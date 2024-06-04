Return-Path: <linux-rdma+bounces-2822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A038FB133
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835101C21AD0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063F14535B;
	Tue,  4 Jun 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CQ0m0CP9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CC38B;
	Tue,  4 Jun 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500972; cv=none; b=PuewJBehhrAA4eb4kq41JH5xkftR56uKs75dE7nlqkJaMg3MbEstWy/5yxP6sh0HwC1XxFGrgKirSQ3r8z4ekUV+eVqPTl4GZNE/t1NQpVgTzEydxOosR6TQ53YhXB/kbYSAz6+QluswK/lN/F/XbaEkoXYqNacwHSSaqKfdjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500972; c=relaxed/simple;
	bh=02u0kNPyfblbpdwTQTDwg+4zFb9EyB2G2DK5wKRR5ZY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fXNS8FYNk9VP7AckgYn6tFszWjZcEfrkJtV5L/PfV8O6agWPZAfNS7MLEGqKXyVbF48FLHLriCYbe9pJ6fsSCQuUzJhC4yUx54Z6L9wE6xjHHFPAdQXqYDzByoRs1bT9laKtk23fRSrmX0boVYLGzodi5nyhhCjbXHI0dNaMn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CQ0m0CP9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 391F720B915A;
	Tue,  4 Jun 2024 04:36:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 391F720B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717500970;
	bh=P719o/fbklQlZn6JZundaChgkDKmyxtoWTlV7qJ1Hoo=;
	h=From:To:Cc:Subject:Date:From;
	b=CQ0m0CP92PDJfkAMxdRkZq8Cagk+hYrZpV5Bk42kg4KkcHZo9+kxlecwhRvbdgZu1
	 wAIl91nxLWqJhj8SaDdPZhOqPjZxmvne1LAqZ6mbLT2+4JQQaZM2oWdVWU3vKmFAmJ
	 B+p9LpJVPxnVih3nFTXvyWeDUJ8UIjgVilgi5r5k=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	weh@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Date: Tue,  4 Jun 2024 04:36:03 -0700
Message-Id: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Process QP fatal events from the error event queue.
For that, find the QP, using QPN from the event, and then call its
event_handler. To find the QPs, store created RC QPs in an xarray.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c           |  3 ++
 drivers/infiniband/hw/mana/main.c             | 37 ++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h          |  4 ++
 drivers/infiniband/hw/mana/qp.c               | 11 ++++++
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 include/net/mana/gdma.h                       |  1 +
 6 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 9a7da2e..9eb714e 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -126,6 +126,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (ret)
 		goto destroy_eqs;
 
+	xa_init_flags(&dev->qp_table_rq, XA_FLAGS_LOCK_IRQ);
 	ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
@@ -143,6 +144,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	return 0;
 
 destroy_rnic:
+	xa_destroy(&dev->qp_table_rq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
@@ -158,6 +160,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
+	xa_destroy(&dev->qp_table_rq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 365b4f1..dfcfb88 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -667,6 +667,39 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	return 0;
 }
 
+static void
+mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event *event)
+{
+	struct mana_ib_dev *mdev = (struct mana_ib_dev *)ctx;
+	struct mana_ib_qp *qp;
+	struct ib_event ev;
+	unsigned long flag;
+	u32 qpn;
+
+	switch (event->type) {
+	case GDMA_EQE_RNIC_QP_FATAL:
+		qpn = event->details[0];
+		xa_lock_irqsave(&mdev->qp_table_rq, flag);
+		qp = xa_load(&mdev->qp_table_rq, qpn);
+		if (qp)
+			refcount_inc(&qp->refcount);
+		xa_unlock_irqrestore(&mdev->qp_table_rq, flag);
+		if (!qp)
+			break;
+		if (qp->ibqp.event_handler) {
+			ev.device = qp->ibqp.device;
+			ev.element.qp = &qp->ibqp;
+			ev.event = IB_EVENT_QP_FATAL;
+			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+		}
+		if (refcount_dec_and_test(&qp->refcount))
+			complete(&qp->free);
+		break;
+	default:
+		break;
+	}
+}
+
 int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
@@ -676,7 +709,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.type = GDMA_EQ;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = EQ_SIZE;
-	spec.eq.callback = NULL;
+	spec.eq.callback = mana_ib_event_handler;
 	spec.eq.context = mdev;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
@@ -691,7 +724,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 		err = -ENOMEM;
 		goto destroy_fatal_eq;
 	}
-
+	spec.eq.callback = NULL;
 	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
 		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 60bc548..b732555 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -62,6 +62,7 @@ struct mana_ib_dev {
 	mana_handle_t adapter_handle;
 	struct gdma_queue *fatal_err_eq;
 	struct gdma_queue **eqs;
+	struct xarray qp_table_rq;
 	struct mana_ib_adapter_caps adapter_caps;
 };
 
@@ -124,6 +125,9 @@ struct mana_ib_qp {
 
 	/* The port on the IB device, starting with 1 */
 	u32 port;
+
+	refcount_t		refcount;
+	struct completion	free;
 };
 
 struct mana_ib_ucontext {
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 34a9372..3f4fcc9 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -460,6 +460,12 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		}
 	}
 
+	refcount_set(&qp->refcount, 1);
+	init_completion(&qp->free);
+	err = xa_insert_irq(&mdev->qp_table_rq, qp->ibqp.qp_num, qp, GFP_KERNEL);
+	if (err)
+		goto destroy_qp;
+
 	return 0;
 
 destroy_qp:
@@ -620,6 +626,11 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
 	int i;
 
+	xa_erase_irq(&mdev->qp_table_rq, qp->ibqp.qp_num);
+	if (refcount_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+	wait_for_completion(&qp->free);
+
 	/* Ignore return code as there is not much we can do about it.
 	 * The error message is printed inside.
 	 */
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index d33b272..ab8adac 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -380,6 +380,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
 	case GDMA_EQE_HWC_INIT_DATA:
 	case GDMA_EQE_HWC_INIT_DONE:
+	case GDMA_EQE_RNIC_QP_FATAL:
 		if (!eq->eq.callback)
 			break;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 2768413..44c797d 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -60,6 +60,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_DONE		= 131,
 	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
 
 enum {
-- 
2.43.0


