Return-Path: <linux-rdma+bounces-6967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE1A0A2C3
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 11:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9035D188B25C
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A9190072;
	Sat, 11 Jan 2025 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IwJaowgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A718FDDF
	for <linux-rdma@vger.kernel.org>; Sat, 11 Jan 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736591301; cv=none; b=XkCyMIKWjCsnAb0k71FBD4S5+KncSZf7ewIM1Z0lW4BXR5FzJLrwOoEmJTNGS3d577z6PstmO3ZwG8PNeMaQtMfazbj+s/TuXjuYu2yF1VtPHx5F71HT9BWplknHi+mZDl+KRXYXDFa48Xph38sv20lrSt28qPZONzqs6+ehgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736591301; c=relaxed/simple;
	bh=psXkEZJObdKI/w6Asz6AaLDdcJbxijYYPOUa25otQEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCwiuz6bgNYTv4UxjL9Rc5shvWZL33HlAvzG9BqaJ4PYOjzFtDKApYEErT2hcvXk9frJqWdQ9BNwuB12hnRVnaO7CjwLVzmSCRH78k1uCpXYkiUy3JlrHA006tpiGCBEG2bKZYrtFr0OkbF0btZLhOxNfY50VfhYfJbegIb+trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IwJaowgp; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736591291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lbcq05uYZwZ+qrhSJkf7yhTDpCfska0yAKM14aGDDrc=;
	b=IwJaowgpaja2f49dxirE/kO0QWoQhAvs7GnEnBK3ZXHAYFFstCcWOh1X43vKw654DjEb3i
	TDk8DHT1FfsOG+QExwuuu2XJdTFM22orIq8CbRKxAl8Uchs5Q1j/uvMzU0xnvgXuiKe80d
	RDk39CmxI2OIdBjaXkR1DH0SRmKkKX8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Change the return type from int to bool
Date: Sat, 11 Jan 2025 11:27:58 +0100
Message-Id: <20250111102758.308502-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The return type of the functions queue_full and queue_empty should be
bool.

No functional changes.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_queue.h | 4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fec87c9030ab..a2df55e13ea4 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,7 +88,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
-	int full;
+	bool full;
 	void *addr;
 	unsigned long flags;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index c711cb98b949..597e3da469a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -151,7 +151,7 @@ static inline u32 queue_get_consumer(const struct rxe_queue *q,
 	return cons;
 }
 
-static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
+static inline bool queue_empty(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod = queue_get_producer(q, type);
 	u32 cons = queue_get_consumer(q, type);
@@ -159,7 +159,7 @@ static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
 	return ((prod - cons) & q->index_mask) == 0;
 }
 
-static inline int queue_full(struct rxe_queue *q, enum queue_type type)
+static inline bool queue_full(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod = queue_get_producer(q, type);
 	u32 cons = queue_get_consumer(q, type);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8a5fc20fd186..c88140d896c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -870,7 +870,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
 	struct rxe_send_wqe *send_wqe;
 	unsigned int mask;
 	unsigned int length;
-	int full;
+	bool full;
 
 	err = validate_send_wr(qp, ibwr, &mask, &length);
 	if (err)
@@ -960,7 +960,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	unsigned long length;
 	struct rxe_recv_wqe *recv_wqe;
 	int num_sge = ibwr->num_sge;
-	int full;
+	bool full;
 	int err;
 
 	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
@@ -1185,7 +1185,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 	int ret = 0;
-	int empty;
+	bool empty;
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&cq->cq_lock, irq_flags);
-- 
2.34.1


