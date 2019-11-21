Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDB104802
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKUBXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbfKUBXB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2668633DC677E9020FE2;
        Thu, 21 Nov 2019 09:22:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:52 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 4/7] libhns: Bugfix for cleaning cq
Date:   Thu, 21 Nov 2019 09:19:26 +0800
Message-ID: <1574299169-31457-5-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

When a qp attached with a srq needs to be modified to reset or error
state, the corresponding cq should be cleaned and then the wqe placeholder
of the srq can be released.

Fixes: 6fe30a1a705f ("libhns: Introduce QP operations referred to hip08 RoCE device)
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index b473f07..7f5a2ce 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -1040,6 +1040,8 @@ out:
 static void __hns_roce_v2_cq_clean(struct hns_roce_cq *cq, uint32_t qpn,
 				   struct hns_roce_srq *srq)
 {
+	bool is_rcqe;
+	int wqe_index;
 	int nfreed = 0;
 	uint32_t prod_index;
 	uint8_t owner_bit = 0;
@@ -1055,6 +1057,14 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *cq, uint32_t qpn,
 		cqe = get_cqe_v2(cq, prod_index & cq->ibv_cq.cqe);
 		if ((roce_get_field(cqe->byte_16, CQE_BYTE_16_LCL_QPN_M,
 			      CQE_BYTE_16_LCL_QPN_S) & 0xffffff) == qpn) {
+			is_rcqe = roce_get_bit(cqe->byte_4, CQE_BYTE_4_S_R_S);
+
+			if (srq && is_rcqe) {
+				wqe_index = roce_get_field(cqe->byte_4,
+						CQE_BYTE_4_WQE_IDX_M,
+						CQE_BYTE_4_WQE_IDX_S);
+				hns_roce_free_srq_wqe(srq, wqe_index);
+			}
 			++nfreed;
 		} else if (nfreed) {
 			dest = get_cqe_v2(cq,
-- 
2.8.1

