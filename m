Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42738FB39
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEYGx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:53:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3935 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhEYGx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:53:28 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fq4Rz6D98zBvZq;
        Tue, 25 May 2021 14:49:03 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:55 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next 08/13] RDMA/hns: Use refcount_t instead of atomic_t for CQ reference counting
Date:   Tue, 25 May 2021 14:51:39 +0800
Message-ID: <1621925504-33019-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 8 ++++----
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 488d86b..1422bdc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -154,7 +154,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hr_cq->cons_index = 0;
 	hr_cq->arm_sn = 1;
 
-	atomic_set(&hr_cq->refcount, 1);
+	refcount_set(&hr_cq->refcount, 1);
 	init_completion(&hr_cq->free);
 
 	return 0;
@@ -188,7 +188,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	synchronize_irq(hr_dev->eq_table.eq[hr_cq->vector].irq);
 
 	/* wait for all interrupt processed */
-	if (atomic_dec_and_test(&hr_cq->refcount))
+	if (refcount_dec_and_test(&hr_cq->refcount))
 		complete(&hr_cq->free);
 	wait_for_completion(&hr_cq->free);
 
@@ -480,7 +480,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		return;
 	}
 
-	atomic_inc(&hr_cq->refcount);
+	refcount_inc(&hr_cq->refcount);
 
 	ibcq = &hr_cq->ib_cq;
 	if (ibcq->event_handler) {
@@ -490,7 +490,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		ibcq->event_handler(&event, ibcq->cq_context);
 	}
 
-	if (atomic_dec_and_test(&hr_cq->refcount))
+	if (refcount_dec_and_test(&hr_cq->refcount))
 		complete(&hr_cq->free);
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 111cab5..d90a39c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -446,7 +446,7 @@ struct hns_roce_cq {
 	int				cqe_size;
 	unsigned long			cqn;
 	u32				vector;
-	atomic_t			refcount;
+	refcount_t			refcount;
 	struct completion		free;
 	struct list_head		sq_list; /* all qps on this send cq */
 	struct list_head		rq_list; /* all qps on this recv cq */
-- 
2.7.4

