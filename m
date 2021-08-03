Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD23DF492
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhHCSVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239021AbhHCSVF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 156B961050;
        Tue,  3 Aug 2021 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628014853;
        bh=LIfLn5NmsPlntJOOgDywXl3S3N0YHSnUSg1HMF1luLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmx2MYjVhiq8BrI1QzskRSIto3xiT9U75/qgLDsiF7PFC00KN9w7xCvspBOjtZTn5
         BR6477pLy2kK3jbWja7ivq+h8PL4B1U+ksnVhGADS7JoUdTNPmZJYmzw/I/+SOXq4i
         jBR1Ot7DyNuWiokdSQHXLH04iIQF/puM1DU+854754q9O1ShfnbtHUxskdjCB9ft5h
         Pko9yuWy6PfMrBQEsDk71PQoghnkU+2w4mg265QsPUMfHVjw7Skb8SC07fuCejdXlm
         /DoufwZL4H33ztKJHjIYNr1ZgG471BhGphS96GFaF66QlfZqAEEydZ6Yran6WyrIJM
         YUT6sQ65c74OA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v2 4/7] RDMA/core: Reorganize create QP low-level functions
Date:   Tue,  3 Aug 2021 21:20:35 +0300
Message-Id: <2c08709d86f876c3dfb77684357b2a939e570ca4.1628014762.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628014762.git.leonro@nvidia.com>
References: <cover.1628014762.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The low-level create QP function grew to be larger than any sensible
inline function should be. The inline attribute is not really needed
for that function and can be implemented as exported symbol.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h | 58 ++--------------------
 drivers/infiniband/core/verbs.c     | 74 +++++++++++++++++++++++++----
 include/rdma/ib_verbs.h             | 16 +++++--
 3 files changed, 81 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index c870adecd3a4..d28ced053222 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -316,60 +316,10 @@ struct ib_device *ib_device_get_by_index(const struct net *net, u32 index);
 void nldev_init(void);
 void nldev_exit(void);
 
-static inline struct ib_qp *
-_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
-	      struct ib_qp_init_attr *attr, struct ib_udata *udata,
-	      struct ib_uqp_object *uobj, const char *caller)
-{
-	struct ib_qp *qp;
-	int ret;
-
-	if (!dev->ops.create_qp)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	qp = rdma_zalloc_drv_obj_numa(dev, ib_qp);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
-
-	qp->device = dev;
-	qp->pd = pd;
-	qp->uobject = uobj;
-	qp->real_qp = qp;
-
-	qp->qp_type = attr->qp_type;
-	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
-	qp->srq = attr->srq;
-	qp->event_handler = attr->event_handler;
-	qp->port = attr->port_num;
-	qp->qp_context = attr->qp_context;
-
-	spin_lock_init(&qp->mr_lock);
-	INIT_LIST_HEAD(&qp->rdma_mrs);
-	INIT_LIST_HEAD(&qp->sig_mrs);
-
-	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
-	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
-	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
-	ret = dev->ops.create_qp(qp, attr, udata);
-	if (ret)
-		goto err_create;
-
-	/*
-	 * TODO: The mlx4 internally overwrites send_cq and recv_cq.
-	 * Unfortunately, it is not an easy task to fix that driver.
-	 */
-	qp->send_cq = attr->send_cq;
-	qp->recv_cq = attr->recv_cq;
-
-	rdma_restrack_add(&qp->res);
-	return qp;
-
-err_create:
-	rdma_restrack_put(&qp->res);
-	kfree(qp);
-	return ERR_PTR(ret);
-
-}
+struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
+			    struct ib_qp_init_attr *attr,
+			    struct ib_udata *udata, struct ib_uqp_object *uobj,
+			    const char *caller);
 
 struct rdma_dev_addr;
 int rdma_resolve_ip_route(struct sockaddr *src_addr,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 2090f3c9f689..a7717df83273 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1201,19 +1201,75 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 }
 
 /**
- * ib_create_named_qp - Creates a kernel QP associated with the specified protection
- *   domain.
+ * _ib_create_qp - Creates a QP associated with the specified protection domain
+ * @dev: IB device
  * @pd: The protection domain associated with the QP.
- * @qp_init_attr: A list of initial attributes required to create the
+ * @attr: A list of initial attributes required to create the
  *   QP.  If QP creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created QP.
+ * @udata: User data
+ * @uobj: uverbs obect
  * @caller: caller's build-time module name
- *
- * NOTE: for user qp use ib_create_qp_user with valid udata!
  */
-struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
-				 struct ib_qp_init_attr *qp_init_attr,
-				 const char *caller)
+struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
+			    struct ib_qp_init_attr *attr,
+			    struct ib_udata *udata, struct ib_uqp_object *uobj,
+			    const char *caller)
+{
+	struct ib_qp *qp;
+	int ret;
+
+	if (!dev->ops.create_qp)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	qp = rdma_zalloc_drv_obj_numa(dev, ib_qp);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
+	qp->device = dev;
+	qp->pd = pd;
+	qp->uobject = uobj;
+	qp->real_qp = qp;
+
+	qp->qp_type = attr->qp_type;
+	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
+	qp->srq = attr->srq;
+	qp->event_handler = attr->event_handler;
+	qp->port = attr->port_num;
+	qp->qp_context = attr->qp_context;
+
+	spin_lock_init(&qp->mr_lock);
+	INIT_LIST_HEAD(&qp->rdma_mrs);
+	INIT_LIST_HEAD(&qp->sig_mrs);
+
+	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
+	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
+	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
+	ret = dev->ops.create_qp(qp, attr, udata);
+	if (ret)
+		goto err_create;
+
+	/*
+	 * TODO: The mlx4 internally overwrites send_cq and recv_cq.
+	 * Unfortunately, it is not an easy task to fix that driver.
+	 */
+	qp->send_cq = attr->send_cq;
+	qp->recv_cq = attr->recv_cq;
+
+	rdma_restrack_add(&qp->res);
+	return qp;
+
+err_create:
+	rdma_restrack_put(&qp->res);
+	kfree(qp);
+	return ERR_PTR(ret);
+
+}
+EXPORT_SYMBOL(_ib_create_qp);
+
+struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
+				  struct ib_qp_init_attr *qp_init_attr,
+				  const char *caller)
 {
 	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
 	struct ib_qp *qp;
@@ -1280,7 +1336,7 @@ struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
 	return ERR_PTR(ret);
 
 }
-EXPORT_SYMBOL(ib_create_named_qp);
+EXPORT_SYMBOL(ib_create_qp_kernel);
 
 static const struct {
 	int			valid;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6737582e9e2e..aa7806335cba 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3688,13 +3688,21 @@ static inline int ib_post_srq_recv(struct ib_srq *srq,
 					      bad_recv_wr ? : &dummy);
 }
 
-struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
-				 struct ib_qp_init_attr *qp_init_attr,
-				 const char *caller);
+struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
+				  struct ib_qp_init_attr *qp_init_attr,
+				  const char *caller);
+/**
+ * ib_create_qp - Creates a kernel QP associated with the specific protection
+ * domain.
+ * @pd: The protection domain associated with the QP.
+ * @init_attr: A list of initial attributes required to create the
+ *   QP.  If QP creation succeeds, then the attributes are updated to
+ *   the actual capabilities of the created QP.
+ */
 static inline struct ib_qp *ib_create_qp(struct ib_pd *pd,
 					 struct ib_qp_init_attr *init_attr)
 {
-	return ib_create_named_qp(pd, init_attr, KBUILD_MODNAME);
+	return ib_create_qp_kernel(pd, init_attr, KBUILD_MODNAME);
 }
 
 /**
-- 
2.31.1

