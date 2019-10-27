Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725A6E653F
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJ0UHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 16:07:25 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2906 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727683AbfJ0UHZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 16:07:25 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9RK5QsK011406;
        Sun, 27 Oct 2019 13:07:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=O9g1J0f9VD9PZTKR4yA8H6Hiv1vPHP6l8/5Y6+jznR0=;
 b=Vwg8wZq6xuU9rGcEPKIv8GohZ+9Nr2UZVZHHpmYJ+aZfDLkJvxdBrwE1HaMA+sjDafEh
 zdGHlJn/TqSKfHNfShhOu/1dMG71C22frbONCBfUFsIOPIQ+mjBmpzL6FE6evvcmjGrx
 YXh5eG/td1MLVpDZdars9r1zXmyx2+toX5LzGp/vya0u4nz0WJind133wL8PoZtdtmfy
 rXvOuaeIuJDcbBmvzbij8uDPtxfcRdLU+8mpU//f97VE6Cs0MPfgmywo3K6BpCsdGtZT
 HYiorlIzKT6WatOtKQJKjhQ8NNnALQ18CMI6Y8WhQ9PsqM82EfkZS3/O65ea8EnNqPpO dQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vvkgq3qcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 27 Oct 2019 13:07:24 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 27 Oct
 2019 13:07:22 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 27 Oct 2019 13:07:22 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 632D03F7041;
        Sun, 27 Oct 2019 13:07:21 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v4 rdma-next 4/4] RDMA/qedr: Fix memory leak in user qp and mr
Date:   Sun, 27 Oct 2019 22:04:51 +0200
Message-ID: <20191027200451.28187-5-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191027200451.28187-1-michal.kalderon@marvell.com>
References: <20191027200451.28187-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-27_08:2019-10-25,2019-10-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User QPs pbl's weren't freed properly.
MR pbls weren't freed properly.

Fixes: e0290cce6ac0 ("qedr: Add support for memory registeration verbs")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index a17b388ee3b3..8b4240c1cc76 100644
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
@@ -2689,8 +2697,8 @@ int qedr_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	dev->ops->rdma_free_tid(dev->rdma_ctx, mr->hw_mr.itid);
 
-	if ((mr->type != QEDR_MR_DMA) && (mr->type != QEDR_MR_FRMR))
-		qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
+	if (mr->type != QEDR_MR_DMA)
+		free_mr_info(dev, &mr->info);
 
 	/* it could be user registered memory. */
 	ib_umem_release(mr->umem);
-- 
2.14.5

