Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950A03AC87F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhFRKNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5400 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhFRKND (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:13:03 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5vk53sGkz71Bs;
        Fri, 18 Jun 2021 18:07:41 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 08/10] RDMA/hns: Encapsulate flushing CQE as a function
Date:   Fri, 18 Jun 2021 18:10:18 +0800
Message-ID: <1624011020-16992-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The process of flushing CQE can be encapsultated into a function, which can
reduce duplicate code.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 36 +++--------------------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 19 +++++++++++++--
 3 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c5524f1..9467b3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1259,6 +1259,7 @@ void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db);
 
 void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
+void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
 u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u32 port, int gid_index);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8d8f4d4..921899f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -629,18 +629,8 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *qp)
 {
-	/*
-	 * Hip08 hardware cannot flush the WQEs in SQ if the QP state
-	 * gets into errored mode. Hence, as a workaround to this
-	 * hardware limitation, driver needs to assist in flushing. But
-	 * the flushing operation uses mailbox to convey the QP state to
-	 * the hardware and which can sleep due to the mutex protection
-	 * around the mailbox calls. Hence, use the deferred flush for
-	 * now.
-	 */
 	if (unlikely(qp->state == IB_QPS_ERR)) {
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
-			init_flush_work(hr_dev, qp);
+		flush_cqe(hr_dev, qp);
 	} else {
 		struct hns_roce_v2_db sq_db = {};
 
@@ -663,18 +653,8 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 static inline void update_rq_db(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *qp)
 {
-	/*
-	 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
-	 * gets into errored mode. Hence, as a workaround to this
-	 * hardware limitation, driver needs to assist in flushing. But
-	 * the flushing operation uses mailbox to convey the QP state to
-	 * the hardware and which can sleep due to the mutex protection
-	 * around the mailbox calls. Hence, use the deferred flush for
-	 * now.
-	 */
 	if (unlikely(qp->state == IB_QPS_ERR)) {
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
-			init_flush_work(hr_dev, qp);
+		flush_cqe(hr_dev, qp);
 	} else {
 		if (likely(qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)) {
 			*qp->rdb.db_record =
@@ -3514,17 +3494,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 	if (cqe_status == HNS_ROCE_CQE_V2_GENERAL_ERR)
 		return;
 
-	/*
-	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state gets
-	 * into errored mode. Hence, as a workaround to this hardware
-	 * limitation, driver needs to assist in flushing. But the flushing
-	 * operation uses mailbox to convey the QP state to the hardware and
-	 * which can sleep due to the mutex protection around the mailbox calls.
-	 * Hence, use the deferred flush for now. Once wc error detected, the
-	 * flushing operation is needed.
-	 */
-	if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
-		init_flush_work(hr_dev, qp);
+	flush_cqe(hr_dev, qp);
 }
 
 static int get_cur_qp(struct hns_roce_cq *hr_cq, struct hns_roce_v2_cqe *cqe,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5196369..8a2076d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -79,6 +79,21 @@ void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	queue_work(hr_dev->irq_workq, &flush_work->work);
 }
 
+void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp)
+{
+	/*
+	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state
+	 * gets into errored mode. Hence, as a workaround to this
+	 * hardware limitation, driver needs to assist in flushing. But
+	 * the flushing operation uses mailbox to convey the QP state to
+	 * the hardware and which can sleep due to the mutex protection
+	 * around the mailbox calls. Hence, use the deferred flush for
+	 * now.
+	 */
+	if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+		init_flush_work(dev, qp);
+}
+
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 {
 	struct device *dev = hr_dev->dev;
@@ -102,8 +117,8 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	     event_type == HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION ||
 	     event_type == HNS_ROCE_EVENT_TYPE_INVALID_XRCETH)) {
 		qp->state = IB_QPS_ERR;
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
-			init_flush_work(hr_dev, qp);
+
+		flush_cqe(hr_dev, qp);
 	}
 
 	qp->event(qp, (enum hns_roce_event)event_type);
-- 
2.7.4

