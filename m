Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98D022D3F7
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jul 2020 04:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYCzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 22:55:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbgGYCzC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 22:55:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAE5F86362968DD56A2D;
        Sat, 25 Jul 2020 10:54:58 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:54:57 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <jgg@mellanox.com>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/core: fix return error value to negative
Date:   Sat, 25 Jul 2020 10:56:27 +0800
Message-ID: <1595645787-20375-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes: 8d9ec9addd6c (IB/core: Add a sgid_attr pointer to struct rdma_ah_attr)
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 53d6505c..f369f0a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1712,7 +1712,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 		if (!(rdma_protocol_ib(qp->device,
 				       attr->alt_ah_attr.port_num) &&
 		      rdma_protocol_ib(qp->device, port))) {
-			ret = EINVAL;
+			ret = -EINVAL;
 			goto out;
 		}
 	}
-- 
2.7.4

