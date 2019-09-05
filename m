Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB4A9F31
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2019 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfIEKDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Sep 2019 06:03:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9672 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730959AbfIEKDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Sep 2019 06:03:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85A07qJ009501;
        Thu, 5 Sep 2019 03:03:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=Ii5dfxpMJatjvnacwJ+dlzeD4jiojVstksmhZz86nZ8=;
 b=mPEqCbBXX0rogi/MIu9vVL9jTsU3PxK85GrireK4VemulPNiDK+XNYFXEEEGGV73DMKZ
 tnBu8cXQviB+uPbFX3fHrEXy+i/dE8Y2N6xqttEhKBKulh2wGKbvgMHUCJ0KkmMGevMi
 pflDyh/EeXGVptn3zfi71LAUodLxxY84kA+lRxGm/1rcGa87EhoIN/WBMQDQ1rO8XBLP
 0qLEWqa1Ee9il97Udw0un/x4dA113wJLQdMfzjZVjFyrsvTTh57WmqN7VbF02qBgFoXj
 9JbRni72lPGixdW2f9gNDwHtol/l7LnGCYI+9XbPuQCfMDi/DEZap1mOY/ke0KdIa+bY 8A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmhy48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 03:03:17 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Sep
 2019 03:03:14 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 5 Sep 2019 03:03:14 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id D8C463F7045;
        Thu,  5 Sep 2019 03:03:11 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v11 rdma-next 7/7] RDMA/qedr: Add iWARP doorbell recovery support
Date:   Thu, 5 Sep 2019 13:01:17 +0300
Message-ID: <20190905100117.20879-8-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190905100117.20879-1-michal.kalderon@marvell.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_03:2019-09-04,2019-09-05 signatures=0
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
index 04f6f4fbe276..7661d767815c 100644
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
index 922c203ca0ea..524dd3682d8d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1738,6 +1738,10 @@ static void qedr_cleanup_user(struct qedr_dev *dev,
 		rdma_user_mmap_entry_remove(&ctx->ibucontext,
 					    qp->urq.db_rec_key);
 	}
+
+	if (rdma_protocol_iwarp(&dev->ibdev, 1))
+		qedr_db_recovery_del(dev, qp->urq.db_rec_db2_addr,
+				     &qp->urq.db_rec_db2_data);
 }
 
 static int qedr_create_user_qp(struct qedr_dev *dev,
@@ -1812,6 +1816,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
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
@@ -1825,6 +1840,15 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
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
@@ -1865,7 +1889,13 @@ static int qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
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
 
@@ -1994,8 +2024,13 @@ static void qedr_cleanup_kernel(struct qedr_dev *dev, struct qedr_qp *qp)
 
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

