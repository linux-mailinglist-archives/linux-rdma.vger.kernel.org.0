Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368D895FAC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfHTNPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 09:15:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbfHTNPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KDDGCI035203
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 09:15:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uggd1bxb4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 09:15:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Tue, 20 Aug 2019 14:15:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 14:15:07 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KDF6el44957838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 13:15:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66275AE051;
        Tue, 20 Aug 2019 13:15:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 374B2AE05D;
        Tue, 20 Aug 2019 13:15:06 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 13:15:06 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, geert@linux-m68k.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] siw: fix 64/32bit pointer inconsistency.
Date:   Tue, 20 Aug 2019 15:14:42 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082013-0012-0000-0000-00000340B65A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082013-0013-0000-0000-0000217ADA94
Message-Id: <20190820131442.26466-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200139
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes improper casting between addresses and unsigned types.
Changes siw_pbl_get_buffer() function to return appropriate
dma_addr_t, and not u64.

In debug prints, all potentially kernel private variables
are printed as void * to allow keeping that information
secret.

Fixes: 2c8ccb37b08fe364 ("RDMA/siw: Change CQ flags from 64->32 bits")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  6 ++--
 drivers/infiniband/sw/siw/siw_cq.c    |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c   |  2 +-
 drivers/infiniband/sw/siw/siw_mem.h   |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c | 18 ++++++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c | 43 ++++++++++++++-------------
 drivers/infiniband/sw/siw/siw_verbs.c | 19 +++++++-----
 8 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 77b1aabf6ff3..b7838e95fcc1 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -138,9 +138,9 @@ struct siw_umem {
 };
 
 struct siw_pble {
-	u64 addr; /* Address of assigned user buffer */
-	u64 size; /* Size of this entry */
-	u64 pbl_off; /* Total offset from start of PBL */
+	dma_addr_t addr; /* Address of assigned buffer */
+	unsigned int size; /* Size of this entry */
+	unsigned long pbl_off; /* Total offset from start of PBL */
 };
 
 struct siw_pbl {
diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index e381ae9b7d62..9637f43a6ff1 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -73,7 +73,7 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 			wc->qp = cqe->base_qp;
 			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
 				   cq->cq_get % cq->num_cqe, cqe->opcode,
-				   cqe->flags, (void *)cqe->id);
+				   cqe->flags, (void *)(uintptr_t)cqe->id);
 		}
 		WRITE_ONCE(cqe->flags, 0);
 		cq->cq_get++;
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 67171c82b0c4..93d1fbd25e79 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -330,7 +330,7 @@ int siw_invalidate_stag(struct ib_pd *pd, u32 stag)
  * Optionally, provides remaining len within current element, and
  * current PBL index for later resume at same element.
  */
-u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
+dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
 {
 	int i = idx ? *idx : 0;
 
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index f43daf280891..db138c8423da 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -9,7 +9,7 @@
 struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable);
 void siw_umem_release(struct siw_umem *umem, bool dirty);
 struct siw_pbl *siw_pbl_alloc(u32 num_buf);
-u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
+dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
 struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index);
 int siw_mem_add(struct siw_device *sdev, struct siw_mem *m);
 int siw_invalidate_stag(struct ib_pd *pd, u32 stag);
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 0990307c5d2c..430314c8abd9 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -949,7 +949,7 @@ int siw_activate_tx(struct siw_qp *qp)
 				rv = -EINVAL;
 				goto out;
 			}
-			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
+			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
 			wqe->sqe.sge[0].lkey = 0;
 			wqe->sqe.num_sge = 1;
 		}
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index f87657a11657..22dc01ea9e8d 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -40,7 +40,8 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 		if (unlikely(!p)) {
 			pr_warn("siw: %s: [QP %u]: bogus addr: %p, %p\n",
 				__func__, qp_id(rx_qp(srx)),
-				(void *)dest_addr, (void *)umem->fp_addr);
+				(void *)(uintptr_t)dest_addr,
+				(void *)(uintptr_t)umem->fp_addr);
 			/* siw internal error */
 			srx->skb_copied += copied;
 			srx->skb_new -= copied;
@@ -132,7 +133,7 @@ static int siw_rx_pbl(struct siw_rx_stream *srx, int *pbl_idx,
 
 	while (len) {
 		int bytes;
-		u64 buf_addr =
+		dma_addr_t buf_addr =
 			siw_pbl_get_buffer(pbl, offset, &bytes, pbl_idx);
 		if (!buf_addr)
 			break;
@@ -485,8 +486,8 @@ int siw_proc_send(struct siw_qp *qp)
 		mem_p = *mem;
 		if (mem_p->mem_obj == NULL)
 			rv = siw_rx_kva(srx,
-					(void *)(sge->laddr + frx->sge_off),
-					sge_bytes);
+				(void *)(uintptr_t)(sge->laddr + frx->sge_off),
+				sge_bytes);
 		else if (!mem_p->is_pbl)
 			rv = siw_rx_umem(srx, mem_p->umem,
 					 sge->laddr + frx->sge_off, sge_bytes);
@@ -598,8 +599,8 @@ int siw_proc_write(struct siw_qp *qp)
 
 	if (mem->mem_obj == NULL)
 		rv = siw_rx_kva(srx,
-				(void *)(srx->ddp_to + srx->fpdu_part_rcvd),
-				bytes);
+			(void *)(uintptr_t)(srx->ddp_to + srx->fpdu_part_rcvd),
+			bytes);
 	else if (!mem->is_pbl)
 		rv = siw_rx_umem(srx, mem->umem,
 				 srx->ddp_to + srx->fpdu_part_rcvd, bytes);
@@ -841,8 +842,9 @@ int siw_proc_rresp(struct siw_qp *qp)
 	bytes = min(srx->fpdu_part_rem, srx->skb_new);
 
 	if (mem_p->mem_obj == NULL)
-		rv = siw_rx_kva(srx, (void *)(sge->laddr + wqe->processed),
-				bytes);
+		rv = siw_rx_kva(srx,
+			(void *)(uintptr_t)(sge->laddr + wqe->processed),
+			bytes);
 	else if (!mem_p->is_pbl)
 		rv = siw_rx_umem(srx, mem_p->umem, sge->laddr + wqe->processed,
 				 bytes);
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 43020d2040fc..1dca4aade09a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -26,7 +26,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 {
 	struct siw_pbl *pbl = mem->pbl;
 	u64 offset = addr - mem->va;
-	u64 paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
+	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
 		return virt_to_page(paddr);
@@ -37,7 +37,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 /*
  * Copy short payload at provided destination payload address
  */
-static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
+static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 {
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[0];
@@ -50,17 +50,18 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 		return 0;
 
 	if (tx_flags(wqe) & SIW_WQE_INLINE) {
-		memcpy((void *)paddr, &wqe->sqe.sge[1], bytes);
+		memcpy(paddr, &wqe->sqe.sge[1], bytes);
 	} else {
 		struct siw_mem *mem = wqe->mem[0];
 
 		if (!mem->mem_obj) {
 			/* Kernel client using kva */
-			memcpy((void *)paddr, (void *)sge->laddr, bytes);
+			memcpy(paddr,
+			       (const void *)(uintptr_t)sge->laddr, bytes);
 		} else if (c_tx->in_syscall) {
-			if (copy_from_user((void *)paddr,
-					   (const void __user *)sge->laddr,
-					   bytes))
+			if (copy_from_user(paddr,
+				(const void __user *)(uintptr_t)sge->laddr,
+				bytes))
 				return -EFAULT;
 		} else {
 			unsigned int off = sge->laddr & ~PAGE_MASK;
@@ -79,12 +80,12 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 			buffer = kmap_atomic(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
-				memcpy((void *)paddr, buffer + off, bytes);
+				memcpy(paddr, buffer + off, bytes);
 				kunmap_atomic(buffer);
 			} else {
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
-				memcpy((void *)paddr, buffer + off, part);
+				memcpy(paddr, buffer + off, part);
 				kunmap_atomic(buffer);
 
 				if (!mem->is_pbl)
@@ -98,7 +99,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 					return -EFAULT;
 
 				buffer = kmap_atomic(p);
-				memcpy((void *)(paddr + part), buffer,
+				memcpy(paddr + part, buffer,
 				       bytes - part);
 				kunmap_atomic(buffer);
 			}
@@ -166,7 +167,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_SEND_REMOTE_INV:
@@ -189,7 +190,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send_inv);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_WRITE:
@@ -201,7 +202,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_write);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_READ_RESPONSE:
@@ -216,7 +217,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_rresp);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	default:
@@ -473,7 +474,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			 * tx from kernel virtual address: either inline data
 			 * or memory region with assigned kernel buffer
 			 */
-			iov[seg].iov_base = (void *)(sge->laddr + sge_off);
+			iov[seg].iov_base =
+				(void *)(uintptr_t)(sge->laddr + sge_off);
 			iov[seg].iov_len = sge_len;
 
 			if (do_crc)
@@ -526,13 +528,13 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 						page_address(p) + fp_off,
 						plen);
 			} else {
-				u64 pa = ((sge->laddr + sge_off) & PAGE_MASK);
+				u64 va = sge->laddr + sge_off;
 
-				page_array[seg] = virt_to_page(pa);
+				page_array[seg] = virt_to_page(va & PAGE_MASK);
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-						(void *)(sge->laddr + sge_off),
+						(void *)(uintptr_t)va,
 						plen);
 			}
 
@@ -829,7 +831,8 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 					rv = -EINVAL;
 					goto tx_error;
 				}
-				wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
+				wqe->sqe.sge[0].laddr =
+					(u64)(uintptr_t)&wqe->sqe.sge[1];
 			}
 		}
 		wqe->wr_status = SIW_WR_INPROGRESS;
@@ -924,7 +927,7 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 
 static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 {
-	struct ib_mr *base_mr = (struct ib_mr *)sqe->base_mr;
+	struct ib_mr *base_mr = (struct ib_mr *)(uintptr_t)sqe->base_mr;
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
 	int rv = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index e7f3a2379d9d..7abe29aeea35 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -662,7 +662,7 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 	void *kbuf = &sqe->sge[1];
 	int num_sge = core_wr->num_sge, bytes = 0;
 
-	sqe->sge[0].laddr = (u64)kbuf;
+	sqe->sge[0].laddr = (uintptr_t)kbuf;
 	sqe->sge[0].lkey = 0;
 
 	while (num_sge--) {
@@ -825,7 +825,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			break;
 
 		case IB_WR_REG_MR:
-			sqe->base_mr = (uint64_t)reg_wr(wr)->mr;
+			sqe->base_mr = (uintptr_t)reg_wr(wr)->mr;
 			sqe->rkey = reg_wr(wr)->key;
 			sqe->access = reg_wr(wr)->access & IWARP_ACCESS_MASK;
 			sqe->opcode = SIW_OP_REG_MR;
@@ -843,7 +843,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			break;
 		}
 		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
-			   sqe->opcode, sqe->flags, (void *)sqe->id);
+			   sqe->opcode, sqe->flags,
+			   (void *)(uintptr_t)sqe->id);
 
 		if (unlikely(rv < 0))
 			break;
@@ -1363,7 +1364,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 	struct siw_mem *mem = mr->mem;
 	struct siw_pbl *pbl = mem->pbl;
 	struct siw_pble *pble;
-	u64 pbl_size;
+	unsigned long pbl_size;
 	int i, rv;
 
 	if (!pbl) {
@@ -1402,16 +1403,18 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 			pbl_size += sg_dma_len(slp);
 		}
 		siw_dbg_mem(mem,
-			"sge[%d], size %llu, addr 0x%016llx, total %llu\n",
-			i, pble->size, pble->addr, pbl_size);
+			"sge[%d], size %u, addr 0x%p, total %lu\n",
+			i, pble->size, (void *)(uintptr_t)pble->addr,
+			pbl_size);
 	}
 	rv = ib_sg_to_pages(base_mr, sl, num_sle, sg_off, siw_set_pbl_page);
 	if (rv > 0) {
 		mem->len = base_mr->length;
 		mem->va = base_mr->iova;
 		siw_dbg_mem(mem,
-			"%llu bytes, start 0x%016llx, %u SLE to %u entries\n",
-			mem->len, mem->va, num_sle, pbl->num_buf);
+			"%llu bytes, start 0x%p, %u SLE to %u entries\n",
+			mem->len, (void *)(uintptr_t)mem->va, num_sle,
+			pbl->num_buf);
 	}
 	return rv;
 }
-- 
2.17.2

