Return-Path: <linux-rdma+bounces-2062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95EF8B1C3B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BEB281FB9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74136E611;
	Thu, 25 Apr 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cISvYAxz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421676D1B0
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031515; cv=none; b=K9jLSCiXvoeKNxammRLp9iLcu0Az6cNuQe1I/qp9LgTiKmTUuPvGeQLcvxJAmLgZ5eVfRiWi5blZKhF2zdGAF7IX4GYNOy5eKCdGDwPckvpqSHBpI2ZFJdb4xCdAKVqY8y1XJz66rybCeMCE+4IUNEgYJ1GMqdlsPHUyWdM881s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031515; c=relaxed/simple;
	bh=7nE1KT0f9V/CV9S3TLbxyhu8W1ACUGVtadGNaIhLw30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2XGrOT26mapap4/Pk1ViZg4LmWvUV8rv4uJXQgal1bcc7R08yR+JVKhVSwI/R4d3AZQ01DrIWuoZTweceDlpyvcw88UvKLnlHvSqoRbNrr3/xfhZmjA90B7cNQvK34l9vfvp4TkKYdS3elUgnD6dvSvnXpSQf5WWx9m6S31q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cISvYAxz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714031514; x=1745567514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSFrerWZUHYs6edWiAXdcrelcGa5YOVabl+bNrmByEs=;
  b=cISvYAxz4l68L5D/G9QnvxaHohS0b0IOR36ZX1oQtjDQqsN4EOe+t9Xc
   iLWca/IDtAJNLuO5l04k2AxNyStqfpX15PqK31UHFg3K+lG4sWy8p5rxh
   4W1B9nC6+2qRi4NAL+8SGNhMeXQ3XdXub5Y9scyyspdjYwnZfBkcb3U6B
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,228,1708387200"; 
   d="scan'208";a="201121264"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 07:51:51 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:57802]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id 17f0f3a9-c303-4f9f-b33d-b8002f95fc25; Thu, 25 Apr 2024 07:51:49 +0000 (UTC)
X-Farcaster-Flow-ID: 17f0f3a9-c303-4f9f-b33d-b8002f95fc25
Received: from EX19D019EUB004.ant.amazon.com (10.252.51.91) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 07:51:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D019EUB004.ant.amazon.com (10.252.51.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 07:51:45 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 25 Apr 2024 07:51:44
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	<ltao@redhat.com>, Firas Jahjah <firasj@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Add shutdown notifier
Date: Thu, 25 Apr 2024 07:51:43 +0000
Message-ID: <20240425075143.24683-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add driver function to stop the device and release any active IRQs as
preparation for shutdown. This should fix issues cased by unexpected AQ
interrupts when booting kernel using kexec and possible data integrity
issues when the system is being shutdown during traffic.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 5fa3603c80d8..d1a48f988f6c 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -671,11 +671,22 @@ static void efa_remove(struct pci_dev *pdev)
 	efa_remove_device(pdev);
 }
 
+static void efa_shutdown(struct pci_dev *pdev)
+{
+	struct efa_dev *dev = pci_get_drvdata(pdev);
+
+	efa_destroy_eqs(dev);
+	efa_com_dev_reset(&dev->edev, EFA_REGS_RESET_SHUTDOWN);
+	efa_free_irq(dev, &dev->admin_irq);
+	efa_disable_msix(dev);
+}
+
 static struct pci_driver efa_pci_driver = {
 	.name           = DRV_MODULE_NAME,
 	.id_table       = efa_pci_tbl,
 	.probe          = efa_probe,
 	.remove         = efa_remove,
+	.shutdown       = efa_shutdown,
 };
 
 module_pci_driver(efa_pci_driver);
-- 
2.40.1


