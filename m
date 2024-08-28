Return-Path: <linux-rdma+bounces-4599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10198961F13
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AE11F24FE5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1C155345;
	Wed, 28 Aug 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GI5ykoAE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ECC14B945
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825392; cv=none; b=gb6aNMn/VePiw7jxmmrA9k4FNwNeN4wb1fUJkzKraBR9aB6gSrOMhmKSQ7DYwomoQ0okIJlkMq0RhEJkXL5a+n/GR9MOsL4UjHpQgFrCJX9Mww4L12wx/Jb3RcIzqpGGUp3EjsX68yxRoSy7GloVa3tQxHGHfXm9jvvndoIESis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825392; c=relaxed/simple;
	bh=kllXqj7/n7qr5ooiWLb4gkupRQZfpra1DehjCKInps0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQgtObPxK/fUJhxpZWTeWgLd261JULsouTcVpY3taBSejj1M0QgKQCda09uh1BXRY0SkMOETx4AZ6esPPJyxNRQ5V7msIJvF6ovzVaLtevqq1wWwo2cyWNgpg1hnf/n/xijp2Z5G8v1EEfsjtReDWS68i0bT1c9KUhuP3LAMLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GI5ykoAE; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724825386; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3B0UdIQF1Wd35JDJ4rkg/HdwUySaqmCTJOmNmTkeSkU=;
	b=GI5ykoAEnMgpgfqCujgrgoyGyBAnzskWvDWLS4OpOjp6KJK1nTHcCjD/BWNEDea5iE6DoHzj9tlyke/sEMNiopMQskhR1svijG2YmtLurbN3OUTCwdiQC6RSandaUNgyJzjEOmxORupoiUCvtd5vIlhVZWL0Ws+ctBcS3o/6skA=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDok9M6_1724825385)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 14:09:46 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe process more robust
Date: Wed, 28 Aug 2024 14:09:41 +0800
Message-Id: <20240828060944.77829-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240828060944.77829-1-chengyou@linux.alibaba.com>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver may probe again while hardware is destroying the internal
resources allocated for previous probing, which will fail the
device probe. To make it more robust, we always issue a reset at the
beginning of the device probe process.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      |  1 +
 drivers/infiniband/hw/erdma/erdma_main.c | 44 +++++++++++++++++++-----
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index c8bd698e21b0..b5c258f77ca0 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -94,6 +94,7 @@ enum {
 
 #define ERDMA_CMDQ_TIMEOUT_MS 15000
 #define ERDMA_REG_ACCESS_WAIT_MS 20
+#define ERDMA_WAIT_DEV_REST_CNT 50
 #define ERDMA_WAIT_DEV_DONE_CNT 500
 
 struct erdma_cmdq {
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 7080f8a71ec4..9199058a0b29 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -209,11 +209,30 @@ static void erdma_device_uninit(struct erdma_dev *dev)
 	dma_pool_destroy(dev->resp_pool);
 }
 
-static void erdma_hw_reset(struct erdma_dev *dev)
+static int erdma_hw_reset(struct erdma_dev *dev, bool wait)
 {
 	u32 ctrl = FIELD_PREP(ERDMA_REG_DEV_CTRL_RESET_MASK, 1);
+	int i;
 
 	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG, ctrl);
+
+	if (!wait)
+		return 0;
+
+	for (i = 0; i < ERDMA_WAIT_DEV_REST_CNT; i++) {
+		if (erdma_reg_read32_filed(dev, ERDMA_REGS_DEV_ST_REG,
+					   ERDMA_REG_DEV_ST_RESET_DONE_MASK))
+			break;
+
+		msleep(ERDMA_REG_ACCESS_WAIT_MS);
+	}
+
+	if (i == ERDMA_WAIT_DEV_REST_CNT) {
+		dev_err(&dev->pdev->dev, "wait reset done timeout.\n");
+		return -ETIME;
+	}
+
+	return 0;
 }
 
 static int erdma_wait_hw_init_done(struct erdma_dev *dev)
@@ -239,6 +258,17 @@ static int erdma_wait_hw_init_done(struct erdma_dev *dev)
 	return 0;
 }
 
+static int erdma_preinit_check(struct erdma_dev *dev)
+{
+	u32 version = erdma_reg_read32(dev, ERDMA_REGS_VERSION_REG);
+
+	/* we knows that it is a non-functional function. */
+	if (version == 0)
+		return -ENODEV;
+
+	return erdma_hw_reset(dev, true);
+}
+
 static const struct pci_device_id erdma_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ALIBABA, 0x107f) },
 	{}
@@ -248,7 +278,6 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 {
 	struct erdma_dev *dev;
 	int bars, err;
-	u32 version;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -287,12 +316,9 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 		goto err_release_bars;
 	}
 
-	version = erdma_reg_read32(dev, ERDMA_REGS_VERSION_REG);
-	if (version == 0) {
-		/* we knows that it is a non-functional function. */
-		err = -ENODEV;
+	err = erdma_preinit_check(dev);
+	if (err)
 		goto err_iounmap_func_bar;
-	}
 
 	err = erdma_device_init(dev, pdev);
 	if (err)
@@ -327,7 +353,7 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 	return 0;
 
 err_reset_hw:
-	erdma_hw_reset(dev);
+	erdma_hw_reset(dev, false);
 
 err_uninit_cmdq:
 	erdma_cmdq_destroy(dev);
@@ -364,7 +390,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
 	struct erdma_dev *dev = pci_get_drvdata(pdev);
 
 	erdma_ceqs_uninit(dev);
-	erdma_hw_reset(dev);
+	erdma_hw_reset(dev, false);
 	erdma_cmdq_destroy(dev);
 	erdma_aeq_destroy(dev);
 	erdma_comm_irq_uninit(dev);
-- 
2.31.1


