Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F535EEC30
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiI2C4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiI2C4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 22:56:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9039B851
        for <linux-rdma@vger.kernel.org>; Wed, 28 Sep 2022 19:56:12 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MdHxX6t5qzHqS3;
        Thu, 29 Sep 2022 10:53:52 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 10:56:10 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <benve@cisco.com>, <neescoba@cisco.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <roland@purestorage.com>, <umalhi@cisco.com>
CC:     <linux-rdma@vger.kernel.org>, <liwei391@huawei.com>,
        <zengheng4@huawei.com>
Subject: [PATCH -next] RDMA/usnic: fix set-but-not-unused variable 'flags' warning
Date:   Thu, 29 Sep 2022 11:12:00 +0800
Message-ID: <20220929031200.4060891-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove unused local variable 'flag'
without any logic changes.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 67a1b4562dc2..67923ced6e2d 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -95,7 +95,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	int ret;
 	int off;
 	int i;
-	int flags;
 	dma_addr_t pa;
 	unsigned int gup_flags;
 	struct mm_struct *mm;
@@ -132,8 +131,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 		goto out;
 	}
 
-	flags = IOMMU_READ | IOMMU_CACHE;
-	flags |= (writable) ? IOMMU_WRITE : 0;
 	gup_flags = FOLL_WRITE;
 	gup_flags |= (writable) ? 0 : FOLL_FORCE;
 	cur_base = addr & PAGE_MASK;
-- 
2.25.1

