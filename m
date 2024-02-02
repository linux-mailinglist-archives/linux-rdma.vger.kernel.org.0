Return-Path: <linux-rdma+bounces-872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C48472A0
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B99D1C27B14
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186C1468F2;
	Fri,  2 Feb 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GwseLGBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE86145346;
	Fri,  2 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886414; cv=none; b=BOXEbKintWuRtHq1dHmIng1ytwCru0q9lbax9brGTXEpMox9H5CzqBgrOteUPhPgZe8sFKgUORM9VRD1Jt3ghRxCa/8Yv0P6vn2dzPoKp2naTp+SWcN76nJoWmcQDZ0/BV7yxetB2pcds16Fj4Yi6p++qHwdA7JmtnZzFoNeEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886414; c=relaxed/simple;
	bh=4ZmPsc+rDgX7rX3N3RoK8DZaj+dzW3V5EQi2cFZw9c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qm3vqxmGtksFdHr+VGMfwGTpb4JBsJDRmMfn9X2CYp4OUmm1dqH4XIhjV70a4qYcGF3XXri6MQ+bk/m61WsBHVFuJ0YdesbgZ3QGNvRKmnPiBiIF99Q/a4OIQsEvgecfkX9g3hxGdcI3J9TXLfcPOVTGj5EfFdBKQ/xSWhJeoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GwseLGBm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 541DB20B2001;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 541DB20B2001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=saDdL5sYNRP0RdrEfccKfGdzxJcVkUQ2VWnSyr2q/F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwseLGBmF4IF6c7qv7lLjifT7x3kKd0qA/BBxUa4uzHH7xKaY/iH9Augap+q1B3DF
	 zLP00weP8S2MoiWqXKwbOUyboPwIqX6VhONzKLhlWw5uENIA3IfqzO3+OBY4r9bqWB
	 TugSxtJGaYXQrbSNXjemOk1hdrlXSD5uFhD9aCtY=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/5] RDMA/mana_ib: Add EQ creation for rnic adapter
Date: Fri,  2 Feb 2024 07:06:33 -0800
Message-Id: <1706886397-16600-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This patch introduces functions for RNIC creation
and creates one EQ for RNIC creation.

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  9 ++++--
 drivers/infiniband/hw/mana/main.c    | 53 ++++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  5 ++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 6fa902e..d8e8b10 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -92,15 +92,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	mana_ib_gd_create_rnic_adapter(dev);
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto deregister_device;
+		goto destroy_rnic_adapter;
 
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
 
+destroy_rnic_adapter:
+	mana_ib_gd_destroy_rnic_adapter(dev);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -113,9 +117,8 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
-
+	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
-
 	ib_dealloc_device(&dev->ib_dev);
 }
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 29dd243..c64d569 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -548,3 +548,56 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 
 	return 0;
 }
+
+static int mana_ib_create_eqs(struct mana_ib_dev *mdev)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_queue_spec spec = {};
+	int err;
+
+	spec.type = GDMA_EQ;
+	spec.monitor_avl_buf = false;
+	spec.queue_size = EQ_SIZE;
+	spec.eq.callback = NULL;
+	spec.eq.context = mdev;
+	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
+	spec.eq.msix_index = 0;
+
+	err = mana_gd_create_mana_eq(&gc->mana_ib, &spec, &mdev->fatal_err_eq);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
+{
+	if (!mdev->fatal_err_eq)
+		return;
+
+	mana_gd_destroy_queue(mdev_to_gc(mdev), mdev->fatal_err_eq);
+	mdev->fatal_err_eq = NULL;
+}
+
+void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
+{
+	int err;
+
+	err = mana_ib_create_eqs(mdev);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create EQs for RNIC err %d", err);
+		goto cleanup;
+	}
+
+	return;
+
+cleanup:
+	ibdev_warn(&mdev->ib_dev,
+		   "RNIC is not available. Only RAW QPs are supported");
+	mana_ib_destroy_eqs(mdev);
+}
+
+void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
+{
+	mana_ib_destroy_eqs(mdev);
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6a03ae6..a4b94ee 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -48,6 +48,7 @@ struct mana_ib_adapter_caps {
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	struct gdma_queue *fatal_err_eq;
 	struct mana_ib_adapter_caps adapter_caps;
 };
 
@@ -228,4 +229,8 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
+
+void mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev);
+
+void mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
 #endif
-- 
1.8.3.1


