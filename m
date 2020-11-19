Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095B92B92C3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 13:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSMrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 07:47:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8374 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgKSMrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 07:47:18 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcKFH1lmrz70GF;
        Thu, 19 Nov 2020 20:46:59 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:47:07 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <wangxiongfeng2@huawei.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] IB/mthca: fix return value of error branch in mthca_init_cq()
Date:   Thu, 19 Nov 2020 20:38:49 +0800
Message-ID: <1605789529-54808-1-git-send-email-wangxiongfeng2@huawei.com>
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

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/infiniband/hw/mthca/mthca_cq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index c3cfea2..98d697b 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -803,8 +803,10 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
 	}
 
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
-	if (IS_ERR(mailbox))
+	if (IS_ERR(mailbox)) {
+		err = -ENOMEM;
 		goto err_out_arm;
+	}
 
 	cq_context = mailbox->buf;
 
@@ -850,6 +852,7 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
 			    cq->cqn & (dev->limits.num_cqs - 1),
 			    cq)) {
 		spin_unlock_irq(&dev->cq_table.lock);
+		err = -ENOMEM;
 		goto err_out_free_mr;
 	}
 	spin_unlock_irq(&dev->cq_table.lock);
-- 
1.7.12.4

