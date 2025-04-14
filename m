Return-Path: <linux-rdma+bounces-9424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF116A88B0E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F553B3CD5
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BF28DF0F;
	Mon, 14 Apr 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qowdkBkC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58728BABD;
	Mon, 14 Apr 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655332; cv=none; b=f1rZWtAMK0Hj8KOvs7tFLuaSwJmAGoEXhosG6/7mqzR1As5rsummqqePiGbVGIPituG46/UtG8yRKIgYWQF8czqex90C4ggHwYk5HBH9OJg7iof5q+WXHsxtFYaGd6bc7WrhWHTdY+qBU+pr95dMJ5QXN33vRqE214mAsnHirx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655332; c=relaxed/simple;
	bh=wAR3zRcC32JyRZSscQWjjEDRobAr+4tnxdrwNhQ8q6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rdA8vZjXhWLd2hgJCHxIyqG53c7YwS70JhZyilDDWFrurhWePOz7x1VCFXN4KHRh47kNDBtMztRSy/IZWhv31DpMQRjWgXBY8dlVA0/PVsNEHwzJ702VTQB4cgoEku6jasOnHNkUETvpeUoxl6OdYv8itw1m21BWZa+ROC6bNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qowdkBkC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id CE6782052511; Mon, 14 Apr 2025 11:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE6782052511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744655329;
	bh=T+t2Pr+b5X9fRwcM37Y8+xt2plb2c5xj4H5UNxKpUJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qowdkBkCp2uzCmgxfXYX3q5BQzX6goFFqdFKjVOnAvCaNla71eQn7JG338Xewc+3b
	 wyZUdsyHTQxRKcVN4ucW3pa2AjlI8CgnNpEjNvPYAPAn46+fLOjmQH4v5uOei45+IR
	 ZR5rlW4AYCf+EhGFTi+9RVKWp++UblNq+48DfTNw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next 4/4] net: mana: Add support for auxiliary device servicing events
Date: Mon, 14 Apr 2025 11:28:49 -0700
Message-Id: <1744655329-13601-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Handle soc servcing events which require the rdma auxiliary device resources to
be cleaned up during a suspend, and re-initialized during a resume.

Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 11 +++-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 19 ++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 60 +++++++++++++++++++
 include/net/mana/gdma.h                       | 18 ++++++
 include/net/mana/hw_channel.h                 |  9 +++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1caf73c..1d98dd6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -385,6 +385,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
 	case GDMA_EQE_HWC_INIT_DATA:
 	case GDMA_EQE_HWC_INIT_DONE:
+	case GDMA_EQE_HWC_SOC_SERVICE:
 	case GDMA_EQE_RNIC_QP_FATAL:
 		if (!eq->eq.callback)
 			break;
@@ -1438,9 +1439,13 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	mana_gd_init_registers(pdev);
 	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
 
+	gc->service_wq = alloc_ordered_workqueue("gdma_service_wq", 0);
+	if (!gc->service_wq)
+		return -ENOMEM;
+
 	err = mana_gd_setup_irqs(pdev);
 	if (err)
-		return err;
+		goto free_workqueue;
 
 	err = mana_hwc_create_channel(gc);
 	if (err)
@@ -1464,6 +1469,8 @@ destroy_hwc:
 	mana_hwc_destroy_channel(gc);
 remove_irq:
 	mana_gd_remove_irqs(pdev);
+free_workqueue:
+	destroy_workqueue(gc->service_wq);
 	return err;
 }
 
@@ -1474,6 +1481,8 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
 	mana_hwc_destroy_channel(gc);
 
 	mana_gd_remove_irqs(pdev);
+
+	destroy_workqueue(gc->service_wq);
 }
 
 static bool mana_is_pf(unsigned short dev_id)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index a00f915..407b46e 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -112,11 +112,13 @@ out:
 static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 					struct gdma_event *event)
 {
+	union hwc_init_soc_service_type service_data;
 	struct hw_channel_context *hwc = ctx;
 	struct gdma_dev *gd = hwc->gdma_dev;
 	union hwc_init_type_data type_data;
 	union hwc_init_eq_id_db eq_db;
 	u32 type, val;
+	int ret;
 
 	switch (event->type) {
 	case GDMA_EQE_HWC_INIT_EQ_ID_DB:
@@ -199,7 +201,24 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 		}
 
 		break;
+	case GDMA_EQE_HWC_SOC_SERVICE:
+		service_data.as_uint32 = event->details[0];
+		type = service_data.type;
+		val = service_data.value;
 
+		switch (type) {
+		case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
+		case GDMA_SERVICE_TYPE_RDMA_RESUME:
+			ret = mana_rdma_service_event(gd->gdma_context, type);
+			if (ret)
+				dev_err(hwc->dev, "Failed to schedule adev service event: %d\n", ret);
+			break;
+		default:
+			dev_warn(hwc->dev, "Received unknown SOC service type %u\n", type);
+			break;
+		}
+
+		break;
 	default:
 		dev_warn(hwc->dev, "Received unknown gdma event %u\n", event->type);
 		/* Ignore unknown events, which should never happen. */
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 70c4955..d832700 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2982,6 +2982,66 @@ idx_fail:
 	return ret;
 }
 
+static void mana_handle_rdma_servicing(struct work_struct *work)
+{
+	struct mana_service_work *serv_work =
+		container_of(work, struct mana_service_work, work);
+	struct gdma_dev *gd = serv_work->gdma_dev;
+	struct device *dev = gd->gdma_context->dev;
+	int ret;
+
+	switch (serv_work->event) {
+	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
+		if (!gd->adev || gd->is_suspended)
+			break;
+
+		remove_adev(gd);
+		gd->is_suspended = true;
+		break;
+
+	case GDMA_SERVICE_TYPE_RDMA_RESUME:
+		if (!gd->is_suspended)
+			break;
+
+		ret = add_adev(gd, "rdma");
+		if (ret)
+			dev_err(dev, "Failed to add adev on resume: %d\n", ret);
+		else
+			gd->is_suspended = false;
+		break;
+
+	default:
+		dev_warn(dev, "unknown adev service event %u\n",
+			 serv_work->event);
+		break;
+	}
+
+	kfree(serv_work);
+}
+
+int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type event)
+{
+	struct gdma_dev *gd = &gc->mana_ib;
+	struct mana_service_work *serv_work;
+
+	if (gd->dev_id.type != GDMA_DEVICE_MANA_IB) {
+		/* RDMA device is not detected on pci */
+		return 0;
+	}
+
+	serv_work = kzalloc(sizeof(*serv_work), GFP_ATOMIC);
+	if (!serv_work)
+		return -ENOMEM;
+
+	serv_work->event = event;
+	serv_work->gdma_dev = gd;
+
+	INIT_WORK(&serv_work->work, mana_handle_rdma_servicing);
+	queue_work(gc->service_wq, &serv_work->work);
+
+	return 0;
+}
+
 int mana_probe(struct gdma_dev *gd, bool resuming)
 {
 	struct gdma_context *gc = gd->gdma_context;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 89abf98..335d061 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -60,6 +60,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_DONE		= 131,
 	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+	GDMA_EQE_HWC_SOC_SERVICE	= 134,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
 
@@ -70,6 +71,18 @@ enum {
 	GDMA_DEVICE_MANA_IB	= 3,
 };
 
+enum gdma_service_type {
+	GDMA_SERVICE_TYPE_NONE		= 0,
+	GDMA_SERVICE_TYPE_RDMA_SUSPEND	= 1,
+	GDMA_SERVICE_TYPE_RDMA_RESUME	= 2,
+};
+
+struct mana_service_work {
+	struct work_struct work;
+	struct gdma_dev *gdma_dev;
+	enum gdma_service_type event;
+};
+
 struct gdma_resource {
 	/* Protect the bitmap */
 	spinlock_t lock;
@@ -224,6 +237,7 @@ struct gdma_dev {
 	void *driver_data;
 
 	struct auxiliary_device *adev;
+	bool is_suspended;
 };
 
 /* MANA_PAGE_SIZE is the DMA unit */
@@ -409,6 +423,8 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 
 	u64 pf_cap_flags1;
+
+	struct workqueue_struct *service_wq;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
@@ -888,4 +904,6 @@ int mana_gd_destroy_dma_region(struct gdma_context *gc, u64 dma_region_handle);
 void mana_register_debugfs(void);
 void mana_unregister_debugfs(void);
 
+int mana_rdma_service_event(struct gdma_context *gc, enum gdma_service_type event);
+
 #endif /* _GDMA_H */
diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 158b125..83cf933 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -49,6 +49,15 @@ union hwc_init_type_data {
 	};
 }; /* HW DATA */
 
+union hwc_init_soc_service_type {
+	u32 as_uint32;
+
+	struct {
+		u32 value	: 28;
+		u32 type	:  4;
+	};
+}; /* HW DATA */
+
 struct hwc_rx_oob {
 	u32 type	: 6;
 	u32 eom		: 1;
-- 
2.43.0


