Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111E5270CC3
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgISKEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgISKEo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB58E7B040EA9B312DE3;
        Sat, 19 Sep 2020 18:04:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 3/8] RDMA/hns: Correct typo of hns_roce_create_cq()
Date:   Sat, 19 Sep 2020 18:03:17 +0800
Message-ID: <1600509802-44382-4-git-send-email-liweihang@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

Change "initialze" to "initialize".

Fixes: 8f3e9f3ea087 ("IB/hns: Add code for refreshing CQ CI using TPTR")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index c5acf33..34f86d9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -287,7 +287,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	/*
 	 * For the QP created by kernel space, tptr value should be initialized
 	 * to zero; For the QP created by user space, it will cause synchronous
-	 * problems if tptr is set to zero here, so we initialze it in user
+	 * problems if tptr is set to zero here, so we initialize it in user
 	 * space.
 	 */
 	if (!udata && hr_cq->tptr_addr)
-- 
2.8.1

