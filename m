Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7E31083F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBEJr2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:47:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12849 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBEJpO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:14 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q96kRsz7hVl;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:51 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 11/12] RDMA/hns: Remove unnecessary wrap around for EQ's consumer index
Date:   Fri, 5 Feb 2021 17:39:33 +0800
Message-ID: <1612517974-31867-12-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

The hns driver wrap around the consumer index of AEQ and CEQ when they
reach to two times of queue entries number for owner mechanism, actually,
it is unnecessary to wrap around since the hardware itself will mask it
before use.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 55dfd44..9c6fe32 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5667,9 +5667,6 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		aeqe_found = 1;
 
-		if (eq->cons_index > (2 * eq->entries - 1))
-			eq->cons_index = 0;
-
 		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
 		aeqe = next_aeqe_sw_v2(eq);
@@ -5712,9 +5709,6 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		ceqe_found = 1;
 
-		if (eq->cons_index > (EQ_DEPTH_COEFF * eq->entries - 1))
-			eq->cons_index = 0;
-
 		ceqe = next_ceqe_sw_v2(eq);
 	}
 
-- 
2.8.1

