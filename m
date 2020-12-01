Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC12C9D21
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbgLAJTd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 04:19:33 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:2852 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgLAJTS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 04:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606814358; x=1638350358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=myh7mB1Rd6SFZULOERKkD2JIURItOzgfX2lV6zE2+y8=;
  b=VI2uY4q9hmbMx/A9ToGWB9VRESU+WiQQ6cERQ+9Bi5HbA19qN7hNDO6+
   WrMWat7wVlv/zf8SIG+f64W36zr+sIjpPHXu/tE27UVMWF2WCUbMOfSGT
   xNz+fiAFH1NNf8BbB8RGBeXbMay3Pp2HiPFP14IKJLfP8bjnBi+hwWm7D
   c=;
X-IronPort-AV: E=Sophos;i="5.78,384,1599523200"; 
   d="scan'208";a="68254715"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-16425a8d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Dec 2020 09:18:27 +0000
Received: from EX13D13EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-16425a8d.us-east-1.amazon.com (Postfix) with ESMTPS id 171C7101067;
        Tue,  1 Dec 2020 09:18:25 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUB003.ant.amazon.com (10.43.166.55) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 09:18:24 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.17) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 09:18:20 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Use dma_set_mask_and_coherent to simplify code
Date:   Tue, 1 Dec 2020 11:18:11 +0200
Message-ID: <20201201091811.37984-1-galpress@amazon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use dma_set_mask_and_coherent() instead of pci_set_dma_mask() followed
by a pci_set_consistent_dma_mask().

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index cb2f2c647ee5..0f578734bddb 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -384,19 +384,12 @@ static int efa_device_init(struct efa_com_dev *edev, struct pci_dev *pdev)
 		return err;
 	}
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_width));
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_width));
 	if (err) {
-		dev_err(&pdev->dev, "pci_set_dma_mask failed %d\n", err);
+		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed %d\n", err);
 		return err;
 	}
 
-	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(dma_width));
-	if (err) {
-		dev_err(&pdev->dev,
-			"err_pci_set_consistent_dma_mask failed %d\n",
-			err);
-		return err;
-	}
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 	return 0;
 }

base-commit: dd37d2f59eb839d51b988f6668ce5f0d533b23fd
-- 
2.29.2

