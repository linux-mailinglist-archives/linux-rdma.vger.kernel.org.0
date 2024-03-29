Return-Path: <linux-rdma+bounces-1668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D7891E9F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F4A1F25C40
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA21B2C36;
	Fri, 29 Mar 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekK4/EyC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307ED1B2C2C;
	Fri, 29 Mar 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716590; cv=none; b=J5VI4Guyq31CLF5ckpSA+QjzdmN6/R+PDTMRJ4sg9Cz8Ryos6jzcrtou5ZcrZbcAG/2nPpH6hwGRjLKFz+8Z7uRoC2J5OiGwxam+D7iXYVqMEz4BMiU36ZBAlm3QvbXSgY8mmeDpgJ5jKy6KSI0l8Ik5Wzz2wv5fOyN460cyfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716590; c=relaxed/simple;
	bh=67hnujsbtK7vRmIqoli5FDo9E2OVIOrMdtKAEsoBGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqV0RYTWfTvb7VZjIBKl57TJ7nsOcTPSxpf5U/axgFP85c1OrjqGk2q20EBHf7lsbWG+Gysov6t4xiKu9ec+RQbgvfeN8ah9SVeBCNkyqQ5GKBe2IKMu95vnIXTxg9bQ0DT/qNiUu1YAq/mbQm0npF7nnqpGrPg0SONwVY5fJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekK4/EyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2772C433F1;
	Fri, 29 Mar 2024 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716589;
	bh=67hnujsbtK7vRmIqoli5FDo9E2OVIOrMdtKAEsoBGfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekK4/EyCcIeVpXi48vGbssvqvxJIyzE8uXvafvCQONtLEMjpN593DERhQbeaxsixo
	 TZfoAN//maSj8kKpwqlL4YQgD02kjqqxnWBRGR/8bwiGKdPrmFkx/W48W5T9xeyqzr
	 Kf7JuOiWn+oZJUCUqgn0GLWQslyapdTUH/Kxx0rqGntzpts8HS3m08LOTkvPgg5vuG
	 3Fe1v+EI93bwBw6OkOh/lWkASe5ve363YDNHKIUvRDxFNpP0pWXEEKfFORVGJNtw8f
	 HJC9u2eTVHplFi40BVqlu9yJunoFZ9QuUscbdo1ijozoXkj+hD7I+kYasvobIgvdBD
	 NbZeEZXGaLMwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manjunath Patil <manjunath.b.patil@oracle.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	markzhang@nvidia.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 27/31] RDMA/cm: add timeout to cm_destroy_id wait
Date: Fri, 29 Mar 2024 08:48:44 -0400
Message-ID: <20240329124903.3093161-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Manjunath Patil <manjunath.b.patil@oracle.com>

[ Upstream commit 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa ]

Add timeout to cm_destroy_id, so that userspace can trigger any data
collection that would help in analyzing the cause of delay in destroying
the cm_id.

New noinline function helps dtrace/ebpf programs to hook on to it.
Existing functionality isn't changed except triggering a probe-able new
function at every timeout interval.

We have seen cases where CM messages stuck with MAD layer (either due to
software bug or faulty HCA), leading to cm_id getting stuck in the
following call stack. This patch helps in resolving such issues faster.

kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
...
	Call Trace:
	__schedule+0x2bc/0x895
	schedule+0x36/0x7c
	schedule_timeout+0x1f6/0x31f
 	? __slab_free+0x19c/0x2ba
	wait_for_completion+0x12b/0x18a
	? wake_up_q+0x80/0x73
	cm_destroy_id+0x345/0x610 [ib_cm]
	ib_destroy_cm_id+0x10/0x20 [ib_cm]
	rdma_destroy_id+0xa8/0x300 [rdma_cm]
	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
	ucma_write+0xe0/0x160 [rdma_ucm]
	__vfs_write+0x3a/0x16d
	vfs_write+0xb2/0x1a1
	? syscall_trace_enter+0x1ce/0x2b8
	SyS_write+0x5c/0xd3
	do_syscall_64+0x79/0x1b9
	entry_SYSCALL_64_after_hwframe+0x16d/0x0

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Link: https://lore.kernel.org/r/20240309063323.458102-1-manjunath.b.patil@oracle.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index db1a25fbe2fa9..2a30b25c5e7e5 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -33,6 +33,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1056,10 +1057,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+{
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
+	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+}
+
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_work *work;
+	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
@@ -1171,7 +1182,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
 	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
-	wait_for_completion(&cm_id_priv->comp);
+	do {
+		ret = wait_for_completion_timeout(&cm_id_priv->comp,
+						  msecs_to_jiffies(
+						  CM_DESTROY_ID_WAIT_TIMEOUT));
+		if (!ret) /* timeout happened */
+			cm_destroy_id_wait_timeout(cm_id);
+	} while (!ret);
+
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
 
-- 
2.43.0


