Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C0E653E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfJ0UHW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 16:07:22 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33596 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfJ0UHW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 16:07:22 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9RK5rYq011538;
        Sun, 27 Oct 2019 13:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=b92B3ODI6/rzNU/z2P8ctV/cPA6qsUaX0WlwswayyRo=;
 b=D31QIelFluVADachv99x+iltCUeC9RHfvffu+S7tIE8vQb3EO3KKl4Z1MAp2ept0lJpV
 00D+MXSspnRcKES8v3IP5LeMOSuHzCmBeCKZ2jedjoEdzn+HhmjqitxZL79G+L5IaAKh
 JFzRT14AIis3ewD3J9VbRU3Dh2/MVTksbPoAC/V7RyEriyIv8m+/nPoJ1YDSy105iurC
 /T839EgmNsBpBeglGfKOe75PCSWj9pT4RCV/pt0AMz+8g15s0VQcfEr3OPl5NHN+Al3a
 KsSpxUnucA05ae2fzxAHwcxrDl+VW6Xisn3MYKViah+UE9fBUe/CBSDgfInqIORYEnOt 0A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vvkgq3qcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 27 Oct 2019 13:07:20 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 27 Oct
 2019 13:07:19 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 27 Oct 2019 13:07:19 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id AF8DA3F7040;
        Sun, 27 Oct 2019 13:07:17 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v4 rdma-next 2/4] RDMA/qedr: Fix qpids xarray api used
Date:   Sun, 27 Oct 2019 22:04:49 +0200
Message-ID: <20191027200451.28187-3-michal.kalderon@marvell.com>
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

The qpids xarray isn't accessed from irq context and therefore there
is no need to use the xa_XXX_irq version of the apis.
Remove the _irq.

Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c       | 2 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
 drivers/infiniband/hw/qedr/verbs.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index aa0bda428690..1ff5407270d2 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -360,7 +360,7 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 	xa_init_flags(&dev->srqs, XA_FLAGS_LOCK_IRQ);
 
 	if (IS_IWARP(dev)) {
-		xa_init_flags(&dev->qps, XA_FLAGS_LOCK_IRQ);
+		xa_init(&dev->qps);
 		dev->iwarp_wq = create_singlethread_workqueue("qedr_iwarpq");
 	}
 
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 22881d4442b9..7fea74739c1f 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -739,7 +739,7 @@ void qedr_iw_qp_rem_ref(struct ib_qp *ibqp)
 	struct qedr_qp *qp = get_qedr_qp(ibqp);
 
 	if (atomic_dec_and_test(&qp->refcnt)) {
-		xa_erase_irq(&qp->dev->qps, qp->qp_id);
+		xa_erase(&qp->dev->qps, qp->qp_id);
 		kfree(qp);
 	}
 }
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..84b666c67cff 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1918,7 +1918,7 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 	qp->ibqp.qp_num = qp->qp_id;
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
-		rc = xa_insert_irq(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
+		rc = xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
 		if (rc)
 			goto err;
 	}
@@ -2492,7 +2492,7 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	if (atomic_dec_and_test(&qp->refcnt) &&
 	    rdma_protocol_iwarp(&dev->ibdev, 1)) {
-		xa_erase_irq(&dev->qps, qp->qp_id);
+		xa_erase(&dev->qps, qp->qp_id);
 		kfree(qp);
 	}
 	return 0;
-- 
2.14.5

