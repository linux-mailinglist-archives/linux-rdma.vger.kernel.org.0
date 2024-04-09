Return-Path: <linux-rdma+bounces-1871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5989DA4D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F388D1C222BE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6953136994;
	Tue,  9 Apr 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKDoR7EI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6C13698F
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669192; cv=none; b=V9vFktH8T3i+71Iz1HZSCz+me98NBSRod/n7Zm4IdEqCEQ+Vz+MeomXr6/XemJhk0eE5Jx2TWKrBitHBOrOnXYggZQ+EHWuwQyfOhYEo3F5DU9SLKtwfieGY9ot5y7Idd0AXYa0IYXRQlqeuqmIk7L21B3Anj6kT/KZP3A5AEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669192; c=relaxed/simple;
	bh=pxRzwUSQiLqnKuB9bKH0eaA+10oOxFnhAfBy+rf3HwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1AjqMKbsMLwEM1JTjPhFiJN380FBHKN0IT45kjlV27Ln0ci/vKzHGYbwTZQvLiK0gfH4u/7ftmzxXtCvouyBS3HzlVZK4DlZElp9M4BvbxjZyics2PAMdadmO4vvpYv32tLYJGU5aphXt01EJtM+0BpeAZfJD3fMTUDdc8/7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKDoR7EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B3FC43390;
	Tue,  9 Apr 2024 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669191;
	bh=pxRzwUSQiLqnKuB9bKH0eaA+10oOxFnhAfBy+rf3HwE=;
	h=From:To:Cc:Subject:Date:From;
	b=VKDoR7EI50BH5OY8AoJxLztVjAKA+7GUpFxXN7hKvnSfNIXkJynYsyML2e8o/iYzh
	 Xk1Ify54jvB8R9WtaEYrPorBK1UZDqTciB5520/6tno39e8ui3ptGX72gMuXBZTaYV
	 icUF5lpFd10aBphY1NEO9ITQXgBSZBwbc8VrT+LUFSLChgTZ4anoLoPtiOji4zOfGY
	 d2xkkz3f0f4mdIoCPkKT+lSs6BjjkxlF1fzAT4gdPIu+p9/IL78W1UGlz+FMIqTHDg
	 2jjKMhXNYdTVm5PbnIG9u/E6vaBnSEy6XmL/sKbnpoBwmjXj2YpYfI6os8F+jsmqeL
	 izxdU9SKCgDsw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1] IB/core: Implement a limit on UMAD receive List
Date: Tue,  9 Apr 2024 16:26:25 +0300
Message-ID: <e2262f827f43518e5e3a4d825a3e0514c0f7aa5f.1712668708.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

The existing behavior of ib_umad, which maintains received MAD
packets in an unbounded list, poses a risk of uncontrolled growth.
As user-space applications extract packets from this list, the rate
of extraction may not match the rate of incoming packets, leading
to potential list overflow.

To address this, we introduce a limit to the size of the list. After
considering typical scenarios, such as OpenSM processing, which can
handle approximately 100k packets per second, and the 1-second retry
timeout for most packets, we set the list size limit to 200k. Packets
received beyond this limit are dropped, assuming they are likely timed
out by the time they are handled by user-space.

Notably, packets queued on the receive list due to reasons like
timed-out sends are preserved even when the list is full.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Changed sysfs entry to hard coded value.
 * Rewrote the commit message.
v0: https://lore.kernel.org/all/70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org
---
 drivers/infiniband/core/user_mad.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f5feca7fa9b9..40756b573017 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -63,6 +63,8 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand userspace MAD packet access");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define MAX_UMAD_RECV_LIST_SIZE 200000
+
 enum {
 	IB_UMAD_MAX_PORTS  = RDMA_MAX_PORTS,
 	IB_UMAD_MAX_AGENTS = 32,
@@ -113,6 +115,7 @@ struct ib_umad_file {
 	struct mutex		mutex;
 	struct ib_umad_port    *port;
 	struct list_head	recv_list;
+	atomic_t		recv_list_size;
 	struct list_head	send_list;
 	struct list_head	port_list;
 	spinlock_t		send_lock;
@@ -182,7 +185,8 @@ static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
 
 static int queue_packet(struct ib_umad_file *file,
 			struct ib_mad_agent *agent,
-			struct ib_umad_packet *packet)
+			struct ib_umad_packet *packet,
+			bool is_send_mad)
 {
 	int ret = 1;
 
@@ -192,7 +196,11 @@ static int queue_packet(struct ib_umad_file *file,
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
 		if (agent == __get_agent(file, packet->mad.hdr.id)) {
+			if (is_send_mad || atomic_read(&file->recv_list_size) >
+						   MAX_UMAD_RECV_LIST_SIZE)
+				break;
 			list_add_tail(&packet->list, &file->recv_list);
+			atomic_inc(&file->recv_list_size);
 			wake_up_interruptible(&file->recv_wait);
 			ret = 0;
 			break;
@@ -224,7 +232,7 @@ static void send_handler(struct ib_mad_agent *agent,
 	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
 		packet->length = IB_MGMT_MAD_HDR;
 		packet->mad.hdr.status = ETIMEDOUT;
-		if (!queue_packet(file, agent, packet))
+		if (!queue_packet(file, agent, packet, true))
 			return;
 	}
 	kfree(packet);
@@ -284,7 +292,7 @@ static void recv_handler(struct ib_mad_agent *agent,
 		rdma_destroy_ah_attr(&ah_attr);
 	}
 
-	if (queue_packet(file, agent, packet))
+	if (queue_packet(file, agent, packet, false))
 		goto err2;
 	return;
 
@@ -409,6 +417,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 
 	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
 	list_del(&packet->list);
+	atomic_dec(&file->recv_list_size);
 
 	mutex_unlock(&file->mutex);
 
@@ -421,6 +430,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 		/* Requeue packet */
 		mutex_lock(&file->mutex);
 		list_add(&packet->list, &file->recv_list);
+		atomic_inc(&file->recv_list_size);
 		mutex_unlock(&file->mutex);
 	} else {
 		if (packet->recv_wc)
-- 
2.44.0


