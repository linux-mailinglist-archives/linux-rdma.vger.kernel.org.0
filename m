Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990CC7A3D6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfG3JRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:17:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbfG3JRK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:17:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80E1656ECD906174D696;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:45 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 03/13] RDMA/hns: Update the prompt message for creating and destroy qp
Date:   Tue, 30 Jul 2019 16:56:40 +0800
Message-ID: <1564477010-29804-4-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Current prompt message is uncorrect when destroying qp, add qpn
information when creating qp.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 83c58be..064e56c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4571,8 +4571,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
 		if (ret) {
-			dev_err(dev, "modify QP %06lx to ERR failed.\n",
-				hr_qp->qpn);
+			dev_err(dev, "modify QP to Reset failed.\n");
 			return ret;
 		}
 	}
@@ -4641,7 +4640,8 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret) {
-		dev_err(hr_dev->dev, "Destroy qp failed(%d)\n", ret);
+		dev_err(hr_dev->dev, "Destroy qp 0x%06lx failed(%d)\n",
+			hr_qp->qpn, ret);
 		return ret;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8b2d10f..c88a42d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1002,7 +1002,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, 0,
 						hr_qp);
 		if (ret) {
-			dev_err(dev, "Create RC QP failed\n");
+			dev_err(dev, "Create RC QP 0x%06lx failed(%d)\n",
+				hr_qp->qpn, ret);
 			kfree(hr_qp);
 			return ERR_PTR(ret);
 		}
-- 
1.9.1

