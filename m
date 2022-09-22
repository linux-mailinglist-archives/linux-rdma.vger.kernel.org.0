Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1705E6279
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiIVMeU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiIVMeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3BE720E
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:10 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYF2t19yZzMpR5;
        Thu, 22 Sep 2022 20:29:26 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:08 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:02 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 03/12] RDMA/hns: Remove unnecessary brackets when getting point
Date:   Thu, 22 Sep 2022 20:33:06 +0800
Message-ID: <20220922123315.3732205-4-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
References: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guofeng Yue <yueguofeng@hisilicon.com>

Delete () when using & to obtain an address.

Signed-off-by: Guofeng Yue <yueguofeng@hisilicon.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a9dc28fd2962..07a9988d7505 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4613,7 +4613,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		hr_reg_clear(qpc_mask, QPC_DQPN);
 	}
 
-	memcpy(&(context->dmac), dmac, sizeof(u32));
+	memcpy(&context->dmac, dmac, sizeof(u32));
 	hr_reg_write(context, QPC_DMAC_H, *((u16 *)(&dmac[4])));
 	qpc_mask->dmac = 0;
 	hr_reg_clear(qpc_mask, QPC_DMAC_H);
@@ -5904,12 +5904,12 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 	if (!irq_work)
 		return;
 
-	INIT_WORK(&(irq_work->work), hns_roce_irq_work_handle);
+	INIT_WORK(&irq_work->work, hns_roce_irq_work_handle);
 	irq_work->hr_dev = hr_dev;
 	irq_work->event_type = eq->event_type;
 	irq_work->sub_type = eq->sub_type;
 	irq_work->queue_num = queue_num;
-	queue_work(hr_dev->irq_workq, &(irq_work->work));
+	queue_work(hr_dev->irq_workq, &irq_work->work);
 }
 
 static void update_eq_db(struct hns_roce_eq *eq)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ae29780dd63a..ca63463e7d4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -406,6 +406,7 @@ enum hns_roce_v2_qp_state {
 struct hns_roce_v2_qp_context_ex {
 	__le32 data[64];
 };
+
 struct hns_roce_v2_qp_context {
 	__le32 byte_4_sqpn_tst;
 	__le32 wqe_sge_ba;
-- 
2.30.0

