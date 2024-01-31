Return-Path: <linux-rdma+bounces-824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53791843B33
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3141C227FC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DD67A1F;
	Wed, 31 Jan 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LZT/B0CV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBE633E9
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693656; cv=none; b=LIjPB23Rk8hwlcRy2cDKOoBl8ssQsZwMqpREiERBaL2spw6dfuASeVlGj2vg73676nC6lQWT4Ovv67/1JW2RC7Qd9Liy9B7LnXhKigoT3phivyammheDpd65jAZHgonkLAP9d4iy3iQ75BfKFyfr9OD3iDKnKa1EVfN9ItOXC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693656; c=relaxed/simple;
	bh=aW1ZAbuqHR973Wjw1DGDU/uPKQ7mLN4wAV94ap7+2Z8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYbhQB/I8QW4RskQC4nFheU8gUNBUZ69nw9tQ5KXh2nyUJ4ySStTmKtDYfbYZvZ4dWQt+jxmxtbfCvwrM6E4+7h7+ZdD6aZizcZhH50ZCaW83ccA9sw/Slgi+RoaXv1lYJADl3JbwgjbQlOL5EAE2EuOnRB7kYbtr5mFQg58O9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LZT/B0CV; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706693655; x=1738229655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KXf2HgUNmrP9NCghNoPZ/Cpha3kBbne3xNmIuPNLioY=;
  b=LZT/B0CVRp7bvDDdZa1QHZaOmKtc9I/VqHnvXEC738a+WlyFmXYK69Dp
   /mURunsc3EHGtKqMVO0jzr4a6m9R6yMUIRoaXEefKZ2q4KCEpaRb1sUPd
   htRyowojRBzZBkz5nLhbwB9KQ2QI9xrDFdwiEW1Oiigoo89PImdz+fwiL
   g=;
X-IronPort-AV: E=Sophos;i="6.05,231,1701129600"; 
   d="scan'208";a="324217202"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 09:34:07 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:61900]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.250:2525] with esmtp (Farcaster)
 id 24540874-340a-4258-85c9-a1ba9bed6e44; Wed, 31 Jan 2024 09:34:05 +0000 (UTC)
X-Farcaster-Flow-ID: 24540874-340a-4258-85c9-a1ba9bed6e44
Received: from EX19D045EUA004.ant.amazon.com (10.252.50.235) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 09:34:05 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D045EUA004.ant.amazon.com (10.252.50.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 09:34:05 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Wed, 31 Jan 2024 09:34:04
 +0000
From: <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>, Michael Margolin <mrgolin@amazon.com>,
	"Yonatan Goldhirsh" <ygold@amazon.com>
Subject: [PATCH for-rc v2] RDMA/efa: Limit EQs to available MSI-X vectors
Date: Wed, 31 Jan 2024 09:34:03 +0000
Message-ID: <20240131093403.18624-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yonatan Nachum <ynachum@amazon.com>

When creating EQs we take into consideration the max number of EQs the
device reported it can support and the number of available CPUs. There
are situations where the number of EQs the device reported it can
support and the PCI configuration of MSI-X is different, take it in
account as well when creating EQs.
Also request at least 1 MSI-X vector for the management queue and allow
the kernel to return a number of vectors in a range between 1 and the
max supported MSI-X vectors according to the PCI config.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yonatan Goldhirsh <ygold@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h      |  1 +
 drivers/infiniband/hw/efa/efa_main.c | 32 +++++++++++++---------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index e2bdec32ae80..926f9ff1f60f 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -57,6 +57,7 @@ struct efa_dev {
 	u64 db_bar_addr;
 	u64 db_bar_len;
 
+	unsigned int num_irq_vectors;
 	int admin_msix_vector_idx;
 	struct efa_irq admin_irq;
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 7b1910a86216..5fa3603c80d8 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -322,7 +322,9 @@ static int efa_create_eqs(struct efa_dev *dev)
 	int err;
 	int i;
 
-	neqs = min_t(unsigned int, neqs, num_online_cpus());
+	neqs = min_t(unsigned int, neqs,
+		     dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
+
 	dev->neqs = neqs;
 	dev->eqs = kcalloc(neqs, sizeof(*dev->eqs), GFP_KERNEL);
 	if (!dev->eqs)
@@ -468,34 +470,30 @@ static void efa_disable_msix(struct efa_dev *dev)
 
 static int efa_enable_msix(struct efa_dev *dev)
 {
-	int msix_vecs, irq_num;
+	int max_vecs, num_vecs;
 
 	/*
 	 * Reserve the max msix vectors we might need, one vector is reserved
 	 * for admin.
 	 */
-	msix_vecs = min_t(int, pci_msix_vec_count(dev->pdev),
-			  num_online_cpus() + 1);
+	max_vecs = min_t(int, pci_msix_vec_count(dev->pdev),
+			 num_online_cpus() + 1);
 	dev_dbg(&dev->pdev->dev, "Trying to enable MSI-X, vectors %d\n",
-		msix_vecs);
+		max_vecs);
 
 	dev->admin_msix_vector_idx = EFA_MGMNT_MSIX_VEC_IDX;
-	irq_num = pci_alloc_irq_vectors(dev->pdev, msix_vecs,
-					msix_vecs, PCI_IRQ_MSIX);
+	num_vecs = pci_alloc_irq_vectors(dev->pdev, 1,
+					 max_vecs, PCI_IRQ_MSIX);
 
-	if (irq_num < 0) {
-		dev_err(&dev->pdev->dev, "Failed to enable MSI-X. irq_num %d\n",
-			irq_num);
+	if (num_vecs < 0) {
+		dev_err(&dev->pdev->dev, "Failed to enable MSI-X. error %d\n",
+			num_vecs);
 		return -ENOSPC;
 	}
 
-	if (irq_num != msix_vecs) {
-		efa_disable_msix(dev);
-		dev_err(&dev->pdev->dev,
-			"Allocated %d MSI-X (out of %d requested)\n",
-			irq_num, msix_vecs);
-		return -ENOSPC;
-	}
+	dev_dbg(&dev->pdev->dev, "Allocated %d MSI-X vectors\n", num_vecs);
+
+	dev->num_irq_vectors = num_vecs;
 
 	return 0;
 }
-- 
2.40.1


