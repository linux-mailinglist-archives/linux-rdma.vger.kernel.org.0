Return-Path: <linux-rdma+bounces-1881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D089EDD3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E54B21C0B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75061553B7;
	Wed, 10 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iNINV/HH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78D154C0A;
	Wed, 10 Apr 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738559; cv=none; b=Oxol2VVaIW4lDkSqaxkwsMxJ7WdJndANpUIy9NhXYfIVMFkNc6TR4ZFyYcFiRAcGSIT+XEokEE3iqY9TAdqibP8rfGZLvDv7rHZBQ3mFzBPAAHVkIHVRVy5TXRJIVER2MbXoTxz+33sBSVkntiJi6L3l3Hk5df4kF+hBblz0xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738559; c=relaxed/simple;
	bh=bM0oK7MTXduTMJ4UNCL9VTBSkBbMAxcFDPFIVGvVT68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bK16y9PM+romaDlCD0uoDV1S81QR8Htb8YG4wOFFXOV0w1GtBwsyHS9kSfBUxvSUJAxgPdNWrnnpLVY5lLmvZ8Xc9erjMEXebCtwdwu4ulMjf2ufo5wKHuo0+LdOO1ZbdSjjT/I+haOms3mE8MBU4G0Xy/X0ZLKnUSJ0y7lcTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iNINV/HH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 989A120EB0FB;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 989A120EB0FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=W9w7GJWqvIwZdFH9Mme/YLMG5+pTk49k5ZpBxP4+eUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNINV/HHyPKqelqQui6UKFPmIr9EHfz5RRcxpctjyQ5XkkBtX60ocIIh18zBzxZeR
	 6FUVi0Mk1vqcPP7zn/6R7SOyyR3dxiNLk7oZLjqUYpE0s8JbSbkoWrbsIcYfrJ/WZ4
	 U5EmEgySuo2Ff9KHsEQ0WA85cSa+85z5eUsKBfPM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 2/6] RDMA/mana_ib: Create and destroy rnic adapter
Date: Wed, 10 Apr 2024 01:42:27 -0700
Message-Id: <1712738551-22075-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add functions for RNIC creation and destruction.
If creation fails, the ib_probe fails as well.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  9 +++++-
 drivers/infiniband/hw/mana/main.c    | 43 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 28 ++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 335ac6baa8d4..a98a04ff92e5 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -98,15 +98,21 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		goto deregister_device;
 	}
 
+	ret = mana_ib_gd_create_rnic_adapter(dev);
+	if (ret)
+		goto destroy_eqs;
+
 	ret = ib_register_device(&dev->ib_dev, "mana_%d",
 				 mdev->gdma_context->dev);
 	if (ret)
-		goto destroy_eqs;
+		goto destroy_rnic;
 
 	dev_set_drvdata(&adev->dev, dev);
 
 	return 0;
 
+destroy_rnic:
+	mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	mana_ib_destroy_eqs(dev);
 deregister_device:
@@ -121,6 +127,7 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
 	ib_unregister_device(&dev->ib_dev);
+	mana_ib_gd_destroy_rnic_adapter(dev);
 	mana_ib_destroy_eqs(dev);
 	mana_gd_deregister_device(dev->gdma_dev);
 	ib_dealloc_device(&dev->ib_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 4a9571c14853..aa3cac8d3edb 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -639,3 +639,46 @@ void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
 {
 	mana_gd_destroy_queue(mdev_to_gc(mdev), mdev->fatal_err_eq);
 }
+
+int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
+{
+	struct mana_rnic_create_adapter_resp resp = {};
+	struct mana_rnic_create_adapter_req req = {};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req), sizeof(resp));
+	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.notify_eq_id = mdev->fatal_err_eq->id;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create RNIC adapter err %d", err);
+		return err;
+	}
+	mdev->adapter_handle = resp.adapter;
+
+	return 0;
+}
+
+int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
+{
+	struct mana_rnic_destroy_adapter_resp resp = {};
+	struct mana_rnic_destroy_adapter_req req = {};
+	struct gdma_context *gc;
+	int err;
+
+	gc = mdev_to_gc(mdev);
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to destroy RNIC adapter err %d", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 7c55204125de..842f9c63a495 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -54,6 +54,7 @@ struct mana_ib_queue {
 struct mana_ib_dev {
 	struct ib_device ib_dev;
 	struct gdma_dev *gdma_dev;
+	mana_handle_t adapter_handle;
 	struct gdma_queue *fatal_err_eq;
 	struct mana_ib_adapter_caps adapter_caps;
 };
@@ -113,6 +114,8 @@ struct mana_ib_rwq_ind_table {
 
 enum mana_ib_command_code {
 	MANA_IB_GET_ADAPTER_CAP = 0x30001,
+	MANA_IB_CREATE_ADAPTER  = 0x30002,
+	MANA_IB_DESTROY_ADAPTER = 0x30003,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -141,6 +144,27 @@ struct mana_ib_query_adapter_caps_resp {
 	u32 max_inline_data_size;
 }; /* HW Data */
 
+struct mana_rnic_create_adapter_req {
+	struct gdma_req_hdr hdr;
+	u32 notify_eq_id;
+	u32 reserved;
+	u64 feature_flags;
+}; /*HW Data */
+
+struct mana_rnic_create_adapter_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t adapter;
+}; /* HW Data */
+
+struct mana_rnic_destroy_adapter_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+}; /*HW Data */
+
+struct mana_rnic_destroy_adapter_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -238,4 +262,8 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
 int mana_ib_create_eqs(struct mana_ib_dev *mdev);
 
 void mana_ib_destroy_eqs(struct mana_ib_dev *mdev);
+
+int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev);
+
+int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev);
 #endif
-- 
2.43.0


