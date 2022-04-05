Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9704F5196
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 04:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442358AbiDFCFo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Apr 2022 22:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449825AbiDEPup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Apr 2022 11:50:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2C01107833;
        Tue,  5 Apr 2022 07:36:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EF623A;
        Tue,  5 Apr 2022 07:36:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C05F63F5A1;
        Tue,  5 Apr 2022 07:36:04 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     benve@cisco.com, neescoba@cisco.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Date:   Tue,  5 Apr 2022 15:35:59 +0100
Message-Id: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
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

Rather than hard-coding pci_bus_type, pass the PF device through to
usnic_uiom_alloc_pd() and retrieve its bus there. This prepares for
iommu_domain_alloc() changing to take a device rather than a bus_type.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 3 +--
 drivers/infiniband/hw/usnic/usnic_uiom.c     | 5 ++---
 drivers/infiniband/hw/usnic/usnic_uiom.h     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index d3a9670bf971..06aae6a79c3d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -442,7 +442,7 @@ int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct usnic_ib_pd *pd = to_upd(ibpd);
 
-	pd->umem_pd = usnic_uiom_alloc_pd();
+	pd->umem_pd = usnic_uiom_alloc_pd(ibpd->device->dev.parent);
 	if (IS_ERR(pd->umem_pd))
 		return PTR_ERR(pd->umem_pd);
 
@@ -706,4 +706,3 @@ int usnic_ib_mmap(struct ib_ucontext *context,
 	usnic_err("No VF %u found\n", vfid);
 	return -EINVAL;
 }
-
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 8c48027614a1..e212929369df 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -40,7 +40,6 @@
 #include <linux/iommu.h>
 #include <linux/workqueue.h>
 #include <linux/list.h>
-#include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 
 #include "usnic_log.h"
@@ -439,7 +438,7 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr)
 	__usnic_uiom_release_tail(uiomr);
 }
 
-struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
+struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev)
 {
 	struct usnic_uiom_pd *pd;
 	void *domain;
@@ -448,7 +447,7 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->domain = domain = iommu_domain_alloc(&pci_bus_type);
+	pd->domain = domain = iommu_domain_alloc(dev->bus);
 	if (!domain) {
 		usnic_err("Failed to allocate IOMMU domain");
 		kfree(pd);
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 9407522179e9..5a9acf941510 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -80,7 +80,7 @@ struct usnic_uiom_chunk {
 	struct scatterlist		page_list[];
 };
 
-struct usnic_uiom_pd *usnic_uiom_alloc_pd(void);
+struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev);
 void usnic_uiom_dealloc_pd(struct usnic_uiom_pd *pd);
 int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev);
 void usnic_uiom_detach_dev_from_pd(struct usnic_uiom_pd *pd,
-- 
2.28.0.dirty

