Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9594F3EF9
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 22:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiDENyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Apr 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387456AbiDENPN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Apr 2022 09:15:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB3512BF9F;
        Tue,  5 Apr 2022 05:20:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6BDBD6E;
        Tue,  5 Apr 2022 05:20:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 014163F5A1;
        Tue,  5 Apr 2022 05:20:02 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     benve@cisco.com, neescoba@cisco.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/usnic: Stop using iommu_present()
Date:   Tue,  5 Apr 2022 13:19:59 +0100
Message-Id: <f707b4248e1d33b6d2c7f1d7c94febb802cf9890.1649161199.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device(s)
we care about. Replace iommu_present() with a more appropriate check at
probe time, and garbage-collect the resulting empty init function.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c | 11 +++++------
 drivers/infiniband/hw/usnic/usnic_uiom.c    | 10 ----------
 drivers/infiniband/hw/usnic/usnic_uiom.h    |  1 -
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index d346dd48e731..46653ad56f5a 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -534,6 +534,11 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
 	struct usnic_ib_vf *vf;
 	enum usnic_vnic_res_type res_type;
 
+	if (!device_iommu_mapped(&pdev->dev)) {
+		usnic_err("IOMMU required but not present or enabled.  USNIC QPs will not function w/o enabling IOMMU\n");
+		return -EPERM;
+	}
+
 	vf = kzalloc(sizeof(*vf), GFP_KERNEL);
 	if (!vf)
 		return -ENOMEM;
@@ -642,12 +647,6 @@ static int __init usnic_ib_init(void)
 
 	printk_once(KERN_INFO "%s", usnic_version);
 
-	err = usnic_uiom_init(DRV_NAME);
-	if (err) {
-		usnic_err("Unable to initialize umem with err %d\n", err);
-		return err;
-	}
-
 	err = pci_register_driver(&usnic_ib_pci_driver);
 	if (err) {
 		usnic_err("Unable to register with PCI\n");
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 760b254ba42d..8c48027614a1 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -556,13 +556,3 @@ void usnic_uiom_free_dev_list(struct device **devs)
 {
 	kfree(devs);
 }
-
-int usnic_uiom_init(char *drv_name)
-{
-	if (!iommu_present(&pci_bus_type)) {
-		usnic_err("IOMMU required but not present or enabled.  USNIC QPs will not function w/o enabling IOMMU\n");
-		return -EPERM;
-	}
-
-	return 0;
-}
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 7ec8991ace67..9407522179e9 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -91,5 +91,4 @@ struct usnic_uiom_reg *usnic_uiom_reg_get(struct usnic_uiom_pd *pd,
 						unsigned long addr, size_t size,
 						int access, int dmasync);
 void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr);
-int usnic_uiom_init(char *drv_name);
 #endif /* USNIC_UIOM_H_ */
-- 
2.28.0.dirty

