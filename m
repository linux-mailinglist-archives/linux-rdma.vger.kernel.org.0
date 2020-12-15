Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000CC2DB518
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 21:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgLOUXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 15:23:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbgLOUXW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 15:23:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFK2HvY023581;
        Tue, 15 Dec 2020 15:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zpJ5kY43A33URA/SFwyJ21J55hUUGCH3rbjPW+6tZFI=;
 b=iZy9wpyN+CltswJLFyXmkwdv4XathDx7yRXl2GI4maACskCCZ74Bd6lGswbzisl8l11e
 dqexFcb8AlkouN/UgS0Uz736Xw10g7xj1wBv7IxZiIyUiCzEWPedpzl6+9cBHqBa0TC+
 gt7Sg7je1XldurP7igKWbZfFeBkYDm9SlsCxK1f9FQh7W79lifDKdt0fO9KYPEsEnHts
 +6TZPHOPEVo8a2ynqOcHeTzmDCyvtQoOMAgl5QJaYOdnCcJ3ajZl32GYHOOrbj2qjUnE
 XDCx9iDksN3y81mn8ARcHb0PgFB4zSzA5Hp99jLXmtgdEBLAV+7M1ramEQhCAyYSKHvN lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35f2g1k8as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 15:22:34 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BFK5Fn7037907;
        Tue, 15 Dec 2020 15:22:34 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35f2g1k89y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 15:22:33 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFKDPue017905;
        Tue, 15 Dec 2020 20:22:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8dbt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 20:22:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BFKJxHY30474592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 20:19:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AD2211C054;
        Tue, 15 Dec 2020 20:19:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D33BD11C04C;
        Tue, 15 Dec 2020 20:19:56 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.163.19.166])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Dec 2020 20:19:56 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, jgg@nvidia.com,
        linux-nvme@lists.infradead.org, Kamal Heib <kamalheib1@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH v2] RDMA/siw: Fix handling of zero-sized Read and Receive Queues.
Date:   Tue, 15 Dec 2020 21:19:18 +0100
Message-Id: <20201215201918.4050-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=858 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150130
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

During connection setup, the application may choose to zero-size
inbound and outbound READ queues, as well as the Receive queue.
This patch fixes handling of zero-sized queues, but not prevents
it.

v2 changes:
- Fix uninitialized variable introduced in siw_qp_rx.c, as
  Reported-by: kernel test robot <lkp@intel.com>
- Add initial error report as
  Reported-by: Kamal Heib <kamalheib1@gmail.com>

Kamal Heib says in an initial error report:
When running the blktests over siw the following shift-out-of-bounds is
reported, this is happening because the passed IRD or ORD from the ulp
could be zero which will lead to unexpected behavior when calling
roundup_pow_of_two(), fix that by blocking zero values of ORD or IRD.

UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S     5.10.0-rc6 #2
Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
Call Trace:
 dump_stack+0x99/0xcb
 ubsan_epilogue+0x5/0x40
 __ubsan_handle_shift_out_of_bounds.cold.11+0xb4/0xf3
 ? down_write+0x183/0x3d0
 siw_qp_modify.cold.8+0x2d/0x32 [siw]
 ? __local_bh_enable_ip+0xa5/0xf0
 siw_accept+0x906/0x1b60 [siw]
 ? xa_load+0x147/0x1f0
 ? siw_connect+0x17a0/0x17a0 [siw]
 ? lock_downgrade+0x700/0x700
 ? siw_get_base_qp+0x1c2/0x340 [siw]
 ? _raw_spin_unlock_irqrestore+0x39/0x40
 iw_cm_accept+0x1f4/0x430 [iw_cm]
 rdma_accept+0x3fa/0xb10 [rdma_cm]
 ? check_flush_dependency+0x410/0x410
 ? cma_rep_recv+0x570/0x570 [rdma_cm]
 nvmet_rdma_queue_connect+0x1a62/0x2680 [nvmet_rdma]
 ? nvmet_rdma_alloc_cmds+0xce0/0xce0 [nvmet_rdma]
 ? lock_release+0x56e/0xcc0
 ? lock_downgrade+0x700/0x700
 ? lock_downgrade+0x700/0x700
 ? __xa_alloc_cyclic+0xef/0x350
 ? __xa_alloc+0x2d0/0x2d0
 ? rdma_restrack_add+0xbe/0x2c0 [ib_core]
 ? __ww_mutex_die+0x190/0x190
 cma_cm_event_handler+0xf2/0x500 [rdma_cm]
 iw_conn_req_handler+0x910/0xcb0 [rdma_cm]
 ? _raw_spin_unlock_irqrestore+0x39/0x40
 ? trace_hardirqs_on+0x1c/0x150
 ? cma_ib_handler+0x8a0/0x8a0 [rdma_cm]
 ? __kasan_kmalloc.constprop.7+0xc1/0xd0
 cm_work_handler+0x121c/0x17a0 [iw_cm]
 ? iw_cm_reject+0x190/0x190 [iw_cm]
 ? trace_hardirqs_on+0x1c/0x150
 process_one_work+0x8fb/0x16c0
 ? pwq_dec_nr_in_flight+0x320/0x320
 worker_thread+0x87/0xb40
 ? __kthread_parkme+0xd1/0x1a0
 ? process_one_work+0x16c0/0x16c0
 kthread+0x35f/0x430
 ? kthread_mod_delayed_work+0x180/0x180
 ret_from_fork+0x22/0x30

Fixes: a531975279f3 ("rdma/siw: main include file")
Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
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

