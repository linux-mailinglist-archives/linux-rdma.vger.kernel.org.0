Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06A6141E2
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEESkm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 14:40:42 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56422 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEESkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 14:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557081635; x=1588617635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DJnSukhrR1EsN756YFENmdYN4WleQJN1xiK9DBsh6ik=;
  b=lBkDq/v1tSNN3Hn5Be3SQEndYcBCnwHxJxy2odsZgHb1CVMy+S1VB9Kr
   jXeVU2U3xLrXw7fkIAVhS9Lxg+wmnX28VFMyn8jaLZbnn8UTwCescqG8Z
   Lvqh2HqWnRD94pS9CAN3P5mVuP7KGmIWm9noJS5YjuVTIITiwl9bYg/3n
   4=;
X-IronPort-AV: E=Sophos;i="5.60,434,1549929600"; 
   d="scan'208";a="731832796"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 18:40:33 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x45IeSxS005452
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 18:40:32 GMT
Received: from EX13D03EUC001.ant.amazon.com (10.43.164.245) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:31 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D03EUC001.ant.amazon.com (10.43.164.245) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 11:40:29 -0700
Received: from galpress-VirtualBox.hfa16.amazon.com (10.85.90.212) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 5 May 2019 18:40:26 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next v7 02/11] RDMA/efa: Add EFA device definitions
Date:   Sun, 5 May 2019 20:59:22 +0300
Message-ID: <1557079171-19329-3-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557079171-19329-1-git-send-email-galpress@amazon.com>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

EFA PCIe device implements a single Admin Queue (AQ) and Admin Completion Queue
(ACQ) pair to initialize and communicate configuration with the device.
Through this pair, we run set/get commands for querying and configuring the
device, create/modify/destroy queues, and IB specific commands like Address
Handler (AH), Memory Registration (MR) and Protection Domains (PD).

In addition to admin (AQ/ACQ), we have data path queues that get classified as
Queue Pairs (QP) and Completion Queues (CQ).

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 794 ++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_admin_defs.h      | 136 ++++
 drivers/infiniband/hw/efa/efa_common_defs.h     |  18 +
 drivers/infiniband/hw/efa/efa_regs_defs.h       | 113 ++++
 4 files changed, 1061 insertions(+)
 create mode 100644 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_admin_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_common_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_regs_defs.h

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
new file mode 100644
index 000000000000..2be0469d545f
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -0,0 +1,794 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_ADMIN_CMDS_H_
+#define _EFA_ADMIN_CMDS_H_
+
+#define EFA_ADMIN_API_VERSION_MAJOR          0
+#define EFA_ADMIN_API_VERSION_MINOR          1
+
+/* EFA admin queue opcodes */
+enum efa_admin_aq_opcode {
+	EFA_ADMIN_CREATE_QP                         = 1,
+	EFA_ADMIN_MODIFY_QP                         = 2,
+	EFA_ADMIN_QUERY_QP                          = 3,
+	EFA_ADMIN_DESTROY_QP                        = 4,
+	EFA_ADMIN_CREATE_AH                         = 5,
+	EFA_ADMIN_DESTROY_AH                        = 6,
+	EFA_ADMIN_REG_MR                            = 7,
+	EFA_ADMIN_DEREG_MR                          = 8,
+	EFA_ADMIN_CREATE_CQ                         = 9,
+	EFA_ADMIN_DESTROY_CQ                        = 10,
+	EFA_ADMIN_GET_FEATURE                       = 11,
+	EFA_ADMIN_SET_FEATURE                       = 12,
+	EFA_ADMIN_GET_STATS                         = 13,
+	EFA_ADMIN_ALLOC_PD                          = 14,
+	EFA_ADMIN_DEALLOC_PD                        = 15,
+	EFA_ADMIN_ALLOC_UAR                         = 16,
+	EFA_ADMIN_DEALLOC_UAR                       = 17,
+	EFA_ADMIN_MAX_OPCODE                        = 17,
+};
+
+enum efa_admin_aq_feature_id {
+	EFA_ADMIN_DEVICE_ATTR                       = 1,
+	EFA_ADMIN_AENQ_CONFIG                       = 2,
+	EFA_ADMIN_NETWORK_ATTR                      = 3,
+	EFA_ADMIN_QUEUE_ATTR                        = 4,
+	EFA_ADMIN_HW_HINTS                          = 5,
+	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
+};
+
+/* QP transport type */
+enum efa_admin_qp_type {
+	/* Unreliable Datagram */
+	EFA_ADMIN_QP_TYPE_UD                        = 1,
+	/* Scalable Reliable Datagram */
+	EFA_ADMIN_QP_TYPE_SRD                       = 2,
+};
+
+/* QP state */
+enum efa_admin_qp_state {
+	EFA_ADMIN_QP_STATE_RESET                    = 0,
+	EFA_ADMIN_QP_STATE_INIT                     = 1,
+	EFA_ADMIN_QP_STATE_RTR                      = 2,
+	EFA_ADMIN_QP_STATE_RTS                      = 3,
+	EFA_ADMIN_QP_STATE_SQD                      = 4,
+	EFA_ADMIN_QP_STATE_SQE                      = 5,
+	EFA_ADMIN_QP_STATE_ERR                      = 6,
+};
+
+enum efa_admin_get_stats_type {
+	EFA_ADMIN_GET_STATS_TYPE_BASIC              = 0,
+};
+
+enum efa_admin_get_stats_scope {
+	EFA_ADMIN_GET_STATS_SCOPE_ALL               = 0,
+	EFA_ADMIN_GET_STATS_SCOPE_QUEUE             = 1,
+};
+
+enum efa_admin_modify_qp_mask_bits {
+	EFA_ADMIN_QP_STATE_BIT                      = 0,
+	EFA_ADMIN_CUR_QP_STATE_BIT                  = 1,
+	EFA_ADMIN_QKEY_BIT                          = 2,
+	EFA_ADMIN_SQ_PSN_BIT                        = 3,
+	EFA_ADMIN_SQ_DRAINED_ASYNC_NOTIFY_BIT       = 4,
+};
+
+/*
+ * QP allocation sizes, converted by fabric QueuePair (QP) create command
+ * from QP capabilities.
+ */
+struct efa_admin_qp_alloc_size {
+	/* Send descriptor ring size in bytes */
+	u32 send_queue_ring_size;
+
+	/* Max number of WQEs that can be outstanding on send queue. */
+	u32 send_queue_depth;
+
+	/*
+	 * Recv descriptor ring size in bytes, sufficient for user-provided
+	 * number of WQEs
+	 */
+	u32 recv_queue_ring_size;
+
+	/* Max number of WQEs that can be outstanding on recv queue */
+	u32 recv_queue_depth;
+};
+
+struct efa_admin_create_qp_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* Protection Domain associated with this QP */
+	u16 pd;
+
+	/* QP type */
+	u8 qp_type;
+
+	/*
+	 * 0 : sq_virt - If set, SQ ring base address is
+	 *    virtual (IOVA returned by MR registration)
+	 * 1 : rq_virt - If set, RQ ring base address is
+	 *    virtual (IOVA returned by MR registration)
+	 * 7:2 : reserved - MBZ
+	 */
+	u8 flags;
+
+	/*
+	 * Send queue (SQ) ring base physical address. This field is not
+	 * used if this is a Low Latency Queue(LLQ).
+	 */
+	u64 sq_base_addr;
+
+	/* Receive queue (RQ) ring base address. */
+	u64 rq_base_addr;
+
+	/* Index of CQ to be associated with Send Queue completions */
+	u32 send_cq_idx;
+
+	/* Index of CQ to be associated with Recv Queue completions */
+	u32 recv_cq_idx;
+
+	/*
+	 * Memory registration key for the SQ ring, used only when not in
+	 * LLQ mode and base address is virtual
+	 */
+	u32 sq_l_key;
+
+	/*
+	 * Memory registration key for the RQ ring, used only when base
+	 * address is virtual
+	 */
+	u32 rq_l_key;
+
+	/* Requested QP allocation sizes */
+	struct efa_admin_qp_alloc_size qp_alloc_size;
+
+	/* UAR number */
+	u16 uar;
+
+	/* MBZ */
+	u16 reserved;
+
+	/* MBZ */
+	u32 reserved2;
+};
+
+struct efa_admin_create_qp_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* Opaque handle to be used for consequent operations on the QP */
+	u32 qp_handle;
+
+	/* QP number in the given EFA virtual device */
+	u16 qp_num;
+
+	/* MBZ */
+	u16 reserved;
+
+	/* Index of sub-CQ for Send Queue completions */
+	u16 send_sub_cq_idx;
+
+	/* Index of sub-CQ for Receive Queue completions */
+	u16 recv_sub_cq_idx;
+
+	/* SQ doorbell address, as offset to PCIe DB BAR */
+	u32 sq_db_offset;
+
+	/* RQ doorbell address, as offset to PCIe DB BAR */
+	u32 rq_db_offset;
+
+	/*
+	 * low latency send queue ring base address as an offset to PCIe
+	 * MMIO LLQ_MEM BAR
+	 */
+	u32 llq_descriptors_offset;
+};
+
+struct efa_admin_modify_qp_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/*
+	 * Mask indicating which fields should be updated see enum
+	 * efa_admin_modify_qp_mask_bits
+	 */
+	u32 modify_mask;
+
+	/* QP handle returned by create_qp command */
+	u32 qp_handle;
+
+	/* QP state */
+	u32 qp_state;
+
+	/* Override current QP state (before applying the transition) */
+	u32 cur_qp_state;
+
+	/* QKey */
+	u32 qkey;
+
+	/* SQ PSN */
+	u32 sq_psn;
+
+	/* Enable async notification when SQ is drained */
+	u8 sq_drained_async_notify;
+
+	/* MBZ */
+	u8 reserved1;
+
+	/* MBZ */
+	u16 reserved2;
+};
+
+struct efa_admin_modify_qp_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+struct efa_admin_query_qp_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* QP handle returned by create_qp command */
+	u32 qp_handle;
+};
+
+struct efa_admin_query_qp_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* QP state */
+	u32 qp_state;
+
+	/* QKey */
+	u32 qkey;
+
+	/* SQ PSN */
+	u32 sq_psn;
+
+	/* Indicates that draining is in progress */
+	u8 sq_draining;
+
+	/* MBZ */
+	u8 reserved1;
+
+	/* MBZ */
+	u16 reserved2;
+};
+
+struct efa_admin_destroy_qp_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* QP handle returned by create_qp command */
+	u32 qp_handle;
+};
+
+struct efa_admin_destroy_qp_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/*
+ * Create Address Handle command parameters. Must not be called more than
+ * once for the same destination
+ */
+struct efa_admin_create_ah_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* Destination address in network byte order */
+	u8 dest_addr[16];
+
+	/* PD number */
+	u16 pd;
+
+	u16 reserved;
+};
+
+struct efa_admin_create_ah_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* Target interface address handle (opaque) */
+	u16 ah;
+
+	u16 reserved;
+};
+
+struct efa_admin_destroy_ah_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* Target interface address handle (opaque) */
+	u16 ah;
+
+	/* PD number */
+	u16 pd;
+};
+
+struct efa_admin_destroy_ah_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/*
+ * Registration of MemoryRegion, required for QP working with Virtual
+ * Addresses. In standard verbs semantics, region length is limited to 2GB
+ * space, but EFA offers larger MR support for large memory space, to ease
+ * on users working with very large datasets (i.e. full GPU memory mapping).
+ */
+struct efa_admin_reg_mr_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* Protection Domain */
+	u16 pd;
+
+	/* MBZ */
+	u16 reserved16_w1;
+
+	/* Physical Buffer List, each element is page-aligned. */
+	union {
+		/*
+		 * Inline array of guest-physical page addresses of user
+		 * memory pages (optimization for short region
+		 * registrations)
+		 */
+		u64 inline_pbl_array[4];
+
+		/* points to PBL (direct or indirect, chained if needed) */
+		struct efa_admin_ctrl_buff_info pbl;
+	} pbl;
+
+	/* Memory region length, in bytes. */
+	u64 mr_length;
+
+	/*
+	 * flags and page size
+	 * 4:0 : phys_page_size_shift - page size is (1 <<
+	 *    phys_page_size_shift). Page size is used for
+	 *    building the Virtual to Physical address mapping
+	 * 6:5 : reserved - MBZ
+	 * 7 : mem_addr_phy_mode_en - Enable bit for physical
+	 *    memory registration (no translation), can be used
+	 *    only by privileged clients. If set, PBL must
+	 *    contain a single entry.
+	 */
+	u8 flags;
+
+	/*
+	 * permissions
+	 * 0 : local_write_enable - Write permissions: value
+	 *    of 1 needed for RQ buffers and for RDMA write
+	 * 7:1 : reserved1 - remote access flags, etc
+	 */
+	u8 permissions;
+
+	u16 reserved16_w5;
+
+	/* number of pages in PBL (redundant, could be calculated) */
+	u32 page_num;
+
+	/*
+	 * IO Virtual Address associated with this MR. If
+	 * mem_addr_phy_mode_en is set, contains the physical address of
+	 * the region.
+	 */
+	u64 iova;
+};
+
+struct efa_admin_reg_mr_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/*
+	 * L_Key, to be used in conjunction with local buffer references in
+	 * SQ and RQ WQE, or with virtual RQ/CQ rings
+	 */
+	u32 l_key;
+
+	/*
+	 * R_Key, to be used in RDMA messages to refer to remotely accessed
+	 * memory region
+	 */
+	u32 r_key;
+};
+
+struct efa_admin_dereg_mr_cmd {
+	/* Common Admin Queue descriptor */
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/* L_Key, memory region's l_key */
+	u32 l_key;
+};
+
+struct efa_admin_dereg_mr_resp {
+	/* Common Admin Queue completion descriptor */
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+struct efa_admin_create_cq_cmd {
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	/*
+	 * 4:0 : reserved5
+	 * 5 : interrupt_mode_enabled - if set, cq operates
+	 *    in interrupt mode (i.e. CQ events and MSI-X are
+	 *    generated), otherwise - polling
+	 * 6 : virt - If set, ring base address is virtual
+	 *    (IOVA returned by MR registration)
+	 * 7 : reserved6
+	 */
+	u8 cq_caps_1;
+
+	/*
+	 * 4:0 : cq_entry_size_words - size of CQ entry in
+	 *    32-bit words, valid values: 4, 8.
+	 * 7:5 : reserved7
+	 */
+	u8 cq_caps_2;
+
+	/* completion queue depth in # of entries. must be power of 2 */
+	u16 cq_depth;
+
+	/* msix vector assigned to this cq */
+	u32 msix_vector_idx;
+
+	/*
+	 * CQ ring base address, virtual or physical depending on 'virt'
+	 * flag
+	 */
+	struct efa_common_mem_addr cq_ba;
+
+	/*
+	 * Memory registration key for the ring, used only when base
+	 * address is virtual
+	 */
+	u32 l_key;
+
+	/*
+	 * number of sub cqs - must be equal to sub_cqs_per_cq of queue
+	 *    attributes.
+	 */
+	u16 num_sub_cqs;
+
+	/* UAR number */
+	u16 uar;
+};
+
+struct efa_admin_create_cq_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	u16 cq_idx;
+
+	/* actual cq depth in number of entries */
+	u16 cq_actual_depth;
+};
+
+struct efa_admin_destroy_cq_cmd {
+	struct efa_admin_aq_common_desc aq_common_desc;
+
+	u16 cq_idx;
+
+	u16 reserved1;
+};
+
+struct efa_admin_destroy_cq_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/*
+ * EFA AQ Get Statistics command. Extended statistics are placed in control
+ * buffer pointed by AQ entry
+ */
+struct efa_admin_aq_get_stats_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	union {
+		/* command specific inline data */
+		u32 inline_data_w1[3];
+
+		struct efa_admin_ctrl_buff_info control_buffer;
+	} u;
+
+	/* stats type as defined in enum efa_admin_get_stats_type */
+	u8 type;
+
+	/* stats scope defined in enum efa_admin_get_stats_scope */
+	u8 scope;
+
+	u16 scope_modifier;
+};
+
+struct efa_admin_basic_stats {
+	u64 tx_bytes;
+
+	u64 tx_pkts;
+
+	u64 rx_bytes;
+
+	u64 rx_pkts;
+
+	u64 rx_drops;
+};
+
+struct efa_admin_acq_get_stats_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	struct efa_admin_basic_stats basic_stats;
+};
+
+struct efa_admin_get_set_feature_common_desc {
+	/*
+	 * 1:0 : select - 0x1 - current value; 0x3 - default
+	 *    value
+	 * 7:3 : reserved3
+	 */
+	u8 flags;
+
+	/* as appears in efa_admin_aq_feature_id */
+	u8 feature_id;
+
+	/* MBZ */
+	u16 reserved16;
+};
+
+struct efa_admin_feature_device_attr_desc {
+	/* Bitmap of efa_admin_aq_feature_id */
+	u64 supported_features;
+
+	/* Bitmap of supported page sizes in MR registrations */
+	u64 page_size_cap;
+
+	u32 fw_version;
+
+	u32 admin_api_version;
+
+	u32 device_version;
+
+	/* Bar used for SQ and RQ doorbells */
+	u16 db_bar;
+
+	/* Indicates how many bits are used physical address access */
+	u8 phys_addr_width;
+
+	/* Indicates how many bits are used virtual address access */
+	u8 virt_addr_width;
+};
+
+struct efa_admin_feature_queue_attr_desc {
+	/* The maximum number of queue pairs supported */
+	u32 max_qp;
+
+	u32 max_sq_depth;
+
+	/* max send wr used in inline-buf */
+	u32 inline_buf_size;
+
+	u32 max_rq_depth;
+
+	/* The maximum number of completion queues supported per VF */
+	u32 max_cq;
+
+	u32 max_cq_depth;
+
+	/* Number of sub-CQs to be created for each CQ */
+	u16 sub_cqs_per_cq;
+
+	u16 reserved;
+
+	/*
+	 * Maximum number of SGEs (buffs) allowed for a single send work
+	 *    queue element (WQE)
+	 */
+	u16 max_wr_send_sges;
+
+	/* Maximum number of SGEs allowed for a single recv WQE */
+	u16 max_wr_recv_sges;
+
+	/* The maximum number of memory regions supported */
+	u32 max_mr;
+
+	/* The maximum number of pages can be registered */
+	u32 max_mr_pages;
+
+	/* The maximum number of protection domains supported */
+	u32 max_pd;
+
+	/* The maximum number of address handles supported */
+	u32 max_ah;
+
+	/* The maximum size of LLQ in bytes */
+	u32 max_llq_size;
+};
+
+struct efa_admin_feature_aenq_desc {
+	/* bitmask for AENQ groups the device can report */
+	u32 supported_groups;
+
+	/* bitmask for AENQ groups to report */
+	u32 enabled_groups;
+};
+
+struct efa_admin_feature_network_attr_desc {
+	/* Raw address data in network byte order */
+	u8 addr[16];
+
+	u32 mtu;
+};
+
+/*
+ * When hint value is 0, hints capabilities are not supported or driver
+ * should use its own predefined value
+ */
+struct efa_admin_hw_hints {
+	/* value in ms */
+	u16 mmio_read_timeout;
+
+	/* value in ms */
+	u16 driver_watchdog_timeout;
+
+	/* value in ms */
+	u16 admin_completion_timeout;
+
+	/* poll interval in ms */
+	u16 poll_interval;
+};
+
+struct efa_admin_get_feature_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	struct efa_admin_ctrl_buff_info control_buffer;
+
+	struct efa_admin_get_set_feature_common_desc feature_common;
+
+	u32 raw[11];
+};
+
+struct efa_admin_get_feature_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	union {
+		u32 raw[14];
+
+		struct efa_admin_feature_device_attr_desc device_attr;
+
+		struct efa_admin_feature_aenq_desc aenq;
+
+		struct efa_admin_feature_network_attr_desc network_attr;
+
+		struct efa_admin_feature_queue_attr_desc queue_attr;
+
+		struct efa_admin_hw_hints hw_hints;
+	} u;
+};
+
+struct efa_admin_set_feature_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	struct efa_admin_ctrl_buff_info control_buffer;
+
+	struct efa_admin_get_set_feature_common_desc feature_common;
+
+	union {
+		u32 raw[11];
+
+		/* AENQ configuration */
+		struct efa_admin_feature_aenq_desc aenq;
+	} u;
+};
+
+struct efa_admin_set_feature_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	union {
+		u32 raw[14];
+	} u;
+};
+
+struct efa_admin_alloc_pd_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+};
+
+struct efa_admin_alloc_pd_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* PD number */
+	u16 pd;
+
+	/* MBZ */
+	u16 reserved;
+};
+
+struct efa_admin_dealloc_pd_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* PD number */
+	u16 pd;
+
+	/* MBZ */
+	u16 reserved;
+};
+
+struct efa_admin_dealloc_pd_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+struct efa_admin_alloc_uar_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+};
+
+struct efa_admin_alloc_uar_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* UAR number */
+	u16 uar;
+
+	/* MBZ */
+	u16 reserved;
+};
+
+struct efa_admin_dealloc_uar_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* UAR number */
+	u16 uar;
+
+	/* MBZ */
+	u16 reserved;
+};
+
+struct efa_admin_dealloc_uar_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/* asynchronous event notification groups */
+enum efa_admin_aenq_group {
+	EFA_ADMIN_FATAL_ERROR                       = 1,
+	EFA_ADMIN_WARNING                           = 2,
+	EFA_ADMIN_NOTIFICATION                      = 3,
+	EFA_ADMIN_KEEP_ALIVE                        = 4,
+	EFA_ADMIN_AENQ_GROUPS_NUM                   = 5,
+};
+
+enum efa_admin_aenq_notification_syndrom {
+	EFA_ADMIN_SUSPEND                           = 0,
+	EFA_ADMIN_RESUME                            = 1,
+	EFA_ADMIN_UPDATE_HINTS                      = 2,
+};
+
+struct efa_admin_mmio_req_read_less_resp {
+	u16 req_id;
+
+	u16 reg_off;
+
+	/* value is valid when poll is cleared */
+	u32 reg_val;
+};
+
+/* create_qp_cmd */
+#define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
+#define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_SHIFT               1
+#define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
+
+/* reg_mr_cmd */
+#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
+#define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_SHIFT     7
+#define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
+#define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
+
+/* create_cq_cmd */
+#define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_SHIFT 5
+#define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
+#define EFA_ADMIN_CREATE_CQ_CMD_VIRT_SHIFT                  6
+#define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
+#define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
+
+/* get_set_feature_common_desc */
+#define EFA_ADMIN_GET_SET_FEATURE_COMMON_DESC_SELECT_MASK   GENMASK(1, 0)
+
+#endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
new file mode 100644
index 000000000000..c8e0c8b905be
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_ADMIN_H_
+#define _EFA_ADMIN_H_
+
+enum efa_admin_aq_completion_status {
+	EFA_ADMIN_SUCCESS                           = 0,
+	EFA_ADMIN_RESOURCE_ALLOCATION_FAILURE       = 1,
+	EFA_ADMIN_BAD_OPCODE                        = 2,
+	EFA_ADMIN_UNSUPPORTED_OPCODE                = 3,
+	EFA_ADMIN_MALFORMED_REQUEST                 = 4,
+	/* Additional status is provided in ACQ entry extended_status */
+	EFA_ADMIN_ILLEGAL_PARAMETER                 = 5,
+	EFA_ADMIN_UNKNOWN_ERROR                     = 6,
+	EFA_ADMIN_RESOURCE_BUSY                     = 7,
+};
+
+struct efa_admin_aq_common_desc {
+	/*
+	 * 11:0 : command_id
+	 * 15:12 : reserved12
+	 */
+	u16 command_id;
+
+	/* as appears in efa_admin_aq_opcode */
+	u8 opcode;
+
+	/*
+	 * 0 : phase
+	 * 1 : ctrl_data - control buffer address valid
+	 * 2 : ctrl_data_indirect - control buffer address
+	 *    points to list of pages with addresses of control
+	 *    buffers
+	 * 7:3 : reserved3
+	 */
+	u8 flags;
+};
+
+/*
+ * used in efa_admin_aq_entry. Can point directly to control data, or to a
+ * page list chunk. Used also at the end of indirect mode page list chunks,
+ * for chaining.
+ */
+struct efa_admin_ctrl_buff_info {
+	u32 length;
+
+	struct efa_common_mem_addr address;
+};
+
+struct efa_admin_aq_entry {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	union {
+		u32 inline_data_w1[3];
+
+		struct efa_admin_ctrl_buff_info control_buffer;
+	} u;
+
+	u32 inline_data_w4[12];
+};
+
+struct efa_admin_acq_common_desc {
+	/*
+	 * command identifier to associate it with the aq descriptor
+	 * 11:0 : command_id
+	 * 15:12 : reserved12
+	 */
+	u16 command;
+
+	u8 status;
+
+	/*
+	 * 0 : phase
+	 * 7:1 : reserved1
+	 */
+	u8 flags;
+
+	u16 extended_status;
+
+	/*
+	 * indicates to the driver which AQ entry has been consumed by the
+	 *    device and could be reused
+	 */
+	u16 sq_head_indx;
+};
+
+struct efa_admin_acq_entry {
+	struct efa_admin_acq_common_desc acq_common_descriptor;
+
+	u32 response_specific_data[14];
+};
+
+struct efa_admin_aenq_common_desc {
+	u16 group;
+
+	u16 syndrom;
+
+	/*
+	 * 0 : phase
+	 * 7:1 : reserved - MBZ
+	 */
+	u8 flags;
+
+	u8 reserved1[3];
+
+	u32 timestamp_low;
+
+	u32 timestamp_high;
+};
+
+struct efa_admin_aenq_entry {
+	struct efa_admin_aenq_common_desc aenq_common_desc;
+
+	/* command specific inline data */
+	u32 inline_data_w4[12];
+};
+
+/* aq_common_desc */
+#define EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK            GENMASK(11, 0)
+#define EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK                 BIT(0)
+#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_SHIFT            1
+#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_MASK             BIT(1)
+#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_SHIFT   2
+#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK    BIT(2)
+
+/* acq_common_desc */
+#define EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK           GENMASK(11, 0)
+#define EFA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK                BIT(0)
+
+/* aenq_common_desc */
+#define EFA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
+
+#endif /* _EFA_ADMIN_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_common_defs.h b/drivers/infiniband/hw/efa/efa_common_defs.h
new file mode 100644
index 000000000000..c559ec08898e
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_common_defs.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_COMMON_H_
+#define _EFA_COMMON_H_
+
+#define EFA_COMMON_SPEC_VERSION_MAJOR        2
+#define EFA_COMMON_SPEC_VERSION_MINOR        0
+
+struct efa_common_mem_addr {
+	u32 mem_addr_low;
+
+	u32 mem_addr_high;
+};
+
+#endif /* _EFA_COMMON_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_regs_defs.h b/drivers/infiniband/hw/efa/efa_regs_defs.h
new file mode 100644
index 000000000000..bb9cad3d6a15
--- /dev/null
+++ b/drivers/infiniband/hw/efa/efa_regs_defs.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef _EFA_REGS_H_
+#define _EFA_REGS_H_
+
+enum efa_regs_reset_reason_types {
+	EFA_REGS_RESET_NORMAL                       = 0,
+	/* Keep alive timeout */
+	EFA_REGS_RESET_KEEP_ALIVE_TO                = 1,
+	EFA_REGS_RESET_ADMIN_TO                     = 2,
+	EFA_REGS_RESET_INIT_ERR                     = 3,
+	EFA_REGS_RESET_DRIVER_INVALID_STATE         = 4,
+	EFA_REGS_RESET_OS_TRIGGER                   = 5,
+	EFA_REGS_RESET_SHUTDOWN                     = 6,
+	EFA_REGS_RESET_USER_TRIGGER                 = 7,
+	EFA_REGS_RESET_GENERIC                      = 8,
+};
+
+/* efa_registers offsets */
+
+/* 0 base */
+#define EFA_REGS_VERSION_OFF                                0x0
+#define EFA_REGS_CONTROLLER_VERSION_OFF                     0x4
+#define EFA_REGS_CAPS_OFF                                   0x8
+#define EFA_REGS_AQ_BASE_LO_OFF                             0x10
+#define EFA_REGS_AQ_BASE_HI_OFF                             0x14
+#define EFA_REGS_AQ_CAPS_OFF                                0x18
+#define EFA_REGS_ACQ_BASE_LO_OFF                            0x20
+#define EFA_REGS_ACQ_BASE_HI_OFF                            0x24
+#define EFA_REGS_ACQ_CAPS_OFF                               0x28
+#define EFA_REGS_AQ_PROD_DB_OFF                             0x2c
+#define EFA_REGS_AENQ_CAPS_OFF                              0x34
+#define EFA_REGS_AENQ_BASE_LO_OFF                           0x38
+#define EFA_REGS_AENQ_BASE_HI_OFF                           0x3c
+#define EFA_REGS_AENQ_CONS_DB_OFF                           0x40
+#define EFA_REGS_INTR_MASK_OFF                              0x4c
+#define EFA_REGS_DEV_CTL_OFF                                0x54
+#define EFA_REGS_DEV_STS_OFF                                0x58
+#define EFA_REGS_MMIO_REG_READ_OFF                          0x5c
+#define EFA_REGS_MMIO_RESP_LO_OFF                           0x60
+#define EFA_REGS_MMIO_RESP_HI_OFF                           0x64
+
+/* version register */
+#define EFA_REGS_VERSION_MINOR_VERSION_MASK                 0xff
+#define EFA_REGS_VERSION_MAJOR_VERSION_SHIFT                8
+#define EFA_REGS_VERSION_MAJOR_VERSION_MASK                 0xff00
+
+/* controller_version register */
+#define EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_MASK   0xff
+#define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_SHIFT     8
+#define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK      0xff00
+#define EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_SHIFT     16
+#define EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_MASK      0xff0000
+#define EFA_REGS_CONTROLLER_VERSION_IMPL_ID_SHIFT           24
+#define EFA_REGS_CONTROLLER_VERSION_IMPL_ID_MASK            0xff000000
+
+/* caps register */
+#define EFA_REGS_CAPS_CONTIGUOUS_QUEUE_REQUIRED_MASK        0x1
+#define EFA_REGS_CAPS_RESET_TIMEOUT_SHIFT                   1
+#define EFA_REGS_CAPS_RESET_TIMEOUT_MASK                    0x3e
+#define EFA_REGS_CAPS_DMA_ADDR_WIDTH_SHIFT                  8
+#define EFA_REGS_CAPS_DMA_ADDR_WIDTH_MASK                   0xff00
+#define EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT                    16
+#define EFA_REGS_CAPS_ADMIN_CMD_TO_MASK                     0xf0000
+
+/* aq_caps register */
+#define EFA_REGS_AQ_CAPS_AQ_DEPTH_MASK                      0xffff
+#define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_SHIFT                16
+#define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_MASK                 0xffff0000
+
+/* acq_caps register */
+#define EFA_REGS_ACQ_CAPS_ACQ_DEPTH_MASK                    0xffff
+#define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_SHIFT              16
+#define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_MASK               0xff0000
+#define EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_SHIFT             24
+#define EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_MASK              0xff000000
+
+/* aenq_caps register */
+#define EFA_REGS_AENQ_CAPS_AENQ_DEPTH_MASK                  0xffff
+#define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT            16
+#define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK             0xff0000
+#define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_SHIFT           24
+#define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK            0xff000000
+
+/* dev_ctl register */
+#define EFA_REGS_DEV_CTL_DEV_RESET_MASK                     0x1
+#define EFA_REGS_DEV_CTL_AQ_RESTART_SHIFT                   1
+#define EFA_REGS_DEV_CTL_AQ_RESTART_MASK                    0x2
+#define EFA_REGS_DEV_CTL_RESET_REASON_SHIFT                 28
+#define EFA_REGS_DEV_CTL_RESET_REASON_MASK                  0xf0000000
+
+/* dev_sts register */
+#define EFA_REGS_DEV_STS_READY_MASK                         0x1
+#define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_SHIFT       1
+#define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_MASK        0x2
+#define EFA_REGS_DEV_STS_AQ_RESTART_FINISHED_SHIFT          2
+#define EFA_REGS_DEV_STS_AQ_RESTART_FINISHED_MASK           0x4
+#define EFA_REGS_DEV_STS_RESET_IN_PROGRESS_SHIFT            3
+#define EFA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK             0x8
+#define EFA_REGS_DEV_STS_RESET_FINISHED_SHIFT               4
+#define EFA_REGS_DEV_STS_RESET_FINISHED_MASK                0x10
+#define EFA_REGS_DEV_STS_FATAL_ERROR_SHIFT                  5
+#define EFA_REGS_DEV_STS_FATAL_ERROR_MASK                   0x20
+
+/* mmio_reg_read register */
+#define EFA_REGS_MMIO_REG_READ_REQ_ID_MASK                  0xffff
+#define EFA_REGS_MMIO_REG_READ_REG_OFF_SHIFT                16
+#define EFA_REGS_MMIO_REG_READ_REG_OFF_MASK                 0xffff0000
+
+#endif /* _EFA_REGS_H_ */
-- 
2.7.4

