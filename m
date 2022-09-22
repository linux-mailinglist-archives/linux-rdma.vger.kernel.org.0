Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481305E6282
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiIVMeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiIVMeN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF070E721E
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:10 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYF530BV8zpTcP;
        Thu, 22 Sep 2022 20:31:19 +0800 (CST)
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
Subject: [PATCH for-next 04/12] RDMA/hns: Remove redundant 'attr_mask' in modify_qp_init_to_init()
Date:   Thu, 22 Sep 2022 20:33:07 +0800
Message-ID: <20220922123315.3732205-5-xuhaoyue1@hisilicon.com>
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

From: Yixing Liu <liuyixing1@huawei.com>

The attr_mask variable is not used in the function,
so remove it.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 07a9988d7505..4931f2a8a4af 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4300,7 +4300,6 @@ static inline int get_pdn(struct ib_pd *ib_pd)
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 				    const struct ib_qp_attr *attr,
-				    int attr_mask,
 				    struct hns_roce_v2_qp_context *context,
 				    struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4364,7 +4363,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
-				   const struct ib_qp_attr *attr, int attr_mask,
+				   const struct ib_qp_attr *attr,
 				   struct hns_roce_v2_qp_context *context,
 				   struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -5015,11 +5014,9 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
-		modify_qp_reset_to_init(ibqp, attr, attr_mask, context,
-					qpc_mask);
+		modify_qp_reset_to_init(ibqp, attr, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-		modify_qp_init_to_init(ibqp, attr, attr_mask, context,
-				       qpc_mask);
+		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
 					    qpc_mask);
-- 
2.30.0

