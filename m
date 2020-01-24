Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A7147853
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgAXFxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:53:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46826 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAXFxF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:53:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id n9so546148pff.13
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gS7/qGAX3xtFn+6i1Bmzwf7XYrK2kYNxMRgIILgq518=;
        b=CBmgsUKgCV7yBYFPKepnjVWKDD+Rc4YgDuH6WGuxm6SwLvrfLQYYsHonRvGwPfQGEt
         vzs7ePOstN4M+tOwq583u0Jjplgg9kK0tJKMNaquIyJUOpE0H2Gb0y5cYzVMJ5lRgWBS
         PKpR6AdIKHb4XnD/NbzgYGb/IHx7zgyRMT0ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gS7/qGAX3xtFn+6i1Bmzwf7XYrK2kYNxMRgIILgq518=;
        b=fYGA6DdxUqU/I0iCnZFuEQuSgnsR7sDuzliIVZTp0TQGx+VRFET+zz2Iok7g4Rs55a
         jXHROcC2EkfwCBJaXNR+8q+PM71lhUDBp0oq3I1eEWNkwsiaqgsBPCA0Avz2U1qN/NPk
         EJCsD8BTsq9BXXqdXiWshzEiBOd30Z7KEUb4ESiDMba5rapj7YKuTN/6a0Wa7cWdYRsA
         ID2CHOnELnBMSK1YJ+tksSP1YIu30Fw7wyx5XUnUe9A6qBE8CO6K+qN9E+e4YZhv5pW8
         GVkTdY/byi7jjqoXIlemJGBfwjP9p6vCMnbh7+n4Yl9ssajCW6tpnbdwkTzltqbaYqHr
         Vftw==
X-Gm-Message-State: APjAAAWAg/lsDYhyXFpwY8VLHGWQxOCKiuO7uu0/c45o4lQ28jfPxPfL
        104jRllzU8wVVIW6aCTFwFG7mLQq/3nbcbylAKOUkRGG6XjVe0aHib8Q0f3OA3LwOvqXmE1O2q+
        lF0RuTbUzYx6hTqgANTnOTmWByHkm9Uhp3hJF7fTjWaQZ9v0GhC9uRMRwHpBHYJEqifZb9VfJ4X
        W1J2TWuQ==
X-Google-Smtp-Source: APXvYqxzXBodd1QlpYFs7/exYPF0we6vXHP5zbnXZ4Z/s0yhS/ys0jG9IScPVcqfCs00NrK/V7ZtAg==
X-Received: by 2002:a63:6787:: with SMTP id b129mr2267780pgc.103.1579845182371;
        Thu, 23 Jan 2020 21:53:02 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:53:01 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 3/7] RDMA/bnxt_re: Refactor hardware queue memory allocation
Date:   Fri, 24 Jan 2020 00:52:41 -0500
Message-Id: <1579845165-18002-4-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

At top level there are three major data structure addition.
viz bnxt_qplib_hwq_attr, bnxt_qplib_sg_info and bnxt_qplib_tqm_ctx

Intorduction of first data structure reduces the arguments list
to bnxt_re_alloc_init_hwq() function. There are changes all over
the driver code to incorporate this new structure. The caller
needs to fill the attribute data structure and pass to this function.

The second data structure is to pass memory region description
viz. sghead, page_size and page_shift. There are changes all over
the driver code to initialize bnxt_re_sg_info data structure. The
new data structure helps to reduce the argument list of
__alloc_pbl() function call.

Till now the TQM rings related members were not collected under any
specific data-structure making it hard to manage. The third data
sctructure bnxt_qplib_tqm_ctx is added to refactor the TQM queue
allocation and initialization.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  26 +-
 drivers/infiniband/hw/bnxt_re/main.c       |  20 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 176 ++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  59 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   5 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 475 ++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  60 ++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  52 ++--
 9 files changed, 543 insertions(+), 332 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 865728c..e589c98 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -876,9 +876,11 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		return PTR_ERR(umem);
 
 	qp->sumem = umem;
-	qplib_qp->sq.sg_info.sglist = umem->sg_head.sgl;
+	qplib_qp->sq.sg_info.sghead = umem->sg_head.sgl;
 	qplib_qp->sq.sg_info.npages = ib_umem_num_pages(umem);
 	qplib_qp->sq.sg_info.nmap = umem->nmap;
+	qplib_qp->sq.sg_info.pgsize = PAGE_SIZE;
+	qplib_qp->sq.sg_info.pgshft = PAGE_SHIFT;
 	qplib_qp->qp_handle = ureq.qp_handle;
 
 	if (!qp->qplib_qp.srq) {
@@ -889,9 +891,11 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		if (IS_ERR(umem))
 			goto rqfail;
 		qp->rumem = umem;
-		qplib_qp->rq.sg_info.sglist = umem->sg_head.sgl;
+		qplib_qp->rq.sg_info.sghead = umem->sg_head.sgl;
 		qplib_qp->rq.sg_info.npages = ib_umem_num_pages(umem);
 		qplib_qp->rq.sg_info.nmap = umem->nmap;
+		qplib_qp->rq.sg_info.pgsize = PAGE_SIZE;
+		qplib_qp->rq.sg_info.pgshft = PAGE_SHIFT;
 	}
 
 	qplib_qp->dpi = &cntx->dpi;
@@ -981,6 +985,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.sq.max_sge = 2;
 	/* Q full delta can be 1 since it is internal QP */
 	qp->qplib_qp.sq.q_full_delta = 1;
+	qp->qplib_qp.sq.sg_info.pgsize = PAGE_SIZE;
+	qp->qplib_qp.sq.sg_info.pgshft = PAGE_SHIFT;
 
 	qp->qplib_qp.scq = qp1_qp->scq;
 	qp->qplib_qp.rcq = qp1_qp->rcq;
@@ -989,6 +995,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->qplib_qp.rq.max_sge = qp1_qp->rq.max_sge;
 	/* Q full delta can be 1 since it is internal QP */
 	qp->qplib_qp.rq.q_full_delta = 1;
+	qp->qplib_qp.rq.sg_info.pgsize = PAGE_SIZE;
+	qp->qplib_qp.rq.sg_info.pgshft = PAGE_SHIFT;
 
 	qp->qplib_qp.mtu = qp1_qp->mtu;
 
@@ -1048,6 +1056,8 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
 			qplqp->rq.max_sge = dev_attr->max_qp_sges;
 	}
+	qplqp->rq.sg_info.pgsize = PAGE_SIZE;
+	qplqp->rq.sg_info.pgshft = PAGE_SHIFT;
 
 	return 0;
 }
@@ -1100,6 +1110,8 @@ static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	 * unexpected Queue full condition
 	 */
 	qplqp->sq.q_full_delta -= 1;
+	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
+	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
 }
 
 static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
@@ -1515,9 +1527,11 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 		return PTR_ERR(umem);
 
 	srq->umem = umem;
-	qplib_srq->sg_info.sglist = umem->sg_head.sgl;
+	qplib_srq->sg_info.sghead = umem->sg_head.sgl;
 	qplib_srq->sg_info.npages = ib_umem_num_pages(umem);
 	qplib_srq->sg_info.nmap = umem->nmap;
+	qplib_srq->sg_info.pgsize = PAGE_SIZE;
+	qplib_srq->sg_info.pgshft = PAGE_SHIFT;
 	qplib_srq->srq_handle = ureq.srq_handle;
 	qplib_srq->dpi = &cntx->dpi;
 
@@ -2371,7 +2385,7 @@ static int bnxt_re_build_reg_wqe(const struct ib_reg_wr *wr,
 	wqe->frmr.pbl_dma_ptr = qplib_frpl->hwq.pbl_dma_ptr[0];
 	wqe->frmr.page_list = mr->pages;
 	wqe->frmr.page_list_len = mr->npages;
-	wqe->frmr.levels = qplib_frpl->hwq.level + 1;
+	wqe->frmr.levels = qplib_frpl->hwq.level;
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_REG_MR;
 
 	/* Need unconditional fence for reg_mr
@@ -2745,6 +2759,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
+	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
+	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
 		struct bnxt_re_ucontext *uctx = rdma_udata_to_drv_context(
@@ -2761,7 +2777,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			rc = PTR_ERR(cq->umem);
 			goto fail;
 		}
-		cq->qplib_cq.sg_info.sglist = cq->umem->sg_head.sgl;
+		cq->qplib_cq.sg_info.sghead = cq->umem->sg_head.sgl;
 		cq->qplib_cq.sg_info.npages = ib_umem_num_pages(cq->umem);
 		cq->qplib_cq.sg_info.nmap = cq->umem->nmap;
 		cq->qplib_cq.dpi = &uctx->dpi;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 390daeb..a966c68 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -90,6 +90,8 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
 	rdev->qplib_res.cctx = NULL;
+	rdev->qplib_res.pdev = NULL;
+	rdev->qplib_res.netdev = NULL;
 	kfree(chip_ctx);
 }
 
@@ -151,7 +153,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
 	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
-			rdev->qplib_ctx.tqm_count[i] =
+			rdev->qplib_ctx.tqm_ctx.qcount[i] =
 			rdev->dev_attr.tqm_alloc_reqs[i];
 }
 
@@ -982,8 +984,8 @@ static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
 	for (i = 0; i < rdev->num_msix - 1; i++) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		rdev->nq[i].res = NULL;
 		bnxt_qplib_free_nq(&rdev->nq[i]);
+		rdev->nq[i].res = NULL;
 	}
 }
 
@@ -1032,7 +1034,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		rdev->nq[i].res = &rdev->qplib_res;
 		rdev->nq[i].hwq.max_elements = BNXT_RE_MAX_CQ_COUNT +
 			BNXT_RE_MAX_SRQC_COUNT + 2;
-		rc = bnxt_qplib_alloc_nq(rdev->en_dev->pdev, &rdev->nq[i]);
+		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev), "Alloc Failed NQ%d rc:%#x",
 				i, rc);
@@ -1056,7 +1058,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	}
 	return 0;
 free_nq:
-	for (i = num_vec_created; i >= 0; i--) {
+	for (i = num_vec_created - 1; i >= 0; i--) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
 		bnxt_qplib_free_nq(&rdev->nq[i]);
@@ -1335,7 +1337,7 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 			dev_warn(rdev_to_dev(rdev),
 				 "Failed to deinitialize RCFW: %#x", rc);
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-		bnxt_qplib_free_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx);
+		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
@@ -1411,7 +1413,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	/* Establish RCFW Communication Channel to initialize the context
 	 * memory for the function and all child VFs
 	 */
-	rc = bnxt_qplib_alloc_rcfw_channel(rdev->en_dev->pdev, &rdev->rcfw,
+	rc = bnxt_qplib_alloc_rcfw_channel(&rdev->qplib_res, &rdev->rcfw,
 					   &rdev->qplib_ctx,
 					   BNXT_RE_MAX_QPC_COUNT);
 	if (rc) {
@@ -1432,7 +1434,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	}
 	db_offt = bnxt_re_get_nqdb_offset(rdev, BNXT_RE_AEQ_IDX);
 	vid = rdev->msix_entries[BNXT_RE_AEQ_IDX].vector;
-	rc = bnxt_qplib_enable_rcfw_channel(rdev->en_dev->pdev, &rdev->rcfw,
+	rc = bnxt_qplib_enable_rcfw_channel(&rdev->rcfw,
 					    vid, db_offt, rdev->is_virtfn,
 					    &bnxt_re_aeq_handler);
 	if (rc) {
@@ -1447,7 +1449,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 
 	bnxt_re_set_resource_limits(rdev);
 
-	rc = bnxt_qplib_alloc_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx, 0,
+	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
 				  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx));
 	if (rc) {
 		pr_err("Failed to allocate QPLIB context: %#x\n", rc);
@@ -1514,7 +1516,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
 free_ctx:
-	bnxt_qplib_free_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx);
+	bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
 disable_rcfw:
 	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index bc9f747..792fc6b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -464,26 +464,35 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 void bnxt_qplib_free_nq(struct bnxt_qplib_nq *nq)
 {
 	if (nq->hwq.max_elements) {
-		bnxt_qplib_free_hwq(nq->pdev, &nq->hwq);
+		bnxt_qplib_free_hwq(nq->res, &nq->hwq);
 		nq->hwq.max_elements = 0;
 	}
 }
 
-int bnxt_qplib_alloc_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq)
+int bnxt_qplib_alloc_nq(struct bnxt_qplib_res *res, struct bnxt_qplib_nq *nq)
 {
-	u8 hwq_type;
+	struct bnxt_qplib_hwq_attr hwq_attr;
+	struct bnxt_qplib_sg_info sginfo;
 
-	nq->pdev = pdev;
+	nq->pdev = res->pdev;
+	nq->res = res;
 	if (!nq->hwq.max_elements ||
 	    nq->hwq.max_elements > BNXT_QPLIB_NQE_MAX_CNT)
 		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
-	hwq_type = bnxt_qplib_get_hwq_type(nq->res);
-	if (bnxt_qplib_alloc_init_hwq(nq->pdev, &nq->hwq, NULL,
-				      &nq->hwq.max_elements,
-				      BNXT_QPLIB_MAX_NQE_ENTRY_SIZE, 0,
-				      PAGE_SIZE, hwq_type))
-		return -ENOMEM;
 
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.depth = nq->hwq.max_elements;
+	hwq_attr.stride = sizeof(struct nq_base);
+	hwq_attr.type = bnxt_qplib_get_hwq_type(nq->res);
+	if (bnxt_qplib_alloc_init_hwq(&nq->hwq, &hwq_attr)) {
+		dev_err(&nq->pdev->dev, "FP NQ allocation failed");
+		return -ENOMEM;
+	}
 	nq->budget = 8;
 	return 0;
 }
@@ -526,24 +535,27 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 	kfree(srq->swq);
 	if (rc)
 		return;
-	bnxt_qplib_free_hwq(res->pdev, &srq->hwq);
+	bnxt_qplib_free_hwq(res, &srq->hwq);
 }
 
 int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_srq *srq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_create_srq req;
+	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct creq_create_srq_resp resp;
+	struct cmdq_create_srq req;
 	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
 	int rc, idx;
 
-	srq->hwq.max_elements = srq->max_wqe;
-	rc = bnxt_qplib_alloc_init_hwq(res->pdev, &srq->hwq, &srq->sg_info,
-				       &srq->hwq.max_elements,
-				       BNXT_QPLIB_MAX_RQE_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_QUEUE);
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &srq->sg_info;
+	hwq_attr.depth = srq->max_wqe;
+	hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&srq->hwq, &hwq_attr);
 	if (rc)
 		goto exit;
 
@@ -602,7 +614,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 
 	return 0;
 fail:
-	bnxt_qplib_free_hwq(res->pdev, &srq->hwq);
+	bnxt_qplib_free_hwq(res, &srq->hwq);
 	kfree(srq->swq);
 exit:
 	return rc;
@@ -722,14 +734,15 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_create_qp1 req;
-	struct creq_create_qp1_resp resp;
-	struct bnxt_qplib_pbl *pbl;
+	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
-	int rc;
+	struct creq_create_qp1_resp resp;
+	struct cmdq_create_qp1 req;
+	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
+	int rc;
 
 	RCFW_CMD_PREP(req, CREATE_QP1, cmd_flags);
 
@@ -738,12 +751,14 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.dpi = cpu_to_le32(qp->dpi->dpi);
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
 	/* SQ */
-	sq->hwq.max_elements = sq->max_wqe;
-	rc = bnxt_qplib_alloc_init_hwq(res->pdev, &sq->hwq, NULL,
-				       &sq->hwq.max_elements,
-				       BNXT_QPLIB_MAX_SQE_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_QUEUE);
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sq->sg_info;
+	hwq_attr.depth = sq->max_wqe;
+	hwq_attr.stride = BNXT_QPLIB_MAX_SQE_ENTRY_SIZE;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
 		goto exit;
 
@@ -778,11 +793,12 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* RQ */
 	if (rq->max_wqe) {
-		rq->hwq.max_elements = qp->rq.max_wqe;
-		rc = bnxt_qplib_alloc_init_hwq(res->pdev, &rq->hwq, NULL,
-					       &rq->hwq.max_elements,
-					       BNXT_QPLIB_MAX_RQE_ENTRY_SIZE, 0,
-					       PAGE_SIZE, HWQ_TYPE_QUEUE);
+		hwq_attr.res = res;
+		hwq_attr.sginfo = &rq->sg_info;
+		hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+		hwq_attr.depth = qp->rq.max_wqe;
+		hwq_attr.type = HWQ_TYPE_QUEUE;
+		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
 			goto fail_sq;
 
@@ -848,10 +864,10 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 fail:
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
 fail_rq:
-	bnxt_qplib_free_hwq(res->pdev, &rq->hwq);
+	bnxt_qplib_free_hwq(res, &rq->hwq);
 	kfree(rq->swq);
 fail_sq:
-	bnxt_qplib_free_hwq(res->pdev, &sq->hwq);
+	bnxt_qplib_free_hwq(res, &sq->hwq);
 	kfree(sq->swq);
 exit:
 	return rc;
@@ -861,9 +877,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	unsigned long int psn_search, poff = 0;
+	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct sq_psn_search **psn_search_ptr;
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
+	struct bnxt_qplib_sg_info sginfo;
 	int i, rc, req_size, psn_sz = 0;
 	struct sq_send **hw_sq_send_ptr;
 	struct creq_create_qp_resp resp;
@@ -881,18 +899,23 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.dpi = cpu_to_le32(qp->dpi->dpi);
 	req.qp_handle = cpu_to_le64(qp->qp_handle);
 
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
 	/* SQ */
 	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
 		psn_sz = bnxt_qplib_is_chip_gen_p5(res->cctx) ?
 			 sizeof(struct sq_psn_search_ext) :
 			 sizeof(struct sq_psn_search);
 	}
-	sq->hwq.max_elements = sq->max_wqe;
-	rc = bnxt_qplib_alloc_init_hwq(res->pdev, &sq->hwq, &sq->sg_info,
-				       &sq->hwq.max_elements,
-				       BNXT_QPLIB_MAX_SQE_ENTRY_SIZE,
-				       psn_sz,
-				       PAGE_SIZE, HWQ_TYPE_QUEUE);
+
+	hwq_attr.res = res;
+	hwq_attr.sginfo = &sq->sg_info;
+	hwq_attr.stride = BNXT_QPLIB_MAX_SQE_ENTRY_SIZE;
+	hwq_attr.depth = sq->max_wqe;
+	hwq_attr.aux_stride = psn_sz;
+	hwq_attr.aux_depth = hwq_attr.depth;
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
 		goto exit;
 
@@ -956,12 +979,14 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* RQ */
 	if (rq->max_wqe) {
-		rq->hwq.max_elements = rq->max_wqe;
-		rc = bnxt_qplib_alloc_init_hwq(res->pdev, &rq->hwq,
-					       &rq->sg_info,
-					       &rq->hwq.max_elements,
-					       BNXT_QPLIB_MAX_RQE_ENTRY_SIZE, 0,
-					       PAGE_SIZE, HWQ_TYPE_QUEUE);
+		hwq_attr.res = res;
+		hwq_attr.sginfo = &rq->sg_info;
+		hwq_attr.stride = BNXT_QPLIB_MAX_RQE_ENTRY_SIZE;
+		hwq_attr.depth = rq->max_wqe;
+		hwq_attr.aux_stride = 0;
+		hwq_attr.aux_depth = 0;
+		hwq_attr.type = HWQ_TYPE_QUEUE;
+		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
 			goto fail_sq;
 
@@ -1029,10 +1054,17 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		req_size = xrrq->max_elements *
 			   BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
 		req_size &= ~(PAGE_SIZE - 1);
-		rc = bnxt_qplib_alloc_init_hwq(res->pdev, xrrq, NULL,
-					       &xrrq->max_elements,
-					       BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE,
-					       0, req_size, HWQ_TYPE_CTX);
+		sginfo.pgsize = req_size;
+		sginfo.pgshft = PAGE_SHIFT;
+
+		hwq_attr.res = res;
+		hwq_attr.sginfo = &sginfo;
+		hwq_attr.depth = xrrq->max_elements;
+		hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
+		hwq_attr.aux_stride = 0;
+		hwq_attr.aux_depth = 0;
+		hwq_attr.type = HWQ_TYPE_CTX;
+		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
 		if (rc)
 			goto fail_buf_free;
 		pbl = &xrrq->pbl[PBL_LVL_0];
@@ -1044,11 +1076,10 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		req_size = xrrq->max_elements *
 			   BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
 		req_size &= ~(PAGE_SIZE - 1);
-
-		rc = bnxt_qplib_alloc_init_hwq(res->pdev, xrrq, NULL,
-					       &xrrq->max_elements,
-					       BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE,
-					       0, req_size, HWQ_TYPE_CTX);
+		sginfo.pgsize = req_size;
+		hwq_attr.depth =  xrrq->max_elements;
+		hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
+		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
 		if (rc)
 			goto fail_orrq;
 
@@ -1074,17 +1105,17 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 fail:
 	if (qp->irrq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &qp->irrq);
+		bnxt_qplib_free_hwq(res, &qp->irrq);
 fail_orrq:
 	if (qp->orrq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &qp->orrq);
+		bnxt_qplib_free_hwq(res, &qp->orrq);
 fail_buf_free:
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
 fail_rq:
-	bnxt_qplib_free_hwq(res->pdev, &rq->hwq);
+	bnxt_qplib_free_hwq(res, &rq->hwq);
 	kfree(rq->swq);
 fail_sq:
-	bnxt_qplib_free_hwq(res->pdev, &sq->hwq);
+	bnxt_qplib_free_hwq(res, &sq->hwq);
 	kfree(sq->swq);
 exit:
 	return rc;
@@ -1440,16 +1471,16 @@ void bnxt_qplib_free_qp_res(struct bnxt_qplib_res *res,
 			    struct bnxt_qplib_qp *qp)
 {
 	bnxt_qplib_free_qp_hdr_buf(res, qp);
-	bnxt_qplib_free_hwq(res->pdev, &qp->sq.hwq);
+	bnxt_qplib_free_hwq(res, &qp->sq.hwq);
 	kfree(qp->sq.swq);
 
-	bnxt_qplib_free_hwq(res->pdev, &qp->rq.hwq);
+	bnxt_qplib_free_hwq(res, &qp->rq.hwq);
 	kfree(qp->rq.swq);
 
 	if (qp->irrq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &qp->irrq);
+		bnxt_qplib_free_hwq(res, &qp->irrq);
 	if (qp->orrq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &qp->orrq);
+		bnxt_qplib_free_hwq(res, &qp->orrq);
 
 }
 
@@ -1927,17 +1958,20 @@ static void bnxt_qplib_arm_cq(struct bnxt_qplib_cq *cq, u32 arm_type)
 int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_create_cq req;
+	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct creq_create_cq_resp resp;
+	struct cmdq_create_cq req;
 	struct bnxt_qplib_pbl *pbl;
 	u16 cmd_flags = 0;
 	int rc;
 
-	cq->hwq.max_elements = cq->max_wqe;
-	rc = bnxt_qplib_alloc_init_hwq(res->pdev, &cq->hwq, &cq->sg_info,
-				       &cq->hwq.max_elements,
-				       BNXT_QPLIB_MAX_CQE_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_QUEUE);
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	hwq_attr.res = res;
+	hwq_attr.depth = cq->max_wqe;
+	hwq_attr.stride = sizeof(struct cq_base);
+	hwq_attr.type = HWQ_TYPE_QUEUE;
+	hwq_attr.sginfo = &cq->sg_info;
+	rc = bnxt_qplib_alloc_init_hwq(&cq->hwq, &hwq_attr);
 	if (rc)
 		goto exit;
 
@@ -1988,7 +2022,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	return 0;
 
 fail:
-	bnxt_qplib_free_hwq(res->pdev, &cq->hwq);
+	bnxt_qplib_free_hwq(res, &cq->hwq);
 exit:
 	return rc;
 }
@@ -2008,7 +2042,7 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 					  (void *)&resp, NULL, 0);
 	if (rc)
 		return rc;
-	bnxt_qplib_free_hwq(res->pdev, &cq->hwq);
+	bnxt_qplib_free_hwq(res, &cq->hwq);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 99e0a13..d3f080c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -550,7 +550,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 bool bnxt_qplib_is_cq_empty(struct bnxt_qplib_cq *cq);
 void bnxt_qplib_req_notify_cq(struct bnxt_qplib_cq *cq, u32 arm_type);
 void bnxt_qplib_free_nq(struct bnxt_qplib_nq *nq);
-int bnxt_qplib_alloc_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq);
+int bnxt_qplib_alloc_nq(struct bnxt_qplib_res *res, struct bnxt_qplib_nq *nq);
 void bnxt_qplib_add_flush_qp(struct bnxt_qplib_qp *qp);
 void bnxt_qplib_acquire_cq_locks(struct bnxt_qplib_qp *qp,
 				 unsigned long *flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5cdfa84..d2464dc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -520,9 +520,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	level = ctx->tim_tbl.level;
 	req.tim_pg_size_tim_lvl = (level << CMDQ_INITIALIZE_FW_TIM_LVL_SFT) |
 				  __get_pbl_pg_idx(&ctx->tim_tbl.pbl[level]);
-	level = ctx->tqm_pde_level;
-	req.tqm_pg_size_tqm_lvl = (level << CMDQ_INITIALIZE_FW_TQM_LVL_SFT) |
-				  __get_pbl_pg_idx(&ctx->tqm_pde.pbl[level]);
+	level = ctx->tqm_ctx.pde.level;
+	req.tqm_pg_size_tqm_lvl =
+		(level << CMDQ_INITIALIZE_FW_TQM_LVL_SFT) |
+		 __get_pbl_pg_idx(&ctx->tqm_ctx.pde.pbl[level]);
 
 	req.qpc_page_dir =
 		cpu_to_le64(ctx->qpc_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
@@ -535,7 +536,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	req.tim_page_dir =
 		cpu_to_le64(ctx->tim_tbl.pbl[PBL_LVL_0].pg_map_arr[0]);
 	req.tqm_page_dir =
-		cpu_to_le64(ctx->tqm_pde.pbl[PBL_LVL_0].pg_map_arr[0]);
+		cpu_to_le64(ctx->tqm_ctx.pde.pbl[PBL_LVL_0].pg_map_arr[0]);
 
 	req.number_of_qp = cpu_to_le32(ctx->qpc_tbl.max_elements);
 	req.number_of_mrw = cpu_to_le32(ctx->mrw_tbl.max_elements);
@@ -563,25 +564,34 @@ void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
 	kfree(rcfw->qp_tbl);
 	kfree(rcfw->crsqe_tbl);
-	bnxt_qplib_free_hwq(rcfw->pdev, &rcfw->cmdq);
-	bnxt_qplib_free_hwq(rcfw->pdev, &rcfw->creq);
+	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq);
+	bnxt_qplib_free_hwq(rcfw->res, &rcfw->creq);
 	rcfw->pdev = NULL;
 }
 
-int bnxt_qplib_alloc_rcfw_channel(struct pci_dev *pdev,
+int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx,
 				  int qp_tbl_sz)
 {
-	u8 hwq_type;
-
-	rcfw->pdev = pdev;
-	rcfw->creq.max_elements = BNXT_QPLIB_CREQE_MAX_CNT;
-	hwq_type = bnxt_qplib_get_hwq_type(rcfw->res);
-	if (bnxt_qplib_alloc_init_hwq(rcfw->pdev, &rcfw->creq, NULL,
-				      &rcfw->creq.max_elements,
-				      BNXT_QPLIB_CREQE_UNITS,
-				      0, PAGE_SIZE, hwq_type)) {
+	struct bnxt_qplib_hwq_attr hwq_attr;
+	struct bnxt_qplib_sg_info sginfo;
+
+	rcfw->pdev = res->pdev;
+	rcfw->res = res;
+
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.res = rcfw->res;
+	hwq_attr.depth = BNXT_QPLIB_CREQE_MAX_CNT;
+	hwq_attr.stride = BNXT_QPLIB_CREQE_UNITS;
+	hwq_attr.type = bnxt_qplib_get_hwq_type(res);
+
+	if (bnxt_qplib_alloc_init_hwq(&rcfw->creq, &hwq_attr)) {
 		dev_err(&rcfw->pdev->dev,
 			"HW channel CREQ allocation failed\n");
 		goto fail;
@@ -591,13 +601,11 @@ int bnxt_qplib_alloc_rcfw_channel(struct pci_dev *pdev,
 	else
 		rcfw->cmdq_depth = BNXT_QPLIB_CMDQE_MAX_CNT_8192;
 
-	rcfw->cmdq.max_elements = rcfw->cmdq_depth;
-	if (bnxt_qplib_alloc_init_hwq
-			(rcfw->pdev, &rcfw->cmdq, NULL,
-			 &rcfw->cmdq.max_elements,
-			 BNXT_QPLIB_CMDQE_UNITS, 0,
-			 bnxt_qplib_cmdqe_page_size(rcfw->cmdq_depth),
-			 HWQ_TYPE_CTX)) {
+	sginfo.pgsize = bnxt_qplib_cmdqe_page_size(rcfw->cmdq_depth);
+	hwq_attr.depth = rcfw->cmdq_depth;
+	hwq_attr.stride = BNXT_QPLIB_CMDQE_UNITS;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	if (bnxt_qplib_alloc_init_hwq(&rcfw->cmdq, &hwq_attr)) {
 		dev_err(&rcfw->pdev->dev,
 			"HW channel CMDQ allocation failed\n");
 		goto fail;
@@ -690,8 +698,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 	return 0;
 }
 
-int bnxt_qplib_enable_rcfw_channel(struct pci_dev *pdev,
-				   struct bnxt_qplib_rcfw *rcfw,
+int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 				   int msix_vector,
 				   int cp_bar_reg_off, int virt_fn,
 				   int (*aeq_handler)(struct bnxt_qplib_rcfw *,
@@ -699,10 +706,12 @@ int bnxt_qplib_enable_rcfw_channel(struct pci_dev *pdev,
 {
 	resource_size_t res_base;
 	struct cmdq_init init;
+	struct pci_dev *pdev;
 	u16 bmap_size;
 	int rc;
 
 	/* General */
+	pdev = rcfw->pdev;
 	rcfw->seq_num = 0;
 	set_bit(FIRMWARE_FIRST_FLAG, &rcfw->flags);
 	bmap_size = BITS_TO_LONGS(rcfw->cmdq_depth) * sizeof(unsigned long);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index dfeadc1..ab1531c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -268,7 +268,7 @@ struct bnxt_qplib_rcfw {
 };
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
-int bnxt_qplib_alloc_rcfw_channel(struct pci_dev *pdev,
+int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx,
 				  int qp_tbl_sz);
@@ -276,8 +276,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct pci_dev *pdev,
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init);
-int bnxt_qplib_enable_rcfw_channel(struct pci_dev *pdev,
-				   struct bnxt_qplib_rcfw *rcfw,
+int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 				   int msix_vector,
 				   int cp_bar_reg_off, int virt_fn,
 				   int (*aeq_handler)(struct bnxt_qplib_rcfw *,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index bdbde8e..1fa8e79 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -55,9 +55,10 @@ static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
 				      struct bnxt_qplib_stats *stats);
 
 /* PBL */
-static void __free_pbl(struct pci_dev *pdev, struct bnxt_qplib_pbl *pbl,
+static void __free_pbl(struct bnxt_qplib_res *res, struct bnxt_qplib_pbl *pbl,
 		       bool is_umem)
 {
+	struct pci_dev *pdev = res->pdev;
 	int i;
 
 	if (!is_umem) {
@@ -74,35 +75,57 @@ static void __free_pbl(struct pci_dev *pdev, struct bnxt_qplib_pbl *pbl,
 			pbl->pg_arr[i] = NULL;
 		}
 	}
-	kfree(pbl->pg_arr);
+	vfree(pbl->pg_arr);
 	pbl->pg_arr = NULL;
-	kfree(pbl->pg_map_arr);
+	vfree(pbl->pg_map_arr);
 	pbl->pg_map_arr = NULL;
 	pbl->pg_count = 0;
 	pbl->pg_size = 0;
 }
 
-static int __alloc_pbl(struct pci_dev *pdev, struct bnxt_qplib_pbl *pbl,
-		       struct scatterlist *sghead, u32 pages,
-		       u32 nmaps, u32 pg_size)
+static void bnxt_qplib_fill_user_dma_pages(struct bnxt_qplib_pbl *pbl,
+					   struct bnxt_qplib_sg_info *sginfo)
 {
+	struct scatterlist *sghead = sginfo->sghead;
 	struct sg_dma_page_iter sg_iter;
+	int i = 0;
+
+	for_each_sg_dma_page(sghead, &sg_iter, sginfo->nmap, 0) {
+		pbl->pg_map_arr[i] = sg_page_iter_dma_address(&sg_iter);
+		pbl->pg_arr[i] = NULL;
+		pbl->pg_count++;
+		i++;
+	}
+}
+
+static int __alloc_pbl(struct bnxt_qplib_res *res,
+		       struct bnxt_qplib_pbl *pbl,
+		       struct bnxt_qplib_sg_info *sginfo)
+{
+	struct pci_dev *pdev = res->pdev;
+	struct scatterlist *sghead;
 	bool is_umem = false;
+	u32 pages, pg_size;
 	int i;
 
+	if (sginfo->nopte)
+		return 0;
+	pages = sginfo->npages;
+	pg_size = sginfo->pgsize;
+	sghead = sginfo->sghead;
 	/* page ptr arrays */
-	pbl->pg_arr = kcalloc(pages, sizeof(void *), GFP_KERNEL);
+	pbl->pg_arr = vmalloc(pages * sizeof(void *));
 	if (!pbl->pg_arr)
 		return -ENOMEM;
 
-	pbl->pg_map_arr = kcalloc(pages, sizeof(dma_addr_t), GFP_KERNEL);
+	pbl->pg_map_arr = vmalloc(pages * sizeof(dma_addr_t));
 	if (!pbl->pg_map_arr) {
-		kfree(pbl->pg_arr);
+		vfree(pbl->pg_arr);
 		pbl->pg_arr = NULL;
 		return -ENOMEM;
 	}
 	pbl->pg_count = 0;
-	pbl->pg_size = pg_size;
+	pbl->pg_size = sginfo->pgsize;
 
 	if (!sghead) {
 		for (i = 0; i < pages; i++) {
@@ -115,25 +138,19 @@ static int __alloc_pbl(struct pci_dev *pdev, struct bnxt_qplib_pbl *pbl,
 			pbl->pg_count++;
 		}
 	} else {
-		i = 0;
 		is_umem = true;
-		for_each_sg_dma_page(sghead, &sg_iter, nmaps, 0) {
-			pbl->pg_map_arr[i] = sg_page_iter_dma_address(&sg_iter);
-			pbl->pg_arr[i] = NULL;
-			pbl->pg_count++;
-			i++;
-		}
+		bnxt_qplib_fill_user_dma_pages(pbl, sginfo);
 	}
 
 	return 0;
-
 fail:
-	__free_pbl(pdev, pbl, is_umem);
+	__free_pbl(res, pbl, is_umem);
 	return -ENOMEM;
 }
 
 /* HWQ */
-void bnxt_qplib_free_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq)
+void bnxt_qplib_free_hwq(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_hwq *hwq)
 {
 	int i;
 
@@ -144,9 +161,9 @@ void bnxt_qplib_free_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq)
 
 	for (i = 0; i < hwq->level + 1; i++) {
 		if (i == hwq->level)
-			__free_pbl(pdev, &hwq->pbl[i], hwq->is_user);
+			__free_pbl(res, &hwq->pbl[i], hwq->is_user);
 		else
-			__free_pbl(pdev, &hwq->pbl[i], false);
+			__free_pbl(res, &hwq->pbl[i], false);
 	}
 
 	hwq->level = PBL_LVL_MAX;
@@ -158,79 +175,114 @@ void bnxt_qplib_free_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq)
 }
 
 /* All HWQs are power of 2 in size */
-int bnxt_qplib_alloc_init_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq,
-			      struct bnxt_qplib_sg_info *sg_info,
-			      u32 *elements, u32 element_size, u32 aux,
-			      u32 pg_size, enum bnxt_qplib_hwq_type hwq_type)
+
+int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
+			      struct bnxt_qplib_hwq_attr *hwq_attr)
 {
-	u32 pages, maps, slots, size, aux_pages = 0, aux_size = 0;
+	u32 npages, aux_slots, pg_size, aux_pages = 0, aux_size = 0;
+	u32 depth, stride, npbl, npde;
+	struct bnxt_qplib_sg_info sginfo;
 	dma_addr_t *src_phys_ptr, **dst_virt_ptr;
 	struct scatterlist *sghead = NULL;
-	int i, rc;
-
+	struct bnxt_qplib_res *res;
+	struct pci_dev *pdev;
+	int i, rc, lvl;
+
+	res = hwq_attr->res;
+	pdev = res->pdev;
+	sghead = hwq_attr->sginfo->sghead;
+	pg_size = hwq_attr->sginfo->pgsize;
+	memset(&sginfo, 0, sizeof(sginfo));
 	hwq->level = PBL_LVL_MAX;
 
-	slots = roundup_pow_of_two(*elements);
-	if (aux) {
-		aux_size = roundup_pow_of_two(aux);
-		aux_pages = (slots * aux_size) / pg_size;
-		if ((slots * aux_size) % pg_size)
+	depth = roundup_pow_of_two(hwq_attr->depth);
+	stride = roundup_pow_of_two(hwq_attr->stride);
+	if (hwq_attr->aux_depth) {
+		aux_slots = hwq_attr->aux_depth;
+		aux_size = roundup_pow_of_two(hwq_attr->aux_stride);
+		aux_pages = (aux_slots * aux_size) / pg_size;
+		if ((aux_slots * aux_size) % pg_size)
 			aux_pages++;
 	}
-	size = roundup_pow_of_two(element_size);
-
-	if (sg_info)
-		sghead = sg_info->sglist;
 
 	if (!sghead) {
 		hwq->is_user = false;
-		pages = (slots * size) / pg_size + aux_pages;
-		if ((slots * size) % pg_size)
-			pages++;
-		if (!pages)
+		npages = (depth * stride) / pg_size + aux_pages;
+		if ((depth * stride) % pg_size)
+			npages++;
+		if (!npages)
 			return -EINVAL;
-		maps = 0;
+		hwq_attr->sginfo->npages = npages;
 	} else {
 		hwq->is_user = true;
-		pages = sg_info->npages;
-		maps = sg_info->nmap;
+		npages = hwq_attr->sginfo->npages;
+		npages = (npages * PAGE_SIZE) /
+			  BIT_ULL(hwq_attr->sginfo->pgshft);
+		if ((hwq_attr->sginfo->npages * PAGE_SIZE) %
+		     BIT_ULL(hwq_attr->sginfo->pgshft))
+			if (!npages)
+				npages++;
 	}
 
-	/* Alloc the 1st memory block; can be a PDL/PTL/PBL */
-	if (sghead && (pages == MAX_PBL_LVL_0_PGS))
-		rc = __alloc_pbl(pdev, &hwq->pbl[PBL_LVL_0], sghead,
-				 pages, maps, pg_size);
-	else
-		rc = __alloc_pbl(pdev, &hwq->pbl[PBL_LVL_0], NULL,
-				 1, 0, pg_size);
-	if (rc)
-		goto fail;
-
-	hwq->level = PBL_LVL_0;
+	if (npages == MAX_PBL_LVL_0_PGS) {
+		/* This request is Level 0, map PTE */
+		rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], hwq_attr->sginfo);
+		if (rc)
+			goto fail;
+		hwq->level = PBL_LVL_0;
+	}
 
-	if (pages > MAX_PBL_LVL_0_PGS) {
-		if (pages > MAX_PBL_LVL_1_PGS) {
+	if (npages > MAX_PBL_LVL_0_PGS) {
+		if (npages > MAX_PBL_LVL_1_PGS) {
+			u32 flag = (hwq_attr->type == HWQ_TYPE_L2_CMPL) ?
+				    0 : PTU_PTE_VALID;
 			/* 2 levels of indirection */
-			rc = __alloc_pbl(pdev, &hwq->pbl[PBL_LVL_1], NULL,
-					 MAX_PBL_LVL_1_PGS_FOR_LVL_2,
-					 0, pg_size);
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			npde = npbl >> MAX_PDL_LVL_SHIFT;
+			if (npbl % BIT(MAX_PDL_LVL_SHIFT))
+				npde++;
+			/* Alloc PDE pages */
+			sginfo.pgsize = npde * pg_size;
+			sginfo.npages = 1;
+			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+
+			/* Alloc PBL pages */
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_1], &sginfo);
 			if (rc)
 				goto fail;
-			/* Fill in lvl0 PBL */
+			/* Fill PDL with PBL page pointers */
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_0].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_1].pg_map_arr;
-			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++)
-				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
-					src_phys_ptr[i] | PTU_PDE_VALID;
-			hwq->level = PBL_LVL_1;
-
-			rc = __alloc_pbl(pdev, &hwq->pbl[PBL_LVL_2], sghead,
-					 pages, maps, pg_size);
+			if (hwq_attr->type == HWQ_TYPE_MR) {
+			/* For MR it is expected that we supply only 1 contigous
+			 * page i.e only 1 entry in the PDL that will contain
+			 * all the PBLs for the user supplied memory region
+			 */
+				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
+				     i++)
+					dst_virt_ptr[0][i] = src_phys_ptr[i] |
+						flag;
+			} else {
+				for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count;
+				     i++)
+					dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
+						src_phys_ptr[i] |
+						PTU_PDE_VALID;
+			}
+			/* Alloc or init PTEs */
+			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_2],
+					 hwq_attr->sginfo);
 			if (rc)
 				goto fail;
-
-			/* Fill in lvl1 PBL */
+			hwq->level = PBL_LVL_2;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBLs with PTE pointers */
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_1].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_2].pg_map_arr;
@@ -238,7 +290,7 @@ int bnxt_qplib_alloc_init_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq,
 				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
 					src_phys_ptr[i] | PTU_PTE_VALID;
 			}
-			if (hwq_type == HWQ_TYPE_QUEUE) {
+			if (hwq_attr->type == HWQ_TYPE_QUEUE) {
 				/* Find the last pg of the size */
 				i = hwq->pbl[PBL_LVL_2].pg_count;
 				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
@@ -248,25 +300,36 @@ int bnxt_qplib_alloc_init_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq,
 						    [PTR_IDX(i - 2)] |=
 						    PTU_PTE_NEXT_TO_LAST;
 			}
-			hwq->level = PBL_LVL_2;
-		} else {
-			u32 flag = hwq_type == HWQ_TYPE_L2_CMPL ? 0 :
-						PTU_PTE_VALID;
+		} else { /* pages < 512 npbl = 1, npde = 0 */
+			u32 flag = (hwq_attr->type == HWQ_TYPE_L2_CMPL) ?
+				    0 : PTU_PTE_VALID;
 
 			/* 1 level of indirection */
-			rc = __alloc_pbl(pdev, &hwq->pbl[PBL_LVL_1], sghead,
-					 pages, maps, pg_size);
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			/* Alloc PBL page */
+			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
 			if (rc)
 				goto fail;
-			/* Fill in lvl0 PBL */
+			/* Alloc or init  PTEs */
+			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_1],
+					 hwq_attr->sginfo);
+			if (rc)
+				goto fail;
+			hwq->level = PBL_LVL_1;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBL with PTE pointers */
 			dst_virt_ptr =
 				(dma_addr_t **)hwq->pbl[PBL_LVL_0].pg_arr;
 			src_phys_ptr = hwq->pbl[PBL_LVL_1].pg_map_arr;
-			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++) {
+			for (i = 0; i < hwq->pbl[PBL_LVL_1].pg_count; i++)
 				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
 					src_phys_ptr[i] | flag;
-			}
-			if (hwq_type == HWQ_TYPE_QUEUE) {
+			if (hwq_attr->type == HWQ_TYPE_QUEUE) {
 				/* Find the last pg of the size */
 				i = hwq->pbl[PBL_LVL_1].pg_count;
 				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
@@ -276,42 +339,143 @@ int bnxt_qplib_alloc_init_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq,
 						    [PTR_IDX(i - 2)] |=
 						    PTU_PTE_NEXT_TO_LAST;
 			}
-			hwq->level = PBL_LVL_1;
 		}
 	}
-	hwq->pdev = pdev;
-	spin_lock_init(&hwq->lock);
+done:
 	hwq->prod = 0;
 	hwq->cons = 0;
-	*elements = hwq->max_elements = slots;
-	hwq->element_size = size;
-
+	hwq->pdev = pdev;
+	hwq->depth = hwq_attr->depth;
+	hwq->max_elements = depth;
+	hwq->element_size = stride;
 	/* For direct access to the elements */
-	hwq->pbl_ptr = hwq->pbl[hwq->level].pg_arr;
-	hwq->pbl_dma_ptr = hwq->pbl[hwq->level].pg_map_arr;
+	lvl = hwq->level;
+	if (hwq_attr->sginfo->nopte && hwq->level)
+		lvl = hwq->level - 1;
+	hwq->pbl_ptr = hwq->pbl[lvl].pg_arr;
+	hwq->pbl_dma_ptr = hwq->pbl[lvl].pg_map_arr;
+	spin_lock_init(&hwq->lock);
 
 	return 0;
-
 fail:
-	bnxt_qplib_free_hwq(pdev, hwq);
+	bnxt_qplib_free_hwq(res, hwq);
 	return -ENOMEM;
 }
 
 /* Context Tables */
-void bnxt_qplib_free_ctx(struct pci_dev *pdev,
+void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx)
 {
 	int i;
 
-	bnxt_qplib_free_hwq(pdev, &ctx->qpc_tbl);
-	bnxt_qplib_free_hwq(pdev, &ctx->mrw_tbl);
-	bnxt_qplib_free_hwq(pdev, &ctx->srqc_tbl);
-	bnxt_qplib_free_hwq(pdev, &ctx->cq_tbl);
-	bnxt_qplib_free_hwq(pdev, &ctx->tim_tbl);
+	bnxt_qplib_free_hwq(res, &ctx->qpc_tbl);
+	bnxt_qplib_free_hwq(res, &ctx->mrw_tbl);
+	bnxt_qplib_free_hwq(res, &ctx->srqc_tbl);
+	bnxt_qplib_free_hwq(res, &ctx->cq_tbl);
+	bnxt_qplib_free_hwq(res, &ctx->tim_tbl);
 	for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
-		bnxt_qplib_free_hwq(pdev, &ctx->tqm_tbl[i]);
-	bnxt_qplib_free_hwq(pdev, &ctx->tqm_pde);
-	bnxt_qplib_free_stats_ctx(pdev, &ctx->stats);
+		bnxt_qplib_free_hwq(res, &ctx->tqm_ctx.qtbl[i]);
+	/* restore original pde level before destroy */
+	ctx->tqm_ctx.pde.level = ctx->tqm_ctx.pde_level;
+	bnxt_qplib_free_hwq(res, &ctx->tqm_ctx.pde);
+	bnxt_qplib_free_stats_ctx(res->pdev, &ctx->stats);
+}
+
+static int bnxt_qplib_alloc_tqm_rings(struct bnxt_qplib_res *res,
+				      struct bnxt_qplib_ctx *ctx)
+{
+	struct bnxt_qplib_hwq_attr hwq_attr;
+	struct bnxt_qplib_sg_info sginfo;
+	struct bnxt_qplib_tqm_ctx *tqmctx;
+	int rc = 0;
+	int i;
+
+	tqmctx = &ctx->tqm_ctx;
+
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.res = res;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	hwq_attr.depth = 512;
+	hwq_attr.stride = sizeof(u64);
+	/* Alloc pdl buffer */
+	rc = bnxt_qplib_alloc_init_hwq(&tqmctx->pde, &hwq_attr);
+	if (rc)
+		goto out;
+	/* Save original pdl level */
+	tqmctx->pde_level = tqmctx->pde.level;
+
+	hwq_attr.stride = 1;
+	for (i = 0; i < MAX_TQM_ALLOC_REQ; i++) {
+		if (!tqmctx->qcount[i])
+			continue;
+		hwq_attr.depth = ctx->qpc_count * tqmctx->qcount[i];
+		rc = bnxt_qplib_alloc_init_hwq(&tqmctx->qtbl[i], &hwq_attr);
+		if (rc)
+			goto out;
+	}
+out:
+	return rc;
+}
+
+static void bnxt_qplib_map_tqm_pgtbl(struct bnxt_qplib_tqm_ctx *ctx)
+{
+	struct bnxt_qplib_hwq *tbl;
+	dma_addr_t *dma_ptr;
+	__le64 **pbl_ptr, *ptr;
+	int i, j, k;
+	int fnz_idx = -1;
+	int pg_count;
+
+	pbl_ptr = (__le64 **)ctx->pde.pbl_ptr;
+
+	for (i = 0, j = 0; i < MAX_TQM_ALLOC_REQ;
+	     i++, j += MAX_TQM_ALLOC_BLK_SIZE) {
+		tbl = &ctx->qtbl[i];
+		if (!tbl->max_elements)
+			continue;
+		if (fnz_idx == -1)
+			fnz_idx = i; /* first non-zero index */
+		switch (tbl->level) {
+		case PBL_LVL_2:
+			pg_count = tbl->pbl[PBL_LVL_1].pg_count;
+			for (k = 0; k < pg_count; k++) {
+				ptr = &pbl_ptr[PTR_PG(j + k)][PTR_IDX(j + k)];
+				dma_ptr = &tbl->pbl[PBL_LVL_1].pg_map_arr[k];
+				*ptr = cpu_to_le64(*dma_ptr | PTU_PTE_VALID);
+			}
+			break;
+		case PBL_LVL_1:
+		case PBL_LVL_0:
+		default:
+			ptr = &pbl_ptr[PTR_PG(j)][PTR_IDX(j)];
+			*ptr = cpu_to_le64(tbl->pbl[PBL_LVL_0].pg_map_arr[0] |
+					   PTU_PTE_VALID);
+			break;
+		}
+	}
+	if (fnz_idx == -1)
+		fnz_idx = 0;
+	/* update pde level as per page table programming */
+	ctx->pde.level = (ctx->qtbl[fnz_idx].level == PBL_LVL_2) ? PBL_LVL_2 :
+			  ctx->qtbl[fnz_idx].level + 1;
+}
+
+static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
+				      struct bnxt_qplib_ctx *ctx)
+{
+	int rc = 0;
+
+	rc = bnxt_qplib_alloc_tqm_rings(res, ctx);
+	if (rc)
+		goto fail;
+
+	bnxt_qplib_map_tqm_pgtbl(&ctx->tqm_ctx);
+fail:
+	return rc;
 }
 
 /*
@@ -335,120 +499,74 @@ void bnxt_qplib_free_ctx(struct pci_dev *pdev,
  * Returns:
  *     0 if success, else -ERRORS
  */
-int bnxt_qplib_alloc_ctx(struct pci_dev *pdev,
+int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5)
 {
-	int i, j, k, rc = 0;
-	int fnz_idx = -1;
-	__le64 **pbl_ptr;
+	struct bnxt_qplib_hwq_attr hwq_attr;
+	struct bnxt_qplib_sg_info sginfo;
+	int rc = 0;
 
 	if (virt_fn || is_p5)
 		goto stats_alloc;
 
 	/* QPC Tables */
-	ctx->qpc_tbl.max_elements = ctx->qpc_count;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->qpc_tbl, NULL,
-				       &ctx->qpc_tbl.max_elements,
-				       BNXT_QPLIB_MAX_QP_CTX_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_CTX);
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+	hwq_attr.sginfo = &sginfo;
+
+	hwq_attr.res = res;
+	hwq_attr.depth = ctx->qpc_count;
+	hwq_attr.stride = BNXT_QPLIB_MAX_QP_CTX_ENTRY_SIZE;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	rc = bnxt_qplib_alloc_init_hwq(&ctx->qpc_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
 
 	/* MRW Tables */
-	ctx->mrw_tbl.max_elements = ctx->mrw_count;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->mrw_tbl, NULL,
-				       &ctx->mrw_tbl.max_elements,
-				       BNXT_QPLIB_MAX_MRW_CTX_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_CTX);
+	hwq_attr.depth = ctx->mrw_count;
+	hwq_attr.stride = BNXT_QPLIB_MAX_MRW_CTX_ENTRY_SIZE;
+	rc = bnxt_qplib_alloc_init_hwq(&ctx->mrw_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
 
 	/* SRQ Tables */
-	ctx->srqc_tbl.max_elements = ctx->srqc_count;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->srqc_tbl, NULL,
-				       &ctx->srqc_tbl.max_elements,
-				       BNXT_QPLIB_MAX_SRQ_CTX_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_CTX);
+	hwq_attr.depth = ctx->srqc_count;
+	hwq_attr.stride = BNXT_QPLIB_MAX_SRQ_CTX_ENTRY_SIZE;
+	rc = bnxt_qplib_alloc_init_hwq(&ctx->srqc_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
 
 	/* CQ Tables */
-	ctx->cq_tbl.max_elements = ctx->cq_count;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->cq_tbl, NULL,
-				       &ctx->cq_tbl.max_elements,
-				       BNXT_QPLIB_MAX_CQ_CTX_ENTRY_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_CTX);
+	hwq_attr.depth = ctx->cq_count;
+	hwq_attr.stride = BNXT_QPLIB_MAX_CQ_CTX_ENTRY_SIZE;
+	rc = bnxt_qplib_alloc_init_hwq(&ctx->cq_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
 
 	/* TQM Buffer */
-	ctx->tqm_pde.max_elements = 512;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->tqm_pde, NULL,
-				       &ctx->tqm_pde.max_elements, sizeof(u64),
-				       0, PAGE_SIZE, HWQ_TYPE_CTX);
+	rc = bnxt_qplib_setup_tqm_rings(res, ctx);
 	if (rc)
 		goto fail;
-
-	for (i = 0; i < MAX_TQM_ALLOC_REQ; i++) {
-		if (!ctx->tqm_count[i])
-			continue;
-		ctx->tqm_tbl[i].max_elements = ctx->qpc_count *
-					       ctx->tqm_count[i];
-		rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->tqm_tbl[i], NULL,
-					       &ctx->tqm_tbl[i].max_elements, 1,
-					       0, PAGE_SIZE, HWQ_TYPE_CTX);
-		if (rc)
-			goto fail;
-	}
-	pbl_ptr = (__le64 **)ctx->tqm_pde.pbl_ptr;
-	for (i = 0, j = 0; i < MAX_TQM_ALLOC_REQ;
-	     i++, j += MAX_TQM_ALLOC_BLK_SIZE) {
-		if (!ctx->tqm_tbl[i].max_elements)
-			continue;
-		if (fnz_idx == -1)
-			fnz_idx = i;
-		switch (ctx->tqm_tbl[i].level) {
-		case PBL_LVL_2:
-			for (k = 0; k < ctx->tqm_tbl[i].pbl[PBL_LVL_1].pg_count;
-			     k++)
-				pbl_ptr[PTR_PG(j + k)][PTR_IDX(j + k)] =
-				  cpu_to_le64(
-				    ctx->tqm_tbl[i].pbl[PBL_LVL_1].pg_map_arr[k]
-				    | PTU_PTE_VALID);
-			break;
-		case PBL_LVL_1:
-		case PBL_LVL_0:
-		default:
-			pbl_ptr[PTR_PG(j)][PTR_IDX(j)] = cpu_to_le64(
-				ctx->tqm_tbl[i].pbl[PBL_LVL_0].pg_map_arr[0] |
-				PTU_PTE_VALID);
-			break;
-		}
-	}
-	if (fnz_idx == -1)
-		fnz_idx = 0;
-	ctx->tqm_pde_level = ctx->tqm_tbl[fnz_idx].level == PBL_LVL_2 ?
-			     PBL_LVL_2 : ctx->tqm_tbl[fnz_idx].level + 1;
-
 	/* TIM Buffer */
 	ctx->tim_tbl.max_elements = ctx->qpc_count * 16;
-	rc = bnxt_qplib_alloc_init_hwq(pdev, &ctx->tim_tbl, NULL,
-				       &ctx->tim_tbl.max_elements, 1,
-				       0, PAGE_SIZE, HWQ_TYPE_CTX);
+	hwq_attr.depth = ctx->qpc_count * 16;
+	hwq_attr.stride = 1;
+	rc = bnxt_qplib_alloc_init_hwq(&ctx->tim_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
-
 stats_alloc:
 	/* Stats */
-	rc = bnxt_qplib_alloc_stats_ctx(pdev, &ctx->stats);
+	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, &ctx->stats);
 	if (rc)
 		goto fail;
 
 	return 0;
 
 fail:
-	bnxt_qplib_free_ctx(pdev, ctx);
+	bnxt_qplib_free_ctx(res, ctx);
 	return rc;
 }
 
@@ -808,9 +926,6 @@ void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 	bnxt_qplib_free_sgid_tbl(res, &res->sgid_tbl);
 	bnxt_qplib_free_pd_tbl(&res->pd_tbl);
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
-
-	res->netdev = NULL;
-	res->pdev = NULL;
 }
 
 int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index aaa76d7..fe8a6dd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -55,7 +55,8 @@
 enum bnxt_qplib_hwq_type {
 	HWQ_TYPE_CTX,
 	HWQ_TYPE_QUEUE,
-	HWQ_TYPE_L2_CMPL
+	HWQ_TYPE_L2_CMPL,
+	HWQ_TYPE_MR
 };
 
 #define MAX_PBL_LVL_0_PGS		1
@@ -63,6 +64,7 @@ enum bnxt_qplib_hwq_type {
 #define MAX_PBL_LVL_1_PGS_SHIFT		9
 #define MAX_PBL_LVL_1_PGS_FOR_LVL_2	256
 #define MAX_PBL_LVL_2_PGS		(256 * 512)
+#define MAX_PDL_LVL_SHIFT               9
 
 enum bnxt_qplib_pbl_lvl {
 	PBL_LVL_0,
@@ -85,17 +87,37 @@ struct bnxt_qplib_pbl {
 	dma_addr_t			*pg_map_arr;
 };
 
+struct bnxt_qplib_sg_info {
+	struct scatterlist		*sghead;
+	u32				nmap;
+	u32				npages;
+	u32				pgshft;
+	u32				pgsize;
+	bool				nopte;
+};
+
+struct bnxt_qplib_hwq_attr {
+	struct bnxt_qplib_res		*res;
+	struct bnxt_qplib_sg_info	*sginfo;
+	enum bnxt_qplib_hwq_type	type;
+	u32				depth;
+	u32				stride;
+	u32				aux_stride;
+	u32				aux_depth;
+};
+
 struct bnxt_qplib_hwq {
 	struct pci_dev			*pdev;
 	/* lock to protect qplib_hwq */
 	spinlock_t			lock;
-	struct bnxt_qplib_pbl		pbl[PBL_LVL_MAX];
+	struct bnxt_qplib_pbl		pbl[PBL_LVL_MAX + 1];
 	enum bnxt_qplib_pbl_lvl		level;		/* 0, 1, or 2 */
 	/* ptr for easy access to the PBL entries */
 	void				**pbl_ptr;
 	/* ptr for easy access to the dma_addr */
 	dma_addr_t			*pbl_dma_ptr;
 	u32				max_elements;
+	u32				depth;
 	u16				element_size;	/* Size of each entry */
 
 	u32				prod;		/* raw */
@@ -159,6 +181,15 @@ struct bnxt_qplib_vf_res {
 #define BNXT_QPLIB_MAX_CQ_CTX_ENTRY_SIZE	64
 #define BNXT_QPLIB_MAX_MRW_CTX_ENTRY_SIZE	128
 
+#define MAX_TQM_ALLOC_REQ               48
+#define MAX_TQM_ALLOC_BLK_SIZE          8
+struct bnxt_qplib_tqm_ctx {
+	struct bnxt_qplib_hwq           pde;
+	u8                              pde_level; /* Original level */
+	struct bnxt_qplib_hwq           qtbl[MAX_TQM_ALLOC_REQ];
+	u8                              qcount[MAX_TQM_ALLOC_REQ];
+};
+
 struct bnxt_qplib_ctx {
 	u32				qpc_count;
 	struct bnxt_qplib_hwq		qpc_tbl;
@@ -169,12 +200,7 @@ struct bnxt_qplib_ctx {
 	u32				cq_count;
 	struct bnxt_qplib_hwq		cq_tbl;
 	struct bnxt_qplib_hwq		tim_tbl;
-#define MAX_TQM_ALLOC_REQ		48
-#define MAX_TQM_ALLOC_BLK_SIZE		8
-	u8				tqm_count[MAX_TQM_ALLOC_REQ];
-	struct bnxt_qplib_hwq		tqm_pde;
-	u32				tqm_pde_level;
-	struct bnxt_qplib_hwq		tqm_tbl[MAX_TQM_ALLOC_REQ];
+	struct bnxt_qplib_tqm_ctx	tqm_ctx;
 	struct bnxt_qplib_stats		stats;
 	struct bnxt_qplib_vf_res	vf_res;
 	u64				hwrm_intf_ver;
@@ -223,11 +249,6 @@ static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
 
-struct bnxt_qplib_sg_info {
-	struct scatterlist		*sglist;
-	u32				nmap;
-	u32				npages;
-};
 
 #define to_bnxt_qplib(ptr, type, member)	\
 	container_of(ptr, type, member)
@@ -235,11 +256,10 @@ struct bnxt_qplib_sg_info {
 struct bnxt_qplib_pd;
 struct bnxt_qplib_dev_attr;
 
-void bnxt_qplib_free_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq);
-int bnxt_qplib_alloc_init_hwq(struct pci_dev *pdev, struct bnxt_qplib_hwq *hwq,
-			      struct bnxt_qplib_sg_info *sg_info, u32 *elements,
-			      u32 elements_per_page, u32 aux, u32 pg_size,
-			      enum bnxt_qplib_hwq_type hwq_type);
+void bnxt_qplib_free_hwq(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_hwq *hwq);
+int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
+			      struct bnxt_qplib_hwq_attr *hwq_attr);
 void bnxt_qplib_get_guid(u8 *dev_addr, u8 *guid);
 int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pd_tbl,
 			struct bnxt_qplib_pd *pd);
@@ -258,9 +278,9 @@ int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 			 struct net_device *netdev,
 			 struct bnxt_qplib_dev_attr *dev_attr);
-void bnxt_qplib_free_ctx(struct pci_dev *pdev,
+void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx);
-int bnxt_qplib_alloc_ctx(struct pci_dev *pdev,
+int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5);
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 40296b9..a5d4cb9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -585,7 +585,7 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 
 	/* Free the qplib's MRW memory */
 	if (mrw->hwq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &mrw->hwq);
+		bnxt_qplib_free_hwq(res, &mrw->hwq);
 
 	return 0;
 }
@@ -646,7 +646,7 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 	if (mrw->hwq.max_elements) {
 		mrw->va = 0;
 		mrw->total_size = 0;
-		bnxt_qplib_free_hwq(res->pdev, &mrw->hwq);
+		bnxt_qplib_free_hwq(res, &mrw->hwq);
 	}
 
 	return 0;
@@ -656,13 +656,17 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		      u64 *pbl_tbl, int num_pbls, bool block, u32 buf_pg_size)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_register_mr req;
+	struct bnxt_qplib_hwq_attr hwq_attr;
 	struct creq_register_mr_resp resp;
-	u16 cmd_flags = 0, level;
+	struct bnxt_qplib_sg_info sginfo;
+	struct cmdq_register_mr req;
 	int pg_ptrs, pages, i, rc;
+	u16 cmd_flags = 0, level;
 	dma_addr_t **pbl_ptr;
 	u32 pg_size;
 
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	memset(&sginfo, 0, sizeof(sginfo));
 	if (num_pbls) {
 		/* Allocate memory for the non-leaf pages to store buf ptrs.
 		 * Non-leaf pages always uses system PAGE_SIZE
@@ -674,20 +678,23 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 
 		if (pages > MAX_PBL_LVL_1_PGS) {
 			dev_err(&res->pdev->dev,
-				"SP: Reg MR pages requested (0x%x) exceeded max (0x%x)\n",
+				"SP: Reg MR: pages requested (0x%x) exceeded max (0x%x)\n",
 				pages, MAX_PBL_LVL_1_PGS);
 			return -ENOMEM;
 		}
 		/* Free the hwq if it already exist, must be a rereg */
 		if (mr->hwq.max_elements)
-			bnxt_qplib_free_hwq(res->pdev, &mr->hwq);
-
-		mr->hwq.max_elements = pages;
+			bnxt_qplib_free_hwq(res, &mr->hwq);
 		/* Use system PAGE_SIZE */
-		rc = bnxt_qplib_alloc_init_hwq(res->pdev, &mr->hwq, NULL,
-					       &mr->hwq.max_elements,
-					       PAGE_SIZE, 0, PAGE_SIZE,
-					       HWQ_TYPE_CTX);
+		hwq_attr.res = res;
+		hwq_attr.depth = pages;
+		hwq_attr.stride = PAGE_SIZE;
+		hwq_attr.type = HWQ_TYPE_MR;
+		hwq_attr.sginfo = &sginfo;
+		hwq_attr.sginfo->npages = pages;
+		hwq_attr.sginfo->pgsize = PAGE_SIZE;
+		hwq_attr.sginfo->pgshft = PAGE_SHIFT;
+		rc = bnxt_qplib_alloc_init_hwq(&mr->hwq, &hwq_attr);
 		if (rc) {
 			dev_err(&res->pdev->dev,
 				"SP: Reg MR memory allocation failed\n");
@@ -734,7 +741,7 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 
 fail:
 	if (mr->hwq.max_elements)
-		bnxt_qplib_free_hwq(res->pdev, &mr->hwq);
+		bnxt_qplib_free_hwq(res, &mr->hwq);
 	return rc;
 }
 
@@ -742,6 +749,8 @@ int bnxt_qplib_alloc_fast_reg_page_list(struct bnxt_qplib_res *res,
 					struct bnxt_qplib_frpl *frpl,
 					int max_pg_ptrs)
 {
+	struct bnxt_qplib_hwq_attr hwq_attr;
+	struct bnxt_qplib_sg_info sginfo;
 	int pg_ptrs, pages, rc;
 
 	/* Re-calculate the max to fit the HWQ allocation model */
@@ -753,10 +762,17 @@ int bnxt_qplib_alloc_fast_reg_page_list(struct bnxt_qplib_res *res,
 	if (pages > MAX_PBL_LVL_1_PGS)
 		return -ENOMEM;
 
-	frpl->hwq.max_elements = pages;
-	rc = bnxt_qplib_alloc_init_hwq(res->pdev, &frpl->hwq, NULL,
-				       &frpl->hwq.max_elements, PAGE_SIZE, 0,
-				       PAGE_SIZE, HWQ_TYPE_CTX);
+	memset(&sginfo, 0, sizeof(sginfo));
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.nopte = true;
+
+	memset(&hwq_attr, 0, sizeof(hwq_attr));
+	hwq_attr.res = res;
+	hwq_attr.depth = pg_ptrs;
+	hwq_attr.stride = PAGE_SIZE;
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.type = HWQ_TYPE_CTX;
+	rc = bnxt_qplib_alloc_init_hwq(&frpl->hwq, &hwq_attr);
 	if (!rc)
 		frpl->max_pg_ptrs = pg_ptrs;
 
@@ -766,7 +782,7 @@ int bnxt_qplib_alloc_fast_reg_page_list(struct bnxt_qplib_res *res,
 int bnxt_qplib_free_fast_reg_page_list(struct bnxt_qplib_res *res,
 				       struct bnxt_qplib_frpl *frpl)
 {
-	bnxt_qplib_free_hwq(res->pdev, &frpl->hwq);
+	bnxt_qplib_free_hwq(res, &frpl->hwq);
 	return 0;
 }
 
-- 
1.8.3.1

