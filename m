Return-Path: <linux-rdma+bounces-3808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F392DE17
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 03:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2740D1C2138C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B75321D;
	Thu, 11 Jul 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="acykPASy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697B9441
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720662058; cv=none; b=MWo+M1mEgPNExHLXtrai+41f1vf9N7//hR6Nui9rniC72x/ji0NAQy26xfF7b2PaPKuU8eifv4JFMlny2sdv4ja3k/EEpEDo/E1pvrHds4ffXwqOYoNq77/EGoPvVKgViRoFI+O2S0VZ6m9ZXL5OkH5Rh5hmrmKYCVZNJcIKMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720662058; c=relaxed/simple;
	bh=l6Dymuov3Zi0c7SdbYK+XLtj+ERQp/as2r9XGyCU7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnuQuZrqxLRbFZQGHMjL9eUTLqgd03GqUPS5VKLNBlMGQRth6g8KwL9n7B9pzuPGBeOae9Ii5SAKSe+CHx5kUQFrVBEEgZ90dhwohvviXeCHj9C9FS9f24h6FUhxoi4GTwjPDpRCHQ/fs8PQqzGZzYSRRZy+8+ZUb7tlak8Mh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=acykPASy; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=xnouZ
	IB4OtOOBETcS+PdhBxM5g6t//PG5HvUptZetVQ=; b=acykPASydNk5T4HMlOsnP
	zeUYpWsuOpAcXqpttSxCq2noqlbpZ55NMq03Sfms47v572J7Zr9lwc8IrZuOOMFH
	9IlNOSpohatsFKYjXvC2eF/D11f1mKsyGbNFiBskdOX/L/d3v2do/TqhVKoUgCdg
	iuu7IVjf9OkmBQYR6ju4UY=
Received: from fc39.. (unknown [125.33.20.250])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDHZ9QTOI9mEEwWBA--.13394S4;
	Thu, 11 Jul 2024 09:40:36 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: zyjzyj2000@gmail.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	rpearsonhpe@gmail.com,
	linux-rdma@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
Date: Thu, 11 Jul 2024 09:40:06 +0800
Message-ID: <20240711014006.11294-1-honggangli@163.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHZ9QTOI9mEEwWBA--.13394S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKry3Zw4fZrW8Ar48KrW5GFg_yoW7WFy3pa
	y8J34Ykr4fXF429anYyr48ZFsxC3Wku3srGFZay3s3XFn5C3y3XFs7Ary7uFWrtF9rGF1x
	tFyjyr4DCryrGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMnmi9UUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiDxQZRWVOFJT7AgAAsV

If ib_req_notify_cq() was called in complete handler, deadlock occurs
in receive path.

rxe_req_notify_cq+0x21/0x70 [rdma_rxe]
krping_cq_event_handler+0x26f/0x2c0 [rdma_krping]
rxe_cq_post+0x128/0x1d0 [rdma_rxe]
? copy_data+0xe0/0x230 [rdma_rxe]
rxe_responder+0xbe8/0x23a0 [rdma_rxe]
do_task+0x68/0x1e0 [rdma_rxe]
? __pfx_rxe_udp_encap_recv+0x10/0x10 [rdma_rxe]
rxe_udp_encap_recv+0x79/0xe0 [rdma_rxe]
udp_queue_rcv_one_skb+0x272/0x540
udp_unicast_rcv_skb+0x76/0x90
__udp4_lib_rcv+0xab2/0xd60
? raw_local_deliver+0xd2/0x2a0
ip_protocol_deliver_rcu+0xd1/0x1b0
ip_local_deliver_finish+0x76/0xa0
ip_local_deliver+0x68/0x100
? ip_rcv_finish_core.isra.0+0xc2/0x430
ip_sublist_rcv+0x2a0/0x340
ip_list_rcv+0x13b/0x170
__netif_receive_skb_list_core+0x2bb/0x2e0
netif_receive_skb_list_internal+0x1cd/0x300
napi_complete_done+0x72/0x200
e1000e_poll+0xcf/0x320 [e1000e]
__napi_poll+0x2b/0x160
net_rx_action+0x2c6/0x3b0
? enqueue_hrtimer+0x42/0xa0
handle_softirqs+0xf7/0x340
? sched_clock_cpu+0xf/0x1f0
__irq_exit_rcu+0x97/0xb0
common_interrupt+0x85/0xa0

Fixes: 0c7e314a6352 ("RDMA/rxe: Fix rxe_cq_post")
Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 35 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 ++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fec87c9030ab..97a537994aee 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -39,6 +39,21 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	return -EINVAL;
 }
 
+static void rxe_send_complete(struct tasklet_struct *t)
+{
+	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->cq_lock, flags);
+	if (cq->is_dying) {
+		spin_unlock_irqrestore(&cq->cq_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
+	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+}
+
 int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     int comp_vector, struct ib_udata *udata,
 		     struct rxe_create_cq_resp __user *uresp)
@@ -64,6 +79,10 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	cq->is_user = uresp;
 
+	cq->is_dying = false;
+
+	tasklet_setup(&cq->comp_task, rxe_send_complete);
+
 	spin_lock_init(&cq->cq_lock);
 	cq->ibcq.cqe = cqe;
 	return 0;
@@ -84,7 +103,6 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 	return err;
 }
 
-/* caller holds reference to cq */
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
@@ -113,17 +131,26 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		tasklet_schedule(&cq->comp_task);
 	}
 
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-
 	return 0;
 }
 
+void rxe_cq_disable(struct rxe_cq *cq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->cq_lock, flags);
+	cq->is_dying = true;
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+}
+
 void rxe_cq_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_cq *cq = container_of(elem, typeof(*cq), elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ded46119151b..ba84f780aa3d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -31,6 +31,8 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
 
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
+void rxe_cq_disable(struct rxe_cq *cq);
+
 void rxe_cq_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mcast.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index de6238ee4379..a964d86789f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1205,6 +1205,8 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		goto err_out;
 	}
 
+	rxe_cq_disable(cq);
+
 	err = rxe_cleanup(cq);
 	if (err)
 		rxe_err_cq(cq, "cleanup failed, err = %d\n", err);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3c1354f82283..03df97e83570 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -63,7 +63,9 @@ struct rxe_cq {
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
 	u8			notify;
+	bool			is_dying;
 	bool			is_user;
+	struct tasklet_struct	comp_task;
 	atomic_t		num_wq;
 };
 
-- 
2.45.2


