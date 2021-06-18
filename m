Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC973AC868
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFRKJC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:09:02 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8273 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhFRKJB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:09:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5vb30lMlz1BNvg;
        Fri, 18 Jun 2021 18:01:35 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about hr_reg_write()
Date:   Fri, 18 Jun 2021 18:05:58 +0800
Message-ID: <1624010765-1029-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix complains from sparse about "dubious: x & !y" when calling
hr_reg_write(ctx, field, !!val) by using "val ? 1 : 0" instead of "!!val".

Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fields")
Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC")
Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..6452ccc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3013,15 +3013,15 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
 
 	hr_reg_write(mpt_entry, MPT_BIND_EN,
-		     !!(mr->access & IB_ACCESS_MW_BIND));
+		     mr->access & IB_ACCESS_MW_BIND ? 1 : 0);
 	hr_reg_write(mpt_entry, MPT_ATOMIC_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_ATOMIC));
+		     mr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
 	hr_reg_write(mpt_entry, MPT_RR_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_READ));
+		     mr->access & IB_ACCESS_REMOTE_READ ? 1 : 0);
 	hr_reg_write(mpt_entry, MPT_RW_EN,
-		     !!(mr->access & IB_ACCESS_REMOTE_WRITE));
+		     mr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
 	hr_reg_write(mpt_entry, MPT_LW_EN,
-		     !!((mr->access & IB_ACCESS_LOCAL_WRITE)));
+		     mr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
 
 	mpt_entry->len_l = cpu_to_le32(lower_32_bits(mr->size));
 	mpt_entry->len_h = cpu_to_le32(upper_32_bits(mr->size));
@@ -5617,7 +5617,7 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
 	hr_reg_write(ctx, SRQC_SRQ_TYPE,
-		     !!(srq->ibsrq.srq_type == IB_SRQT_XRC));
+		     srq->ibsrq.srq_type == IB_SRQT_XRC ? 1 : 0);
 	hr_reg_write(ctx, SRQC_PD, to_hr_pd(srq->ibsrq.pd)->pdn);
 	hr_reg_write(ctx, SRQC_SRQN, srq->srqn);
 	hr_reg_write(ctx, SRQC_XRCD, srq->xrcdn);
@@ -6168,7 +6168,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	hr_reg_write(eqc, EQC_NEX_EQE_BA_L, eqe_ba[1] >> 12);
 	hr_reg_write(eqc, EQC_NEX_EQE_BA_H, eqe_ba[1] >> 44);
 	hr_reg_write(eqc, EQC_EQE_SIZE,
-		     !!(eq->eqe_size == HNS_ROCE_V3_EQE_SIZE));
+		     eq->eqe_size == HNS_ROCE_V3_EQE_SIZE ? 1 : 0);
 
 	return 0;
 }
-- 
2.7.4

