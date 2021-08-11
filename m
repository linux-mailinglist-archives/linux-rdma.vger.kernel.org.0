Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E883E944C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhHKPNN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 11:13:13 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:4605 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhHKPNK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Aug 2021 11:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628694768; x=1660230768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0IxpAeJmDs7VAznGjulWQvvFCJXpZa8y4P5kq9CSImI=;
  b=wIG0lcBLkR0gjknQbvN5Nx9hAz0aPrBDn2rqQuGjjvI8sh3UQGZAGWF+
   2xbJFtGFA4oBp+XaPOvas6e0J0JpZULfCKtqFnxYoJGrqebGuGCgaZ71x
   bxd2St4J6b94jGY4fubUqgk7VaYUnoif5ak2Cywk6p+gKUehvG+JdIs/y
   A=;
X-IronPort-AV: E=Sophos;i="5.84,313,1620691200"; 
   d="scan'208";a="128755113"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 11 Aug 2021 15:12:38 +0000
Received: from EX13D13EUB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id A942CC01B1;
        Wed, 11 Aug 2021 15:12:35 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 11 Aug 2021 15:12:34 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Wed, 11 Aug 2021 15:12:31 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/4] RDMA/efa: Free IRQ vectors on error flow
Date:   Wed, 11 Aug 2021 18:11:28 +0300
Message-ID: <20210811151131.39138-2-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151131.39138-1-galpress@amazon.com>
References: <20210811151131.39138-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to free the IRQ vectors in case the allocation doesn't return
the expected number of IRQs.

Fixes: b7f5e880f377 ("RDMA/efa: Add the efa module")
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 997947d77de6..42f9ac3f586e 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -358,6 +358,7 @@ static int efa_enable_msix(struct efa_dev *dev)
 	}
 
 	if (irq_num != msix_vecs) {
+		efa_disable_msix(dev);
 		dev_err(&dev->pdev->dev,
 			"Allocated %d MSI-X (out of %d requested)\n",
 			irq_num, msix_vecs);
-- 
2.32.0

