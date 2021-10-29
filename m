Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4443FA6E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJ2KFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 06:05:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30878 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhJ2KFl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Oct 2021 06:05:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HgdD66h8NzbnVP;
        Fri, 29 Oct 2021 17:58:30 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 18:03:06 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 18:03:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix initial arm_st of CQ
Date:   Fri, 29 Oct 2021 17:58:46 +0800
Message-ID: <20211029095846.26732-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

We set the init CQ status to ARMED before. As a result, an unexpected CEQE
would be reported. Therefore, the init CQ status should be set to no_armed
rather than REG_NXT_CEQE.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d5f3faa1627a..8e5f0862896e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3328,7 +3328,7 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	memset(cq_context, 0, sizeof(*cq_context));
 
 	hr_reg_write(cq_context, CQC_CQ_ST, V2_CQ_STATE_VALID);
-	hr_reg_write(cq_context, CQC_ARM_ST, REG_NXT_CEQE);
+	hr_reg_write(cq_context, CQC_ARM_ST, NO_ARMED);
 	hr_reg_write(cq_context, CQC_SHIFT, ilog2(hr_cq->cq_depth));
 	hr_reg_write(cq_context, CQC_CEQN, hr_cq->vector);
 	hr_reg_write(cq_context, CQC_CQN, hr_cq->cqn);
-- 
2.33.0

