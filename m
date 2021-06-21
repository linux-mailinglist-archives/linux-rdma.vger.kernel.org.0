Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB43AE473
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUIDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:03:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5410 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFUID3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:03:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7hj35XPpz72Z6;
        Mon, 21 Jun 2021 15:57:59 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:13 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:13 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v5 for-next 3/9] RDMA/hns: Add hr_reg_write_bool()
Date:   Mon, 21 Jun 2021 16:00:37 +0800
Message-ID: <1624262443-24528-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
References: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

In order to avoid to do bitwise operations on a boolean value, add a new
register interface to avoid sparse comlaint about "dubious: x & !y" when
calling hr_reg_write(ctx, field, !!val).

Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fields")
Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h |  8 ++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 3a5658f..b73e55d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -77,6 +77,14 @@
 
 #define hr_reg_clear(ptr, field) _hr_reg_clear(ptr, field)
 
+#define _hr_reg_write_bool(ptr, field_type, field_h, field_l, val)             \
+	({                                                                     \
+		(val) ? _hr_reg_enable(ptr, field_type, field_h, field_l) :    \
+			_hr_reg_clear(ptr, field_type, field_h, field_l);      \
+	})
+
+#define hr_reg_write_bool(ptr, field, val) _hr_reg_write_bool(ptr, field, val)
+
 #define _hr_reg_write(ptr, field_type, field_h, field_l, val)                  \
 	({                                                                     \
 		_hr_reg_clear(ptr, field_type, field_h, field_l);              \
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2a4d748..7afecc6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3109,16 +3109,16 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
 	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
 
-	hr_reg_write(mpt_entry, MPT_BIND_EN,
-		     !!(mr->access & IB_ACCESS_MW_BIND));
-	hr_reg_write(mpt_entry, MPT_ATOMIC_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_ATOMIC));
-	hr_reg_write(mpt_entry, MPT_RR_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_READ));
-	hr_reg_write(mpt_entry, MPT_RW_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_WRITE));
-	hr_reg_write(mpt_entry, MPT_LW_EN,
-		     !!((mr->access & IB_ACCESS_LOCAL_WRITE)));
+	hr_reg_write_bool(mpt_entry, MPT_BIND_EN,
+			  mr->access & IB_ACCESS_MW_BIND);
+	hr_reg_write_bool(mpt_entry, MPT_ATOMIC_EN,
+			  mr->access & IB_ACCESS_REMOTE_ATOMIC);
+	hr_reg_write_bool(mpt_entry, MPT_RR_EN,
+			  mr->access & IB_ACCESS_REMOTE_READ);
+	hr_reg_write_bool(mpt_entry, MPT_RW_EN,
+			  mr->access & IB_ACCESS_REMOTE_WRITE);
+	hr_reg_write_bool(mpt_entry, MPT_LW_EN,
+			  mr->access & IB_ACCESS_LOCAL_WRITE);
 
 	mpt_entry->len_l = cpu_to_le32(lower_32_bits(mr->size));
 	mpt_entry->len_h = cpu_to_le32(upper_32_bits(mr->size));
@@ -5718,8 +5718,8 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	}
 
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
-	hr_reg_write(ctx, SRQC_SRQ_TYPE,
-		     !!(srq->ibsrq.srq_type == IB_SRQT_XRC));
+	hr_reg_write_bool(ctx, SRQC_SRQ_TYPE,
+			  srq->ibsrq.srq_type == IB_SRQT_XRC);
 	hr_reg_write(ctx, SRQC_PD, to_hr_pd(srq->ibsrq.pd)->pdn);
 	hr_reg_write(ctx, SRQC_SRQN, srq->srqn);
 	hr_reg_write(ctx, SRQC_XRCD, srq->xrcdn);
-- 
2.7.4

