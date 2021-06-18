Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0C3AC879
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFRKNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7488 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhFRKNA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:13:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5vkJ0KpWzZfqV;
        Fri, 18 Jun 2021 18:07:52 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 05/10] RDMA/hns: Delete unnecessary branch of hns_roce_v2_query_qp
Date:   Fri, 18 Jun 2021 18:10:15 +0800
Message-ID: <1624011020-16992-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

When query_qp is called by userspace, max_send_wr and max_send_sge are set
to 0 by the kernel driver. However, the userspace does not use these two
return values from the kernel driver, but uses its own calculated values.
So there is no need for special treatment.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 65ed472..8d8f4d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5403,13 +5403,8 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
 	qp_attr->cap.max_inline_data = hr_qp->max_inline_data;
 
-	if (!ibqp->uobject) {
-		qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
-		qp_attr->cap.max_send_sge = hr_qp->sq.max_gs;
-	} else {
-		qp_attr->cap.max_send_wr = 0;
-		qp_attr->cap.max_send_sge = 0;
-	}
+	qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
+	qp_attr->cap.max_send_sge = hr_qp->sq.max_gs;
 
 	qp_init_attr->qp_context = ibqp->qp_context;
 	qp_init_attr->qp_type = ibqp->qp_type;
-- 
2.7.4

