Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5634767FDE3
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jan 2023 10:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjA2JiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Jan 2023 04:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjA2JiI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Jan 2023 04:38:08 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DF1027E
        for <linux-rdma@vger.kernel.org>; Sun, 29 Jan 2023 01:38:06 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P4R5H5RzTz16N2W;
        Sun, 29 Jan 2023 17:36:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 29 Jan
 2023 17:38:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <benve@cisco.com>, <neescoba@cisco.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <umalhi@cisco.com>, <roland@purestorage.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH] RDMA/usnic: use iommu_map_atomic() under spin_lock()
Date:   Sun, 29 Jan 2023 17:37:57 +0800
Message-ID: <20230129093757.637354-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

usnic_uiom_map_sorted_intervals() is called under spin_lock(), iommu_map()
might sleep, use iommu_map_atomic() to avoid potential sleep in atomic
context.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index c301b3be9f30..a2857accc427 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -276,8 +276,8 @@ static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
 				size = pa_end - pa_start + PAGE_SIZE;
 				usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x",
 					va_start, &pa_start, size, flags);
-				err = iommu_map(pd->domain, va_start, pa_start,
-							size, flags);
+				err = iommu_map_atomic(pd->domain, va_start,
+						       pa_start, size, flags);
 				if (err) {
 					usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
 						va_start, &pa_start, size, err);
@@ -293,8 +293,8 @@ static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
 				size = pa - pa_start + PAGE_SIZE;
 				usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x\n",
 					va_start, &pa_start, size, flags);
-				err = iommu_map(pd->domain, va_start, pa_start,
-						size, flags);
+				err = iommu_map_atomic(pd->domain, va_start,
+						       pa_start, size, flags);
 				if (err) {
 					usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
 						va_start, &pa_start, size, err);
-- 
2.25.1

