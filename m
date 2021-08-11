Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28923E944B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhHKPNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 11:13:13 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23824 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhHKPNL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Aug 2021 11:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628694768; x=1660230768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUilMmo0sQUNdAun7MkBkFo03LtjLFGU6kVPIhBZT44=;
  b=VTj7KG+NVBvdzewM3USzUohHUK/PhDmss7Lr5CxuILX831ovFDVeWMYA
   xtmjIm3q57KNxLsES6jvrSZUcB3jhYIXJ0FtlbvRU7RbsRdL8HlxO5G2X
   ltAD5H9BHqBxLtZlO3EG/wF9O/H82Hs1jy9YWuW1RYEJjyOiXtsVqUXe6
   c=;
X-IronPort-AV: E=Sophos;i="5.84,313,1620691200"; 
   d="scan'208";a="133210799"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 11 Aug 2021 15:12:40 +0000
Received: from EX13D02EUC004.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 84640A07DC;
        Wed, 11 Aug 2021 15:12:38 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 11 Aug 2021 15:12:37 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Wed, 11 Aug 2021 15:12:35 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 2/4] RDMA/efa: Remove unused cpu field from irq struct
Date:   Wed, 11 Aug 2021 18:11:29 +0300
Message-ID: <20210811151131.39138-3-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151131.39138-1-galpress@amazon.com>
References: <20210811151131.39138-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The cpu field in efa_irq struct is unused, remove it.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h      | 3 +--
 drivers/infiniband/hw/efa/efa_main.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 1a1e60eee1dc..1148b308d3f6 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_H_
@@ -27,7 +27,6 @@
 struct efa_irq {
 	irq_handler_t handler;
 	void *data;
-	int cpu;
 	u32 vector;
 	cpumask_t affinity_hint_mask;
 	char name[EFA_IRQNAME_SIZE];
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 42f9ac3f586e..5b2fcfe9be20 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -109,7 +109,6 @@ static void efa_setup_mgmnt_irq(struct efa_dev *dev)
 	dev->admin_irq.vector =
 		pci_irq_vector(dev->pdev, dev->admin_msix_vector_idx);
 	cpu = cpumask_first(cpu_online_mask);
-	dev->admin_irq.cpu = cpu;
 	cpumask_set_cpu(cpu,
 			&dev->admin_irq.affinity_hint_mask);
 	dev_info(&dev->pdev->dev, "Setup irq:0x%p vector:%d name:%s\n",
-- 
2.32.0

