Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC07B1DE796
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgEVNDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 09:03:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729292AbgEVNDd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 09:03:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF3432A374F4F9BF3171;
        Fri, 22 May 2020 21:03:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 21:03:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Simplify process related to poll cq
Date:   Fri, 22 May 2020 21:02:58 +0800
Message-ID: <1590152579-32364-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
References: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Set hns_roce_v2_cq_set_ci to inline type and remove unnecessary
next_cqe_sw_v2().

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 150df4e..e02afd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2775,14 +2775,9 @@ static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 		!!(n & hr_cq->cq_depth)) ? cqe : NULL;
 }
 
-static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *hr_cq)
+static inline void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 ci)
 {
-	return get_sw_cqe_v2(hr_cq, hr_cq->cons_index);
-}
-
-static void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 cons_index)
-{
-	*hr_cq->set_ci_db = cons_index & V2_CQ_DB_PARAMETER_CONS_IDX_M;
+	*hr_cq->set_ci_db = ci & V2_CQ_DB_PARAMETER_CONS_IDX_M;
 }
 
 static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
@@ -3105,7 +3100,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	int ret;
 
 	/* Find cqe according to consumer index */
-	cqe = next_cqe_sw_v2(hr_cq);
+	cqe = get_sw_cqe_v2(hr_cq, hr_cq->cons_index);
 	if (!cqe)
 		return -EAGAIN;
 
-- 
2.8.1

