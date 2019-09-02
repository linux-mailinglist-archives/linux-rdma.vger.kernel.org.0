Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF42A5918
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfIBOTI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 10:19:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfIBOTI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 10:19:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82EH2Il110444
        for <linux-rdma@vger.kernel.org>; Mon, 2 Sep 2019 10:19:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2us1um5xsy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 02 Sep 2019 10:19:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Mon, 2 Sep 2019 15:19:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Sep 2019 15:19:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x82EIxgU48562282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Sep 2019 14:18:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0912611C04C;
        Mon,  2 Sep 2019 14:18:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D57AA11C04A;
        Mon,  2 Sep 2019 14:18:58 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Sep 2019 14:18:58 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     mkalderon@marvell.com, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [RFC] RDMA/siw: Fix xa_mmap helper patch
Date:   Mon,  2 Sep 2019 16:18:54 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19090214-0016-0000-0000-000002A5BA8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090214-0017-0000-0000-000033061D43
Message-Id: <20190902141854.19822-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909020161
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- make the siw_user_mmap_entry.address a void *, which
  naturally fits with remap_vmalloc_range. also avoids
  other casting during resource address assignment.

- do not kfree SQ/RQ/CQ/SRQ in preparation of mmap.
  Those resources are always further needed ;)

- Fix check for correct mmap range in siw_mmap().
  - entry->length is the object length. We have to
    expand to PAGE_ALIGN(entry->length), since mmap
    comes with complete page(s) containing the
    object.
  - put mmap_entry if that check fails. Otherwise
    entry object ref counting screws up, and later
    crashes during context close.

- simplify siw_mmap_free() - it must just free
  the entry.
---
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 59 +++++++++------------------
 2 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index d48cd42ae43e..d62f18f49ac5 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -505,7 +505,7 @@ struct iwarp_msg_info {
 
 struct siw_user_mmap_entry {
 	struct rdma_user_mmap_entry rdma_entry;
-	u64 address;
+	void *address;
 	u64 length;
 };
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 9e049241051e..24bdf5b508e6 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -36,10 +36,7 @@ static char ib_qp_state_to_string[IB_QPS_ERR + 1][sizeof("RESET")] = {
 
 void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
-	struct siw_user_mmap_entry *entry = to_siw_mmap_entry(rdma_entry);
-
-	vfree((void *)entry->address);
-	kfree(entry);
+	kfree(rdma_entry);
 }
 
 int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
@@ -56,29 +53,28 @@ int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 	 */
 	if (vma->vm_start & (PAGE_SIZE - 1)) {
 		pr_warn("siw: mmap not page aligned\n");
-		goto out;
+		return -EINVAL;
 	}
 	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, off,
 					      size, vma);
 	if (!rdma_entry) {
 		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %u\n",
 			off, size);
-		goto out;
+		return -EINVAL;
 	}
 	entry = to_siw_mmap_entry(rdma_entry);
-	if (entry->length != size) {
+	if (PAGE_ALIGN(entry->length) != size) {
 		siw_dbg(&uctx->sdev->base_dev,
 			"key[%#lx] does not have valid length[%#x] expected[%#llx]\n",
 			off, size, entry->length);
+		rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
 		return -EINVAL;
 	}
-
-	rv = remap_vmalloc_range(vma, (void *)entry->address, 0);
+	rv = remap_vmalloc_range(vma, entry->address, 0);
 	if (rv) {
 		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off, size);
 		rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
 	}
-out:
 	return rv;
 }
 
@@ -270,7 +266,7 @@ void siw_qp_put_ref(struct ib_qp *base_qp)
 }
 
 static int siw_user_mmap_entry_insert(struct ib_ucontext *ucontext,
-				      u64 address, u64 length,
+				      void *address, u64 length,
 				      u64 *key)
 {
 	struct siw_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -461,30 +457,22 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		if (qp->sendq) {
 			length = num_sqe * sizeof(struct siw_sqe);
 			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
-							(uintptr_t)qp->sendq,
-							length, &key);
-			if (!rv)
+							qp->sendq, length,
+							&key);
+			if (rv)
 				goto err_out_xa;
 
-			/* If entry was inserted successfully, qp->sendq
-			 * will be freed by siw_mmap_free
-			 */
-			qp->sendq = NULL;
 			qp->sq_key = key;
 		}
 
 		if (qp->recvq) {
 			length = num_rqe * sizeof(struct siw_rqe);
 			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
-							(uintptr_t)qp->recvq,
-							length, &key);
-			if (!rv)
+							qp->recvq, length,
+							&key);
+			if (rv)
 				goto err_out_mmap_rem;
 
-			/* If entry was inserted successfully, qp->recvq will
-			 * be freed by siw_mmap_free
-			 */
-			qp->recvq = NULL;
 			qp->rq_key = key;
 		}
 
@@ -1078,16 +1066,11 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 			     sizeof(struct siw_cq_ctrl);
 
 		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
-						(uintptr_t)cq->queue,
-						length, &cq->cq_key);
-		if (!rv)
+						cq->queue, length,
+						&cq->cq_key);
+		if (rv)
 			goto err_out;
 
-		/* If entry was inserted successfully, cq->queue will be freed
-		 * by siw_mmap_free
-		 */
-		cq->queue = NULL;
-
 		uresp.cq_key = cq->cq_key;
 		uresp.cq_id = cq->id;
 		uresp.num_cqe = size;
@@ -1535,15 +1518,11 @@ int siw_create_srq(struct ib_srq *base_srq,
 		u64 length = srq->num_rqe * sizeof(struct siw_rqe);
 
 		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
-						(uintptr_t)srq->recvq,
-						length, &srq->srq_key);
-		if (!rv)
+						srq->recvq, length,
+						&srq->srq_key);
+		if (rv)
 			goto err_out;
 
-		/* If entry was inserted successfully, srq->recvq will be freed
-		 * by siw_mmap_free
-		 */
-		srq->recvq = NULL;
 		uresp.srq_key = srq->srq_key;
 		uresp.num_rqe = srq->num_rqe;
 
-- 
2.17.2

