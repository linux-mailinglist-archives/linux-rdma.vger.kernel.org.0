Return-Path: <linux-rdma+bounces-8430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB94A55618
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1433A954A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874A25A652;
	Thu,  6 Mar 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ET2LSxvO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B513B791;
	Thu,  6 Mar 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287720; cv=none; b=LS61wVs5IXXnS4oPG8noQ6eprydegQqWUPXbREucfstZhKdV4fh58Im4NF8ESIUMEdr94SsJJIaOPcsCoYJsQNPk2yRzGpliEf0MTUM/c4cJQQtUkx6il0KIAIeN9LRvsXyBgX9yZpucyWdzvp/sfzTnImrzRtLQ0u3R5wksH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287720; c=relaxed/simple;
	bh=2GUy9c0Fp47qaNghIUFQ7uC7AKBpYxEeyN9JkZzEBow=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s6yurxpc7cA/7MMVinSS076UJ9myDRXnyEgpAtSpX7jXA+KOFN4KfsfzfxMn/jpWHpyFzivJh27OL52OpydUavqAnRo2nhKQ9VOUO6HAbfSn6lLFqu9aL4Qd6f/WxcKrL9R5wHJl8Z22uIe2NvUGtNQTjeCyWhrKScFRYHiqyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ET2LSxvO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE9D1210EAFF;
	Thu,  6 Mar 2025 11:01:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE9D1210EAFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741287718;
	bh=geTq2s7qAZPY7wuOn3Tp2rejisU2kA66dHe+A4j6rx0=;
	h=From:To:Cc:Subject:Date:From;
	b=ET2LSxvO7fy+HJ+ac//4b1P3R5JRhckGJOm8QvdykAFrMzzhzjiZtX9JbSlbHk39i
	 mDjTOAJbBMMcdfRnN0E74yNH/kun3XHyV7Uv87yhqLYt0b1Q2UT5dfPz60RIa3nRVu
	 FFQCq6UCJzoLMtHrsbdykpHIuzotKHKEgmtsaP5E=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during queue creation
Date: Thu,  6 Mar 2025 11:01:53 -0800
Message-Id: <1741287713-13812-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use size_t instead of u32 in helpers for queue creations
to detect overflow of queue size. The queue size cannot
exceed size of u32.

Fixes: bd4ee700870a ("RDMA/mana_ib: UD/GSI QP creation for kernel")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      |  9 +++++----
 drivers/infiniband/hw/mana/main.c    | 15 +++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h |  4 ++--
 drivers/infiniband/hw/mana/qp.c      | 11 ++++++-----
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 5c325ef..07b97da 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -18,7 +18,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct gdma_context *gc;
 	bool is_rnic_cq;
 	u32 doorbell;
-	u32 buf_size;
+	size_t buf_size;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
@@ -45,7 +45,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 
 		cq->cqe = attr->cqe;
-		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
+		buf_size = (size_t)cq->cqe * COMP_ENTRY_SIZE;
+		err = mana_ib_create_queue(mdev, ucmd.buf_addr, buf_size,
 					   &cq->queue);
 		if (err) {
 			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
@@ -57,8 +58,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		doorbell = mana_ucontext->doorbell;
 	} else {
 		is_rnic_cq = true;
-		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
-		cq->cqe = buf_size / COMP_ENTRY_SIZE;
+		cq->cqe = attr->cqe;
+		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two((size_t)attr->cqe * COMP_ENTRY_SIZE));
 		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
 		if (err) {
 			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 091e6b2..cc9de4b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -240,7 +240,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
 }
 
-int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
+int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, size_t size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
@@ -249,6 +249,12 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 
 	queue->id = INVALID_QUEUE_ID;
 	queue->gdma_region = GDMA_INVALID_DMA_REGION;
+
+	if (size > U32_MAX) {
+		ibdev_dbg(&mdev->ib_dev, "Queue size exceeding limit %zu\n", size);
+		return -EINVAL;
+	}
+
 	spec.type = type;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = size;
@@ -261,7 +267,7 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 	return 0;
 }
 
-int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, size_t size,
 			 struct mana_ib_queue *queue)
 {
 	struct ib_umem *umem;
@@ -271,6 +277,11 @@ int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
 	queue->id = INVALID_QUEUE_ID;
 	queue->gdma_region = GDMA_INVALID_DMA_REGION;
 
+	if (size > U32_MAX) {
+		ibdev_dbg(&mdev->ib_dev, "Queue size exceeding limit %zu\n", size);
+		return -EINVAL;
+	}
+
 	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index bd47b7f..282b0ae 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -589,9 +589,9 @@ int mana_ib_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 				  mana_handle_t gdma_region);
 
-int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
+int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, size_t size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue);
-int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
+int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, size_t size,
 			 struct mana_ib_queue *queue);
 void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index c92465d..36050e7 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -377,18 +377,18 @@ static u32 mana_ib_wqe_size(u32 sge, u32 oob_size)
 	return ALIGN(wqe_size, GDMA_WQE_BU_SIZE);
 }
 
-static u32 mana_ib_queue_size(struct ib_qp_init_attr *attr, u32 queue_type)
+static size_t mana_ib_queue_size(struct ib_qp_init_attr *attr, u32 queue_type)
 {
-	u32 queue_size;
+	size_t queue_size;
 
 	switch (attr->qp_type) {
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		if (queue_type == MANA_UD_SEND_QUEUE)
-			queue_size = attr->cap.max_send_wr *
+			queue_size = (size_t)attr->cap.max_send_wr *
 				mana_ib_wqe_size(attr->cap.max_send_sge, INLINE_OOB_LARGE_SIZE);
 		else
-			queue_size = attr->cap.max_recv_wr *
+			queue_size = (size_t)attr->cap.max_recv_wr *
 				mana_ib_wqe_size(attr->cap.max_recv_sge, INLINE_OOB_SMALL_SIZE);
 		break;
 	default:
@@ -608,7 +608,8 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	u32 doorbell, queue_size;
+	size_t queue_size;
+	u32 doorbell;
 	int i, err;
 
 	if (udata) {
-- 
2.43.0


