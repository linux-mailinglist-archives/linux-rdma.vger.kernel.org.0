Return-Path: <linux-rdma+bounces-16895-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPN2EIa2kWmTlgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16895-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44813EA06
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB7D3011BDD
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259A2D3725;
	Sun, 15 Feb 2026 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZpKWrfHv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52F2BDC05
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771157120; cv=none; b=SJMaiP7cxutryGRzQmrEA8kbal0DJygBDzKyoJwGjYNKG2Ch1NjDTxQcmDpvYRvKsNrQzhQ8vwTm4D3Pzw0RjJDKvaOYjvnsCErKsRrotrFFZOcBdgyR/4LnONlqkndPFy7LsuF2W6tIIN+S2dIKaQyzv+on8Sw6zFRbSApllV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771157120; c=relaxed/simple;
	bh=facgzqgTeGF73B0tVpGLzRs0SEm9OYSZ7WStKrP1YKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzVLHISkrFWNiILRZNBXhvs2Bc2/elaG/a9PKuX8qNmXE9YSuSWvaJWbg3GBlCtnbtGbXoQQdQZVPd/+5nkoYvLPD6BfDt/i733X8nADVQTpJ3nEY0J8nrkGFd0LzlG++HQzIzl/LijwfySMPEzOo2A6TLwTKaDjhW7r1q/BOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZpKWrfHv; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771157119; x=1802693119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0++GZ9/4ZxD2pFuNBMfW+qjNTYnqN93PUfG4SSekdE=;
  b=ZpKWrfHvoTiVYAt6QFMg0bknMhW5BB+8CMG6iVt0M3INPTn098agWJLt
   usgJbXKFVXLavgcYjWCwI1XbypEw1+UTFtexbA6SdWONf48iny7KP7WUH
   VJDFwNKMKmJHTqB9oR99+XflrsepXOZEKNjgRj0WEUf4fudFaXFT7VcXB
   szdHXyuN+gr7LuQzmqCcQQe8FfOiMa5hUAKJinQ3d6JjM4h+b/izKL17w
   f8MSUZQmNXkwM7iBjl7Pr2HGHVUQfyV8on9j41kLkgKxeSdBnXKao/0qT
   8Hyr4qxuRuA+C9UDrrWSV/9N3NmJEqA9nyQXITXUu3FZ2JQ2SLij7txcy
   Q==;
X-CSE-ConnectionGUID: FV8nu/KzTHa9sAut/mUzJA==
X-CSE-MsgGUID: LISjykDjTzuhlavEddo7gQ==
X-IronPort-AV: E=Sophos;i="6.21,292,1763424000"; 
   d="scan'208";a="13107087"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 12:05:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:8955]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.96:2525] with esmtp (Farcaster)
 id 05f9ba70-1cb0-4582-af32-4e4c07292010; Sun, 15 Feb 2026 12:05:16 +0000 (UTC)
X-Farcaster-Flow-ID: 05f9ba70-1cb0-4582-af32-4e4c07292010
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sun, 15 Feb 2026 12:05:15 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Sun, 15 Feb 2026
 12:05:14 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Expose new extended max inline buff size
Date: Sun, 15 Feb 2026 12:04:51 +0000
Message-ID: <20260215120451.18053-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260215120451.18053-1-ynachum@amazon.com>
References: <20260215120451.18053-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16895-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB44813EA06
X-Rspamd-Action: no action

Add new extended max inline query and report the new value to userspace.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 14 +++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c         | 15 +++++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  3 ++-
 drivers/infiniband/hw/efa/efa_verbs.c           |  3 ++-
 include/uapi/rdma/efa-abi.h                     |  5 +++--
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 5bbc765b6e3f..93e5ffe900e9 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -42,6 +42,7 @@ enum efa_admin_aq_feature_id {
 	EFA_ADMIN_HW_HINTS                          = 5,
 	EFA_ADMIN_HOST_INFO                         = 6,
 	EFA_ADMIN_EVENT_QUEUE_ATTR                  = 7,
+	EFA_ADMIN_QUEUE_ATTR_2                      = 8,
 };
 
 /* QP transport type */
@@ -751,7 +752,11 @@ struct efa_admin_feature_queue_attr_desc_1 {
 	/* Maximum number of WQEs per Send Queue */
 	u32 max_sq_depth;
 
-	/* Maximum size of data that can be sent inline in a Send WQE */
+	/*
+	 * Maximum size of data that can be sent inline in a Send WQE
+	 * (deprecated by
+	 * efa_admin_feature_queue_attr_desc_2::inline_buf_size_ex)
+	 */
 	u32 inline_buf_size;
 
 	/* Maximum number of buffer descriptors per Recv Queue */
@@ -805,6 +810,11 @@ struct efa_admin_feature_queue_attr_desc_1 {
 	u16 max_tx_batch;
 };
 
+struct efa_admin_feature_queue_attr_desc_2 {
+	/* Maximum size of data that can be sent inline in a Send WQE */
+	u16 inline_buf_size_ex;
+};
+
 struct efa_admin_event_queue_attr_desc {
 	/* The maximum number of event queues supported */
 	u32 max_eq;
@@ -874,6 +884,8 @@ struct efa_admin_get_feature_resp {
 
 		struct efa_admin_feature_queue_attr_desc_1 queue_attr_1;
 
+		struct efa_admin_feature_queue_attr_desc_2 queue_attr_2;
+
 		struct efa_admin_event_queue_attr_desc event_queue_attr;
 
 		struct efa_admin_hw_hints hw_hints;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 592c420e4473..63c7f07806a8 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -505,6 +505,21 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_tx_batch = resp.u.queue_attr_1.max_tx_batch;
 	result->min_sq_depth = resp.u.queue_attr_1.min_sq_depth;
 
+	if (efa_com_check_supported_feature_id(edev, EFA_ADMIN_QUEUE_ATTR_2)) {
+		err = efa_com_get_feature(edev, &resp,
+					  EFA_ADMIN_QUEUE_ATTR_2);
+		if (err) {
+			ibdev_err_ratelimited(
+				edev->efa_dev,
+				"Failed to get queue attributes2 %d\n", err);
+			return err;
+		}
+
+		result->inline_buf_size_ex = resp.u.queue_attr_2.inline_buf_size_ex;
+	} else {
+		result->inline_buf_size_ex = result->inline_buf_size;
+	}
+
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
 		ibdev_err_ratelimited(edev->efa_dev,
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 3ac2686abba1..ef15b3c38429 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_CMD_H_
@@ -127,6 +127,7 @@ struct efa_com_get_device_attr_result {
 	u32 max_cq;
 	u32 max_cq_depth; /* cqes */
 	u32 inline_buf_size;
+	u32 inline_buf_size_ex;
 	u32 max_mr;
 	u32 max_pd;
 	u32 max_ah;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d..85c3a7dd4335 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/dma-buf.h>
@@ -1994,6 +1994,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
 	resp.sub_cqs_per_cq = dev->dev_attr.sub_cqs_per_cq;
 	resp.inline_buf_size = dev->dev_attr.inline_buf_size;
+	resp.inline_buf_size_ex = dev->dev_attr.inline_buf_size_ex;
 	resp.max_llq_size = dev->dev_attr.max_llq_size;
 	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
 	resp.min_sq_wr = dev->dev_attr.min_sq_depth;
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 98b71b9979f8..13225b038124 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -44,7 +44,8 @@ struct efa_ibv_alloc_ucontext_resp {
 	__u32 max_llq_size; /* bytes */
 	__u16 max_tx_batch; /* units of 64 bytes */
 	__u16 min_sq_wr;
-	__u8 reserved_a0[4];
+	__u16 inline_buf_size_ex;
+	__u8 reserved_b0[2];
 };
 
 struct efa_ibv_alloc_pd_resp {
-- 
2.47.3


