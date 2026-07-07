Return-Path: <linux-rdma+bounces-22864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kOoULPdiTWrDzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:35:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4E71F8F6
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:35:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=VxjRTzZr;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22864-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22864-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4EF9300BCAE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F333F1AB2;
	Tue,  7 Jul 2026 20:34:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6A10785
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 20:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456480; cv=none; b=uuHK7eVISEndAEw8CC0VWaB0Yvchx/IEZnrnpSoVrfejCkgz20AnMav0nzksj3qwb9TZMXveuBkByqL08zAqVz97Q1l3d6udgE5mxQOw8bZuc6VAFkDsSBydOxdP9emv7QqkCj1TrsMUmlU/kv1qGSAL6KUR6NONbmuoql2okVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456480; c=relaxed/simple;
	bh=2KqsIievcQGbfks2neSTHBZlCYeEn4rK7m/XdHdGtIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKxLsyEPap29oq28VEih680grflcucJLQIH6wortjENCOpiUrXq4kBvJJWHZlzD6810XOl2+QoQ/XwJyw4wcvlo+5TZO2HjpugUBa1pDo5kktnBvu7Sz6wRlu8JerlsLZYiXd8ED0yObyOukCnXEfoA4UBNv7PJcJIHfletIl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VxjRTzZr; arc=none smtp.client-ip=52.26.1.71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783456479; x=1814992479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Du9uU1gTgk69ylX4ZoFEL2UX82p/SS0bE3gcOF0VfBU=;
  b=VxjRTzZryZSltADQiw4xkv22yMgKkcNyJmGkex2UE2+G3tSFnfT6A6vP
   +BdMPdY/Lkl6GAJWSw0DZD9XxLOqVCYDOXRP8Mq604WWDZIbCgJfRf+/W
   63Z45KcRbNdFIACH6EF+hrRW7ewQz9yxQVBwjVGwxfbUKYM1WG4dhBcNS
   TEs8eQ+qfigP0Or0JXwcjuFemLqEy6APp8+EPvlNxskx1B78dTeZGSqqw
   yllgoKCzbe/xkdJ5DkC+DyApDqjd47CClPqNHR2Qk3pkOOUgv4yfrZsU6
   aWNG8g9/0YjVV9Bwm6Mu2ztXSOxRFE+pUnsprTWVmvboYOdJDX8xLkbl+
   A==;
X-CSE-ConnectionGUID: ufpOEZvNTMuKDZ60oOqsyQ==
X-CSE-MsgGUID: 1vhXTuTOQNmilsv174wzDA==
X-IronPort-AV: E=Sophos;i="6.25,153,1779148800"; 
   d="scan'208";a="23268788"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:34:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:18601]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.191:2525] with esmtp (Farcaster)
 id d97049fc-4e82-4426-97ef-55fc0afdc13e; Tue, 7 Jul 2026 20:34:36 +0000 (UTC)
X-Farcaster-Flow-ID: d97049fc-4e82-4426-97ef-55fc0afdc13e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 7 Jul 2026 20:34:36 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Tue, 7 Jul 2026
 20:34:34 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kinsbursky" <dkinsb@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v8 4/5] RDMA/efa: Update device interface
Date: Tue, 7 Jul 2026 20:34:26 +0000
Message-ID: <20260707203427.6923-5-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707203427.6923-1-mrgolin@amazon.com>
References: <20260707203427.6923-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22864-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:dkinsb@amazon.com,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5C4E71F8F6

Align device interface definitions.

Reviewed-by: Daniel Kinsbursky <dkinsb@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 186 +++++++++++++++++-
 drivers/infiniband/hw/efa/efa_io_defs.h       |  20 +-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 826790ca9d83..87c320f18362 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -28,7 +28,13 @@ enum efa_admin_aq_opcode {
 	EFA_ADMIN_CREATE_EQ                         = 18,
 	EFA_ADMIN_DESTROY_EQ                        = 19,
 	EFA_ADMIN_ALLOC_MR                          = 20,
-	EFA_ADMIN_MAX_OPCODE                        = 20,
+	EFA_ADMIN_SERVICE                           = 21,
+	EFA_ADMIN_CREATE_EVENT_COUNTER              = 25,
+	EFA_ADMIN_DESTROY_EVENT_COUNTER             = 26,
+	EFA_ADMIN_ATTACH_EVENT_COUNTER              = 27,
+	EFA_ADMIN_MODIFY_EVENT_COUNTER              = 28,
+	EFA_ADMIN_DETACH_EVENT_COUNTER              = 29,
+	EFA_ADMIN_MAX_OPCODE                        = 29,
 };
 
 enum efa_admin_aq_feature_id {
@@ -722,7 +728,9 @@ struct efa_admin_feature_device_attr_desc {
 	 *    on TX queues
 	 * 4 : unsolicited_write_recv - If set, unsolicited
 	 *    write with imm. receive is supported
-	 * 31:5 : reserved - MBZ
+	 * 5 : event_counters - If set, event counters are
+	 *    supported
+	 * 31:6 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -811,6 +819,34 @@ struct efa_admin_feature_queue_attr_desc_1 {
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
+	u32 supported_event_counter_qp_events;
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
@@ -1089,6 +1125,127 @@ struct efa_admin_host_info {
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
+struct efa_admin_create_event_counter_cmd {
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
+struct efa_admin_create_event_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* MBZ */
+	u32 reserved;
+};
+
+struct efa_admin_destroy_event_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+};
+
+struct efa_admin_destroy_event_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+enum efa_admin_event_counter_attach_type {
+	EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS    = 0,
+};
+
+struct efa_admin_event_counter_attach_qp_events {
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
+struct efa_admin_attach_detach_event_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* efa_admin_event_counter_attach_type */
+	u8 attach_type;
+
+	/* MBZ */
+	u8 reserved[3];
+
+	union {
+		struct efa_admin_event_counter_attach_qp_events qp_events;
+	} u;
+};
+
+struct efa_admin_attach_detach_event_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
+/* Counter modify operations */
+enum efa_admin_event_counter_modify_ops {
+	/* Set counter value */
+	EFA_ADMIN_EVENT_COUNTER_MODIFY_SET          = 0,
+	/* Add to counter value */
+	EFA_ADMIN_EVENT_COUNTER_MODIFY_ADD          = 1,
+};
+
+struct efa_admin_modify_event_counter_cmd {
+	struct efa_admin_aq_common_desc aq_common_descriptor;
+
+	/* Counter handle */
+	u32 cntr_handle;
+
+	/* Counter operation type (efa_admin_event_counter_modify_ops) */
+	u8 operation;
+
+	/* MBZ */
+	u8 reserved[7];
+
+	/* Value for SET or ADD */
+	u64 value;
+};
+
+struct efa_admin_modify_event_counter_resp {
+	struct efa_admin_acq_common_desc acq_common_desc;
+};
+
 /* create_qp_cmd */
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
@@ -1129,6 +1286,19 @@ struct efa_admin_host_info {
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
@@ -1147,4 +1317,16 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_HOST_INFO_INTREE_MASK                     BIT(0)
 #define EFA_ADMIN_HOST_INFO_GDR_MASK                        BIT(1)
 
+/* counter_attach_qp_events */
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_MASK   BIT(0)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_SEND_COMP_ERR_MASK BIT(1)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_MASK   BIT(2)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_RECV_COMP_ERR_MASK BIT(3)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_READ_COMP_MASK   BIT(4)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_READ_COMP_ERR_MASK BIT(5)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_MASK  BIT(6)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_WRITE_COMP_ERR_MASK BIT(7)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_REMOTE_READ_COMP_MASK BIT(8)
+#define EFA_ADMIN_EVENT_COUNTER_ATTACH_QP_EVENTS_REMOTE_WRITE_COMP_MASK BIT(9)
+
 #endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_io_defs.h b/drivers/infiniband/hw/efa/efa_io_defs.h
index a4c9fd33da38..a849d92a6eb6 100644
--- a/drivers/infiniband/hw/efa/efa_io_defs.h
+++ b/drivers/infiniband/hw/efa/efa_io_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_IO_H_
@@ -65,6 +65,8 @@ enum efa_io_comp_status {
 	EFA_IO_COMP_STATUS_REMOTE_ERROR_UNKNOWN_PEER = 14,
 	/* Unreachable remote - never received a response */
 	EFA_IO_COMP_STATUS_LOCAL_ERROR_UNREACH_REMOTE = 15,
+	/* Remote feature mismatch */
+	EFA_IO_COMP_STATUS_REMOTE_ERROR_FEATURE_MISMATCH = 18,
 };
 
 enum efa_io_frwr_pbl_mode {
@@ -72,6 +74,11 @@ enum efa_io_frwr_pbl_mode {
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
@@ -121,7 +128,15 @@ struct efa_io_tx_meta_desc {
 
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
@@ -365,6 +380,7 @@ struct efa_io_rx_cdesc_ex {
 #define EFA_IO_TX_META_DESC_FIRST_MASK                      BIT(2)
 #define EFA_IO_TX_META_DESC_LAST_MASK                       BIT(3)
 #define EFA_IO_TX_META_DESC_COMP_REQ_MASK                   BIT(4)
+#define EFA_IO_TX_META_DESC_PROCESSING_HINTS_MASK           GENMASK(1, 0)
 
 /* tx_buf_desc */
 #define EFA_IO_TX_BUF_DESC_LKEY_MASK                        GENMASK(23, 0)
-- 
2.47.3


