Return-Path: <linux-rdma+bounces-2989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06825900052
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 12:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD55B217A7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C5157A63;
	Fri,  7 Jun 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dRIzQ2Kl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DED1CA85;
	Fri,  7 Jun 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754913; cv=none; b=EH9vnRbwbRGUOqY17wL/OPC3SRcBWMq4Z3pPEMRDI8zfpgAo5zIctJrSu54URzw6xF4Cdkh1M2qgKdK/K3oYFlYjc7qa38k/QkKs0JWV9iamn7ZYN1o88mpX53OEfBMLEYhTFrrvMwQnLae7TA6IRWZ3WEZ0f8HETyFsq9xxBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754913; c=relaxed/simple;
	bh=qld2R9srsXV/Hg8uPR+5FlrI6C210MwPh5xClF7AnVE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QRv8I/pI0TPstVia0wb1EnXDRN6pA2Bxo2ziUheKXgKH9i5jjFh0VeGbaBHDALhM3F4wtWW52rqeMel8ojCfOcI7CtAmpNKVKdH7CZmVfAgKZgHRnU/Iw4QFsi1c11HX9Y6AQuc6v6REJrw/kCL9iyoxC4zmR3n0OiSzBwHdmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dRIzQ2Kl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4982720B9260;
	Fri,  7 Jun 2024 03:08:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4982720B9260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1717754910;
	bh=Kc8PvZsPZKdp9dT96TN8x5FjLAArIFyjP+l/uaalYdo=;
	h=From:To:Cc:Subject:Date:From;
	b=dRIzQ2KlmVvrdEMgU9De54nSncVDRV9/PaQ4GSVWm73t/3cNFVL4pZK+s9EeHlXwQ
	 sYvv5N7m+WCW1+IEmnjpmF/v3oBXflM2DlZyr0/o7pR7uBxgoNta8oxDP8SPKAhyJj
	 y30lEd+pgxNDsvYpvzWc5xSc8NZ2IGhj32HxRVY4=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	weh@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/1] RDMA/mana_ib: process QP error events in mana_ib
Date: Fri,  7 Jun 2024 03:08:17 -0700
Message-Id: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>
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

v2 is the same code, but some code is moved into helper functions

v1->v2
* Introduced helpers to add and remove QPs to/from the table
* Introduced helpers to get and put QP references

 drivers/infiniband/hw/mana/device.c           |  3 ++
 drivers/infiniband/hw/mana/main.c             | 31 +++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h          | 23 ++++++++++++++
 drivers/infiniband/hw/mana/qp.c               | 20 ++++++++++++
 .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
 include/net/mana/gdma.h                       |  1 +
 6 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 9a7da2e..b07a8e2 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -126,6 +126,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	if (ret)
 		goto destroy_eqs;
 
+	xa_init_flags(&dev->qp_table_wq, XA_FLAGS_LOCK_IRQ);
 	ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
@@ -143,6 +144,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	return 0;
 
 destroy_rnic:
+	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
@@ -158,6 +160,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
+	xa_destroy(&dev->qp_table_wq);
 	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 365b4f1..d13abc9 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -667,6 +667,33 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	return 0;
 }
 
+static void
+mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event *event)
+{
+	struct mana_ib_dev *mdev = (struct mana_ib_dev *)ctx;
+	struct mana_ib_qp *qp;
+	struct ib_event ev;
+	u32 qpn;
+
+	switch (event->type) {
+	case GDMA_EQE_RNIC_QP_FATAL:
+		qpn = event->details[0];
+		qp = mana_get_qp_ref(mdev, qpn);
+		if (!qp)
+			break;
+		if (qp->ibqp.event_handler) {
+			ev.device = qp->ibqp.device;
+			ev.element.qp = &qp->ibqp;
+			ev.event = IB_EVENT_QP_FATAL;
+			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+		}
+		mana_put_qp_ref(qp);
+		break;
+	default:
+		break;
+	}
+}
+
 int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
@@ -676,7 +703,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.type = GDMA_EQ;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = EQ_SIZE;
-	spec.eq.callback = NULL;
+	spec.eq.callback = mana_ib_event_handler;
 	spec.eq.context = mdev;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
@@ -691,7 +718,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 		err = -ENOMEM;
 		goto destroy_fatal_eq;
 	}
-
+	spec.eq.callback = NULL;
 	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
 		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 60bc548..6bd2edf 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -62,6 +62,7 @@ struct mana_ib_dev {
 	mana_handle_t adapter_handle;
 	struct gdma_queue *fatal_err_eq;
 	struct gdma_queue **eqs;
+	struct xarray qp_table_wq;
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
@@ -333,6 +337,25 @@ static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 	return mdev->gdma_dev->gdma_context;
 }
 
+static inline struct mana_ib_qp *mana_get_qp_ref(struct mana_ib_dev *mdev, uint32_t qid)
+{
+	struct mana_ib_qp *qp;
+	unsigned long flag;
+
+	xa_lock_irqsave(&mdev->qp_table_wq, flag);
+	qp = xa_load(&mdev->qp_table_wq, qid);
+	if (qp)
+		refcount_inc(&qp->refcount);
+	xa_unlock_irqrestore(&mdev->qp_table_wq, flag);
+	return qp;
+}
+
+static inline void mana_put_qp_ref(struct mana_ib_qp *qp)
+{
+	if (refcount_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+}
+
 static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32 port)
 {
 	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 34a9372..b1afc75 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -398,6 +398,20 @@ err_free_vport:
 	return err;
 }
 
+static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	refcount_set(&qp->refcount, 1);
+	init_completion(&qp->free);
+	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp, GFP_KERNEL);
+}
+
+static void mana_table_remove_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);
+	mana_put_qp_ref(qp);
+	wait_for_completion(&qp->free);
+}
+
 static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 				struct ib_qp_init_attr *attr, struct ib_udata *udata)
 {
@@ -460,6 +474,10 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 		}
 	}
 
+	err = mana_table_store_qp(mdev, qp);
+	if (err)
+		goto destroy_qp;
+
 	return 0;
 
 destroy_qp:
@@ -620,6 +638,8 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
 	int i;
 
+	mana_table_remove_qp(mdev, qp);
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


