/**
 * WorkDesk — Payroll Cron Worker
 *
 * Cloudflare Worker with a scheduled Cron Trigger that automatically
 * queues a payroll run at the start of each pay period.
 *
 * Schedule (configure in wrangler.toml):
 *   0 0 1 * *  — fires at 00:00 UTC on the 1st of every month
 *
 * What it does:
 *   1. Determines the current pay period (e.g. "2025-06").
 *   2. Publishes a `payroll.run` message to workdesk-queue.
 *   3. The queue consumer (workers/queues/job-consumer.js) picks up the
 *      message and executes the full payroll calculation against D1.
 *
 * Bindings required (configure in wrangler.toml before deploying):
 *   env.WORKDESK_QUEUE — Cloudflare Queue producer binding
 *
 * Deploy:
 *   cd workers/cron && wrangler deploy
 */

export default {
  /**
   * scheduled — Cron Trigger handler
   *
   * @param {ScheduledEvent} event
   * @param {object}         env
   * @param {ExecutionContext} ctx
   */
  async scheduled(event, env, ctx) {
    const now    = new Date(event.scheduledTime);
    const period = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0');

    console.info('[cron/payroll] triggered for period:', period);

    if (!env.WORKDESK_QUEUE) {
      console.warn('[cron/payroll] WORKDESK_QUEUE binding not configured — skipping enqueue.');
      return;
    }

    await env.WORKDESK_QUEUE.send({
      event:     'payroll.run',
      period,
      count:     0,
      token:     'cron',
      queued_at: now.toISOString(),
    });

    console.info('[cron/payroll] payroll.run enqueued for period:', period);
  },
};
