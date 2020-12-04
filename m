Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857322CEC5F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 11:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgLDKnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 05:43:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8692 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgLDKnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 05:43:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnTlz5L5JzkkcQ;
        Fri,  4 Dec 2020 18:41:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 18:42:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 05/11] RDMA/hns: WARN_ON if get a reserved sl from users
Date:   Fri, 4 Dec 2020 18:40:30 +0800
Message-ID: <1607078436-26455-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

According to the RoCE v1 specification, the sl (service level) 0-7 are
mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
driver should verify whether the value of sl is larger than 7, if so, an
exception should be returned.

Fixes: 172505cfa3a8 ("RDMA/hns: Add check for the validity of sl configuration")
Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a0c1ab..15e1313 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -433,6 +433,10 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
 		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
+
+	if (WARN_ON(ah->av.sl > MAX_SERVICE_LEVEL))
+		return -EINVAL;
+
 	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
 		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
 
@@ -4609,12 +4613,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
 
 	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
-	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
-		ibdev_err(ibdev,
-			  "failed to fill QPC, sl (%d) shouldn't be larger than %d.\n",
-			  hr_qp->sl, MAX_SERVICE_LEVEL);
+	if (WARN_ON(hr_qp->sl > MAX_SERVICE_LEVEL))
 		return -EINVAL;
-	}
 
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
 		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);
-- 
2.8.1

