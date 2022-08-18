Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7A598554
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiHROHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245725AbiHROG4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 10:06:56 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA817CA9E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660831591; x=1692367591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n83tqzNhqcF3tZRI/xDfeJ4mbfuk5B8M8j/PVSVjmL8=;
  b=Uhhy1loBWvDS6QCOESlq6KDQkk6T7v/BfmBVSoSnrD1pbKTH+fPNVY9i
   Z3vhG2wPvYPGANwyawt/UioxelfjNvIvclwbMBk2zf+qhS1RwPkQ/OzTy
   CwVDk4+IzDtKekwbzfa4scthbcUBDgiRS3oJkcI/4GgzXqOOVhAI2NqI2
   o=;
X-IronPort-AV: E=Sophos;i="5.93,246,1654560000"; 
   d="scan'208";a="120715539"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 14:05:12 +0000
Received: from EX13D09EUC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com (Postfix) with ESMTPS id 3213544AAE;
        Thu, 18 Aug 2022 14:05:12 +0000 (UTC)
Received: from HFA15-G2116K32.ant.amazon.com (10.43.162.85) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 18 Aug 2022 14:05:07 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Support CQ receive entries with source GID
Date:   Thu, 18 Aug 2022 17:04:49 +0300
Message-ID: <20220818140449.414-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.30.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a parameter for create CQ admin command to set source address on
receive completion descriptors. Report capability for this feature
through query device verb.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
v1 -> v2:
- Add check for CQE size request correctness in efa_create_cq() 
	(comment from Gal Pressman)
- Use bitfields for bool struct members
	(comment from Leon Romanovsky and Jason Gunthorpe)

 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h   |   6 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c           |   5 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h           |   3 +-
 drivers/infiniband/hw/efa/efa_io_defs.h           | 289 ++++++++++++++++++
 drivers/infiniband/hw/efa/efa_verbs.c             |  10 +-
 include/uapi/rdma/efa-abi.h                       |   4 +-
 6 files changed, 311 insertions(+), 6 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_io_defs.h

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 0b0b93b529f3..d4b9226088bd 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -444,7 +444,10 @@ struct efa_admin_create_cq_cmd {
 	/*
 	 * 4:0 : cq_entry_size_words - size of CQ entry in
 	 *    32-bit words, valid values: 4, 8.
-	 * 7:5 : reserved7 - MBZ
+	 * 5 : set_src_addr - If set, source address will be
+	 *    filled on RX completions from unknown senders.
+	 *    Requires 8 words CQ entry size.
+	 * 7:6 : reserved7 - MBZ
 	 */
 	u8 cq_caps_2;
 
@@ -980,6 +983,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
 #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
+#define EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR_MASK           BIT(5)
 
 /* create_cq_resp */
 #define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index fb405da4e1db..8f8885e002ba 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -168,7 +168,10 @@ int efa_com_create_cq(struct efa_com_dev *edev,
 			EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED, 1);
 		create_cmd.eqn = params->eqn;
 	}
-
+	if (params->set_src_addr) {
+		EFA_SET(&create_cmd.cq_caps_2,
+			EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR, 1);
+	}
 	efa_com_set_dma_addr(params->dma_addr,
 			     &create_cmd.cq_ba.mem_addr_high,
 			     &create_cmd.cq_ba.mem_addr_low);
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index c33010bbf9e8..671a04d69fc2 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -75,7 +75,8 @@ struct efa_com_create_cq_params {
 	u16 uarn;
 	u16 eqn;
 	u8 entry_size_in_bytes;
-	bool interrupt_mode_enabled;
+	bool interrupt_mode_enabled : 1;
+	bool set_src_addr : 1;
 };
 
 struct efa_com_create_cq_result {
diff --git a/drivers/infiniband/hw/efa/efa_io_defs.h b/drivers/infiniband/hw/efa/efa_io_defs.h
new file mode 100644
index 000000000000..17ba8984b11e
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_io_defs.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_IO_H_
+#define _EFA_IO_H_
+
+#define EFA_IO_TX_DESC_NUM_BUFS              2
+#define EFA_IO_TX_DESC_NUM_RDMA_BUFS         1
+#define EFA_IO_TX_DESC_INLINE_MAX_SIZE       32
+#define EFA_IO_TX_DESC_IMM_DATA_SIZE         4
+
+enum efa_io_queue_type {
+	/* send queue (of a QP) */
+	EFA_IO_SEND_QUEUE                           = 1,
+	/* recv queue (of a QP) */
+	EFA_IO_RECV_QUEUE                           = 2,
+};
+
+enum efa_io_send_op_type {
+	/* send message */
+	EFA_IO_SEND                                 = 0,
+	/* RDMA read */
+	EFA_IO_RDMA_READ                            = 1,
+};
+
+enum efa_io_comp_status {
+	/* Successful completion */
+	EFA_IO_COMP_STATUS_OK                       = 0,
+	/* Flushed during QP destroy */
+	EFA_IO_COMP_STATUS_FLUSHED                  = 1,
+	/* Internal QP error */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_QP_INTERNAL_ERROR = 2,
+	/* Bad operation type */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_INVALID_OP_TYPE = 3,
+	/* Bad AH */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_INVALID_AH   = 4,
+	/* LKEY not registered or does not match IOVA */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_INVALID_LKEY = 5,
+	/* Message too long */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_BAD_LENGTH   = 6,
+	/* Destination ENI is down or does not run EFA */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_BAD_ADDRESS = 7,
+	/* Connection was reset by remote side */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_ABORT       = 8,
+	/* Bad dest QP number (QP does not exist or is in error state) */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_BAD_DEST_QPN = 9,
+	/* Destination resource not ready (no WQEs posted on RQ) */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_RNR         = 10,
+	/* Receiver SGL too short */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_BAD_LENGTH  = 11,
+	/* Unexpected status returned by responder */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_BAD_STATUS  = 12,
+	/* Unresponsive remote - detected locally */
+	EFA_IO_COMP_STATUS_LOCAL_ERROR_UNRESP_REMOTE = 13,
+};
+
+struct efa_io_tx_meta_desc {
+	/* Verbs-generated Request ID */
+	u16 req_id;
+
+	/*
+	 * control flags
+	 * 3:0 : op_type - operation type: send/rdma/fast mem
+	 *    ops/etc
+	 * 4 : has_imm - immediate_data field carries valid
+	 *    data.
+	 * 5 : inline_msg - inline mode - inline message data
+	 *    follows this descriptor (no buffer descriptors).
+	 *    Note that it is different from immediate data
+	 * 6 : meta_extension - Extended metadata. MBZ
+	 * 7 : meta_desc - Indicates metadata descriptor.
+	 *    Must be set.
+	 */
+	u8 ctrl1;
+
+	/*
+	 * control flags
+	 * 0 : phase
+	 * 1 : reserved25 - MBZ
+	 * 2 : first - Indicates first descriptor in
+	 *    transaction. Must be set.
+	 * 3 : last - Indicates last descriptor in
+	 *    transaction. Must be set.
+	 * 4 : comp_req - Indicates whether completion should
+	 *    be posted, after packet is transmitted. Valid only
+	 *    for the first descriptor
+	 * 7:5 : reserved29 - MBZ
+	 */
+	u8 ctrl2;
+
+	u16 dest_qp_num;
+
+	/*
+	 * If inline_msg bit is set, length of inline message in bytes,
+	 *    otherwise length of SGL (number of buffers).
+	 */
+	u16 length;
+
+	/*
+	 * immediate data: if has_imm is set, then this field is included
+	 *    within Tx message and reported in remote Rx completion.
+	 */
+	u32 immediate_data;
+
+	u16 ah;
+
+	u16 reserved;
+
+	/* Queue key */
+	u32 qkey;
+
+	u8 reserved2[12];
+};
+
+/*
+ * Tx queue buffer descriptor, for any transport type. Preceded by metadata
+ * descriptor.
+ */
+struct efa_io_tx_buf_desc {
+	/* length in bytes */
+	u32 length;
+
+	/*
+	 * 23:0 : lkey - local memory translation key
+	 * 31:24 : reserved - MBZ
+	 */
+	u32 lkey;
+
+	/* Buffer address bits[31:0] */
+	u32 buf_addr_lo;
+
+	/* Buffer address bits[63:32] */
+	u32 buf_addr_hi;
+};
+
+struct efa_io_remote_mem_addr {
+	/* length in bytes */
+	u32 length;
+
+	/* remote memory translation key */
+	u32 rkey;
+
+	/* Buffer address bits[31:0] */
+	u32 buf_addr_lo;
+
+	/* Buffer address bits[63:32] */
+	u32 buf_addr_hi;
+};
+
+struct efa_io_rdma_req {
+	/* Remote memory address */
+	struct efa_io_remote_mem_addr remote_mem;
+
+	/* Local memory address */
+	struct efa_io_tx_buf_desc local_mem[1];
+};
+
+/*
+ * Tx WQE, composed of tx meta descriptors followed by either tx buffer
+ * descriptors or inline data
+ */
+struct efa_io_tx_wqe {
+	/* TX meta */
+	struct efa_io_tx_meta_desc meta;
+
+	union {
+		/* Send buffer descriptors */
+		struct efa_io_tx_buf_desc sgl[2];
+
+		u8 inline_data[32];
+
+		/* RDMA local and remote memory addresses */
+		struct efa_io_rdma_req rdma_req;
+	} data;
+};
+
+/*
+ * Rx buffer descriptor; RX WQE is composed of one or more RX buffer
+ * descriptors.
+ */
+struct efa_io_rx_desc {
+	/* Buffer address bits[31:0] */
+	u32 buf_addr_lo;
+
+	/* Buffer Pointer[63:32] */
+	u32 buf_addr_hi;
+
+	/* Verbs-generated request id. */
+	u16 req_id;
+
+	/* Length in bytes. */
+	u16 length;
+
+	/*
+	 * LKey and control flags
+	 * 23:0 : lkey
+	 * 29:24 : reserved - MBZ
+	 * 30 : first - Indicates first descriptor in WQE
+	 * 31 : last - Indicates last descriptor in WQE
+	 */
+	u32 lkey_ctrl;
+};
+
+/* Common IO completion descriptor */
+struct efa_io_cdesc_common {
+	/*
+	 * verbs-generated request ID, as provided in the completed tx or rx
+	 *    descriptor.
+	 */
+	u16 req_id;
+
+	u8 status;
+
+	/*
+	 * flags
+	 * 0 : phase - Phase bit
+	 * 2:1 : q_type - enum efa_io_queue_type: send/recv
+	 * 3 : has_imm - indicates that immediate data is
+	 *    present - for RX completions only
+	 * 7:4 : reserved28 - MBZ
+	 */
+	u8 flags;
+
+	/* local QP number */
+	u16 qp_num;
+
+	/* Transferred length */
+	u16 length;
+};
+
+/* Tx completion descriptor */
+struct efa_io_tx_cdesc {
+	/* Common completion info */
+	struct efa_io_cdesc_common common;
+};
+
+/* Rx Completion Descriptor */
+struct efa_io_rx_cdesc {
+	/* Common completion info */
+	struct efa_io_cdesc_common common;
+
+	/* Remote Address Handle FW index, 0xFFFF indicates invalid ah */
+	u16 ah;
+
+	u16 src_qp_num;
+
+	/* Immediate data */
+	u32 imm;
+};
+
+/* Extended Rx Completion Descriptor */
+struct efa_io_rx_cdesc_ex {
+	/* Base RX completion info */
+	struct efa_io_rx_cdesc rx_cdesc_base;
+
+	/*
+	 * Valid only in case of unknown AH (0xFFFF) and CQ set_src_addr is
+	 * enabled.
+	 */
+	u8 src_addr[16];
+};
+
+/* tx_meta_desc */
+#define EFA_IO_TX_META_DESC_OP_TYPE_MASK                    GENMASK(3, 0)
+#define EFA_IO_TX_META_DESC_HAS_IMM_MASK                    BIT(4)
+#define EFA_IO_TX_META_DESC_INLINE_MSG_MASK                 BIT(5)
+#define EFA_IO_TX_META_DESC_META_EXTENSION_MASK             BIT(6)
+#define EFA_IO_TX_META_DESC_META_DESC_MASK                  BIT(7)
+#define EFA_IO_TX_META_DESC_PHASE_MASK                      BIT(0)
+#define EFA_IO_TX_META_DESC_FIRST_MASK                      BIT(2)
+#define EFA_IO_TX_META_DESC_LAST_MASK                       BIT(3)
+#define EFA_IO_TX_META_DESC_COMP_REQ_MASK                   BIT(4)
+
+/* tx_buf_desc */
+#define EFA_IO_TX_BUF_DESC_LKEY_MASK                        GENMASK(23, 0)
+
+/* rx_desc */
+#define EFA_IO_RX_DESC_LKEY_MASK                            GENMASK(23, 0)
+#define EFA_IO_RX_DESC_FIRST_MASK                           BIT(30)
+#define EFA_IO_RX_DESC_LAST_MASK                            BIT(31)
+
+/* cdesc_common */
+#define EFA_IO_CDESC_COMMON_PHASE_MASK                      BIT(0)
+#define EFA_IO_CDESC_COMMON_Q_TYPE_MASK                     GENMASK(2, 1)
+#define EFA_IO_CDESC_COMMON_HAS_IMM_MASK                    BIT(3)
+
+#endif /* _EFA_IO_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ecfe70eb5efb..7de46608fec2 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/dma-buf.h>
@@ -15,6 +15,7 @@
 #include <rdma/uverbs_ioctl.h>
 
 #include "efa.h"
+#include "efa_io_defs.h"
 
 enum {
 	EFA_MMAP_DMA_PAGE = 0,
@@ -242,6 +243,7 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rq_wr = dev_attr->max_rq_depth;
 		resp.max_rdma_size = dev_attr->max_rdma_size;
 
+		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID;
 		if (EFA_DEV_CAP(dev, RDMA_READ))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
@@ -1064,6 +1066,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd = {};
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	bool set_src_addr;
 	int err;
 
 	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
@@ -1109,7 +1112,9 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		goto err_out;
 	}
 
-	if (!cmd.cq_entry_size) {
+	set_src_addr = !!(cmd.flags & EFA_CREATE_CQ_WITH_SGID);
+	if ((cmd.cq_entry_size != sizeof(struct efa_io_rx_cdesc_ex)) &&
+		(set_src_addr || cmd.cq_entry_size != sizeof(struct efa_io_rx_cdesc))) {
 		ibdev_dbg(ibdev,
 			  "Invalid entry size [%u]\n", cmd.cq_entry_size);
 		err = -EINVAL;
@@ -1138,6 +1143,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	params.dma_addr = cq->dma_addr;
 	params.entry_size_in_bytes = cmd.cq_entry_size;
 	params.num_sub_cqs = cmd.num_sub_cqs;
+	params.set_src_addr = set_src_addr;
 	if (cmd.flags & EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL) {
 		cq->eq = efa_vec2eq(dev, attr->comp_vector);
 		params.eqn = cq->eq->eeq.eqn;
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 08035ccf1fff..163ac79556d6 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -54,6 +54,7 @@ struct efa_ibv_alloc_pd_resp {
 
 enum {
 	EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL = 1 << 0,
+	EFA_CREATE_CQ_WITH_SGID               = 1 << 1,
 };
 
 struct efa_ibv_create_cq {
@@ -118,6 +119,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
 	EFA_QUERY_DEVICE_CAPS_RNR_RETRY = 1 << 1,
 	EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
+	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.34.1

