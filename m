Return-Path: <linux-rdma+bounces-2077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662588B277C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D23B25917
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C914E2DF;
	Thu, 25 Apr 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZEQpa/OB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9114E2D8
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065503; cv=none; b=sH46yeFyIi0USgnyiRR0k3MM57M9ugo+WxJkPZo9WWKC1dPoyKM5K6Mq5dc9bqYBJkS+a1dX1tNme35I0FPsnBi5b2zqBzpN3rb5Xo6SgIIVtazRt5yieMEfwjlagASRCpS7RHlKS3jIXL3kXijGDrg3UGKqIuW5SGsAbDGvfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065503; c=relaxed/simple;
	bh=aTbMrwHzuIpHJer192d6WyMl66mCeUNqHBiBWW5UDdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCHyRAkgpj8gQVWQeWfV0fP0dWFvi+hr0huOZWKCo/oeoPjWEDVo8JzUyAPrxJwfdsODOSLreHo4NSh9xN//BUfpp+Qn1OHMQJjDb9m1OdvWuc1zqBtNMpmtDu9qKwG0R5P8PrT40atiw91y18dsyE+U09ZyAv8guWGx4iK4Djs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZEQpa/OB; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714065503; x=1745601503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeuQyS8zNuUkgk4nFEplNvAkca3wnKgFYESgPrdCxOw=;
  b=ZEQpa/OBm7MXgiwqEBXtlYXVwc3AiqzWx6Jhcd3Ub7+WfeQiHhSvtbkQ
   rh/46qE3hP9+GaeaB6Q9LrHE2o/TDpDnx6Dz2OasOEVIYoi3hH2i1az6L
   gvTkVm7bG35oTWSO8/zZIMwDXJ26ljw2+PXAf46zTKZnaOIbd4QGDQuRr
   o=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="402905573"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:18:20 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:12179]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id 1ae8d3dd-ceb7-4aed-8625-2632dc9ebce9; Thu, 25 Apr 2024 17:18:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1ae8d3dd-ceb7-4aed-8625-2632dc9ebce9
Received: from EX19D045EUA002.ant.amazon.com (10.252.50.120) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:18:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D045EUA002.ant.amazon.com (10.252.50.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:18:17 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 25 Apr 2024 17:18:14
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	<ltao@redhat.com>, Firas Jahjah <firasj@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
Subject: [PATCH for-rc v2] RDMA/efa: Add shutdown notifier
Date: Thu, 25 Apr 2024 17:18:14 +0000
Message-ID: <20240425171814.25216-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
References: <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add driver function to stop the device and release any active IRQs as
preparation for shutdown. This should fix issues caused by unexpected AQ
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


