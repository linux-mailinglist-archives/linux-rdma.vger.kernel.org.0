Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8681735283C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDBJKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:10:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbhDBJKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:10:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ2H24g6znW0p;
        Fri,  2 Apr 2021 17:07:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:10:05 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Fix missing assignment of max_inline_data
Date:   Fri, 2 Apr 2021 17:07:27 +0800
Message-ID: <1617354454-47840-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When querying QP, the ULPs should be informed of the max length of inline
data supported by the hardware.

Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b48bdc9..570fd7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5376,6 +5376,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->cur_qp_state = qp_attr->qp_state;
 	qp_attr->cap.max_recv_wr = hr_qp->rq.wqe_cnt;
 	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
+	qp_attr->cap.max_inline_data = hr_qp->max_inline_data;
 
 	if (!ibqp->uobject) {
 		qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
-- 
2.8.1

