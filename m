Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F14542F6B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiFHLqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiFHLqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 07:46:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6816CA7E06;
        Wed,  8 Jun 2022 04:46:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C971424;
        Wed,  8 Jun 2022 04:46:42 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A67B3F73B;
        Wed,  8 Jun 2022 04:46:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     benve@cisco.com, neescoba@cisco.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/usnic: Use device_iommu_capable()
Date:   Wed,  8 Jun 2022 12:46:33 +0100
Message-Id: <96ffe7050da0aa0ad6bce4705c3532f3ecaf32e3.1654688682.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the new interface to check the capability for our device
specifically.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index e212929369df..67a1b4562dc2 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -482,7 +482,7 @@ int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev)
 	if (err)
 		goto out_free_dev;
 
-	if (!iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY)) {
+	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		usnic_err("IOMMU of %s does not support cache coherency\n",
 				dev_name(dev));
 		err = -EINVAL;
-- 
2.36.1.dirty

