Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B373B16BFC4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgBYLko (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 06:40:44 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:33133 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLko (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 06:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630843; x=1614166843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JtB15nkNm/JfnHDX0NfiLAr8r+j5/rA9lAkmKP/4IIs=;
  b=muQV/hufKtVMVbSrLXxcWQYemgEGhqvtJW71AsEsB0E8iDvxbgtyJEoF
   eutgCTmmeWh6RX56DqUZlLMzmJwlqZBRkJDeHgkYPWJpDe2d9NZQqe56r
   yzG4cfXIf7M/hhK4093AzDKivND7ZwKzbxhmXq50ADXB2fj0j8VoIva6d
   Y=;
IronPort-SDR: wTy141u5qix0Jhw0V9DxlMUsS55EymxSjgrXvwfuMGDhFa+qj/Wd7V+wQHVhx3Z1EjM0Ch+Z0N
 PM1yO93JWUoQ==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="19535692"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Feb 2020 11:40:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 44513C5F4D;
        Tue, 25 Feb 2020 11:40:29 +0000 (UTC)
Received: from EX13D02EUB002.ant.amazon.com (10.43.166.170) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:40:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUB002.ant.amazon.com (10.43.166.170) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 11:40:28 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1236.3 via Frontend Transport; Tue, 25 Feb 2020 11:40:25 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next v2 2/3] RDMA/efa: Properly document the interrupt mask register
Date:   Tue, 25 Feb 2020 13:40:09 +0200
Message-ID: <20200225114010.21790-3-galpress@amazon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200225114010.21790-1-galpress@amazon.com>
References: <20200225114010.21790-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The fact that the LSB in the register is the enable bit should not be an
implicit assumption between the driver and the device, properly document
that in the register definition.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c       | 4 +---
 drivers/infiniband/hw/efa/efa_regs_defs.h | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 00904c9b2ccb..b962cc6be1cd 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -23,8 +23,6 @@
 #define EFA_DMA_ADDR_TO_UINT32_LOW(x)   ((u32)((u64)(x)))
 #define EFA_DMA_ADDR_TO_UINT32_HIGH(x)  ((u32)(((u64)(x)) >> 32))
 
-#define EFA_REGS_ADMIN_INTR_MASK 1
-
 enum efa_cmd_status {
 	EFA_CMD_SUBMITTED,
 	EFA_CMD_COMPLETED,
@@ -689,7 +687,7 @@ void efa_com_set_admin_polling_mode(struct efa_com_dev *edev, bool polling)
 	u32 mask_value = 0;
 
 	if (polling)
-		mask_value = EFA_REGS_ADMIN_INTR_MASK;
+		EFA_SET(&mask_value, EFA_REGS_INTR_MASK_EN, 1);
 
 	writel(mask_value, edev->reg_bar + EFA_REGS_INTR_MASK_OFF);
 	if (polling)
diff --git a/drivers/infiniband/hw/efa/efa_regs_defs.h b/drivers/infiniband/hw/efa/efa_regs_defs.h
index 322a2c0d4ef9..4017982fe13b 100644
--- a/drivers/infiniband/hw/efa/efa_regs_defs.h
+++ b/drivers/infiniband/hw/efa/efa_regs_defs.h
@@ -73,6 +73,9 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK             0xff0000
 #define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK            0xff000000
 
+/* intr_mask register */
+#define EFA_REGS_INTR_MASK_EN_MASK                          0x1
+
 /* dev_ctl register */
 #define EFA_REGS_DEV_CTL_DEV_RESET_MASK                     0x1
 #define EFA_REGS_DEV_CTL_AQ_RESTART_MASK                    0x2
-- 
2.25.0

