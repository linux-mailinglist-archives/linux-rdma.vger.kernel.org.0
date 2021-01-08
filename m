Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97D2EF2D1
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jan 2021 14:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAHNAe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jan 2021 08:00:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727226AbhAHNAc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jan 2021 08:00:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 108CgZ6N080208;
        Fri, 8 Jan 2021 07:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pt2ajE+XcSE6r0bohdfCG36uVKkkUGxIhMSk/5Pjyz8=;
 b=ZORWi4yiFJlOSHb2MUibPEvfejnfbMDZsXqvUO8AY4LAQVZ1VcUDtCmzNoXF5BVHE0bY
 /GkMD9SzkGW49hO3TEtoE7CbTHZ4uIE+2gO2XDPjihsqcYT/c3iykhQBeoxDtRBRdkRz
 jpxAMMYp53j3lNQ/ncQ7v3CfItVmXKlP5AZvpcrQP0iurwBTXf1InSLwo/rkXYqFq1lu
 Y25bqv1qbfMKYuKq8+xUB8n9uYYeMAaI2F7iJQBc5TQTn6vgf4GjBCZ6U4myJyUaMGHw
 PuqD36dTZS6Vbheq47awIvHOzEm3vWyaVzAdFEAzHjetf5e3PBRGp8BOcASEb14oQ2Fq /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xq8js0qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 07:59:38 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 108CpJsC110790;
        Fri, 8 Jan 2021 07:59:38 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xq8js0py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 07:59:38 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 108CxVNd004746;
        Fri, 8 Jan 2021 12:59:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8e3rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 12:59:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 108CxXRh47055220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jan 2021 12:59:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D4C11C058;
        Fri,  8 Jan 2021 12:59:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0197C11C050;
        Fri,  8 Jan 2021 12:59:33 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.171.1.47])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jan 2021 12:59:32 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, jgg@nvidia.com,
        linux-nvme@lists.infradead.org, leon@kernel.org,
        Kamal Heib <kamalheib1@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] RDMA/siw: Fix handling of zero-sized Read and Receive Queues.
Date:   Fri,  8 Jan 2021 13:58:45 +0100
Message-Id: <20210108125845.1803-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_07:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

During connection setup, the application may choose to zero-size
inbound and outbound READ queues, as well as the Receive queue.
This patch fixes handling of zero-sized queues, but not prevents
it.

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
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
v2 changes:
- Fix uninitialized variable introduced in siw_qp_rx.c, as
  Reported-by: kernel test robot <lkp@intel.com>
- Add initial error report as
  Reported-by: Kamal Heib <kamalheib1@gmail.com>

v3 changes:
- correct patch changelog location
- remove prints for failed queue malloc's as pointed out by
  Leon Romanovsky

v4 changes:
- unwind siw_activate_tx function avoiding confusing
  goto's as requested by Jason Gunthorp

 drivers/infiniband/sw/siw/siw.h       |   2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 271 ++++++++++++++------------
 drivers/infiniband/sw/siw/siw_qp_rx.c |  26 ++-
 drivers/infiniband/sw/siw/siw_qp_tx.c |   4 +-
 drivers/infiniband/sw/siw/siw_verbs.c |  20 +-
 5 files changed, 177 insertions(+), 146 deletions(-)

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
index 875d36d4b1c6..ddb2e66f9f13 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -199,26 +199,26 @@ void siw_qp_llp_write_space(struct sock *sk)
 
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
@@ -288,13 +288,14 @@ int siw_qp_mpa_rts(struct siw_qp *qp, enum mpa_v2_ctrl ctrl)
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
@@ -877,135 +878,88 @@ void siw_read_to_orq(struct siw_sqe *rreq, struct siw_sqe *sqe)
 	rreq->num_sge = 1;
 }
 
-/*
- * Must be called with SQ locked.
- * To avoid complete SQ starvation by constant inbound READ requests,
- * the active IRQ will not be served after qp->irq_burst, if the
- * SQ has pending work.
- */
-int siw_activate_tx(struct siw_qp *qp)
+static int siw_activate_tx_from_sq(struct siw_qp *qp)
 {
-	struct siw_sqe *irqe, *sqe;
+	struct siw_sqe *sqe;
 	struct siw_wqe *wqe = tx_wqe(qp);
 	int rv = 1;
 
-	irqe = &qp->irq[qp->irq_get % qp->attrs.irq_size];
-
-	if (irqe->flags & SIW_WQE_VALID) {
-		sqe = sq_get_next(qp);
-
-		/*
-		 * Avoid local WQE processing starvation in case
-		 * of constant inbound READ request stream
-		 */
-		if (sqe && ++qp->irq_burst >= SIW_IRQ_MAXBURST_SQ_ACTIVE) {
-			qp->irq_burst = 0;
-			goto skip_irq;
-		}
-		memset(wqe->mem, 0, sizeof(*wqe->mem) * SIW_MAX_SGE);
-		wqe->wr_status = SIW_WR_QUEUED;
-
-		/* start READ RESPONSE */
-		wqe->sqe.opcode = SIW_OP_READ_RESPONSE;
-		wqe->sqe.flags = 0;
-		if (irqe->num_sge) {
-			wqe->sqe.num_sge = 1;
-			wqe->sqe.sge[0].length = irqe->sge[0].length;
-			wqe->sqe.sge[0].laddr = irqe->sge[0].laddr;
-			wqe->sqe.sge[0].lkey = irqe->sge[0].lkey;
-		} else {
-			wqe->sqe.num_sge = 0;
-		}
-
-		/* Retain original RREQ's message sequence number for
-		 * potential error reporting cases.
-		 */
-		wqe->sqe.sge[1].length = irqe->sge[1].length;
-
-		wqe->sqe.rkey = irqe->rkey;
-		wqe->sqe.raddr = irqe->raddr;
+	sqe = sq_get_next(qp);
+	if (!sqe)
+		return 0;
 
-		wqe->processed = 0;
-		qp->irq_get++;
+	memset(wqe->mem, 0, sizeof(*wqe->mem) * SIW_MAX_SGE);
+	wqe->wr_status = SIW_WR_QUEUED;
 
-		/* mark current IRQ entry free */
-		smp_store_mb(irqe->flags, 0);
+	/* First copy SQE to kernel private memory */
+	memcpy(&wqe->sqe, sqe, sizeof(*sqe));
 
+	if (wqe->sqe.opcode >= SIW_NUM_OPCODES) {
+		rv = -EINVAL;
 		goto out;
 	}
-	sqe = sq_get_next(qp);
-	if (sqe) {
-skip_irq:
-		memset(wqe->mem, 0, sizeof(*wqe->mem) * SIW_MAX_SGE);
-		wqe->wr_status = SIW_WR_QUEUED;
-
-		/* First copy SQE to kernel private memory */
-		memcpy(&wqe->sqe, sqe, sizeof(*sqe));
-
-		if (wqe->sqe.opcode >= SIW_NUM_OPCODES) {
+	if (wqe->sqe.flags & SIW_WQE_INLINE) {
+		if (wqe->sqe.opcode != SIW_OP_SEND &&
+		    wqe->sqe.opcode != SIW_OP_WRITE) {
 			rv = -EINVAL;
 			goto out;
 		}
-		if (wqe->sqe.flags & SIW_WQE_INLINE) {
-			if (wqe->sqe.opcode != SIW_OP_SEND &&
-			    wqe->sqe.opcode != SIW_OP_WRITE) {
-				rv = -EINVAL;
-				goto out;
-			}
-			if (wqe->sqe.sge[0].length > SIW_MAX_INLINE) {
-				rv = -EINVAL;
-				goto out;
-			}
-			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
-			wqe->sqe.sge[0].lkey = 0;
-			wqe->sqe.num_sge = 1;
+		if (wqe->sqe.sge[0].length > SIW_MAX_INLINE) {
+			rv = -EINVAL;
+			goto out;
 		}
-		if (wqe->sqe.flags & SIW_WQE_READ_FENCE) {
-			/* A READ cannot be fenced */
-			if (unlikely(wqe->sqe.opcode == SIW_OP_READ ||
-				     wqe->sqe.opcode ==
-					     SIW_OP_READ_LOCAL_INV)) {
-				siw_dbg_qp(qp, "cannot fence read\n");
-				rv = -EINVAL;
-				goto out;
-			}
-			spin_lock(&qp->orq_lock);
+		wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
+		wqe->sqe.sge[0].lkey = 0;
+		wqe->sqe.num_sge = 1;
+	}
+	if (wqe->sqe.flags & SIW_WQE_READ_FENCE) {
+		/* A READ cannot be fenced */
+		if (unlikely(wqe->sqe.opcode == SIW_OP_READ ||
+			     wqe->sqe.opcode ==
+				     SIW_OP_READ_LOCAL_INV)) {
+			siw_dbg_qp(qp, "cannot fence read\n");
+			rv = -EINVAL;
+			goto out;
+		}
+		spin_lock(&qp->orq_lock);
 
-			if (!siw_orq_empty(qp)) {
-				qp->tx_ctx.orq_fence = 1;
-				rv = 0;
-			}
-			spin_unlock(&qp->orq_lock);
+		if (qp->attrs.orq_size && !siw_orq_empty(qp)) {
+			qp->tx_ctx.orq_fence = 1;
+			rv = 0;
+		}
+		spin_unlock(&qp->orq_lock);
 
-		} else if (wqe->sqe.opcode == SIW_OP_READ ||
-			   wqe->sqe.opcode == SIW_OP_READ_LOCAL_INV) {
-			struct siw_sqe *rreq;
+	} else if (wqe->sqe.opcode == SIW_OP_READ ||
+		   wqe->sqe.opcode == SIW_OP_READ_LOCAL_INV) {
+		struct siw_sqe *rreq;
 
-			wqe->sqe.num_sge = 1;
+		if (unlikely(!qp->attrs.orq_size)) {
+			/* We negotiated not to send READ req's */
+			rv = -EINVAL;
+			goto out;
+		}
+		wqe->sqe.num_sge = 1;
 
-			spin_lock(&qp->orq_lock);
+		spin_lock(&qp->orq_lock);
 
-			rreq = orq_get_free(qp);
-			if (rreq) {
-				/*
-				 * Make an immediate copy in ORQ to be ready
-				 * to process loopback READ reply
-				 */
-				siw_read_to_orq(rreq, &wqe->sqe);
-				qp->orq_put++;
-			} else {
-				qp->tx_ctx.orq_fence = 1;
-				rv = 0;
-			}
-			spin_unlock(&qp->orq_lock);
+		rreq = orq_get_free(qp);
+		if (rreq) {
+			/*
+			 * Make an immediate copy in ORQ to be ready
+			 * to process loopback READ reply
+			 */
+			siw_read_to_orq(rreq, &wqe->sqe);
+			qp->orq_put++;
+		} else {
+			qp->tx_ctx.orq_fence = 1;
+			rv = 0;
 		}
-
-		/* Clear SQE, can be re-used by application */
-		smp_store_mb(sqe->flags, 0);
-		qp->sq_get++;
-	} else {
-		rv = 0;
+		spin_unlock(&qp->orq_lock);
 	}
+
+	/* Clear SQE, can be re-used by application */
+	smp_store_mb(sqe->flags, 0);
+	qp->sq_get++;
 out:
 	if (unlikely(rv < 0)) {
 		siw_dbg_qp(qp, "error %d\n", rv);
@@ -1014,6 +968,65 @@ int siw_activate_tx(struct siw_qp *qp)
 	return rv;
 }
 
+/*
+ * Must be called with SQ locked.
+ * To avoid complete SQ starvation by constant inbound READ requests,
+ * the active IRQ will not be served after qp->irq_burst, if the
+ * SQ has pending work.
+ */
+int siw_activate_tx(struct siw_qp *qp)
+{
+	struct siw_sqe *irqe;
+	struct siw_wqe *wqe = tx_wqe(qp);
+
+	if (!qp->attrs.irq_size)
+		return siw_activate_tx_from_sq(qp);
+
+	irqe = &qp->irq[qp->irq_get % qp->attrs.irq_size];
+
+	if (!(irqe->flags & SIW_WQE_VALID))
+		return siw_activate_tx_from_sq(qp);
+
+	/*
+	 * Avoid local WQE processing starvation in case
+	 * of constant inbound READ request stream
+	 */
+	if (sq_get_next(qp) && ++qp->irq_burst >= SIW_IRQ_MAXBURST_SQ_ACTIVE) {
+		qp->irq_burst = 0;
+		return siw_activate_tx_from_sq(qp);
+	}
+	memset(wqe->mem, 0, sizeof(*wqe->mem) * SIW_MAX_SGE);
+	wqe->wr_status = SIW_WR_QUEUED;
+
+	/* start READ RESPONSE */
+	wqe->sqe.opcode = SIW_OP_READ_RESPONSE;
+	wqe->sqe.flags = 0;
+	if (irqe->num_sge) {
+		wqe->sqe.num_sge = 1;
+		wqe->sqe.sge[0].length = irqe->sge[0].length;
+		wqe->sqe.sge[0].laddr = irqe->sge[0].laddr;
+		wqe->sqe.sge[0].lkey = irqe->sge[0].lkey;
+	} else {
+		wqe->sqe.num_sge = 0;
+	}
+
+	/* Retain original RREQ's message sequence number for
+	 * potential error reporting cases.
+	 */
+	wqe->sqe.sge[1].length = irqe->sge[1].length;
+
+	wqe->sqe.rkey = irqe->rkey;
+	wqe->sqe.raddr = irqe->raddr;
+
+	wqe->processed = 0;
+	qp->irq_get++;
+
+	/* mark current IRQ entry free */
+	smp_store_mb(irqe->flags, 0);
+
+	return 1;
+}
+
 /*
  * Check if current CQ state qualifies for calling CQ completion
  * handler. Must be called with CQ lock held.
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 4bd1f1f84057..60116f20653c 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -680,6 +680,10 @@ static int siw_init_rresp(struct siw_qp *qp, struct siw_rx_stream *srx)
 	}
 	spin_lock_irqsave(&qp->sq_lock, flags);
 
+	if (unlikely(!qp->attrs.irq_size)) {
+		run_sq = 0;
+		goto error_irq;
+	}
 	if (tx_work->wr_status == SIW_WR_IDLE) {
 		/*
 		 * immediately schedule READ response w/o
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
index 7cf3242ffb41..fb25e8011f5a 100644
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
@@ -376,7 +386,6 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		qp->sendq = vzalloc(num_sqe * sizeof(struct siw_sqe));
 
 	if (qp->sendq == NULL) {
-		siw_dbg(base_dev, "SQ size %d alloc failed\n", num_sqe);
 		rv = -ENOMEM;
 		goto err_out_xa;
 	}
@@ -410,7 +419,6 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
 
 		if (qp->recvq == NULL) {
-			siw_dbg(base_dev, "RQ size %d alloc failed\n", num_rqe);
 			rv = -ENOMEM;
 			goto err_out_xa;
 		}
@@ -960,9 +968,9 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
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

