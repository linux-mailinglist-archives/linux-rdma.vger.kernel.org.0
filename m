Return-Path: <linux-rdma+bounces-6404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEFA9EC1F5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1971188B96F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6771FC0F8;
	Wed, 11 Dec 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lhFrMFSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591A1FBCA7
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882984; cv=none; b=G4AOP3HMHv3LQhP6JAW+Isr9JJqwrYn/hWNqJpJrIebg0lXrVQELM1UNsfHybZFJDZxaRa3Nb1LBkAj/ZoKTvlOTbS59s1E/4pMNQprzus7yZpKhCc79tyY+JoVHZg4UN0wYjBl+nc4HHuaq/qZ+mKJDqDLDkCHrmEWcTwDfCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882984; c=relaxed/simple;
	bh=g3J/ccupsuJHOP4vgoT2zMnnIwoSdw7C8xxTn5sB4oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpRdijcngykMXeozy5PYtZatbCAGdVkIu+G+ELfX4ONDnNyCTx9cnRbDCRr4DPK6tjqC7yfGnhJv6o9W1/63X1dELTHzmnzjB6Vay2NeT/mlvvBiI9ZaAmAELyPcEzrahxwo20hbzGL7o4C423Aaqwau4jLcbQ1b+SYfg9Qrct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lhFrMFSe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882974; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pggvjnqjcEYQjTpdgMUoK32HepvaRsI1aHtgFNyWBTY=;
	b=lhFrMFSe7hFK/U/RpMRD65L+ntyKe5d6MI3YKeOcJj2Q+0qpZLOZv2c1fYfWoUo2HcWPNhC06n8jLJNMhaqOsIB5ib6slYVJvwkiVYm3e7zxdL7SxORtW1qcT90iX8zd/waH19C67T1vmMbdrTkdFrKY34zwuEBXdVtilzb+W+Q=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WLGS1IX_1733882972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:09:33 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next v2 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
Date: Wed, 11 Dec 2024 10:09:01 +0800
Message-ID: <20241211020930.68833-2-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
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
 drivers/infiniband/hw/erdma/erdma_hw.h    |  7 +++++
 drivers/infiniband/hw/erdma/erdma_main.c  | 34 +++++++++++++++++------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 16 ++++++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++++++
 6 files changed, 62 insertions(+), 12 deletions(-)

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
index 62f497a71004..cf97bb79e595 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -172,6 +172,8 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 {
 	int ret;
 
+	dev->proto = erdma_reg_read32(dev, ERDMA_REGS_DEV_PROTO_REG);
+
 	dev->resp_pool = dma_pool_create("erdma_resp_pool", &pdev->dev,
 					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
 					 0);
@@ -474,6 +476,21 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
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
@@ -494,14 +511,6 @@ static const struct ib_device_ops erdma_device_ops = {
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
@@ -537,7 +546,14 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	ibdev->node_type = RDMA_NODE_RNIC;
+	if (erdma_device_iwarp(dev)) {
+		ibdev->node_type = RDMA_NODE_RNIC;
+		ib_set_device_ops(ibdev, &erdma_device_ops_iwarp);
+	} else {
+		ibdev->node_type = RDMA_NODE_IB_CA;
+		ib_set_device_ops(ibdev, &erdma_device_ops_rocev2);
+	}
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


