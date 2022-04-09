Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298004FA606
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiDIIfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 04:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiDIIfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 04:35:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CCD2FFDC
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 01:33:34 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb7fk2nwRz1HBbS;
        Sat,  9 Apr 2022 16:33:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Init the variable at the suitable place
Date:   Sat, 9 Apr 2022 16:32:54 +0800
Message-ID: <20220409083254.9696-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220409083254.9696-1-liangwenpeng@huawei.com>
References: <20220409083254.9696-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

Assigning a value to ret in the init statement of a for-loop makes the code
less readable.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5d6da396586d..2abed0e3dfd8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1296,7 +1296,8 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	} while (++timeout < priv->cmq.tx_timeout);
 
 	if (hns_roce_cmq_csq_done(hr_dev)) {
-		for (ret = 0, i = 0; i < num; i++) {
+		ret = 0;
+		for (i = 0; i < num; i++) {
 			/* check the result of hardware write back */
 			desc[i] = csq->desc[tail++];
 			if (tail == csq->desc_num)
-- 
2.33.0

