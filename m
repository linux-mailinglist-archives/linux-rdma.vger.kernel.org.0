Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245B6D8FD7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfJPLpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 07:45:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:16406 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728578AbfJPLpV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 07:45:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GBdhiP012008;
        Wed, 16 Oct 2019 04:45:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=Iv3Xr8T2jSCuMHW0Dc6D3Ae2ZlnTHrfS/cRjz9rl/k0=;
 b=l130i6CVf45RKUnimdB+1wrJ6JFGVLSzkc5KZiOc4czuMVGOWy4uGMUCZ7ZKU0U4OFdZ
 ywmhKj90wH7r2ruG1hwkaEKzwDhWF3PZTFvyZbFCMVVd9soOZgvlJGMY06+WiB2DHCMm
 k2GirPh61xxoRndRo+eSbNwfn4S58nvZPWtWf23l7hKb/crmaSvaVkVcaz6i8QzzB+4g
 nnR1H+rxc/TfsUR1RcK/paxhNnQsm3JH6YIGcTLbyAPx2lWKF4EIQqlUhQK1xeS3c2W4
 xJVUZYXrfrY6PWOAQoZ9QwqRSUckje4SXPYC12kMbgpsYyBZrd0n1gKhECwep/09jwBl kQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vnpmbjmcp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 04:45:19 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 04:45:11 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 16 Oct 2019 04:45:11 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 72ED83F704A;
        Wed, 16 Oct 2019 04:45:09 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v2 rdma-next 2/2] RDMA/qedr: Fix memory leak in user qp and mr
Date:   Wed, 16 Oct 2019 14:42:42 +0300
Message-ID: <20191016114242.10736-3-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191016114242.10736-1-michal.kalderon@marvell.com>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User QPs pbl's won't freed properly.
MR pbls won't freed properly.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index dbb0b0000594..8d4164380984 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1581,6 +1581,14 @@ static void qedr_cleanup_user(struct qedr_dev *dev, struct qedr_qp *qp)
 
 	ib_umem_release(qp->urq.umem);
 	qp->urq.umem = NULL;
+
+	if (rdma_protocol_roce(&dev->ibdev, 1)) {
+		qedr_free_pbl(dev, &qp->usq.pbl_info, qp->usq.pbl_tbl);
+		qedr_free_pbl(dev, &qp->urq.pbl_info, qp->urq.pbl_tbl);
+	} else {
+		kfree(qp->usq.pbl_tbl);
+		kfree(qp->urq.pbl_tbl);
+	}
 }
 
 static int qedr_create_user_qp(struct qedr_dev *dev,
@@ -2671,8 +2679,8 @@ int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	dev->ops->rdma_free_tid(dev->rdma_ctx, mr->hw_mr.itid);
 
-	if ((mr->type != QEDR_MR_DMA) && (mr->type != QEDR_MR_FRMR))
-		qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
+	if (mr->type != QEDR_MR_DMA)
+		free_mr_info(dev, &mr->info);
 
 	/* it could be user registered memory. */
 	ib_umem_release(mr->umem);
-- 
2.14.5

