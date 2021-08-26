Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274DA3F8932
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhHZNmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:42:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8783 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242687AbhHZNmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 09:42:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwPBF1lNxzYsQ7;
        Thu, 26 Aug 2021 21:40:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:27 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/7] RDMA/hns: Remove dqpn filling when modify qp from Init to Init
Date:   Thu, 26 Aug 2021 21:37:32 +0800
Message-ID: <1629985056-57004-4-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
References: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

According to the IB specification, the destination qpn is allowed to be
filled into the qpc only when the qp transitions from Init to RTR, so
this code is unused.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 752bad5..85ad937 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4143,8 +4143,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 				   struct hns_roce_v2_qp_context *context,
 				   struct hns_roce_v2_qp_context *qpc_mask)
 {
-	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-
 	/*
 	 * In v2 engine, software pass context and context mask to hardware
 	 * when modifying qp. If software need modify some fields in context,
@@ -4169,11 +4167,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 		hr_reg_write(context, QPC_SRQN, to_hr_srq(ibqp->srq)->srqn);
 		hr_reg_clear(qpc_mask, QPC_SRQN);
 	}
-
-	if (attr_mask & IB_QP_DEST_QPN) {
-		hr_reg_write(context, QPC_DQPN, hr_qp->qpn);
-		hr_reg_clear(qpc_mask, QPC_DQPN);
-	}
 }
 
 static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
-- 
2.8.1

