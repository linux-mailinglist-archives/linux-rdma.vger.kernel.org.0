Return-Path: <linux-rdma+bounces-4111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4952E941FA8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F46285E15
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235131917D4;
	Tue, 30 Jul 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynlip6uZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739418E054;
	Tue, 30 Jul 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364461; cv=none; b=UzfElHTq0Eeq0ZIbaCboiNUga6e6m00/P4SRfk4t9QD4WDICqfiu5YpBcv9o+q/ESCg52zki3GU+OL/3cy9ZPMufHL6eTqOaO4uv6F9wdCJi7r7lEqT/MaGSV6xVxcRiVxkjLtzkLyVz25thKSd4KHHZNjXiXC8kUNDQALZaqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364461; c=relaxed/simple;
	bh=zNXUonBkY332KTz7o5NpA8UezyxolbGi/xfiOMJm/xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0WQY1xcmGeDICgjqgZm/p+g/eTSYNxVLqqMPGFYfJ4bpq9hj9xftbpiN3wEdhgzci4KTnf3Burr8+g89/zGuaWZ3fPPbUr/HfaucAnl/PHH+lvdaEt8Q363JpLy75G587I1p+HiHaDcM3ufgw3oZnctVxUw9f5cX+p8lerdFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynlip6uZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc66fc35f2so1232795ad.0;
        Tue, 30 Jul 2024 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364460; x=1722969260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tAJul54dXwAicX38emqI3ljWngiGXZJVJ9lmbTIws0=;
        b=Ynlip6uZMwB71bcEuIPDjXWDwrBpI7ogJ5kPBOnaR351gRyQmZ/Xxh0pirc5O3avDO
         JD8R14TpHhwjhWj7+Lu/owvcESOH0N2fgMrvn3WTCY833st1Bgg/3scl3DY9CebkDtDE
         ei/6gvLFCl2ZoAsHr1m9jEMDNW4URfEFTlPia1u8p91YNH4n7UHQlNbfb+9oiOrbD+ZO
         EGGSckSJNHa26qbEeEXpxf/TI1BdN61p/ZAURV/4hSrtbgzwHGWtKm/UJ+AGCJrwcihS
         vYafDkj3sTwYmJQ1DhKMJk3n0ZWZ/JeAJzIZBm1w1ZoO6n3hCdIRAs8ZIYm3JwT0crlt
         Ng5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364460; x=1722969260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tAJul54dXwAicX38emqI3ljWngiGXZJVJ9lmbTIws0=;
        b=xFlKRdv3s64Eknhn1KWnKZO8UjzVmS/c/NCF6vS18C19sVVGNeeOj4qWw+osIQT8wo
         O5kvd8qGxc5kQvZjSR2wpsPhavlnZ3SIU6j/5qKyyUPUjRxm1Exw5KR+HqDF3k+h+4It
         XiIzUdwi4UPXzxvTRFah7pV3hCY4EwFOw0Pc7xP/W9XxNsM68NYFeBIN+O0lNEqVfsvz
         xgMiGvZOajQKoMRpJ8hHrbqP3hkXXsyJ5FbvI0qCVjdiu2udBHFMcXUspsHAR89hKOyb
         1yGzd6/sulV2aviBNXiOtjbaz8WNxWLTbYsY/I2K3JLTybkm+ZR/rAUIItfvvu7NXQs/
         EmUw==
X-Forwarded-Encrypted: i=1; AJvYcCVqVMTPLQFrdPy6R3O+gtrvJZNUy1CC89CQ9Xi2x12zCQazFEyPIJOM1nZks1ygLuenfmGaaQa7z3aVBUdUX8qNgS+4Zzc2E2LI5seIlPzKO3wEdyw3Z/Knrh4Qd3x44X6/k4R+WeETMVwkoXsnh551PbzlxPl0ZlqUNJSYQK6vzQ==
X-Gm-Message-State: AOJu0YwMPsSrMn1AF/ezuq+2IFWfzdic6C/3ygU171pDUOWzwmz3Om+H
	Vdh+I4G2XTbBdgfpR5nCONFyHAFpPkxrvP7xwEMhXmHnkoTAPqSy
X-Google-Smtp-Source: AGHT+IGfya6mYn6ddU1tD7ITxjKPgnQCju1kkkFTzl3i1Es4LhqbsMgRa4AGgjVuAFe7V1qwxUpF5A==
X-Received: by 2002:a17:902:e811:b0:1fd:8dfd:3553 with SMTP id d9443c01a7336-1ff37bec1cemr54739435ad.18.1722364459494;
        Tue, 30 Jul 2024 11:34:19 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:18 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
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
Subject: [net-next v3 04/15] net: macb: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:52 -0700
Message-Id: <20240730183403.4176544-5-allen.lkml@gmail.com>
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
APIs throughout the macb driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ea71612f6b36..5740c98d8c9f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -13,6 +13,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/phy/phy.h>
+#include <linux/workqueue.h>
 
 #if defined(CONFIG_ARCH_DMA_ADDR_T_64BIT) || defined(CONFIG_MACB_USE_HWSTAMP)
 #define MACB_EXT_DESC
@@ -1330,7 +1331,7 @@ struct macb {
 	spinlock_t rx_fs_lock;
 	unsigned int max_tuples;
 
-	struct tasklet_struct	hresp_err_tasklet;
+	struct work_struct	hresp_err_bh_work;
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 11665be3a22c..95e8742dce1d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1792,9 +1792,9 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void macb_hresp_error_task(struct tasklet_struct *t)
+static void macb_hresp_error_task(struct work_struct *work)
 {
-	struct macb *bp = from_tasklet(bp, t, hresp_err_tasklet);
+	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *dev = bp->dev;
 	struct macb_queue *queue;
 	unsigned int q;
@@ -1994,7 +1994,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		}
 
 		if (status & MACB_BIT(HRESP)) {
-			tasklet_schedule(&bp->hresp_err_tasklet);
+			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
 			netdev_err(dev, "DMA bus error: HRESP not OK\n");
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
@@ -5172,7 +5172,7 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_unregister_mdio;
 	}
 
-	tasklet_setup(&bp->hresp_err_tasklet, macb_hresp_error_task);
+	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5216,7 +5216,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		tasklet_kill(&bp->hresp_err_tasklet);
+		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (!pm_runtime_suspended(&pdev->dev)) {
-- 
2.34.1


