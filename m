Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3409815FF6A
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 18:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgBORL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 12:11:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33280 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgBORL0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Feb 2020 12:11:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so6645993pfn.0
        for <linux-rdma@vger.kernel.org>; Sat, 15 Feb 2020 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3P023nkDEPy/hptMWDMq6GVTAmaCb6i+0zWaJLjbppc=;
        b=OhDYPLx/+9b1KfPreoWHFPqT4Gx9frDW8xHxooe22x7bHV1jDaT0UPUGiZ2m3VJSv1
         19NeKVCIf9wAkkPL86UmZVkCHOg8A8O48gbGnIyr/H3rYQZcmit4jgZlx1soluVwSIIa
         PxOhQCs4hJwdREMDphREKM2tsaKRnL5dLBScI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3P023nkDEPy/hptMWDMq6GVTAmaCb6i+0zWaJLjbppc=;
        b=SDu0HMw/e2RahfnKGfQ2d+L9XeI1O/z/lb3WZtTjEhcVtiKBAfHtXcUiu7AhhDWjWO
         IZ5eoCcdNLxpbY4K7OVNu2FBWFO0Pd6vyKO7NCw+UOKQGAwCVzJ3VsxZWnf7kdG4BMmL
         SQtFREYZGShMac3+PkHKMPNUa+igLgf9P6OMggF2807+CGVxNVqI9JlbeiI808n0yB8m
         obvAZrp/WOetBvM2PYOAztjVL4QKCc7cA0Xuoj5FHHpPajS0+H0Ie5dthyLnzPAaffIf
         DSy+D9F/JayoHkaNaYjwXa1SDe6XPlajqZTjpljYA5t+ldeB8wW6dNwyZ+qtn5uJZxBS
         41+Q==
X-Gm-Message-State: APjAAAUUqnL1R2L7VmnXOzxAylDeKh9tqg/0G84+daHSvgFUG/JodJiT
        zV4Ps5OgIuGFQpW07fn0ukYHPwfCElED+KSam4jVyRvh49GdQQi/dKM12oY9kHBkAuGuI2MMVHg
        YoBKscM9U9i03jTMIho5VYEEcREb2ProtUyA+78teGYk/UM8j41zWWedjwGf8daD7tOYv/OOop7
        Mf1Bo=
X-Google-Smtp-Source: APXvYqz1Wg+cP1qHrzfdnSGFIhJaTpYIP47NBpVv/1GPfWXAj0LQLEWayepootPYANrrFXBrHWFo/w==
X-Received: by 2002:a62:e111:: with SMTP id q17mr8813880pfh.242.1581786684683;
        Sat, 15 Feb 2020 09:11:24 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r198sm11755664pfr.54.2020.02.15.09.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2020 09:11:24 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH V3 for-next 2/8] RDMA/bnxt_re: Replace chip context structure with pointer
Date:   Sat, 15 Feb 2020 12:10:59 -0500
Message-Id: <1581786665-23705-3-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
References: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The chip_ctx member in bnxt_re_dev structure is now a pointer
to struct bnxt_qplib_chip_ctx. Since the member type has changed
there are changes in rest of the code wherever dev->chip_ctx is
used.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 13 ++++++-----
 drivers/infiniband/hw/bnxt_re/main.c     | 40 +++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  2 +-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c2805384..86274f4 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -133,7 +133,7 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
 	struct net_device		*netdev;
 	unsigned int			version, major, minor;
-	struct bnxt_qplib_chip_ctx	chip_ctx;
+	struct bnxt_qplib_chip_ctx	*chip_ctx;
 	struct bnxt_en_dev		*en_dev;
 	struct bnxt_msix_entry		msix_entries[BNXT_RE_MAX_MSIX];
 	int				num_msix;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f1a83f4..38b9564 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -859,7 +859,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * BNXT_QPLIB_MAX_SQE_ENTRY_SIZE);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
+		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
 					sizeof(struct sq_psn_search_ext) :
 					sizeof(struct sq_psn_search);
 		bytes += (qplib_qp->sq.max_wqe * psn_sz);
@@ -1060,6 +1060,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 	qplqp->rq.max_sge = dev_attr->max_qp_sges;
 	if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
+	qplqp->rq.max_sge = 6;
 }
 
 static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
@@ -1123,7 +1124,7 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	int qptype;
 
-	chip_ctx = &rdev->chip_ctx;
+	chip_ctx = rdev->chip_ctx;
 
 	qptype = __from_ib_qp_type(init_attr->qp_type);
 	if (qptype == IB_QPT_MAX) {
@@ -1343,7 +1344,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 		goto fail;
 
 	if (qp_init_attr->qp_type == IB_QPT_GSI &&
-	    !(bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))) {
+	    !(bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))) {
 		rc = bnxt_re_create_gsi_qp(qp, pd, qp_init_attr);
 		if (rc == -ENODEV)
 			goto qp_destroy;
@@ -3819,10 +3820,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	spin_lock_init(&uctx->sh_lock);
 
 	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
-	chip_met_rev_num = rdev->chip_ctx.chip_num;
-	chip_met_rev_num |= ((u32)rdev->chip_ctx.chip_rev & 0xFF) <<
+	chip_met_rev_num = rdev->chip_ctx->chip_num;
+	chip_met_rev_num |= ((u32)rdev->chip_ctx->chip_rev & 0xFF) <<
 			     BNXT_RE_CHIP_ID0_CHIP_REV_SFT;
-	chip_met_rev_num |= ((u32)rdev->chip_ctx.chip_metal & 0xFF) <<
+	chip_met_rev_num |= ((u32)rdev->chip_ctx->chip_metal & 0xFF) <<
 			     BNXT_RE_CHIP_ID0_CHIP_MET_SFT;
 	resp.chip_id0 = chip_met_rev_num;
 	/* Future extension of chip info */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 82a5350..390daeb 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -82,22 +82,35 @@
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_chip_ctx *chip_ctx;
+
+	if (!rdev->chip_ctx)
+		return;
+	chip_ctx = rdev->chip_ctx;
+	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
 	rdev->qplib_res.cctx = NULL;
+	kfree(chip_ctx);
 }
 
 static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
 	struct bnxt *bp;
 
 	en_dev = rdev->en_dev;
 	bp = netdev_priv(en_dev->net);
 
-	rdev->chip_ctx.chip_num = bp->chip_num;
+	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
+	if (!chip_ctx)
+		return -ENOMEM;
+	chip_ctx->chip_num = bp->chip_num;
+
+	rdev->chip_ctx = chip_ctx;
 	/* rest members to follow eventually */
 
-	rdev->qplib_res.cctx = &rdev->chip_ctx;
+	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
 
 	return 0;
@@ -136,7 +149,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	ctx->srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
 				attr->max_srq);
 	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
-	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))
+	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_count[i] =
 			rdev->dev_attr.tqm_alloc_reqs[i];
@@ -185,7 +198,7 @@ static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
 	memset(&rdev->qplib_ctx.vf_res, 0, sizeof(struct bnxt_qplib_vf_res));
 	bnxt_re_limit_pf_res(rdev);
 
-	num_vfs =  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
+	num_vfs =  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
 			BNXT_RE_GEN_P5_MAX_VF : rdev->num_vfs;
 	if (num_vfs)
 		bnxt_re_limit_vf_res(&rdev->qplib_ctx, num_vfs);
@@ -208,7 +221,7 @@ static void bnxt_re_sriov_config(void *p, int num_vfs)
 		return;
 
 	rdev->num_vfs = num_vfs;
-	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
 		bnxt_re_set_resource_limits(rdev);
 		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
 					      &rdev->qplib_ctx);
@@ -916,7 +929,7 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 #define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
 static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
 {
-	return bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
+	return bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
 		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
 				   BNXT_RE_GEN_P5_PF_NQ_DB) :
 				   rdev->msix_entries[indx].db_offset;
@@ -967,7 +980,7 @@ static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
 	int i;
 
 	for (i = 0; i < rdev->num_msix - 1; i++) {
-		type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
 		rdev->nq[i].res = NULL;
 		bnxt_qplib_free_nq(&rdev->nq[i]);
@@ -1025,7 +1038,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 				i, rc);
 			goto free_nq;
 		}
-		type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		pg_map = rdev->nq[i].hwq.pbl[PBL_LVL_0].pg_map_arr;
 		pages = rdev->nq[i].hwq.pbl[rdev->nq[i].hwq.level].pg_count;
 		rc = bnxt_re_net_ring_alloc(rdev, pg_map, pages, type,
@@ -1044,7 +1057,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	return 0;
 free_nq:
 	for (i = num_vec_created; i >= 0; i--) {
-		type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
 		bnxt_qplib_free_nq(&rdev->nq[i]);
 	}
@@ -1324,7 +1337,7 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
 		bnxt_qplib_free_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
-		type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
@@ -1405,7 +1418,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 		pr_err("Failed to allocate RCFW Channel: %#x\n", rc);
 		goto fail;
 	}
-	type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+
+	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 	pg_map = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
 	pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
 	ridx = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
@@ -1434,7 +1448,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx, 0,
-				  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx));
+				  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx));
 	if (rc) {
 		pr_err("Failed to allocate QPLIB context: %#x\n", rc);
 		goto disable_rcfw;
@@ -1504,7 +1518,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 disable_rcfw:
 	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
-	type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 	bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
 free_rcfw:
 	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 020f70e..ffe8610 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2426,7 +2426,7 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 	}
 	cqe = *pcqe;
 	cqe->opcode = hwcqe->cqe_type_toggle & CQ_BASE_CQE_TYPE_MASK;
-	cqe->length = (u32)le16_to_cpu(hwcqe->length);
+	cqe->length = le16_to_cpu(hwcqe->length) & CQ_RES_UD_LENGTH_MASK;
 	cqe->cfa_meta = le16_to_cpu(hwcqe->cfa_metadata);
 	cqe->invrkey = le32_to_cpu(hwcqe->imm_data);
 	cqe->flags = le16_to_cpu(hwcqe->flags);
-- 
1.8.3.1

