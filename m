Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FA25FA2E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgIGMLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbgIGMLY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:11:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77C1215A4;
        Mon,  7 Sep 2020 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480587;
        bh=Vgy2H6t3Q5G4mfvUEpURV6WtTk6IuURmsUE5r1zfcM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1CtUOdK71pk6fPP5asKibKjLm9DtxAUMz3qxHBMWG01VcyQbwLUK+P4ykKCpO3G+
         pxkLeTcxxUCqHFmS5BP9r7gt58SEEZE4C9rrEFwY2gS07dPOv1eWscj2GIGnHXygIp
         Ztt9reiTuxRSyVBUNUIS4z1J+LdgKnB8v4zJFdiY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v2 7/9] RDMA: Change XRCD destroy return value
Date:   Mon,  7 Sep 2020 15:09:19 +0300
Message-Id: <20200907120921.476363-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
References: <20200907120921.476363-1-leon@kernel.org>
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
index 93503f10bcbb..117265616cd0 100644
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
+	if (ret)
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
index db1732fb3089..606f7f559922 100644
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
index 96f6be189993..739e390936f3 100644
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

