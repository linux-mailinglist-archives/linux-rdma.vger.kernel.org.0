Return-Path: <linux-rdma+bounces-1975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62B8AA05D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9A1C20E05
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B017165C;
	Thu, 18 Apr 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GANkhwYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73662171648;
	Thu, 18 Apr 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459132; cv=none; b=pdnMfKDRut+ZjBFst9FFSB11IX0kCVsF6J8+ggKDE6QM/kc3/eh0NlMlUI65O3Uz1UA6QwMlWuH6o7Vlnb5uUjiPspk0i9dEMowBxw/Q4FT+PausYEplm2pdX61ad4mPU9TnKjMM38qUr//N7Cisy5L1jgroXTLH4KjeateEykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459132; c=relaxed/simple;
	bh=/0uuLjjYWxSxyb5NnVn+FuSGipT7WnI35hM/uEhelXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aVMW2bn+Pz9ju3FH3suoAPhrV1bVWRK1wCBybBaOHfBU4Iy+R2cYQ0PEB9I2A16qqxmyesWt6kBfd6syzsGZMWzKMPBUB2cfrP3hHy389CU+Hd+zlPdbYN3Nlmyu/wq5ge1Dyo7IsjWFovQPjfYPPy60YAbOQ0cR/jBSTe4lR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GANkhwYJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2984920FD8CD;
	Thu, 18 Apr 2024 09:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2984920FD8CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713459131;
	bh=tAsZJIj2Of05p989qQAkdOWhFJMrfd7SNYTDHemiUHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GANkhwYJ0GkY+gLzPtqLD9B8+RN6oUeJHrLt6gxBTWT4eYW2fmFe1hrh6qH2qfios
	 VbKl+rdXoX/bzpJIn0+D58z88BlaF6elWGQ16eLuyfUiDOwU71vMLfqkuRbYo4cDi5
	 mlgfTft+VN/W/XOVLzG7niJj6gHalGXsOyiFNNJU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/6] RDMA/mana_ib: create EQs for RNIC CQs
Date: Thu, 18 Apr 2024 09:52:00 -0700
Message-Id: <1713459125-14914-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Create EQs within mana_ib device. Such EQs are required
for creation of RNIC CQs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 34 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/mana/mana_ib.h |  1 +
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f540147..546d059 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -658,7 +658,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
-	int err;
+	int err, i;
 
 	spec.type = GDMA_EQ;
 	spec.monitor_avl_buf = false;
@@ -672,12 +672,42 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	if (err)
 		return err;
 
+	mdev->eqs = kcalloc(mdev->ib_dev.num_comp_vectors, sizeof(struct gdma_queue *),
+			    GFP_KERNEL);
+	if (!mdev->eqs) {
+		err = -ENOMEM;
+		goto destroy_fatal_eq;
+	}
+
+	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
+		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
+		if (err)
+			goto destroy_eqs;
+	}
+
 	return 0;
+
+destroy_eqs:
+	while (i-- > 0)
+		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+	kfree(mdev->eqs);
+destroy_fatal_eq:
+	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+	return err;
 }
 
 void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
 {
-	mana_gd_destroy_queue(mdev_to_gc(mdev), mdev->fatal_err_eq);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	int i;
+
+	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+
+	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++)
+		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+
+	kfree(mdev->eqs);
 }
 
 int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 4c1240d..bfcf6df 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -56,6 +56,7 @@ struct mana_ib_dev {
 	struct gdma_dev *gdma_dev;
 	mana_handle_t adapter_handle;
 	struct gdma_queue *fatal_err_eq;
+	struct gdma_queue **eqs;
 	struct mana_ib_adapter_caps adapter_caps;
 };
 
-- 
2.43.0


