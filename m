Return-Path: <linux-rdma+bounces-4109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5A941FA1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D5DB25E89
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0218E02C;
	Tue, 30 Jul 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU2pjY7X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDC18C935;
	Tue, 30 Jul 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364457; cv=none; b=eKOGpnUeu3JDbNZ4pMPrfXB0rhiNH9sbA0847w7I1ejW4341s4BWSsPEPTLNBowHjqhJaduBW/vETSElF3l4oj4MAAaATV+HU1iFxooBRVWqZGHFdOpP/qHaynDv76V9Get2liQw/n/Xd6MrzZNj3xMst7qyRiBSTCGZiVpxWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364457; c=relaxed/simple;
	bh=6SvRW/yxoNpZwoYZMTVDeEIcDTd9jfiBS9x45YxGCMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/GmXedvPMkvDk57ZKglGBYU3ehzr0kM4AFz1nhWWCmCXlkvuqO9Vx+GpZSti+zwGanSUnIkP8jv7hzZEBwymvlxJMuiKkl1jwNTFcWIfktQDvdLqDEeGMQkEPtbqETsCpuRKhJktzoqQF5CYAQpNs/RrT8uwItoNy06wSpikfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU2pjY7X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso4128309b3a.3;
        Tue, 30 Jul 2024 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364455; x=1722969255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB0wI3bTOL8Z7NkoFf7Yv1HR9LADL20dFoU50ttk+I0=;
        b=fU2pjY7XSPy6j6as4NMzb+NwTo+PO9CcfcSGmAPkb+g0dY6BWux65/a0vkogv3WdLv
         10gwHgNsqJJAPoV9xNk0oFbXhj1W8CY9wMnOwYbW7H3v9ykSfor4Q+pXyev7QMTdfRZ8
         KANQit+n3PiDtG6ARv1ygDSc+//J6IPI93NHyBqK0gMMA4t2e6acW5b0qmzMdSRDIWva
         xeds6j6DwwIxIwhQQktg4+0EbBfuJG9/FObSl+O6wC7BLHLT3HwombMxpfNeAYrFOCcO
         WAXx79PAgpTiwgOwQ88EmamS24gY3FLK/I/QyymOM4dcSMXvh8TUSmbeZC0WMBGSEe14
         afpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364455; x=1722969255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB0wI3bTOL8Z7NkoFf7Yv1HR9LADL20dFoU50ttk+I0=;
        b=isBUe4DtePfW9vcv9dM3yTGOXQuzWeHuET0iCzfY/CU23GX/MfhVvqNbuJ7BTy8VUr
         La1mfJzxgwqTr45hkua/oQclAukaHgY6Tjco8wK5k0A/Sxff9jltNrBceZO5KhWYGmpb
         B40RMh5KfpfkaGi1gCFTvx2PtpOvMiB9m78q4UKWBeEi8q1Yxs0cdF3z4VozXVP49Da5
         hikivL74YdvbjlETpyFfvMghJOgqLJOFHWUTCJ6S4+6Qwu3tVAm8GvHlTsq0n0chwL+p
         J9v6P+YkAXRHjMlLEnDfefLsTY7EBxxQJVngYKs6VmIiFWvhqYoz+C3eMS1oOi4dsbDJ
         B1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhsXKe0RHn2niCRuMREWVSglptR9POjiprcO47CHIhrjvdkT69PxMbct6LqOHvYhFoU5pIPMhLCufJC3OImcmXwU3bNQDzLTFC0HlDxW8T67+NU3u0GZ2BwouCiXa3IlmOIdmrAc7oJDLajjbdt7SG31qgQpZmyMmLfS5ajqP0bw==
X-Gm-Message-State: AOJu0YwBbmgMq88h9P90/eq3nm8T8IB4SCIqD37rDDb0A3xIJXPENH4C
	N1Ke3/T2vXDVZ+UE8yIUzDn4e44xeZXg3R+Fr0JQWj1nC4b1xw/T
X-Google-Smtp-Source: AGHT+IHTgMmTpBe/FA3+CQ0G4ogSBdkYOovxMN42cMmaL9uq6bOzPos7Ze8hZ827PyeluPhC/BEzXw==
X-Received: by 2002:a05:6a21:3489:b0:1c4:919f:3677 with SMTP id adf61e73a8af0-1c4a14c6f3amr14768208637.42.1722364454639;
        Tue, 30 Jul 2024 11:34:14 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:13 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 02/15] net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:50 -0700
Message-Id: <20240730183403.4176544-3-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730183403.4176544-1-allen.lkml@gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the xgbe driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 30 +++++++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c  | 16 ++++++------
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 16 ++++++------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c  |  4 +--
 drivers/net/ethernet/amd/xgbe/xgbe.h      | 10 ++++----
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index c4a4e316683f..5475867708f4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -403,9 +403,9 @@ static bool xgbe_ecc_ded(struct xgbe_prv_data *pdata, unsigned long *period,
 	return false;
 }
 
-static void xgbe_ecc_isr_task(struct tasklet_struct *t)
+static void xgbe_ecc_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_ecc);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, ecc_bh_work);
 	unsigned int ecc_isr;
 	bool stop = false;
 
@@ -465,17 +465,17 @@ static irqreturn_t xgbe_ecc_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_ecc);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->ecc_bh_work);
 	else
-		xgbe_ecc_isr_task(&pdata->tasklet_ecc);
+		xgbe_ecc_isr_bh_work(&pdata->ecc_bh_work);
 
 	return IRQ_HANDLED;
 }
 
-static void xgbe_isr_task(struct tasklet_struct *t)
+static void xgbe_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_dev);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, dev_bh_work);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	struct xgbe_channel *channel;
 	unsigned int dma_isr, dma_ch_isr;
@@ -582,7 +582,7 @@ static void xgbe_isr_task(struct tasklet_struct *t)
 
 	/* If there is not a separate ECC irq, handle it here */
 	if (pdata->vdata->ecc_support && (pdata->dev_irq == pdata->ecc_irq))
-		xgbe_ecc_isr_task(&pdata->tasklet_ecc);
+		xgbe_ecc_isr_bh_work(&pdata->ecc_bh_work);
 
 	/* If there is not a separate I2C irq, handle it here */
 	if (pdata->vdata->i2c_support && (pdata->dev_irq == pdata->i2c_irq))
@@ -604,10 +604,10 @@ static irqreturn_t xgbe_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_dev);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->dev_bh_work);
 	else
-		xgbe_isr_task(&pdata->tasklet_dev);
+		xgbe_isr_bh_work(&pdata->dev_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -1007,8 +1007,8 @@ static int xgbe_request_irqs(struct xgbe_prv_data *pdata)
 	unsigned int i;
 	int ret;
 
-	tasklet_setup(&pdata->tasklet_dev, xgbe_isr_task);
-	tasklet_setup(&pdata->tasklet_ecc, xgbe_ecc_isr_task);
+	INIT_WORK(&pdata->dev_bh_work, xgbe_isr_bh_work);
+	INIT_WORK(&pdata->ecc_bh_work, xgbe_ecc_isr_bh_work);
 
 	ret = devm_request_irq(pdata->dev, pdata->dev_irq, xgbe_isr, 0,
 			       netdev_name(netdev), pdata);
@@ -1078,8 +1078,8 @@ static void xgbe_free_irqs(struct xgbe_prv_data *pdata)
 
 	devm_free_irq(pdata->dev, pdata->dev_irq, pdata);
 
-	tasklet_kill(&pdata->tasklet_dev);
-	tasklet_kill(&pdata->tasklet_ecc);
+	cancel_work_sync(&pdata->dev_bh_work);
+	cancel_work_sync(&pdata->ecc_bh_work);
 
 	if (pdata->vdata->ecc_support && (pdata->dev_irq != pdata->ecc_irq))
 		devm_free_irq(pdata->dev, pdata->ecc_irq, pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
index a9ccc4258ee5..7a833894f52a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
@@ -274,9 +274,9 @@ static void xgbe_i2c_clear_isr_interrupts(struct xgbe_prv_data *pdata,
 		XI2C_IOREAD(pdata, IC_CLR_STOP_DET);
 }
 
-static void xgbe_i2c_isr_task(struct tasklet_struct *t)
+static void xgbe_i2c_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_i2c);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, i2c_bh_work);
 	struct xgbe_i2c_op_state *state = &pdata->i2c.op_state;
 	unsigned int isr;
 
@@ -321,10 +321,10 @@ static irqreturn_t xgbe_i2c_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = (struct xgbe_prv_data *)data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_i2c);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->i2c_bh_work);
 	else
-		xgbe_i2c_isr_task(&pdata->tasklet_i2c);
+		xgbe_i2c_isr_bh_work(&pdata->i2c_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -369,7 +369,7 @@ static void xgbe_i2c_set_target(struct xgbe_prv_data *pdata, unsigned int addr)
 
 static irqreturn_t xgbe_i2c_combined_isr(struct xgbe_prv_data *pdata)
 {
-	xgbe_i2c_isr_task(&pdata->tasklet_i2c);
+	xgbe_i2c_isr_bh_work(&pdata->i2c_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -449,7 +449,7 @@ static void xgbe_i2c_stop(struct xgbe_prv_data *pdata)
 
 	if (pdata->dev_irq != pdata->i2c_irq) {
 		devm_free_irq(pdata->dev, pdata->i2c_irq, pdata);
-		tasklet_kill(&pdata->tasklet_i2c);
+		cancel_work_sync(&pdata->i2c_bh_work);
 	}
 }
 
@@ -464,7 +464,7 @@ static int xgbe_i2c_start(struct xgbe_prv_data *pdata)
 
 	/* If we have a separate I2C irq, enable it */
 	if (pdata->dev_irq != pdata->i2c_irq) {
-		tasklet_setup(&pdata->tasklet_i2c, xgbe_i2c_isr_task);
+		INIT_WORK(&pdata->i2c_bh_work, xgbe_i2c_isr_bh_work);
 
 		ret = devm_request_irq(pdata->dev, pdata->i2c_irq,
 				       xgbe_i2c_isr, 0, pdata->i2c_name,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 4a2dc705b528..07f4f3418d01 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -703,9 +703,9 @@ static void xgbe_an73_isr(struct xgbe_prv_data *pdata)
 	}
 }
 
-static void xgbe_an_isr_task(struct tasklet_struct *t)
+static void xgbe_an_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_an);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, an_bh_work);
 
 	netif_dbg(pdata, intr, pdata->netdev, "AN interrupt received\n");
 
@@ -727,17 +727,17 @@ static irqreturn_t xgbe_an_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = (struct xgbe_prv_data *)data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_an);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->an_bh_work);
 	else
-		xgbe_an_isr_task(&pdata->tasklet_an);
+		xgbe_an_isr_bh_work(&pdata->an_bh_work);
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t xgbe_an_combined_isr(struct xgbe_prv_data *pdata)
 {
-	xgbe_an_isr_task(&pdata->tasklet_an);
+	xgbe_an_isr_bh_work(&pdata->an_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -1454,7 +1454,7 @@ static void xgbe_phy_stop(struct xgbe_prv_data *pdata)
 
 	if (pdata->dev_irq != pdata->an_irq) {
 		devm_free_irq(pdata->dev, pdata->an_irq, pdata);
-		tasklet_kill(&pdata->tasklet_an);
+		cancel_work_sync(&pdata->an_bh_work);
 	}
 
 	pdata->phy_if.phy_impl.stop(pdata);
@@ -1477,7 +1477,7 @@ static int xgbe_phy_start(struct xgbe_prv_data *pdata)
 
 	/* If we have a separate AN irq, enable it */
 	if (pdata->dev_irq != pdata->an_irq) {
-		tasklet_setup(&pdata->tasklet_an, xgbe_an_isr_task);
+		INIT_WORK(&pdata->an_bh_work, xgbe_an_isr_bh_work);
 
 		ret = devm_request_irq(pdata->dev, pdata->an_irq,
 				       xgbe_an_isr, 0, pdata->an_name,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index c5e5fac49779..c636999a6a84 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -139,7 +139,7 @@ static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 
-	pdata->isr_as_tasklet = 1;
+	pdata->isr_as_bh_work = 1;
 	pdata->irq_count = ret;
 
 	pdata->dev_irq = pci_irq_vector(pdata->pcidev, 0);
@@ -176,7 +176,7 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 
-	pdata->isr_as_tasklet = pdata->pcidev->msi_enabled ? 1 : 0;
+	pdata->isr_as_bh_work = pdata->pcidev->msi_enabled ? 1 : 0;
 	pdata->irq_count = 1;
 	pdata->channel_irq_count = 1;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index f01a1e566da6..d85386cac8d1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1298,11 +1298,11 @@ struct xgbe_prv_data {
 
 	unsigned int lpm_ctrl;		/* CTRL1 for resume */
 
-	unsigned int isr_as_tasklet;
-	struct tasklet_struct tasklet_dev;
-	struct tasklet_struct tasklet_ecc;
-	struct tasklet_struct tasklet_i2c;
-	struct tasklet_struct tasklet_an;
+	unsigned int isr_as_bh_work;
+	struct work_struct dev_bh_work;
+	struct work_struct ecc_bh_work;
+	struct work_struct i2c_bh_work;
+	struct work_struct an_bh_work;
 
 	struct dentry *xgbe_debugfs;
 
-- 
2.34.1


