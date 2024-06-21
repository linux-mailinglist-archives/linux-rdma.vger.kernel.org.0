Return-Path: <linux-rdma+bounces-3378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225499119F9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC7283077
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188012F37F;
	Fri, 21 Jun 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaYmDC/e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FB12C801;
	Fri, 21 Jun 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946343; cv=none; b=SIbIWgbYsmWnLDve8gm340VRENMlsA5Yg6tkWxc8qrekissiAjDL0Ak44FpiGxCrWLwc57DiQQsEDk7weA6IuYBaj30ZBOpsFef01ZrcUz9SfJqcitgQl3AEB0BLb6SDT/BjLzhGMF5pjyj25lAEVhQOefnJXHNLe/kSFP1sFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946343; c=relaxed/simple;
	bh=KdYeKBr4GE3XLiqNm9PoEa7iY9lF/A9jXufuvajDY0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rEuLjEgQItjFanjQVmL9e4tZnNXgma6IFFToxakEIAAt+R7neY8VCVDJyZX6GK7ACdNTnAGdO68AjMpuX0uvMaa9NQ23u/62iiPvvZmpgVguSwd6onrZJIj1Zgf6GXjdhv//uhGbNj4mSI/kYjpYrxDCEBk1EB1EOHilLVIdpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaYmDC/e; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8edde24b3so997068a34.2;
        Thu, 20 Jun 2024 22:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946341; x=1719551141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=kaYmDC/edzgwS45qGiUWWufQvLXFfRqWulhZ6/oSWoU6GSDJfkc78RERm2eGaWfrmt
         xMT3erASLggHgWclkGwegRiQ+tcQyEXPlWjA3me1YiZp80o7Oiz5nxFRInzRU6/AVAGa
         YFlLsZ5ZB+5pLY9hJ+KUdsZUNeE6Ep+Xp/+Z5GTi4Z3p4mSVnihSmlv9g38XBdf2YX/o
         FigtE/2SmADZdTBTqfalMvaf+4qAuFaMDX48h30/1I2j7Z3mv0h1etwGzhz9FQLDdxgL
         V8bmw4kP0teVwiJEiVSnfWGXPFdNAurqcQ4i/9GEpQdlOotc7uKRfGKSY3Z01dqX+1jd
         NUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946341; x=1719551141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=YK9T6ZIoxgT5g9NPf6ECZfuvsaigDkINpM7hY5hFMS2gY6qZxXXEPC2asU3zG9IR5j
         1rFSfKVfOtguE1gfVmIzM7e3SXYQkMDwbHezolFI8eB5SFYQN9B0ZYX74BVDAapiMjIa
         QunxX9dkswXc3RcU0jeYmpBKdsK5FA90Ct4QxIpI+stGt1WGeQn+Z20Vju1y69rU/NiL
         dECab9zZxmltt1z2ZuQWkb4VlNwl+6+2Vto5F0xoV+LgX8gHg9Fh3kEJXXLk2hxEZOSC
         DV6JtrMleTGLpyBuLQsfrLYvNm+bJtJ1jYVLIZDobq66gSbPTAMqbnD2awE8BdsLBF9J
         l8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw9hldr7/nFnHocUP79Kc7GCQPuBm2MQSmBr4Och8tNjtI7cp3uoZs1gEST6MYdZvUPdJbv5Kqo6w5uGt3E3Yb+pC1F4CuSBT5CqzEdQoEDPPBspfjnI59ylYwRBHuAkAHh4N4UbnmGahNeI3I0ezpPVjAJzObeDbMov1d19ZwKA==
X-Gm-Message-State: AOJu0Yya6aD82Y9TBQPRML+UAew2TZmU2fp2GlC5ULjBIjHfFXMTBwkK
	0HvmMB6IGAKvR7+feUpXIX0+YVRvonbZddiOflMHMskpOyUIpRDd
X-Google-Smtp-Source: AGHT+IFX0r3F5AwqpcuZVxyeJQNdGLegGwkn0/4iOt94ueHmQ8no9Tm2T36xWOozgSqBHiZ/ArVcuQ==
X-Received: by 2002:a05:6830:18e1:b0:6f9:9fad:159c with SMTP id 46e09a7af769-70075e594abmr6736549a34.33.1718946341230;
        Thu, 20 Jun 2024 22:05:41 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:40 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Jes Sorensen <jes@trained-monkey.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kda@linux-powerpc.org,
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
Subject: [PATCH 01/15] net: alteon: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:11 -0700
Message-Id: <20240621050525.3720069-2-allen.lkml@gmail.com>
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
APIs throughout the alteon driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/alteon/acenic.c | 26 +++++++++++++-------------
 drivers/net/ethernet/alteon/acenic.h |  8 ++++----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
index 3d8ac63132fb..9e6f91df2ba0 100644
--- a/drivers/net/ethernet/alteon/acenic.c
+++ b/drivers/net/ethernet/alteon/acenic.c
@@ -1560,9 +1560,9 @@ static void ace_watchdog(struct net_device *data, unsigned int txqueue)
 }
 
 
-static void ace_tasklet(struct tasklet_struct *t)
+static void ace_bh_work(struct work_struct *work)
 {
-	struct ace_private *ap = from_tasklet(ap, t, ace_tasklet);
+	struct ace_private *ap = from_work(ap, work, ace_bh_work);
 	struct net_device *dev = ap->ndev;
 	int cur_size;
 
@@ -1595,7 +1595,7 @@ static void ace_tasklet(struct tasklet_struct *t)
 #endif
 		ace_load_jumbo_rx_ring(dev, RX_JUMBO_SIZE - cur_size);
 	}
-	ap->tasklet_pending = 0;
+	ap->bh_work_pending = 0;
 }
 
 
@@ -1617,7 +1617,7 @@ static void ace_dump_trace(struct ace_private *ap)
  *
  * Loading rings is safe without holding the spin lock since this is
  * done only before the device is enabled, thus no interrupts are
- * generated and by the interrupt handler/tasklet handler.
+ * generated and by the interrupt handler/bh handler.
  */
 static void ace_load_std_rx_ring(struct net_device *dev, int nr_bufs)
 {
@@ -2160,7 +2160,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 	 */
 	if (netif_running(dev)) {
 		int cur_size;
-		int run_tasklet = 0;
+		int run_bh_work = 0;
 
 		cur_size = atomic_read(&ap->cur_rx_bufs);
 		if (cur_size < RX_LOW_STD_THRES) {
@@ -2172,7 +2172,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 				ace_load_std_rx_ring(dev,
 						     RX_RING_SIZE - cur_size);
 			} else
-				run_tasklet = 1;
+				run_bh_work = 1;
 		}
 
 		if (!ACE_IS_TIGON_I(ap)) {
@@ -2188,7 +2188,7 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 					ace_load_mini_rx_ring(dev,
 							      RX_MINI_SIZE - cur_size);
 				} else
-					run_tasklet = 1;
+					run_bh_work = 1;
 			}
 		}
 
@@ -2205,12 +2205,12 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
 					ace_load_jumbo_rx_ring(dev,
 							       RX_JUMBO_SIZE - cur_size);
 				} else
-					run_tasklet = 1;
+					run_bh_work = 1;
 			}
 		}
-		if (run_tasklet && !ap->tasklet_pending) {
-			ap->tasklet_pending = 1;
-			tasklet_schedule(&ap->ace_tasklet);
+		if (run_bh_work && !ap->bh_work_pending) {
+			ap->bh_work_pending = 1;
+			queue_work(system_bh_wq, &ap->ace_bh_work);
 		}
 	}
 
@@ -2267,7 +2267,7 @@ static int ace_open(struct net_device *dev)
 	/*
 	 * Setup the bottom half rx ring refill handler
 	 */
-	tasklet_setup(&ap->ace_tasklet, ace_tasklet);
+	INIT_WORK(&ap->ace_bh_work, ace_bh_work);
 	return 0;
 }
 
@@ -2301,7 +2301,7 @@ static int ace_close(struct net_device *dev)
 	cmd.idx = 0;
 	ace_issue_cmd(regs, &cmd);
 
-	tasklet_kill(&ap->ace_tasklet);
+	cancel_work_sync(&ap->ace_bh_work);
 
 	/*
 	 * Make sure one CPU is not processing packets while
diff --git a/drivers/net/ethernet/alteon/acenic.h b/drivers/net/ethernet/alteon/acenic.h
index ca5ce0cbbad1..0e45a97b9c9b 100644
--- a/drivers/net/ethernet/alteon/acenic.h
+++ b/drivers/net/ethernet/alteon/acenic.h
@@ -2,7 +2,7 @@
 #ifndef _ACENIC_H_
 #define _ACENIC_H_
 #include <linux/interrupt.h>
-
+#include <linux/workqueue.h>
 
 /*
  * Generate TX index update each time, when TX ring is closed.
@@ -667,8 +667,8 @@ struct ace_private
 	struct rx_desc		*rx_mini_ring;
 	struct rx_desc		*rx_return_ring;
 
-	int			tasklet_pending, jumbo;
-	struct tasklet_struct	ace_tasklet;
+	int			bh_work_pending, jumbo;
+	struct work_struct	ace_bh_work;
 
 	struct event		*evt_ring;
 
@@ -776,7 +776,7 @@ static int ace_open(struct net_device *dev);
 static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev);
 static int ace_close(struct net_device *dev);
-static void ace_tasklet(struct tasklet_struct *t);
+static void ace_bh_work(struct work_struct *work);
 static void ace_dump_trace(struct ace_private *ap);
 static void ace_set_multicast_list(struct net_device *dev);
 static int ace_change_mtu(struct net_device *dev, int new_mtu);
-- 
2.34.1


