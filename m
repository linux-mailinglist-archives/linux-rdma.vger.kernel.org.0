Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE02B0177
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKLJBi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 04:01:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7176 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLJBi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 04:01:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWwZF2fBJz15VWx;
        Thu, 12 Nov 2020 17:01:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 17:01:24 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <maorg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] RDMA/core: Fix error return code in _ib_modify_qp()
Date:   Thu, 12 Nov 2020 17:06:26 +0800
Message-ID: <20201112090626.184976-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling case
instead of 0 in function _ib_modify_qp(), as done elsewhere in this
function.

Fixes: 51aab12631dd ("RDMA/core: Get xmit slave for LAG")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/infiniband/core/verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 740f8454b6b4..3d895cc41c3a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1698,8 +1698,10 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
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
2.20.1

