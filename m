Return-Path: <linux-rdma+bounces-2102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260BB8B3814
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800B92840F0
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61331482EB;
	Fri, 26 Apr 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S47mHtzp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF8146D55;
	Fri, 26 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137168; cv=none; b=Ek23phF8LG7rqYUekb/XmxXlqOUCsGWyJNfnwd325ny7u5jWAsELB/6iI+p5M+3JEUBj/UvF7d1enz0/8jaTpsWn6cQeUouliCTWP2kgFn5CRce+2Bp02+AHenh1d4uvW+xi7pq8sAHi10XUQhSgpGkyWpNn+HCMD+4X7ze/npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137168; c=relaxed/simple;
	bh=Usu77U3GYcspHtKEiK5azthR80eo1pinrp+TtsB6MkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ul6oX/JnwLwGS3N9gxenTh+NwgkdbhA72ux2/qE3xCQgRnYMdsrA4u/oHpN9tKwDST1w2goEARBFoaCZyCcY3WhsS/6u7KDzE/op78CM7dH2XspflyWiYqxnKxivv7S/qUSFhJvEoCKN8934ISVCukllG9/NZmnj2WE5ln9VbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S47mHtzp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3788210EF25;
	Fri, 26 Apr 2024 06:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3788210EF25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714137165;
	bh=ltCMK8jIH6z2pJvdSWPrhUfu9Ob4wk1gjWILq73eM6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S47mHtzpRhOyeXa5ecUVA7kMQWNoJJFbLbJwvrRke/JmsYyrKynNbvKEUjHhw3Cg+
	 /ON2Ni6W8aClC00SX2HxNjkOWH1mT/Iv8OpvUsAgjkokVRpeF5DUo2vB3+kRThKMYd
	 INAA3ITsv/3IjiJJZJfir1OKm1o0Jrxcs9vYbiaU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/5] RDMA/mana_ib: create EQs for RNIC CQs
Date: Fri, 26 Apr 2024 06:12:36 -0700
Message-Id: <1714137160-5222-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Create EQs within mana_ib device. Such EQs are required
for creation of RNIC CQs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
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


