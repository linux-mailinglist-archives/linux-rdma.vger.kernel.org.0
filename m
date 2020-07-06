Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D685A215F65
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGFTca (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 15:32:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12722 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgGFTca (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 15:32:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066JU9TE002834;
        Mon, 6 Jul 2020 12:32:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=o0tIFuWCR3kCWpUKvgrK2e8IVQJNQvbZZb5dEWcjx6E=;
 b=Px4ETYa9HMX8IFaEJ++fQ4hAa4U64uRuja5JSvUZsd0xeVhFa0ejzwdVu1yY1BRgcewH
 QXtMrry0pE6K95zCepR3lHEbSTKYv5DmSGdWP9ndUTWYSRyZyu3+jbfAPIldCduZmFY+
 d66XZkBVxHTxQjyItnIYCX4aisx9MmssuMIXwwhhs5LD0br3SpsBmHTbrnvfESdsI0kK
 ij44lo6a4jRwT20C2NtktK+uc4H7EYKCRStoQsqtyphuc4RIm19vUnb0SinS+M97xY2Y
 H/rKpoAX3obtm0i830cfDJ0RyASVhZ5Vpwo8qEwCdd0JBZjZmKrW9s9dO1XGMBwu642s 6w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n7rey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:32:27 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 12:32:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 12:32:26 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 175793F703F;
        Mon,  6 Jul 2020 12:32:23 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Yuval Bason <yuval.bason@marvell.com>
Subject: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add EDPM mode type for user-fw compatibility
Date:   Mon, 6 Jul 2020 22:32:13 +0300
Message-ID: <20200706193214.19942-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200706193214.19942-1-michal.kalderon@marvell.com>
References: <20200706193214.19942-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_19:2020-07-06,2020-07-06 signatures=0
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

