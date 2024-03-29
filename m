Return-Path: <linux-rdma+bounces-1666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28052891F55
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D25B28BBB
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6A14C5BB;
	Fri, 29 Mar 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJyS7rEu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6516C459;
	Fri, 29 Mar 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716443; cv=none; b=kXU3m1vlQQRVlZ/ltHT/BsNURyw4Wih8/JbQdSxT9lCOJX90NxbyO8cCCErpsEiS2H4e2DiMh0RNb2C7uIl/YiVUt6IOwQYLcxiGvJ0nQ3EwrW4uIGGkBHVDh4xYKxBDFNwCNHm6ZhlkuzeQqCB5kXqSmlaTAItjSnQN9CdGg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716443; c=relaxed/simple;
	bh=HYVuJYmf6hryDlxKDkRvVdXDUbrtfxHve60c2wv2Abc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGgPyyyLMoiUBX85t4CxKWfKS2ZlwRff8mON09/HiUZ0IERRrl/HQXbGmrBqihWxZTjdCfIwoSAM/z4lGmY2zmDTvqLR6vafungcP4UbSKJshj30t2DepvEQaQHZCZ8D7pXOR2PLvF7Twl/T+oBgZ4vKpti5Ic994Ws91F9vhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJyS7rEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59087C43399;
	Fri, 29 Mar 2024 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716443;
	bh=HYVuJYmf6hryDlxKDkRvVdXDUbrtfxHve60c2wv2Abc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJyS7rEu3TIjExhg67/cBEapP7c29WN8ZoKdynKt/mPBiWEALflxqBY+QK/KAJ1cN
	 toUjqkTkpdhgLOx9jJB23tyWvS415f8Fc+qjnhGge7+UpBxI3pFtF/Tn2kTx19Hksv
	 nM5kP7BWVIAdN6HW5XvS2ZJ+sHdB59H+jUtAL6h2+fpEaTfKetPbZ1k/0stBOtNCZV
	 Qryy+mZGsYK1A+ieZz31dpQcPfRwvgvdQb0SvGm/EmYOHG6akBcLplowTYamReO2xN
	 TAJE7DZMm0IqwpHjS8EvZCMhjGKCJt6EYSbZPBoGR/i+gTR5wvHrNSn/EjDWlE2J+s
	 RwYcJN0UHweuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manjunath Patil <manjunath.b.patil@oracle.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	markzhang@nvidia.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 44/52] RDMA/cm: add timeout to cm_destroy_id wait
Date: Fri, 29 Mar 2024 08:45:38 -0400
Message-ID: <20240329124605.3091273-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index b7f9023442890..462a10d6a5762 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -1025,10 +1026,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
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
@@ -1135,7 +1146,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
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


