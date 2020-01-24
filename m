Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20716147851
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAXFw4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:52:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAXFw4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:52:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so551919pfo.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nurkOfdTvzoneYlquLGwkW34Z6YPJG4W55ju6H+xKZA=;
        b=S8x9wTa+eELDqyXJDo5cG3OZgg44lL0g+NOP+lAWZzO8c+las10usWHmHjUmbpt1Tr
         Sc0Xezb8wUGJcvEwjZQl822QzrpBGKnf8YVcez4sz/AZ+P5QbFHe1bMG/W7iqmeMiDbW
         sYRbHfMAvNQUPy6OyqjTE4QbyvoZ0ge/Sanko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nurkOfdTvzoneYlquLGwkW34Z6YPJG4W55ju6H+xKZA=;
        b=RszeJjXZFtJZN3V1gFiN5Txtr3SRpKrLfOYBJvznhmPPf7iuygA2IewU5eklRgvcbL
         Yr3U4S81BSZmqEI+RYONdRhdu51qfKs44pIuqIfD58ufYCJC/22DTDF7JepxpB9fEPpu
         g/EZfwzQP+WJnBuwXj4bO6BJk5gq40rUMtro8LKeU85YAqFW2bct638ESwwbR/GJ/IGR
         vvwJTvYZ4/Oe3Lid8BpedUAqYTxVq3HJEJ6SxshYBjQRXo3OxutgiVa6Zflp+Py4I/SS
         2P/nzqZzZ4PutaA4H9ZYackcfnsVKTVo8c3Npwg2WgUsWUSzVItsB788W4a2OHeFS0Zi
         hjuA==
X-Gm-Message-State: APjAAAVKDeS7PuLdZ4Kn3jEqjD3yFJFVOzwpDhYZ09T5c/Nwd95UC+sf
        y+8HoKh7trgy8KzwUoE6tZ39ag8jgkl2aHzjyIcuWALeJkpoZvXx4GKNlC7QYDIR73/ap8JWHDn
        XnmCGZTmU9laJEr8Fa1PbhG62NmgjZYDdl+cYHtxNAz+FHw6BdkRH6tOoOSqfOCw+K8/PHsOU5a
        XJCyGgNA==
X-Google-Smtp-Source: APXvYqwr243skH/8e8DUKZ8uz/NW4st5VPbr6ib8HntwycKhxYVwfi9E052pHDNRAHjUpejPjvIoBw==
X-Received: by 2002:a63:f455:: with SMTP id p21mr2220989pgk.436.1579845174500;
        Thu, 23 Jan 2020 21:52:54 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:52:54 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
Date:   Fri, 24 Jan 2020 00:52:39 -0500
Message-Id: <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Restructuring the bnxt_re_create_qp function. Listing below
the major changes:
 --Monolithic central part of create_qp where attributes are
   initialized is now enclosed in one function and this new
   function has few more sub-functions.
 --Top level qp limit checking code moved to a function.
 --GSI QP creation and GSI Shadow qp creation code is handled
   in a sub function.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
 3 files changed, 434 insertions(+), 217 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 725b235..c2805384 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -104,6 +104,14 @@ struct bnxt_re_sqp_entries {
 	struct bnxt_re_qp *qp1_qp;
 };
 
+#define BNXT_RE_MAX_GSI_SQP_ENTRIES	1024
+struct bnxt_re_gsi_context {
+	struct	bnxt_re_qp *gsi_qp;
+	struct	bnxt_re_qp *gsi_sqp;
+	struct	bnxt_re_ah *gsi_sah;
+	struct	bnxt_re_sqp_entries *sqp_tbl;
+};
+
 #define BNXT_RE_MIN_MSIX		2
 #define BNXT_RE_MAX_MSIX		9
 #define BNXT_RE_AEQ_IDX			0
@@ -165,10 +173,7 @@ struct bnxt_re_dev {
 	u16				cosq[2];
 
 	/* QP for for handling QP1 packets */
-	u32				sqp_id;
-	struct bnxt_re_qp		*qp1_sqp;
-	struct bnxt_re_ah		*sqp_ah;
-	struct bnxt_re_sqp_entries sqp_tbl[1024];
+	struct bnxt_re_gsi_context	gsi_ctx;
 	atomic_t nq_alloc_cnt;
 	u32 is_virtfn;
 	u32 num_vfs;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9b6ca15..127eb8f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -312,7 +312,7 @@ int bnxt_re_del_gid(const struct ib_gid_attr *attr, void **context)
 		 */
 		if (ctx->idx == 0 &&
 		    rdma_link_local_addr((struct in6_addr *)gid_to_del) &&
-		    ctx->refcnt == 1 && rdev->qp1_sqp) {
+		    ctx->refcnt == 1 && rdev->gsi_ctx.gsi_sqp) {
 			dev_dbg(rdev_to_dev(rdev),
 				"Trying to delete GID0 while QP1 is alive\n");
 			return -EFAULT;
@@ -742,6 +742,53 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp,
 	spin_unlock_irqrestore(&qp->scq->cq_lock, flags);
 }
 
+static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
+{
+	struct bnxt_re_qp *gsi_sqp;
+	struct bnxt_re_ah *gsi_sah;
+	struct bnxt_re_dev *rdev;
+	int rc = 0;
+
+	rdev = qp->rdev;
+	gsi_sqp = rdev->gsi_ctx.gsi_sqp;
+	gsi_sah = rdev->gsi_ctx.gsi_sah;
+
+	/* remove from active qp list */
+	mutex_lock(&rdev->qp_lock);
+	list_del(&gsi_sqp->list);
+	atomic_dec(&rdev->qp_count);
+	mutex_unlock(&rdev->qp_lock);
+
+	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
+	bnxt_qplib_destroy_ah(&rdev->qplib_res,
+			      &gsi_sah->qplib_ah,
+			      true);
+	bnxt_qplib_clean_qp(&qp->qplib_qp);
+
+	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
+	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
+	if (rc) {
+		dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
+		goto fail;
+	}
+	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
+
+	kfree(rdev->gsi_ctx.sqp_tbl);
+	kfree(gsi_sah);
+	kfree(gsi_sqp);
+	rdev->gsi_ctx.gsi_sqp = NULL;
+	rdev->gsi_ctx.gsi_sah = NULL;
+	rdev->gsi_ctx.sqp_tbl = NULL;
+
+	return 0;
+fail:
+	mutex_lock(&rdev->qp_lock);
+	list_add_tail(&gsi_sqp->list, &rdev->qp_list);
+	atomic_inc(&rdev->qp_count);
+	mutex_unlock(&rdev->qp_lock);
+	return rc;
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -750,10 +797,18 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	atomic_dec(&rdev->qp_count);
+	mutex_unlock(&rdev->qp_lock);
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
 	if (rc) {
 		dev_err(rdev_to_dev(rdev), "Failed to destroy HW QP");
+		mutex_lock(&rdev->qp_lock);
+		list_add_tail(&qp->list, &rdev->qp_list);
+		atomic_inc(&rdev->qp_count);
+		mutex_unlock(&rdev->qp_lock);
 		return rc;
 	}
 
@@ -765,40 +820,19 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 
-	if (ib_qp->qp_type == IB_QPT_GSI && rdev->qp1_sqp) {
-		bnxt_qplib_destroy_ah(&rdev->qplib_res, &rdev->sqp_ah->qplib_ah,
-				      false);
-
-		bnxt_qplib_clean_qp(&qp->qplib_qp);
-		rc = bnxt_qplib_destroy_qp(&rdev->qplib_res,
-					   &rdev->qp1_sqp->qplib_qp);
-		if (rc) {
-			dev_err(rdev_to_dev(rdev),
-				"Failed to destroy Shadow QP");
-			return rc;
-		}
-		bnxt_qplib_free_qp_res(&rdev->qplib_res,
-				       &rdev->qp1_sqp->qplib_qp);
-		mutex_lock(&rdev->qp_lock);
-		list_del(&rdev->qp1_sqp->list);
-		atomic_dec(&rdev->qp_count);
-		mutex_unlock(&rdev->qp_lock);
-
-		kfree(rdev->sqp_ah);
-		kfree(rdev->qp1_sqp);
-		rdev->qp1_sqp = NULL;
-		rdev->sqp_ah = NULL;
+	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp) {
+		rc = bnxt_re_destroy_gsi_sqp(qp);
+		if (rc)
+			goto sh_fail;
 	}
 
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
-	mutex_lock(&rdev->qp_lock);
-	list_del(&qp->list);
-	atomic_dec(&rdev->qp_count);
-	mutex_unlock(&rdev->qp_lock);
 	kfree(qp);
 	return 0;
+sh_fail:
+	return rc;
 }
 
 static u8 __from_ib_qp_type(enum ib_qp_type type)
@@ -966,8 +1000,6 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	if (rc)
 		goto fail;
 
-	rdev->sqp_id = qp->qplib_qp.id;
-
 	spin_lock_init(&qp->sq_lock);
 	INIT_LIST_HEAD(&qp->list);
 	mutex_lock(&rdev->qp_lock);
@@ -980,205 +1012,377 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	return NULL;
 }
 
-struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
-				struct ib_qp_init_attr *qp_init_attr,
-				struct ib_udata *udata)
+static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
+				struct ib_qp_init_attr *init_attr)
 {
-	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
-	struct bnxt_re_dev *rdev = pd->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_qp *qp;
-	struct bnxt_re_cq *cq;
-	struct bnxt_re_srq *srq;
-	int rc, entries;
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	int entries;
 
-	if ((qp_init_attr->cap.max_send_wr > dev_attr->max_qp_wqes) ||
-	    (qp_init_attr->cap.max_recv_wr > dev_attr->max_qp_wqes) ||
-	    (qp_init_attr->cap.max_send_sge > dev_attr->max_qp_sges) ||
-	    (qp_init_attr->cap.max_recv_sge > dev_attr->max_qp_sges) ||
-	    (qp_init_attr->cap.max_inline_data > dev_attr->max_inline_data))
-		return ERR_PTR(-EINVAL);
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
 
-	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
+	if (init_attr->srq) {
+		struct bnxt_re_srq *srq;
 
-	qp->rdev = rdev;
-	ether_addr_copy(qp->qplib_qp.smac, rdev->netdev->dev_addr);
-	qp->qplib_qp.pd = &pd->qplib_pd;
-	qp->qplib_qp.qp_handle = (u64)(unsigned long)(&qp->qplib_qp);
-	qp->qplib_qp.type = __from_ib_qp_type(qp_init_attr->qp_type);
+		srq = container_of(init_attr->srq, struct bnxt_re_srq, ib_srq);
+		if (!srq) {
+			dev_err(rdev_to_dev(rdev), "SRQ not found");
+			return -EINVAL;
+		}
+		qplqp->srq = &srq->qplib_srq;
+		qplqp->rq.max_wqe = 0;
+	} else {
+		/* Allocate 1 more than what's provided so posting max doesn't
+		 * mean empty.
+		 */
+		entries = roundup_pow_of_two(init_attr->cap.max_recv_wr + 1);
+		qplqp->rq.max_wqe = min_t(u32, entries,
+					  dev_attr->max_qp_wqes + 1);
 
-	if (qp_init_attr->qp_type == IB_QPT_GSI &&
-	    bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))
-		qp->qplib_qp.type = CMDQ_CREATE_QP_TYPE_GSI;
-	if (qp->qplib_qp.type == IB_QPT_MAX) {
+		qplqp->rq.q_full_delta = qplqp->rq.max_wqe -
+					 init_attr->cap.max_recv_wr;
+		qplqp->rq.max_sge = init_attr->cap.max_recv_sge;
+		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
+			qplqp->rq.max_sge = dev_attr->max_qp_sges;
+	}
+
+	return 0;
+}
+
+static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
+
+	qplqp->rq.max_sge = dev_attr->max_qp_sges;
+	if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
+		qplqp->rq.max_sge = dev_attr->max_qp_sges;
+}
+
+static void bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
+				 struct ib_qp_init_attr *init_attr,
+				 struct ib_udata *udata)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	int entries;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
+
+	qplqp->sq.max_sge = init_attr->cap.max_send_sge;
+	if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
+		qplqp->sq.max_sge = dev_attr->max_qp_sges;
+	/*
+	 * Change the SQ depth if user has requested minimum using
+	 * configfs. Only supported for kernel consumers
+	 */
+	entries = init_attr->cap.max_send_wr;
+	/* Allocate 128 + 1 more than what's provided */
+	entries = roundup_pow_of_two(entries + BNXT_QPLIB_RESERVED_QP_WRS + 1);
+	qplqp->sq.max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes +
+			BNXT_QPLIB_RESERVED_QP_WRS + 1);
+	qplqp->sq.q_full_delta = BNXT_QPLIB_RESERVED_QP_WRS + 1;
+	/*
+	 * Reserving one slot for Phantom WQE. Application can
+	 * post one extra entry in this case. But allowing this to avoid
+	 * unexpected Queue full condition
+	 */
+	qplqp->sq.q_full_delta -= 1;
+}
+
+static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
+				       struct ib_qp_init_attr *init_attr)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	int entries;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
+
+	entries = roundup_pow_of_two(init_attr->cap.max_send_wr + 1);
+	qplqp->sq.max_wqe = min_t(u32, entries, dev_attr->max_qp_wqes + 1);
+	qplqp->sq.q_full_delta = qplqp->sq.max_wqe -
+				 init_attr->cap.max_send_wr;
+	qplqp->sq.max_sge++; /* Need one extra sge to put UD header */
+	if (qplqp->sq.max_sge > dev_attr->max_qp_sges)
+		qplqp->sq.max_sge = dev_attr->max_qp_sges;
+}
+
+static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
+				struct ib_qp_init_attr *init_attr)
+{
+	struct bnxt_qplib_chip_ctx *chip_ctx;
+	int qptype;
+
+	chip_ctx = &rdev->chip_ctx;
+
+	qptype = __from_ib_qp_type(init_attr->qp_type);
+	if (qptype == IB_QPT_MAX) {
 		dev_err(rdev_to_dev(rdev), "QP type 0x%x not supported",
-			qp->qplib_qp.type);
-		rc = -EINVAL;
-		goto fail;
+			qptype);
+		qptype = -EINVAL;
+		goto out;
 	}
 
-	qp->qplib_qp.max_inline_data = qp_init_attr->cap.max_inline_data;
-	qp->qplib_qp.sig_type = ((qp_init_attr->sq_sig_type ==
-				  IB_SIGNAL_ALL_WR) ? true : false);
+	if (bnxt_qplib_is_chip_gen_p5(chip_ctx) &&
+	    init_attr->qp_type == IB_QPT_GSI)
+		qptype = CMDQ_CREATE_QP_TYPE_GSI;
+out:
+	return qptype;
+}
+
+static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
+				struct ib_qp_init_attr *init_attr,
+				struct ib_udata *udata)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_qplib_qp *qplqp;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *cq;
+	int rc = 0, qptype;
+
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
+
+	/* Setup misc params */
+	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
+	qplqp->pd = &pd->qplib_pd;
+	qplqp->qp_handle = (u64)qplqp;
+	qplqp->max_inline_data = init_attr->cap.max_inline_data;
+	qplqp->sig_type = ((init_attr->sq_sig_type == IB_SIGNAL_ALL_WR) ?
+			    true : false);
+	qptype = bnxt_re_init_qp_type(rdev, init_attr);
+	if (qptype < 0) {
+		rc = qptype;
+		goto out;
+	}
+	qplqp->type = (u8)qptype;
 
-	qp->qplib_qp.sq.max_sge = qp_init_attr->cap.max_send_sge;
-	if (qp->qplib_qp.sq.max_sge > dev_attr->max_qp_sges)
-		qp->qplib_qp.sq.max_sge = dev_attr->max_qp_sges;
+	if (init_attr->qp_type == IB_QPT_RC) {
+		qplqp->max_rd_atomic = dev_attr->max_qp_rd_atom;
+		qplqp->max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
+	}
+	qplqp->mtu = ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	qplqp->dpi = &rdev->dpi_privileged; /* Doorbell page */
+	if (init_attr->create_flags)
+		dev_dbg(rdev_to_dev(rdev),
+			"QP create flags 0x%x not supported",
+			init_attr->create_flags);
 
-	if (qp_init_attr->send_cq) {
-		cq = container_of(qp_init_attr->send_cq, struct bnxt_re_cq,
-				  ib_cq);
+	/* Setup CQs */
+	if (init_attr->send_cq) {
+		cq = container_of(init_attr->send_cq, struct bnxt_re_cq, ib_cq);
 		if (!cq) {
 			dev_err(rdev_to_dev(rdev), "Send CQ not found");
 			rc = -EINVAL;
-			goto fail;
+			goto out;
 		}
-		qp->qplib_qp.scq = &cq->qplib_cq;
+		qplqp->scq = &cq->qplib_cq;
 		qp->scq = cq;
 	}
 
-	if (qp_init_attr->recv_cq) {
-		cq = container_of(qp_init_attr->recv_cq, struct bnxt_re_cq,
-				  ib_cq);
+	if (init_attr->recv_cq) {
+		cq = container_of(init_attr->recv_cq, struct bnxt_re_cq, ib_cq);
 		if (!cq) {
 			dev_err(rdev_to_dev(rdev), "Receive CQ not found");
 			rc = -EINVAL;
-			goto fail;
+			goto out;
 		}
-		qp->qplib_qp.rcq = &cq->qplib_cq;
+		qplqp->rcq = &cq->qplib_cq;
 		qp->rcq = cq;
 	}
 
-	if (qp_init_attr->srq) {
-		srq = container_of(qp_init_attr->srq, struct bnxt_re_srq,
-				   ib_srq);
-		if (!srq) {
-			dev_err(rdev_to_dev(rdev), "SRQ not found");
-			rc = -EINVAL;
-			goto fail;
-		}
-		qp->qplib_qp.srq = &srq->qplib_srq;
-		qp->qplib_qp.rq.max_wqe = 0;
-	} else {
-		/* Allocate 1 more than what's provided so posting max doesn't
-		 * mean empty
-		 */
-		entries = roundup_pow_of_two(qp_init_attr->cap.max_recv_wr + 1);
-		qp->qplib_qp.rq.max_wqe = min_t(u32, entries,
-						dev_attr->max_qp_wqes + 1);
+	/* Setup RQ/SRQ */
+	rc = bnxt_re_init_rq_attr(qp, init_attr);
+	if (rc)
+		goto out;
+	if (init_attr->qp_type == IB_QPT_GSI)
+		bnxt_re_adjust_gsi_rq_attr(qp);
+
+	/* Setup SQ */
+	bnxt_re_init_sq_attr(qp, init_attr, udata);
+	if (init_attr->qp_type == IB_QPT_GSI)
+		bnxt_re_adjust_gsi_sq_attr(qp, init_attr);
 
-		qp->qplib_qp.rq.q_full_delta = qp->qplib_qp.rq.max_wqe -
-						qp_init_attr->cap.max_recv_wr;
+	if (udata) /* This will update DPI and qp_handle */
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, udata);
+out:
+	return rc;
+}
+
+static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
+				     struct bnxt_re_pd *pd)
+{
+	struct bnxt_re_sqp_entries *sqp_tbl = NULL;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_re_qp *sqp;
+	struct bnxt_re_ah *sah;
+	int rc = 0;
 
-		qp->qplib_qp.rq.max_sge = qp_init_attr->cap.max_recv_sge;
-		if (qp->qplib_qp.rq.max_sge > dev_attr->max_qp_sges)
-			qp->qplib_qp.rq.max_sge = dev_attr->max_qp_sges;
+	rdev = qp->rdev;
+	/* Create a shadow QP to handle the QP1 traffic */
+	sqp_tbl = kzalloc(sizeof(*sqp_tbl) * BNXT_RE_MAX_GSI_SQP_ENTRIES,
+			  GFP_KERNEL);
+	if (!sqp_tbl)
+		return -ENOMEM;
+	rdev->gsi_ctx.sqp_tbl = sqp_tbl;
+
+	sqp = bnxt_re_create_shadow_qp(pd, &rdev->qplib_res, &qp->qplib_qp);
+	if (!sqp) {
+		rc = -ENODEV;
+		dev_err(rdev_to_dev(rdev),
+			"Failed to create Shadow QP for QP1");
+		goto out;
 	}
+	rdev->gsi_ctx.gsi_sqp = sqp;
 
-	qp->qplib_qp.mtu = ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	sqp->rcq = qp->rcq;
+	sqp->scq = qp->scq;
+	sah = bnxt_re_create_shadow_qp_ah(pd, &rdev->qplib_res,
+					  &qp->qplib_qp);
+	if (!sah) {
+		bnxt_qplib_destroy_qp(&rdev->qplib_res,
+				      &sqp->qplib_qp);
+		rc = -ENODEV;
+		dev_err(rdev_to_dev(rdev),
+			"Failed to create AH entry for ShadowQP");
+		goto out;
+	}
+	rdev->gsi_ctx.gsi_sah = sah;
 
-	if (qp_init_attr->qp_type == IB_QPT_GSI &&
-	    !(bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))) {
-		/* Allocate 1 more than what's provided */
-		entries = roundup_pow_of_two(qp_init_attr->cap.max_send_wr + 1);
-		qp->qplib_qp.sq.max_wqe = min_t(u32, entries,
-						dev_attr->max_qp_wqes + 1);
-		qp->qplib_qp.sq.q_full_delta = qp->qplib_qp.sq.max_wqe -
-						qp_init_attr->cap.max_send_wr;
-		qp->qplib_qp.rq.max_sge = dev_attr->max_qp_sges;
-		if (qp->qplib_qp.rq.max_sge > dev_attr->max_qp_sges)
-			qp->qplib_qp.rq.max_sge = dev_attr->max_qp_sges;
-		qp->qplib_qp.sq.max_sge++;
-		if (qp->qplib_qp.sq.max_sge > dev_attr->max_qp_sges)
-			qp->qplib_qp.sq.max_sge = dev_attr->max_qp_sges;
-
-		qp->qplib_qp.rq_hdr_buf_size =
-					BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
-
-		qp->qplib_qp.sq_hdr_buf_size =
-					BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;
-		qp->qplib_qp.dpi = &rdev->dpi_privileged;
-		rc = bnxt_qplib_create_qp1(&rdev->qplib_res, &qp->qplib_qp);
-		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Failed to create HW QP1");
-			goto fail;
-		}
-		/* Create a shadow QP to handle the QP1 traffic */
-		rdev->qp1_sqp = bnxt_re_create_shadow_qp(pd, &rdev->qplib_res,
-							 &qp->qplib_qp);
-		if (!rdev->qp1_sqp) {
-			rc = -EINVAL;
-			dev_err(rdev_to_dev(rdev),
-				"Failed to create Shadow QP for QP1");
-			goto qp_destroy;
-		}
-		rdev->sqp_ah = bnxt_re_create_shadow_qp_ah(pd, &rdev->qplib_res,
-							   &qp->qplib_qp);
-		if (!rdev->sqp_ah) {
-			bnxt_qplib_destroy_qp(&rdev->qplib_res,
-					      &rdev->qp1_sqp->qplib_qp);
-			rc = -EINVAL;
-			dev_err(rdev_to_dev(rdev),
-				"Failed to create AH entry for ShadowQP");
-			goto qp_destroy;
-		}
+	return 0;
+out:
+	kfree(sqp_tbl);
+	return rc;
+}
 
-	} else {
-		/* Allocate 128 + 1 more than what's provided */
-		entries = roundup_pow_of_two(qp_init_attr->cap.max_send_wr +
-					     BNXT_QPLIB_RESERVED_QP_WRS + 1);
-		qp->qplib_qp.sq.max_wqe = min_t(u32, entries,
-						dev_attr->max_qp_wqes +
-						BNXT_QPLIB_RESERVED_QP_WRS + 1);
-		qp->qplib_qp.sq.q_full_delta = BNXT_QPLIB_RESERVED_QP_WRS + 1;
+static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
+				 struct ib_qp_init_attr *init_attr)
+{
+	struct bnxt_qplib_dev_attr *dev_attr;
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_qp *qplqp;
+	int rc = 0;
 
-		/*
-		 * Reserving one slot for Phantom WQE. Application can
-		 * post one extra entry in this case. But allowing this to avoid
-		 * unexpected Queue full condition
-		 */
+	rdev = qp->rdev;
+	qplqp = &qp->qplib_qp;
+	dev_attr = &rdev->dev_attr;
 
-		qp->qplib_qp.sq.q_full_delta -= 1;
+	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
+	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;
 
-		qp->qplib_qp.max_rd_atomic = dev_attr->max_qp_rd_atom;
-		qp->qplib_qp.max_dest_rd_atomic = dev_attr->max_qp_init_rd_atom;
-		if (udata) {
-			rc = bnxt_re_init_user_qp(rdev, pd, qp, udata);
-			if (rc)
-				goto fail;
-		} else {
-			qp->qplib_qp.dpi = &rdev->dpi_privileged;
-		}
+	rc = bnxt_qplib_create_qp1(&rdev->qplib_res, qplqp);
+	if (rc) {
+		dev_err(rdev_to_dev(rdev), "create HW QP1 failed!");
+		goto out;
+	}
+
+	rc = bnxt_re_create_shadow_gsi(qp, pd);
+out:
+	return rc;
+}
 
+static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
+				   struct ib_qp_init_attr *init_attr,
+				   struct bnxt_qplib_dev_attr *dev_attr)
+{
+	bool rc = true;
+
+	if (init_attr->cap.max_send_wr > dev_attr->max_qp_wqes ||
+	    init_attr->cap.max_recv_wr > dev_attr->max_qp_wqes ||
+	    init_attr->cap.max_send_sge > dev_attr->max_qp_sges ||
+	    init_attr->cap.max_recv_sge > dev_attr->max_qp_sges ||
+	    init_attr->cap.max_inline_data > dev_attr->max_inline_data) {
+		dev_err(rdev_to_dev(rdev),
+			"Create QP failed - max exceeded! 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x 0x%x/0x%x",
+			init_attr->cap.max_send_wr, dev_attr->max_qp_wqes,
+			init_attr->cap.max_recv_wr, dev_attr->max_qp_wqes,
+			init_attr->cap.max_send_sge, dev_attr->max_qp_sges,
+			init_attr->cap.max_recv_sge, dev_attr->max_qp_sges,
+			init_attr->cap.max_inline_data,
+			dev_attr->max_inline_data);
+		rc = false;
+	}
+	return rc;
+}
+
+struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
+				struct ib_qp_init_attr *qp_init_attr,
+				struct ib_udata *udata)
+{
+	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
+	struct bnxt_re_dev *rdev = pd->rdev;
+	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_re_qp *qp;
+	int rc;
+
+	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
+	if (!rc) {
+		rc = -EINVAL;
+		goto exit;
+	}
+
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+	qp->rdev = rdev;
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, udata);
+	if (rc)
+		goto fail;
+
+	if (qp_init_attr->qp_type == IB_QPT_GSI &&
+	    !(bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))) {
+		rc = bnxt_re_create_gsi_qp(qp, pd, qp_init_attr);
+		if (rc == -ENODEV)
+			goto qp_destroy;
+		if (rc)
+			goto fail;
+	} else {
 		rc = bnxt_qplib_create_qp(&rdev->qplib_res, &qp->qplib_qp);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev), "Failed to create HW QP");
 			goto free_umem;
 		}
+		if (udata) {
+			struct bnxt_re_qp_resp resp;
+
+			resp.qpid = qp->qplib_qp.id;
+			resp.rsvd = 0;
+			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+			if (rc) {
+				dev_err(rdev_to_dev(rdev), "Failed to copy QP udata");
+				goto qp_destroy;
+			}
+		}
 	}
 
 	qp->ib_qp.qp_num = qp->qplib_qp.id;
+	if (qp_init_attr->qp_type == IB_QPT_GSI)
+		rdev->gsi_ctx.gsi_qp = qp;
 	spin_lock_init(&qp->sq_lock);
 	spin_lock_init(&qp->rq_lock);
-
-	if (udata) {
-		struct bnxt_re_qp_resp resp;
-
-		resp.qpid = qp->ib_qp.qp_num;
-		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
-		if (rc) {
-			dev_err(rdev_to_dev(rdev), "Failed to copy QP udata");
-			goto qp_destroy;
-		}
-	}
 	INIT_LIST_HEAD(&qp->list);
 	mutex_lock(&rdev->qp_lock);
 	list_add_tail(&qp->list, &rdev->qp_list);
-	atomic_inc(&rdev->qp_count);
 	mutex_unlock(&rdev->qp_lock);
+	atomic_inc(&rdev->qp_count);
 
 	return &qp->ib_qp;
 qp_destroy:
@@ -1188,6 +1392,7 @@ struct ib_qp *bnxt_re_create_qp(struct ib_pd *ib_pd,
 	ib_umem_release(qp->sumem);
 fail:
 	kfree(qp);
+exit:
 	return ERR_PTR(rc);
 }
 
@@ -1485,7 +1690,7 @@ static int bnxt_re_modify_shadow_qp(struct bnxt_re_dev *rdev,
 				    struct bnxt_re_qp *qp1_qp,
 				    int qp_attr_mask)
 {
-	struct bnxt_re_qp *qp = rdev->qp1_sqp;
+	struct bnxt_re_qp *qp = rdev->gsi_ctx.gsi_sqp;
 	int rc = 0;
 
 	if (qp_attr_mask & IB_QP_STATE) {
@@ -1749,7 +1954,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		dev_err(rdev_to_dev(rdev), "Failed to modify HW QP");
 		return rc;
 	}
-	if (ib_qp->qp_type == IB_QPT_GSI && rdev->qp1_sqp)
+	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp)
 		rc = bnxt_re_modify_shadow_qp(rdev, qp, qp_attr_mask);
 	return rc;
 }
@@ -1993,9 +2198,12 @@ static int bnxt_re_build_qp1_shadow_qp_recv(struct bnxt_re_qp *qp,
 					    struct bnxt_qplib_swqe *wqe,
 					    int payload_size)
 {
+	struct bnxt_re_sqp_entries *sqp_entry;
 	struct bnxt_qplib_sge ref, sge;
+	struct bnxt_re_dev *rdev;
 	u32 rq_prod_index;
-	struct bnxt_re_sqp_entries *sqp_entry;
+
+	rdev = qp->rdev;
 
 	rq_prod_index = bnxt_qplib_get_rq_prod_index(&qp->qplib_qp);
 
@@ -2010,7 +2218,7 @@ static int bnxt_re_build_qp1_shadow_qp_recv(struct bnxt_re_qp *qp,
 	ref.lkey = wqe->sg_list[0].lkey;
 	ref.size = wqe->sg_list[0].size;
 
-	sqp_entry = &qp->rdev->sqp_tbl[rq_prod_index];
+	sqp_entry = &rdev->gsi_ctx.sqp_tbl[rq_prod_index];
 
 	/* SGE 1 */
 	wqe->sg_list[0].addr = sge.addr;
@@ -2830,12 +3038,13 @@ static bool bnxt_re_is_loopback_packet(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
-static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *qp1_qp,
+static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 					 struct bnxt_qplib_cqe *cqe)
 {
-	struct bnxt_re_dev *rdev = qp1_qp->rdev;
+	struct bnxt_re_dev *rdev = gsi_qp->rdev;
 	struct bnxt_re_sqp_entries *sqp_entry = NULL;
-	struct bnxt_re_qp *qp = rdev->qp1_sqp;
+	struct bnxt_re_qp *gsi_sqp = rdev->gsi_ctx.gsi_sqp;
+	struct bnxt_re_ah *gsi_sah;
 	struct ib_send_wr *swr;
 	struct ib_ud_wr udwr;
 	struct ib_recv_wr rwr;
@@ -2858,19 +3067,19 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *qp1_qp,
 	swr = &udwr.wr;
 	tbl_idx = cqe->wr_id;
 
-	rq_hdr_buf = qp1_qp->qplib_qp.rq_hdr_buf +
-			(tbl_idx * qp1_qp->qplib_qp.rq_hdr_buf_size);
-	rq_hdr_buf_map = bnxt_qplib_get_qp_buf_from_index(&qp1_qp->qplib_qp,
+	rq_hdr_buf = gsi_qp->qplib_qp.rq_hdr_buf +
+			(tbl_idx * gsi_qp->qplib_qp.rq_hdr_buf_size);
+	rq_hdr_buf_map = bnxt_qplib_get_qp_buf_from_index(&gsi_qp->qplib_qp,
 							  tbl_idx);
 
 	/* Shadow QP header buffer */
-	shrq_hdr_buf_map = bnxt_qplib_get_qp_buf_from_index(&qp->qplib_qp,
+	shrq_hdr_buf_map = bnxt_qplib_get_qp_buf_from_index(&gsi_qp->qplib_qp,
 							    tbl_idx);
-	sqp_entry = &rdev->sqp_tbl[tbl_idx];
+	sqp_entry = &rdev->gsi_ctx.sqp_tbl[tbl_idx];
 
 	/* Store this cqe */
 	memcpy(&sqp_entry->cqe, cqe, sizeof(struct bnxt_qplib_cqe));
-	sqp_entry->qp1_qp = qp1_qp;
+	sqp_entry->qp1_qp = gsi_qp;
 
 	/* Find packet type from the cqe */
 
@@ -2924,7 +3133,7 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *qp1_qp,
 	rwr.wr_id = tbl_idx;
 	rwr.next = NULL;
 
-	rc = bnxt_re_post_recv_shadow_qp(rdev, qp, &rwr);
+	rc = bnxt_re_post_recv_shadow_qp(rdev, gsi_sqp, &rwr);
 	if (rc) {
 		dev_err(rdev_to_dev(rdev),
 			"Failed to post Rx buffers to shadow QP");
@@ -2936,13 +3145,13 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *qp1_qp,
 	swr->wr_id = tbl_idx;
 	swr->opcode = IB_WR_SEND;
 	swr->next = NULL;
-
-	udwr.ah = &rdev->sqp_ah->ib_ah;
-	udwr.remote_qpn = rdev->qp1_sqp->qplib_qp.id;
-	udwr.remote_qkey = rdev->qp1_sqp->qplib_qp.qkey;
+	gsi_sah = rdev->gsi_ctx.gsi_sah;
+	udwr.ah = &gsi_sah->ib_ah;
+	udwr.remote_qpn = gsi_sqp->qplib_qp.id;
+	udwr.remote_qkey = gsi_sqp->qplib_qp.qkey;
 
 	/* post data received  in the send queue */
-	rc = bnxt_re_post_send_shadow_qp(rdev, qp, swr);
+	rc = bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
 
 	return 0;
 }
@@ -2996,12 +3205,12 @@ static void bnxt_re_process_res_rc_wc(struct ib_wc *wc,
 		wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
 }
 
-static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *qp,
+static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *gsi_sqp,
 					     struct ib_wc *wc,
 					     struct bnxt_qplib_cqe *cqe)
 {
-	struct bnxt_re_dev *rdev = qp->rdev;
-	struct bnxt_re_qp *qp1_qp = NULL;
+	struct bnxt_re_dev *rdev = gsi_sqp->rdev;
+	struct bnxt_re_qp *gsi_qp = NULL;
 	struct bnxt_qplib_cqe *orig_cqe = NULL;
 	struct bnxt_re_sqp_entries *sqp_entry = NULL;
 	int nw_type;
@@ -3011,13 +3220,13 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *qp,
 
 	tbl_idx = cqe->wr_id;
 
-	sqp_entry = &rdev->sqp_tbl[tbl_idx];
-	qp1_qp = sqp_entry->qp1_qp;
+	sqp_entry = &rdev->gsi_ctx.sqp_tbl[tbl_idx];
+	gsi_qp = sqp_entry->qp1_qp;
 	orig_cqe = &sqp_entry->cqe;
 
 	wc->wr_id = sqp_entry->wrid;
 	wc->byte_len = orig_cqe->length;
-	wc->qp = &qp1_qp->ib_qp;
+	wc->qp = &gsi_qp->ib_qp;
 
 	wc->ex.imm_data = orig_cqe->immdata;
 	wc->src_qp = orig_cqe->src_qp;
@@ -3096,7 +3305,7 @@ static int send_phantom_wqe(struct bnxt_re_qp *qp)
 int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 {
 	struct bnxt_re_cq *cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
-	struct bnxt_re_qp *qp;
+	struct bnxt_re_qp *qp, *sh_qp;
 	struct bnxt_qplib_cqe *cqe;
 	int i, ncqe, budget;
 	struct bnxt_qplib_q *sq;
@@ -3160,8 +3369,9 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 
 			switch (cqe->opcode) {
 			case CQ_BASE_CQE_TYPE_REQ:
-				if (qp->rdev->qp1_sqp && qp->qplib_qp.id ==
-				    qp->rdev->qp1_sqp->qplib_qp.id) {
+				sh_qp = qp->rdev->gsi_ctx.gsi_sqp;
+				if (sh_qp &&
+				    qp->qplib_qp.id == sh_qp->qplib_qp.id) {
 					/* Handle this completion with
 					 * the stored completion
 					 */
@@ -3187,7 +3397,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				 * stored in the table
 				 */
 				tbl_idx = cqe->wr_id;
-				sqp_entry = &cq->rdev->sqp_tbl[tbl_idx];
+				sqp_entry = &cq->rdev->gsi_ctx.sqp_tbl[tbl_idx];
 				wc->wr_id = sqp_entry->wrid;
 				bnxt_re_process_res_rawqp1_wc(wc, cqe);
 				break;
@@ -3195,8 +3405,9 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				bnxt_re_process_res_rc_wc(wc, cqe);
 				break;
 			case CQ_BASE_CQE_TYPE_RES_UD:
-				if (qp->rdev->qp1_sqp && qp->qplib_qp.id ==
-				    qp->rdev->qp1_sqp->qplib_qp.id) {
+				sh_qp = qp->rdev->gsi_ctx.gsi_sqp;
+				if (sh_qp &&
+				    qp->qplib_qp.id == sh_qp->qplib_qp.id) {
 					/* Handle this completion with
 					 * the stored completion
 					 */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 793c972..82a5350 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1125,7 +1125,8 @@ static int bnxt_re_query_hwrm_pri2cos(struct bnxt_re_dev *rdev, u8 dir,
 static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
 					struct bnxt_re_qp *qp)
 {
-	return (qp->ib_qp.qp_type == IB_QPT_GSI) || (qp == rdev->qp1_sqp);
+	return (qp->ib_qp.qp_type == IB_QPT_GSI) ||
+	       (qp == rdev->gsi_ctx.gsi_sqp);
 }
 
 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
-- 
1.8.3.1

