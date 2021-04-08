Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D043581FD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhDHLen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 07:34:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16838 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhDHLem (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 07:34:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJyV045xz7txY;
        Thu,  8 Apr 2021 19:32:18 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:34:22 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] RDMA/qedr: Fix error return code in qedr_iw_connect()
Date:   Thu, 8 Apr 2021 11:31:35 +0000
Message-ID: <20210408113135.92165-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 82af6d19d8d9 ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index c4bc587..1715fbe 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -636,8 +636,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	memcpy(in_params.local_mac_addr, dev->ndev->dev_addr, ETH_ALEN);
 
 	if (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
-			     &qp->iwarp_cm_flags))
+			     &qp->iwarp_cm_flags)) {
+		rc = -ENODEV;
 		goto err; /* QP already being destroyed */
+	}
 
 	rc = dev->ops->iwarp_connect(dev->rdma_ctx, &in_params, &out_params);
 	if (rc) {
-- 
2.9.4

