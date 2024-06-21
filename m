Return-Path: <linux-rdma+bounces-3381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BF911A02
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5EDB20B29
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86083167D98;
	Fri, 21 Jun 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/mLuSdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED65156228;
	Fri, 21 Jun 2024 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946349; cv=none; b=RpnOsJFWtpeAzztpYgzouUYR62gN6dFpLMv7DDuRI5LGPist574/D5i7x0WlVd6xkmL9gpeaSdlRxipVENHwUiO0seqihLk4ukkMG576zfXmhvnS2VymD/VTgfAZyR/2BbbFBI14SreZ+S0raMUmVl2U1gzFfJvVnEnRxQA/bQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946349; c=relaxed/simple;
	bh=iWmbrGxooEyBj4VWQ7emVHug9EYg04S4JxaGVSqV/yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSrFcgo/s/nM5EEPpjgHKfTGJSR9DAiKP0qtjtED6wHQIshXX0vv3P7KqoZXtf5ymZrnBlckNvBwdjjrRgwU7AEHRXjqrpg7LrxBew9C+kCzMKmLbv+gavnNgWBYL4qF1TtjBQb8mx4p3PVx0OSYv22BBTZUMJS38O8EqsYMCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/mLuSdE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f65a3abd01so13423215ad.3;
        Thu, 20 Jun 2024 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946347; x=1719551147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiWssLGa6hq6n1xcfQQ/01ONDxIRNpw6q3yCritF5Gs=;
        b=l/mLuSdEME9mvWmTDhsflfRbx02mqCSeAzMotW/tD31CGFpXqpAriwP7gsOcQIX7Uz
         X6pz64569CsVJATxIcPUwGMu6rvlDrxaiY6gq67+bBX7zubkQxXhGexNd3YffvsPLzx0
         XBJuFr41OX2/slIeKMmrX37g6qJVL1P48nD6+yTlCAYxThDNWZ7SWtzTRYdQ2dQvtuFr
         8XUPSEkVuL7K6ZNN0lZU6Im7kLrA07+wtdiB0ZK22BK/78fCUE/agP0ftumCZ2mVt5EP
         33oRcXVusqibEJsvoAZ46zpCw+EdBMN8rWcU+gMb3UdO8whf6Yj4x2jAEMuTpzq3c1iy
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946347; x=1719551147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiWssLGa6hq6n1xcfQQ/01ONDxIRNpw6q3yCritF5Gs=;
        b=jp9VbzSOxkVgp2wXuP51pi2If9i2WAv+NYRwqYSwBUDIxD57m0XPENrQWCtGSUNJE6
         bzeyi64hGLhXzVPYGD4xhui9OUa6+ryt/SzAp9OEG9N3bqCd+vlGGZfnHiXtAN6Upmu8
         GuCnGXv8Wj80UaYowj5j2vjyi+sZVPwtWZ2rIAmDLoKJ+ZkDtIK5ZbPeXFceT5HNwTLj
         gLo3qlrnTc8vNrK7Gw5Oe5QuV/u9YMqjA77PZ01uhp494iDV4GoTys/PMP/QIvBHL3z1
         eIQSTHDR5K97D0ZQ7vbv4XwyWfgxeYp/sxFwVK4TZSKnd39fcJA3OJBRdCuI4VlFOAjO
         YZJw==
X-Forwarded-Encrypted: i=1; AJvYcCUcilfz258+i6ebRXOa1CPFR8FFL93VWYVu3v1M7bkcTnDbuwxenGlWHvNO68VUzaLamcY+wSOpuOzo+q24BXba1fVC/b7Cg6Z4wiBAc45ZTUI5ZYssKci8feIDQmGZahZ3+s/WuFae2d25WWd+Ynog2QHZIvGNYkHDKz5+Gs+aFg==
X-Gm-Message-State: AOJu0Yyi1nDen05r6UGMjV93Snu9NFwFgY9xZuiPwb3veJl57GIkCzYE
	9LrI1vybUzqlixPqxb+rDpaS4RMVIdiBTXTV5Ll724xP3cdPNyUN
X-Google-Smtp-Source: AGHT+IFx1JB4r97zoJsVZl74xpEVNx+0aSHyzo7ylxxfGZ4kG9dJuWHhO+YimxwJEMrF46gYY2aUjw==
X-Received: by 2002:a17:90b:115:b0:2bd:9319:3da1 with SMTP id 98e67ed59e1d1-2c7b5c8be4dmr7325642a91.25.1718946347005;
        Thu, 20 Jun 2024 22:05:47 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:46 -0700 (PDT)
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
	Allen Pais <allen.lkml@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 04/15] net: macb: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:14 -0700
Message-Id: <20240621050525.3720069-5-allen.lkml@gmail.com>
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
APIs throughout the macb driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..e570cad705d2 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -13,6 +13,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/phy/phy.h>
+#include <linux/workqueue.h>
 
 #if defined(CONFIG_ARCH_DMA_ADDR_T_64BIT) || defined(CONFIG_MACB_USE_HWSTAMP)
 #define MACB_EXT_DESC
@@ -1322,7 +1323,7 @@ struct macb {
 	spinlock_t rx_fs_lock;
 	unsigned int max_tuples;
 
-	struct tasklet_struct	hresp_err_tasklet;
+	struct work_struct	hresp_err_bh_work;
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 241ce9a2fa99..0dc21a9ae215 100644
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
@@ -5150,7 +5150,7 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_unregister_mdio;
 	}
 
-	tasklet_setup(&bp->hresp_err_tasklet, macb_hresp_error_task);
+	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5194,7 +5194,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		tasklet_kill(&bp->hresp_err_tasklet);
+		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (!pm_runtime_suspended(&pdev->dev)) {
-- 
2.34.1


