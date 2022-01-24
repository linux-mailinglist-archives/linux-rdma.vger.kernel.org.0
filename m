Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A621C497FC6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiAXMqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:46:11 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30295 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiAXMqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:46:10 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jj8pR5BVJzbk7x;
        Mon, 24 Jan 2022 20:45:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Add more restrack attributes to CQ
Date:   Mon, 24 Jan 2022 20:46:22 +0800
Message-ID: <20220124124624.55352-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220124124624.55352-1-liangwenpeng@huawei.com>
References: <20220124124624.55352-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add arm_st, shift and cqe_size of CQ.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 4420639445a1..a0d601cd2cb6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -15,7 +15,8 @@
 #define _HR_REG_CFG(type, h, l) _HR_REG_MASK(h, l), l
 #define HR_REG_CFG(field) _HR_REG_CFG(field)
 
-static int hns_roce_fill_cq(struct sk_buff *msg,
+static int hns_roce_fill_cq(struct hns_roce_cq *hr_cq,
+			    struct sk_buff *msg,
 			    struct hns_roce_v2_cq_context *context)
 {
 	static struct {
@@ -24,8 +25,11 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 		u32 l;
 	} reg[] = {
 		{ "cq_st", HR_REG_CFG(CQC_CQ_ST) },
+		{ "arm_st", HR_REG_CFG(CQC_ARM_ST) },
+		{ "shift", HR_REG_CFG(CQC_SHIFT) },
 		{ "ceqn", HR_REG_CFG(CQC_CEQN) },
 		{ "cqn", HR_REG_CFG(CQC_CQN) },
+		{ "cqe_size", HR_REG_CFG(CQC_CQE_SIZE) },
 		{ "hopnum", HR_REG_CFG(CQC_CQE_HOP_NUM) },
 		{ "pi", HR_REG_CFG(CQC_CQ_PRODUCER_IDX) },
 		{ "ci", HR_REG_CFG(CQC_CQ_CONSUMER_IDX) },
@@ -43,6 +47,9 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 				(reg[i].l % 32)))
 			goto err;
 
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_cq_ci", hr_cq->cons_index))
+		goto err;
+
 	return 0;
 
 err:
@@ -68,7 +75,7 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 	if (!table_attr)
 		return -EMSGSIZE;
 
-	if (hns_roce_fill_cq(msg, &context))
+	if (hns_roce_fill_cq(hr_cq, msg, &context))
 		goto err_cancel_table;
 
 	nla_nest_end(msg, table_attr);
-- 
2.33.0

