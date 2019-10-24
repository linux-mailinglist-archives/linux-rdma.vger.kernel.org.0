Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F36E3A71
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394104AbfJXRzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 13:55:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16590 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394091AbfJXRzf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OHoEvF028330;
        Thu, 24 Oct 2019 10:55:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=TERpucAj0h99GZfEjby9v3mtST9xrR0g5dl0nBI4N8g=;
 b=X2KZlXfY17C3pyQzu/gv6aznb79fxRnlApp6d3sMXot4w+HJnViKYRMX6/FeR5lNUIb7
 FWbAW8BT6i6wxg4Hgt0GOJiNwNVPK5759pIRhUWBBelXC+ObjH2SM9QHUA6Az+ke8nCH
 o/hudPNBIet6bq9Snin6oVSIC/1bT/VomzlvG5Z41bgLW5lz2m6Sj4OMMQrSQ9HoGnQl
 KBQnq1KRb8pUrOEnq3dTtzk36KRdrOAkDldQjXpwhsOA2qsDVLTUu0HdopxTEgW7bDkI
 zhnTcbKwG/SYiaaDLRYeag5gLLAUwIlMziuzBQlLCgY9X2UbVPVgQSZOSp1Eu4p0g7ZU FA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vt9ujrhhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 10:55:32 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 10:55:30 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 24 Oct 2019 10:55:30 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 096EF3F7040;
        Thu, 24 Oct 2019 10:55:28 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v3 rdma-next 3/3] RDMA/qedr: Fix memory leak in user qp and mr
Date:   Thu, 24 Oct 2019 20:52:53 +0300
Message-ID: <20191024175253.26816-4-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191024175253.26816-1-michal.kalderon@marvell.com>
References: <20191024175253.26816-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_10:2019-10-23,2019-10-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User QPs pbl's won't freed properly.
MR pbls won't freed properly.

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

