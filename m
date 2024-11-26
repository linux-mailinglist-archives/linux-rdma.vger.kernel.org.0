Return-Path: <linux-rdma+bounces-6099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FE9D920E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D11283E1B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103F18FC7E;
	Tue, 26 Nov 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="llcJF3+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869917BB6
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604644; cv=none; b=A4Ud3Rg8fV9PI66nbTLhSjjngRiFpkqX+dbF8gJKzE2Dm7HGmxn8u0LvdEV/CS6F3PsjnvyOKggpTbCAiUOIsqm+fPwS+izQ0Bm1iBrDL+wEXPHgJxhZMaDOtMlsO7E5eaNS0XpaUxRodPd+9LjFZ0doAp79TOLnvBE6yaFD6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604644; c=relaxed/simple;
	bh=W8ehrBPRJKU/h7zyzMzxMlMuHL6v2wfz+5Yb6XsAnmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxo3PYPSadOBp5BjMGZVbCg85ToBmt9bZiHICH9VxAdHuKk2c8A1Bh8Gvq3685a2Z5HN0UWqw6rPDrQB5ZWZK+pSnMYw0ZXqWOeyOzUoxJ120pkfLDM7ddvPdqSScED4bwH/OnLBflmCC11z2dAxJkEbf/cNXRdC83giYXftmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=llcJF3+k; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604633; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lSACaPwo5158cGr2kP0s1H2gdhGkG/taikGc6c+NTPQ=;
	b=llcJF3+k86VZckhM0SJ14aeiG8bdFvelw5KJhuj1PPRiZuCL8LrrXQR+ml6PQt4GQW1iDftgNBzL/VPxpoAyp8SFuDtXC4QDTUZpg+dmQOxNo4e2yTWxSPdlnAOe0wDcFzVE02Xi7pQZjEJ6ItFy1FdJBXTmF4RrQd9oW4CyXa8=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKHPI-U_1732604632 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:03:53 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
Date: Tue, 26 Nov 2024 14:59:07 +0800
Message-ID: <20241126070351.92787-2-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
the protocol used by the erdma device. Since each protocol requires
different ib_device_ops, we introduce the erdma_device_ops_iwarp and
erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.

Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/Kconfig       |  2 +-
 drivers/infiniband/hw/erdma/erdma.h       |  3 +-
 drivers/infiniband/hw/erdma/erdma_hw.h    |  7 ++++
 drivers/infiniband/hw/erdma/erdma_main.c  | 47 ++++++++++++++++++-----
 drivers/infiniband/hw/erdma/erdma_verbs.c | 16 +++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++++
 6 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/Kconfig b/drivers/infiniband/hw/erdma/Kconfig
index 169038e3ceb1..267fc1f3c42a 100644
--- a/drivers/infiniband/hw/erdma/Kconfig
+++ b/drivers/infiniband/hw/erdma/Kconfig
@@ -5,7 +5,7 @@ config INFINIBAND_ERDMA
 	depends on INFINIBAND_ADDR_TRANS
 	depends on INFINIBAND_USER_ACCESS
 	help
-	  This is a RDMA/iWarp driver for Alibaba Elastic RDMA Adapter(ERDMA),
+	  This is a RDMA driver for Alibaba Elastic RDMA Adapter(ERDMA),
 	  which supports RDMA features in Alibaba cloud environment.
 
 	  To compile this driver as module, choose M here. The module will be
diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 3c166359448d..ad4dc1a4bdc7 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -16,7 +16,7 @@
 #include "erdma_hw.h"
 
 #define DRV_MODULE_NAME "erdma"
-#define ERDMA_NODE_DESC "Elastic RDMA(iWARP) stack"
+#define ERDMA_NODE_DESC "Elastic RDMA Adapter stack"
 
 struct erdma_eq {
 	void *qbuf;
@@ -215,6 +215,7 @@ struct erdma_dev {
 
 	struct dma_pool *db_pool;
 	struct dma_pool *resp_pool;
+	enum erdma_proto_type proto;
 };
 
 static inline void *get_queue_entry(void *qbuf, u32 idx, u32 depth, u32 shift)
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 05978f3b1475..970b392d4fb4 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -21,8 +21,15 @@
 #define ERDMA_NUM_MSIX_VEC 32U
 #define ERDMA_MSIX_VECTOR_CMDQ 0
 
+/* erdma device protocol type */
+enum erdma_proto_type {
+	ERDMA_PROTO_IWARP = 0,
+	ERDMA_PROTO_ROCEV2 = 1,
+};
+
 /* PCIe Bar0 Registers. */
 #define ERDMA_REGS_VERSION_REG 0x0
+#define ERDMA_REGS_DEV_PROTO_REG 0xC
 #define ERDMA_REGS_DEV_CTRL_REG 0x10
 #define ERDMA_REGS_DEV_ST_REG 0x14
 #define ERDMA_REGS_NETDEV_MAC_L_REG 0x18
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 62f497a71004..b6706c74cd96 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -172,6 +172,12 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 {
 	int ret;
 
+	dev->proto = erdma_reg_read32(dev, ERDMA_REGS_DEV_PROTO_REG);
+	if (!erdma_device_iwarp(dev) && !erdma_device_rocev2(dev)) {
+		dev_err(&pdev->dev, "Unsupported protocol: %d\n", dev->proto);
+		return -ENODEV;
+	}
+
 	dev->resp_pool = dma_pool_create("erdma_resp_pool", &pdev->dev,
 					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
 					 0);
@@ -474,6 +480,21 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
 		bitmap_free(dev->res_cb[i].bitmap);
 }
 
+static const struct ib_device_ops erdma_device_ops_rocev2 = {
+	.get_link_layer = erdma_get_link_layer,
+};
+
+static const struct ib_device_ops erdma_device_ops_iwarp = {
+	.iw_accept = erdma_accept,
+	.iw_add_ref = erdma_qp_get_ref,
+	.iw_connect = erdma_connect,
+	.iw_create_listen = erdma_create_listen,
+	.iw_destroy_listen = erdma_destroy_listen,
+	.iw_get_qp = erdma_get_ibqp,
+	.iw_reject = erdma_reject,
+	.iw_rem_ref = erdma_qp_put_ref,
+};
+
 static const struct ib_device_ops erdma_device_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_ERDMA,
@@ -494,14 +515,6 @@ static const struct ib_device_ops erdma_device_ops = {
 	.get_dma_mr = erdma_get_dma_mr,
 	.get_hw_stats = erdma_get_hw_stats,
 	.get_port_immutable = erdma_get_port_immutable,
-	.iw_accept = erdma_accept,
-	.iw_add_ref = erdma_qp_get_ref,
-	.iw_connect = erdma_connect,
-	.iw_create_listen = erdma_create_listen,
-	.iw_destroy_listen = erdma_destroy_listen,
-	.iw_get_qp = erdma_get_ibqp,
-	.iw_reject = erdma_reject,
-	.iw_rem_ref = erdma_qp_put_ref,
 	.map_mr_sg = erdma_map_mr_sg,
 	.mmap = erdma_mmap,
 	.mmap_free = erdma_mmap_free,
@@ -522,6 +535,18 @@ static const struct ib_device_ops erdma_device_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_qp, erdma_qp, ibqp),
 };
 
+static void erdma_device_init_iwarp(struct ib_device *ibdev)
+{
+	ibdev->node_type = RDMA_NODE_RNIC;
+	ib_set_device_ops(ibdev, &erdma_device_ops_iwarp);
+}
+
+static void erdma_device_init_rocev2(struct ib_device *ibdev)
+{
+	ibdev->node_type = RDMA_NODE_IB_CA;
+	ib_set_device_ops(ibdev, &erdma_device_ops_rocev2);
+}
+
 static int erdma_ib_device_add(struct pci_dev *pdev)
 {
 	struct erdma_dev *dev = pci_get_drvdata(pdev);
@@ -537,7 +562,11 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	ibdev->node_type = RDMA_NODE_RNIC;
+	if (erdma_device_iwarp(dev))
+		erdma_device_init_iwarp(&dev->ibdev);
+	else
+		erdma_device_init_rocev2(&dev->ibdev);
+
 	memcpy(ibdev->node_desc, ERDMA_NODE_DESC, sizeof(ERDMA_NODE_DESC));
 
 	/*
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 51d619edb6c5..3b7e55515cfd 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -395,8 +395,17 @@ int erdma_query_port(struct ib_device *ibdev, u32 port,
 int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
 			     struct ib_port_immutable *port_immutable)
 {
+	struct erdma_dev *dev = to_edev(ibdev);
+
+	if (erdma_device_iwarp(dev)) {
+		port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
+	} else {
+		port_immutable->core_cap_flags =
+			RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+		port_immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+	}
+
 	port_immutable->gid_tbl_len = 1;
-	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
 
 	return 0;
 }
@@ -1839,3 +1848,8 @@ int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 
 	return stats->num_counters;
 }
+
+enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev, u32 port_num)
+{
+	return IB_LINK_LAYER_ETHERNET;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index c998acd39a78..90e2b35a0973 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -291,6 +291,16 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 void erdma_qp_llp_close(struct erdma_qp *qp);
 void erdma_qp_cm_drop(struct erdma_qp *qp);
 
+static inline bool erdma_device_iwarp(struct erdma_dev *dev)
+{
+	return dev->proto == ERDMA_PROTO_IWARP;
+}
+
+static inline bool erdma_device_rocev2(struct erdma_dev *dev)
+{
+	return dev->proto == ERDMA_PROTO_ROCEV2;
+}
+
 static inline struct erdma_ucontext *to_ectx(struct ib_ucontext *ibctx)
 {
 	return container_of(ibctx, struct erdma_ucontext, ibucontext);
@@ -370,5 +380,7 @@ struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
 						u32 port_num);
 int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		       u32 port, int index);
+enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
+					  u32 port_num);
 
 #endif
-- 
2.43.5


