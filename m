Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F96397217
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhFALJ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 07:09:59 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:7433 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231726AbhFALJ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 07:09:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uaw9rV6_1622545681;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uaw9rV6_1622545681)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Jun 2021 19:08:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bharat@chelsio.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] RDMA/cxgb4: Fix missing error code in create_qp()
Date:   Tue,  1 Jun 2021 19:07:49 +0800
Message-Id: <1622545669-20625-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/infiniband/hw/cxgb4/qp.c:298 create_qp() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d109bb3..c940374 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -295,6 +295,7 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 	if (user && (!wq->sq.bar2_pa || (need_rq && !wq->rq.bar2_pa))) {
 		pr_warn("%s: sqid %u or rqid %u not in BAR2 range\n",
 			pci_name(rdev->lldi.pdev), wq->sq.qid, wq->rq.qid);
+		ret = -EINVAL;
 		goto free_dma;
 	}
 
-- 
1.8.3.1

