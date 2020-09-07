Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DB260227
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIGRTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:19:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729711AbgIGNyN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 09:54:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E47F550B38AD32647F69;
        Mon,  7 Sep 2020 21:38:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:37:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Fix the wrong value of rnr_retry when querying qp
Date:   Mon, 7 Sep 2020 21:36:46 +0800
Message-ID: <1599485808-29940-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
References: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The rnr_retry returned to the user is not correct, it should be got from
another fields in QPC.

Fixes: bfe860351e31 ("RDMA/hns: Fix cast from or to restricted __le32 for driver")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8690151..47722c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4807,7 +4807,9 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = roce_get_field(context.byte_212_lsn,
 					    V2_QPC_BYTE_212_RETRY_CNT_M,
 					    V2_QPC_BYTE_212_RETRY_CNT_S);
-	qp_attr->rnr_retry = le32_to_cpu(context.rq_rnr_timer);
+	qp_attr->rnr_retry = roce_get_field(context.byte_244_rnr_rxack,
+					    V2_QPC_BYTE_244_RNR_CNT_M,
+					    V2_QPC_BYTE_244_RNR_CNT_S);
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
-- 
2.8.1

