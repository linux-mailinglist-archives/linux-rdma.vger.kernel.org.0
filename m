Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94C4C1B25
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiBWSyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 13:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiBWSyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 13:54:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382983ED16;
        Wed, 23 Feb 2022 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645642421; x=1677178421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BY2ld0+/+u61k79diqAJ3V3d6w1uIuiecfjfbc6/FiM=;
  b=a4IB588Jpp1KgsXktwXCAc+JBpicHNJRoqv/n9MTl4XM/AZh4snRwA0W
   UdBvob97gCNVAKa3Ozv40iVdmoC0Tkx7BSp7Ady8a8QAVQMFNvcTOqYqR
   ecmvVgGh7MxOmqd5AAs2uLLVQ3yLNM1KMY8wF/13wFSh6AvAlzxMZUvlB
   09ht7RDFl2oNXS8hgTGuev/meYAFKnIFJDL54PmT+7utI/3vhh32RXI8P
   Y4PMa91XlwDJqu2NIKeNSnEK9Lo2u3xw9NVLgoX5qW3IDOoQGA471TUD5
   SvW2ZZjBJl+CxuRiMcaEZqNdG+NhSGUcS67dFAQI/AmIletSLg6wE0LIk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250883298"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="250883298"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="776784895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2022 10:53:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C865894; Wed, 23 Feb 2022 20:53:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Date:   Wed, 23 Feb 2022 20:53:53 +0200
Message-Id: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

While in this particular case it would not be a (critical) issue,
the pattern itself is bad and error prone in case somebody blindly
copies to their code.

Don't cast parameter to unsigned long pointer in the bit operations.
Instead copy to a local variable on stack of a proper type and use.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index f1245c94ae26..100274b926d3 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8286,34 +8286,33 @@ static void is_interrupt(struct hfi1_devdata *dd, unsigned int source)
 irqreturn_t general_interrupt(int irq, void *data)
 {
 	struct hfi1_devdata *dd = data;
-	u64 regs[CCE_NUM_INT_CSRS];
+	DECLARE_BITMAP(pending, CCE_NUM_INT_CSRS * 64);
+	u64 value;
 	u32 bit;
 	int i;
-	irqreturn_t handled = IRQ_NONE;
 
 	this_cpu_inc(*dd->int_counter);
 
 	/* phase 1: scan and clear all handled interrupts */
 	for (i = 0; i < CCE_NUM_INT_CSRS; i++) {
-		if (dd->gi_mask[i] == 0) {
-			regs[i] = 0;	/* used later */
-			continue;
-		}
-		regs[i] = read_csr(dd, CCE_INT_STATUS + (8 * i)) &
-				dd->gi_mask[i];
+		if (dd->gi_mask[i] == 0)
+			value = 0;	/* used later */
+		else
+			value = read_csr(dd, CCE_INT_STATUS + (8 * i)) & dd->gi_mask[i];
+
+		/* save for further use */
+		bitmap_from_u64(&pending[BITS_TO_LONGS(i * 64)], value);
+
 		/* only clear if anything is set */
-		if (regs[i])
-			write_csr(dd, CCE_INT_CLEAR + (8 * i), regs[i]);
+		if (value)
+			write_csr(dd, CCE_INT_CLEAR + (8 * i), value);
 	}
 
 	/* phase 2: call the appropriate handler */
-	for_each_set_bit(bit, (unsigned long *)&regs[0],
-			 CCE_NUM_INT_CSRS * 64) {
+	for_each_set_bit(bit, pending, CCE_NUM_INT_CSRS * 64)
 		is_interrupt(dd, bit);
-		handled = IRQ_HANDLED;
-	}
 
-	return handled;
+	return IRQ_RETVAL(!bitmap_empty(pending, CCE_NUM_INT_CSRS * 64));
 }
 
 irqreturn_t sdma_interrupt(int irq, void *data)
-- 
2.34.1

