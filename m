Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11AB920E8
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSKFf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 06:05:35 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:53084 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSKFe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 06:05:34 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id qy5T2000P05gfCL01y5ThF; Mon, 19 Aug 2019 12:05:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hzeXX-0005Aa-GY; Mon, 19 Aug 2019 12:05:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hzeXX-0003b9-F5; Mon, 19 Aug 2019 12:05:27 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to u64/pointer abuse
Date:   Mon, 19 Aug 2019 12:05:26 +0200
Message-Id: <20190819100526.13788-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When compiling on 32-bit:

    drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:53:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:59:11: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:59:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:61:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:62:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:82:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:87:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:101:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:169:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:192:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:204:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:219:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:476:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:535:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:832:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_qp_tx.c:927:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:43:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:43:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:141:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:488:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:601:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_qp_rx.c:844:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    drivers/infiniband/sw/siw/siw_verbs.c:665:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_verbs.c:828:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/infiniband/sw/siw/siw_verbs.c:846:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Fix this by applying the following rules:
  1. When printing a u64, the %llx format specififer should be used,
     instead of casting to a pointer, and printing the latter.
  2. When assigning a pointer to a u64, the pointer should be cast to
     uintptr_t, not u64,
  3. When casting from u64 to pointer, an intermediate cast to uintptr_t
     should be added,

Fixes: 2c8ccb37b08fe364 ("RDMA/siw: Change CQ flags from 64->32 bits")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The issues predate the commit mentioned above, but didn't become visible
before.

The Right Thing(TM) would be to get rid of all this casting, and use
proper types instead.
This would involve teaching the siw people that a kernel virtual address
is not called a physical address, and should not use u64.
---
 drivers/infiniband/sw/siw/siw_cq.c    |  5 ++--
 drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c | 16 +++++++------
 drivers/infiniband/sw/siw/siw_qp_tx.c | 34 ++++++++++++++-------------
 drivers/infiniband/sw/siw/siw_verbs.c |  8 +++----
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index e381ae9b7d62498e..f4ec26eeb9df62bf 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -71,9 +71,10 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 				wc->wc_flags = IB_WC_WITH_INVALIDATE;
 			}
 			wc->qp = cqe->base_qp;
-			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
+			siw_dbg_cq(cq,
+				   "idx %u, type %d, flags %2x, id 0x%llx\n",
 				   cq->cq_get % cq->num_cqe, cqe->opcode,
-				   cqe->flags, (void *)cqe->id);
+				   cqe->flags, cqe->id);
 		}
 		WRITE_ONCE(cqe->flags, 0);
 		cq->cq_get++;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 0990307c5d2cde95..430314c8abd948c2 100644
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
index f87657a11657223e..8c183fc00ffd9846 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -38,9 +38,9 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 
 		p = siw_get_upage(umem, dest_addr);
 		if (unlikely(!p)) {
-			pr_warn("siw: %s: [QP %u]: bogus addr: %p, %p\n",
+			pr_warn("siw: %s: [QP %u]: bogus addr: %llx, %llx\n",
 				__func__, qp_id(rx_qp(srx)),
-				(void *)dest_addr, (void *)umem->fp_addr);
+				dest_addr, umem->fp_addr);
 			/* siw internal error */
 			srx->skb_copied += copied;
 			srx->skb_new -= copied;
@@ -138,7 +138,8 @@ static int siw_rx_pbl(struct siw_rx_stream *srx, int *pbl_idx,
 			break;
 
 		bytes = min(bytes, len);
-		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
+		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes)
+		    == bytes) {
 			copied += bytes;
 			offset += bytes;
 			len -= bytes;
@@ -485,7 +486,7 @@ int siw_proc_send(struct siw_qp *qp)
 		mem_p = *mem;
 		if (mem_p->mem_obj == NULL)
 			rv = siw_rx_kva(srx,
-					(void *)(sge->laddr + frx->sge_off),
+					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
 					sge_bytes);
 		else if (!mem_p->is_pbl)
 			rv = siw_rx_umem(srx, mem_p->umem,
@@ -598,7 +599,7 @@ int siw_proc_write(struct siw_qp *qp)
 
 	if (mem->mem_obj == NULL)
 		rv = siw_rx_kva(srx,
-				(void *)(srx->ddp_to + srx->fpdu_part_rcvd),
+				(void *)(uintptr_t)(srx->ddp_to + srx->fpdu_part_rcvd),
 				bytes);
 	else if (!mem->is_pbl)
 		rv = siw_rx_umem(srx, mem->umem,
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
index 43020d2040fc3394..311d682539b5232b 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -41,6 +41,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 {
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[0];
+	void *dst = (void *)(uintptr_t)paddr;
 	u32 bytes = sge->length;
 
 	if (bytes > MAX_HDR_INLINE || wqe->sqe.num_sge != 1)
@@ -50,16 +51,16 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 		return 0;
 
 	if (tx_flags(wqe) & SIW_WQE_INLINE) {
-		memcpy((void *)paddr, &wqe->sqe.sge[1], bytes);
+		memcpy(dst, &wqe->sqe.sge[1], bytes);
 	} else {
 		struct siw_mem *mem = wqe->mem[0];
 
 		if (!mem->mem_obj) {
 			/* Kernel client using kva */
-			memcpy((void *)paddr, (void *)sge->laddr, bytes);
+			memcpy(dst, (void *)(uintptr_t)sge->laddr, bytes);
 		} else if (c_tx->in_syscall) {
-			if (copy_from_user((void *)paddr,
-					   (const void __user *)sge->laddr,
+			if (copy_from_user(dst,
+					   (const void __user *)(uintptr_t)sge->laddr,
 					   bytes))
 				return -EFAULT;
 		} else {
@@ -79,12 +80,12 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 			buffer = kmap_atomic(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
-				memcpy((void *)paddr, buffer + off, bytes);
+				memcpy(dst, buffer + off, bytes);
 				kunmap_atomic(buffer);
 			} else {
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
-				memcpy((void *)paddr, buffer + off, part);
+				memcpy(dst, buffer + off, part);
 				kunmap_atomic(buffer);
 
 				if (!mem->is_pbl)
@@ -98,8 +99,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 					return -EFAULT;
 
 				buffer = kmap_atomic(p);
-				memcpy((void *)(paddr + part), buffer,
-				       bytes - part);
+				memcpy(dst + part, buffer, bytes - part);
 				kunmap_atomic(buffer);
 			}
 		}
@@ -166,7 +166,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, (uintptr_t)crc);
 		break;
 
 	case SIW_OP_SEND_REMOTE_INV:
@@ -189,7 +189,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send_inv);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, (uintptr_t)crc);
 		break;
 
 	case SIW_OP_WRITE:
@@ -201,7 +201,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_write);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, (uintptr_t)crc);
 		break;
 
 	case SIW_OP_READ_RESPONSE:
@@ -216,7 +216,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_rresp);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, (uintptr_t)crc);
 		break;
 
 	default:
@@ -473,7 +473,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			 * tx from kernel virtual address: either inline data
 			 * or memory region with assigned kernel buffer
 			 */
-			iov[seg].iov_base = (void *)(sge->laddr + sge_off);
+			iov[seg].iov_base =
+				(void *)(uintptr_t)(sge->laddr + sge_off);
 			iov[seg].iov_len = sge_len;
 
 			if (do_crc)
@@ -532,7 +533,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-						(void *)(sge->laddr + sge_off),
+						(void *)(uintptr_t)(sge->laddr + sge_off),
 						plen);
 			}
 
@@ -829,7 +830,8 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 					rv = -EINVAL;
 					goto tx_error;
 				}
-				wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
+				wqe->sqe.sge[0].laddr =
+					(uintptr_t)&wqe->sqe.sge[1];
 			}
 		}
 		wqe->wr_status = SIW_WR_INPROGRESS;
@@ -924,7 +926,7 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 
 static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 {
-	struct ib_mr *base_mr = (struct ib_mr *)sqe->base_mr;
+	struct ib_mr *base_mr = (struct ib_mr *)(uintptr_t)sqe->base_mr;
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
 	int rv = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index e7f3a2379d9d8785..0672ff39a5bcf02d 100644
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
@@ -842,8 +842,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			rv = -EINVAL;
 			break;
 		}
-		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
-			   sqe->opcode, sqe->flags, (void *)sqe->id);
+		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%llx\n",
+			   sqe->opcode, sqe->flags, sqe->id);
 
 		if (unlikely(rv < 0))
 			break;
-- 
2.17.1

