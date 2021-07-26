Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72C53D5492
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jul 2021 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhGZHFF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 03:05:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57601 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhGZHFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Jul 2021 03:05:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uh-4YHl_1627285516;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uh-4YHl_1627285516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Jul 2021 15:45:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mustafa.ismail@intel.com
Cc:     shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v2] RDMA/irdma: Fix missing error code in irdma_modify_qp_roce()
Date:   Mon, 26 Jul 2021 15:45:10 +0800
Message-Id: <1627285510-20411-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/infiniband/hw/irdma/verbs.c:1344 irdma_modify_qp_roce() warn:
missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -For the follow advice: https://lore.kernel.org/patchwork/patch/1466463/

 drivers/infiniband/hw/irdma/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 717147e..721cb0c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1340,8 +1340,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			}
 			break;
 		case IB_QPS_SQD:
-			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD)
+			if (iwqp->iwarp_state == IRDMA_QP_STATE_SQD) {
+				ret = -EINVAL;
 				goto exit;
+			}
 
 			if (iwqp->iwarp_state != IRDMA_QP_STATE_RTS) {
 				ret = -EINVAL;
-- 
1.8.3.1

