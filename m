Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A906D67C8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjDDPob (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjDDPo3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 11:44:29 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74615592
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1680623053; x=1712159053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0sV43QZm4PxuJn77hJHwmajdZm6EJrKz9UbWDiyQy3I=;
  b=hQJJ4yd6yXljFFMrJrMX+Hih0QNGg9uBhGlreL5TxnlI5fJNgh3U1rgP
   ksYH9+Z0ndS79elTg65n7uBcvCNh9si50iQed/8PqbD2GviHRxt2XJP7C
   aRyCzd+0nnaaDm6Rue4h0jsjeLBSiByl4QenOJMojdkWGSVR9sLk63sAb
   c=;
X-IronPort-AV: E=Sophos;i="5.98,318,1673913600"; 
   d="scan'208";a="314683094"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 15:43:18 +0000
Received: from EX19D007EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 417AA819C6;
        Tue,  4 Apr 2023 15:43:15 +0000 (UTC)
Received: from EX19D031EUC003.ant.amazon.com (10.252.61.172) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 15:43:15 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D031EUC003.ant.amazon.com (10.252.61.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 15:43:15 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Tue, 4 Apr 2023 15:43:14 +0000
From:   <ynachum@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <matua@amazon.com>
CC:     <mrgolin@amazon.com>, Yonatan Nachum <ynachum@amazon.com>,
        Firas Jahjah <firasj@amazon.com>
Subject: [PATCH] RDMA/efa: Add rdma write capability to device caps
Date:   Tue, 4 Apr 2023 15:43:13 +0000
Message-ID: <20230404154313.35194-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yonatan Nachum <ynachum@amazon.com>

Add rdma write capability that is propagated from the device to
rdma-core.
Enable MR creation with remote write permissions according to this
device capability.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 12 ++++--
 drivers/infiniband/hw/efa/efa_io_defs.h       | 42 +++++++++++++------
 drivers/infiniband/hw/efa/efa_verbs.c         |  6 ++-
 include/uapi/rdma/efa-abi.h                   |  1 +
 4 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 3db791e6c030..4e93ef7f84ee 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -376,7 +376,9 @@ struct efa_admin_reg_mr_cmd {
 	 * 0 : local_write_enable - Local write permissions:
 	 *    must be set for RQ buffers and buffers posted for
 	 *    RDMA Read requests
-	 * 1 : reserved1 - MBZ
+	 * 1 : remote_write_enable - Remote write
+	 *    permissions: must be set to enable RDMA write to
+	 *    the region
 	 * 2 : remote_read_enable - Remote read permissions:
 	 *    must be set to enable RDMA read from the region
 	 * 7:3 : reserved2 - MBZ
@@ -620,7 +622,9 @@ struct efa_admin_feature_device_attr_desc {
 	 *    modify QP command
 	 * 2 : data_polling_128 - If set, 128 bytes data
 	 *    polling is supported
-	 * 31:3 : reserved - MBZ
+	 * 3 : rdma_write - If set, RDMA Write is supported
+	 *    on TX queues
+	 * 31:4 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -674,7 +678,7 @@ struct efa_admin_feature_queue_attr_desc {
 	/* The maximum size of LLQ in bytes */
 	u32 max_llq_size;
 
-	/* Maximum number of SGEs for a single RDMA read WQE */
+	/* Maximum number of SGEs for a single RDMA read/write WQE */
 	u16 max_wr_rdma_sges;
 
 	/*
@@ -979,6 +983,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
 #define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
+#define EFA_ADMIN_REG_MR_CMD_REMOTE_WRITE_ENABLE_MASK       BIT(1)
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_MASK        BIT(2)
 
 /* create_cq_cmd */
@@ -994,6 +999,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_DATA_POLLING_128_MASK BIT(2)
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_WRITE_MASK  BIT(3)
 
 /* create_eq_cmd */
 #define EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS_MASK       GENMASK(4, 0)
diff --git a/drivers/infiniband/hw/efa/efa_io_defs.h b/drivers/infiniband/hw/efa/efa_io_defs.h
index 17ba8984b11e..2d8eb96eaa81 100644
--- a/drivers/infiniband/hw/efa/efa_io_defs.h
+++ b/drivers/infiniband/hw/efa/efa_io_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_IO_H_
@@ -23,6 +23,8 @@ enum efa_io_send_op_type {
 	EFA_IO_SEND                                 = 0,
 	/* RDMA read */
 	EFA_IO_RDMA_READ                            = 1,
+	/* RDMA write */
+	EFA_IO_RDMA_WRITE                           = 2,
 };
 
 enum efa_io_comp_status {
@@ -62,8 +64,7 @@ struct efa_io_tx_meta_desc {
 
 	/*
 	 * control flags
-	 * 3:0 : op_type - operation type: send/rdma/fast mem
-	 *    ops/etc
+	 * 3:0 : op_type - enum efa_io_send_op_type
 	 * 4 : has_imm - immediate_data field carries valid
 	 *    data.
 	 * 5 : inline_msg - inline mode - inline message data
@@ -219,21 +220,22 @@ struct efa_io_cdesc_common {
 	 * 2:1 : q_type - enum efa_io_queue_type: send/recv
 	 * 3 : has_imm - indicates that immediate data is
 	 *    present - for RX completions only
-	 * 7:4 : reserved28 - MBZ
+	 * 6:4 : op_type - enum efa_io_send_op_type
+	 * 7 : reserved31 - MBZ
 	 */
 	u8 flags;
 
 	/* local QP number */
 	u16 qp_num;
-
-	/* Transferred length */
-	u16 length;
 };
 
 /* Tx completion descriptor */
 struct efa_io_tx_cdesc {
 	/* Common completion info */
 	struct efa_io_cdesc_common common;
+
+	/* MBZ */
+	u16 reserved16;
 };
 
 /* Rx Completion Descriptor */
@@ -241,6 +243,9 @@ struct efa_io_rx_cdesc {
 	/* Common completion info */
 	struct efa_io_cdesc_common common;
 
+	/* Transferred length bits[15:0] */
+	u16 length;
+
 	/* Remote Address Handle FW index, 0xFFFF indicates invalid ah */
 	u16 ah;
 
@@ -250,16 +255,26 @@ struct efa_io_rx_cdesc {
 	u32 imm;
 };
 
+/* Rx Completion Descriptor RDMA write info */
+struct efa_io_rx_cdesc_rdma_write {
+	/* Transferred length bits[31:16] */
+	u16 length_hi;
+};
+
 /* Extended Rx Completion Descriptor */
 struct efa_io_rx_cdesc_ex {
 	/* Base RX completion info */
-	struct efa_io_rx_cdesc rx_cdesc_base;
+	struct efa_io_rx_cdesc base;
 
-	/*
-	 * Valid only in case of unknown AH (0xFFFF) and CQ set_src_addr is
-	 * enabled.
-	 */
-	u8 src_addr[16];
+	union {
+		struct efa_io_rx_cdesc_rdma_write rdma_write;
+
+		/*
+		 * Valid only in case of unknown AH (0xFFFF) and CQ
+		 * set_src_addr is enabled.
+		 */
+		u8 src_addr[16];
+	} u;
 };
 
 /* tx_meta_desc */
@@ -285,5 +300,6 @@ struct efa_io_rx_cdesc_ex {
 #define EFA_IO_CDESC_COMMON_PHASE_MASK                      BIT(0)
 #define EFA_IO_CDESC_COMMON_Q_TYPE_MASK                     GENMASK(2, 1)
 #define EFA_IO_CDESC_COMMON_HAS_IMM_MASK                    BIT(3)
+#define EFA_IO_CDESC_COMMON_OP_TYPE_MASK                    GENMASK(6, 4)
 
 #endif /* _EFA_IO_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index c27c36418f7f..a394011a598c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -253,6 +253,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, DATA_POLLING_128))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128;
 
+		if (EFA_DEV_CAP(dev, RDMA_WRITE))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_WRITE;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
@@ -1571,7 +1574,8 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 
 	supp_access_flags =
 		IB_ACCESS_LOCAL_WRITE |
-		(EFA_DEV_CAP(dev, RDMA_READ) ? IB_ACCESS_REMOTE_READ : 0);
+		(EFA_DEV_CAP(dev, RDMA_READ) ? IB_ACCESS_REMOTE_READ : 0) |
+		(EFA_DEV_CAP(dev, RDMA_WRITE) ? IB_ACCESS_REMOTE_WRITE : 0);
 
 	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~supp_access_flags) {
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 74406b4817ce..d94c32f28804 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -121,6 +121,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
 	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
+	EFA_QUERY_DEVICE_CAPS_RDMA_WRITE = 1 << 5,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.39.2

