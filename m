Return-Path: <linux-rdma+bounces-12523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C8B14A94
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222154E156F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2C275B04;
	Tue, 29 Jul 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ire/ACUF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B619D09C;
	Tue, 29 Jul 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779621; cv=none; b=CA4R2PiZqZLewDrN+nf8TRmdGHRu3HdC4F+4z+2Ip/8v2lZGCnVEHotVmxf+36EOuTsF4ORnlKjggpz2JWRa7m4TKg1puxRWwXdd++TSqTHvIa63svsmR++NqhfPZ3Qy8ZQ9hfWd+UjjP4uZsYo6uO/cT+ghBuYfaA2Ur/3uo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779621; c=relaxed/simple;
	bh=DsCF20Q44FCdFYI8M9L9FEFSHIMRHjullCSimqZXOoY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LJsyUmQcVoMgV5XP5yuhBuXrHtNsRcDtx6kalXN+2sgdxq8+ZWSMuw/xCxa9PtHyTyJf82bjf/kGacZ/Mo5jcCMURVAzn/5RVnR/dMyVERelF47EDIwsOyAuzcoGuFcVHks3frc6PhFcdcXnl1RIEBJpRidIpTyc0Oz24y025Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ire/ACUF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 7C94721176FC; Tue, 29 Jul 2025 02:00:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C94721176FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753779618;
	bh=r7wwOkDiGql8oFTfJZqe5CtlN+nAao9E22lf68AMpm8=;
	h=From:To:Cc:Subject:Date:From;
	b=Ire/ACUFf7rZ+dETogxGwYzzt6ubpO7FB3FXp6WD4IYwsKlra8kKZuKdYWgsNAzaJ
	 r3siqkPbaXqbJkVEawNy49H5r8kutlP1OTh+Za1qlL3EfpRuDlmAWZ2GYoyMC322x/
	 ivBt2kuly84Ze3hLeZk2zhrN5OYUJqQkfZlIFzRk=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: drain send wrs of gsi qp
Date: Tue, 29 Jul 2025 02:00:18 -0700
Message-Id: <1753779618-23629-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Drain send WRs of the GSI QP on device removal.

In rare servicing scenarios, the hardware may delete the
state of the GSI QP, preventing it from generating CQEs
for pending send WRs. Since WRs submitted to the GSI QP
hold CM resources, the device cannot be removed until
those WRs are completed. This patch marks all pending
send WRs as failed, allowing the GSI QP to release the CM
resources and enabling safe device removal.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 26 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/device.c  |  3 +++
 drivers/infiniband/hw/mana/mana_ib.h |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 28e154bbb50f..1becc8779123 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -291,6 +291,32 @@ static int mana_process_completions(struct mana_ib_cq *cq, int nwc, struct ib_wc
 	return wc_index;
 }
 
+void mana_drain_gsi_sqs(struct mana_ib_dev *mdev)
+{
+	struct mana_ib_qp *qp = mana_get_qp_ref(mdev, MANA_GSI_QPN, false);
+	struct ud_sq_shadow_wqe *shadow_wqe;
+	struct mana_ib_cq *cq;
+	unsigned long flags;
+
+	if (!qp)
+		return;
+
+	cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+
+	spin_lock_irqsave(&cq->cq_lock, flags);
+	while ((shadow_wqe = shadow_queue_get_next_to_complete(&qp->shadow_sq))
+			!= NULL) {
+		shadow_wqe->header.error_code = IB_WC_GENERAL_ERR;
+		shadow_queue_advance_next_to_complete(&qp->shadow_sq);
+	}
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
+	if (cq->ibcq.comp_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
+	mana_put_qp_ref(qp);
+}
+
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index fa60872f169f..bdeddb642b87 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -230,6 +230,9 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 {
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
+	if (mana_ib_is_rnic(dev))
+		mana_drain_gsi_sqs(dev);
+
 	ib_unregister_device(&dev->ib_dev);
 	dma_pool_destroy(dev->av_pool);
 	if (mana_ib_is_rnic(dev)) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 5d31034ac7fb..af09a3e6ccb7 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -43,6 +43,8 @@
  */
 #define MANA_AV_BUFFER_SIZE	64
 
+#define MANA_GSI_QPN		(1)
+
 struct mana_ib_adapter_caps {
 	u32 max_sq_id;
 	u32 max_rq_id;
@@ -718,6 +720,7 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr);
 
+void mana_drain_gsi_sqs(struct mana_ib_dev *mdev);
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 
-- 
2.43.0


