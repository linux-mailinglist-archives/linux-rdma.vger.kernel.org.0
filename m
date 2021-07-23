Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C73D38C3
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhGWJwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 05:52:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:54275 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhGWJwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 05:52:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ugi2esO_1627036381;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ugi2esO_1627036381)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Jul 2021 18:33:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mustafa.ismail@intel.com
Cc:     shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] RDMA/irdma: Fix missing error code in irdma_modify_qp_roce()
Date:   Fri, 23 Jul 2021 18:32:53 +0800
Message-Id: <1627036373-69929-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/infiniband/hw/irdma/verbs.c:1344 irdma_modify_qp_roce() warn:
missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 717147e..406c8b05 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1341,6 +1341,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			break;
 		case IB_QPS_SQD:
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
+				ret = -EINVAL;
 				goto exit;
 
 			if (iwqp->iwarp_state != IRDMA_QP_STATE_RTS) {
-- 
1.8.3.1

