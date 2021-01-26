Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E2303C91
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392318AbhAZMI7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:08:59 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61527 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392140AbhAZMIy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611662934; x=1643198934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBtiNDjxKiihhp5r8Z+LWpPNb81qCJGf33noUEkSkvo=;
  b=loMpqqf3DHu2dKisqJZE7SqSh64owEaKj4u614y78E2FI6xvvsrc+s61
   2Sy9SpBjC5/q7tum1Ev99AWQ4FS7uXhjifGyxZb+em9zg1njBQGwgCIL6
   Cz1dMp5/QuyjzH+Zck0GtAXpxyB/XmUWonWgxBE7VOB0VSShmJQxS7Pjs
   g=;
X-IronPort-AV: E=Sophos;i="5.79,375,1602547200"; 
   d="scan'208";a="113544935"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 26 Jan 2021 12:08:07 +0000
Received: from EX13D13EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id C7274A1F25;
        Tue, 26 Jan 2021 12:08:05 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 Jan 2021 12:08:03 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.21) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 12:08:01 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 2/5] RDMA/efa: Remove duplication of upper/lower_32_bits
Date:   Tue, 26 Jan 2021 14:06:58 +0200
Message-ID: <20210126120702.9807-3-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
References: <20210126120702.9807-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The EFA_DMA_ADDR_TO_UINT32_HIGH/LOW macros are the same as the kernel's
upper/lower_32_bits, remove them and use kernel macros instead.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 747efc794cc0..0d523ad736c7 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -20,9 +20,6 @@
 #define EFA_CTRL_MINOR          0
 #define EFA_CTRL_SUB_MINOR      1
 
-#define EFA_DMA_ADDR_TO_UINT32_LOW(x)   ((u32)((u64)(x)))
-#define EFA_DMA_ADDR_TO_UINT32_HIGH(x)  ((u32)(((u64)(x)) >> 32))
-
 enum efa_cmd_status {
 	EFA_CMD_SUBMITTED,
 	EFA_CMD_COMPLETED,
@@ -138,8 +135,8 @@ static int efa_com_admin_init_sq(struct efa_com_dev *edev)
 
 	sq->db_addr = (u32 __iomem *)(edev->reg_bar + EFA_REGS_AQ_PROD_DB_OFF);
 
-	addr_high = EFA_DMA_ADDR_TO_UINT32_HIGH(sq->dma_addr);
-	addr_low = EFA_DMA_ADDR_TO_UINT32_LOW(sq->dma_addr);
+	addr_high = upper_32_bits(sq->dma_addr);
+	addr_low = lower_32_bits(sq->dma_addr);
 
 	writel(addr_low, edev->reg_bar + EFA_REGS_AQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_AQ_BASE_HI_OFF);
@@ -172,8 +169,8 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
 	cq->cc = 0;
 	cq->phase = 1;
 
-	addr_high = EFA_DMA_ADDR_TO_UINT32_HIGH(cq->dma_addr);
-	addr_low = EFA_DMA_ADDR_TO_UINT32_LOW(cq->dma_addr);
+	addr_high = upper_32_bits(cq->dma_addr);
+	addr_low = lower_32_bits(cq->dma_addr);
 
 	writel(addr_low, edev->reg_bar + EFA_REGS_ACQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_ACQ_BASE_HI_OFF);
@@ -213,8 +210,8 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
 	aenq->cc = 0;
 	aenq->phase = 1;
 
-	addr_low = EFA_DMA_ADDR_TO_UINT32_LOW(aenq->dma_addr);
-	addr_high = EFA_DMA_ADDR_TO_UINT32_HIGH(aenq->dma_addr);
+	addr_low = lower_32_bits(aenq->dma_addr);
+	addr_high = upper_32_bits(aenq->dma_addr);
 
 	writel(addr_low, edev->reg_bar + EFA_REGS_AENQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_AENQ_BASE_HI_OFF);
-- 
2.30.0

