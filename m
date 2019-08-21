Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8597A8B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfHUNSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:18:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbfHUNSA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:18:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4AE76DE12217181A863;
        Wed, 21 Aug 2019 21:17:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:48 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Fix wrong assignment of qp_access_flags
Date:   Wed, 21 Aug 2019 21:14:36 +0800
Message-ID: <1566393276-42555-10-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We used wrong shifts when set qp_attr->qp_access_flag,
this patch exchange V2_QP_RRE_S and V2_QP_RWE_S to fix it.

Fixes: 2a3d923f8730 ("RDMA/hns: Replace magic numbers with #defines")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ecd0283..7a89d66 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4574,9 +4574,9 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 						  V2_QPC_BYTE_56_DQPN_M,
 						  V2_QPC_BYTE_56_DQPN_S);
 	qp_attr->qp_access_flags = ((roce_get_bit(context.byte_76_srqn_op_en,
-				    V2_QPC_BYTE_76_RRE_S)) << V2_QP_RWE_S) |
+				    V2_QPC_BYTE_76_RRE_S)) << V2_QP_RRE_S) |
 				    ((roce_get_bit(context.byte_76_srqn_op_en,
-				    V2_QPC_BYTE_76_RWE_S)) << V2_QP_RRE_S) |
+				    V2_QPC_BYTE_76_RWE_S)) << V2_QP_RWE_S) |
 				    ((roce_get_bit(context.byte_76_srqn_op_en,
 				    V2_QPC_BYTE_76_ATE_S)) << V2_QP_ATE_S);
 
-- 
2.8.1

