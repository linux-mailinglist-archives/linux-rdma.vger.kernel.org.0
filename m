Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562B34E74B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhC3MP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 08:15:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15398 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhC3MPo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 08:15:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8pJm4lgGznTlt;
        Tue, 30 Mar 2021 20:14:00 +0800 (CST)
Received: from ubuntu.huawei.com (10.67.174.117) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 20:15:34 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>
Subject: [PATCH -next] RDMA/hns: Fix a spelling mistake in hns_roce_hw_v1.c
Date:   Tue, 30 Mar 2021 08:29:12 -0400
Message-ID: <20210330122912.19989-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

s/caculating/calculating

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 759ffe52567a..414e9f33ba49 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -538,7 +538,7 @@ static void hns_roce_set_sdb_ext(struct hns_roce_dev *hr_dev, u32 ext_sdb_alept,
 	/*
 	 * 44 = 32 + 12, When evaluating addr to hardware, shift 12 because of
 	 * using 4K page, and shift more 32 because of
-	 * caculating the high 32 bit value evaluated to hardware.
+	 * calculating the high 32 bit value evaluated to hardware.
 	 */
 	roce_set_field(tmp, ROCEE_EXT_DB_SQ_H_EXT_DB_SQ_BA_H_M,
 		       ROCEE_EXT_DB_SQ_H_EXT_DB_SQ_BA_H_S, sdb_dma_addr >> 44);
@@ -1189,7 +1189,7 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 	/*
 	 * 44 = 32 + 12, When evaluating addr to hardware, shift 12 because of
 	 * using 4K page, and shift more 32 because of
-	 * caculating the high 32 bit value evaluated to hardware.
+	 * calculating the high 32 bit value evaluated to hardware.
 	 */
 	roce_set_field(tmp, ROCEE_EXT_RAQ_H_EXT_RAQ_BA_H_M,
 		       ROCEE_EXT_RAQ_H_EXT_RAQ_BA_H_S,
@@ -2041,7 +2041,7 @@ static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 	/**
 	 * 44 = 32 + 12, When evaluating addr to hardware, shift 12 because of
 	 * using 4K page, and shift more 32 because of
-	 * caculating the high 32 bit value evaluated to hardware.
+	 * calculating the high 32 bit value evaluated to hardware.
 	 */
 	roce_set_field(cq_context->cqc_byte_20,
 		       CQ_CONTEXT_CQC_BYTE_20_CQE_TPTR_ADDR_H_M,
@@ -4170,7 +4170,7 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 	 * Configure eq extended address 45~49 bit.
 	 * 44 = 32 + 12, When evaluating addr to hardware, shift 12 because of
 	 * using 4K page, and shift more 32 because of
-	 * caculating the high 32 bit value evaluated to hardware.
+	 * calculating the high 32 bit value evaluated to hardware.
 	 */
 	roce_set_field(tmp1, ROCEE_CAEP_AEQE_CUR_IDX_CAEP_AEQ_BT_H_M,
 		       ROCEE_CAEP_AEQE_CUR_IDX_CAEP_AEQ_BT_H_S,
-- 
2.17.1

