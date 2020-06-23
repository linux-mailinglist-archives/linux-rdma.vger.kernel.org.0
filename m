Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90358205056
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgFWLPv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732491AbgFWLPs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:15:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 993E72078A;
        Tue, 23 Jun 2020 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910947;
        bh=L3+TNAxhcq0YD8JTau2bvmbtDlufD54N8yJoPrNtlj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4VVDGpe7M9ZmT6JpEtYvV1NjuTUD4QODKfMfhwayy0jF5L+pYEzKpqTR5FlvqLz6
         qSIb+u/c0eZO9Y/lhCkYFTPHg964ZGBJk12FKf1VdaKTWTzrjiPsy2mkuuUTrWhj3e
         EJ9ZHC7pBlC6r4OqZzdr6dH/4Yhes03q+Mb2k0lU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/2] RDMA: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
Date:   Tue, 23 Jun 2020 14:15:30 +0300
Message-Id: <20200623111531.1227013-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623111531.1227013-1-leon@kernel.org>
References: <20200623111531.1227013-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

ib_alloc_xrcd already does the required initialization, so move
the mlx5 driver and uverbs to call it and save some code duplication,
while cleaning the function argument lists of that function.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 12 +++---------
 drivers/infiniband/core/verbs.c      | 19 +++++++++++++------
 drivers/infiniband/hw/mlx5/main.c    | 24 ++++++++----------------
 include/rdma/ib_verbs.h              | 22 ++++++++++++----------
 4 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 557644dcc923..68c9a0210220 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -614,17 +614,11 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	}
 
 	if (!xrcd) {
-		xrcd = ib_dev->ops.alloc_xrcd(ib_dev, &attrs->driver_udata);
+		xrcd = ib_alloc_xrcd_user(ib_dev, inode, &attrs->driver_udata);
 		if (IS_ERR(xrcd)) {
 			ret = PTR_ERR(xrcd);
 			goto err;
 		}
-
-		xrcd->inode   = inode;
-		xrcd->device  = ib_dev;
-		atomic_set(&xrcd->usecnt, 0);
-		mutex_init(&xrcd->tgt_qp_mutex);
-		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
 		new_xrcd = 1;
 	}
 
@@ -663,7 +657,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	}
 
 err_dealloc_xrcd:
-	ib_dealloc_xrcd(xrcd, uverbs_get_cleared_udata(attrs));
+	ib_dealloc_xrcd_user(xrcd, uverbs_get_cleared_udata(attrs));
 
 err:
 	uobj_alloc_abort(&obj->uobject, attrs);
@@ -701,7 +695,7 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
 	if (inode && !atomic_dec_and_test(&xrcd->usecnt))
 		return 0;
 
-	ret = ib_dealloc_xrcd(xrcd, &attrs->driver_udata);
+	ret = ib_dealloc_xrcd_user(xrcd, &attrs->driver_udata);
 
 	if (ib_is_destroy_retryable(ret, why, uobject)) {
 		atomic_inc(&xrcd->usecnt);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index d70771caf534..d66a0ad62077 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2289,17 +2289,24 @@ int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
 }
 EXPORT_SYMBOL(ib_detach_mcast);
 
-struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
+/**
+ * ib_alloc_xrcd_user - Allocates an XRC domain.
+ * @device: The device on which to allocate the XRC domain.
+ * @inode: inode to connect XRCD
+ * @udata: Valid user data or NULL for kernel object
+ */
+struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
+				   struct inode *inode, struct ib_udata *udata)
 {
 	struct ib_xrcd *xrcd;
 
 	if (!device->ops.alloc_xrcd)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	xrcd = device->ops.alloc_xrcd(device, NULL);
+	xrcd = device->ops.alloc_xrcd(device, udata);
 	if (!IS_ERR(xrcd)) {
 		xrcd->device = device;
-		xrcd->inode = NULL;
+		xrcd->inode = inode;
 		atomic_set(&xrcd->usecnt, 0);
 		mutex_init(&xrcd->tgt_qp_mutex);
 		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
@@ -2307,9 +2314,9 @@ struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
 
 	return xrcd;
 }
-EXPORT_SYMBOL(__ib_alloc_xrcd);
+EXPORT_SYMBOL(ib_alloc_xrcd_user);
 
-int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	struct ib_qp *qp;
 	int ret;
@@ -2327,7 +2334,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 
 	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
 }
-EXPORT_SYMBOL(ib_dealloc_xrcd);
+EXPORT_SYMBOL(ib_dealloc_xrcd_user);
 
 /**
  * ib_create_wq - Creates a WQ associated with the specified protection
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 47a0c091eea5..46c596a855e7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5043,27 +5043,17 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	if (ret)
 		goto err_create_cq;
 
-	devr->x0 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
+	devr->x0 = ib_alloc_xrcd(&dev->ib_dev);
 	if (IS_ERR(devr->x0)) {
 		ret = PTR_ERR(devr->x0);
 		goto error2;
 	}
-	devr->x0->device = &dev->ib_dev;
-	devr->x0->inode = NULL;
-	atomic_set(&devr->x0->usecnt, 0);
-	mutex_init(&devr->x0->tgt_qp_mutex);
-	INIT_LIST_HEAD(&devr->x0->tgt_qp_list);
 
-	devr->x1 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
+	devr->x1 = ib_alloc_xrcd(&dev->ib_dev);
 	if (IS_ERR(devr->x1)) {
 		ret = PTR_ERR(devr->x1);
 		goto error3;
 	}
-	devr->x1->device = &dev->ib_dev;
-	devr->x1->inode = NULL;
-	atomic_set(&devr->x1->usecnt, 0);
-	mutex_init(&devr->x1->tgt_qp_mutex);
-	INIT_LIST_HEAD(&devr->x1->tgt_qp_list);
 
 	memset(&attr, 0, sizeof(attr));
 	attr.attr.max_sge = 1;
@@ -5125,13 +5115,14 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 error6:
 	kfree(devr->s1);
 error5:
+	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
 	mlx5_ib_destroy_srq(devr->s0, NULL);
 err_create:
 	kfree(devr->s0);
 error4:
-	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
+	ib_dealloc_xrcd(devr->x1);
 error3:
-	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
+	ib_dealloc_xrcd(devr->x0);
 error2:
 	mlx5_ib_destroy_cq(devr->c0, NULL);
 err_create_cq:
@@ -5149,10 +5140,11 @@ static void destroy_dev_resources(struct mlx5_ib_resources *devr)
 
 	mlx5_ib_destroy_srq(devr->s1, NULL);
 	kfree(devr->s1);
+	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
 	mlx5_ib_destroy_srq(devr->s0, NULL);
 	kfree(devr->s0);
-	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
-	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
+	ib_dealloc_xrcd(devr->x0);
+	ib_dealloc_xrcd(devr->x1);
 	mlx5_ib_destroy_cq(devr->c0, NULL);
 	kfree(devr->c0);
 	mlx5_ib_dealloc_pd(devr->p0, NULL);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f1e8afe1dd75..f785a4f1e58b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4331,21 +4331,23 @@ int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
  */
 int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 
-/**
- * ib_alloc_xrcd - Allocates an XRC domain.
- * @device: The device on which to allocate the XRC domain.
- * @caller: Module name for kernel consumers
- */
-struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller);
-#define ib_alloc_xrcd(device) \
-	__ib_alloc_xrcd((device), KBUILD_MODNAME)
+struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
+				   struct inode *inode, struct ib_udata *udata);
+static inline struct ib_xrcd *ib_alloc_xrcd(struct ib_device *device)
+{
+	return ib_alloc_xrcd_user(device, NULL, NULL);
+}
 
 /**
- * ib_dealloc_xrcd - Deallocates an XRC domain.
+ * ib_dealloc_xrcd_user - Deallocates an XRC domain.
  * @xrcd: The XRC domain to deallocate.
  * @udata: Valid user data or NULL for kernel object
  */
-int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
+int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
+static inline int ib_dealloc_xrcd(struct ib_xrcd *xrcd)
+{
+	return ib_dealloc_xrcd_user(xrcd, NULL);
+}
 
 static inline int ib_check_mr_access(int flags)
 {
-- 
2.26.2

