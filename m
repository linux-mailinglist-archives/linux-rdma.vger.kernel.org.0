Return-Path: <linux-rdma+bounces-1884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF289EDDA
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDDB21D16
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF174156C71;
	Wed, 10 Apr 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ITcb7ATo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D113D287;
	Wed, 10 Apr 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738560; cv=none; b=oBdBw2ung/xHL7oofnVsvhykEzZno8Y2dpPupJ8VDL5zXUnyyTbSZN2sh1XIxllWhPseH/x+qL3Pq98odbUgqcvUm4hkUEF5aUev8eabpWK1I1Y/K9OBwl2/HTZmOgrA2Q5Ggk6Xpt0QALZGPT/xoNCUW9uYCDetGdf9O+MFAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738560; c=relaxed/simple;
	bh=A8kZwsP81xoK220n20L70ADejLMYA33cTzAWE7Uq75M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AqO+B2+GSGzcYe8yB09ncA4PVQ+IvMM++AV5d9y3NtiidEkKEpHJz2BpfBp6+RSni/5MoveMXS4AOztCFgpkSxtPDKRW1D/4RHPfPfh2TIExcwbcG3X/h/LxbfAgDnM+Bq1wMCvqyMXx08DW3eCFYqZu0kERQinxDtyuwbxhgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ITcb7ATo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 807BF20EB0EE;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 807BF20EB0EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=cghJsl2qoWz1C17ZFTtK+EhZ1gCGU0AbzJLUQLcdmg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITcb7AToJGQZzGhqs7KcJQA4P52lCVEERVIxnY9eoI7EY1dvdRc/h+ol4Lk0Ntruw
	 qmvzl//th6m6zJXUJ1lbC4Nopogu0/BBYXbvaI3pgxcpMCFoYRoVUgsTJxa2OFQ2gW
	 RzmvQtVY7lzHocZkZxEHjZNm4j7eH4FqyjVru7Zw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 1/6] RDMA/mana_ib: Add EQ creation for rnic adapter
Date: Wed, 10 Apr 2024 01:42:26 -0700
Message-Id: <1712738551-22075-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Create an error EQ for the RNIC adapter.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 13 ++++++++++---
 drivers/infiniband/hw/mana/main.c    | 26 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  5 +++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 6fa902ee80a6..335ac6baa8d4 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -92,15 +92,23 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	ret = mana_ib_create_eqs(dev);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
+		goto deregister_device;
+	}
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto deregister_device;
+		goto destroy_eqs;
 
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
 
+destroy_eqs:
+	mana_ib_destroy_eqs(dev);
 deregister_device:
 	mana_gd_deregister_device(dev->gdma_dev);
 free_ib_device:
@@ -113,9 +121,8 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
-
+	mana_ib_destroy_eqs(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
-
 	ib_dealloc_device(&dev->ib_dev);
 }
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 4524c6b80748..4a9571c14853 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -613,3 +613,29 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 
 	return 0;
 }
+
+int mana_ib_create_eqs(struct mana_ib_dev *mdev)
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
+void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
+{
+	mana_gd_destroy_queue(mdev_to_gc(mdev), mdev->fatal_err_eq);
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index ceca21cef72a..7c55204125de 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -54,6 +54,7 @@ struct mana_ib_queue {
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	struct gdma_queue *fatal_err_eq;
 	struct mana_ib_adapter_caps adapter_caps;
 };
 
@@ -233,4 +234,8 @@ int mana_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 void mana_ib_disassociate_ucontext(struct ib_ucontext *ibcontext);
 
 int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
+
+int mana_ib_create_eqs(struct mana_ib_dev *mdev);
+
+void mana_ib_destroy_eqs(struct mana_ib_dev *mdev);
 #endif
-- 
2.43.0


