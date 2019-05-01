Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70151097F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfEAOpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 10:45:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40131 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727069AbfEAOo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 10:44:59 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 May 2019 17:44:53 +0300
Received: from gen-l-vrt-692.mtl.labs.mlnx (gen-l-vrt-692.mtl.labs.mlnx [10.141.69.20])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x41Eirqf019853;
        Wed, 1 May 2019 17:44:53 +0300
Received: from gen-l-vrt-692.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-692.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x41Eirwt036052;
        Wed, 1 May 2019 17:44:53 +0300
Received: (from talgi@localhost)
        by gen-l-vrt-692.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x41Eir40036051;
        Wed, 1 May 2019 17:44:53 +0300
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH rdma-for-next 7/9] linux/dim: Add completions count to dim_sample
Date:   Wed,  1 May 2019 17:44:37 +0300
Message-Id: <1556721879-35987-8-git-send-email-talgi@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
References: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Added a measurement of completions per/msec to allow for completion based
dim algorithms.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c        |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c |  6 ++++--
 include/linux/dim.h                               |  8 +++++++-
 lib/dim/dim.c                                     | 13 ++++++++++++-
 lib/dim/net_dim.c                                 |  2 +-
 7 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b2c5b1a..fc21432 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1029,7 +1029,7 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 
 	if (priv->dim.use_dim) {
 		dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
-				  priv->dim.bytes, &dim_sample);
+				  priv->dim.bytes, 0, &dim_sample);
 		net_dim(&priv->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9e62e3f..91607ef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2130,6 +2130,7 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 		dim_create_sample(cpr->event_ctr,
 				  cpr->rx_packets,
 				  cpr->rx_bytes,
+				  0,
 				  &dim_sample);
 		net_dim(&cpr->dim, dim_sample);
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 68d96e3..aca82ef 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1910,7 +1910,7 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 	if (ring->dim.use_dim) {
 		dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
-				  ring->dim.bytes, &dim_sample);
+				  ring->dim.bytes, 0, &dim_sample);
 		net_dim(&ring->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 4324747..ab68d7d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -53,7 +53,8 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_AM, &sq->state)))
 		return;
 
-	dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, 0,
+			  &dim_sample);
 	net_dim(&sq->dim, dim_sample);
 }
 
@@ -65,7 +66,8 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_AM, &rq->state)))
 		return;
 
-	dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, 0,
+			  &dim_sample);
 	net_dim(&rq->dim, dim_sample);
 }
 
diff --git a/include/linux/dim.h b/include/linux/dim.h
index ffaea87..2bc4c40 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -44,6 +44,7 @@
 struct dim_cq_moder {
 	u16 usec;
 	u16 pkts;
+	u16 comps;
 	u8 cq_period_mode;
 };
 
@@ -52,18 +53,22 @@ struct dim_sample {
 	u32     pkt_ctr;
 	u32     byte_ctr;
 	u16     event_ctr;
+	u32     comp_ctr;
 };
 
 struct dim_stats {
 	int ppms; /* packets per msec */
 	int bpms; /* bytes per msec */
 	int epms; /* events per msec */
+	int cpms; /* completions per msec */
+	int cpe_ratio; /* ratio of completions to events */
 };
 
 struct dim { /* Dynamic Interrupt Moderation */
 	u8                                      state;
 	struct dim_stats                        prev_stats;
 	struct dim_sample                       start_sample;
+	struct dim_sample                       measuring_sample;
 	struct work_struct                      work;
 	u8                                      profile_ix;
 	u8                                      mode;
@@ -112,7 +117,8 @@ enum {
 
 void dim_park_tired(struct dim *dim);
 
-void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s);
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, u64 comps,
+		       struct dim_sample *s);
 
 void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats);
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 93e1ddd..4f25c0f 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -54,12 +54,14 @@ void dim_park_tired(struct dim *dim)
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s)
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, u64 comps,
+		       struct dim_sample *s)
 {
 	s->time	     = ktime_get();
 	s->pkt_ctr   = packets;
 	s->byte_ctr  = bytes;
 	s->event_ctr = event_ctr;
+	s->comp_ctr  = comps;
 }
 EXPORT_SYMBOL(dim_create_sample);
 
@@ -71,6 +73,8 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
 	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
 			     start->byte_ctr);
+	u32 ncomps = BIT_GAP(BITS_PER_TYPE(u32), end->comp_ctr,
+			     start->comp_ctr);
 
 	if (!delta_us)
 		return;
@@ -79,5 +83,12 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
 	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
 					delta_us);
+	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
+	if (curr_stats->epms != 0)
+		curr_stats->cpe_ratio =
+				(curr_stats->cpms * 100) / curr_stats->epms;
+	else
+		curr_stats->cpe_ratio = 0;
+
 }
 EXPORT_SYMBOL(dim_calc_stats);
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 05d259e..67a8f82 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -181,7 +181,7 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
 		/* fall through */
 	case DIM_START_MEASURE:
 		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
-				  end_sample.byte_ctr, &dim->start_sample);
+				  end_sample.byte_ctr, 0, &dim->start_sample);
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
 	case DIM_APPLY_NEW_PROFILE:
-- 
1.8.3.1

