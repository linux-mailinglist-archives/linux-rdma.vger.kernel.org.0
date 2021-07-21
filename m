Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED603D08A5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhGUFdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233203AbhGUFcv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0F30610D2;
        Wed, 21 Jul 2021 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626848008;
        bh=lwZkq0QcJB6OO75dmawMQJIIxHMVupKGsQJm/QS0Ako=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ea1FgmfNi1XYHyxA/D3utxecl3SDR+SVWzcCRFXZxMy4zPTDLhthX0H+X0SqGRzBO
         js9Rtfyx2IXCGGdov7Lw9COPmNisgly+h/6TyQBOGr5oCuKVTHVbUYw9pQFH9w58Uf
         B9dOyDl/wTFehF+Dz4nurS8klfkGJ0zuTvGXHDVBOQfSZXMuIqY6lWeYvPTpvqmAZ9
         7jlv0EQfwU3DoWfvV5Ad1Y6EPp0k2WPDQJq6aLHjUzVrWqIjRiZnZCWVbvYrMcFmrA
         e2gsTxF8BEA4plHXkp/bHm4t+jgJ1+aXdljsFsrqE/QA/i20bIVWXXox+r/1iFSVEZ
         BJ99zcFt0FZaA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 6/7] RDMA/core: Properly increment and decrement QP usecnts
Date:   Wed, 21 Jul 2021 09:13:05 +0300
Message-Id: <8057f36af73cebc5e3acfeeea4264f5044734d0c.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The QP usecnts were incremented through QP attributes structure while
decreased through QP itself. Rely on the ib_creat_qp_user() code that
initialized all QP parameters prior returning to the user and increment
exactly like destroy does.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h           |  2 +
 drivers/infiniband/core/uverbs_cmd.c          | 13 +---
 drivers/infiniband/core/uverbs_std_types_qp.c | 13 +---
 drivers/infiniband/core/verbs.c               | 60 ++++++++++---------
 4 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index d28ced053222..d8f464b43dbc 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -320,6 +320,8 @@ struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 			    struct ib_qp_init_attr *attr,
 			    struct ib_udata *udata, struct ib_uqp_object *uobj,
 			    const char *caller);
+void ib_qp_usecnt_inc(struct ib_qp *qp);
+void ib_qp_usecnt_dec(struct ib_qp *qp);
 
 struct rdma_dev_addr;
 int rdma_resolve_ip_route(struct sockaddr *src_addr,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b5153200b8a8..62cafd768d89 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1445,18 +1445,9 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
+	ib_qp_usecnt_inc(qp);
 
-	if (cmd->qp_type != IB_QPT_XRC_TGT) {
-		atomic_inc(&pd->usecnt);
-		if (attr.send_cq)
-			atomic_inc(&attr.send_cq->usecnt);
-		if (attr.recv_cq)
-			atomic_inc(&attr.recv_cq->usecnt);
-		if (attr.srq)
-			atomic_inc(&attr.srq->usecnt);
-		if (ind_tbl)
-			atomic_inc(&ind_tbl->usecnt);
-	} else {
+	if (cmd->qp_type == IB_QPT_XRC_TGT) {
 		/* It is done in _ib_create_qp for other QP types */
 		qp->uobject = obj;
 	}
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 92812f6a21b0..a0e734735ba5 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -258,18 +258,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
+	ib_qp_usecnt_inc(qp);
 
-	if (attr.qp_type != IB_QPT_XRC_TGT) {
-		atomic_inc(&pd->usecnt);
-		if (attr.send_cq)
-			atomic_inc(&attr.send_cq->usecnt);
-		if (attr.recv_cq)
-			atomic_inc(&attr.recv_cq->usecnt);
-		if (attr.srq)
-			atomic_inc(&attr.srq->usecnt);
-		if (attr.rwq_ind_tbl)
-			atomic_inc(&attr.rwq_ind_tbl->usecnt);
-	} else {
+	if (attr.qp_type == IB_QPT_XRC_TGT) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
 					  uobject);
 		atomic_inc(&obj->uxrcd->refcnt);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 612c73861e0d..acf866038277 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1275,6 +1275,36 @@ struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 }
 EXPORT_SYMBOL(_ib_create_qp);
 
+void ib_qp_usecnt_inc(struct ib_qp *qp)
+{
+	if (qp->pd)
+		atomic_inc(&qp->pd->usecnt);
+	if (qp->send_cq)
+		atomic_inc(&qp->send_cq->usecnt);
+	if (qp->recv_cq)
+		atomic_inc(&qp->recv_cq->usecnt);
+	if (qp->srq)
+		atomic_inc(&qp->srq->usecnt);
+	if (qp->rwq_ind_tbl)
+		atomic_inc(&qp->rwq_ind_tbl->usecnt);
+}
+EXPORT_SYMBOL(ib_qp_usecnt_inc);
+
+void ib_qp_usecnt_dec(struct ib_qp *qp)
+{
+	if (qp->rwq_ind_tbl)
+		atomic_dec(&qp->rwq_ind_tbl->usecnt);
+	if (qp->srq)
+		atomic_dec(&qp->srq->usecnt);
+	if (qp->recv_cq)
+		atomic_dec(&qp->recv_cq->usecnt);
+	if (qp->send_cq)
+		atomic_dec(&qp->send_cq->usecnt);
+	if (qp->pd)
+		atomic_dec(&qp->pd->usecnt);
+}
+EXPORT_SYMBOL(ib_qp_usecnt_dec);
+
 /**
  * ib_create_qp_kernel - Creates a kernel QP associated with the specified
  *   protection domain.
@@ -1316,14 +1346,7 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 		return xrc_qp;
 	}
 
-	if (qp_init_attr->recv_cq)
-		atomic_inc(&qp_init_attr->recv_cq->usecnt);
-	if (qp->srq)
-		atomic_inc(&qp_init_attr->srq->usecnt);
-
-	atomic_inc(&pd->usecnt);
-	if (qp_init_attr->send_cq)
-		atomic_inc(&qp_init_attr->send_cq->usecnt);
+	ib_qp_usecnt_inc(qp);
 
 	if (qp_init_attr->cap.max_rdma_ctxs) {
 		ret = rdma_rw_init_mrs(qp, qp_init_attr);
@@ -1981,10 +2004,6 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 {
 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
-	struct ib_pd *pd;
-	struct ib_cq *scq, *rcq;
-	struct ib_srq *srq;
-	struct ib_rwq_ind_table *ind_tbl;
 	struct ib_qp_security *sec;
 	int ret;
 
@@ -1996,11 +2015,6 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (qp->real_qp != qp)
 		return __ib_destroy_shared_qp(qp);
 
-	pd   = qp->pd;
-	scq  = qp->send_cq;
-	rcq  = qp->recv_cq;
-	srq  = qp->srq;
-	ind_tbl = qp->rwq_ind_tbl;
 	sec  = qp->qp_sec;
 	if (sec)
 		ib_destroy_qp_security_begin(sec);
@@ -2020,16 +2034,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 		rdma_put_gid_attr(alt_path_sgid_attr);
 	if (av_sgid_attr)
 		rdma_put_gid_attr(av_sgid_attr);
-	if (pd)
-		atomic_dec(&pd->usecnt);
-	if (scq)
-		atomic_dec(&scq->usecnt);
-	if (rcq)
-		atomic_dec(&rcq->usecnt);
-	if (srq)
-		atomic_dec(&srq->usecnt);
-	if (ind_tbl)
-		atomic_dec(&ind_tbl->usecnt);
+
+	ib_qp_usecnt_dec(qp);
 	if (sec)
 		ib_destroy_qp_security_end(sec);
 
-- 
2.31.1

