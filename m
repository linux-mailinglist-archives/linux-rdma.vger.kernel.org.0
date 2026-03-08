Return-Path: <linux-rdma+bounces-17724-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNcHGGurrWmE5gEAu9opvQ
	(envelope-from <linux-rdma+bounces-17724-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 18:01:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8FA231520
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CAC30D7306
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873333563EE;
	Sun,  8 Mar 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EqaAjy3C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2637FF48
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988856; cv=none; b=aFoQdumaoyB4v5SZ3juLY7tbBX+uDUsphkeoFOBsI09+4stXg7iOOOdfTD5evVRYPz9B5VL1V7HgHmDs5WSQ2sk6mR368x9FMbCiRTv340VC7oxrndnuNtY9eM3/WgwpqQAHBmd7Ex2Yk4/ucIuUfVa1jJXJzzU8Gl2+h/yrJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988856; c=relaxed/simple;
	bh=R+b8Z053Stk06/xZXTHuTFR729bEICDx+iFLKdx1gQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKVrt+Vy95dApz/q/sJXNCqa7I2P5YZqC1qOR76Qzhz4sujFHvH9fImrhV91kT8jo2/UQjmkUBvp0BUh4FRi2OMdhAqRflTzgolnu7oqlXeLeXlhaNqMANjph98LaGmF4/guoCr/9yIqigoWGlmCV0RtsispXxfOboAJFN9NZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EqaAjy3C; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772988847; x=1804524847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Uwq2LWekftE7r7FJrzFq6xz9nv1fyiyEcTCY5ecgbk=;
  b=EqaAjy3Ctw4xOyXr0E8tXIq0krXm6ZnRP8YK8UpWIsZxhrKJbOkk8iFc
   UWF/pxwfKfapQJsYloALJULf48GAObNjlR6vH6mHS5050Hkv2n17uTWkg
   bHR2DBeQUdeOLqFZRERkc/JNAfIg8dpvfgiYg/a6DkzQRPaU5hzYvecfN
   ERgSSqkG9SCiR4HkJmyI+CiXV7/ZqrqCJr2nCs2rC8K3HZZf4EilyvPUy
   F5E/zEs+Rl6KkdIFJY17dv99Bu2MbzhhWRXyJ0+3ACIyabnFHpGrlkeyy
   wxLKO0S5W/Ie/534hY7QGUesw75KE84yePPVPHUXai7bZo8giTZvc0B4+
   A==;
X-CSE-ConnectionGUID: ToyzpH1jQqqh/MxuSNYKJg==
X-CSE-MsgGUID: iFGs7KwXTf6fAV1ZCsHksA==
X-IronPort-AV: E=Sophos;i="6.23,109,1770595200"; 
   d="scan'208";a="14576351"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 16:54:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:18353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.220:2525] with esmtp (Farcaster)
 id 3f00c2d5-a6fa-4942-92a4-0d2ed2f4927b; Sun, 8 Mar 2026 16:54:04 +0000 (UTC)
X-Farcaster-Flow-ID: 3f00c2d5-a6fa-4942-92a4-0d2ed2f4927b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 8 Mar 2026 16:54:00 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 8 Mar 2026
 16:53:59 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Fix use of completion ctx after free
Date: Sun, 8 Mar 2026 16:53:50 +0000
Message-ID: <20260308165350.18219-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: BD8FA231520
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17724-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On admin queue completion handling, if the admin command completed with
error we print data from the completion context. The issue is that we
already freed the completion context in polling/interrupts handler which
means we print data from context in an unknown state (it might be
already used again).
Change the admin submission flow so alloc/dealloc of the context will be
symmetric and dealloc will be called after any potential use of the
context.

Fixes: 68fb9f3e312a ("RDMA/efa: Remove redundant NULL pointer check of CQE")
Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 69 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 229b0ad3b0cb..037ca2ab6d24 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/log2.h>
@@ -310,23 +310,19 @@ static inline struct efa_comp_ctx *efa_com_get_comp_ctx_by_cmd_id(struct efa_com
 	return &aq->comp_ctx[ctx_id];
 }
 
-static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
-						       struct efa_admin_aq_entry *cmd,
-						       size_t cmd_size_in_bytes,
-						       struct efa_admin_acq_entry *comp,
-						       size_t comp_size_in_bytes)
+static void __efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
+				       struct efa_comp_ctx *comp_ctx,
+				       struct efa_admin_aq_entry *cmd,
+				       size_t cmd_size_in_bytes,
+				       struct efa_admin_acq_entry *comp,
+				       size_t comp_size_in_bytes)
 {
 	struct efa_admin_aq_entry *aqe;
-	struct efa_comp_ctx *comp_ctx;
 	u16 queue_size_mask;
 	u16 cmd_id;
 	u16 ctx_id;
 	u16 pi;
 
-	comp_ctx = efa_com_alloc_comp_ctx(aq);
-	if (!comp_ctx)
-		return ERR_PTR(-EINVAL);
-
 	queue_size_mask = aq->depth - 1;
 	pi = aq->sq.pc & queue_size_mask;
 	ctx_id = efa_com_get_comp_ctx_id(aq, comp_ctx);
@@ -360,8 +356,6 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 
 	/* barrier not needed in case of writel */
 	writel(aq->sq.pc, aq->sq.db_addr);
-
-	return comp_ctx;
 }
 
 static inline int efa_com_init_comp_ctxt(struct efa_com_admin_queue *aq)
@@ -394,28 +388,25 @@ static inline int efa_com_init_comp_ctxt(struct efa_com_admin_queue *aq)
 	return 0;
 }
 
-static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
-						     struct efa_admin_aq_entry *cmd,
-						     size_t cmd_size_in_bytes,
-						     struct efa_admin_acq_entry *comp,
-						     size_t comp_size_in_bytes)
+static int efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
+				    struct efa_comp_ctx *comp_ctx,
+				    struct efa_admin_aq_entry *cmd,
+				    size_t cmd_size_in_bytes,
+				    struct efa_admin_acq_entry *comp,
+				    size_t comp_size_in_bytes)
 {
-	struct efa_comp_ctx *comp_ctx;
-
 	spin_lock(&aq->sq.lock);
 	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
 		ibdev_err_ratelimited(aq->efa_dev, "Admin queue is closed\n");
 		spin_unlock(&aq->sq.lock);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
-	comp_ctx = __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, comp,
-					      comp_size_in_bytes);
+	__efa_com_submit_admin_cmd(aq, comp_ctx, cmd, cmd_size_in_bytes, comp,
+				   comp_size_in_bytes);
 	spin_unlock(&aq->sq.lock);
-	if (IS_ERR(comp_ctx))
-		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
 
-	return comp_ctx;
+	return 0;
 }
 
 static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
@@ -541,7 +532,6 @@ static int efa_com_wait_and_process_admin_cq_polling(struct efa_comp_ctx *comp_c
 
 	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
-	efa_com_dealloc_comp_ctx(aq, comp_ctx);
 	return err;
 }
 
@@ -591,7 +581,6 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 
 	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
-	efa_com_dealloc_comp_ctx(aq, comp_ctx);
 	return err;
 }
 
@@ -642,30 +631,38 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	ibdev_dbg(aq->efa_dev, "%s (opcode %d)\n",
 		  efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
 		  cmd->aq_common_descriptor.opcode);
-	comp_ctx = efa_com_submit_admin_cmd(aq, cmd, cmd_size, comp, comp_size);
-	if (IS_ERR(comp_ctx)) {
+
+	comp_ctx = efa_com_alloc_comp_ctx(aq);
+	if (!comp_ctx) {
+		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
+		return -EINVAL;
+	}
+
+	err = efa_com_submit_admin_cmd(aq, comp_ctx, cmd, cmd_size, comp, comp_size);
+	if (err) {
 		ibdev_err_ratelimited(
 			aq->efa_dev,
-			"Failed to submit command %s (opcode %u) err %pe\n",
+			"Failed to submit command %s (opcode %u) err %d\n",
 			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			cmd->aq_common_descriptor.opcode, comp_ctx);
+			cmd->aq_common_descriptor.opcode, err);
 
+		efa_com_dealloc_comp_ctx(aq, comp_ctx);
 		up(&aq->avail_cmds);
 		atomic64_inc(&aq->stats.cmd_err);
-		return PTR_ERR(comp_ctx);
+		return err;
 	}
 
 	err = efa_com_wait_and_process_admin_cq(comp_ctx, aq);
 	if (err) {
 		ibdev_err_ratelimited(
 			aq->efa_dev,
-			"Failed to process command %s (opcode %u) comp_status %d err %d\n",
+			"Failed to process command %s (opcode %u) err %d\n",
 			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			cmd->aq_common_descriptor.opcode,
-			comp_ctx->user_cqe->acq_common_descriptor.status, err);
+			cmd->aq_common_descriptor.opcode, err);
 		atomic64_inc(&aq->stats.cmd_err);
 	}
 
+	efa_com_dealloc_comp_ctx(aq, comp_ctx);
 	up(&aq->avail_cmds);
 
 	return err;
-- 
2.47.3


