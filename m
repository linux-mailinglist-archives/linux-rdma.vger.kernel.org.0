Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE969E96A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfH0Nbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:31:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60018 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfH0Nbu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 09:31:50 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RDUdJ4006576;
        Tue, 27 Aug 2019 06:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=/ua8lF83KqzPsVDVk3mPQD4/Th3ygZwGVHNkMlpbDJw=;
 b=bG1dKJc+zSvwV36IKP0DkmaO2wy2kXizhTBYp4SRVls/lne8ffituq/FG5qyf0st33+1
 ja/IKnMnPkNsLu3ZH7rlmyG9PGN2x0WU9Efv4BBvN6AqcBNiQToDDm/mzOQOy8gc4MpQ
 XtZKigRVyiZjO43sK9yRgaRekfl9JbNTEH2IIv32G1VqtiSadLJJEqq/fLeIyNNwg2cd
 RvmDLK9V1pN0wwnPAp8Yv61+Yb2wx4+Isp2Kq9txgtgmuRa+RPwm1rt0dQDEw7G5ELJ8
 /Q5jBOgF3XQZs+1aBwo9mRCc9wBTqv0NOyzLMcyjtgNkKD+eAW7/Nj0qv/ZCvCC9TrTr xg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkjp4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 06:31:45 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 06:31:44 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 27 Aug 2019 06:31:44 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 3BC703F7044;
        Tue, 27 Aug 2019 06:31:41 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v8 rdma-next 7/7] RDMA/qedr: Add iWARP doorbell recovery support
Date:   Tue, 27 Aug 2019 16:28:46 +0300
Message-ID: <20190827132846.9142-8-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190827132846.9142-1-michal.kalderon@marvell.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_02:2019-08-27,2019-08-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds the iWARP specific doorbells to the doorbell
recovery mechanism

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr.h  | 12 +++++++-----
 drivers/infiniband/hw/qedr/verbs.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 8cb12b3396d5..07d8ba2a82b2 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -237,6 +237,11 @@ struct qedr_ucontext {
 	bool db_rec;
 };
 
+union db_prod32 {
+	struct rdma_pwm_val16_data data;
+	u32 raw;
+};
+
 union db_prod64 {
 	struct rdma_pwm_val32_data data;
 	u64 raw;
@@ -268,6 +273,8 @@ struct qedr_userq {
 	struct qedr_user_db_rec *db_rec_data;
 	u64 db_rec_phys;
 	u64 db_rec_key;
+	void __iomem *db_rec_db2_addr;
+	union db_prod32 db_rec_db2_data;
 };
 
 struct qedr_cq {
@@ -303,11 +310,6 @@ struct qedr_pd {
 	struct qedr_ucontext *uctx;
 };
 
-union db_prod32 {
-	struct rdma_pwm_val16_data data;
-	u32 raw;
-};
-
 struct qedr_qp_hwq_info {
 	/* WQE Elements */
 	struct qed_chain pbl;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 205985490df1..43c9536d0f5d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1733,6 +1733,10 @@ static void qedr_cleanup_user(struct qedr_dev *dev,
 		rdma_user_mmap_entry_remove(&ctx->ibucontext,
 					    qp->urq.db_rec_key);
 	}
+
+	if (rdma_protocol_iwarp(&dev->ibdev, 1))
+		qedr_db_recovery_del(dev, qp->urq.db_rec_db2_addr,
+				     &qp->urq.db_rec_db2_data);
 }
 
 static int qedr_create_user_qp(struct qedr_dev *dev,
@@ -1807,6 +1811,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
 	qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
 
+	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
+		qp->urq.db_rec_db2_addr = ctx->dpi_addr + uresp.rq_db2_offset;
+
+		/* calculate the db_rec_db2 data since it is constant so no
+		 *  need to reflect from user
+		 */
+		qp->urq.db_rec_db2_data.data.icid = cpu_to_le16(qp->icid);
+		qp->urq.db_rec_db2_data.data.value =
+			cpu_to_le16(DQ_TCM_IWARP_POST_RQ_CF_CMD);
+	}
+
 	rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
 				  &qp->usq.db_rec_data->db_data,
 				  DB_REC_WIDTH_32B,
@@ -1820,6 +1835,15 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 				  DB_REC_USER);
 	if (rc)
 		goto err;
+
+	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
+		rc = qedr_db_recovery_add(dev, qp->urq.db_rec_db2_addr,
+					  &qp->urq.db_rec_db2_data,
+					  DB_REC_WIDTH_32B,
+					  DB_REC_USER);
+		if (rc)
+			goto err;
+	}
 	qedr_qp_user_print(dev, qp);
 
 	return rc;
@@ -1860,7 +1884,13 @@ static int qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
 				  &qp->rq.db_data,
 				  DB_REC_WIDTH_32B,
 				  DB_REC_KERNEL);
+	if (rc)
+		return rc;
 
+	rc = qedr_db_recovery_add(dev, qp->rq.iwarp_db2,
+				  &qp->rq.iwarp_db2_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_KERNEL);
 	return rc;
 }
 
@@ -1989,8 +2019,13 @@ static void qedr_cleanup_kernel(struct qedr_dev *dev, struct qedr_qp *qp)
 
 	qedr_db_recovery_del(dev, qp->sq.db, &qp->sq.db_data);
 
-	if (!qp->srq)
+	if (!qp->srq) {
 		qedr_db_recovery_del(dev, qp->rq.db, &qp->rq.db_data);
+
+		if (rdma_protocol_iwarp(&dev->ibdev, 1))
+			qedr_db_recovery_del(dev, qp->rq.iwarp_db2,
+					     &qp->rq.iwarp_db2_data);
+	}
 }
 
 static int qedr_create_kernel_qp(struct qedr_dev *dev,
-- 
2.14.5

