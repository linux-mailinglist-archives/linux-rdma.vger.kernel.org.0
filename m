Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0D87700C0
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjHDNFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHDNFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 09:05:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CD49C1
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 06:05:00 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHQnX1DKGztRn6;
        Fri,  4 Aug 2023 21:01:04 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 21:04:27 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <xuhaoyue1@hisilicon.com>, <huangjunxian6@hisilicon.com>,
        <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: Remove unused declaration hns_roce_modify_srq()
Date:   Fri, 4 Aug 2023 21:04:18 +0800
Message-ID: <20230804130418.41728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
declared but never implemented this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 34e099efaae3..4dd6437ca410 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1159,9 +1159,6 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 int hns_roce_create_srq(struct ib_srq *srq,
 			struct ib_srq_init_attr *srq_init_attr,
 			struct ib_udata *udata);
-int hns_roce_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
-			enum ib_srq_attr_mask srq_attr_mask,
-			struct ib_udata *udata);
 int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 
 int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata);
-- 
2.34.1

