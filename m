Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1554A2C7F71
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 08:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgK3H73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 02:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgK3H73 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 02:59:29 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A94D20719;
        Mon, 30 Nov 2020 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606723129;
        bh=Cu29LQHZRWm2ZXWqyGK5NFUTzRontlRlLRQ1WqAs3p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Og209ZvZHCI+F/3uxn7tUSF8Ik3D5KOl0wG0Dq65XlrGQdFQu2TFgLMEbGRkksaND
         5NghIqoy9x0iaqil2nPFgwSy4GsvpgR+p1W2X2TorcSXmPa/3Nl23YCUYVf961glSw
         4fldriUPztFw/nphvT5EQkjiRQ53TguKySZ0Mz+4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/5] RDMA/uverbs: Check ODP in ib_check_mr_access() as well
Date:   Mon, 30 Nov 2020 09:58:36 +0200
Message-Id: <20201130075839.278575-3-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130075839.278575-1-leon@kernel.org>
References: <20201130075839.278575-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

No reason only one caller checks this. This properly blocks ODP
from the rereg flow if the device does not support ODP.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 19 +++++--------------
 drivers/infiniband/core/uverbs_std_types_mr.c |  2 +-
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 include/rdma/ib_verbs.h                       |  6 +++++-
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c0b4aaf724de..291f7db6aa1e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -708,29 +708,20 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
 		return -EINVAL;
 
-	ret = ib_check_mr_access(cmd.access_flags);
-	if (ret)
-		return ret;
-
 	uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ib_dev);
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
+	ret = ib_check_mr_access(ib_dev, cmd.access_flags);
+	if (ret)
+		goto err_free;
+
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_free;
 	}
 
-	if (cmd.access_flags & IB_ACCESS_ON_DEMAND) {
-		if (!(pd->device->attrs.device_cap_flags &
-		      IB_DEVICE_ON_DEMAND_PAGING)) {
-			pr_debug("ODP support not available\n");
-			ret = -EINVAL;
-			goto err_put;
-		}
-	}
-
 	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
 					 cmd.access_flags,
 					 &attrs->driver_udata);
@@ -803,7 +794,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	}
 
 	if (cmd.flags & IB_MR_REREG_ACCESS) {
-		ret = ib_check_mr_access(cmd.access_flags);
+		ret = ib_check_mr_access(mr->device, cmd.access_flags);
 		if (ret)
 			goto put_uobjs;
 	}
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index dc5856441729..dd4e76b26c74 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -115,7 +115,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	if (!(attr.access_flags & IB_ZERO_BASED))
 		return -EINVAL;
 
-	ret = ib_check_mr_access(attr.access_flags);
+	ret = ib_check_mr_access(ib_dev, attr.access_flags);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index ad0173f62c0e..819c142857d6 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2068,7 +2068,7 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	if (err)
 		return err;
 
-	err = ib_check_mr_access(access);
+	err = ib_check_mr_access(&dev->ib_dev, access);
 	if (err)
 		return err;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7bee8abae35c..4fcbc6d3d0e0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4183,7 +4183,8 @@ struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
 				   struct inode *inode, struct ib_udata *udata);
 int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 
-static inline int ib_check_mr_access(int flags)
+static inline int ib_check_mr_access(struct ib_device *ib_dev,
+				     unsigned int flags)
 {
 	/*
 	 * Local write permission is required if remote write or
@@ -4196,6 +4197,9 @@ static inline int ib_check_mr_access(int flags)
 	if (flags & ~IB_ACCESS_SUPPORTED)
 		return -EINVAL;
 
+	if (flags & IB_ACCESS_ON_DEMAND &&
+	    !(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
+		return -EINVAL;
 	return 0;
 }
 
-- 
2.28.0

