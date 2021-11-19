Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4C457042
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhKSOJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:45 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28159 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hwdhk1MYHz8vRj;
        Fri, 19 Nov 2021 22:04:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:39 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Correct the print format to be consistent with the variable type
Date:   Fri, 19 Nov 2021 22:02:01 +0800
Message-ID: <20211119140208.40416-3-liangwenpeng@huawei.com>
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

From: Xinhao Liu <liuxinhao5@hisilicon.com>

The print format should be consistent with variant type.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1c3307d57b06..42bbb4278273 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1302,7 +1302,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	} else {
 		/* FW/HW reset or incorrect number of desc */
 		tail = roce_read(hr_dev, ROCEE_TX_CMQ_CI_REG);
-		dev_warn(hr_dev->dev, "CMDQ move tail from %d to %d\n",
+		dev_warn(hr_dev->dev, "CMDQ move tail from %u to %u.\n",
 			 csq->head, tail);
 		csq->head = tail;
 
@@ -4723,7 +4723,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
 	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
 		ibdev_err(ibdev,
-			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
+			  "failed to fill QPC, sl (%u) shouldn't be larger than %d.\n",
 			  hr_qp->sl, MAX_SERVICE_LEVEL);
 		return -EINVAL;
 	}
@@ -5831,7 +5831,7 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, int eqn)
 					0, HNS_ROCE_CMD_DESTROY_AEQC,
 					HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
-		dev_err(dev, "[mailbox cmd] destroy eqc(%d) failed.\n", eqn);
+		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
 }
 
 static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
-- 
2.33.0

