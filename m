Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C177B31DE
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjI2L6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjI2L6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 07:58:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FFCCA;
        Fri, 29 Sep 2023 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695988717; x=1727524717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JAXtYmb8T8PU8AF8jWO+axHjdebLbG0LfnuH9IHuvY=;
  b=GAnpoq3iHh+I2pUwv/fwODKvMJhUzPW+1maSmlkygudc9yPis5LhJu/I
   wes3TUzJrC5tDDl4EvBTT3gqwlYWUc/FIk+jh5MAQ0zgX0Td/Rgd2Zd50
   FtLWEnKLuWHlc32y5hUgjJylquRNB3vq0Y/NAXezO0ccSYf7WUNOFq+WB
   0VQ6hryeETspAJxS7M82GS2AShSLyfBkGhVF0HYPwHa1eVoQsZ/iheOe0
   wUObYpPct6Ve8y4562TeLRbXp2s7+n0rl7yXZ/xpbgqoZEJ8nDGciAWyq
   M+uDAIuNpl6t7k4cRVLx6N1Thk1KhYBZ5/658cN+RLvcIzZOsohoSDuig
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379552923"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="379552923"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="726573822"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="726573822"
Received: from valeks2x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 04:58:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 04/10] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Date:   Fri, 29 Sep 2023 14:57:17 +0300
Message-Id: <20230929115723.7864-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL2. In the
case of upstream (parent), the driver does not even own the device it's
changing the registers for.

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. This change is also useful as
a cleanup.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 08732e1ac966..4487a05bea04 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1212,14 +1212,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 		    (u32)lnkctl2);
 	/* only write to parent if target is not as high as ours */
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= target_vector;
-		dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-			    (u32)lnkctl2);
-		ret = pcie_capability_write_word(parent,
-						 PCI_EXP_LNKCTL2, lnkctl2);
+		ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+							 PCI_EXP_LNKCTL2_TLS,
+							 target_vector);
 		if (ret) {
-			dd_dev_err(dd, "Unable to write to PCI config\n");
+			dd_dev_err(dd, "Unable to change parent PCI target speed\n");
 			return_error = 1;
 			goto done;
 		}
@@ -1228,22 +1225,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
 	}
 
 	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
-	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
+	ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 target_vector);
 	if (ret) {
-		dd_dev_err(dd, "Unable to read from PCI config\n");
-		return_error = 1;
-		goto done;
-	}
-
-	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-	lnkctl2 |= target_vector;
-	dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
-		    (u32)lnkctl2);
-	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnkctl2);
-	if (ret) {
-		dd_dev_err(dd, "Unable to write to PCI config\n");
+		dd_dev_err(dd, "Unable to change device PCI target speed\n");
 		return_error = 1;
 		goto done;
 	}
-- 
2.30.2

