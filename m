Return-Path: <linux-rdma+bounces-3391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C6911A23
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75FE286ABD
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2748D16D9B9;
	Fri, 21 Jun 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIZVXW9+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5E16E882;
	Fri, 21 Jun 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946367; cv=none; b=ifX4VPQMWj/eBuvb2jDKN3eRmr2DTiKfJsrY285SGQtg8euMAqTUmxR6ZTt07b+jh4/u1RsC9oqXoDfsu6ImoebQt4r1Dh2G/hg5V8YRlfaVw7lNCXLT1QOGmj8hK4Ib2PGZABdwI1ErBjl52nLMDzKCAMLp1l9UJE0oVaf0OXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946367; c=relaxed/simple;
	bh=x/RfIjlwpumUmDOu4Tf2V/YAEWwgje+MYgVG2elP/Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXZqx0R9t9xPAl62xlsucjHmmH3wCnDxQHwkdDDrXpIoJMMvp3aKrQf7Hl2iVl/vfYwPVxrHYV2sp5TCscvtFHWRz8Ka+2ZLSeRD1USMVJan06Y6RUI/ob3wVM9TeHjSa5+fGv5YEeIcGws+uX44n7BXs81Yf0EjViWJ72IJpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIZVXW9+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so1385124a91.1;
        Thu, 20 Jun 2024 22:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946366; x=1719551166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb9G2dJ7OPjt/ejkd8tb2g/z5QKcxicC+1X1lii3BoE=;
        b=cIZVXW9+Ae5zckttlTsg85lq7f7jFOVRIWOqG22Voa9Ji3SZR8NoQt9nN+IzOfjdvq
         pptbiOH6cGQZtewuPd2M0Q0ufzEMOmNHLNMDUbPqDWoyEml52m/9ZrZI/ML+17rQ+4Ip
         rZ+/8LxtyLURzB0u4/nz0ZaweLlU1VG09f1PKpv52KlqCT4KCO+ZwFDlU9x8eCmSV3Zo
         3TJQREZcqbD9pz1DOgixG/OivFDvlIyNQhulr+xD0qC8pkc60W82BqDTzvj7B6+FpYnS
         RKznyLtD+ixk6UOiICzeeBVW9VOG5tX0oi0g0H6DuKMe+Po7V4o3QanvUUKD3xpAdReV
         jZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946366; x=1719551166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb9G2dJ7OPjt/ejkd8tb2g/z5QKcxicC+1X1lii3BoE=;
        b=Jw3ReE8Fmk/6gpveV0yAfLOujcrzPSMMMGrIvPHEyqJ5jcPheTgAUpBWoT8B8MOYpl
         UhJkJonXMLpT1w9BT0V/eq04Ymiq328JSYzttBV2dGr0ki6CwwpiVWPOaGQdy7WoADub
         Xs8i2BAasT0XKKTwjf/mqlrGLXVpGH8PxCe+JcmUJOilC9/WFvFs4S/LGrW4yKtzBNwS
         LRMi+B5h8dN/3RXkR4RvBdiit98lWl84MwCL+M0FnWfw3w5VE0tUuREd72OFYwYHu7Pj
         GGC7eoXug2RFGhwiJJQMzhgj+dQoDzBeGYUcKvxjN+h9HDfDY0/oYNZ5yh97PA3B1g9s
         jdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8e2Ku43ALsNeuVy5l9wJNmssu/NwR0UptJxO4s9LzshLNC2v3CT1Y2LbDBAjIksabTeO7Q7yrb1gjPW6wmRSZyRVzQ0rn7ddBrxrfCycGqWNM9190irR43zNevlkkKQa4B/ntLpnYgmnD5p12W+yTHF8TYcG61w/+Kbl7aoIGjQ==
X-Gm-Message-State: AOJu0YxxGAZ6c0xN8P01NskR8tGxYSUn1wuA0vUBWcqWilP2O2V0G3o6
	YBQGfCh50WAj49UgtdO5RpIbkPANFILbQxCEIZCdgnd7yG5AHjVn
X-Google-Smtp-Source: AGHT+IFt/DVrB0r5Yt5O6INCZ9XvmjOda1oxh5UnpUp4RYoHaOpA6xAH45TisqRzLqPRUnNT9XKRaA==
X-Received: by 2002:a17:90a:43a5:b0:2c2:8d49:5e6c with SMTP id 98e67ed59e1d1-2c7b58fc980mr7060917a91.7.1718946365579;
        Thu, 20 Jun 2024 22:06:05 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:06:05 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>
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
Subject: [PATCH 14/15] net: marvell: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:24 -0700
Message-Id: <20240621050525.3720069-15-allen.lkml@gmail.com>
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
APIs throughout the marvell driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  4 +---
 drivers/net/ethernet/marvell/skge.c             | 12 ++++++------
 drivers/net/ethernet/marvell/skge.h             |  3 ++-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 671368d2c77e..47fe71a8f57e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2628,9 +2628,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
  * The number of sent descriptors is returned.
  * Per-thread access
  *
- * Called only from mvpp2_txq_done(), called from mvpp2_tx()
- * (migration disabled) and from the TX completion tasklet (migration
- * disabled) so using smp_processor_id() is OK.
+ * Called only from mvpp2_txq_done().
  */
 static inline int mvpp2_txq_sent_desc_proc(struct mvpp2_port *port,
 					   struct mvpp2_tx_queue *txq)
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index fcfb34561882..4448af079447 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3342,13 +3342,13 @@ static void skge_error_irq(struct skge_hw *hw)
 }
 
 /*
- * Interrupt from PHY are handled in tasklet (softirq)
+ * Interrupt from PHY are handled in bh work (softirq)
  * because accessing phy registers requires spin wait which might
  * cause excess interrupt latency.
  */
-static void skge_extirq(struct tasklet_struct *t)
+static void skge_extirq(struct work_struct *work)
 {
-	struct skge_hw *hw = from_tasklet(hw, t, phy_task);
+	struct skge_hw *hw = from_work(hw, work, phy_bh_work);
 	int port;
 
 	for (port = 0; port < hw->ports; port++) {
@@ -3389,7 +3389,7 @@ static irqreturn_t skge_intr(int irq, void *dev_id)
 	status &= hw->intr_mask;
 	if (status & IS_EXT_REG) {
 		hw->intr_mask &= ~IS_EXT_REG;
-		tasklet_schedule(&hw->phy_task);
+		queue_work(system_bh_wq, &hw->phy_bh_work);
 	}
 
 	if (status & (IS_XA1_F|IS_R1_F)) {
@@ -3937,7 +3937,7 @@ static int skge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->pdev = pdev;
 	spin_lock_init(&hw->hw_lock);
 	spin_lock_init(&hw->phy_lock);
-	tasklet_setup(&hw->phy_task, skge_extirq);
+	INIT_WORK(&hw->phy_bh_work, skge_extirq);
 
 	hw->regs = ioremap(pci_resource_start(pdev, 0), 0x4000);
 	if (!hw->regs) {
@@ -4035,7 +4035,7 @@ static void skge_remove(struct pci_dev *pdev)
 	dev0 = hw->dev[0];
 	unregister_netdev(dev0);
 
-	tasklet_kill(&hw->phy_task);
+	cancel_work_sync(&hw->phy_bh_work);
 
 	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask = 0;
diff --git a/drivers/net/ethernet/marvell/skge.h b/drivers/net/ethernet/marvell/skge.h
index f72217348eb4..0cf77f4b1c57 100644
--- a/drivers/net/ethernet/marvell/skge.h
+++ b/drivers/net/ethernet/marvell/skge.h
@@ -5,6 +5,7 @@
 #ifndef _SKGE_H
 #define _SKGE_H
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 /* PCI config registers */
 #define PCI_DEV_REG1	0x40
@@ -2418,7 +2419,7 @@ struct skge_hw {
 	u32	     	     ram_offset;
 	u16		     phy_addr;
 	spinlock_t	     phy_lock;
-	struct tasklet_struct phy_task;
+	struct work_struct   phy_bh_work;
 
 	char		     irq_name[]; /* skge@pci:000:04:00.0 */
 };
-- 
2.34.1


