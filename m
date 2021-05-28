Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC139402F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhE1Jji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:39:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2336 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhE1Jjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:39:32 -0400
Received: from dggeml764-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Frzy85hdwz1BFvF;
        Fri, 28 May 2021 17:33:20 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml764-chm.china.huawei.com (10.1.199.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 09/12] RDMA/hns: Use refcount_t instead of atomic_t for SRQ reference counting
Date:   Fri, 28 May 2021 17:37:40 +0800
Message-ID: <1622194663-2383-10-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d90a39c..24d177c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -473,7 +473,7 @@ struct hns_roce_srq {
 	u32			xrcdn;
 	void __iomem		*db_reg;
 
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	free;
 
 	struct hns_roce_mtr	buf_mtr;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 546d182..327f7aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -17,7 +17,7 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 	xa_lock(&srq_table->xa);
 	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
 	if (srq)
-		atomic_inc(&srq->refcount);
+		refcount_inc(&srq->refcount);
 	xa_unlock(&srq_table->xa);
 
 	if (!srq) {
@@ -27,7 +27,7 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 
 	srq->event(srq, event_type);
 
-	if (atomic_dec_and_test(&srq->refcount))
+	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
 }
 
@@ -149,7 +149,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	xa_erase(&srq_table->xa, srq->srqn);
 
-	if (atomic_dec_and_test(&srq->refcount))
+	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
 	wait_for_completion(&srq->free);
 
@@ -417,7 +417,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	srq->db_reg = hr_dev->reg_base + SRQ_DB_REG;
 	srq->event = hns_roce_ib_srq_event;
-	atomic_set(&srq->refcount, 1);
+	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
 
 	return 0;
-- 
2.7.4

