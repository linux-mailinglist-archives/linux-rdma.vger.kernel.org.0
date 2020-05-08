Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB01CA775
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHJqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbgEHJqT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7C88752EA7298494CDD;
        Fri,  8 May 2020 17:46:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Fix cmdq parameter of querying pf timer resource
Date:   Fri, 8 May 2020 17:45:52 +0800
Message-ID: <1588931159-56875-3-git-send-email-liweihang@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

The firmware has reduced the number of descriptions of command
HNS_ROCE_OPC_QUERY_PF_TIMER_RES to 1. The driver needs to adapt, otherwise
the hardware will report error 4(CMD_NEXT_ERR).

Fixes: 0e40dc2f70cd ("RDMA/hns: Add timer allocation support for hip08")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 32 +++++++++++-------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 61098b0..81abab0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1450,34 +1450,26 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_pf_timer_res_a *req_a;
-	struct hns_roce_cmq_desc desc[2];
-	int ret, i;
+	struct hns_roce_cmq_desc desc;
+	int ret;
 
-	for (i = 0; i < 2; i++) {
-		hns_roce_cmq_setup_basic_desc(&desc[i],
-					      HNS_ROCE_OPC_QUERY_PF_TIMER_RES,
-					      true);
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_PF_TIMER_RES,
+				      true);
 
-		if (i == 0)
-			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-		else
-			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-	}
-
-	ret = hns_roce_cmq_send(hr_dev, desc, 2);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret)
 		return ret;
 
-	req_a = (struct hns_roce_pf_timer_res_a *)desc[0].data;
+	req_a = (struct hns_roce_pf_timer_res_a *)desc.data;
 
 	hr_dev->caps.qpc_timer_bt_num =
-				roce_get_field(req_a->qpc_timer_bt_idx_num,
-					PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_M,
-					PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_S);
+		roce_get_field(req_a->qpc_timer_bt_idx_num,
+			       PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_M,
+			       PF_RES_DATA_1_PF_QPC_TIMER_BT_NUM_S);
 	hr_dev->caps.cqc_timer_bt_num =
-				roce_get_field(req_a->cqc_timer_bt_idx_num,
-					PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_M,
-					PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_S);
+		roce_get_field(req_a->cqc_timer_bt_idx_num,
+			       PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_M,
+			       PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_S);
 
 	return 0;
 }
-- 
2.8.1

