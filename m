Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CC2BA028
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgKTCFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 21:05:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7956 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 21:05:40 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CcfyY41yqzhc1f;
        Fri, 20 Nov 2020 10:05:25 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 10:05:27 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <wangxiongfeng2@huawei.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] IB/mthca: fix return value of error branch in mthca_init_cq()
Date:   Fri, 20 Nov 2020 09:57:02 +0800
Message-ID: <1605837422-42724-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We return 'err' in the error branch, but this variable may be set as
zero by the above code. Fix it by setting 'err'  as a negative value
before we goto the error label.

Fixes: 74c2174e7be5 ("IB uverbs: add mthca user CQ support")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/infiniband/hw/mthca/mthca_cq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index c3cfea2..119b257 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -803,8 +803,10 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
 	}
 
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
-	if (IS_ERR(mailbox))
+	if (IS_ERR(mailbox)) {
+		err = PTR_ERR(mailbox);
 		goto err_out_arm;
+	}
 
 	cq_context = mailbox->buf;
 
@@ -846,9 +848,9 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
 	}
 
 	spin_lock_irq(&dev->cq_table.lock);
-	if (mthca_array_set(&dev->cq_table.cq,
-			    cq->cqn & (dev->limits.num_cqs - 1),
-			    cq)) {
+	err = mthca_array_set(&dev->cq_table.cq,
+			      cq->cqn & (dev->limits.num_cqs - 1), cq);
+	if (err) {
 		spin_unlock_irq(&dev->cq_table.lock);
 		goto err_out_free_mr;
 	}
-- 
1.7.12.4

