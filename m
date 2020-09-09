Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3040262B1E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIII6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:58:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730128AbgIII6u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8ED765EA1F8E53A32899;
        Wed,  9 Sep 2020 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:58:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 4/9] RDMA/hns: Correct typo of hns_roce_create_cq()
Date:   Wed, 9 Sep 2020 16:57:29 +0800
Message-ID: <1599641854-23160-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Change "initialze" to "initialize".

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index e87d616..4f4f54f 100644
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

