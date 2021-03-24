Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B3347AA4
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 15:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhCXOZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 10:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236129AbhCXOZ3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 10:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FCE061580;
        Wed, 24 Mar 2021 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616595929;
        bh=510M5NUkGTkTnk1INO8EUeU+5nZMp5OqjFn4ZvkAvDg=;
        h=From:To:Cc:Subject:Date:From;
        b=EYcrSLUVsacmqdTIdQJuoXC4gBKfisBLf+tISD78Wo9BcWVnxwesZycry+UpNdPoK
         v6piJL0jb4uvDmNIvvb7ClK1rc9K4YOfPE1yiVUAa+lqxPwCqYVmm3eU/83/a+4hXq
         5AAkdeDKiTb29UaCzuZvnBg/fmesFjdHYnpaQ5PBJKKPf3xs6tBiCcbVMFCiynnuEz
         /MMMI9+GN4Pt403KdFjBi7ucwnJu0PGKWhI7LgS0Ax6KO5YTew5Ov5iGDI7QbTXNna
         D1uA2a/vevEALjBff0PaGE3BwyImaRo03YieObFi6mJc5yeBOFR464x9bDh81uIoI1
         22hQL7DJEdWBg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module dependency
Date:   Wed, 24 Mar 2021 16:25:24 +0200
Message-Id: <20210324142524.1135319-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Instead of manually messing with parent driver module reference
counting, rely on "depends on" keyword to ensure that proper
probe/remove chain is performed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/Kconfig |  4 +---
 drivers/infiniband/hw/bnxt_re/main.c  | 20 +++++---------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
index 0feac5132ce1..b4779a6cd565 100644
--- a/drivers/infiniband/hw/bnxt_re/Kconfig
+++ b/drivers/infiniband/hw/bnxt_re/Kconfig
@@ -2,9 +2,7 @@
 config INFINIBAND_BNXT_RE
 	tristate "Broadcom Netxtreme HCA support"
 	depends on 64BIT
-	depends on ETHERNET && NETDEVICES && PCI && INET && DCB
-	select NET_VENDOR_BROADCOM
-	select BNXT
+	depends on ETHERNET && NETDEVICES && PCI && INET && DCB && BNXT
 	help
 	  This driver supports Broadcom NetXtreme-E 10/25/40/50 gigabit
 	  RoCE HCAs.  To compile this driver as a module, choose M here:
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fdb8c2478258..a81adb07e5d9 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -561,13 +561,6 @@ static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
 	return container_of(ibdev, struct bnxt_re_dev, ibdev);
 }
 
-static void bnxt_re_dev_unprobe(struct net_device *netdev,
-				struct bnxt_en_dev *en_dev)
-{
-	dev_put(netdev);
-	module_put(en_dev->pdev->driver->driver.owner);
-}
-
 static struct bnxt_en_dev *bnxt_re_dev_probe(struct net_device *netdev)
 {
 	struct bnxt *bp = netdev_priv(netdev);
@@ -593,10 +586,6 @@ static struct bnxt_en_dev *bnxt_re_dev_probe(struct net_device *netdev)
 		return ERR_PTR(-ENODEV);
 	}
 
-	/* Bump net device reference count */
-	if (!try_module_get(pdev->driver->driver.owner))
-		return ERR_PTR(-ENODEV);
-
 	dev_hold(netdev);
 
 	return en_dev;
@@ -1523,13 +1512,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 
 static void bnxt_re_dev_unreg(struct bnxt_re_dev *rdev)
 {
-	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct net_device *netdev = rdev->netdev;
 
 	bnxt_re_dev_remove(rdev);
 
-	if (netdev)
-		bnxt_re_dev_unprobe(netdev, en_dev);
+	if (!netdev)
+		return;
+
+	dev_put(netdev);
 }
 
 static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
@@ -1551,7 +1541,7 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
 	*rdev = bnxt_re_dev_add(netdev, en_dev);
 	if (!*rdev) {
 		rc = -ENOMEM;
-		bnxt_re_dev_unprobe(netdev, en_dev);
+		dev_put(netdev);
 		goto exit;
 	}
 exit:
-- 
2.30.2

