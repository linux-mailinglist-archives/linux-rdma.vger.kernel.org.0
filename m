Return-Path: <linux-rdma+bounces-14950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD86CB2F8C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9E83044B99
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A0322C73;
	Wed, 10 Dec 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DO0bq1k3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B741A9F94
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372025; cv=none; b=IWV/cF7zdKTUiBFuM5UHOoTljsI//hoqAngVJzSocmCRULW3oW8sUesUnV5AKoSoJB2iOgW47IbGhbfIXSRCQFj8pqZgHVPVJVKPTYeMIAf5lLbGm+gHDqp1ZAAfhq4HDYeYMzqk/F9kwOD9yKj/6VN9ZCs16REjYVCWftJvwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372025; c=relaxed/simple;
	bh=qj0mIf/HsLQhzjfM/yhpZ6kvZ3c8Syy2+zUEOI8LW70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blcZDdKg0JzXX2E2bARhJDNfJzB377tCfkkUzYnDhMM/5obfEa0tgVj4ltMsjyiH7107PZVLbzHAko/moIu44ufS/SroNyqPUESPo9vxSxeka8XK3RQ+MQ0HjijkkPXr6t85sMb6EoSHzEIT2wskROL8oOVBXwRcmillp42yBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DO0bq1k3; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765372023; x=1796908023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lneBisST/T4jZFvKQC7gYN0wJ8U+o4IzRPvL5NN6LoI=;
  b=DO0bq1k3uNd2aFeoAK9YA9YGZdUFZArm5qP+WiJo8TFOOiEmsCtZaV7B
   aJ1CyfFt01msdlp+gXmiVf7rdDuIqnyu+1waL7yQM1tfvVQY7xQyakqDz
   Gay4ZvEQu7XeUVo9ER0TuFcuabtb+5Db3JcxlQQRvhqwFyCzYZn4hp9yN
   tSnVWKOVXAZpxf08YpIIW85lXkwpryKG6EwT4pjVVivMM7qd7yZ3DpKqy
   B+jN5/KFWsX7eJEWI0cKAVR13dGGfB4GDz0WNUIiQKD9TyR6w6VvcrR8P
   ArjY/2Dr28QtB1DaeaE9BqV+RAuDo5VBBCMxXJK83prIaFYH/xozbeEhB
   w==;
X-CSE-ConnectionGUID: LBKhknlbT2S9rXitOwGZbA==
X-CSE-MsgGUID: fyu5MMNHTD6TZ9FBjPDAqQ==
X-IronPort-AV: E=Sophos;i="6.20,264,1758585600"; 
   d="scan'208";a="6388751"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 13:06:45 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:4559]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.73:2525] with esmtp (Farcaster)
 id 75916c55-35c8-4ffa-8bf0-643fa3da8473; Wed, 10 Dec 2025 13:06:45 +0000 (UTC)
X-Farcaster-Flow-ID: 75916c55-35c8-4ffa-8bf0-643fa3da8473
Received: from EX19D011EUB004.ant.amazon.com (10.252.51.93) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Dec 2025 13:06:43 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D011EUB004.ant.amazon.com (10.252.51.93) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 10 Dec 2025
 13:06:40 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>
Subject: [PATCH 2/2] RDMA/efa: Improve admin completion context state machine
Date: Wed, 10 Dec 2025 13:06:14 +0000
Message-ID: <20251210130614.36460-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210130614.36460-1-ynachum@amazon.com>
References: <20251210130614.36460-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D011EUB004.ant.amazon.com (10.252.51.93)

Add a new unused state to the admin completion contexts state machine
instead of the occupied field. This improves the completion validity
check because it now enforce the context to be in submitted state prior
to completing it. Also add allocated state as a intermediate state
between unused and submitted.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 91 ++++++++++++++++-------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index b31478f3a121..229b0ad3b0cb 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -23,6 +23,8 @@
 #define EFA_CTRL_SUB_MINOR      1
 
 enum efa_cmd_status {
+	EFA_CMD_UNUSED,
+	EFA_CMD_ALLOCATED,
 	EFA_CMD_SUBMITTED,
 	EFA_CMD_COMPLETED,
 };
@@ -34,7 +36,6 @@ struct efa_comp_ctx {
 	enum efa_cmd_status status;
 	u16 cmd_id;
 	u8 cmd_opcode;
-	u8 occupied;
 };
 
 static const char *efa_com_cmd_str(u8 cmd)
@@ -243,7 +244,6 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
 	return 0;
 }
 
-/* ID to be used with efa_com_get_comp_ctx */
 static u16 efa_com_alloc_ctx_id(struct efa_com_admin_queue *aq)
 {
 	u16 ctx_id;
@@ -265,36 +265,47 @@ static void efa_com_dealloc_ctx_id(struct efa_com_admin_queue *aq,
 	spin_unlock(&aq->comp_ctx_lock);
 }
 
-static inline void efa_com_put_comp_ctx(struct efa_com_admin_queue *aq,
-					struct efa_comp_ctx *comp_ctx)
+static struct efa_comp_ctx *efa_com_alloc_comp_ctx(struct efa_com_admin_queue *aq)
 {
-	u16 cmd_id = EFA_GET(&comp_ctx->user_cqe->acq_common_descriptor.command,
-			     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
-	u16 ctx_id = cmd_id & (aq->depth - 1);
+	struct efa_comp_ctx *comp_ctx;
+	u16 ctx_id;
 
-	ibdev_dbg(aq->efa_dev, "Put completion command_id %#x\n", cmd_id);
-	comp_ctx->occupied = 0;
-	efa_com_dealloc_ctx_id(aq, ctx_id);
+	ctx_id = efa_com_alloc_ctx_id(aq);
+
+	comp_ctx = &aq->comp_ctx[ctx_id];
+	if (comp_ctx->status != EFA_CMD_UNUSED) {
+		efa_com_dealloc_ctx_id(aq, ctx_id);
+		ibdev_err_ratelimited(aq->efa_dev,
+				      "Completion context[%u] is used[%u]\n",
+				      ctx_id, comp_ctx->status);
+		return NULL;
+	}
+
+	comp_ctx->status = EFA_CMD_ALLOCATED;
+	ibdev_dbg(aq->efa_dev, "Take completion context[%u]\n", ctx_id);
+	return comp_ctx;
 }
 
-static struct efa_comp_ctx *efa_com_get_comp_ctx(struct efa_com_admin_queue *aq,
-						 u16 cmd_id, bool capture)
+static inline u16 efa_com_get_comp_ctx_id(struct efa_com_admin_queue *aq,
+					  struct efa_comp_ctx *comp_ctx)
 {
-	u16 ctx_id = cmd_id & (aq->depth - 1);
+	return comp_ctx - aq->comp_ctx;
+}
 
-	if (aq->comp_ctx[ctx_id].occupied && capture) {
-		ibdev_err_ratelimited(
-			aq->efa_dev,
-			"Completion context for command_id %#x is occupied\n",
-			cmd_id);
-		return NULL;
-	}
+static inline void efa_com_dealloc_comp_ctx(struct efa_com_admin_queue *aq,
+					    struct efa_comp_ctx *comp_ctx)
+{
+	u16 ctx_id = efa_com_get_comp_ctx_id(aq, comp_ctx);
 
-	if (capture) {
-		aq->comp_ctx[ctx_id].occupied = 1;
-		ibdev_dbg(aq->efa_dev,
-			  "Take completion ctxt for command_id %#x\n", cmd_id);
-	}
+	ibdev_dbg(aq->efa_dev, "Put completion context[%u]\n", ctx_id);
+	comp_ctx->status = EFA_CMD_UNUSED;
+	efa_com_dealloc_ctx_id(aq, ctx_id);
+}
+
+static inline struct efa_comp_ctx *efa_com_get_comp_ctx_by_cmd_id(struct efa_com_admin_queue *aq,
+								  u16 cmd_id)
+{
+	u16 ctx_id = cmd_id & (aq->depth - 1);
 
 	return &aq->comp_ctx[ctx_id];
 }
@@ -312,10 +323,13 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 	u16 ctx_id;
 	u16 pi;
 
+	comp_ctx = efa_com_alloc_comp_ctx(aq);
+	if (!comp_ctx)
+		return ERR_PTR(-EINVAL);
+
 	queue_size_mask = aq->depth - 1;
 	pi = aq->sq.pc & queue_size_mask;
-
-	ctx_id = efa_com_alloc_ctx_id(aq);
+	ctx_id = efa_com_get_comp_ctx_id(aq, comp_ctx);
 
 	/* cmd_id LSBs are the ctx_id and MSBs are entropy bits from pc */
 	cmd_id = ctx_id & queue_size_mask;
@@ -326,12 +340,6 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 	EFA_SET(&cmd->aq_common_descriptor.flags,
 		EFA_ADMIN_AQ_COMMON_DESC_PHASE, aq->sq.phase);
 
-	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, true);
-	if (!comp_ctx) {
-		efa_com_dealloc_ctx_id(aq, ctx_id);
-		return ERR_PTR(-EINVAL);
-	}
-
 	comp_ctx->status = EFA_CMD_SUBMITTED;
 	comp_ctx->comp_size = comp_size_in_bytes;
 	comp_ctx->user_cqe = comp;
@@ -372,9 +380,9 @@ static inline int efa_com_init_comp_ctxt(struct efa_com_admin_queue *aq)
 	}
 
 	for (i = 0; i < aq->depth; i++) {
-		comp_ctx = efa_com_get_comp_ctx(aq, i, false);
-		if (comp_ctx)
-			init_completion(&comp_ctx->wait_event);
+		comp_ctx = &aq->comp_ctx[i];
+		comp_ctx->status = EFA_CMD_UNUSED;
+		init_completion(&comp_ctx->wait_event);
 
 		aq->comp_ctx_pool[i] = i;
 	}
@@ -419,11 +427,12 @@ static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq
 	cmd_id = EFA_GET(&cqe->acq_common_descriptor.command,
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
-	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
+	comp_ctx = efa_com_get_comp_ctx_by_cmd_id(aq, cmd_id);
 	if (comp_ctx->status != EFA_CMD_SUBMITTED || comp_ctx->cmd_id != cmd_id) {
 		ibdev_err(aq->efa_dev,
-			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
-			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+			  "Received completion with unexpected command id[%x], status[%d] sq producer[%d], sq consumer[%d], cq consumer[%d]\n",
+			  cmd_id, comp_ctx->status, aq->sq.pc, aq->sq.cc,
+			  aq->cq.cc);
 		return -EINVAL;
 	}
 
@@ -532,7 +541,7 @@ static int efa_com_wait_and_process_admin_cq_polling(struct efa_comp_ctx *comp_c
 
 	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
-	efa_com_put_comp_ctx(aq, comp_ctx);
+	efa_com_dealloc_comp_ctx(aq, comp_ctx);
 	return err;
 }
 
@@ -582,7 +591,7 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 
 	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
-	efa_com_put_comp_ctx(aq, comp_ctx);
+	efa_com_dealloc_comp_ctx(aq, comp_ctx);
 	return err;
 }
 
-- 
2.47.3


