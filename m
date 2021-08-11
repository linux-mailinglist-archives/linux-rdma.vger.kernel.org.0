Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F33E944D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhHKPNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 11:13:13 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:25160 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhHKPNN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Aug 2021 11:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628694769; x=1660230769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HiWdvnOuicCk9FNTzMD9lpRsyTXUJRgnFPcs4QdDbaQ=;
  b=Z/6g52yQDtzddFdcJfNDoahoUlOUdSxXXzP92t48gt4ClFiYivacDTiE
   LbRVTvlWVw1CpiQ8SeY+bPNvpv0wTTv9HWhea7Lngnol5lqNv68EsANAB
   tjOUknfCJgGqrLfxXsFRgdUfsu4kLoO4EOHOB5rlyj/uLhRNV6dRpCemc
   4=;
X-IronPort-AV: E=Sophos;i="5.84,313,1620691200"; 
   d="scan'208";a="18574463"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 11 Aug 2021 15:12:42 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 71095A256C;
        Wed, 11 Aug 2021 15:12:42 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 11 Aug 2021 15:12:41 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Wed, 11 Aug 2021 15:12:38 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 3/4] RDMA/efa: Rename vector field in efa_irq struct to irqn
Date:   Wed, 11 Aug 2021 18:11:30 +0300
Message-ID: <20210811151131.39138-4-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151131.39138-1-galpress@amazon.com>
References: <20210811151131.39138-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The vector field naming is quite confusing, it is better referred to as
irqn.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h      |  2 +-
 drivers/infiniband/hw/efa/efa_main.c | 18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 1148b308d3f6..87b1dadeb7fe 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -27,7 +27,7 @@
 struct efa_irq {
 	irq_handler_t handler;
 	void *data;
-	u32 vector;
+	u32 irqn;
 	cpumask_t affinity_hint_mask;
 	char name[EFA_IRQNAME_SIZE];
 };
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 5b2fcfe9be20..417dea5f90cf 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -83,8 +83,7 @@ static int efa_request_mgmnt_irq(struct efa_dev *dev)
 	int err;
 
 	irq = &dev->admin_irq;
-	err = request_irq(irq->vector, irq->handler, 0, irq->name,
-			  irq->data);
+	err = request_irq(irq->irqn, irq->handler, 0, irq->name, irq->data);
 	if (err) {
 		dev_err(&dev->pdev->dev, "Failed to request admin irq (%d)\n",
 			err);
@@ -92,8 +91,8 @@ static int efa_request_mgmnt_irq(struct efa_dev *dev)
 	}
 
 	dev_dbg(&dev->pdev->dev, "Set affinity hint of mgmnt irq to %*pbl (irq vector: %d)\n",
-		nr_cpumask_bits, &irq->affinity_hint_mask, irq->vector);
-	irq_set_affinity_hint(irq->vector, &irq->affinity_hint_mask);
+		nr_cpumask_bits, &irq->affinity_hint_mask, irq->irqn);
+	irq_set_affinity_hint(irq->irqn, &irq->affinity_hint_mask);
 
 	return 0;
 }
@@ -106,14 +105,13 @@ static void efa_setup_mgmnt_irq(struct efa_dev *dev)
 		 "efa-mgmnt@pci:%s", pci_name(dev->pdev));
 	dev->admin_irq.handler = efa_intr_msix_mgmnt;
 	dev->admin_irq.data = dev;
-	dev->admin_irq.vector =
+	dev->admin_irq.irqn =
 		pci_irq_vector(dev->pdev, dev->admin_msix_vector_idx);
 	cpu = cpumask_first(cpu_online_mask);
 	cpumask_set_cpu(cpu,
 			&dev->admin_irq.affinity_hint_mask);
-	dev_info(&dev->pdev->dev, "Setup irq:0x%p vector:%d name:%s\n",
-		 &dev->admin_irq,
-		 dev->admin_irq.vector,
+	dev_info(&dev->pdev->dev, "Setup irq:%d name:%s\n",
+		 dev->admin_irq.irqn,
 		 dev->admin_irq.name);
 }
 
@@ -122,8 +120,8 @@ static void efa_free_mgmnt_irq(struct efa_dev *dev)
 	struct efa_irq *irq;
 
 	irq = &dev->admin_irq;
-	irq_set_affinity_hint(irq->vector, NULL);
-	free_irq(irq->vector, irq->data);
+	irq_set_affinity_hint(irq->irqn, NULL);
+	free_irq(irq->irqn, irq->data);
 }
 
 static int efa_set_mgmnt_irq(struct efa_dev *dev)
-- 
2.32.0

