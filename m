Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD2A2307E1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgG1Kn0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 06:43:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728709AbgG1KnY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 06:43:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD88A64D86DA46CA6805;
        Tue, 28 Jul 2020 18:43:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 18:43:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 7/7] RDMA/hns: Fix the unneeded process when getting a general type of CQE error
Date:   Tue, 28 Jul 2020 18:42:21 +0800
Message-ID: <1595932941-40613-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
References: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If the hns ROCEE reports a general error CQE (types not specified by the IB
General Specifications), it's no need to change the QP state to error, and
the driver should just skip it.

Fixes: 7c044adca272 ("RDMA/hns: Simplify the cqe code of poll cq")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0c81100..d51b332 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3046,6 +3046,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		  IB_WC_RETRY_EXC_ERR },
 		{ HNS_ROCE_CQE_V2_RNR_RETRY_EXC_ERR, IB_WC_RNR_RETRY_EXC_ERR },
 		{ HNS_ROCE_CQE_V2_REMOTE_ABORT_ERR, IB_WC_REM_ABORT_ERR },
+		{ HNS_ROCE_CQE_V2_GENERAL_ERR, IB_WC_GENERAL_ERR}
 	};
 
 	u32 cqe_status = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_STATUS_M,
@@ -3068,6 +3069,14 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		       sizeof(*cqe), false);
 
 	/*
+	 * For hns ROCEE, GENERAL_ERR is an error type that is not defined in
+	 * the standard protocol, the driver must ignore it and needn't to set
+	 * the QP to an error state.
+	 */
+	if (cqe_status == HNS_ROCE_CQE_V2_GENERAL_ERR)
+		return;
+
+	/*
 	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state gets
 	 * into errored mode. Hence, as a workaround to this hardware
 	 * limitation, driver needs to assist in flushing. But the flushing
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 53c26f3..1fb1c58 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -214,6 +214,7 @@ enum {
 	HNS_ROCE_CQE_V2_TRANSPORT_RETRY_EXC_ERR		= 0x15,
 	HNS_ROCE_CQE_V2_RNR_RETRY_EXC_ERR		= 0x16,
 	HNS_ROCE_CQE_V2_REMOTE_ABORT_ERR		= 0x22,
+	HNS_ROCE_CQE_V2_GENERAL_ERR			= 0x23,
 
 	HNS_ROCE_V2_CQE_STATUS_MASK			= 0xff,
 };
-- 
2.8.1

