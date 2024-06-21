Return-Path: <linux-rdma+bounces-3386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB05911A11
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA34287516
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827D16D31E;
	Fri, 21 Jun 2024 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BilxYJbF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E212F37F;
	Fri, 21 Jun 2024 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946359; cv=none; b=ZVxwmCXQedBfr8vM69We1gCqGXghs1joG9uPxpbV2+CRjTm3FhGH+6vKJ3X6BeaSMoGzxpSlWfyeddJhAEX0hsV7+u7bPQUN9xc6zzxafgATDyWrHigvadKrJtuAhXiVbC+sYG5nfr1yI/2yn3km1u+HMQJqHgcwkfYZx5I9Hsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946359; c=relaxed/simple;
	bh=5wCl1B1i8ji1xA4dADPfV0mjXWvLWyC2722XSPdktnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UP+95DzvJEWcCtM6AuEfXJQ/eBXMTMoTiym61HxYzjbK6korYPtaH8HutnQkyxwQKDv29aJsHH43UO0Pq3LLtsZE5y0wCJNX31gX3XKhaxPHllisIcw6KXu9qo5Tlohd3xQCSh7t2+pWbcMa9feUhCzaDPtCxrQLhj8ikOVfR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BilxYJbF; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c19d338401so810856eaf.0;
        Thu, 20 Jun 2024 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946357; x=1719551157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=BilxYJbF5AQglQIk0tqaiyb4LVUbM/BqGAR4htJwugCfIJrJyfBM0yeRPXyi7THQRJ
         8TVm3DYgoJV1DHIj73RKtHKsqOOGOYpuJOekwyPrPdq3RhmvCfEby9qFNYD5vQLezlfF
         xrIQZJ/3snT77OvqvcuiQRRo+goKbbDOu4LUlYUDuDZxv5FD8Kf29t9KpO7oX5cTp3kM
         T9GmP1LSQjr2wYSro24JA0Qds2zaD5ei+mQaJFddItfTpEsPCeHENaKseoGmyif+nzBz
         tw8VRs4LXL88UvpbJ3oYbq5dzp6U4ds6kGQeFMS4E14u8A4SoF8cIuIvL3FDjxuMvMEt
         gZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946357; x=1719551157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=ZV1+SxGfy8DEe8V47goOCWH2lGVSf7qkSdFdE1pml0ZScSjscheI5mW+wSFSrup0pP
         iacw2qEfJTXe5cml06v37UgJfyHzvVBtWDIObPorew7/frsXXB7OQO3T/WDV1LIpm7Pv
         dvtcWhR1W6se3yHNWsffp/TlS4iwMwlyIGOTEQMPjOL+/3Ewle9KQSMyJg/9wM0MT0kU
         rsG6G5Hpot3z8leiulxJ2OdT14PJFSqSN8LDjcAMilW+uCmTSrlD0sDJfncnH+kcFJ8z
         WvgObr63bCqKtxMyQtem14+zSQVlCSvPliHC3r6dDbfAXxYhJXI8lhVdJ9zRJPK9FEm0
         yo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKfHj4k02lgLCdCql3c8gtQZcXHcFNJBvMBFj6+HyAucUd1OmE47bRV+pshX3tBMwcCodmY60wrvKR3rjbp15YB0I0t3Q1cFzwlqn1YsLt5v0dRBNcf1vONWPkQ4QjZ6+8AR7DaoM4agNuQs644/XJglLdz3NKPvQY6Mg2TOox1w==
X-Gm-Message-State: AOJu0YwRIp31vA/75iL5H+egC+Z9MVTM3mIK19sINSicQzR0MDj/kdNz
	8Oz8F3TgodXeazg16SYDm8yVbfcDlBL1XyEhNDMAyik9KuIxU5G5
X-Google-Smtp-Source: AGHT+IHhA35uL6dKwMEPYqyMrHx0+sbso3nzM6DX+derz+sMKjvn9qW/U4VOg8Eu5V2sPuLfkd8gmQ==
X-Received: by 2002:a05:6358:5328:b0:19e:e349:1cfd with SMTP id e5c5f4694b2df-1a1fd5cf280mr812647955d.26.1718946356722;
        Thu, 20 Jun 2024 22:05:56 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:56 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Denis Kirjanov <kda@linux-powerpc.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jes@trained-monkey.org,
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
	Allen Pais <allen.lkml@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 09/15] net: sundance: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:19 -0700
Message-Id: <20240621050525.3720069-10-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the dlink sundance driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/dlink/sundance.c | 41 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index 8af5ecec7d61..65dfd32a9656 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -86,6 +86,7 @@ static char *media[MAX_UNITS];
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
@@ -395,8 +396,8 @@ struct netdev_private {
 	unsigned int an_enable:1;
 	unsigned int speed;
 	unsigned int wol_enabled:1;			/* Wake on LAN enabled */
-	struct tasklet_struct rx_tasklet;
-	struct tasklet_struct tx_tasklet;
+	struct work_struct rx_bh_work;
+	struct work_struct tx_bh_work;
 	int budget;
 	int cur_task;
 	/* Multicast and receive mode. */
@@ -430,8 +431,8 @@ static void init_ring(struct net_device *dev);
 static netdev_tx_t start_tx(struct sk_buff *skb, struct net_device *dev);
 static int reset_tx (struct net_device *dev);
 static irqreturn_t intr_handler(int irq, void *dev_instance);
-static void rx_poll(struct tasklet_struct *t);
-static void tx_poll(struct tasklet_struct *t);
+static void rx_poll(struct work_struct *work);
+static void tx_poll(struct work_struct *work);
 static void refill_rx (struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void netdev_error(struct net_device *dev, int intr_status);
@@ -541,8 +542,8 @@ static int sundance_probe1(struct pci_dev *pdev,
 	np->msg_enable = (1 << debug) - 1;
 	spin_lock_init(&np->lock);
 	spin_lock_init(&np->statlock);
-	tasklet_setup(&np->rx_tasklet, rx_poll);
-	tasklet_setup(&np->tx_tasklet, tx_poll);
+	INIT_WORK(&np->rx_bh_work, rx_poll);
+	INIT_WORK(&np->tx_bh_work, tx_poll);
 
 	ring_space = dma_alloc_coherent(&pdev->dev, TX_TOTAL_SIZE,
 			&ring_dma, GFP_KERNEL);
@@ -965,7 +966,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 	unsigned long flag;
 
 	netif_stop_queue(dev);
-	tasklet_disable_in_atomic(&np->tx_tasklet);
+	disable_work_sync(&np->tx_bh_work);
 	iowrite16(0, ioaddr + IntrEnable);
 	printk(KERN_WARNING "%s: Transmit timed out, TxStatus %2.2x "
 		   "TxFrameId %2.2x,"
@@ -1006,7 +1007,7 @@ static void tx_timeout(struct net_device *dev, unsigned int txqueue)
 		netif_wake_queue(dev);
 	}
 	iowrite16(DEFAULT_INTR, ioaddr + IntrEnable);
-	tasklet_enable(&np->tx_tasklet);
+	enable_and_queue_work(system_bh_wq, &np->tx_bh_work);
 }
 
 
@@ -1058,9 +1059,9 @@ static void init_ring(struct net_device *dev)
 	}
 }
 
-static void tx_poll(struct tasklet_struct *t)
+static void tx_poll(struct work_struct *work)
 {
-	struct netdev_private *np = from_tasklet(np, t, tx_tasklet);
+	struct netdev_private *np = from_work(np, work, tx_bh_work);
 	unsigned head = np->cur_task % TX_RING_SIZE;
 	struct netdev_desc *txdesc =
 		&np->tx_ring[(np->cur_tx - 1) % TX_RING_SIZE];
@@ -1104,11 +1105,11 @@ start_tx (struct sk_buff *skb, struct net_device *dev)
 			goto drop_frame;
 	txdesc->frag.length = cpu_to_le32 (skb->len | LastFrag);
 
-	/* Increment cur_tx before tasklet_schedule() */
+	/* Increment cur_tx before bh_work is queued */
 	np->cur_tx++;
 	mb();
-	/* Schedule a tx_poll() task */
-	tasklet_schedule(&np->tx_tasklet);
+	/* Queue a tx_poll() bh work */
+	queue_work(system_bh_wq, &np->tx_bh_work);
 
 	/* On some architectures: explicitly flush cache lines here. */
 	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1 &&
@@ -1199,7 +1200,7 @@ static irqreturn_t intr_handler(int irq, void *dev_instance)
 					ioaddr + IntrEnable);
 			if (np->budget < 0)
 				np->budget = RX_BUDGET;
-			tasklet_schedule(&np->rx_tasklet);
+			queue_work(system_bh_wq, &np->rx_bh_work);
 		}
 		if (intr_status & (IntrTxDone | IntrDrvRqst)) {
 			tx_status = ioread16 (ioaddr + TxStatus);
@@ -1315,9 +1316,9 @@ static irqreturn_t intr_handler(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
-static void rx_poll(struct tasklet_struct *t)
+static void rx_poll(struct work_struct *work)
 {
-	struct netdev_private *np = from_tasklet(np, t, rx_tasklet);
+	struct netdev_private *np = from_work(np, work, rx_bh_work);
 	struct net_device *dev = np->ndev;
 	int entry = np->cur_rx % RX_RING_SIZE;
 	int boguscnt = np->budget;
@@ -1407,7 +1408,7 @@ static void rx_poll(struct tasklet_struct *t)
 	np->budget -= received;
 	if (np->budget <= 0)
 		np->budget = RX_BUDGET;
-	tasklet_schedule(&np->rx_tasklet);
+	queue_work(system_bh_wq, &np->rx_bh_work);
 }
 
 static void refill_rx (struct net_device *dev)
@@ -1819,9 +1820,9 @@ static int netdev_close(struct net_device *dev)
 	struct sk_buff *skb;
 	int i;
 
-	/* Wait and kill tasklet */
-	tasklet_kill(&np->rx_tasklet);
-	tasklet_kill(&np->tx_tasklet);
+	/* Wait and cancel bh work */
+	cancel_work_sync(&np->rx_bh_work);
+	cancel_work_sync(&np->tx_bh_work);
 	np->cur_tx = 0;
 	np->dirty_tx = 0;
 	np->cur_task = 0;
-- 
2.34.1


