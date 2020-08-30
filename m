Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337F256CE1
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Aug 2020 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgH3Ikx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Aug 2020 04:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3Ikp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 04:40:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B72F20BED;
        Sun, 30 Aug 2020 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598776844;
        bh=MLx6OPSmCNGzWVCrCmjkb//h0dzcDikeIuEsGxYGkIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GB/d0QLvKEBcDulkJpGe27dLrOEZa0y4KMGfLSur9ZeZOkOq8qieuIu30uR1ju/e/
         6n+7BWrxpWWrl8vJgoG5DfmHviMxgxbh9cM0pAkA7buE5IV+R+XqTFkFjAEzm4Gw9o
         QFqcbYQAKcti1HlqDAnFL0ACbFRaTUu/FwC7wnyQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 08/10] RDMA: Change XRCD destroy return value
Date:   Sun, 30 Aug 2020 11:40:08 +0300
Message-Id: <20200830084010.102381-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200830084010.102381-1-leon@kernel.org>
References: <20200830084010.102381-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Update XRCD destroy flow to allow command failure.

Fixes: 28ad5f65c314 ("RDMA: Move XRCD to be under ib_core responsibility")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c      | 8 ++++++--
 drivers/infiniband/hw/mlx4/main.c    | 3 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
 drivers/infiniband/hw/mlx5/qp.c      | 4 ++--
 include/rdma/ib_verbs.h              | 2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 80154be9390a..0dec1c8d6744 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2345,13 +2345,17 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
  */
 int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
+	int ret;
+
 	if (atomic_read(&xrcd->usecnt))
 		return -EBUSY;
 
 	WARN_ON(!xa_empty(&xrcd->tgt_qps));
-	xrcd->device->ops.dealloc_xrcd(xrcd, udata);
+	ret = xrcd->device->ops.dealloc_xrcd(xrcd, udata);
+	if (ret && udata)
+		return ret;
 	kfree(xrcd);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(ib_dealloc_xrcd_user);
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 1be0108db992..8e1e3b8a5a0d 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1256,11 +1256,12 @@ static int mlx4_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
 	return err;
 }
 
-static void mlx4_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+static int mlx4_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	ib_destroy_cq(to_mxrcd(xrcd)->cq);
 	ib_dealloc_pd(to_mxrcd(xrcd)->pd);
 	mlx4_xrcd_free(to_mdev(xrcd->device)->dev, to_mxrcd(xrcd)->xrcdn);
+	return 0;
 }
 
 static int add_gid_entry(struct ib_qp *ibqp, union ib_gid *gid)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0a65f7ba40c4..041f9d1d696b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1196,7 +1196,7 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			const struct ib_mad *in, struct ib_mad *out,
 			size_t *out_mad_size, u16 *out_mad_pkey_index);
 int mlx5_ib_alloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
-void mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
+int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
 int mlx5_ib_get_buf_offset(u64 addr, int page_shift, u32 *offset);
 int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port);
 int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 98abb8606f0e..fea837cb2ec4 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4745,12 +4745,12 @@ int mlx5_ib_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
 	return mlx5_cmd_xrcd_alloc(dev->mdev, &xrcd->xrcdn, 0);
 }
 
-void mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
+int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(xrcd->device);
 	u32 xrcdn = to_mxrcd(xrcd)->xrcdn;
 
-	mlx5_cmd_xrcd_dealloc(dev->mdev, xrcdn, 0);
+	return mlx5_cmd_xrcd_dealloc(dev->mdev, xrcdn, 0);
 }
 
 static void mlx5_ib_wq_event(struct mlx5_core_qp *core_qp, int type)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 335189bddbef..1161e18d948a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2458,7 +2458,7 @@ struct ib_device_ops {
 	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*alloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
-	void (*dealloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
+	int (*dealloc_xrcd)(struct ib_xrcd *xrcd, struct ib_udata *udata);
 	struct ib_flow *(*create_flow)(struct ib_qp *qp,
 				       struct ib_flow_attr *flow_attr,
 				       struct ib_udata *udata);
-- 
2.26.2

