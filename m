Return-Path: <linux-rdma+bounces-22733-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3bhoJNESR2rrSwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22733-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 03:39:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20CF6FDBE6
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 03:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=uxu3CLJ2;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22733-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22733-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD7F303C3D0
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D2220687;
	Fri,  3 Jul 2026 01:37:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE023393B
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 01:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042647; cv=none; b=JIqQiVciNLj3wH1/OuGHfYbbOnKdkupxPsIynDcTptnHhj1+HqoXN1m9xE182/iiEQV+843NUIo6KfJQfjf6GOD21QfRWodBJGD+WlQMYQMXCpzR5CSWkU30ef7gjZg1LvQQm7/A5urmgtyU3RpVkVXGEolPFZd5n90Qka+vIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042647; c=relaxed/simple;
	bh=WeH+YO2mQ7IxKBuWmV4yRJoOYTxOKU9PFNXB1QiItM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CWIBqQfANWFNJEVJPnR76iBpVQGXQtwrcechGnPnE6eYfqVMWp+LhGu/Y36IdTbv9lhvSCKN+hOk0k2YMet7cNIRixjGAZXitOm4aKcbIrM7XBTRBO/LmLqcgiImuv0pw3wqeIup8WxFEGWtX+bAQNZC7Ndh654mVmcWpH6Z72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uxu3CLJ2; arc=none smtp.client-ip=95.215.58.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783042633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MhHDmWgxp2xGYpIVrshekJcBSv50KMn7I0I5p0NdbQs=;
	b=uxu3CLJ2ZQ2Pf0LXWMefdSb1s4XBFnoQmbwmfYGhTpKcOyBQmbFNX32CYOmoQwsEwiF+vT
	u01SklrxVJvF363ZdwgRscEZD1y8a+3/VtvNS+j16UNMhcomAsa8k9StCwtAC9Aj9/P7IK
	L3cm7JlouW0PjijDyxPRBDLa+w85KCw=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Fri, 03 Jul 2026 01:36:40 +0000
Subject: [PATCH net-next] net/mlx5e: bound TX CQ poll softirq residency
 with a time budget
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mlx5e-tx-cq-time-budget-v1-1-6da2cfe9c7b1@linux.dev>
X-B4-Tracking: v=1; b=H4sIACcSR2oC/yWMwQ7CIBBEf6XZsxsRrU38FeMBlm27xqICbUia/
 rtQjzPz5q0QOQhHuDUrBF4kytuXcDo0QKPxA6O4kkErfVWd0ji9csuYMtIXk0yMdnYDJ1SaiPp
 zZ/v2AuX9CdxL3s138AXwnBM8/kuc7ZMpVXFlrYnFE4ynsVaFdrzsh+NkxMO2/QBaF6NqqAAAA
 A==
X-Change-ID: 20260702-mlx5e-tx-cq-time-budget-02cccf37bf54
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, 
 Ben Cressey <ben@cressey.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22733-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jose.fernandez@linux.dev,m:ben@cressey.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jose.fernandez@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jose.fernandez@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cressey.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D20CF6FDBE6

Under strict IOMMU invalidation (iommu.strict=1), each per-fragment DMA
unmap in the TX completion path issues a synchronous TLB invalidate and
waits for CMD_SYNC, spinning IRQ-off in the SMMU command queue. Under
cross-CPU command-queue contention this per-unmap cost inflates from
microseconds to hundreds of microseconds. mlx5e_poll_tx_cq()'s per-CQE
budget (128) does not bound time in this regime: one CQE can cover a
multi-WQE batch with many fragments, so a single poll invocation can
accumulate seconds of softirq residency and trip the soft-lockup
watchdog on arm64/SMMU-v3 systems.

Bound the invocation by time: check local_clock() every 8 CQEs against
a budget (default 500us; module parameter tx_cq_time_budget_us,
runtime-writable, 0 disables) and break out of the CQE loop when
exceeded, reporting busy exactly like the existing CQE-budget
exhaustion path so NAPI keeps the poll scheduled. Remaining
completions are delayed by one reschedule, never stranded. The inner
WQE walk is never interrupted mid-CQE (sqcc/dma_fifo_cc accounting).
A new ethtool statistic (tx_time_budget_exit) counts early exits.

Also add cond_resched() in mlx5e_free_txqsq_descs(): the teardown path
walks the same per-fragment unmaps in process context.

Tested on arm64 with SMMU-v3 under strict mode: throughput cost is
within run-to-run variance at every measured load shape; under active
invalidation-storm contention, the bounded poll measures 35-50%
faster than unbounded (bounded polling yields cores back to the
transmit path).

Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Reviewed-by: Ben Cressey <ben@cressey.dev>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  5 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    | 29 +++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 7f33261ba655..b940280af19d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -171,6 +171,7 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_queue_wake) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqe_err) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_time_budget_exit) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_xmit) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_mpwqe) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_inlnw) },
@@ -426,6 +427,7 @@ static void mlx5e_stats_grp_sw_update_stats_sq(struct mlx5e_sw_stats *s,
 	s->tx_queue_wake            += sq_stats->wake;
 	s->tx_queue_dropped         += sq_stats->dropped;
 	s->tx_cqe_err               += sq_stats->cqe_err;
+	s->tx_time_budget_exit      += sq_stats->time_budget_exit;
 	s->tx_recover               += sq_stats->recover;
 	s->tx_xmit_more             += sq_stats->xmit_more;
 	s->tx_csum_partial_inner    += sq_stats->csum_partial_inner;
@@ -2323,6 +2325,7 @@ static const struct counter_desc sq_stats_desc[] = {
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, cqes) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, wake) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
 };
 
 static const struct counter_desc rq_xdpsq_stats_desc[] = {
@@ -2399,6 +2402,7 @@ static const struct counter_desc ptp_sq_stats_desc[] = {
 	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, cqes) },
 	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, wake) },
 	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
+	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
 };
 
 static const struct counter_desc ptp_ch_stats_desc[] = {
@@ -2476,6 +2480,7 @@ static const struct counter_desc qos_sq_stats_desc[] = {
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, cqes) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, wake) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
+	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
 };
 
 #define NUM_RQ_STATS			ARRAY_SIZE(rq_stats_desc)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 09f155acb461..5ba954f42ccd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -187,6 +187,7 @@ struct mlx5e_sw_stats {
 	u64 tx_cqes;
 	u64 tx_queue_wake;
 	u64 tx_cqe_err;
+	u64 tx_time_budget_exit;
 	u64 tx_xdp_xmit;
 	u64 tx_xdp_mpwqe;
 	u64 tx_xdp_inlnw;
@@ -445,6 +446,7 @@ struct mlx5e_sq_stats {
 	u64 cqes ____cacheline_aligned_in_smp;
 	u64 wake;
 	u64 cqe_err;
+	u64 time_budget_exit;
 };
 
 struct mlx5e_xdpsq_stats {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 0b5e600e4a6a..994df912b765 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -43,6 +43,13 @@
 #include "en_accel/macsec.h"
 #include "en/ptp.h"
 #include <net/ipv6.h>
+#include <linux/moduleparam.h>
+#include <linux/sched/clock.h>
+
+static unsigned int mlx5e_tx_cq_time_budget_us = 500;
+module_param_named(tx_cq_time_budget_us, mlx5e_tx_cq_time_budget_us, uint, 0644);
+MODULE_PARM_DESC(tx_cq_time_budget_us,
+		 "Max microseconds one TX CQ poll may spend before yielding (0 = unbounded)");
 
 static void mlx5e_dma_unmap_wqe_err(struct mlx5e_txqsq *sq, u8 num_dma)
 {
@@ -760,9 +767,12 @@ void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq)
 bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 {
 	struct mlx5e_sq_stats *stats;
+	bool time_exceeded = false;
+	u64 time_budget_end = 0;
 	struct mlx5e_txqsq *sq;
 	struct mlx5_cqe64 *cqe;
 	u32 dma_fifo_cc;
+	u32 budget_us;
 	u32 nbytes;
 	u16 npkts;
 	u16 sqcc;
@@ -790,6 +800,10 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 	/* avoid dirtying sq cache line every cqe */
 	dma_fifo_cc = sq->dma_fifo_cc;
 
+	budget_us = READ_ONCE(mlx5e_tx_cq_time_budget_us);
+	if (budget_us)
+		time_budget_end = local_clock() + (u64)budget_us * NSEC_PER_USEC;
+
 	i = 0;
 	do {
 		struct mlx5e_tx_wqe_info *wi;
@@ -842,8 +856,19 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 			stats->cqe_err++;
 		}
 
+		/* Check between CQEs only (sqcc/dma_fifo_cc must advance together). */
+		if (unlikely(time_budget_end && (i & 7) == 7 &&
+			     local_clock() >= time_budget_end)) {
+			time_exceeded = true;
+			i++;
+			break;
+		}
+
 	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
+	if (unlikely(time_exceeded))
+		stats->time_budget_exit++;
+
 	stats->cqes += i;
 
 	mlx5_cqwq_update_db_record(&cq->wq);
@@ -858,7 +883,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 
 	mlx5e_txqsq_wake(sq);
 
-	return (i == MLX5E_TX_CQ_POLL_BUDGET);
+	return time_exceeded || (i == MLX5E_TX_CQ_POLL_BUDGET);
 }
 
 static void mlx5e_tx_wi_kfree_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_tx_wqe_info *wi)
@@ -879,6 +904,8 @@ void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
 	dma_fifo_cc = sq->dma_fifo_cc;
 
 	while (sqcc != sq->pc) {
+		cond_resched();
+
 		ci = mlx5_wq_cyc_ctr2ix(&sq->wq, sqcc);
 		wi = &sq->db.wqe_info[ci];
 

---
base-commit: 08bc5b2636afcbadc31bb17243eec094e048bd79
change-id: 20260702-mlx5e-tx-cq-time-budget-02cccf37bf54

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>


