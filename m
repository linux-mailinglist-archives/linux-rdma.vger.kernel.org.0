Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC77D390F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjJWOPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 10:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJWOPY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 10:15:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EB10B
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 07:15:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692c02adeefso2486116b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698070521; x=1698675321; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9e2m35rU/y7/fYEPXHxtwfTT4W03QiF934qIFyMWUs=;
        b=ED4cS6RuxM8qZ/4jsZruvaMQgCmJmlldTfcrckPFtaMI1v3a6akw+479CEYGa9S3l+
         7LbfxiCAMyWc3ycth9Qz+czS02WhC8cDnwQx4JGLn7DdQC+h8LBInPwwuE9VFe4fEblp
         8DKzd6TOEY6wKgZMWHob8b9zcLGz+n6XFvlx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698070521; x=1698675321;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9e2m35rU/y7/fYEPXHxtwfTT4W03QiF934qIFyMWUs=;
        b=VAdqpchrj4/sZ4SAN2QDzUiUhPt3p3J43xxUncYaOkCdOaDZ+qyAe4mlp6UbcVTwa5
         2z2dRVlLLoD3Pi+PUAAlE/CHeR0dNuS9pl1sF8Sg00r0bss/rfjpmou3MstXu3pLWEPx
         QPoB21hqU++S5ePbk4HeUy1dNvUFN+hObyXnAi5rNaO3b0UEfZvPgMGPgo3CCYdPuCLA
         oyEuxDCepofqI0VOpraboX2KsmcAOoWjU72yWbdy1rBKayczdZwNFdGeEJb+WFp3onli
         lDjcDvt/KvsPO1ycs9L1ixnhJl/KL1SGaiio0Pk5UDg0Z0ZkSf/pCtBSBqfTrH8Ox8YD
         fGRg==
X-Gm-Message-State: AOJu0YwW5ZhMliEnHkBIz4JQ0MlaujHtr+ZWbBl2Juk/eBQj4JJiVCuz
        4UFH1iDr6bRSMEdhSCQXN/23QcVDDElwp1LfqxE=
X-Google-Smtp-Source: AGHT+IHsdtCAt6EqlWtDTI/a9Psolymtbr/o1SryP0S96xOfo/QqWSW6z7J+g877Dq84scXRvjmuTQ==
X-Received: by 2002:a05:6a21:6d99:b0:16b:b0ea:b0a1 with SMTP id wl25-20020a056a216d9900b0016bb0eab0a1mr4934916pzb.34.1698070520469;
        Mon, 23 Oct 2023 07:15:20 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y10-20020a62ce0a000000b0069ea08a2a99sm6404299pfg.211.2023.10.23.07.15.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:15:19 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/2] bnxt_re: Remove roundup_pow_of_two depth for all hardware queue resources
Date:   Mon, 23 Oct 2023 07:03:23 -0700
Message-Id: <1698069803-1787-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
References: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000037d0eb060862da10"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000037d0eb060862da10

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Rounding up the queue depth to power of two is not a hardware requirement.
In order to optmize the per connection memory usage, removing drivers
implementation which round up to the queue depths to the power of 2.

Implements a mask to maintain backward compatibility with older
library.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 57 +++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  7 ++++
 include/uapi/rdma/bnxt_re-abi.h          |  9 +++++
 3 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 0848c2c..4fd268e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1180,7 +1180,8 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 }
 
 static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
-				struct ib_qp_init_attr *init_attr)
+				struct ib_qp_init_attr *init_attr,
+				struct bnxt_re_ucontext *uctx)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1209,7 +1210,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		/* Allocate 1 more than what's provided so posting max doesn't
 		 * mean empty.
 		 */
-		entries = roundup_pow_of_two(init_attr->cap.max_recv_wr + 1);
+		entries = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1, uctx);
 		rq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
 		rq->q_full_delta = 0;
 		rq->sg_info.pgsize = PAGE_SIZE;
@@ -1239,7 +1240,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
-				struct ib_udata *udata)
+				struct bnxt_re_ucontext *uctx)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1268,7 +1269,7 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	/* Allocate 128 + 1 more than what's provided */
 	diff = (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE) ?
 		0 : BNXT_QPLIB_RESERVED_QP_WRS;
-	entries = roundup_pow_of_two(entries + diff + 1);
+	entries = bnxt_re_init_depth(entries + diff + 1, uctx);
 	sq->max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + diff + 1);
 	sq->q_full_delta = diff + 1;
 	/*
@@ -1284,7 +1285,8 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 }
 
 static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
-				       struct ib_qp_init_attr *init_attr)
+				       struct ib_qp_init_attr *init_attr,
+				       struct bnxt_re_ucontext *uctx)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1296,7 +1298,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 	dev_attr = &rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
-		entries = roundup_pow_of_two(init_attr->cap.max_send_wr + 1);
+		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
 		qplqp->sq.max_wqe = min_t(u32, entries,
 					  dev_attr->max_qp_wqes + 1);
 		qplqp->sq.q_full_delta = qplqp->sq.max_wqe -
@@ -1334,6 +1336,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_udata *udata)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_re_ucontext *uctx;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
@@ -1343,6 +1346,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
 	qplqp->pd = &pd->qplib_pd;
@@ -1384,18 +1388,18 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	}
 
 	/* Setup RQ/SRQ */
-	rc = bnxt_re_init_rq_attr(qp, init_attr);
+	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
 	if (rc)
 		goto out;
 	if (init_attr->qp_type == IB_QPT_GSI)
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, udata);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx);
 	if (rc)
 		goto out;
 	if (init_attr->qp_type == IB_QPT_GSI)
-		bnxt_re_adjust_gsi_sq_attr(qp, init_attr);
+		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (udata) /* This will update DPI and qp_handle */
 		rc = bnxt_re_init_user_qp(rdev, pd, qp, udata);
@@ -1711,6 +1715,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_nq *nq = NULL;
+	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_srq *srq;
 	struct bnxt_re_pd *pd;
@@ -1735,13 +1740,14 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		goto exit;
 	}
 
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	srq->rdev = rdev;
 	srq->qplib_srq.pd = &pd->qplib_pd;
 	srq->qplib_srq.dpi = &rdev->dpi_privileged;
 	/* Allocate 1 more than what's provided so posting max doesn't
 	 * mean empty
 	 */
-	entries = roundup_pow_of_two(srq_init_attr->attr.max_wr + 1);
+	entries = bnxt_re_init_depth(srq_init_attr->attr.max_wr + 1, uctx);
 	if (entries > dev_attr->max_srq_wqes + 1)
 		entries = dev_attr->max_srq_wqes + 1;
 	srq->qplib_srq.max_wqe = entries;
@@ -2099,6 +2105,9 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		qp->qplib_qp.max_dest_rd_atomic = qp_attr->max_dest_rd_atomic;
 	}
 	if (qp_attr_mask & IB_QP_CAP) {
+		struct bnxt_re_ucontext *uctx =
+			rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+
 		qp->qplib_qp.modify_flags |=
 				CMDQ_MODIFY_QP_MODIFY_MASK_SQ_SIZE |
 				CMDQ_MODIFY_QP_MODIFY_MASK_RQ_SIZE |
@@ -2115,7 +2124,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 				  "Create QP failed - max exceeded");
 			return -EINVAL;
 		}
-		entries = roundup_pow_of_two(qp_attr->cap.max_send_wr);
+		entries = bnxt_re_init_depth(qp_attr->cap.max_send_wr, uctx);
 		qp->qplib_qp.sq.max_wqe = min_t(u32, entries,
 						dev_attr->max_qp_wqes + 1);
 		qp->qplib_qp.sq.q_full_delta = qp->qplib_qp.sq.max_wqe -
@@ -2128,7 +2137,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		qp->qplib_qp.sq.q_full_delta -= 1;
 		qp->qplib_qp.sq.max_sge = qp_attr->cap.max_send_sge;
 		if (qp->qplib_qp.rq.max_wqe) {
-			entries = roundup_pow_of_two(qp_attr->cap.max_recv_wr);
+			entries = bnxt_re_init_depth(qp_attr->cap.max_recv_wr, uctx);
 			qp->qplib_qp.rq.max_wqe =
 				min_t(u32, entries, dev_attr->max_qp_wqes + 1);
 			qp->qplib_qp.rq.q_full_delta = qp->qplib_qp.rq.max_wqe -
@@ -2916,9 +2925,11 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct ib_udata *udata)
 {
+	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
+	struct bnxt_re_ucontext *uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	int rc, entries;
 	int cqe = attr->cqe;
 	struct bnxt_qplib_nq *nq = NULL;
@@ -2937,7 +2948,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->rdev = rdev;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
-	entries = roundup_pow_of_two(cqe + 1);
+	entries = bnxt_re_init_depth(cqe + 1, uctx);
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
@@ -2945,8 +2956,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
-		struct bnxt_re_ucontext *uctx = rdma_udata_to_drv_context(
-			udata, struct bnxt_re_ucontext, ib_uctx);
 		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
 			rc = -EFAULT;
 			goto fail;
@@ -3068,12 +3077,11 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		return -EINVAL;
 	}
 
-	entries = roundup_pow_of_two(cqe + 1);
+	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	entries = bnxt_re_init_depth(cqe + 1, uctx);
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,
-					 ib_uctx);
 	/* uverbs consumer */
 	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
 		rc = -EFAULT;
@@ -4104,6 +4112,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_uctx_resp resp = {};
+	struct bnxt_re_uctx_req ureq = {};
 	u32 chip_met_rev_num = 0;
 	int rc;
 
@@ -4153,6 +4162,16 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (rdev->pacing.dbr_pacing)
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED;
 
+	if (udata->inlen >= sizeof(ureq)) {
+		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
+		if (rc)
+			goto cfail;
+		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
+			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
+			uctx->cmask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
+		}
+	}
+
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (rc) {
 		ibdev_err(ibdev, "Failed to copy user context");
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 84715b7..98baea9 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -140,6 +140,7 @@ struct bnxt_re_ucontext {
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
 	struct rdma_user_mmap_entry *shpage_mmap;
+	u64 cmask;
 };
 
 enum bnxt_re_mmap_flag {
@@ -167,6 +168,12 @@ static inline u16 bnxt_re_get_rwqe_size(int nsge)
 	return sizeof(struct rq_wqe_hdr) + (nsge * sizeof(struct sq_sge));
 }
 
+static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
+{
+	return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CMASK_POW2_DISABLED) ?
+		ent : roundup_pow_of_two(ent) : ent;
+}
+
 int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_device_attr *ib_attr,
 			 struct ib_udata *udata);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 6e7c67a..a1b896d 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -54,6 +54,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL,
 	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
 	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
+	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 };
 
 enum bnxt_re_wqe_mode {
@@ -62,6 +63,14 @@ enum bnxt_re_wqe_mode {
 	BNXT_QPLIB_WQE_MODE_INVALID	= 0x02,
 };
 
+enum {
+	BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT = 0x01,
+};
+
+struct bnxt_re_uctx_req {
+	__aligned_u64 comp_mask;
+};
+
 struct bnxt_re_uctx_resp {
 	__u32 dev_id;
 	__u32 max_qp;
-- 
2.5.5


--00000000000037d0eb060862da10
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII6+XoLVLAgN
Q9u/LhAvzKYN8CPvgYawzbDkTDsDcvPzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTAyMzE0MTUyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCF/TVpTO5vj3TprbGew9Pwoqpgj0mk
kNYLdEaaDP95i464LnAlTF5IGP+IYWzYkSfCbfcy4hbSha0o2wef12pBFniQdTvHWig25o1tXDMv
dX9hDbfeo/tQvU4LgFQJBPmmliCwJrM7cAmG8leoQD3CLcSg3cvgestOw6nYXZroLX/j4CVK/SpZ
/qQljXb3VU6fP+U3zPGnqHmV0n4IszVQlColABxHQMvIHIpNCRtIVTaBHKAeZQQkmr7NhOUKOOJR
0tUqYfSd+7rBBp3JgxSk7HAVzUHESnSAgpD6O8TSCL96imkTv+FbRhNsLWZAoQslyizxSUYn8J15
IJ0+wCcF
--00000000000037d0eb060862da10--
