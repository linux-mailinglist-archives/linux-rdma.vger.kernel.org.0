Return-Path: <linux-rdma+bounces-4116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B987F941FB8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CB61C23270
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA50D18CBE6;
	Tue, 30 Jul 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T67YaH+T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8518CBEB;
	Tue, 30 Jul 2024 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364475; cv=none; b=XY+fFMpvvgTApMQCKAcZM5QoFeGMtZMpPC+HYPHRn6u6SpNMykBK3EyCJSk14MmfNj0fM9PDwLdGRDjgojS074gEDmxcIsAs/16Y3wFTEAsYsaLdqJz5W+zPQ4XeffT9aFr1mcDfurnLwrBwtYGTMfjQr+u42GmGUnmvcE4WW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364475; c=relaxed/simple;
	bh=5wCl1B1i8ji1xA4dADPfV0mjXWvLWyC2722XSPdktnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eO9/iIkukjslgJhp2fw/euXJ1AholqD56ed5/qXgqkELgkpjwbgMwzfKDI5aq9PdIfwcJ0XmJKBPfvSBA7ofhVTM9ZE9pzQmagM/hNqKByraNEV9pNn0KiYspkK9Wj+f4swNa0jqoqy51YXKaDlUwRcPqh5pHsVZDE+rwPvOdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T67YaH+T; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db23a60850so2535217b6e.0;
        Tue, 30 Jul 2024 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364473; x=1722969273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=T67YaH+Tzm2m8mUDLYz7s9eKgA1dACCZq59HbOB9kkLpzDnK8dX3/etC8+z2ggco2Z
         GPUBXpzbxQci+YqLQJezkUdF/61MSi4rOf2a12wVfDN0/S0SrtoLjjMdWkAq+ZyayEPL
         BkKYebhxE8VKJjP6vPfDSGT+SrDjRqNijGeg0KJbYiGGuEni15NSeUVOO3BxHVt/FE6t
         TB14i5roL7FaQ0jG+sqDcKvCXyGRb4LOwkwGkfUrF5ZHI9BNVbuyM/O3XIxYoSdLT+Y8
         bTomxGm/I0gpHgIUqXpJEwb/8UtkGCKiOlsj41TkBUYnloNTawRDNNIsf3ZD0sIXAUf8
         VLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364473; x=1722969273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dhdHUZpgwd2/wkpVLwdxeMY04zoPfYMfPcgph0II3s=;
        b=auDRxTMFaCx7yl3qsnAPti7Pz5bzodDqVeAQM/gLwDncnlm8vxat56RN3JB/fn/oZX
         PT1wjFyE/plBqcaXwcd+Gk87LB+OPNifPYbz/C2gH6rsjhZrW1rHBG7pa2rcK31ekZ/U
         PEGDGiHB25AyihBY2i6m+ohdNn0VO1fd+4v2Hnj6oJpSdOLfwrEK2XHHuxIoZLET3eV1
         aqrdV+R1O1RgHhLg2SwRVZoxgsKHVBNEeQmVO/a7fr9iK7b6/abhPXUC9+rk+nAc+Jn5
         4UZF0TSkEi0jEfWR5PdoNaeIpc944I4fXsUTDjkHxlpE7dqIRXJCtPuNCjiDRM1upTef
         SuSg==
X-Forwarded-Encrypted: i=1; AJvYcCVm3KHYZqBunqfXPaAy9okTf/YPxO0VsL72pN+34QReSCBd3ljQMjDKeogo77YfUwoomsTNjPFNpzQ00w==@vger.kernel.org, AJvYcCW4rL5m631QZJxKGdKBnxwpH4FG/1Vl4CpDU9UsNFmb/VnsvNmqFKalaStD477r/Btnx0LrFk+F9zNk6S0=@vger.kernel.org, AJvYcCX9Qxov2T/DdO+aEZmDNKRdUEGdd4MX11KtWyIDrTCfz4bKx2VGNUC+0RjfxEe4hOa0L+G2/zDx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TeLYCUbj+oCX8lgzG5Oy2sBQrBAsqJYkT57j77w+uGoh9TaU
	vatnqHA+WhXhyNPSQa+JR2P6tx4301hRsylGgrUSitQccP9ISORQ
X-Google-Smtp-Source: AGHT+IHN/mrTA3BMYiZNVarf9NMI3uOSdPrgVQeed6qhHnuiCVI/TIgkXkD2IX40hlbUAtEwpoQeoQ==
X-Received: by 2002:a05:6808:f04:b0:3d2:1a92:8f4a with SMTP id 5614622812f47-3db23ac0933mr16165026b6e.23.1722364472735;
        Tue, 30 Jul 2024 11:34:32 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:31 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 09/15] net: sundance: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:57 -0700
Message-Id: <20240730183403.4176544-10-allen.lkml@gmail.com>
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


