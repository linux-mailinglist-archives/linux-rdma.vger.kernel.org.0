Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5546A457045
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhKSOJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27147 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hwdgy5Ry0z1DJ0t;
        Fri, 19 Nov 2021 22:04:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Initialize variable in the right place
Date:   Fri, 19 Nov 2021 22:02:04 +0800
Message-ID: <20211119140208.40416-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

The "ret" should be initialized when it is defined instead of in the loop.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ae4f6fa8ad71..556d79fb2352 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1260,8 +1260,8 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
 	u32 timeout = 0;
 	u16 desc_ret;
+	int ret = 0;
 	u32 tail;
-	int ret;
 	int i;
 
 	spin_lock_bh(&csq->lock);
@@ -1284,7 +1284,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	} while (++timeout < priv->cmq.tx_timeout);
 
 	if (hns_roce_cmq_csq_done(hr_dev)) {
-		for (ret = 0, i = 0; i < num; i++) {
+		for (i = 0; i < num; i++) {
 			/* check the result of hardware write back */
 			desc[i] = csq->desc[tail++];
 			if (tail == csq->desc_num)
-- 
2.33.0

