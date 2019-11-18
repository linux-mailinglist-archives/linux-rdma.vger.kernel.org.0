Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2353FFD20
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 03:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKRCi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfKRCi0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 992779BBF385BB7BED9F;
        Mon, 18 Nov 2019 10:38:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 10:38:14 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 4/4] RDMA/hns: Delete unnecessary callback functions for cq
Date:   Mon, 18 Nov 2019 10:34:53 +0800
Message-ID: <1574044493-46984-5-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
References: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Currently, when cq event occurred, we first call our own callback
functions in the event process function, then call ib callback
functions. Actually, we can directly call ib callback functions.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 91 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 -
 2 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 9174d33..af1d882 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -39,40 +39,6 @@
 #include <rdma/hns-abi.h>
 #include "hns_roce_common.h"
 
-static void hns_roce_ib_cq_comp(struct hns_roce_cq *hr_cq)
-{
-	struct ib_cq *ibcq = &hr_cq->ib_cq;
-
-	ibcq->comp_handler(ibcq, ibcq->cq_context);
-}
-
-static void hns_roce_ib_cq_event(struct hns_roce_cq *hr_cq,
-				 enum hns_roce_event event_type)
-{
-	struct hns_roce_dev *hr_dev;
-	struct ib_event event;
-	struct ib_cq *ibcq;
-
-	ibcq = &hr_cq->ib_cq;
-	hr_dev = to_hr_dev(ibcq->device);
-
-	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
-	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
-	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
-		dev_err(hr_dev->dev,
-			"hns_roce_ib: Unexpected event type 0x%x on CQ %06lx\n",
-			event_type, hr_cq->cqn);
-		return;
-	}
-
-	if (ibcq->event_handler) {
-		event.device = ibcq->device;
-		event.event = IB_EVENT_CQ_ERR;
-		event.element.cq = ibcq;
-		ibcq->event_handler(&event, ibcq->cq_context);
-	}
-}
-
 static int hns_roce_alloc_cqc(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_cq *hr_cq)
 {
@@ -434,10 +400,6 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	if (!udata && hr_cq->tptr_addr)
 		*hr_cq->tptr_addr = 0;
 
-	/* Get created cq handler and carry out event */
-	hr_cq->comp = hns_roce_ib_cq_comp;
-	hr_cq->event = hns_roce_ib_cq_event;
-
 	if (udata) {
 		resp.cqn = hr_cq->cqn;
 		ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
@@ -491,38 +453,57 @@ void hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn)
 {
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_cq *cq;
+	struct hns_roce_cq *hr_cq;
+	struct ib_cq *ibcq;
 
-	cq = xa_load(&hr_dev->cq_table.array, cqn & (hr_dev->caps.num_cqs - 1));
-	if (!cq) {
-		dev_warn(dev, "Completion event for bogus CQ 0x%08x\n", cqn);
+	hr_cq = xa_load(&hr_dev->cq_table.array,
+			cqn & (hr_dev->caps.num_cqs - 1));
+	if (!hr_cq) {
+		dev_warn(hr_dev->dev, "Completion event for bogus CQ 0x%06x\n",
+			 cqn);
 		return;
 	}
 
-	++cq->arm_sn;
-	cq->comp(cq);
+	++hr_cq->arm_sn;
+	ibcq = &hr_cq->ib_cq;
+	if (ibcq->comp_handler)
+		ibcq->comp_handler(ibcq, ibcq->cq_context);
 }
 
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 {
-	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_cq *cq;
+	struct hns_roce_cq *hr_cq;
+	struct ib_event event;
+	struct ib_cq *ibcq;
 
-	cq = xa_load(&cq_table->array, cqn & (hr_dev->caps.num_cqs - 1));
-	if (cq)
-		atomic_inc(&cq->refcount);
+	hr_cq = xa_load(&hr_dev->cq_table.array,
+			cqn & (hr_dev->caps.num_cqs - 1));
+	if (!hr_cq) {
+		dev_warn(dev, "Async event for bogus CQ 0x%06x\n", cqn);
+		return;
+	}
 
-	if (!cq) {
-		dev_warn(dev, "Async event for bogus CQ %08x\n", cqn);
+	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
+	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
+	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
+		dev_err(dev, "Unexpected event type 0x%x on CQ 0x%06x\n",
+			event_type, cqn);
 		return;
 	}
 
-	cq->event(cq, (enum hns_roce_event)event_type);
+	atomic_inc(&hr_cq->refcount);
 
-	if (atomic_dec_and_test(&cq->refcount))
-		complete(&cq->free);
+	ibcq = &hr_cq->ib_cq;
+	if (ibcq->event_handler) {
+		event.device = ibcq->device;
+		event.element.cq = ibcq;
+		event.event = IB_EVENT_CQ_ERR;
+		ibcq->event_handler(&event, ibcq->cq_context);
+	}
+
+	if (atomic_dec_and_test(&hr_cq->refcount))
+		complete(&hr_cq->free);
 }
 
 int hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 152701e..5617434 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -488,9 +488,6 @@ struct hns_roce_cq {
 	u8				db_en;
 	spinlock_t			lock;
 	struct ib_umem			*umem;
-	void (*comp)(struct hns_roce_cq *cq);
-	void (*event)(struct hns_roce_cq *cq, enum hns_roce_event event_type);
-
 	u32				cq_depth;
 	u32				cons_index;
 	u32				*set_ci_db;
-- 
2.8.1

