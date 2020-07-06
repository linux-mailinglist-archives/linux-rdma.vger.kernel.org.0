Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F5215736
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgGFM1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgGFM1a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:27:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307C0206E6;
        Mon,  6 Jul 2020 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038449;
        bh=S90AcrniT/VOj92e3p6NcLdBUou1te8Gx4eu3KNxAxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9G7c1pScJ490ycxxLgSEDxptcmBuKIwiEGvuJQW0wiMpQFRuThPc89cNHlgYcfq1
         czw/DXhnBdu8yJU12qBPYkOBWMGN2BP1LecmzUxH5Q8uI7yJDw803ksDG0TAWALN3/
         Fe6xxvpU7zf7xdKViPS1blGS9OtOSY+18XLkx2G0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 2/3] RDMA/core: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
Date:   Mon,  6 Jul 2020 15:27:15 +0300
Message-Id: <20200706122716.647338-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706122716.647338-1-leon@kernel.org>
References: <20200706122716.647338-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

ib_alloc_xrcd already does the required initialization, so move
the uverbs to call it and save code duplication, while cleaning
the function argument lists of that function.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 12 +++---------
 drivers/infiniband/core/verbs.c      | 24 ++++++++++++++++++------
 include/rdma/ib_verbs.h              | 18 +++---------------
 3 files changed, 24 insertions(+), 30 deletions(-)

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
index 732548152d22..b0cb5fa8f808 100644
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
@@ -2307,9 +2314,14 @@ struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
 
 	return xrcd;
 }
-EXPORT_SYMBOL(__ib_alloc_xrcd);
+EXPORT_SYMBOL(ib_alloc_xrcd_user);
 
-int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+/**
+ * ib_dealloc_xrcd_user - Deallocates an XRC domain.
+ * @xrcd: The XRC domain to deallocate.
+ * @udata: Valid user data or NULL for kernel object
+ */
+int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	struct ib_qp *qp;
 	int ret;
@@ -2327,7 +2339,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 
 	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
 }
-EXPORT_SYMBOL(ib_dealloc_xrcd);
+EXPORT_SYMBOL(ib_dealloc_xrcd_user);
 
 /**
  * ib_create_wq - Creates a WQ associated with the specified protection
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3a9eb61b4de0..19cebedb7bbc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4332,21 +4332,9 @@ int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid);
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
-
-/**
- * ib_dealloc_xrcd - Deallocates an XRC domain.
- * @xrcd: The XRC domain to deallocate.
- * @udata: Valid user data or NULL for kernel object
- */
-int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
+struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
+				   struct inode *inode, struct ib_udata *udata);
+int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 
 static inline int ib_check_mr_access(int flags)
 {
-- 
2.26.2

