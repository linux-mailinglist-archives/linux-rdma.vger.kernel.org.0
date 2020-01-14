Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8873513A354
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANI5g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:36 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:45185 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992255; x=1610528255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=adXI+I+J6Nqm/LKE9XJSjoWXzId4ORrsgPL0F+Yr6aY=;
  b=aV/negIu6P1CW6JeORlu5jwNx+n7gMkH0YHCB4JNKBQJbq5E2Fs0vZR9
   o+3beHxvzKhEIzvkhEuvDzPf64IMl22NyI2ON/fVJV8A52ogyM+QZino8
   BNvtm1pO/h27AVw9PUX3Mj+58xQspXpKpup+W/OXgN2WAUydq1aiNWnJY
   E=;
IronPort-SDR: JnhfhH2tgpftgUo47G4Ph7+c5DNVOVMrUnGAmdCwR8y2nVHw1t86mLJqZmiYud7pPwkzYqLhf1
 1t8sGAU6/EqQ==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="10165929"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 14 Jan 2020 08:57:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 9771224A5F3;
        Tue, 14 Jan 2020 08:57:22 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:21 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:20 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:18 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 2/6] RDMA/efa: Properly document the interrupt mask register
Date:   Tue, 14 Jan 2020 10:57:02 +0200
Message-ID: <20200114085706.82229-3-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
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
 drivers/infiniband/hw/efa/efa_regs_defs.h | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 5dd5e429c15c..8622b34705c5 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -34,8 +34,6 @@
 #define EFA_DMA_ADDR_TO_UINT32_LOW(x)   ((u32)((u64)(x)))
 #define EFA_DMA_ADDR_TO_UINT32_HIGH(x)  ((u32)(((u64)(x)) >> 32))
 
-#define EFA_REGS_ADMIN_INTR_MASK 1
-
 enum efa_cmd_status {
 	EFA_CMD_SUBMITTED,
 	EFA_CMD_COMPLETED,
@@ -700,7 +698,7 @@ void efa_com_set_admin_polling_mode(struct efa_com_dev *edev, bool polling)
 	u32 mask_value = 0;
 
 	if (polling)
-		mask_value = EFA_REGS_ADMIN_INTR_MASK;
+		EFA_SET(&mask_value, EFA_REGS_INTR_MASK_EN, 1);
 
 	writel(mask_value, edev->reg_bar + EFA_REGS_INTR_MASK_OFF);
 	if (polling)
diff --git a/drivers/infiniband/hw/efa/efa_regs_defs.h b/drivers/infiniband/hw/efa/efa_regs_defs.h
index b3119ed8d9b2..48a72c507224 100644
--- a/drivers/infiniband/hw/efa/efa_regs_defs.h
+++ b/drivers/infiniband/hw/efa/efa_regs_defs.h
@@ -91,6 +91,10 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_SHIFT           24
 #define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK            0xff000000
 
+/* intr_mask register */
+#define EFA_REGS_INTR_MASK_EN_SHIFT                         0
+#define EFA_REGS_INTR_MASK_EN_MASK                          0x1
+
 /* dev_ctl register */
 #define EFA_REGS_DEV_CTL_DEV_RESET_SHIFT                    0
 #define EFA_REGS_DEV_CTL_DEV_RESET_MASK                     0x1
-- 
2.24.1

