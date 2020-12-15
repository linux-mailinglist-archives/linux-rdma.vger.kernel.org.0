Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2526E2DAD2A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 13:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgLOMYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 07:24:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729044AbgLOMYi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 07:24:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFCD3eH075677;
        Tue, 15 Dec 2020 07:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1Ke6IdGHfHQf/3VRLeN4JoR5y0TXK6UIBlUzSKCRduE=;
 b=bV3nODdijstu/dmXlc99MdDOM/w7iwtVkWsb22rjt8QQlbXKIhYDuJUq/+hNeCcicevW
 w6RHgBoNpVpSitxCdKpbgHAuhs0bQc8PeTtYDF23Kj1U7Om/x7TP05j04UCjsHZJrJWU
 +KViqCb0NkIMxdO8s0oWL3agKsYWhlfdT5YxvmgIVLajf+copqbNapcRADau4lue4LZ+
 f7ayvYt5y1G0V/WyBrDYqHwAREVIGKTz1RAMEkV5o28m70+NQQkS0gE9P+yJkJTZ/KLF
 4qwpfZ7CjCkuDaYOjoeiBvf/rq5s7JOuoZhv18cOJeZtJ1edtpiF44PG3Ci9yG0HyDoC Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35evxsr999-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:23:52 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BFCJ4Mf096263;
        Tue, 15 Dec 2020 07:23:51 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35evxsr98h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 07:23:51 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFCGgGD031160;
        Tue, 15 Dec 2020 12:23:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 35cng837p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 12:23:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BFCNlcb11731378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 12:23:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61C1411C04C;
        Tue, 15 Dec 2020 12:23:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D296911C050;
        Tue, 15 Dec 2020 12:23:44 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.163.44.2])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Dec 2020 12:23:44 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, jgg@nvidia.com,
        kamalheib1@gmail.com, yi.zhang@redhat.com,
        linux-nvme@lists.infradead.org
Subject: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive Queues.
Date:   Tue, 15 Dec 2020 13:23:06 +0100
Message-Id: <20201215122306.3886-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_10:2020-12-14,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=929 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150081
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

During connection setup, the application may choose to zero-size
inbound and outbound READ queues, as well as the Receive queue.
This patch fixes handling of zero-sized queues.

Reported-by: Kamal Heib <kamalheib1@gmail.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++++++++++++-----------
 drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++++++----
 drivers/infiniband/sw/siw/siw_qp_tx.c |  4 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++++--
 5 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index e9753831ac3f..6f17392f975a 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -654,7 +654,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
 {
 	struct siw_sqe *orq_e = orq_get_tail(qp);
 
-	if (orq_e && READ_ONCE(orq_e->flags) == 0)
+	if (READ_ONCE(orq_e->flags) == 0)
 		return orq_e;
 
 	return NULL;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 875d36d4b1c6..b686a09a75ae 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -199,26 +199,28 @@ void siw_qp_llp_write_space(struct sock *sk)
 
 static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
 {
-	irq_size = roundup_pow_of_two(irq_size);
-	orq_size = roundup_pow_of_two(orq_size);
-
-	qp->attrs.irq_size = irq_size;
-	qp->attrs.orq_size = orq_size;
-
-	qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
-	if (!qp->irq) {
-		siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
-		qp->attrs.irq_size = 0;
-		return -ENOMEM;
+	if (irq_size) {
+		irq_size = roundup_pow_of_two(irq_size);
+		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
+		if (!qp->irq) {
+			siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
+			qp->attrs.irq_size = 0;
+			return -ENOMEM;
+		}
 	}
-	qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
-	if (!qp->orq) {
-		siw_dbg_qp(qp, "orq malloc for %d failed\n", orq_size);
-		qp->attrs.orq_size = 0;
-		qp->attrs.irq_size = 0;
-		vfree(qp->irq);
-		return -ENOMEM;
+	if (orq_size) {
+		orq_size = roundup_pow_of_two(orq_size);
+		qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
+		if (!qp->orq) {
+			siw_dbg_qp(qp, "orq malloc for %d failed\n", orq_size);
+			qp->attrs.orq_size = 0;
+			qp->attrs.irq_size = 0;
+			vfree(qp->irq);
+			return -ENOMEM;
+		}
 	}
+	qp->attrs.irq_size = irq_size;
+	qp->attrs.orq_size = orq_size;
 	siw_dbg_qp(qp, "ORD %d, IRD %d\n", orq_size, irq_size);
 	return 0;
 }
@@ -288,13 +290,14 @@ int siw_qp_mpa_rts(struct siw_qp *qp, enum mpa_v2_ctrl ctrl)
 	if (ctrl & MPA_V2_RDMA_WRITE_RTR)
 		wqe->sqe.opcode = SIW_OP_WRITE;
 	else if (ctrl & MPA_V2_RDMA_READ_RTR) {
-		struct siw_sqe *rreq;
+		struct siw_sqe *rreq = NULL;
 
 		wqe->sqe.opcode = SIW_OP_READ;
 
 		spin_lock(&qp->orq_lock);
 
-		rreq = orq_get_free(qp);
+		if (qp->attrs.orq_size)
+			rreq = orq_get_free(qp);
 		if (rreq) {
 			siw_read_to_orq(rreq, &wqe->sqe);
 			qp->orq_put++;
@@ -889,6 +892,9 @@ int siw_activate_tx(struct siw_qp *qp)
 	struct siw_wqe *wqe = tx_wqe(qp);
 	int rv = 1;
 
+	if (!qp->attrs.irq_size)
+		goto no_irq;
+
 	irqe = &qp->irq[qp->irq_get % qp->attrs.irq_size];
 
 	if (irqe->flags & SIW_WQE_VALID) {
@@ -933,6 +939,7 @@ int siw_activate_tx(struct siw_qp *qp)
 
 		goto out;
 	}
+no_irq:
 	sqe = sq_get_next(qp);
 	if (sqe) {
 skip_irq:
@@ -971,7 +978,7 @@ int siw_activate_tx(struct siw_qp *qp)
 			}
 			spin_lock(&qp->orq_lock);
 
-			if (!siw_orq_empty(qp)) {
+			if (qp->attrs.orq_size && !siw_orq_empty(qp)) {
 				qp->tx_ctx.orq_fence = 1;
 				rv = 0;
 			}
@@ -981,6 +988,11 @@ int siw_activate_tx(struct siw_qp *qp)
 			   wqe->sqe.opcode == SIW_OP_READ_LOCAL_INV) {
 			struct siw_sqe *rreq;
 
+			if (unlikely(!qp->attrs.orq_size)) {
+				/* We negotiated not to send READ req's */
+				rv = -EINVAL;
+				goto out;
+			}
 			wqe->sqe.num_sge = 1;
 
 			spin_lock(&qp->orq_lock);
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 4bd1f1f84057..981e11f31b2d 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -678,6 +678,10 @@ static int siw_init_rresp(struct siw_qp *qp, struct siw_rx_stream *srx)
 				   DDP_ECODE_UT_INVALID_MSN_RANGE, 0);
 		return -EPROTO;
 	}
+	if (unlikely(!qp->attrs.irq_size)) {
+		run_sq = 0;
+		goto error_irq;
+	}
 	spin_lock_irqsave(&qp->sq_lock, flags);
 
 	if (tx_work->wr_status == SIW_WR_IDLE) {
@@ -712,8 +716,9 @@ static int siw_init_rresp(struct siw_qp *qp, struct siw_rx_stream *srx)
 		/* RRESP now valid as current TX wqe or placed into IRQ */
 		smp_store_mb(resp->flags, SIW_WQE_VALID);
 	} else {
-		pr_warn("siw: [QP %u]: irq %d exceeded %d\n", qp_id(qp),
-			qp->irq_put % qp->attrs.irq_size, qp->attrs.irq_size);
+error_irq:
+		pr_warn("siw: [QP %u]: IRQ exceeded or null, size %d\n",
+			qp_id(qp), qp->attrs.irq_size);
 
 		siw_init_terminate(qp, TERM_ERROR_LAYER_RDMAP,
 				   RDMAP_ETYPE_REMOTE_OPERATION,
@@ -740,6 +745,9 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
 	struct siw_sqe *orqe;
 	struct siw_wqe *wqe = NULL;
 
+	if (unlikely(!qp->attrs.orq_size))
+		return -EPROTO;
+
 	/* make sure ORQ indices are current */
 	smp_mb();
 
@@ -796,8 +804,8 @@ int siw_proc_rresp(struct siw_qp *qp)
 		 */
 		rv = siw_orqe_start_rx(qp);
 		if (rv) {
-			pr_warn("siw: [QP %u]: ORQ empty at idx %d\n",
-				qp_id(qp), qp->orq_get % qp->attrs.orq_size);
+			pr_warn("siw: [QP %u]: ORQ empty, size %d\n",
+				qp_id(qp), qp->attrs.orq_size);
 			goto error_term;
 		}
 		rv = siw_rresp_check_ntoh(srx, frx);
@@ -1290,11 +1298,13 @@ static int siw_rdmap_complete(struct siw_qp *qp, int error)
 					      wc_status);
 		siw_wqe_put_mem(wqe, SIW_OP_READ);
 
-		if (!error)
+		if (!error) {
 			rv = siw_check_tx_fence(qp);
-		else
-			/* Disable current ORQ eleement */
-			WRITE_ONCE(orq_get_current(qp)->flags, 0);
+		} else {
+			/* Disable current ORQ element */
+			if (qp->attrs.orq_size)
+				WRITE_ONCE(orq_get_current(qp)->flags, 0);
+		}
 		break;
 
 	case RDMAP_RDMA_READ_REQ:
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index d19d8325588b..7989c4043db4 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1107,8 +1107,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
 		/*
 		 * RREQ may have already been completed by inbound RRESP!
 		 */
-		if (tx_type == SIW_OP_READ ||
-		    tx_type == SIW_OP_READ_LOCAL_INV) {
+		if ((tx_type == SIW_OP_READ ||
+		     tx_type == SIW_OP_READ_LOCAL_INV) && qp->attrs.orq_size) {
 			/* Cleanup pending entry in ORQ */
 			qp->orq_put--;
 			qp->orq[qp->orq_put % qp->attrs.orq_size].flags = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7cf3242ffb41..95003678cf3f 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -362,13 +362,23 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	if (rv)
 		goto err_out;
 
+	num_sqe = attrs->cap.max_send_wr;
+	num_rqe = attrs->cap.max_recv_wr;
+
 	/* All queue indices are derived from modulo operations
 	 * on a free running 'get' (consumer) and 'put' (producer)
 	 * unsigned counter. Having queue sizes at power of two
 	 * avoids handling counter wrap around.
 	 */
-	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
-	num_rqe = roundup_pow_of_two(attrs->cap.max_recv_wr);
+	if (num_sqe)
+		num_sqe = roundup_pow_of_two(num_sqe);
+	else {
+		/* Zero sized SQ is not supported */
+		rv = -EINVAL;
+		goto err_out;
+	}
+	if (num_rqe)
+		num_rqe = roundup_pow_of_two(num_rqe);
 
 	if (udata)
 		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
@@ -960,9 +970,9 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 	unsigned long flags;
 	int rv = 0;
 
-	if (qp->srq) {
+	if (qp->srq || qp->attrs.rq_size == 0) {
 		*bad_wr = wr;
-		return -EOPNOTSUPP; /* what else from errno.h? */
+		return -EINVAL;
 	}
 	if (!rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "no kernel post_recv for user mapped rq\n");
-- 
2.17.2

