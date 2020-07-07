Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D554B216662
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGGbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 02:31:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9334 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGGbJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 02:31:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0676UVDg029250;
        Mon, 6 Jul 2020 23:31:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=o0tIFuWCR3kCWpUKvgrK2e8IVQJNQvbZZb5dEWcjx6E=;
 b=BtqXHDpHOlMtbS03GKKT/OkfxpuSNin0qHrcvOg7y1MPDqxLqtUsPaOM/2TSd/M2FxA9
 ZWGwnOHe0sQ5B8T2wVjsLJV8W/35itx23zBl089r3CkRqXmAU2zjjxXy/zg5bff0daxX
 V6NpK5lowoFV2gXAwOubKKJ4QlzRm6iZGj4I/igM5DcH29nKqRYYl8S5YfJadmUX7erd
 ngMqb0fu6yxT4EFbBo3DNpwfQPUqFF3Q1kSGhiJZn/XQ8Wg5wxB2WgGARhdK87/Pl2aq
 UpabiSu7FGfsGB/K3nQgVk9KfVZznZGUoXcbKnLwnsGEGKVLPhE0u562Zn7Ki3zs5xep Yg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n9pmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 23:31:06 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 23:31:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 23:31:05 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id A9B323F703F;
        Mon,  6 Jul 2020 23:31:03 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v3 rdma-next 1/2] RDMA/qedr: Add EDPM mode type for user-fw compatibility
Date:   Tue, 7 Jul 2020 09:30:59 +0300
Message-ID: <20200707063100.3811-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200707063100.3811-1-michal.kalderon@marvell.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_05:2020-07-07,2020-07-07 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In older FW versions the completion flag was treated as the ack flag
in edpm messages.
commit ff937b916eb6 ("qed: Add EDPM mode type for user-fw compatibility")
exposed the FW option of setting which mode the QP is in by
adding a flag to the qedr <-> qed API.

This patch adds the qedr <-> libqedr interface so that the libqedr
can set the flag appropriately and qedr can pass it down to FW.
Flag is added for backward compatibility with libqedr.

For older libs, this flag didn't exist and therefore set to zero.

Fixes: ac1b36e55a51 ("qedr: Add support for user context verbs")
Signed-off-by: Yuval Bason <yuval.bason@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr.h  |  1 +
 drivers/infiniband/hw/qedr/verbs.c | 11 ++++++++---
 include/uapi/rdma/qedr-abi.h       |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index fdf90ecb2699..13d5eafb553f 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -235,6 +235,7 @@ struct qedr_ucontext {
 	u32 dpi_size;
 	u16 dpi;
 	bool db_rec;
+	u8 edpm_mode;
 };
 
 union db_prod32 {
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 9b9e80266367..fbb0c66c7f2c 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -275,7 +275,8 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 			DP_ERR(dev, "Problem copying data from user space\n");
 			return -EFAULT;
 		}
-
+		ctx->edpm_mode = !!(ureq.context_flags &
+				    QEDR_ALLOC_UCTX_EDPM_MODE);
 		ctx->db_rec = !!(ureq.context_flags & QEDR_ALLOC_UCTX_DB_REC);
 	}
 
@@ -316,7 +317,8 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 		uresp.dpm_flags = QEDR_DPM_TYPE_IWARP_LEGACY;
 	else
 		uresp.dpm_flags = QEDR_DPM_TYPE_ROCE_ENHANCED |
-				  QEDR_DPM_TYPE_ROCE_LEGACY;
+				  QEDR_DPM_TYPE_ROCE_LEGACY |
+				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
 
 	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
 	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
@@ -1750,7 +1752,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	struct qed_rdma_create_qp_out_params out_params;
 	struct qedr_pd *pd = get_qedr_pd(ibpd);
 	struct qedr_create_qp_uresp uresp;
-	struct qedr_ucontext *ctx = NULL;
+	struct qedr_ucontext *ctx = pd ? pd->uctx : NULL;
 	struct qedr_create_qp_ureq ureq;
 	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
 	int rc = -EINVAL;
@@ -1788,6 +1790,9 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 		in_params.rq_pbl_ptr = qp->urq.pbl_tbl->pa;
 	}
 
+	if (ctx)
+		SET_FIELD(in_params.flags, QED_ROCE_EDPM_MODE, ctx->edpm_mode);
+
 	qp->qed_qp = dev->ops->rdma_create_qp(dev->rdma_ctx,
 					      &in_params, &out_params);
 
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index a0b83c9d4498..b261c9fca07b 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -39,7 +39,7 @@
 
 /* user kernel communication data structures. */
 enum qedr_alloc_ucontext_flags {
-	QEDR_ALLOC_UCTX_RESERVED	= 1 << 0,
+	QEDR_ALLOC_UCTX_EDPM_MODE	= 1 << 0,
 	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1
 };
 
@@ -56,7 +56,7 @@ enum qedr_rdma_dpm_type {
 	QEDR_DPM_TYPE_ROCE_ENHANCED	= 1 << 0,
 	QEDR_DPM_TYPE_ROCE_LEGACY	= 1 << 1,
 	QEDR_DPM_TYPE_IWARP_LEGACY	= 1 << 2,
-	QEDR_DPM_TYPE_RESERVED		= 1 << 3,
+	QEDR_DPM_TYPE_ROCE_EDPM_MODE	= 1 << 3,
 	QEDR_DPM_SIZES_SET		= 1 << 4,
 };
 
-- 
2.14.5

