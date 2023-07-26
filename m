Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230B7639F1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjGZPD0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjGZPDT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:03:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD89212D
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-557790487feso4846689a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690383788; x=1690988588;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BVCI2aFGtarRpz6nL4oKqlRo7YDfc1QEHLpk68LjZ0=;
        b=ZVVbIX3YW6BQ+CcaaY46pg3UlOo/jUQhXAziffBczR3o+MiKlqX9kP+RviH3A7yMUD
         ojictR8JDYhICUuTBq7lrRxVpPArS1cM50pwxuOBpo19OCYKDv60YEd0b+vACruxJgg3
         0JuczSQ+TnBlIVWrfgUGFBFiWH00g5J2qZu0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383788; x=1690988588;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BVCI2aFGtarRpz6nL4oKqlRo7YDfc1QEHLpk68LjZ0=;
        b=c/nIDY6rNRakASSvUtPw3le5GNduZ1D1O9mLGKwkSvIce7WEyV4xLQ/5S355VARmo1
         9NCN7F4xNk2bZQEIAwWDzjVxRT07VETHhHNLBlCfLnHOQsG5tgqcH6i5ER7MyuT9JpKX
         m8XohUPAabxnfcX5D+4skaDap6GEo58vrLdh/IRX+yOiUVdr386hjqQzP8U1aXYfW3qp
         MqFrF4O0HlLanCIVbEldnVmatYmmoGMJfdKfGNizyo/U3XJa+k1ILAEUGaR05c+IBh+l
         IwzdOp6zyuqBFPxobM7cd8nw9lhBHhDmcLh4sWLwlGmJETFqgW3LjjAe1zpPzX7tCgtM
         2efA==
X-Gm-Message-State: ABy/qLYyGjQdma96Sh40tHZL1mth98YjRxy+a5MHqUI0a1Dba4cV+B7y
        Kd/k5FE8KdLV/6tgU98ARCihjw==
X-Google-Smtp-Source: APBJJlHS+fBLMMQYn/kREdEJ3qK42yOazMoRmwAmM8RTDcTrOvYuHQtXRT/8JFB3pjhlrjeVdkuSAw==
X-Received: by 2002:a17:90a:2cc6:b0:268:29a3:49d3 with SMTP id n64-20020a17090a2cc600b0026829a349d3mr2032271pjd.18.1690383787745;
        Wed, 26 Jul 2023 08:03:07 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b0055fd10306a2sm12772846pgo.75.2023.07.26.08.03.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:03:07 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/4] bnxt_re: Update the hw counters for resource stats
Date:   Wed, 26 Jul 2023 07:51:19 -0700
Message-Id: <1690383081-15033-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003be7550601652550"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000003be7550601652550

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Report the additional resource counters which enables
better debugging. Includes active RC/UD QPs,
Watermark of the resources and a count that indicates the
resize cq operations after driver load.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 24 +++++++++++++
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 24 +++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 55 ++++++++++++++++++++++++-----
 3 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 8310e9a..8598af5 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -61,10 +61,22 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_ACTIVE_PD].name		=  "active_pds",
 	[BNXT_RE_ACTIVE_AH].name		=  "active_ahs",
 	[BNXT_RE_ACTIVE_QP].name		=  "active_qps",
+	[BNXT_RE_ACTIVE_RC_QP].name             =  "active_rc_qps",
+	[BNXT_RE_ACTIVE_UD_QP].name             =  "active_ud_qps",
 	[BNXT_RE_ACTIVE_SRQ].name		=  "active_srqs",
 	[BNXT_RE_ACTIVE_CQ].name		=  "active_cqs",
 	[BNXT_RE_ACTIVE_MR].name		=  "active_mrs",
 	[BNXT_RE_ACTIVE_MW].name		=  "active_mws",
+	[BNXT_RE_WATERMARK_PD].name             =  "watermark_pds",
+	[BNXT_RE_WATERMARK_AH].name             =  "watermark_ahs",
+	[BNXT_RE_WATERMARK_QP].name             =  "watermark_qps",
+	[BNXT_RE_WATERMARK_RC_QP].name          =  "watermark_rc_qps",
+	[BNXT_RE_WATERMARK_UD_QP].name          =  "watermark_ud_qps",
+	[BNXT_RE_WATERMARK_SRQ].name            =  "watermark_srqs",
+	[BNXT_RE_WATERMARK_CQ].name             =  "watermark_cqs",
+	[BNXT_RE_WATERMARK_MR].name             =  "watermark_mrs",
+	[BNXT_RE_WATERMARK_MW].name             =  "watermark_mws",
+	[BNXT_RE_RESIZE_CQ_CNT].name            =  "resize_cq_cnt",
 	[BNXT_RE_RX_PKTS].name		=  "rx_pkts",
 	[BNXT_RE_RX_BYTES].name		=  "rx_bytes",
 	[BNXT_RE_TX_PKTS].name		=  "tx_pkts",
@@ -264,12 +276,24 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 		return -EINVAL;
 
 	stats->value[BNXT_RE_ACTIVE_QP] = atomic_read(&res_s->qp_count);
+	stats->value[BNXT_RE_ACTIVE_RC_QP] = atomic_read(&res_s->rc_qp_count);
+	stats->value[BNXT_RE_ACTIVE_UD_QP] = atomic_read(&res_s->ud_qp_count);
 	stats->value[BNXT_RE_ACTIVE_SRQ] = atomic_read(&res_s->srq_count);
 	stats->value[BNXT_RE_ACTIVE_CQ] = atomic_read(&res_s->cq_count);
 	stats->value[BNXT_RE_ACTIVE_MR] = atomic_read(&res_s->mr_count);
 	stats->value[BNXT_RE_ACTIVE_MW] = atomic_read(&res_s->mw_count);
 	stats->value[BNXT_RE_ACTIVE_PD] = atomic_read(&res_s->pd_count);
 	stats->value[BNXT_RE_ACTIVE_AH] = atomic_read(&res_s->ah_count);
+	stats->value[BNXT_RE_WATERMARK_QP] = res_s->qp_watermark;
+	stats->value[BNXT_RE_WATERMARK_RC_QP] = res_s->rc_qp_watermark;
+	stats->value[BNXT_RE_WATERMARK_UD_QP] = res_s->ud_qp_watermark;
+	stats->value[BNXT_RE_WATERMARK_SRQ] = res_s->srq_watermark;
+	stats->value[BNXT_RE_WATERMARK_CQ] = res_s->cq_watermark;
+	stats->value[BNXT_RE_WATERMARK_MR] = res_s->mr_watermark;
+	stats->value[BNXT_RE_WATERMARK_MW] = res_s->mw_watermark;
+	stats->value[BNXT_RE_WATERMARK_PD] = res_s->pd_watermark;
+	stats->value[BNXT_RE_WATERMARK_AH] = res_s->ah_watermark;
+	stats->value[BNXT_RE_RESIZE_CQ_CNT] = atomic_read(&res_s->resize_count);
 
 	if (hw_stats) {
 		stats->value[BNXT_RE_RECOVERABLE_ERRORS] =
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index 4aa6e31..7231a2b 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -44,10 +44,22 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_ACTIVE_PD,
 	BNXT_RE_ACTIVE_AH,
 	BNXT_RE_ACTIVE_QP,
+	BNXT_RE_ACTIVE_RC_QP,
+	BNXT_RE_ACTIVE_UD_QP,
 	BNXT_RE_ACTIVE_SRQ,
 	BNXT_RE_ACTIVE_CQ,
 	BNXT_RE_ACTIVE_MR,
 	BNXT_RE_ACTIVE_MW,
+	BNXT_RE_WATERMARK_PD,
+	BNXT_RE_WATERMARK_AH,
+	BNXT_RE_WATERMARK_QP,
+	BNXT_RE_WATERMARK_RC_QP,
+	BNXT_RE_WATERMARK_UD_QP,
+	BNXT_RE_WATERMARK_SRQ,
+	BNXT_RE_WATERMARK_CQ,
+	BNXT_RE_WATERMARK_MR,
+	BNXT_RE_WATERMARK_MW,
+	BNXT_RE_RESIZE_CQ_CNT,
 	BNXT_RE_RX_PKTS,
 	BNXT_RE_RX_BYTES,
 	BNXT_RE_TX_PKTS,
@@ -115,12 +127,24 @@ enum bnxt_re_hw_stats {
 
 struct bnxt_re_res_cntrs {
 	atomic_t qp_count;
+	atomic_t rc_qp_count;
+	atomic_t ud_qp_count;
 	atomic_t cq_count;
 	atomic_t srq_count;
 	atomic_t mr_count;
 	atomic_t mw_count;
 	atomic_t ah_count;
 	atomic_t pd_count;
+	atomic_t resize_count;
+	u64 qp_watermark;
+	u64 rc_qp_watermark;
+	u64 ud_qp_watermark;
+	u64 cq_watermark;
+	u64 srq_watermark;
+	u64 mr_watermark;
+	u64 mw_watermark;
+	u64 ah_watermark;
+	u64 pd_watermark;
 };
 
 struct bnxt_re_rstat {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b28c869..2b2505a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -615,6 +615,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_pd *pd = container_of(ibpd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_user_mmap_entry *entry = NULL;
+	u32 active_pds;
 	int rc = 0;
 
 	pd->rdev = rdev;
@@ -665,7 +666,9 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		if (bnxt_re_create_fence_mr(pd))
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to create Fence-MR\n");
-	atomic_inc(&rdev->stats.res.pd_count);
+	active_pds = atomic_inc_return(&rdev->stats.res.pd_count);
+	if (active_pds > rdev->stats.res.pd_watermark)
+		rdev->stats.res.pd_watermark = active_pds;
 
 	return 0;
 dbfail:
@@ -725,6 +728,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	const struct ib_gid_attr *sgid_attr;
 	struct bnxt_re_gid_ctx *ctx;
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
+	u32 active_ahs;
 	u8 nw_type;
 	int rc;
 
@@ -777,7 +781,9 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 		wmb(); /* make sure cache is updated. */
 		spin_unlock_irqrestore(&uctx->sh_lock, flag);
 	}
-	atomic_inc(&rdev->stats.res.ah_count);
+	active_ahs = atomic_inc_return(&rdev->stats.res.ah_count);
+	if (active_ahs > rdev->stats.res.ah_watermark)
+		rdev->stats.res.ah_watermark = active_ahs;
 
 	return 0;
 }
@@ -1487,6 +1493,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	u32 active_qps;
 	int rc;
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1535,7 +1542,18 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	mutex_lock(&rdev->qp_lock);
 	list_add_tail(&qp->list, &rdev->qp_list);
 	mutex_unlock(&rdev->qp_lock);
-	atomic_inc(&rdev->stats.res.qp_count);
+	active_qps = atomic_inc_return(&rdev->stats.res.qp_count);
+	if (active_qps > rdev->stats.res.qp_watermark)
+		rdev->stats.res.qp_watermark = active_qps;
+	if (qp_init_attr->qp_type == IB_QPT_RC) {
+		active_qps = atomic_inc_return(&rdev->stats.res.rc_qp_count);
+		if (active_qps > rdev->stats.res.rc_qp_watermark)
+			rdev->stats.res.rc_qp_watermark = active_qps;
+	} else if (qp_init_attr->qp_type == IB_QPT_UD) {
+		active_qps = atomic_inc_return(&rdev->stats.res.ud_qp_count);
+		if (active_qps > rdev->stats.res.ud_qp_watermark)
+			rdev->stats.res.ud_qp_watermark = active_qps;
+	}
 
 	return 0;
 qp_destroy:
@@ -1686,6 +1704,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	struct bnxt_re_srq *srq;
 	struct bnxt_re_pd *pd;
 	struct ib_pd *ib_pd;
+	u32 active_srqs;
 	int rc, entries;
 
 	ib_pd = ib_srq->pd;
@@ -1750,7 +1769,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	}
 	if (nq)
 		nq->budget++;
-	atomic_inc(&rdev->stats.res.srq_count);
+	active_srqs = atomic_inc_return(&rdev->stats.res.srq_count);
+	if (active_srqs > rdev->stats.res.srq_watermark)
+		rdev->stats.res.srq_watermark = active_srqs;
 	spin_lock_init(&srq->lock);
 
 	return 0;
@@ -2892,6 +2913,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int cqe = attr->cqe;
 	struct bnxt_qplib_nq *nq = NULL;
 	unsigned int nq_alloc_cnt;
+	u32 active_cqs;
 
 	if (attr->flags)
 		return -EOPNOTSUPP;
@@ -2960,7 +2982,9 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->cq_period = cq->qplib_cq.period;
 	nq->budget++;
 
-	atomic_inc(&rdev->stats.res.cq_count);
+	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
+	if (active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = active_cqs;
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
@@ -3073,6 +3097,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	}
 
 	cq->ib_cq.cqe = cq->resize_cqe;
+	atomic_inc(&rdev->stats.res.resize_count);
 
 	return 0;
 
@@ -3758,6 +3783,7 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_re_mr *mr;
+	u32 active_mrs;
 	int rc;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
@@ -3785,7 +3811,9 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	if (mr_access_flags & (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |
 			       IB_ACCESS_REMOTE_ATOMIC))
 		mr->ib_mr.rkey = mr->ib_mr.lkey;
-	atomic_inc(&rdev->stats.res.mr_count);
+	active_mrs = atomic_inc_return(&rdev->stats.res.mr_count);
+	if (active_mrs > rdev->stats.res.mr_watermark)
+		rdev->stats.res.mr_watermark = active_mrs;
 
 	return &mr->ib_mr;
 
@@ -3848,6 +3876,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_re_mr *mr = NULL;
+	u32 active_mrs;
 	int rc;
 
 	if (type != IB_MR_TYPE_MEM_REG) {
@@ -3886,7 +3915,9 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 		goto fail_mr;
 	}
 
-	atomic_inc(&rdev->stats.res.mr_count);
+	active_mrs = atomic_inc_return(&rdev->stats.res.mr_count);
+	if (active_mrs > rdev->stats.res.mr_watermark)
+		rdev->stats.res.mr_watermark = active_mrs;
 	return &mr->ib_mr;
 
 fail_mr:
@@ -3904,6 +3935,7 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct bnxt_re_mw *mw;
+	u32 active_mws;
 	int rc;
 
 	mw = kzalloc(sizeof(*mw), GFP_KERNEL);
@@ -3922,7 +3954,9 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	}
 	mw->ib_mw.rkey = mw->qplib_mw.rkey;
 
-	atomic_inc(&rdev->stats.res.mw_count);
+	active_mws = atomic_inc_return(&rdev->stats.res.mw_count);
+	if (active_mws > rdev->stats.res.mw_watermark)
+		rdev->stats.res.mw_watermark = active_mws;
 	return &mw->ib_mw;
 
 fail:
@@ -3958,6 +3992,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct ib_umem *umem;
 	unsigned long page_size;
 	int umem_pgs, rc;
+	u32 active_mrs;
 
 	if (length > BNXT_RE_MAX_MR_SIZE) {
 		ibdev_err(&rdev->ibdev, "MR Size: %lld > Max supported:%lld\n",
@@ -4010,7 +4045,9 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
 	mr->ib_mr.rkey = mr->qplib_mr.lkey;
-	atomic_inc(&rdev->stats.res.mr_count);
+	active_mrs = atomic_inc_return(&rdev->stats.res.mr_count);
+	if (active_mrs > rdev->stats.res.mr_watermark)
+		rdev->stats.res.mr_watermark = active_mrs;
 
 	return &mr->ib_mr;
 free_umem:
-- 
2.5.5


--0000000000003be7550601652550
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINUy4GTAzb3t
4PpIcFGi6F5SYP5vnxkcOYLbI+7ua75oMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNjE1MDMwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDgaV1iQYby1YLblepUWoPK6egUwJb0
7Z1FBUyxWZvDUANzwYUvlZ3qy/lKaznxsDrX4dug9zA7yZOHoYdVoOyoGJwMiOwX67NN4/GBOuLp
48ALvjyVvT8/C5ntDR0KnKb+u/W/YspBACVD1us6HnRNjQLcRC6/eG4t+rPCrURsvJVHst9ylY+h
KQeHia4M/BPBxsIB9/xP2k/VnZhVYxy1FE7+CYJDggcsjIMrDVUIfA/ok7BmP4Qf/B22feQQrg9+
ZNBfK3Vae3+YtamdkzOXlyX48eRLncGBQ0iILHa3s1RWAVo0lkkoqYwwN8ysj+WcPC9/t7wQAHWK
u4N402FP
--0000000000003be7550601652550--
