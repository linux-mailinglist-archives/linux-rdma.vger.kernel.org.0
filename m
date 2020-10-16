Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF05028FF7C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404857AbgJPHw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 03:52:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404854AbgJPHw2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 03:52:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B1D4F836F1B584A3BFB9;
        Fri, 16 Oct 2020 15:52:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 15:52:18 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <maorg@mellanox.com>, <parav@mellanox.com>, <galpress@amazon.com>,
        <monis@mellanox.com>, <chuck.lever@oracle.com>, <maxg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] RDMA/core: Fix error return in _ib_modify_qp()
Date:   Fri, 16 Oct 2020 15:58:45 +0800
Message-ID: <20201016075845.129562-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return error code PTR_ERR() from the error handling case instead of
0.

Fixes: 51aab12631dd ("RDMA/core: Get xmit slave for LAG")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/infiniband/core/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 307886737646..bf63c7561e8c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1685,8 +1685,10 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			slave = rdma_lag_get_ah_roce_slave(qp->device,
 							   &attr->ah_attr,
 							   GFP_KERNEL);
-			if (IS_ERR(slave))
+			if (IS_ERR(slave)) {
+				ret = PTR_ERR(slave);
 				goto out_av;
+			}
 			attr->xmit_slave = slave;
 		}
 	}
-- 
2.17.1

