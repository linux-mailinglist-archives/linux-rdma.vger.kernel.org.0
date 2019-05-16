Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83198203E5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfEPKxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 06:53:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfEPKxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 06:53:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so2900812wrx.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhKgrS03ULJkE5wcaYViWgVvMaBxrxGk2RqypmKNHqU=;
        b=H5rX+w2fV3PJiDiuz26t5eNMMrk5eN6CA4CFa34uAP6JT4awefm/X4B3vDzOga8XSV
         alv7olYbPXELMjz0eCQutdo74E0JLLsGvoe4K9CNrYVt3Sy3JZ2sENGCCWueZvtmx4FU
         ma3RGtD/rVuHYV1v3yYEKlO2/OSKLqpXLWkbJCVhSHf45NsEg9PFsnIjyh22gip3jSDN
         9Y+M8agwoyHlWwFulJJG185n1/xSmDDJ4NEfvGjyw2p32/71BpzmIEuGHKiPZql3O88U
         Z6NJxyfQ4q3335vXB1pEXMu2nMujw0abhOg5jMXnHmK1Fk0Ib+vByLsWayMoPfBRnpXg
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhKgrS03ULJkE5wcaYViWgVvMaBxrxGk2RqypmKNHqU=;
        b=VE578z3X9vesZzbUKHGTBIWsnEORWdFh4ousAAcV97o/9mr0JJz0k0jAR5KVOiUKLQ
         LFcRC4z2VEnHCsM7luFDgDBbTJmWAkwae9agB0IMFIQI4aVQaR8bvUi95xueUlGdNrYr
         r18896g9q1/EWpKAgzoIN0ZIvzSbnI+fJT8CxHc3hknmeJ8pBxYNcY0IH4wAZv7MGddh
         dkEQbQpuNy+RVy8o2tZRQPTfmKfyk/TuWKigNsitb0kehxJ+Zu3KUE7T7PnOmV+/0yFB
         /2xoYucOCl1PNIIEXO9WtqxtbMnvWmLBI+WjcyPxJ6naIvxjg/2fCVEWVuRXOpcbtUv7
         fDXA==
X-Gm-Message-State: APjAAAXktv1/qpt6OytQzJ5un7M7R2OSALtkCJOZBIPyBEMmbon+o3SR
        c1SsO/WXqvM+E1Mr8zAxPm2ztcI5
X-Google-Smtp-Source: APXvYqyLG50LwR5SCIas1zygBmyOKVD5MLeX/YJzg225er3MB61BKHQVDof1QNDl6UOozhG+WUTRvQ==
X-Received: by 2002:adf:eb91:: with SMTP id t17mr12213115wrn.203.1558004000537;
        Thu, 16 May 2019 03:53:20 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-17-143.red.bezeqint.net. [79.181.17.143])
        by smtp.gmail.com with ESMTPSA id b5sm4545599wrp.92.2019.05.16.03.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 03:53:19 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for RoCE providers
Date:   Thu, 16 May 2019 13:53:08 +0300
Message-Id: <20190516105308.29450-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For RoCE ports the call for ib_modify_port is not meaningful, so
simplify the providers of RoCE by return OK in ib_core.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c              | 23 ++++++-----
 drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
 drivers/infiniband/hw/mlx4/main.c             |  8 ----
 drivers/infiniband/hw/mlx5/main.c             |  6 ---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
 drivers/infiniband/hw/qedr/main.c             |  1 -
 drivers/infiniband/hw/qedr/verbs.c            |  6 ---
 drivers/infiniband/hw/qedr/verbs.h            |  2 -
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 -------------------
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
 14 files changed, 14 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..387497f42ec5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2171,18 +2171,23 @@ int ib_modify_port(struct ib_device *device,
 		   u8 port_num, int port_modify_mask,
 		   struct ib_port_modify *port_modify)
 {
-	int rc;
-
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
-	if (device->ops.modify_port)
-		rc = device->ops.modify_port(device, port_num,
-					     port_modify_mask,
-					     port_modify);
-	else
-		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
-	return rc;
+	/*
+	 * Return OK if this is RoCE. CM calls ib_modify_port() regardless
+	 * of whether port link layer is ETH or IB. For ETH ports, qkey
+	 * violations and port capabilities are not meaningful.
+	 */
+	if (rdma_protocol_roce(device, port_num))
+		return 0;
+
+	if (!device->ops.modify_port)
+		return -EOPNOTSUPP;
+
+	return device->ops.modify_port(device, port_num,
+				       port_modify_mask,
+				       port_modify);
 }
 EXPORT_SYMBOL(ib_modify_port);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8da5f18bf820..fada11f47f0a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -310,12 +310,6 @@ static int hns_roce_modify_device(struct ib_device *ib_dev, int mask,
 	return 0;
 }
 
-static int hns_roce_modify_port(struct ib_device *ib_dev, u8 port_num, int mask,
-				struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
@@ -442,7 +436,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.get_port_immutable = hns_roce_port_immutable,
 	.mmap = hns_roce_mmap,
 	.modify_device = hns_roce_modify_device,
-	.modify_port = hns_roce_modify_port,
 	.modify_qp = hns_roce_modify_qp,
 	.query_ah = hns_roce_query_ah,
 	.query_device = hns_roce_query_device,
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25d09d53b51c..b134adc0531f 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1046,18 +1046,10 @@ static int mlx4_ib_modify_port(struct ib_device *ibdev, u8 port, int mask,
 			       struct ib_port_modify *props)
 {
 	struct mlx4_ib_dev *mdev = to_mdev(ibdev);
-	u8 is_eth = mdev->dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH;
 	struct ib_port_attr attr;
 	u32 cap_mask;
 	int err;
 
-	/* return OK if this is RoCE. CM calls ib_modify_port() regardless
-	 * of whether port link layer is ETH or IB. For ETH ports, qkey
-	 * violations and port capabilities are not meaningful.
-	 */
-	if (is_eth)
-		return 0;
-
 	mutex_lock(&mdev->cap_mask_mutex);
 
 	err = ib_query_port(ibdev, port, &attr);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 687f99172037..22b400bd817d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1558,12 +1558,6 @@ static int mlx5_ib_modify_port(struct ib_device *ibdev, u8 port, int mask,
 	bool is_ib = (mlx5_ib_port_link_layer(ibdev, port) ==
 		      IB_LINK_LAYER_INFINIBAND);
 
-	/* CM layer calls ib_modify_port() regardless of the link layer. For
-	 * Ethernet ports, qkey violation and Port capabilities are meaningless.
-	 */
-	if (!is_ib)
-		return 0;
-
 	if (MLX5_CAP_GEN(dev->mdev, ib_virt) && is_ib) {
 		change_mask = props->clr_port_cap_mask | props->set_port_cap_mask;
 		value = ~props->clr_port_cap_mask | props->set_port_cap_mask;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index fc6c0962dea9..a8d35d2c51ec 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -162,7 +162,6 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.get_port_immutable = ocrdma_port_immutable,
 	.map_mr_sg = ocrdma_map_mr_sg,
 	.mmap = ocrdma_mmap,
-	.modify_port = ocrdma_modify_port,
 	.modify_qp = ocrdma_modify_qp,
 	.poll_cq = ocrdma_poll_cq,
 	.post_recv = ocrdma_post_recv,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 35ec87015792..c4916b5724cb 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -190,12 +190,6 @@ int ocrdma_query_port(struct ib_device *ibdev,
 	return 0;
 }
 
-int ocrdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		       struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int ocrdma_add_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 			   unsigned long len)
 {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index d76aae7ed0d3..1d3d41daa331 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -54,8 +54,6 @@ int ocrdma_arm_cq(struct ib_cq *, enum ib_cq_notify_flags flags);
 int ocrdma_query_device(struct ib_device *, struct ib_device_attr *props,
 			struct ib_udata *uhw);
 int ocrdma_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int ocrdma_modify_port(struct ib_device *, u8 port, int mask,
-		       struct ib_port_modify *props);
 
 enum rdma_protocol_type
 ocrdma_query_protocol(struct ib_device *device, u8 port_num);
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 083c2c00a8e9..825f30bc24dd 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -202,7 +202,6 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.get_link_layer = qedr_link_layer,
 	.map_mr_sg = qedr_map_mr_sg,
 	.mmap = qedr_mmap,
-	.modify_port = qedr_modify_port,
 	.modify_qp = qedr_modify_qp,
 	.modify_srq = qedr_modify_srq,
 	.poll_cq = qedr_poll_cq,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index e52d8761d681..a33489661fef 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -257,12 +257,6 @@ int qedr_query_port(struct ib_device *ibdev, u8 port, struct ib_port_attr *attr)
 	return 0;
 }
 
-int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		     struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int qedr_add_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
 			 unsigned long len)
 {
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9328c80375ef..0675a8713005 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -35,8 +35,6 @@
 int qedr_query_device(struct ib_device *ibdev,
 		      struct ib_device_attr *attr, struct ib_udata *udata);
 int qedr_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int qedr_modify_port(struct ib_device *, u8 port, int mask,
-		     struct ib_port_modify *props);
 
 int qedr_iw_query_gid(struct ib_device *ibdev, u8 port,
 		      int index, union ib_gid *gid);
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 40182297f87f..a523016e3fea 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -164,7 +164,6 @@ static const struct ib_device_ops pvrdma_dev_ops = {
 	.get_port_immutable = pvrdma_port_immutable,
 	.map_mr_sg = pvrdma_map_mr_sg,
 	.mmap = pvrdma_mmap,
-	.modify_port = pvrdma_modify_port,
 	.modify_qp = pvrdma_modify_qp,
 	.poll_cq = pvrdma_poll_cq,
 	.post_recv = pvrdma_post_recv,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index faf7ecd7b3fa..30cd40dfb6a3 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -265,44 +265,6 @@ int pvrdma_modify_device(struct ib_device *ibdev, int mask,
 	return 0;
 }
 
-/**
- * pvrdma_modify_port - modify device port attributes
- * @ibdev: the device to modify
- * @port: the port number
- * @mask: attributes to modify
- * @props: the device properties
- *
- * @return: 0 on success, otherwise negative errno
- */
-int pvrdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		       struct ib_port_modify *props)
-{
-	struct ib_port_attr attr;
-	struct pvrdma_dev *vdev = to_vdev(ibdev);
-	int ret;
-
-	if (mask & ~IB_PORT_SHUTDOWN) {
-		dev_warn(&vdev->pdev->dev,
-			 "unsupported port modify mask %#x\n", mask);
-		return -EOPNOTSUPP;
-	}
-
-	mutex_lock(&vdev->port_mutex);
-	ret = ib_query_port(ibdev, port, &attr);
-	if (ret)
-		goto out;
-
-	vdev->port_cap_mask |= props->set_port_cap_mask;
-	vdev->port_cap_mask &= ~props->clr_port_cap_mask;
-
-	if (mask & IB_PORT_SHUTDOWN)
-		vdev->ib_active = false;
-
-out:
-	mutex_unlock(&vdev->port_mutex);
-	return ret;
-}
-
 /**
  * pvrdma_alloc_ucontext - allocate ucontext
  * @uctx: the uverbs countext
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index 9d7b021e1c59..16b54cbf7560 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -393,8 +393,6 @@ enum rdma_link_layer pvrdma_port_link_layer(struct ib_device *ibdev,
 					    u8 port);
 int pvrdma_modify_device(struct ib_device *ibdev, int mask,
 			 struct ib_device_modify *props);
-int pvrdma_modify_port(struct ib_device *ibdev, u8 port,
-		       int mask, struct ib_port_modify *props);
 int pvrdma_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
 void pvrdma_dealloc_ucontext(struct ib_ucontext *context);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8c3e2a18cfe4..41b56b62a2fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -117,23 +117,6 @@ static int rxe_modify_device(struct ib_device *dev,
 	return 0;
 }
 
-static int rxe_modify_port(struct ib_device *dev,
-			   u8 port_num, int mask, struct ib_port_modify *attr)
-{
-	struct rxe_dev *rxe = to_rdev(dev);
-	struct rxe_port *port;
-
-	port = &rxe->port;
-
-	port->attr.port_cap_flags |= attr->set_port_cap_mask;
-	port->attr.port_cap_flags &= ~attr->clr_port_cap_mask;
-
-	if (mask & IB_PORT_RESET_QKEY_CNTR)
-		port->attr.qkey_viol_cntr = 0;
-
-	return 0;
-}
-
 static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
 					       u8 port_num)
 {
@@ -1138,7 +1121,6 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.mmap = rxe_mmap,
 	.modify_ah = rxe_modify_ah,
 	.modify_device = rxe_modify_device,
-	.modify_port = rxe_modify_port,
 	.modify_qp = rxe_modify_qp,
 	.modify_srq = rxe_modify_srq,
 	.peek_cq = rxe_peek_cq,
-- 
2.20.1

