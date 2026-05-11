Return-Path: <linux-rdma+bounces-20418-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GU/ITFaAmosrgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20418-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E46517009
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CE330347D5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171E35675F;
	Mon, 11 May 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="V0iZ4ggq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D706308F23
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539054; cv=none; b=NxdUK0rCbw18Tyg5oi/QxJ4X737PiP0UUBSoxH8wPKizEYXOCVq65bAYuhu8mQh51tBX8PCHtDvl2S2xdiQHlcbj97PnFuWmUBBc8UtSG2Q2u3NIrHP4kUmZWIK3EWzlcKx86l0/mkxtyRmzj4vtDrmIBq7RLljfaMakVBfWkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539054; c=relaxed/simple;
	bh=HKe1TK3ta1xYUCYF9k9bQtayWWX31HAQxyZM5e4tbrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE3FDzyj0l9q18K8rfa2U2HTFQqjOot7NZf60l7DsFlTyvo3PSp4fcP4VRiIFknOAqE/t12Bf5SQgRbZkwBbYH+4X+4RvM75A/lJcwnJE4pIruYcfZwOCMTWGtd3cn82yoMPnHruwjB6cMv0xmbDoHIYt18jKYrZ4EQSTr+2+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=V0iZ4ggq; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778539053; x=1810075053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Brn6NDeaYkKtIz6QhUB0Y7c5dwhHe/mfm2pJH5clBiI=;
  b=V0iZ4ggqkEKIFUWgeHInxDl7NsESBN5JnHyN0ELIZYZey6Y7sWNBmtXW
   xibyDJPPC44rIZ8BJh9sk6feeVxU5UNZ5bcZERScq1PYqdwYEPlxwLsGY
   TblRVHodCK+hMoCVjpfghajvBrf5NEqWVhvyLCwfKrVNWMmL8IYo+bEvu
   qDTGv9IoyJp0+IIEDu8YM/5jWjM4/RYJj0IoXyw1vlM6pqiq7stUHPIiM
   +sksoEuKbIXcFAq2HF3VLaaml0o+iyrOPjwPofgPmEk3xqYTENtcZwXnc
   0+lprBDcgfulZoQvekpO7pYs/MwdW9dXEuxiiGHBWOdRY0vdCfgU3rD+S
   A==;
X-CSE-ConnectionGUID: /Ku2hpopQ0mVCxZZWEyZeQ==
X-CSE-MsgGUID: OW+Ns3kMRCOfY6v5G91dZw==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19408270"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:37:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:10083]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.42:2525] with esmtp (Farcaster)
 id 4980869b-df2c-4d88-bb19-4e6ae202a5a8; Mon, 11 May 2026 22:37:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4980869b-df2c-4d88-bb19-4e6ae202a5a8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 22:37:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 22:37:28 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kinsbursky" <dkinsb@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v4 4/5] RDMA/efa: Update device interface
Date: Mon, 11 May 2026 22:37:20 +0000
Message-ID: <20260511223721.18365-5-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511223721.18365-1-mrgolin@amazon.com>
References: <20260511223721.18365-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 44E46517009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20418-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Align device interface definitions.

Reviewed-by: Daniel Kinsbursky <dkinsb@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 185 +++++++++++++++++-
 drivers/infiniband/hw/efa/efa_io_defs.h       |  63 +++++-
 2 files changed, 242 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index ad34ea5da6b0..2d75edabeefa 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -31,7 +31,12 @@ enum efa_admin_aq_opcode {
 	EFA_ADMIN_CREATE_EQ                         = 18,
 	EFA_ADMIN_DESTROY_EQ                        = 19,
 	EFA_ADMIN_ALLOC_MR                          = 20,
-	EFA_ADMIN_MAX_OPCODE                        = 20,
+	EFA_ADMIN_SERVICE                           = 21,
+	EFA_ADMIN_CREATE_COUNTER                    = 25,
+	EFA_ADMIN_DESTROY_COUNTER                   = 26,
+	EFA_ADMIN_ATTACH_COUNTER                    = 27,
+	EFA_ADMIN_MODIFY_COUNTER                    = 28,
+	EFA_ADMIN_MAX_OPCODE                        = 28,
 };
 
 enum efa_admin_aq_feature_id {
@@ -725,7 +730,9 @@ struct efa_admin_feature_device_attr_desc {
 	 *    on TX queues
 	 * 4 : unsolicited_write_recv - If set, unsolicited
 	 *    write with imm. receive is supported
-	 * 31:5 : reserved - MBZ
+	 * 5 : event_counters - If set, event counters are
+	 *    supported
+	 * 31:6 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -814,6 +821,34 @@ struct efa_admin_feature_queue_attr_desc_1 {
 struct efa_admin_feature_queue_attr_desc_2 {
 	/* Maximum size of data that can be sent inline in a Send WQE */
 	u16 inline_buf_size_ex;
+
+	/* MBZ */
+	u8 reserved[6];
+
+	/*
+	 * Supported counter QP events
+	 * 0 : send_comp
+	 * 1 : send_comp_err
+	 * 2 : recv_comp
+	 * 3 : recv_comp_err
+	 * 4 : read_comp
+	 * 5 : read_comp_err
+	 * 6 : write_comp
+	 * 7 : write_comp_err
+	 * 8 : remote_read_comp
+	 * 9 : remote_write_comp
+	 * 31:10 : reserved - MBZ
+	 */
+	u32 supported_counter_qp_events;
+
+	/* Maximum number of counters */
+	u32 max_event_counters;
+
+	/*
+	 * Maximum counter value, counter wraps around to 0 after reaching
+	 * this value
+	 */
+	u64 event_counter_max_val;
 };
 
 struct efa_admin_event_queue_attr_desc {
@@ -1092,6 +1127,127 @@ struct efa_admin_host_info {
 	u32 flags;
 };
 
+struct efa_admin_service_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	u8 buffer[60];
+};
+
+struct efa_admin_service_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	u8 buffer[56];
+};
+
+/* Create Counter command */
+struct efa_admin_create_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* UAR number */
+	u16 uar;
+
+	/* MBZ */
+	u16 reserved;
+
+	/* Counter physical address */
+	u64 paddr;
+};
+
+struct efa_admin_create_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* MBZ */
+	u32 reserved;
+};
+
+struct efa_admin_destroy_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+};
+
+struct efa_admin_destroy_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+enum efa_admin_counter_attach_type {
+	EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS          = 0,
+};
+
+struct efa_admin_counter_attach_qp_events {
+	/* QP handle */
+	u32 qp_handle;
+
+	/*
+	 * Bitmask of counter QP events
+	 * 0 : send_comp
+	 * 1 : send_comp_err
+	 * 2 : recv_comp
+	 * 3 : recv_comp_err
+	 * 4 : read_comp
+	 * 5 : read_comp_err
+	 * 6 : write_comp
+	 * 7 : write_comp_err
+	 * 8 : remote_read_comp
+	 * 9 : remote_write_comp
+	 * 31:10 : reserved - MBZ
+	 */
+	u32 events;
+};
+
+struct efa_admin_attach_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* efa_admin_counter_attach_type */
+	u8 attach_type;
+
+	/* MBZ */
+	u8 reserved[3];
+
+	union {
+		struct efa_admin_counter_attach_qp_events qp_events;
+	} u;
+};
+
+struct efa_admin_attach_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/* Counter modify operations */
+enum efa_admin_counter_modify_ops {
+	/* Set counter value */
+	EFA_ADMIN_COUNTER_MODIFY_SET                = 0,
+	/* Add to counter value */
+	EFA_ADMIN_COUNTER_MODIFY_ADD                = 1,
+};
+
+struct efa_admin_modify_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* Counter operation type (efa_admin_counter_modify_ops) */
+	u8 operation;
+
+	/* MBZ */
+	u8 reserved[7];
+
+	/* Value for SET or ADD */
+	u64 value;
+};
+
+struct efa_admin_modify_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
 /* create_qp_cmd */
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
@@ -1132,6 +1288,19 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_DATA_POLLING_128_MASK BIT(2)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_WRITE_MASK  BIT(3)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_UNSOLICITED_WRITE_RECV_MASK BIT(4)
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_EVENT_COUNTERS_MASK BIT(5)
+
+/* feature_queue_attr_desc_2 */
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_SEND_COMP_MASK  BIT(0)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_SEND_COMP_ERR_MASK BIT(1)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_RECV_COMP_MASK  BIT(2)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_RECV_COMP_ERR_MASK BIT(3)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_READ_COMP_MASK  BIT(4)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_READ_COMP_ERR_MASK BIT(5)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_WRITE_COMP_MASK BIT(6)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_WRITE_COMP_ERR_MASK BIT(7)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_REMOTE_READ_COMP_MASK BIT(8)
+#define EFA_ADMIN_FEATURE_QUEUE_ATTR_DESC_2_REMOTE_WRITE_COMP_MASK BIT(9)
 
 /* create_eq_cmd */
 #define EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS_MASK       GENMASK(4, 0)
@@ -1150,4 +1319,16 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
 #define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
 
+/* counter_attach_qp_events */
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_MASK   BIT(0)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_ERR_MASK BIT(1)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_MASK   BIT(2)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_ERR_MASK BIT(3)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_READ_COMP_MASK   BIT(4)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_READ_COMP_ERR_MASK BIT(5)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_MASK  BIT(6)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_ERR_MASK BIT(7)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_REMOTE_READ_COMP_MASK BIT(8)
+#define EFA_ADMIN_COUNTER_ATTACH_QP_EVENTS_REMOTE_WRITE_COMP_MASK BIT(9)
+
 #endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_io_defs.h b/drivers/infiniband/hw/efa/efa_io_defs.h
index a4c9fd33da38..ede4b27eb951 100644
--- a/drivers/infiniband/hw/efa/efa_io_defs.h
+++ b/drivers/infiniband/hw/efa/efa_io_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_IO_H_
@@ -9,6 +9,7 @@
 #define EFA_IO_TX_DESC_NUM_BUFS              2
 #define EFA_IO_TX_DESC_NUM_RDMA_BUFS         1
 #define EFA_IO_TX_DESC_INLINE_MAX_SIZE       32
+#define EFA_IO_TX_DESC_INLINE_MAX_SIZE_128   80
 #define EFA_IO_TX_DESC_IMM_DATA_SIZE         4
 #define EFA_IO_TX_DESC_INLINE_PBL_SIZE       1
 
@@ -65,6 +66,8 @@ enum efa_io_comp_status {
 	EFA_IO_COMP_STATUS_REMOTE_ERROR_UNKNOWN_PEER = 14,
 	/* Unreachable remote - never received a response */
 	EFA_IO_COMP_STATUS_LOCAL_ERROR_UNREACH_REMOTE = 15,
+	/* Remote feature mismatch */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_FEATURE_MISMATCH = 18,
 };
 
 enum efa_io_frwr_pbl_mode {
@@ -72,6 +75,11 @@ enum efa_io_frwr_pbl_mode {
 	EFA_IO_FRWR_DIRECT_PBL                      = 1,
 };
 
+enum efa_io_processing_hint {
+	/* Optimize for throughput */
+	EFA_IO_PROCESSING_HINT_BURST_PPS_SENSITIVE  = 1 << 0,
+};
+
 struct efa_io_tx_meta_desc {
 	/* Verbs-generated Request ID */
 	u16 req_id;
@@ -121,7 +129,15 @@ struct efa_io_tx_meta_desc {
 
 	u16 ah;
 
-	u16 reserved;
+	/*
+	 * control flags
+	 * 1:0 : processing_hints - Bitmask of enum
+	 *    efa_io_processing_hint
+	 * 7:2 : reserved - MBZ
+	 */
+	u8 ctrl3;
+
+	u8 reserved;
 
 	/* Queue key */
 	u32 qkey;
@@ -172,6 +188,19 @@ struct efa_io_rdma_req {
 	struct efa_io_tx_buf_desc local_mem[1];
 };
 
+struct efa_io_rdma_req_128 {
+	/* Remote memory address */
+	struct efa_io_remote_mem_addr remote_mem;
+
+	union {
+		/* Local memory address */
+		struct efa_io_tx_buf_desc local_mem[1];
+
+		/* inline data for RDMA */
+		u8 inline_data[80];
+	};
+};
+
 struct efa_io_fast_mr_reg_req {
 	/* Updated local key of the MR after lkey/rkey increment */
 	u32 lkey;
@@ -230,8 +259,8 @@ struct efa_io_fast_mr_inv_req {
 };
 
 /*
- * Tx WQE, composed of tx meta descriptors followed by either tx buffer
- * descriptors or inline data
+ * 64-byte Tx WQE, composed of tx meta descriptors followed by either tx
+ * buffer descriptors or inline data
  */
 struct efa_io_tx_wqe {
 	/* TX meta */
@@ -254,6 +283,31 @@ struct efa_io_tx_wqe {
 	} data;
 };
 
+/*
+ * 128-byte Tx WQE, composed of tx meta descriptors followed by either tx
+ * buffer descriptors or inline data
+ */
+struct efa_io_tx_wqe_128 {
+	/* TX meta */
+	struct efa_io_tx_meta_desc meta;
+
+	union {
+		/* Send buffer descriptors */
+		struct efa_io_tx_buf_desc sgl[2];
+
+		u8 inline_data[80];
+
+		/* RDMA local and remote memory addresses */
+		struct efa_io_rdma_req_128 rdma_req;
+
+		/* Fast registration */
+		struct efa_io_fast_mr_reg_req reg_mr_req;
+
+		/* Fast invalidation */
+		struct efa_io_fast_mr_inv_req inv_mr_req;
+	} data;
+};
+
 /*
  * Rx buffer descriptor; RX WQE is composed of one or more RX buffer
  * descriptors.
@@ -365,6 +419,7 @@ struct efa_io_rx_cdesc_ex {
 #define EFA_IO_TX_META_DESC_FIRST_MASK                      BIT(2)
 #define EFA_IO_TX_META_DESC_LAST_MASK                       BIT(3)
 #define EFA_IO_TX_META_DESC_COMP_REQ_MASK                   BIT(4)
+#define EFA_IO_TX_META_DESC_PROCESSING_HINTS_MASK           GENMASK(1, 0)
 
 /* tx_buf_desc */
 #define EFA_IO_TX_BUF_DESC_LKEY_MASK                        GENMASK(23, 0)
-- 
2.47.3


