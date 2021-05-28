Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0B394028
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhE1Jji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:39:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2449 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhE1Jjd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:39:33 -0400
Received: from dggeml764-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fs007368mz66qZ;
        Fri, 28 May 2021 17:35:03 +0800 (CST)
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
Subject: [PATCH v4 for-next 10/12] RDMA/hns: Use refcount_t instead of atomic_t for QP reference counting
Date:   Fri, 28 May 2021 17:37:41 +0800
Message-ID: <1622194663-2383-11-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 24d177c..501b48f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -641,7 +641,7 @@ struct hns_roce_qp {
 
 	u32			xrcdn;
 
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	free;
 
 	struct hns_roce_sge	sge;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c6e120e..ad26d4d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -65,7 +65,7 @@ static void flush_work_handle(struct work_struct *work)
 	 * make sure we signal QP destroy leg that flush QP was completed
 	 * so that it can safely proceed ahead now and destroy QP
 	 */
-	if (atomic_dec_and_test(&hr_qp->refcount))
+	if (refcount_dec_and_test(&hr_qp->refcount))
 		complete(&hr_qp->free);
 }
 
@@ -75,7 +75,7 @@ void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 	flush_work->hr_dev = hr_dev;
 	INIT_WORK(&flush_work->work, flush_work_handle);
-	atomic_inc(&hr_qp->refcount);
+	refcount_inc(&hr_qp->refcount);
 	queue_work(hr_dev->irq_workq, &flush_work->work);
 }
 
@@ -87,7 +87,7 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	xa_lock(&hr_dev->qp_table_xa);
 	qp = __hns_roce_qp_lookup(hr_dev, qpn);
 	if (qp)
-		atomic_inc(&qp->refcount);
+		refcount_inc(&qp->refcount);
 	xa_unlock(&hr_dev->qp_table_xa);
 
 	if (!qp) {
@@ -108,7 +108,7 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 
 	qp->event(qp, (enum hns_roce_event)event_type);
 
-	if (atomic_dec_and_test(&qp->refcount))
+	if (refcount_dec_and_test(&qp->refcount))
 		complete(&qp->free);
 }
 
@@ -1076,7 +1076,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	hr_qp->ibqp.qp_num = hr_qp->qpn;
 	hr_qp->event = hns_roce_ib_qp_event;
-	atomic_set(&hr_qp->refcount, 1);
+	refcount_set(&hr_qp->refcount, 1);
 	init_completion(&hr_qp->free);
 
 	return 0;
@@ -1099,7 +1099,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			 struct ib_udata *udata)
 {
-	if (atomic_dec_and_test(&hr_qp->refcount))
+	if (refcount_dec_and_test(&hr_qp->refcount))
 		complete(&hr_qp->free);
 	wait_for_completion(&hr_qp->free);
 
-- 
2.7.4

