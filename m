Return-Path: <linux-rdma+bounces-531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668F822F56
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D2E2865C5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C41A58F;
	Wed,  3 Jan 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kub1/TQR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B61A587
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704291705; x=1735827705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bVX98ceQrlc6JVx1RjbrlLg1twATb2VOORHa9cfkHOE=;
  b=kub1/TQRcbJtLRwesB+1u3yetaoKMFo/Ctdy9yXMUb2IvNJ4KIe03ddK
   s7xByfhmBWP9O0eu+WWp+F+0ez8rthfV4NqlIviFdw6Y1pjnqvasoJMzP
   wFTBn6wjIxIduD+qc6m/qAcHtKfUz4PvIaE696I9ZSugb2GHRMibhZYSG
   A=;
X-IronPort-AV: E=Sophos;i="6.04,327,1695686400"; 
   d="scan'208";a="625439508"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:21:42 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id AE1BDA127D;
	Wed,  3 Jan 2024 14:21:40 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:41539]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.199:2525] with esmtp (Farcaster)
 id 0ff18dfa-d783-427f-8133-b8fbca7f5a00; Wed, 3 Jan 2024 14:21:39 +0000 (UTC)
X-Farcaster-Flow-ID: 0ff18dfa-d783-427f-8133-b8fbca7f5a00
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 14:21:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 14:21:36 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Wed, 3 Jan 2024 14:21:34 +0000
From: <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>, Michael Margolin <mrgolin@amazon.com>,
	"Yonatan Goldhirsh" <ygold@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Limit EQs to available MSI-X vectors
Date: Wed, 3 Jan 2024 14:21:34 +0000
Message-ID: <20240103142134.2191-1-ynachum@amazon.com>
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
 drivers/infiniband/hw/efa/efa.h      |  3 ++-
 drivers/infiniband/hw/efa/efa_main.c | 32 +++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 7352a1f5d811..a17045e100cd 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -57,6 +57,7 @@ struct efa_dev {
 	u64 db_bar_addr;
 	u64 db_bar_len;
 
+	unsigned int num_irq_vectors;
 	int admin_msix_vector_idx;
 	struct efa_irq admin_irq;
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 15ee92081118..1aade398c723 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -319,7 +319,9 @@ static int efa_create_eqs(struct efa_dev *dev)
 	int err;
 	int i;
 
-	neqs = min_t(unsigned int, neqs, num_online_cpus());
+	neqs = min_t(unsigned int, neqs,
+		     dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
+
 	dev->neqs = neqs;
 	dev->eqs = kcalloc(neqs, sizeof(*dev->eqs), GFP_KERNEL);
 	if (!dev->eqs)
@@ -463,34 +465,30 @@ static void efa_disable_msix(struct efa_dev *dev)
 
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


