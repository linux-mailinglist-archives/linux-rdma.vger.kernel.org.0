Return-Path: <linux-rdma+bounces-16894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFgPK4K2kWmTlgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E323D13E9FF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9B2300D465
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF513285C91;
	Sun, 15 Feb 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SoqsUQ16"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5D24A046
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771157118; cv=none; b=JaU0lmG9L0nG/XgZgtU9JtZY/7vb7WX3VJwRXKkVIX7B4AjvjGRd0y2N8JdBiWFTQhM0BRYPkJGhU1srfGKolGPWDJFIIoD1ZB6t3iRxJrPBxEA79h4+aCD0UscIiUsx4MS7+VVyNSQrKVRx7Bm98+l5WQv/0atv8409g2jt4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771157118; c=relaxed/simple;
	bh=eoCMO3CFpgkaXHHDn3qAjJySkiVBtp6elIS3neRUkHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkNNLDgBaupdtWnJrMiNCGK0d8J8BLGarF9hxcUGJ0pbcVuTkFV+cQHLDHpO0ctpKYmcepn7EGtqL4wR2yibmTQsEcYXJlIJAqx+iXMMWKtX1vjinBQ+fK/qNchZ0g3xKIaq6zzEwQAeAgVrx73mLy8XtJ7qPL9/mrhWQ/AR0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SoqsUQ16; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771157117; x=1802693117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BjiY4pa9Wc/alKfWmH+4DTWD8kEYoq2dhsDUNacBem0=;
  b=SoqsUQ16It0IhF7lLvJ2SXtMtgJpxoUn/iQyVObduI5ofgTQSOAsc0X1
   EoVYLfjA1dq6h6MRw3c5zSDTiNvq1XmZV6xKsSR+8taU141IUkrc0my5c
   nuXv0SOkCTLvFXb8PW70cxgOH0NWnGmFKR/vIM/ys4ZkhegV4TeD+MbEI
   2V3YUH/vJyQhNwO3WoJ/f/LRnD2VABgULhi1P268DjLNQx+VI8B8Jw89B
   scbdzFEAxxR8VvPa4d042Y9D/NY3DJRVVeIq0R/3PiEYcC4vtiu6t403D
   I8SmZsusjIdNuna1Jn2YIjB9nBDyfKpOZ6YkmqZIFuX4YQaDOPQYVZi6U
   g==;
X-CSE-ConnectionGUID: qZ65fwTeTXedMTu3Gcp7vg==
X-CSE-MsgGUID: LOS6hrzbQ1C5wOBjuCyGig==
X-IronPort-AV: E=Sophos;i="6.21,292,1763424000"; 
   d="scan'208";a="13107624"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 12:05:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:4879]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.39:2525] with esmtp (Farcaster)
 id 334c71c1-671f-4f02-ac2f-b4caf75aeed8; Sun, 15 Feb 2026 12:05:14 +0000 (UTC)
X-Farcaster-Flow-ID: 334c71c1-671f-4f02-ac2f-b4caf75aeed8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sun, 15 Feb 2026 12:05:12 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Sun, 15 Feb 2026
 12:05:10 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/efa: Rename admin queue attributes struct name for extendability
Date: Sun, 15 Feb 2026 12:04:50 +0000
Message-ID: <20260215120451.18053-2-ynachum@amazon.com>
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
	TAGGED_FROM(0.00)[bounces-16894-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E323D13E9FF
X-Rspamd-Action: no action

As preparation for adding a second queue attributes query, change the
name of the existing queue attributes.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |  8 ++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 40 +++++++++----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 57178dad5eb7..5bbc765b6e3f 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_CMDS_H_
@@ -38,7 +38,7 @@ enum efa_admin_aq_feature_id {
 	EFA_ADMIN_DEVICE_ATTR                       = 1,
 	EFA_ADMIN_AENQ_CONFIG                       = 2,
 	EFA_ADMIN_NETWORK_ATTR                      = 3,
-	EFA_ADMIN_QUEUE_ATTR                        = 4,
+	EFA_ADMIN_QUEUE_ATTR_1                      = 4,
 	EFA_ADMIN_HW_HINTS                          = 5,
 	EFA_ADMIN_HOST_INFO                         = 6,
 	EFA_ADMIN_EVENT_QUEUE_ATTR                  = 7,
@@ -744,7 +744,7 @@ struct efa_admin_feature_device_attr_desc {
 	u32 reserved1;
 };
 
-struct efa_admin_feature_queue_attr_desc {
+struct efa_admin_feature_queue_attr_desc_1 {
 	/* The maximum number of queue pairs supported */
 	u32 max_qp;
 
@@ -872,7 +872,7 @@ struct efa_admin_get_feature_resp {
 
 		struct efa_admin_feature_network_attr_desc network_attr;
 
-		struct efa_admin_feature_queue_attr_desc queue_attr;
+		struct efa_admin_feature_queue_attr_desc_1 queue_attr_1;
 
 		struct efa_admin_event_queue_attr_desc event_queue_attr;
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 9ead02800ac7..592c420e4473 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -479,31 +479,31 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 
 	edev->supported_features = resp.u.device_attr.supported_features;
 	err = efa_com_get_feature(edev, &resp,
-				  EFA_ADMIN_QUEUE_ATTR);
+				  EFA_ADMIN_QUEUE_ATTR_1);
 	if (err) {
 		ibdev_err_ratelimited(edev->efa_dev,
-				      "Failed to get queue attributes %d\n",
+				      "Failed to get queue attributes1 %d\n",
 				      err);
 		return err;
 	}
 
-	result->max_qp = resp.u.queue_attr.max_qp;
-	result->max_sq_depth = resp.u.queue_attr.max_sq_depth;
-	result->max_rq_depth = resp.u.queue_attr.max_rq_depth;
-	result->max_cq = resp.u.queue_attr.max_cq;
-	result->max_cq_depth = resp.u.queue_attr.max_cq_depth;
-	result->inline_buf_size = resp.u.queue_attr.inline_buf_size;
-	result->max_sq_sge = resp.u.queue_attr.max_wr_send_sges;
-	result->max_rq_sge = resp.u.queue_attr.max_wr_recv_sges;
-	result->max_mr = resp.u.queue_attr.max_mr;
-	result->max_mr_pages = resp.u.queue_attr.max_mr_pages;
-	result->max_pd = resp.u.queue_attr.max_pd;
-	result->max_ah = resp.u.queue_attr.max_ah;
-	result->max_llq_size = resp.u.queue_attr.max_llq_size;
-	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
-	result->max_wr_rdma_sge = resp.u.queue_attr.max_wr_rdma_sges;
-	result->max_tx_batch = resp.u.queue_attr.max_tx_batch;
-	result->min_sq_depth = resp.u.queue_attr.min_sq_depth;
+	result->max_qp = resp.u.queue_attr_1.max_qp;
+	result->max_sq_depth = resp.u.queue_attr_1.max_sq_depth;
+	result->max_rq_depth = resp.u.queue_attr_1.max_rq_depth;
+	result->max_cq = resp.u.queue_attr_1.max_cq;
+	result->max_cq_depth = resp.u.queue_attr_1.max_cq_depth;
+	result->inline_buf_size = resp.u.queue_attr_1.inline_buf_size;
+	result->max_sq_sge = resp.u.queue_attr_1.max_wr_send_sges;
+	result->max_rq_sge = resp.u.queue_attr_1.max_wr_recv_sges;
+	result->max_mr = resp.u.queue_attr_1.max_mr;
+	result->max_mr_pages = resp.u.queue_attr_1.max_mr_pages;
+	result->max_pd = resp.u.queue_attr_1.max_pd;
+	result->max_ah = resp.u.queue_attr_1.max_ah;
+	result->max_llq_size = resp.u.queue_attr_1.max_llq_size;
+	result->sub_cqs_per_cq = resp.u.queue_attr_1.sub_cqs_per_cq;
+	result->max_wr_rdma_sge = resp.u.queue_attr_1.max_wr_rdma_sges;
+	result->max_tx_batch = resp.u.queue_attr_1.max_tx_batch;
+	result->min_sq_depth = resp.u.queue_attr_1.min_sq_depth;
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
-- 
2.47.3


