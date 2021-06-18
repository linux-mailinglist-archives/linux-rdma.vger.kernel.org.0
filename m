Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C03AC87C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhFRKNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhFRKNC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:13:02 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vgw35ZgzXhCN;
        Fri, 18 Jun 2021 18:05:48 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 04/10] RDMA/hns: Add member assignments for qp_init_attr
Date:   Fri, 18 Jun 2021 18:10:14 +0800
Message-ID: <1624011020-16992-5-git-send-email-liweihang@huawei.com>
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

Some kernel ULPs need to use the return value of qp_init_attr, so add
member assignments for qp_init_attr.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e71df58..65ed472 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5411,6 +5411,11 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		qp_attr->cap.max_send_sge = 0;
 	}
 
+	qp_init_attr->qp_context = ibqp->qp_context;
+	qp_init_attr->qp_type = ibqp->qp_type;
+	qp_init_attr->recv_cq = ibqp->recv_cq;
+	qp_init_attr->send_cq = ibqp->send_cq;
+	qp_init_attr->srq = ibqp->srq;
 	qp_init_attr->cap = qp_attr->cap;
 	qp_init_attr->sq_sig_type = hr_qp->sq_signal_bits;
 
-- 
2.7.4

