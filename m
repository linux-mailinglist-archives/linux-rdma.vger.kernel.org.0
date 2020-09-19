Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCD270CC6
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgISKEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbgISKEr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 95E14F4338A65F3B5122;
        Sat, 19 Sep 2020 18:04:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 6/8] RDMA/hns: Fix the wrong value of rnr_retry when querying qp
Date:   Sat, 19 Sep 2020 18:03:20 +0800
Message-ID: <1600509802-44382-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
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
index 1cc4abe..316cdb6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4799,7 +4799,9 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
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

