Return-Path: <linux-rdma+bounces-4121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36207941FC6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBFB2859B5
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999501A8C00;
	Tue, 30 Jul 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEorkEb+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA921A8BE5;
	Tue, 30 Jul 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364488; cv=none; b=C59wyrhpyxzkVrdB5UuF4dupNmuWfrm4AJgoeQZLNtGkrNSLOV20GPh+qXUqDAiSoWrppX7ClJk0H0NFK89qMS70r8h1OJI9SygiXnBgaAOmQPvZ1bxc0ss+0tyFBwPA6FDwsr3g/B5fo1rNunNKq8r9hgH3W0Kkicj0UPBV/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364488; c=relaxed/simple;
	bh=LEyJiOXnSr7IzNm7xZKPMDnB7ns46OG9/YCUuG54m9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teXs1ith0O6Ndog2xp8NArQK5wlHRxi8AYEzEPEd2LsnB+0G7rUBjcxmpB7i495NH+BWFoDMxSTX2AUj2nFLF+5bv8J1Lpj2KPuh9K0jTIT9aTHu/lF6xHl1yhnxfVeN899S++b1kfG8v/aeFGvu/w9YLvherVdjbQNanye/oRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEorkEb+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so2958286a12.1;
        Tue, 30 Jul 2024 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364486; x=1722969286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/o4jte8rJSyLfv/o/bxl996aMu/g1aGy8txwuXlNI8=;
        b=YEorkEb+Bzl+5CeaGdI1AQ6S6TKomaAnRwMwSvCob2A/pddmEb8RKjDLixPACVuLCB
         BQS8qfZgkmEg6ExD49lXfcoipS+ARVyzs/64VWyHqkBG++P93eVBtSYn6XhXidhjjjpY
         APK0gqF7euAyO4GDn2CDsTP4YV7qtD3CXZG8zuciThY3Vaf67jEvt+5ftxfO1f379WuF
         VKjxIF7ZzRHrryIzJNsv8GVJjpuKRUlyfK/Tw35r9oelojjHtk1q7t7xDWkOweeERrn3
         n3vfloFeQfU/m0xrhFIlPKT4AUYs3p0ZM0xXxbt5XIo09mhlTQJJa3kVviG1afmZnbBe
         DwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364486; x=1722969286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/o4jte8rJSyLfv/o/bxl996aMu/g1aGy8txwuXlNI8=;
        b=K2+EKkU5zfKA9dwmVSAKPvuU/TLbSTgRD3gAelFTbM1GEu36DbW0ttqLmQG05W0VXm
         1UlrL03Px6NlSa4XR9ZB4RIV8yrItILw9QeVm3RXlJQdZzwuPK8ESOfWud+a24EuLeoX
         38VTu0vJxBFCV92tWUYkgyQDD/CnYJT8jDMTha3GZDMmtJ3Ap06NAvlRmmUr75uYRnyu
         yuXS/ZvbCPCRI91IG/tDrqRZhoBnt7IXC1AuRMgquIg1rr0rkDOMXz1W2TxzKYkbIX0D
         tWmIYVw5S6aDrQT3SOJgaLWWh1yfFz0WfOB51kNzvxeZ2I7ejaUgm7nPvVyThUbucxeq
         YGlA==
X-Forwarded-Encrypted: i=1; AJvYcCW6HlmyrnAWPrbhzazbTybPG1yrjtuRDnWoJsU/rO4GLnOvPDhYyARdZ7lXuOSg8KUqIhaiBoqDERivAyAbHWsnMwAsFR6oRP1gXD0IcMoygTFT0Sd1KORCnKlhcfwSZM7G00ecvPu30LQVduliR1XU+1Ag/gugAiI+jkfKg0BT0w==
X-Gm-Message-State: AOJu0YxWCngqN66PXLFg/SxJj81qAfap30JYA/qH4MASJJSSlLP4SnSd
	p4R0j2oZRwMJBR1WS8Ez9/7FwRhLl3P8JDD44Z32D+lyYDm7mttO
X-Google-Smtp-Source: AGHT+IGzTBr0vkyMv23wVvhNpJLqIZ9X+i9f11iA1tZboMTTSqcscHqHJfajMlLIFlgYxY/rQBa59w==
X-Received: by 2002:a05:6a20:2588:b0:1c2:94ad:1c5d with SMTP id adf61e73a8af0-1c4a117dd82mr11599199637.2.1722364486353;
        Tue, 30 Jul 2024 11:34:46 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:45 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 14/15] net: marvell: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:34:02 -0700
Message-Id: <20240730183403.4176544-15-allen.lkml@gmail.com>
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
APIs throughout the marvell drivers. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  9 ++++++---
 drivers/net/ethernet/marvell/skge.c             | 12 ++++++------
 drivers/net/ethernet/marvell/skge.h             |  3 ++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8c45ad983abc..adffbbd20962 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2628,9 +2628,12 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
  * The number of sent descriptors is returned.
  * Per-thread access
  *
- * Called only from mvpp2_txq_done(), called from mvpp2_tx()
- * (migration disabled) and from the TX completion tasklet (migration
- * disabled) so using smp_processor_id() is OK.
+ * Called only from mvpp2_txq_done().
+ *
+ * Historically, this function was invoked directly from mvpp2_tx()
+ * (with migration disabled) and from the bottom half workqueue.
+ * Verify that the use of smp_processor_id() is still appropriate
+ * considering the current bottom half workqueue implementation.
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


