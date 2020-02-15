Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC48D15FF70
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBORLl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 12:11:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55700 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgBORLl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Feb 2020 12:11:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so5352783pjz.5
        for <linux-rdma@vger.kernel.org>; Sat, 15 Feb 2020 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8p19iQhAqwCpTWczrbSADjW9PeuV+d4FvU2lbvSaj6M=;
        b=Kf5aViGY5nn7X4j37lcQ4asDeS/rN60F4TO5uDFXgkDh17/ZhWSC8DtKj0x2d+JJWO
         9lVqeFld84vOzqCOyR7nZwo1mjkKUeYAcfj+XOaqEW/J+GjEwYXoF4+wAB04NqIrJY9J
         fR7R7J3CiC3uVISVMkUeVOyKAzr1ezZBDd30s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8p19iQhAqwCpTWczrbSADjW9PeuV+d4FvU2lbvSaj6M=;
        b=mMA+QZNERunoFunpi0XKcguvEK64AbjSsfLrwZE2na+q5MpLfLKUMVsLRsZmM7sEgq
         mLroaTwnJ5g3/U/fDSs9HaK2jyTRTYgndqnkgWebiVG5KTJSVJRd23wACzk1qQZHuD1z
         nGsUIP5SeNyscXtgwYzKXD29SU20ZIGtSy7d5HF0u3WFjL7aIJR5eLRrbN7R2mr31S/I
         POlCYhHgyolZHSUZJgOnKYIdCTnSpWf0ggXmPDz2xorR9Z6lE4H7j6HoWGOblxnkAf2o
         dAfhPVoghw7uV50crmaTw+mB3RCTceWBGB8A1cAHrNVwnpqnSnrFFREq5B0RxnVwlMZ+
         +B5w==
X-Gm-Message-State: APjAAAXLhMIC1smTzSPS4UIAOmAo2wbSYRBRDMVyIe8WoUoWDONgzHso
        9aKoNuvtMyO0i6i6sq3eb9CcrzMMEJYgj7UXUFENBpqB69JLXBqub6fuqrh7itV+1tPRXigUPuh
        e0tfVjBREwFmhKvaQ5vbr+AAXU6SPuLiD/2AuFOa6sW7OiGiKXK8R1wL5FKFQaWJmgfpecFIj2r
        8Go90=
X-Google-Smtp-Source: APXvYqw4dVzP3KyrzoLLhumK7nrqasXdMWJa5ZMG//MPO2zKxfSyn2BgJFq+f0tsWp45pI8mCza2qQ==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr8942588plo.327.1581786697250;
        Sat, 15 Feb 2020 09:11:37 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r198sm11755664pfr.54.2020.02.15.09.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2020 09:11:36 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH V3 for-next 8/8] RDMA/bnxt_re: use ibdev based message printing functions
Date:   Sat, 15 Feb 2020 12:11:05 -0500
Message-Id: <1581786665-23705-9-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
References: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replacing the dev_err/dbg/warn with ibdev_err/dbg/warn. In
the IB device provider driver these functions are recommended
to use.
Currently qplib layer function calls has not been replaced due
to unavailability of ib_device pointer at that layer.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 280 +++++++++++++++----------------
 drivers/infiniband/hw/bnxt_re/main.c     | 131 ++++++++-------
 2 files changed, 208 insertions(+), 203 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 83af9cc..85c4baa 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -313,8 +313,8 @@ int bnxt_re_del_gid(const struct ib_gid_attr *attr, void **context)
 		if (ctx->idx == 0 &&
 		    rdma_link_local_addr((struct in6_addr *)gid_to_del) &&
 		    ctx->refcnt == 1 && rdev->gsi_ctx.gsi_sqp) {
-			dev_dbg(rdev_to_dev(rdev),
-				"Trying to delete GID0 while QP1 is alive\n");
+			ibdev_dbg(&rdev->ibdev,
+				  "Trying to delete GID0 while QP1 is alive\n");
 			return -EFAULT;
 		}
 		ctx->refcnt--;
@@ -322,8 +322,8 @@ int bnxt_re_del_gid(const struct ib_gid_attr *attr, void **context)
 			rc = bnxt_qplib_del_sgid(sgid_tbl, gid_to_del,
 						 vlan_id,  true);
 			if (rc) {
-				dev_err(rdev_to_dev(rdev),
-					"Failed to remove GID: %#x", rc);
+				ibdev_err(&rdev->ibdev,
+					  "Failed to remove GID: %#x", rc);
 			} else {
 				ctx_tbl = sgid_tbl->ctx;
 				ctx_tbl[ctx->idx] = NULL;
@@ -360,7 +360,7 @@ int bnxt_re_add_gid(const struct ib_gid_attr *attr, void **context)
 	}
 
 	if (rc < 0) {
-		dev_err(rdev_to_dev(rdev), "Failed to add GID: %#x", rc);
+		ibdev_err(&rdev->ibdev, "Failed to add GID: %#x", rc);
 		return rc;
 	}
 
@@ -423,12 +423,12 @@ static int bnxt_re_bind_fence_mw(struct bnxt_qplib_qp *qplib_qp)
 	wqe.bind.r_key = fence->bind_rkey;
 	fence->bind_rkey = ib_inc_rkey(fence->bind_rkey);
 
-	dev_dbg(rdev_to_dev(qp->rdev),
-		"Posting bind fence-WQE: rkey: %#x QP: %d PD: %p\n",
+	ibdev_dbg(&qp->rdev->ibdev,
+		  "Posting bind fence-WQE: rkey: %#x QP: %d PD: %p\n",
 		wqe.bind.r_key, qp->qplib_qp.id, pd);
 	rc = bnxt_qplib_post_send(&qp->qplib_qp, &wqe);
 	if (rc) {
-		dev_err(rdev_to_dev(qp->rdev), "Failed to bind fence-WQE\n");
+		ibdev_err(&qp->rdev->ibdev, "Failed to bind fence-WQE\n");
 		return rc;
 	}
 	bnxt_qplib_post_send_db(&qp->qplib_qp);
@@ -479,7 +479,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 				  DMA_BIDIRECTIONAL);
 	rc = dma_mapping_error(dev, dma_addr);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to dma-map fence-MR-mem\n");
+		ibdev_err(&rdev->ibdev, "Failed to dma-map fence-MR-mem\n");
 		rc = -EIO;
 		fence->dma_addr = 0;
 		goto fail;
@@ -499,7 +499,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.flags = __from_ib_access_flags(mr_access_flags);
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to alloc fence-HW-MR\n");
+		ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
 		goto fail;
 	}
 
@@ -511,7 +511,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, &pbl_tbl,
 			       BNXT_RE_FENCE_PBL_SIZE, false, PAGE_SIZE);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to register fence-MR\n");
+		ibdev_err(&rdev->ibdev, "Failed to register fence-MR\n");
 		goto fail;
 	}
 	mr->ib_mr.rkey = mr->qplib_mr.rkey;
@@ -519,8 +519,8 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	/* Create a fence MW only for kernel consumers */
 	mw = bnxt_re_alloc_mw(&pd->ib_pd, IB_MW_TYPE_1, NULL);
 	if (IS_ERR(mw)) {
-		dev_err(rdev_to_dev(rdev),
-			"Failed to create fence-MW for PD: %p\n", pd);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to create fence-MW for PD: %p\n", pd);
 		rc = PTR_ERR(mw);
 		goto fail;
 	}
@@ -558,7 +558,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	pd->rdev = rdev;
 	if (bnxt_qplib_alloc_pd(&rdev->qplib_res.pd_tbl, &pd->qplib_pd)) {
-		dev_err(rdev_to_dev(rdev), "Failed to allocate HW PD");
+		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
 		rc = -ENOMEM;
 		goto fail;
 	}
@@ -585,16 +585,16 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to copy user response\n");
+			ibdev_err(&rdev->ibdev,
+				  "Failed to copy user response\n");
 			goto dbfail;
 		}
 	}
 
 	if (!udata)
 		if (bnxt_re_create_fence_mr(pd))
-			dev_warn(rdev_to_dev(rdev),
-				 "Failed to create Fence-MR\n");
+			ibdev_warn(&rdev->ibdev,
+				   "Failed to create Fence-MR\n");
 	return 0;
 dbfail:
 	bnxt_qplib_dealloc_pd(&rdev->qplib_res, &rdev->qplib_res.pd_tbl,
@@ -644,7 +644,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	int rc;
 
 	if (!(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH)) {
-		dev_err(rdev_to_dev(rdev), "Failed to alloc AH: GRH not set");
+		ibdev_err(&rdev->ibdev, "Failed to alloc AH: GRH not set");
 		return -EINVAL;
 	}
 
@@ -675,7 +675,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr,
 	rc = bnxt_qplib_create_ah(&rdev->qplib_res, &ah->qplib_ah,
 				  !(flags & RDMA_CREATE_AH_SLEEPABLE));
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to allocate HW AH");
+		ibdev_err(&rdev->ibdev, "Failed to allocate HW AH");
 		return rc;
 	}
 
@@ -759,16 +759,16 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	mutex_unlock(&rdev->qp_lock);
 	atomic_dec(&rdev->qp_count);
 
-	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
+	ibdev_dbg(&rdev->ibdev, "Destroy the shadow AH\n");
 	bnxt_qplib_destroy_ah(&rdev->qplib_res,
 			      &gsi_sah->qplib_ah,
 			      true);
 	bnxt_qplib_clean_qp(&qp->qplib_qp);
 
-	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
+	ibdev_dbg(&rdev->ibdev, "Destroy the shadow QP\n");
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
+		ibdev_err(&rdev->ibdev, "Destroy Shadow QP failed");
 		goto fail;
 	}
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
@@ -802,7 +802,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to destroy HW QP");
+		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
 		return rc;
 	}
 
@@ -938,8 +938,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 
 	rc = bnxt_qplib_create_ah(&rdev->qplib_res, &ah->qplib_ah, false);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev),
-			"Failed to allocate HW AH for Shadow QP");
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate HW AH for Shadow QP");
 		goto fail;
 	}
 
@@ -1032,7 +1032,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 
 		srq = container_of(init_attr->srq, struct bnxt_re_srq, ib_srq);
 		if (!srq) {
-			dev_err(rdev_to_dev(rdev), "SRQ not found");
+			ibdev_err(&rdev->ibdev, "SRQ not found");
 			return -EINVAL;
 		}
 		qplqp->srq = &srq->qplib_srq;
@@ -1140,8 +1140,7 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 
 	qptype = __from_ib_qp_type(init_attr->qp_type);
 	if (qptype == IB_QPT_MAX) {
-		dev_err(rdev_to_dev(rdev), "QP type 0x%x not supported",
-			qptype);
+		ibdev_err(&rdev->ibdev, "QP type 0x%x not supported", qptype);
 		qptype = -EINVAL;
 		goto out;
 	}
@@ -1188,15 +1187,15 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	qplqp->mtu = ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
 	qplqp->dpi = &rdev->dpi_privileged; /* Doorbell page */
 	if (init_attr->create_flags)
-		dev_dbg(rdev_to_dev(rdev),
-			"QP create flags 0x%x not supported",
-			init_attr->create_flags);
+		ibdev_dbg(&rdev->ibdev,
+			  "QP create flags 0x%x not supported",
+			  init_attr->create_flags);
 
 	/* Setup CQs */
 	if (init_attr->send_cq) {
 		cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
 		if (!cq) {
-			dev_err(rdev_to_dev(rdev), "Send CQ not found");
+			ibdev_err(&rdev->ibdev, "Send CQ not found");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -1207,7 +1206,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	if (init_attr->recv_cq) {
 		cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
 		if (!cq) {
-			dev_err(rdev_to_dev(rdev), "Receive CQ not found");
+			ibdev_err(&rdev->ibdev, "Receive CQ not found");
 			rc = -EINVAL;
 			goto out;
 		}
@@ -1253,8 +1252,7 @@ static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
 	sqp = bnxt_re_create_shadow_qp(pd, &rdev->qplib_res, &qp->qplib_qp);
 	if (!sqp) {
 		rc = -ENODEV;
-		dev_err(rdev_to_dev(rdev),
-			"Failed to create Shadow QP for QP1");
+		ibdev_err(&rdev->ibdev, "Failed to create Shadow QP for QP1");
 		goto out;
 	}
 	rdev->gsi_ctx.gsi_sqp = sqp;
@@ -1267,8 +1265,8 @@ static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
 		bnxt_qplib_destroy_qp(&rdev->qplib_res,
 				      &sqp->qplib_qp);
 		rc = -ENODEV;
-		dev_err(rdev_to_dev(rdev),
-			"Failed to create AH entry for ShadowQP");
+		ibdev_err(&rdev->ibdev,
+			  "Failed to create AH entry for ShadowQP");
 		goto out;
 	}
 	rdev->gsi_ctx.gsi_sah = sah;
@@ -1296,7 +1294,7 @@ static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rc = bnxt_qplib_create_qp1(&rdev->qplib_res, qplqp);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "create HW QP1 failed!");
+		ibdev_err(&rdev->ibdev, "create HW QP1 failed!");
 		goto out;
 	}
 
@@ -1316,14 +1314,14 @@ static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
 	    init_attr->cap.max_send_sge > dev_attr->max_qp_sges ||
 	    init_attr->cap.max_recv_sge > dev_attr->max_qp_sges ||
 	    init_attr->cap.max_inline_data > dev_attr->max_inline_data) {
-		dev_err(rdev_to_dev(rdev),
-			"Create QP failed - max exceeded! 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x",
-			init_attr->cap.max_send_wr, dev_attr->max_qp_wqes,
-			init_attr->cap.max_recv_wr, dev_attr->max_qp_wqes,
-			init_attr->cap.max_send_sge, dev_attr->max_qp_sges,
-			init_attr->cap.max_recv_sge, dev_attr->max_qp_sges,
-			init_attr->cap.max_inline_data,
-			dev_attr->max_inline_data);
+		ibdev_err(&rdev->ibdev,
+			  "Create QP failed - max exceeded! 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x",
+			  init_attr->cap.max_send_wr, dev_attr->max_qp_wqes,
+			  init_attr->cap.max_recv_wr, dev_attr->max_qp_wqes,
+			  init_attr->cap.max_send_sge, dev_attr->max_qp_sges,
+			  init_attr->cap.max_recv_sge, dev_attr->max_qp_sges,
+			  init_attr->cap.max_inline_data,
+			  dev_attr->max_inline_data);
 		rc = false;
 	}
 	return rc;
@@ -1365,7 +1363,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 	} else {
 		rc = bnxt_qplib_create_qp(&rdev->qplib_res, &qp->qplib_qp);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Failed to create HW QP");
+			ibdev_err(&rdev->ibdev, "Failed to create HW QP");
 			goto free_umem;
 		}
 		if (udata) {
@@ -1375,7 +1373,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 			resp.rsvd = 0;
 			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 			if (rc) {
-				dev_err(rdev_to_dev(rdev), "Failed to copy QP udata");
+				ibdev_err(&rdev->ibdev, "Failed to copy QP udata");
 				goto qp_destroy;
 			}
 		}
@@ -1548,7 +1546,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	int rc, entries;
 
 	if (srq_init_attr->attr.max_wr >= dev_attr->max_srq_wqes) {
-		dev_err(rdev_to_dev(rdev), "Create CQ failed - max exceeded");
+		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded");
 		rc = -EINVAL;
 		goto exit;
 	}
@@ -1583,7 +1581,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 	rc = bnxt_qplib_create_srq(&rdev->qplib_res, &srq->qplib_srq);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Create HW SRQ failed!");
+		ibdev_err(&rdev->ibdev, "Create HW SRQ failed!");
 		goto fail;
 	}
 
@@ -1593,7 +1591,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		resp.srqid = srq->qplib_srq.id;
 		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 		if (rc) {
-			dev_err(rdev_to_dev(rdev), "SRQ copy to udata failed!");
+			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
 					       &srq->qplib_srq);
 			goto fail;
@@ -1632,7 +1630,7 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		srq->qplib_srq.threshold = srq_attr->srq_limit;
 		rc = bnxt_qplib_modify_srq(&rdev->qplib_res, &srq->qplib_srq);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Modify HW SRQ failed!");
+			ibdev_err(&rdev->ibdev, "Modify HW SRQ failed!");
 			return rc;
 		}
 		/* On success, update the shadow */
@@ -1640,8 +1638,8 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 		/* No need to Build and send response back to udata */
 		break;
 	default:
-		dev_err(rdev_to_dev(rdev),
-			"Unsupported srq_attr_mask 0x%x", srq_attr_mask);
+		ibdev_err(&rdev->ibdev,
+			  "Unsupported srq_attr_mask 0x%x", srq_attr_mask);
 		return -EINVAL;
 	}
 	return 0;
@@ -1659,7 +1657,7 @@ int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr)
 	tsrq.qplib_srq.id = srq->qplib_srq.id;
 	rc = bnxt_qplib_query_srq(&rdev->qplib_res, &tsrq.qplib_srq);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Query HW SRQ failed!");
+		ibdev_err(&rdev->ibdev, "Query HW SRQ failed!");
 		return rc;
 	}
 	srq_attr->max_wr = srq->qplib_srq.max_wqe;
@@ -1725,8 +1723,7 @@ static int bnxt_re_modify_shadow_qp(struct bnxt_re_dev *rdev,
 
 	rc = bnxt_qplib_modify_qp(&rdev->qplib_res, &qp->qplib_qp);
 	if (rc)
-		dev_err(rdev_to_dev(rdev),
-			"Failed to modify Shadow QP for QP1");
+		ibdev_err(&rdev->ibdev, "Failed to modify Shadow QP for QP1");
 	return rc;
 }
 
@@ -1747,15 +1744,15 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		new_qp_state = qp_attr->qp_state;
 		if (!ib_modify_qp_is_ok(curr_qp_state, new_qp_state,
 					ib_qp->qp_type, qp_attr_mask)) {
-			dev_err(rdev_to_dev(rdev),
-				"Invalid attribute mask: %#x specified ",
-				qp_attr_mask);
-			dev_err(rdev_to_dev(rdev),
-				"for qpn: %#x type: %#x",
-				ib_qp->qp_num, ib_qp->qp_type);
-			dev_err(rdev_to_dev(rdev),
-				"curr_qp_state=0x%x, new_qp_state=0x%x\n",
-				curr_qp_state, new_qp_state);
+			ibdev_err(&rdev->ibdev,
+				  "Invalid attribute mask: %#x specified ",
+				  qp_attr_mask);
+			ibdev_err(&rdev->ibdev,
+				  "for qpn: %#x type: %#x",
+				  ib_qp->qp_num, ib_qp->qp_type);
+			ibdev_err(&rdev->ibdev,
+				  "curr_qp_state=0x%x, new_qp_state=0x%x\n",
+				  curr_qp_state, new_qp_state);
 			return -EINVAL;
 		}
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_STATE;
@@ -1763,18 +1760,16 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 
 		if (!qp->sumem &&
 		    qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
-			dev_dbg(rdev_to_dev(rdev),
-				"Move QP = %p to flush list\n",
-				qp);
+			ibdev_dbg(&rdev->ibdev,
+				  "Move QP = %p to flush list\n", qp);
 			flags = bnxt_re_lock_cqs(qp);
 			bnxt_qplib_add_flush_qp(&qp->qplib_qp);
 			bnxt_re_unlock_cqs(qp, flags);
 		}
 		if (!qp->sumem &&
 		    qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_RESET) {
-			dev_dbg(rdev_to_dev(rdev),
-				"Move QP = %p out of flush list\n",
-				qp);
+			ibdev_dbg(&rdev->ibdev,
+				  "Move QP = %p out of flush list\n", qp);
 			flags = bnxt_re_lock_cqs(qp);
 			bnxt_qplib_clean_qp(&qp->qplib_qp);
 			bnxt_re_unlock_cqs(qp, flags);
@@ -1904,10 +1899,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	if (qp_attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) {
 		if (qp_attr->max_dest_rd_atomic >
 		    dev_attr->max_qp_init_rd_atom) {
-			dev_err(rdev_to_dev(rdev),
-				"max_dest_rd_atomic requested%d is > dev_max%d",
-				qp_attr->max_dest_rd_atomic,
-				dev_attr->max_qp_init_rd_atom);
+			ibdev_err(&rdev->ibdev,
+				  "max_dest_rd_atomic requested%d is > dev_max%d",
+				  qp_attr->max_dest_rd_atomic,
+				  dev_attr->max_qp_init_rd_atom);
 			return -EINVAL;
 		}
 
@@ -1928,8 +1923,8 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		    (qp_attr->cap.max_recv_sge >= dev_attr->max_qp_sges) ||
 		    (qp_attr->cap.max_inline_data >=
 						dev_attr->max_inline_data)) {
-			dev_err(rdev_to_dev(rdev),
-				"Create QP failed - max exceeded");
+			ibdev_err(&rdev->ibdev,
+				  "Create QP failed - max exceeded");
 			return -EINVAL;
 		}
 		entries = roundup_pow_of_two(qp_attr->cap.max_send_wr);
@@ -1962,7 +1957,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	}
 	rc = bnxt_qplib_modify_qp(&rdev->qplib_res, &qp->qplib_qp);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to modify HW QP");
+		ibdev_err(&rdev->ibdev, "Failed to modify HW QP");
 		return rc;
 	}
 	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp)
@@ -1987,7 +1982,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 
 	rc = bnxt_qplib_query_qp(&rdev->qplib_res, qplib_qp);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to query HW QP");
+		ibdev_err(&rdev->ibdev, "Failed to query HW QP");
 		goto out;
 	}
 	qp_attr->qp_state = __to_ib_qp_state(qplib_qp->state);
@@ -2192,7 +2187,7 @@ static int bnxt_re_build_qp1_send_v2(struct bnxt_re_qp *qp,
 		wqe->num_sge++;
 
 	} else {
-		dev_err(rdev_to_dev(qp->rdev), "QP1 buffer is empty!");
+		ibdev_err(&qp->rdev->ibdev, "QP1 buffer is empty!");
 		rc = -ENOMEM;
 	}
 	return rc;
@@ -2428,8 +2423,8 @@ static int bnxt_re_copy_inline_data(struct bnxt_re_dev *rdev,
 
 		if ((sge_len + wqe->inline_len) >
 		    BNXT_QPLIB_SWQE_MAX_INLINE_LENGTH) {
-			dev_err(rdev_to_dev(rdev),
-				"Inline data size requested > supported value");
+			ibdev_err(&rdev->ibdev,
+				  "Inline data size requested > supported value");
 			return -EINVAL;
 		}
 		sge_len = wr->sg_list[i].length;
@@ -2489,8 +2484,8 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 		/* Common */
 		wqe.num_sge = wr->num_sge;
 		if (wr->num_sge > qp->qplib_qp.sq.max_sge) {
-			dev_err(rdev_to_dev(rdev),
-				"Limit exceeded for Send SGEs");
+			ibdev_err(&rdev->ibdev,
+				  "Limit exceeded for Send SGEs");
 			rc = -EINVAL;
 			goto bad;
 		}
@@ -2509,9 +2504,9 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 			rc = bnxt_qplib_post_send(&qp->qplib_qp, &wqe);
 bad:
 		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Post send failed opcode = %#x rc = %d",
-				wr->opcode, rc);
+			ibdev_err(&rdev->ibdev,
+				  "Post send failed opcode = %#x rc = %d",
+				  wr->opcode, rc);
 			break;
 		}
 		wr = wr->next;
@@ -2538,8 +2533,8 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 		/* Common */
 		wqe.num_sge = wr->num_sge;
 		if (wr->num_sge > qp->qplib_qp.sq.max_sge) {
-			dev_err(rdev_to_dev(qp->rdev),
-				"Limit exceeded for Send SGEs");
+			ibdev_err(&qp->rdev->ibdev,
+				  "Limit exceeded for Send SGEs");
 			rc = -EINVAL;
 			goto bad;
 		}
@@ -2584,8 +2579,8 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 			rc = bnxt_re_build_atomic_wqe(wr, &wqe);
 			break;
 		case IB_WR_RDMA_READ_WITH_INV:
-			dev_err(rdev_to_dev(qp->rdev),
-				"RDMA Read with Invalidate is not supported");
+			ibdev_err(&qp->rdev->ibdev,
+				  "RDMA Read with Invalidate is not supported");
 			rc = -EINVAL;
 			goto bad;
 		case IB_WR_LOCAL_INV:
@@ -2596,8 +2591,8 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 			break;
 		default:
 			/* Unsupported WRs */
-			dev_err(rdev_to_dev(qp->rdev),
-				"WR (%#x) is not supported", wr->opcode);
+			ibdev_err(&qp->rdev->ibdev,
+				  "WR (%#x) is not supported", wr->opcode);
 			rc = -EINVAL;
 			goto bad;
 		}
@@ -2605,9 +2600,9 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 			rc = bnxt_qplib_post_send(&qp->qplib_qp, &wqe);
 bad:
 		if (rc) {
-			dev_err(rdev_to_dev(qp->rdev),
-				"post_send failed op:%#x qps = %#x rc = %d\n",
-				wr->opcode, qp->qplib_qp.state, rc);
+			ibdev_err(&qp->rdev->ibdev,
+				  "post_send failed op:%#x qps = %#x rc = %d\n",
+				  wr->opcode, qp->qplib_qp.state, rc);
 			*bad_wr = wr;
 			break;
 		}
@@ -2635,8 +2630,8 @@ static int bnxt_re_post_recv_shadow_qp(struct bnxt_re_dev *rdev,
 		/* Common */
 		wqe.num_sge = wr->num_sge;
 		if (wr->num_sge > qp->qplib_qp.rq.max_sge) {
-			dev_err(rdev_to_dev(rdev),
-				"Limit exceeded for Receive SGEs");
+			ibdev_err(&rdev->ibdev,
+				  "Limit exceeded for Receive SGEs");
 			rc = -EINVAL;
 			break;
 		}
@@ -2672,8 +2667,8 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 		/* Common */
 		wqe.num_sge = wr->num_sge;
 		if (wr->num_sge > qp->qplib_qp.rq.max_sge) {
-			dev_err(rdev_to_dev(qp->rdev),
-				"Limit exceeded for Receive SGEs");
+			ibdev_err(&qp->rdev->ibdev,
+				  "Limit exceeded for Receive SGEs");
 			rc = -EINVAL;
 			*bad_wr = wr;
 			break;
@@ -2744,7 +2739,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	/* Validate CQ fields */
 	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
-		dev_err(rdev_to_dev(rdev), "Failed to create CQ -max exceeded");
+		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
 		return -EINVAL;
 	}
 
@@ -2800,7 +2795,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to create HW CQ");
+		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
 		goto fail;
 	}
 
@@ -2820,7 +2815,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		resp.rsvd = 0;
 		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
 		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Failed to copy CQ udata");
+			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
 			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 			goto c2fail;
 		}
@@ -3099,7 +3094,7 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 	pkt_type = bnxt_re_check_packet_type(cqe->raweth_qp1_flags,
 					     cqe->raweth_qp1_flags2);
 	if (pkt_type < 0) {
-		dev_err(rdev_to_dev(rdev), "Invalid packet\n");
+		ibdev_err(&rdev->ibdev, "Invalid packet\n");
 		return -EINVAL;
 	}
 
@@ -3148,8 +3143,8 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 
 	rc = bnxt_re_post_recv_shadow_qp(rdev, gsi_sqp, &rwr);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev),
-			"Failed to post Rx buffers to shadow QP");
+		ibdev_err(&rdev->ibdev,
+			  "Failed to post Rx buffers to shadow QP");
 		return -ENOMEM;
 	}
 
@@ -3304,11 +3299,11 @@ static int send_phantom_wqe(struct bnxt_re_qp *qp)
 	rc = bnxt_re_bind_fence_mw(lib_qp);
 	if (!rc) {
 		lib_qp->sq.phantom_wqe_cnt++;
-		dev_dbg(&lib_qp->sq.hwq.pdev->dev,
-			"qp %#x sq->prod %#x sw_prod %#x phantom_wqe_cnt %d\n",
-			lib_qp->id, lib_qp->sq.hwq.prod,
-			HWQ_CMP(lib_qp->sq.hwq.prod, &lib_qp->sq.hwq),
-			lib_qp->sq.phantom_wqe_cnt);
+		ibdev_dbg(&qp->rdev->ibdev,
+			  "qp %#x sq->prod %#x sw_prod %#x phantom_wqe_cnt %d\n",
+			  lib_qp->id, lib_qp->sq.hwq.prod,
+			  HWQ_CMP(lib_qp->sq.hwq.prod, &lib_qp->sq.hwq),
+			  lib_qp->sq.phantom_wqe_cnt);
 	}
 
 	spin_unlock_irqrestore(&qp->sq_lock, flags);
@@ -3331,7 +3326,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	budget = min_t(u32, num_entries, cq->max_cql);
 	num_entries = budget;
 	if (!cq->cql) {
-		dev_err(rdev_to_dev(cq->rdev), "POLL CQ : no CQL to use");
+		ibdev_err(&cq->rdev->ibdev, "POLL CQ : no CQL to use");
 		goto exit;
 	}
 	cqe = &cq->cql[0];
@@ -3344,8 +3339,8 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				qp = container_of(lib_qp,
 						  struct bnxt_re_qp, qplib_qp);
 				if (send_phantom_wqe(qp) == -ENOMEM)
-					dev_err(rdev_to_dev(cq->rdev),
-						"Phantom failed! Scheduled to send again\n");
+					ibdev_err(&cq->rdev->ibdev,
+						  "Phantom failed! Scheduled to send again\n");
 				else
 					sq->send_phantom = false;
 			}
@@ -3369,8 +3364,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				 (unsigned long)(cqe->qp_handle),
 				 struct bnxt_re_qp, qplib_qp);
 			if (!qp) {
-				dev_err(rdev_to_dev(cq->rdev),
-					"POLL CQ : bad QP handle");
+				ibdev_err(&cq->rdev->ibdev, "POLL CQ : bad QP handle");
 				continue;
 			}
 			wc->qp = &qp->ib_qp;
@@ -3435,9 +3429,9 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				bnxt_re_process_res_ud_wc(qp, wc, cqe);
 				break;
 			default:
-				dev_err(rdev_to_dev(cq->rdev),
-					"POLL CQ : type 0x%x not handled",
-					cqe->opcode);
+				ibdev_err(&cq->rdev->ibdev,
+					  "POLL CQ : type 0x%x not handled",
+					  cqe->opcode);
 				continue;
 			}
 			wc++;
@@ -3530,7 +3524,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Dereg MR failed: %#x\n", rc);
+		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
 		return rc;
 	}
 
@@ -3577,7 +3571,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 	int rc;
 
 	if (type != IB_MR_TYPE_MEM_REG) {
-		dev_dbg(rdev_to_dev(rdev), "MR type 0x%x not supported", type);
+		ibdev_dbg(&rdev->ibdev, "MR type 0x%x not supported", type);
 		return ERR_PTR(-EINVAL);
 	}
 	if (max_num_sg > MAX_PBL_LVL_1_PGS)
@@ -3607,8 +3601,8 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 	rc = bnxt_qplib_alloc_fast_reg_page_list(&rdev->qplib_res,
 						 &mr->qplib_frpl, max_num_sg);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev),
-			"Failed to allocate HW FR page list");
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate HW FR page list");
 		goto fail_mr;
 	}
 
@@ -3643,7 +3637,7 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 			       CMDQ_ALLOCATE_MRW_MRW_FLAGS_MW_TYPE2B);
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mw->qplib_mw);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Allocate MW failed!");
+		ibdev_err(&rdev->ibdev, "Allocate MW failed!");
 		goto fail;
 	}
 	mw->ib_mw.rkey = mw->qplib_mw.rkey;
@@ -3664,7 +3658,7 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mw->qplib_mw);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Free MW failed: %#x\n", rc);
+		ibdev_err(&rdev->ibdev, "Free MW failed: %#x\n", rc);
 		return rc;
 	}
 
@@ -3716,8 +3710,8 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	int umem_pgs, page_shift, rc;
 
 	if (length > BNXT_RE_MAX_MR_SIZE) {
-		dev_err(rdev_to_dev(rdev), "MR Size: %lld > Max supported:%lld\n",
-			length, BNXT_RE_MAX_MR_SIZE);
+		ibdev_err(&rdev->ibdev, "MR Size: %lld > Max supported:%lld\n",
+			  length, BNXT_RE_MAX_MR_SIZE);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -3732,7 +3726,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to allocate MR");
+		ibdev_err(&rdev->ibdev, "Failed to allocate MR");
 		goto free_mr;
 	}
 	/* The fixed portion of the rkey is the same as the lkey */
@@ -3740,7 +3734,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	umem = ib_umem_get(&rdev->ibdev, start, length, mr_access_flags);
 	if (IS_ERR(umem)) {
-		dev_err(rdev_to_dev(rdev), "Failed to get umem");
+		ibdev_err(&rdev->ibdev, "Failed to get umem");
 		rc = -EFAULT;
 		goto free_mrw;
 	}
@@ -3749,7 +3743,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	mr->qplib_mr.va = virt_addr;
 	umem_pgs = ib_umem_page_count(umem);
 	if (!umem_pgs) {
-		dev_err(rdev_to_dev(rdev), "umem is invalid!");
+		ibdev_err(&rdev->ibdev, "umem is invalid!");
 		rc = -EINVAL;
 		goto free_umem;
 	}
@@ -3766,15 +3760,15 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 				virt_addr));
 
 	if (!bnxt_re_page_size_ok(page_shift)) {
-		dev_err(rdev_to_dev(rdev), "umem page size unsupported!");
+		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
 		rc = -EFAULT;
 		goto fail;
 	}
 
 	if (page_shift == BNXT_RE_PAGE_SHIFT_4K &&
 	    length > BNXT_RE_MAX_MR_SIZE_LOW) {
-		dev_err(rdev_to_dev(rdev), "Requested MR Sz:%llu Max sup:%llu",
-			length,	(u64)BNXT_RE_MAX_MR_SIZE_LOW);
+		ibdev_err(&rdev->ibdev, "Requested MR Sz:%llu Max sup:%llu",
+			  length, (u64)BNXT_RE_MAX_MR_SIZE_LOW);
 		rc = -EINVAL;
 		goto fail;
 	}
@@ -3784,7 +3778,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, pbl_tbl,
 			       umem_pgs, false, 1 << page_shift);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to register user MR");
+		ibdev_err(&rdev->ibdev, "Failed to register user MR");
 		goto fail;
 	}
 
@@ -3817,12 +3811,11 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	u32 chip_met_rev_num = 0;
 	int rc;
 
-	dev_dbg(rdev_to_dev(rdev), "ABI version requested %u",
-		ibdev->ops.uverbs_abi_ver);
+	ibdev_dbg(ibdev, "ABI version requested %u", ibdev->ops.uverbs_abi_ver);
 
 	if (ibdev->ops.uverbs_abi_ver != BNXT_RE_ABI_VERSION) {
-		dev_dbg(rdev_to_dev(rdev), " is different from the device %d ",
-			BNXT_RE_ABI_VERSION);
+		ibdev_dbg(ibdev, " is different from the device %d ",
+			  BNXT_RE_ABI_VERSION);
 		return -EPERM;
 	}
 
@@ -3854,7 +3847,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to copy user context");
+		ibdev_err(ibdev, "Failed to copy user context");
 		rc = -EFAULT;
 		goto cfail;
 	}
@@ -3904,15 +3897,14 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 		if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				       PAGE_SIZE, vma->vm_page_prot)) {
-			dev_err(rdev_to_dev(rdev), "Failed to map DPI");
+			ibdev_err(&rdev->ibdev, "Failed to map DPI");
 			return -EAGAIN;
 		}
 	} else {
 		pfn = virt_to_phys(uctx->shpg) >> PAGE_SHIFT;
 		if (remap_pfn_range(vma, vma->vm_start,
 				    pfn, PAGE_SIZE, vma->vm_page_prot)) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to map shared page");
+			ibdev_err(&rdev->ibdev, "Failed to map shared page");
 			return -EAGAIN;
 		}
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 65f106f..b5128cc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -269,7 +269,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		 * to f/w will timeout and that will set the
 		 * timeout bit.
 		 */
-		dev_err(rdev_to_dev(rdev), "Failed to re-start IRQs\n");
+		ibdev_err(&rdev->ibdev, "Failed to re-start IRQs\n");
 		return;
 	}
 
@@ -286,8 +286,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
 		if (rc)
-			dev_warn(rdev_to_dev(rdev),
-				 "Failed to reinit NQ index %d\n", indx - 1);
+			ibdev_warn(&rdev->ibdev, "Failed to reinit NQ index %d\n",
+				   indx - 1);
 	}
 }
 
@@ -373,9 +373,9 @@ static int bnxt_re_request_msix(struct bnxt_re_dev *rdev)
 		goto done;
 	}
 	if (num_msix_got != num_msix_want) {
-		dev_warn(rdev_to_dev(rdev),
-			 "Requested %d MSI-X vectors, got %d\n",
-			 num_msix_want, num_msix_got);
+		ibdev_warn(&rdev->ibdev,
+			   "Requested %d MSI-X vectors, got %d\n",
+			   num_msix_want, num_msix_got);
 	}
 	rdev->num_msix = num_msix_got;
 done:
@@ -422,8 +422,8 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
 	rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
 	if (rc)
-		dev_err(rdev_to_dev(rdev),
-			"Failed to free HW ring:%d :%#x", req.ring_id, rc);
+		ibdev_err(&rdev->ibdev, "Failed to free HW ring:%d :%#x",
+			  req.ring_id, rc);
 	return rc;
 }
 
@@ -483,8 +483,8 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 			    sizeof(req), DFLT_HWRM_CMD_TIMEOUT);
 	rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
 	if (rc)
-		dev_err(rdev_to_dev(rdev),
-			"Failed to free HW stats context %#x", rc);
+		ibdev_err(&rdev->ibdev, "Failed to free HW stats context %#x",
+			  rc);
 
 	return rc;
 }
@@ -757,8 +757,8 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct net_device *netdev,
 	/* Allocate bnxt_re_dev instance here */
 	rdev = ib_alloc_device(bnxt_re_dev, ibdev);
 	if (!rdev) {
-		dev_err(NULL, "%s: bnxt_re_dev allocation failure!",
-			ROCE_DRV_MODULE_NAME);
+		ibdev_err(NULL, "%s: bnxt_re_dev allocation failure!",
+			  ROCE_DRV_MODULE_NAME);
 		return NULL;
 	}
 	/* Default values */
@@ -887,8 +887,8 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq *nq,
 	int rc = 0;
 
 	if (!srq) {
-		dev_err(NULL, "%s: SRQ is NULL, SRQN not handled",
-			ROCE_DRV_MODULE_NAME);
+		ibdev_err(NULL, "%s: SRQ is NULL, SRQN not handled",
+			  ROCE_DRV_MODULE_NAME);
 		rc = -EINVAL;
 		goto done;
 	}
@@ -915,8 +915,8 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 					     qplib_cq);
 
 	if (!cq) {
-		dev_err(NULL, "%s: CQ is NULL, CQN not handled",
-			ROCE_DRV_MODULE_NAME);
+		ibdev_err(NULL, "%s: CQ is NULL, CQN not handled",
+			  ROCE_DRV_MODULE_NAME);
 		return -EINVAL;
 	}
 	if (cq->ib_cq.comp_handler) {
@@ -963,8 +963,8 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 					  db_offt, &bnxt_re_cqn_handler,
 					  &bnxt_re_srqn_handler);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to enable NQ with rc = 0x%x", rc);
+			ibdev_err(&rdev->ibdev,
+				  "Failed to enable NQ with rc = 0x%x", rc);
 			goto fail;
 		}
 		num_vec_enabled++;
@@ -1039,8 +1039,8 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 					qplib_ctx->srqc_count + 2);
 		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Alloc Failed NQ%d rc:%#x",
-				i, rc);
+			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
+				  i, rc);
 			goto free_nq;
 		}
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
@@ -1052,9 +1052,9 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		rattr.lrid = rdev->msix_entries[i + 1].ring_idx;
 		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to allocate NQ fw id with rc = 0x%x",
-				rc);
+			ibdev_err(&rdev->ibdev,
+				  "Failed to allocate NQ fw id with rc = 0x%x",
+				  rc);
 			bnxt_qplib_free_nq(&rdev->nq[i]);
 			goto free_nq;
 		}
@@ -1128,10 +1128,10 @@ static int bnxt_re_query_hwrm_pri2cos(struct bnxt_re_dev *rdev, u8 dir,
 		return rc;
 
 	if (resp.queue_cfg_info) {
-		dev_warn(rdev_to_dev(rdev),
-			 "Asymmetric cos queue configuration detected");
-		dev_warn(rdev_to_dev(rdev),
-			 " on device, QoS may not be fully functional\n");
+		ibdev_warn(&rdev->ibdev,
+			   "Asymmetric cos queue configuration detected");
+		ibdev_warn(&rdev->ibdev,
+			   " on device, QoS may not be fully functional\n");
 	}
 	qcfgmap = &resp.pri0_cos_queue_id;
 	tmp_map = (u8 *)cid_map;
@@ -1184,7 +1184,7 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 		return 0;
 
 	if (!sgid_tbl) {
-		dev_err(rdev_to_dev(rdev), "QPLIB: SGID table not allocated");
+		ibdev_err(&rdev->ibdev, "QPLIB: SGID table not allocated");
 		return -EINVAL;
 	}
 
@@ -1261,7 +1261,7 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 	/* Get cosq id for this priority */
 	rc = bnxt_re_query_hwrm_pri2cos(rdev, 0, &cid_map);
 	if (rc) {
-		dev_warn(rdev_to_dev(rdev), "no cos for p_mask %x\n", prio_map);
+		ibdev_warn(&rdev->ibdev, "no cos for p_mask %x\n", prio_map);
 		return rc;
 	}
 	/* Parse CoS IDs for app priority */
@@ -1270,8 +1270,8 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 	/* Config BONO. */
 	rc = bnxt_qplib_map_tc2cos(&rdev->qplib_res, rdev->cosq);
 	if (rc) {
-		dev_warn(rdev_to_dev(rdev), "no tc for cos{%x, %x}\n",
-			 rdev->cosq[0], rdev->cosq[1]);
+		ibdev_warn(&rdev->ibdev, "no tc for cos{%x, %x}\n",
+			   rdev->cosq[0], rdev->cosq[1]);
 		return rc;
 	}
 
@@ -1306,8 +1306,8 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
 	rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev),
-			"Failed to query HW version, rc = 0x%x", rc);
+		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
+			  rc);
 		return;
 	}
 	rdev->qplib_ctx.hwrm_intf_ver =
@@ -1338,8 +1338,8 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags)) {
 		rc = bnxt_qplib_deinit_rcfw(&rdev->rcfw);
 		if (rc)
-			dev_warn(rdev_to_dev(rdev),
-				 "Failed to deinitialize RCFW: %#x", rc);
+			ibdev_warn(&rdev->ibdev,
+				   "Failed to deinitialize RCFW: %#x", rc);
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
 		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
@@ -1350,16 +1350,16 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags)) {
 		rc = bnxt_re_free_msix(rdev);
 		if (rc)
-			dev_warn(rdev_to_dev(rdev),
-				 "Failed to free MSI-X vectors: %#x", rc);
+			ibdev_warn(&rdev->ibdev,
+				   "Failed to free MSI-X vectors: %#x", rc);
 	}
 
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags)) {
 		rc = bnxt_re_unregister_netdev(rdev);
 		if (rc)
-			dev_warn(rdev_to_dev(rdev),
-				 "Failed to unregister with netdev: %#x", rc);
+			ibdev_warn(&rdev->ibdev,
+				   "Failed to unregister with netdev: %#x", rc);
 	}
 }
 
@@ -1392,14 +1392,15 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	rc = bnxt_re_register_netdev(rdev);
 	if (rc) {
 		rtnl_unlock();
-		pr_err("Failed to register with netedev: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to register with netedev: %#x\n", rc);
 		return -EINVAL;
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
 	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
-		dev_err(rdev_to_dev(rdev), "Failed to get chip context\n");
+		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
 		return -EINVAL;
 	}
 
@@ -1408,7 +1409,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 
 	rc = bnxt_re_request_msix(rdev);
 	if (rc) {
-		pr_err("Failed to get MSI-X vectors: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to get MSI-X vectors: %#x\n", rc);
 		rc = -EINVAL;
 		goto fail;
 	}
@@ -1423,7 +1425,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 					   &rdev->qplib_ctx,
 					   BNXT_RE_MAX_QPC_COUNT);
 	if (rc) {
-		pr_err("Failed to allocate RCFW Channel: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate RCFW Channel: %#x\n", rc);
 		goto fail;
 	}
 
@@ -1437,7 +1440,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	rattr.lrid = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
 	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
 	if (rc) {
-		pr_err("Failed to allocate CREQ: %#x\n", rc);
+		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
 	}
 	db_offt = bnxt_re_get_nqdb_offset(rdev, BNXT_RE_AEQ_IDX);
@@ -1446,7 +1449,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 					    vid, db_offt, rdev->is_virtfn,
 					    &bnxt_re_aeq_handler);
 	if (rc) {
-		pr_err("Failed to enable RCFW channel: %#x\n", rc);
+		ibdev_err(&rdev->ibdev, "Failed to enable RCFW channel: %#x\n",
+			  rc);
 		goto free_ring;
 	}
 
@@ -1460,21 +1464,24 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
 				  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx));
 	if (rc) {
-		pr_err("Failed to allocate QPLIB context: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate QPLIB context: %#x\n", rc);
 		goto disable_rcfw;
 	}
 	rc = bnxt_re_net_stats_ctx_alloc(rdev,
 					 rdev->qplib_ctx.stats.dma_map,
 					 &rdev->qplib_ctx.stats.fw_id);
 	if (rc) {
-		pr_err("Failed to allocate stats context: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate stats context: %#x\n", rc);
 		goto free_ctx;
 	}
 
 	rc = bnxt_qplib_init_rcfw(&rdev->rcfw, &rdev->qplib_ctx,
 				  rdev->is_virtfn);
 	if (rc) {
-		pr_err("Failed to initialize RCFW: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to initialize RCFW: %#x\n", rc);
 		goto free_sctx;
 	}
 	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags);
@@ -1482,13 +1489,15 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	/* Resources based on the 'new' device caps */
 	rc = bnxt_re_alloc_res(rdev);
 	if (rc) {
-		pr_err("Failed to allocate resources: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate resources: %#x\n", rc);
 		goto fail;
 	}
 	set_bit(BNXT_RE_FLAG_RESOURCES_ALLOCATED, &rdev->flags);
 	rc = bnxt_re_init_res(rdev);
 	if (rc) {
-		pr_err("Failed to initialize resources: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to initialize resources: %#x\n", rc);
 		goto fail;
 	}
 
@@ -1497,7 +1506,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	if (!rdev->is_virtfn) {
 		rc = bnxt_re_setup_qos(rdev);
 		if (rc)
-			pr_info("RoCE priority not yet configured\n");
+			ibdev_info(&rdev->ibdev,
+				   "RoCE priority not yet configured\n");
 
 		INIT_DELAYED_WORK(&rdev->worker, bnxt_re_worker);
 		set_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags);
@@ -1510,11 +1520,12 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	/* Register ib dev */
 	rc = bnxt_re_register_ib(rdev);
 	if (rc) {
-		pr_err("Failed to register with IB: %#x\n", rc);
+		ibdev_err(&rdev->ibdev,
+			  "Failed to register with IB: %#x\n", rc);
 		goto fail;
 	}
 	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
-	dev_info(rdev_to_dev(rdev), "Device registered successfully");
+	ibdev_info(&rdev->ibdev, "Device registered successfully");
 	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
 			 &rdev->active_width);
 	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
@@ -1563,7 +1574,8 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
 	en_dev = bnxt_re_dev_probe(netdev);
 	if (IS_ERR(en_dev)) {
 		if (en_dev != ERR_PTR(-ENODEV))
-			pr_err("%s: Failed to probe\n", ROCE_DRV_MODULE_NAME);
+			ibdev_err(&(*rdev)->ibdev, "%s: Failed to probe\n",
+				  ROCE_DRV_MODULE_NAME);
 		rc = PTR_ERR(en_dev);
 		goto exit;
 	}
@@ -1600,8 +1612,8 @@ static void bnxt_re_task(struct work_struct *work)
 	case NETDEV_REGISTER:
 		rc = bnxt_re_ib_reg(rdev);
 		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to register with IB: %#x", rc);
+			ibdev_err(&rdev->ibdev,
+				  "Failed to register with IB: %#x", rc);
 			bnxt_re_remove_one(rdev);
 			bnxt_re_dev_unreg(rdev);
 			goto exit;
@@ -1678,8 +1690,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		if (rc == -ENODEV)
 			break;
 		if (rc) {
-			pr_err("Failed to register with the device %s: %#x\n",
-			       real_dev->name, rc);
+			ibdev_err(&rdev->ibdev,
+				  "Failed to register with the device %s: %#x\n",
+				  real_dev->name, rc);
 			break;
 		}
 		bnxt_re_init_one(rdev);
@@ -1764,7 +1777,7 @@ static void __exit bnxt_re_mod_exit(void)
 	* cleanup is done before PF cleanup
 	*/
 	list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
-		dev_info(rdev_to_dev(rdev), "Unregistering Device");
+		ibdev_info(&rdev->ibdev, "Unregistering Device");
 		/*
 		 * Flush out any scheduled tasks before destroying the
 		 * resources
-- 
1.8.3.1

