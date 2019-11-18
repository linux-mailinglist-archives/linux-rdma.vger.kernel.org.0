Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD361007E5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 16:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKRPJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 10:09:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:12960 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbfKRPJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Nov 2019 10:09:44 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIExY3R009686;
        Mon, 18 Nov 2019 07:09:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=RAYQ7Gcndt4ftRtTg6mREK+LzB+/1m7ttyluaCZyg90=;
 b=Yi16fPxM7xF1H8vEnY0xaNtggOW+fqV7u6uIe0Xhi6nQpA++/5vleTPhsJsQJ+0jYqNC
 5W6Usgm9kxRtOs3F8VQCGP2eBSc6HOL9qHteZq2fgasnpeVk5CMmJ43UyVpAoJ1lSHlv
 7/XzqILhIsb07xWFdDiWunZ6ynV80R1lNRC3Tq0pNiunFLcsJvckG+Dj7p/whpbAQJPN
 z6vcbpc5NqeOB5uZifgSVdj175m5woEQLdGvlXN260N56XDv39f1bWyviS1azgVQ1KYe
 Axw8ttQvtwsAFO5fr0K4yQAph1LfQf6Kn37XoPfWo1tXWGUBnn2jySGutakYNKaly254 rg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wafbv732k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 07:09:40 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Nov
 2019 07:09:39 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 18 Nov 2019 07:09:39 -0800
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 230C03F703F;
        Mon, 18 Nov 2019 07:09:37 -0800 (PST)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <ariel.elior@marvell.com>,
        <michal.kalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/qedr: Fix null-pointer dereference when calling rdma_user_mmap_get_offset
Date:   Mon, 18 Nov 2019 17:06:45 +0200
Message-ID: <20191118150645.26602-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_03:2019-11-15,2019-11-18 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When running against rdma-core that doesn't support doorbell
recovery, the rdma_user_mmap_entry won't be allocated for
doorbell recovery related mappings.
We have a flag indicating whether rdma-core supports doorbell
recovery or not which was used during initialization, however
some cases didn't check that the rdma_user_mmap_entry exists
before attempting to acquire it's offset.

Fixes: 97f612509294 ("RDMA/qedr: Add doorbell overflow recovery support")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 9c0887c61f72..3f3f0ef2f901 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -697,7 +697,9 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 
 	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
-	uresp.db_rec_addr = rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
+	if (cq->q.db_mmap_entry)
+		uresp.db_rec_addr =
+			rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
 
 	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (rc)
@@ -1026,7 +1028,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (udata) {
 		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
 		ib_umem_release(cq->q.umem);
-		if (ctx)
+		if (cq->q.db_mmap_entry)
 			rdma_user_mmap_entry_remove(cq->q.db_mmap_entry);
 	} else {
 		dev->ops->common->chain_free(dev->cdev, &cq->pbl);
@@ -1259,7 +1261,9 @@ static void qedr_copy_rq_uresp(struct qedr_dev *dev,
 	}
 
 	uresp->rq_icid = qp->icid;
-	uresp->rq_db_rec_addr = rdma_user_mmap_get_offset(qp->urq.db_mmap_entry);
+	if (qp->urq.db_mmap_entry)
+		uresp->rq_db_rec_addr =
+			rdma_user_mmap_get_offset(qp->urq.db_mmap_entry);
 }
 
 static void qedr_copy_sq_uresp(struct qedr_dev *dev,
@@ -1274,8 +1278,9 @@ static void qedr_copy_sq_uresp(struct qedr_dev *dev,
 	else
 		uresp->sq_icid = qp->icid + 1;
 
-	uresp->sq_db_rec_addr =
-		rdma_user_mmap_get_offset(qp->usq.db_mmap_entry);
+	if (qp->usq.db_mmap_entry)
+		uresp->sq_db_rec_addr =
+			rdma_user_mmap_get_offset(qp->usq.db_mmap_entry);
 }
 
 static int qedr_copy_qp_uresp(struct qedr_dev *dev,
-- 
2.20.1

