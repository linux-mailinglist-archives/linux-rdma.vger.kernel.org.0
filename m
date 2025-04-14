Return-Path: <linux-rdma+bounces-9423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEEA88B0C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414D31899B88
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25028DEF7;
	Mon, 14 Apr 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U5oFVe8q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64328BABE;
	Mon, 14 Apr 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655331; cv=none; b=L38om5kOlxm83DdyDXhSaK/ZhdATthrbaLMt+BpxBsc2bMpVWFWWHqkFUMODXthdE+9w5RVmwj7RTxm79K+pAWSyGt4PuCM5x0GNnVJxvFshAel8cgvRPU7NFRajEvaNvEpJmAJuMkI7TP+qcexuiVUaXQwA3l9d9SshIS+/8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655331; c=relaxed/simple;
	bh=Ae4wpe//W7HLmSCN6ADUQANwuPPjg/A1ooDFPHKJVdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nca8B/zy4xv2aBCewzmXE9uq3Gnsv0xbeBhskPpt9qpoUJw+vRussViIw/M6wda6dzvarKc/m1hnBFqHj9rL+fT3dp8s8DIHEKjKxAzL+3AFqZU0mtRp6/+1heseQuIWwpelmQG6jo5a0QYzf8At0oBEJR4/HtZ8KxLZyzksGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U5oFVe8q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id A67C1205250E; Mon, 14 Apr 2025 11:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A67C1205250E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744655329;
	bh=0V/DM+F3DK0UPkIn5uJEh69GVCca9RYgoMsmhcoi8Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5oFVe8qP3UKnlfzAkXjiJj3YKlObhkbPyjDnI9my8+xbVIPAPnz2ybH+LGqJCb+0
	 TNF6551hiOG3/sB633TGv32yAm+sVC/EDuvwb3CLZO0P7QyE0J4zGyndE/HGKKvsC5
	 UmLy9V69lxOGo5XZIfapBU5ztSaDYua6XDt15haQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next 1/4] net: mana: Probe rdma device in mana driver
Date: Mon, 14 Apr 2025 11:28:46 -0700
Message-Id: <1744655329-13601-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Initialize gdma device for rdma inside mana module.
For each gdma device, initialize an auxiliary ib device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 16 +++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 39 +++++++++++++++++--
 include/net/mana/mana.h                       |  3 ++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index b5156d4..1caf73c 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -978,7 +978,6 @@ int mana_gd_register_device(struct gdma_dev *gd)
 
 	return 0;
 }
-EXPORT_SYMBOL_NS(mana_gd_register_device, "NET_MANA");
 
 int mana_gd_deregister_device(struct gdma_dev *gd)
 {
@@ -1009,7 +1008,6 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
 
 	return err;
 }
-EXPORT_SYMBOL_NS(mana_gd_deregister_device, "NET_MANA");
 
 u32 mana_gd_wq_avail_space(struct gdma_queue *wq)
 {
@@ -1541,8 +1539,15 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto cleanup_gd;
 
+
+	err = mana_rdma_probe(&gc->mana_ib);
+	if (err)
+		goto cleanup_mana;
+
 	return 0;
 
+cleanup_mana:
+	mana_remove(&gc->mana, false);
 cleanup_gd:
 	mana_gd_cleanup(pdev);
 unmap_bar:
@@ -1569,6 +1574,7 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, false);
 
 	mana_gd_cleanup(pdev);
@@ -1588,6 +1594,7 @@ static int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
 	mana_gd_cleanup(pdev);
@@ -1612,6 +1619,10 @@ static int mana_gd_resume(struct pci_dev *pdev)
 	if (err)
 		return err;
 
+	err = mana_rdma_probe(&gc->mana_ib);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -1622,6 +1633,7 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev, "Shutdown was called\n");
 
+	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
 	mana_gd_cleanup(pdev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4e870b1..70c4955 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2936,7 +2936,7 @@ static void remove_adev(struct gdma_dev *gd)
 	gd->adev = NULL;
 }
 
-static int add_adev(struct gdma_dev *gd)
+static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
@@ -2952,7 +2952,7 @@ static int add_adev(struct gdma_dev *gd)
 		goto idx_fail;
 	adev->id = ret;
 
-	adev->name = "rdma";
+	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
 	adev->dev.release = adev_release;
 	madev->mdev = gd;
@@ -3064,7 +3064,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		}
 	}
 
-	err = add_adev(gd);
+	err = add_adev(gd, "dpdk");
 out:
 	if (err)
 		mana_remove(gd, false);
@@ -3131,6 +3131,39 @@ out:
 	kfree(ac);
 }
 
+int mana_rdma_probe(struct gdma_dev *gd)
+{
+	int err = 0;
+
+	if (gd->dev_id.type != GDMA_DEVICE_MANA_IB) {
+		/* RDMA device is not detected on pci */
+		return err;
+	}
+
+	err = mana_gd_register_device(gd);
+	if (err)
+		return err;
+
+	err = add_adev(gd, "rdma");
+	if (err)
+		mana_gd_deregister_device(gd);
+
+	return err;
+}
+
+void mana_rdma_remove(struct gdma_dev *gd)
+{
+	if (gd->dev_id.type != GDMA_DEVICE_MANA_IB) {
+		/* RDMA device is not detected on pci */
+		return;
+	}
+
+	if (gd->adev)
+		remove_adev(gd);
+
+	mana_gd_deregister_device(gd);
+}
+
 struct net_device *mana_get_primary_netdev(struct mana_context *ac,
 					   u32 port_index,
 					   netdevice_tracker *tracker)
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0f78065..5857efc 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -488,6 +488,9 @@ int mana_detach(struct net_device *ndev, bool from_close);
 int mana_probe(struct gdma_dev *gd, bool resuming);
 void mana_remove(struct gdma_dev *gd, bool suspending);
 
+int mana_rdma_probe(struct gdma_dev *gd);
+void mana_rdma_remove(struct gdma_dev *gd);
+
 void mana_xdp_tx(struct sk_buff *skb, struct net_device *ndev);
 int mana_xdp_xmit(struct net_device *ndev, int n, struct xdp_frame **frames,
 		  u32 flags);
-- 
2.43.0


