Return-Path: <linux-rdma+bounces-6740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A699FC54A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 14:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E691D161257
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124817B402;
	Wed, 25 Dec 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mdK+/NSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CF13B7BC
	for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735132556; cv=none; b=qY2r2nLx9bXUi9GhZTTcEYh58a/WhpSLSGrrObFSiHOsBfRyOqu2XjsU/aDlMh5KLPFjq+mxYkc2BDfmsF6sVmMF1OVR55JDLufJ1O/sZLy5/j//c8HrWlgZm8Xob4LZuAKnrkkiQX0XF7IyI9Rlb7tLWwrIpRrM15WVC5oSGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735132556; c=relaxed/simple;
	bh=AeNpbM/K/GKken8hWGtQubS93ghmhR/gxo0hVaO/sLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsmRvK7g/IE+TOT4SZ1fBkpoZNNUrvIqXFnDu/DZ73pvMDvC9TOhGUO16LIRQYbanqOPpSGt1ab/JGe4SiOQlc/5stGnbn06JStP0QGc9wVCXFsCs45I/glAs0693Hm9sETHkZGkgsPtfS32/WbC8Finh+7/scv67D6Zvfybngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mdK+/NSq; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735132433; x=1766668433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4nEn2ABcVW7BroQ8rAgj64Hh8yNDHWBw2CfqUyXGka4=;
  b=mdK+/NSqQ/9SE9WWvoaU52Qg4qYU+k97PCL58d4AiT98n9M0mFSlVwnk
   d6DM9rmuiSISTZlayNL7tQbTIYh9LT6f489euaWP4EnvCSBWNJlO8LEWf
   eWvi4vzX6oTPvXW1EnIDjmCMqRGpkCcWrejvXsUzc1z3S+BHz9ONIZjHz
   c=;
X-IronPort-AV: E=Sophos;i="6.12,263,1728950400"; 
   d="scan'208";a="8665611"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 13:13:51 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:56418]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.163:2525] with esmtp (Farcaster)
 id b3b9e4e1-40be-4528-a630-1a836ed0619f; Wed, 25 Dec 2024 13:15:51 +0000 (UTC)
X-Farcaster-Flow-ID: b3b9e4e1-40be-4528-a630-1a836ed0619f
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 25 Dec 2024 13:15:51 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 25 Dec 2024 13:15:51 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 25 Dec 2024 13:15:51 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com (dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com [10.253.103.172])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTP id 6C182C0514;
	Wed, 25 Dec 2024 13:15:49 +0000 (UTC)
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Reset device on probe failure
Date: Wed, 25 Dec 2024 13:15:48 +0000
Message-ID: <20241225131548.15155-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Make sure the device is being reset on driver exit whatever the reason
is, to keep the device aligned and allow it to close shared resources
(e.g. admin queue).

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index ad225823e6f2..0b102089e0ab 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -470,7 +470,6 @@ static void efa_ib_device_remove(struct efa_dev *dev)
 	ibdev_info(&dev->ibdev, "Unregister ib device\n");
 	ib_unregister_device(&dev->ibdev);
 	efa_destroy_eqs(dev);
-	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_NORMAL);
 	efa_release_doorbell_bar(dev);
 }
 
@@ -643,12 +642,13 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
 	return ERR_PTR(err);
 }
 
-static void efa_remove_device(struct pci_dev *pdev)
+static void efa_remove_device(struct pci_dev *pdev, bool on_error)
 {
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 	struct efa_com_dev *edev;
 
 	edev = &dev->edev;
+	efa_com_dev_reset(edev, on_error ? EFA_REGS_RESET_INIT_ERR : EFA_REGS_RESET_NORMAL);
 	efa_com_admin_destroy(edev);
 	efa_free_irq(dev, &dev->admin_irq);
 	efa_disable_msix(dev);
@@ -676,7 +676,7 @@ static int efa_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_remove_device:
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, true);
 	return err;
 }
 
@@ -685,7 +685,7 @@ static void efa_remove(struct pci_dev *pdev)
 	struct efa_dev *dev = pci_get_drvdata(pdev);
 
 	efa_ib_device_remove(dev);
-	efa_remove_device(pdev);
+	efa_remove_device(pdev, false);
 }
 
 static void efa_shutdown(struct pci_dev *pdev)
-- 
2.40.1


