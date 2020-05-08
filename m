Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3F1CA772
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHJqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbgEHJqT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B5A6FE9ADDB31506DEC;
        Fri,  8 May 2020 17:46:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/9] RDMA/hns: Bugfix for querying qkey
Date:   Fri, 8 May 2020 17:45:51 +0800
Message-ID: <1588931159-56875-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

The qkey queried through the query ud qp verb is a fixed value and it
should be read from qp context.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ad9a11a..61098b0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4680,7 +4680,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->path_mig_state = IB_MIG_ARMED;
 	qp_attr->ah_attr.type   = RDMA_AH_ATTR_TYPE_ROCE;
 	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
-		qp_attr->qkey = V2_QKEY_VAL;
+		qp_attr->qkey = le32_to_cpu(context.qkey_xrcd);
 
 	qp_attr->rq_psn = roce_get_field(context.byte_108_rx_reqepsn,
 					 V2_QPC_BYTE_108_RX_REQ_EPSN_M,
-- 
2.8.1

