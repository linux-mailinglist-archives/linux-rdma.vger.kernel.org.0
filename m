Return-Path: <linux-rdma+bounces-4108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE25941F9E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38D22857D9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0218C913;
	Tue, 30 Jul 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqp6/eRp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592418B49D;
	Tue, 30 Jul 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364454; cv=none; b=YQ14P6e5qGl/W0zt+y3Bj+sEJkNIOEXtd0trA+1t6J0Dn+S+0JrRcbkP8T79hJmIHUOFQuBNyBFBDMq9fTj8dMCKmTc2Rw80YPILrjz+r+/Pv9MsWlx3GQZDeIcJ1KdfMQYeY4TzrbkINn9/gVIqIAyzeBiS1SGixwR2u5+63wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364454; c=relaxed/simple;
	bh=KdYeKBr4GE3XLiqNm9PoEa7iY9lF/A9jXufuvajDY0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmEhwlqnnS8YqxSeRLcrfIT9xKOVHnlzf+/EdrucjvEU8CFsA04s5UwEM6EXyRSVm7jgyUpURENF3J2umYk0rwYxM3E8gW60Q0UcIzsIy+La+rvs6qkMweCYHS66Ne1xp6OXYIvzIqyisKf8PwcXT03dJM9XFjo7csi5clxNuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqp6/eRp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso3859066b3a.0;
        Tue, 30 Jul 2024 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364452; x=1722969252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=Tqp6/eRpq0fKmi3TsgT6Pf4LcD+yAF1h+CWIxagscwLPbrIAU4HsJJuEFAvzL6o8L/
         gHP/AvVvP1Q3zOk+MA9NvO5nXUHMgkQy55fgnD3L+krwdec5/8X6HpNirnNwGg+oNM4k
         sWf7onQSyFS0Wyc+zN9gXl5QDv/mPAlPVE93PUeBNp9Aik0Le8BGJOst9tctxUrh1LQu
         iNC8wWuC5R1vm+3UCus1wkjofGrQqkPvvgc58pEreyyAjxWpODHMikjCbd/JGUr2Sl0r
         4fFulNOgD1pO2JVGcTNsDNH6a2PjNibvaWCYPKiIrMjPlRDL4PDioBP4yyx6YQwJZbLQ
         ZcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364452; x=1722969252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P3Gdc0qfrmDJeJXUl6nP3lBuuq2/4cAEsXf9G6JMHY=;
        b=kih49Eu2SZmzSEIOFSl4IvSIJWdfngcqXWhrpzYrz6OM0GzBu+QGiT/6noxRVKXlPm
         Rh95K0LnTai7VPiXqVOw/Hq6UDSCUUe8Uyc9wHlRFaiHtQjeJedzb49r51fbUREDM6BD
         7U2QNr2FGQdS6UhHKqMHzFyz+DLi2tA45qksoZg/6S0aAgyoiIYkKudqmCqqyUZ1DcDR
         6YmoNoCwqx3IOJFXFV/s6wReXqs88w3r/AbKFEpCVtsEcBZ3879CKk7BiRd+cBRNfnil
         AsxC16xxeRl1/V22YCkLr458EUP5Afdt2j2rDxOjHxEtn0W0wXbBeBr6TRMAq42XG2/g
         1sjw==
X-Forwarded-Encrypted: i=1; AJvYcCXhrrgF3ruafdQAiWve6CFrogjf85VfODzcurtNot7yM1uptHp6gUhDa61981U2HvYLEIMu+rkfpA28B4gZsNJzs7IlZ00JuvOnHorfNNVTAeUVLKVNbfuSqhu/wVIEXlt2jvN+qSfeXuZfgTuHZCrdYlMWMzIFcqcctXGKlPQMQQ==
X-Gm-Message-State: AOJu0YyqAhjoktG3YWFLJQHOdSe58y9EKWB45WZbmSNmQOBGFB0g8ZPx
	xwNdMBiqLHBvXMTh1bUuImtWahD7ggss9l4R60xdJyaUL6/lc+KJ
X-Google-Smtp-Source: AGHT+IGo8nVaQ+JgIKKf9pLlHqxKPIyD1F+zgCj5uA3r2WC6bOpU1PXlUDgQGzbzKafa7+vywptJKA==
X-Received: by 2002:a05:6a20:6a05:b0:1c4:81a0:3783 with SMTP id adf61e73a8af0-1c4a129a0e9mr11841606637.11.1722364451820;
        Tue, 30 Jul 2024 11:34:11 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:11 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 01/15] net: alteon: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:49 -0700
Message-Id: <20240730183403.4176544-2-allen.lkml@gmail.com>
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


