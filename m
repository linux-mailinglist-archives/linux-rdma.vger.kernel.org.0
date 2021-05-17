Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A525382D8B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhEQNhI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhEQNhH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 09:37:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06320C061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so3144432plc.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=nqKMgcX5OHAfsj1WVE5LEWfqE9w1SuNvDxXHPMK3PXU=;
        b=JgKFew6iRhO4odRmfaFFutQcUA3Ww3BSKpBoCFUjHwEqV6l6K6H7uRO6aX3O7tp8sZ
         y2R1GkMsTEfIkT2cijmb9bpk0bgkYHQyWFgDeEJlTYqQ0sj+6se7+8N78k9SC1qvtHPO
         rMDk+uZkVJJ4tf473tksFiTSTh0hFB4ixjh5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=nqKMgcX5OHAfsj1WVE5LEWfqE9w1SuNvDxXHPMK3PXU=;
        b=m/+Z1868bYssAnA1cmKnmD2tmePqh1x2vU0uQoG5VAY+E346IQZOPgjcu2L7tWFq78
         JFTQc7HPyP4TU3/5m3jUv8NYvK8pPwEv+lDKpV2f1S7pc74J3o6iag6OPdy09g22HqeS
         D2BHKsXIWagrEnLA5oZjJOEk9h389gjAZcdhMFf3ZRaWBwt7WPW5Ka2NihODermP+8Sf
         4wBem2Gu4P9mwVYAdLKfbSd9z/yFg8cJI1Ap+tpjyppuJ8nQ0a7xtFOY/KUrxU7zFRi2
         UyVK4GQoUCoMSWaRRMWOlJou52aYVbBw9hOTGgzxZzigudKXGexJ2wtNQw2h3rl6rZw6
         6z5Q==
X-Gm-Message-State: AOAM530QGnPwzPO97KZqZaxScVsCtAHWypE4ZeNn1eX/uEvg+T5ysBEO
        kFcvssXab6+qJLAud9CBqoCTBSI1UWG+mPZ1ZLKfP5jqlq4KE3rJL8e8Ujx1GZVi5IoXNK6PCGo
        NHPnQxeGqpzNi2sWzgQH7vGw6hy3XlXjanoFbegpHDaejELvcVb1vnUBWzKG0QxuPLkn6Ha8yPZ
        VTkd2wC3nu
X-Google-Smtp-Source: ABdhPJwPg6hk64D1hrYPURA4CLpt7a+xr/+loK7ALwvbdh6YtQk49sAmPg3t477GEbmPFBrGxK14/w==
X-Received: by 2002:a17:90a:cc05:: with SMTP id b5mr21759992pju.6.1621258549479;
        Mon, 17 May 2021 06:35:49 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b6sm10953618pjk.13.2021.05.17.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:35:48 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 INTERNAL 4/4] bnxt_re/lib: Move hardware queue to 16B aligned indices
Date:   Mon, 17 May 2021 19:05:32 +0530
Message-Id: <20210517133532.774998-5-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517133532.774998-1-devesh.sharma@broadcom.com>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fb3d7a05c286ab22"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000fb3d7a05c286ab22
Content-Transfer-Encoding: 8bit

Move SQ and RQ indices from WQE boundary to
16B boundary alignment. Changing the SQ-wqe posting
algorithm accordingly. The new alignment needs to pull
a 16B slot from the hardware queue and initialize the
current 16B into the hardware buffer. Depending on the
max possible wqe size supported by hardware, the number
of 16B slots are calculated and pulled for initialization.
Currently 128B wqe is supported and it requires 8 slots.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/db.c     |  10 +-
 providers/bnxt_re/main.h   |   1 +
 providers/bnxt_re/memory.h |  33 +++-
 providers/bnxt_re/verbs.c  | 371 ++++++++++++++++++++++++++-----------
 4 files changed, 294 insertions(+), 121 deletions(-)

diff --git a/providers/bnxt_re/db.c b/providers/bnxt_re/db.c
index 3c797573..e99b7b62 100644
--- a/providers/bnxt_re/db.c
+++ b/providers/bnxt_re/db.c
@@ -62,18 +62,20 @@ static void bnxt_re_init_db_hdr(struct bnxt_re_db_hdr *hdr, uint32_t indx,
 void bnxt_re_ring_rq_db(struct bnxt_re_qp *qp)
 {
 	struct bnxt_re_db_hdr hdr;
+	uint32_t tail;
 
-	bnxt_re_init_db_hdr(&hdr, qp->jrqq->hwque->tail,
-			    qp->qpid, BNXT_RE_QUE_TYPE_RQ);
+	tail = qp->jrqq->hwque->tail / qp->jrqq->hwque->max_slots;
+	bnxt_re_init_db_hdr(&hdr, tail, qp->qpid, BNXT_RE_QUE_TYPE_RQ);
 	bnxt_re_ring_db(qp->udpi, &hdr);
 }
 
 void bnxt_re_ring_sq_db(struct bnxt_re_qp *qp)
 {
 	struct bnxt_re_db_hdr hdr;
+	uint32_t tail;
 
-	bnxt_re_init_db_hdr(&hdr, qp->jsqq->hwque->tail,
-			    qp->qpid, BNXT_RE_QUE_TYPE_SQ);
+	tail = qp->jsqq->hwque->tail / qp->jsqq->hwque->max_slots;
+	bnxt_re_init_db_hdr(&hdr, tail, qp->qpid, BNXT_RE_QUE_TYPE_SQ);
 	bnxt_re_ring_db(qp->udpi, &hdr);
 }
 
diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index ad660e1a..ab7ac521 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -44,6 +44,7 @@
 #include <stddef.h>
 #include <endian.h>
 #include <pthread.h>
+#include <sys/param.h>
 
 #include <infiniband/driver.h>
 #include <util/udma_barrier.h>
diff --git a/providers/bnxt_re/memory.h b/providers/bnxt_re/memory.h
index 5bcdef9a..ebbc3c51 100644
--- a/providers/bnxt_re/memory.h
+++ b/providers/bnxt_re/memory.h
@@ -57,6 +57,8 @@ struct bnxt_re_queue {
 	 * and the consumer indices in the queue
 	 */
 	uint32_t diff;
+	uint32_t esize;
+	uint32_t max_slots;
 	pthread_spinlock_t qlock;
 };
 
@@ -82,29 +84,44 @@ int bnxt_re_alloc_aligned(struct bnxt_re_queue *que, uint32_t pg_size);
 void bnxt_re_free_aligned(struct bnxt_re_queue *que);
 
 /* Basic queue operation */
-static inline uint32_t bnxt_re_is_que_full(struct bnxt_re_queue *que)
+static inline void *bnxt_re_get_hwqe(struct bnxt_re_queue *que, uint32_t idx)
 {
-	return (((que->diff + que->tail) & (que->depth - 1)) == que->head);
+	idx += que->tail;
+	if (idx >= que->depth)
+		idx -= que->depth;
+	return (void *)(que->va + (idx << 4));
 }
 
-static inline uint32_t bnxt_re_is_que_empty(struct bnxt_re_queue *que)
+static inline uint32_t bnxt_re_is_que_full(struct bnxt_re_queue *que,
+					   uint32_t slots)
 {
-	return que->tail == que->head;
+	int32_t avail, head, tail;
+
+	head = que->head;
+	tail = que->tail;
+	avail = head - tail;
+	if (head <= tail)
+		avail += que->depth;
+	return avail <= (slots + que->diff);
 }
 
-static inline uint32_t bnxt_re_incr(uint32_t val, uint32_t max)
+static inline uint32_t bnxt_re_is_que_empty(struct bnxt_re_queue *que)
 {
-	return (++val & (max - 1));
+	return que->tail == que->head;
 }
 
 static inline void bnxt_re_incr_tail(struct bnxt_re_queue *que, uint8_t cnt)
 {
-	que->tail = (que->tail + cnt) & (que->depth - 1);
+	que->tail += cnt;
+	if (que->tail >= que->depth)
+		que->tail %= que->depth;
 }
 
 static inline void bnxt_re_incr_head(struct bnxt_re_queue *que, uint8_t cnt)
 {
-	que->head = (que->head + cnt) & (que->depth - 1);
+	que->head += cnt;
+	if (que->head >= que->depth)
+		que->head %= que->depth;
 }
 
 #endif
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 9c3cfbd3..be7a2a47 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -885,24 +885,107 @@ static int bnxt_re_alloc_init_swque(struct bnxt_re_joint_queue *jqq, int nwr)
 	return 0;
 }
 
-static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
+static int bnxt_re_calc_wqe_sz(int nsge)
+{
+	/* This is used for both sq and rq. In case hdr size differs
+	 * in future move to individual functions.
+	 */
+	return sizeof(struct bnxt_re_sge) * nsge + bnxt_re_get_sqe_hdr_sz();
+}
+
+static int bnxt_re_get_rq_slots(struct bnxt_re_dev *rdev,
+				struct bnxt_re_qp *qp, uint32_t nrwr,
+				uint32_t nsge)
+{
+	uint32_t max_wqesz;
+	uint32_t wqe_size;
+	uint32_t stride;
+	uint32_t slots;
+
+	stride = sizeof(struct bnxt_re_sge);
+	max_wqesz = bnxt_re_calc_wqe_sz(rdev->devattr.max_sge);
+
+	wqe_size = bnxt_re_calc_wqe_sz(nsge);
+	if (wqe_size > max_wqesz)
+		return -EINVAL;
+
+	if (qp->qpmode == BNXT_RE_WQE_MODE_STATIC)
+		wqe_size = bnxt_re_calc_wqe_sz(6);
+
+	qp->jrqq->hwque->esize = wqe_size;
+	qp->jrqq->hwque->max_slots = wqe_size / stride;
+
+	slots = (nrwr * wqe_size) / stride;
+	return slots;
+}
+
+static int bnxt_re_get_sq_slots(struct bnxt_re_dev *rdev,
+				struct bnxt_re_qp *qp, uint32_t nswr,
+				uint32_t nsge, uint32_t *ils)
+{
+	uint32_t max_wqesz;
+	uint32_t wqe_size;
+	uint32_t cal_ils;
+	uint32_t stride;
+	uint32_t ilsize;
+	uint32_t hdr_sz;
+	uint32_t slots;
+
+	hdr_sz = bnxt_re_get_sqe_hdr_sz();
+	stride = sizeof(struct bnxt_re_sge);
+	max_wqesz = bnxt_re_calc_wqe_sz(rdev->devattr.max_sge);
+	ilsize = get_aligned(*ils, hdr_sz);
+
+	wqe_size = bnxt_re_calc_wqe_sz(nsge);
+	if (ilsize) {
+		cal_ils = hdr_sz + ilsize;
+		wqe_size = MAX(cal_ils, wqe_size);
+		wqe_size = get_aligned(wqe_size, hdr_sz);
+	}
+	if (wqe_size > max_wqesz)
+		return -EINVAL;
+
+	if (qp->qpmode == BNXT_RE_WQE_MODE_STATIC)
+		wqe_size = bnxt_re_calc_wqe_sz(6);
+
+	if (*ils)
+		*ils = wqe_size - hdr_sz;
+	qp->jsqq->hwque->esize = wqe_size;
+	qp->jsqq->hwque->max_slots = (qp->qpmode == BNXT_RE_WQE_MODE_STATIC) ?
+		wqe_size / stride : 1;
+	slots = (nswr * wqe_size) / stride;
+	return slots;
+}
+
+static int bnxt_re_alloc_queues(struct bnxt_re_dev *dev,
+				struct bnxt_re_qp *qp,
 				struct ibv_qp_init_attr *attr,
 				uint32_t pg_size) {
 	struct bnxt_re_psns_ext *psns_ext;
 	struct bnxt_re_wrid *swque;
 	struct bnxt_re_queue *que;
 	struct bnxt_re_psns *psns;
+	uint32_t nswr, diff;
 	uint32_t psn_depth;
 	uint32_t psn_size;
+	uint32_t nsge;
 	int ret, indx;
-	uint32_t nswr;
+	int nslots;
 
 	que = qp->jsqq->hwque;
-	que->stride = bnxt_re_get_sqe_sz();
-	/* 8916 adjustment */
-	nswr  = roundup_pow_of_two(attr->cap.max_send_wr + 1 +
-				   BNXT_RE_FULL_FLAG_DELTA);
-	que->diff = nswr - attr->cap.max_send_wr;
+	diff = (qp->qpmode == BNXT_RE_WQE_MODE_VARIABLE) ?
+		0 : BNXT_RE_FULL_FLAG_DELTA;
+	nswr = roundup_pow_of_two(attr->cap.max_send_wr + 1 + diff);
+	nsge = attr->cap.max_send_sge;
+	if (nsge % 2)
+		nsge++;
+	nslots = bnxt_re_get_sq_slots(dev, qp, nswr, nsge,
+				      &attr->cap.max_inline_data);
+	if (nslots < 0)
+		 return nslots;
+	que->stride = sizeof(struct bnxt_re_sge);
+	que->depth = nslots;
+	que->diff = (diff * que->esize) / que->stride;
 
 	/* psn_depth extra entries of size que->stride */
 	psn_size = bnxt_re_is_chip_gen_p5(qp->cctx) ?
@@ -911,7 +994,7 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	psn_depth = (nswr * psn_size) / que->stride;
 	if ((nswr * psn_size) % que->stride)
 		psn_depth++;
-	que->depth = nswr + psn_depth;
+	que->depth += psn_depth;
 	/* PSN-search memory is allocated without checking for
 	 * QP-Type. Kenrel driver do not map this memory if it
 	 * is UD-qp. UD-qp use this memory to maintain WC-opcode.
@@ -923,7 +1006,7 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	/* exclude psns depth*/
 	que->depth -= psn_depth;
 	/* start of spsn space sizeof(struct bnxt_re_psns) each. */
-	psns = (que->va + que->stride * nswr);
+	psns = (que->va + que->stride * que->depth);
 	psns_ext = (struct bnxt_re_psns_ext *)psns;
 
 	ret = bnxt_re_alloc_init_swque(qp->jsqq, nswr);
@@ -946,10 +1029,19 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 
 	if (qp->jrqq) {
 		que = qp->jrqq->hwque;
-		que->stride = bnxt_re_get_rqe_sz();
 		nswr = roundup_pow_of_two(attr->cap.max_recv_wr + 1);
-		que->depth = nswr;
-		que->diff = nswr - attr->cap.max_recv_wr;
+		nsge = attr->cap.max_recv_sge;
+		if (nsge % 2)
+			nsge++;
+		nslots = bnxt_re_get_rq_slots(dev, qp, nswr, nsge);
+		if (nslots < 0) {
+			ret = nslots;
+			goto fail;
+		}
+		que->stride = sizeof(struct bnxt_re_sge);
+		que->depth = nslots;
+		que->diff = 0;
+
 		ret = bnxt_re_alloc_aligned(que, pg_size);
 		if (ret)
 			goto fail;
@@ -970,10 +1062,10 @@ fail:
 struct ibv_qp *bnxt_re_create_qp(struct ibv_pd *ibvpd,
 				 struct ibv_qp_init_attr *attr)
 {
-	struct bnxt_re_qp *qp;
-	struct ubnxt_re_qp req;
 	struct ubnxt_re_qp_resp resp;
 	struct bnxt_re_qpcap *cap;
+	struct ubnxt_re_qp req;
+	struct bnxt_re_qp *qp;
 
 	struct bnxt_re_context *cntx = to_bnxt_re_context(ibvpd->context);
 	struct bnxt_re_dev *dev = to_bnxt_re_dev(cntx->ibvctx.context.device);
@@ -990,7 +1082,7 @@ struct ibv_qp *bnxt_re_create_qp(struct ibv_pd *ibvpd,
 	/* alloc queues */
 	qp->cctx = &cntx->cctx;
 	qp->qpmode = cntx->wqe_mode & BNXT_RE_WQE_MODE_VARIABLE;
-	if (bnxt_re_alloc_queues(qp, attr, dev->pg_size))
+	if (bnxt_re_alloc_queues(dev, qp, attr, dev->pg_size))
 		goto failq;
 	/* Fill ibv_cmd */
 	cap = &qp->cap;
@@ -1094,8 +1186,44 @@ int bnxt_re_destroy_qp(struct ibv_qp *ibvqp)
 	return 0;
 }
 
+static int bnxt_re_calc_inline_len(struct ibv_send_wr *swr, uint32_t max_ils)
+{
+	int illen, indx;
+
+	illen = 0;
+	for (indx = 0; indx < swr->num_sge; indx++)
+		illen += swr->sg_list[indx].length;
+	if (illen > max_ils)
+		illen = max_ils;
+	return illen;
+}
+
+static int bnxt_re_calc_posted_wqe_slots(struct bnxt_re_queue *que, void *wr,
+					 uint32_t max_ils, bool is_rq)
+{
+	struct ibv_send_wr *swr;
+	struct ibv_recv_wr *rwr;
+	uint32_t wqe_byte;
+	uint32_t nsge;
+	int ilsize;
+
+	swr = wr;
+	rwr = wr;
+
+	nsge = is_rq ? rwr->num_sge : swr->num_sge;
+	wqe_byte = bnxt_re_calc_wqe_sz(nsge);
+	if (!is_rq && (swr->send_flags & IBV_SEND_INLINE)) {
+		ilsize = bnxt_re_calc_inline_len(swr, max_ils);
+		wqe_byte = get_aligned(ilsize, sizeof(struct bnxt_re_sge));
+		wqe_byte += sizeof(struct bnxt_re_bsqe);
+	}
+
+	return (wqe_byte / que->stride);
+}
+
 static inline uint8_t bnxt_re_set_hdr_flags(struct bnxt_re_bsqe *hdr,
-					    uint32_t send_flags, uint8_t sqsig)
+					    uint32_t send_flags, uint8_t sqsig,
+					    uint32_t slots)
 {
 	uint8_t is_inline = false;
 	uint32_t hdrval = 0;
@@ -1116,36 +1244,38 @@ static inline uint8_t bnxt_re_set_hdr_flags(struct bnxt_re_bsqe *hdr,
 			    << BNXT_RE_HDR_FLAGS_SHIFT);
 		is_inline = true;
 	}
+	hdrval |= (slots & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT;
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
 
 	return is_inline;
 }
 
-static int bnxt_re_build_sge(struct bnxt_re_sge *sge, struct ibv_sge *sg_list,
-			     uint32_t num_sge, uint8_t is_inline) {
+static int bnxt_re_build_sge(struct bnxt_re_queue *que, struct ibv_sge *sg_list,
+			     uint32_t num_sge, uint8_t is_inline,
+			     uint32_t *idx)
+{
+	struct bnxt_re_sge *sge;
 	int indx, length = 0;
 	void *dst;
 
-	if (!num_sge) {
-		memset(sge, 0, sizeof(*sge));
+	if (!num_sge)
 		return 0;
-	}
 
 	if (is_inline) {
-		dst = sge;
 		for (indx = 0; indx < num_sge; indx++) {
+			dst = bnxt_re_get_hwqe(que, *idx);
+			(*idx)++;
 			length += sg_list[indx].length;
-			if (length > BNXT_RE_MAX_INLINE_SIZE)
-				return -ENOMEM;
 			memcpy(dst, (void *)(uintptr_t)sg_list[indx].addr,
 			       sg_list[indx].length);
-			dst = dst + sg_list[indx].length;
 		}
 	} else {
 		for (indx = 0; indx < num_sge; indx++) {
-			sge[indx].pa = htole64(sg_list[indx].addr);
-			sge[indx].lkey = htole32(sg_list[indx].lkey);
-			sge[indx].length = htole32(sg_list[indx].length);
+			sge = bnxt_re_get_hwqe(que, *idx);
+			(*idx)++;
+			sge->pa = htole64(sg_list[indx].addr);
+			sge->lkey = htole32(sg_list[indx].lkey);
+			sge->length = htole32(sg_list[indx].length);
 			length += sg_list[indx].length;
 		}
 	}
@@ -1163,6 +1293,7 @@ static void bnxt_re_fill_psns(struct bnxt_re_qp *qp, struct bnxt_re_wrid *wrid,
 
 	psns = wrid->psns;
 	psns_ext = wrid->psns_ext;
+	len = wrid->bytes;
 
 	if (qp->qptyp == IBV_QPT_RC) {
 		opc_spsn = qp->sq_psn & BNXT_RE_PSNS_SPSN_MASK;
@@ -1182,7 +1313,7 @@ static void bnxt_re_fill_psns(struct bnxt_re_qp *qp, struct bnxt_re_wrid *wrid,
 	psns->opc_spsn = htole32(opc_spsn);
 	psns->flg_npsn = htole32(flg_npsn);
 	if (bnxt_re_is_chip_gen_p5(qp->cctx))
-		psns_ext->st_slot_idx = 0;
+		psns_ext->st_slot_idx = wrid->st_slot_idx;
 }
 
 static void bnxt_re_fill_wrid(struct bnxt_re_wrid *wrid, uint64_t wr_id,
@@ -1198,16 +1329,19 @@ static void bnxt_re_fill_wrid(struct bnxt_re_wrid *wrid, uint64_t wr_id,
 	wrid->slots = slots;
 }
 
-static int bnxt_re_build_send_sqe(struct bnxt_re_qp *qp, void *wqe,
-				  struct ibv_send_wr *wr, uint8_t is_inline)
+static int bnxt_re_build_send_sqe(struct bnxt_re_qp *qp,
+				  struct ibv_send_wr *wr,
+				  struct bnxt_re_bsqe *hdr,
+				  uint8_t is_inline, uint32_t *idx)
 {
-	struct bnxt_re_sge *sge = ((void *)wqe + bnxt_re_get_sqe_hdr_sz());
-	struct bnxt_re_bsqe *hdr = wqe;
-	uint32_t wrlen, hdrval = 0;
-	uint8_t opcode, qesize;
+	struct bnxt_re_queue *que;
+	uint32_t hdrval = 0;
+	uint8_t opcode;
 	int len;
 
-	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, is_inline);
+	que = qp->jsqq->hwque;
+	len = bnxt_re_build_sge(que, wr->sg_list, wr->num_sge,
+				is_inline, idx);
 	if (len < 0)
 		return len;
 	hdr->lhdr.qkey_len = htole64((uint64_t)len);
@@ -1217,34 +1351,22 @@ static int bnxt_re_build_send_sqe(struct bnxt_re_qp *qp, void *wqe,
 	if (opcode == BNXT_RE_WR_OPCD_INVAL)
 		return -EINVAL;
 	hdrval = (opcode & BNXT_RE_HDR_WT_MASK);
-
-	if (is_inline) {
-		wrlen = get_aligned(len, 16);
-		qesize = wrlen >> 4;
-	} else {
-		qesize = wr->num_sge;
-	}
-	/* HW requires wqe size has room for atleast one sge even if none was
-	 * supplied by application
-	 */
-	if (!wr->num_sge)
-		qesize++;
-	qesize += (bnxt_re_get_sqe_hdr_sz() >> 4);
-	hdrval |= (qesize & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT;
 	hdr->rsv_ws_fl_wt |= htole32(hdrval);
 	return len;
 }
 
-static int bnxt_re_build_ud_sqe(struct bnxt_re_qp *qp, void *wqe,
-				struct ibv_send_wr *wr, uint8_t is_inline)
+static int bnxt_re_build_ud_sqe(struct bnxt_re_qp *qp, struct ibv_send_wr *wr,
+				struct bnxt_re_bsqe *hdr, uint8_t is_inline,
+				uint32_t *idx)
 {
-	struct bnxt_re_send *sqe = ((void *)wqe + sizeof(struct bnxt_re_bsqe));
-	struct bnxt_re_bsqe *hdr = wqe;
+	struct bnxt_re_send *sqe;
 	struct bnxt_re_ah *ah;
 	uint64_t qkey;
 	int len;
 
-	len = bnxt_re_build_send_sqe(qp, wqe, wr, is_inline);
+	sqe = bnxt_re_get_hwqe(qp->jsqq->hwque, *idx);
+	(*idx)++;
+	len = bnxt_re_build_send_sqe(qp, wr, hdr, is_inline, idx);
 	if (!wr->wr.ud.ah) {
 		len = -EINVAL;
 		goto bail;
@@ -1258,28 +1380,33 @@ bail:
 	return len;
 }
 
-static int bnxt_re_build_rdma_sqe(struct bnxt_re_qp *qp, void *wqe,
-				  struct ibv_send_wr *wr, uint8_t is_inline)
+static int bnxt_re_build_rdma_sqe(struct bnxt_re_qp *qp,
+				  struct bnxt_re_bsqe *hdr,
+				  struct ibv_send_wr *wr,
+				  uint8_t is_inline, uint32_t *idx)
 {
-	struct bnxt_re_rdma *sqe = ((void *)wqe + sizeof(struct bnxt_re_bsqe));
+	struct bnxt_re_rdma *sqe;
 	int len;
 
-	len = bnxt_re_build_send_sqe(qp, wqe, wr, is_inline);
+	sqe = bnxt_re_get_hwqe(qp->jsqq->hwque, *idx);
+	(*idx)++;
+	len = bnxt_re_build_send_sqe(qp, wr, hdr, is_inline, idx);
 	sqe->rva = htole64(wr->wr.rdma.remote_addr);
 	sqe->rkey = htole32(wr->wr.rdma.rkey);
 
 	return len;
 }
 
-static int bnxt_re_build_cns_sqe(struct bnxt_re_qp *qp, void *wqe,
-				 struct ibv_send_wr *wr)
+static int bnxt_re_build_cns_sqe(struct bnxt_re_qp *qp,
+				 struct bnxt_re_bsqe *hdr,
+				 struct ibv_send_wr *wr, uint32_t *idx)
 {
-	struct bnxt_re_bsqe *hdr = wqe;
-	struct bnxt_re_atomic *sqe = ((void *)wqe +
-				      sizeof(struct bnxt_re_bsqe));
+	struct bnxt_re_atomic *sqe;
 	int len;
 
-	len = bnxt_re_build_send_sqe(qp, wqe, wr, false);
+	sqe = bnxt_re_get_hwqe(qp->jsqq->hwque, *idx);
+	(*idx)++;
+	len = bnxt_re_build_send_sqe(qp, wr, hdr, false, idx);
 	hdr->key_immd = htole32(wr->wr.atomic.rkey);
 	hdr->lhdr.rva = htole64(wr->wr.atomic.remote_addr);
 	sqe->cmp_dt = htole64(wr->wr.atomic.compare_add);
@@ -1288,15 +1415,16 @@ static int bnxt_re_build_cns_sqe(struct bnxt_re_qp *qp, void *wqe,
 	return len;
 }
 
-static int bnxt_re_build_fna_sqe(struct bnxt_re_qp *qp, void *wqe,
-				 struct ibv_send_wr *wr)
+static int bnxt_re_build_fna_sqe(struct bnxt_re_qp *qp,
+				 struct bnxt_re_bsqe *hdr,
+				 struct ibv_send_wr *wr, uint32_t *idx)
 {
-	struct bnxt_re_bsqe *hdr = wqe;
-	struct bnxt_re_atomic *sqe = ((void *)wqe +
-				      sizeof(struct bnxt_re_bsqe));
+	struct bnxt_re_atomic *sqe;
 	int len;
 
-	len = bnxt_re_build_send_sqe(qp, wqe, wr, false);
+	sqe = bnxt_re_get_hwqe(qp->jsqq->hwque, *idx);
+	(*idx)++;
+	len = bnxt_re_build_send_sqe(qp, wr, hdr, false, idx);
 	hdr->key_immd = htole32(wr->wr.atomic.rkey);
 	hdr->lhdr.rva = htole64(wr->wr.atomic.remote_addr);
 	sqe->cmp_dt = htole64(wr->wr.atomic.compare_add);
@@ -1310,13 +1438,16 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 	struct bnxt_re_qp *qp = to_bnxt_re_qp(ibvqp);
 	struct bnxt_re_queue *sq = qp->jsqq->hwque;
 	struct bnxt_re_wrid *wrid;
+	struct bnxt_re_send *sqe;
 	uint8_t is_inline = false;
 	struct bnxt_re_bsqe *hdr;
+	uint32_t swq_idx, slots;
 	int ret = 0, bytes = 0;
 	bool ring_db = false;
-	uint32_t swq_idx;
-	uint32_t sig;
-	void *sqe;
+	uint32_t wqe_size;
+	uint32_t max_ils;
+	uint8_t sig = 0;
+	uint32_t idx;
 
 	pthread_spin_lock(&sq->qlock);
 	while (wr) {
@@ -1334,18 +1465,20 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			goto bad_wr;
 		}
 
-		if (bnxt_re_is_que_full(sq) ||
+		max_ils = qp->cap.max_inline;
+		wqe_size = bnxt_re_calc_posted_wqe_slots(sq, wr, max_ils, false);
+		slots = (qp->qpmode == BNXT_RE_WQE_MODE_STATIC) ? 8 : wqe_size;
+		if (bnxt_re_is_que_full(sq, slots) ||
 		    wr->num_sge > qp->cap.max_ssge) {
 			*bad = wr;
 			ret = ENOMEM;
 			goto bad_wr;
 		}
 
-		sqe = (void *)(sq->va + (sq->tail * sq->stride));
-		memset(sqe, 0, bnxt_re_get_sqe_sz());
-		hdr = sqe;
+		idx = 0;
+		hdr = bnxt_re_get_hwqe(sq, idx++);
 		is_inline = bnxt_re_set_hdr_flags(hdr, wr->send_flags,
-						  qp->cap.sqsig);
+						  qp->cap.sqsig, wqe_size);
 		switch (wr->opcode) {
 		case IBV_WR_SEND_WITH_IMM:
 			/* Since our h/w is LE and user supplies raw-data in
@@ -1356,27 +1489,31 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			hdr->key_immd = htole32(be32toh(wr->imm_data));
 			SWITCH_FALLTHROUGH;
 		case IBV_WR_SEND:
-			if (qp->qptyp == IBV_QPT_UD)
-				bytes = bnxt_re_build_ud_sqe(qp, sqe, wr,
-							     is_inline);
-			else
-				bytes = bnxt_re_build_send_sqe(qp, sqe, wr,
-							       is_inline);
+			if (qp->qptyp == IBV_QPT_UD) {
+				bytes = bnxt_re_build_ud_sqe(qp, wr, hdr,
+							     is_inline, &idx);
+			} else {
+				sqe = bnxt_re_get_hwqe(sq, idx++);
+				memset(sqe, 0, sizeof(struct bnxt_re_send));
+				bytes = bnxt_re_build_send_sqe(qp, wr, hdr,
+							       is_inline,
+							       &idx);
+			}
 			break;
 		case IBV_WR_RDMA_WRITE_WITH_IMM:
 			hdr->key_immd = htole32(be32toh(wr->imm_data));
 			SWITCH_FALLTHROUGH;
 		case IBV_WR_RDMA_WRITE:
-			bytes = bnxt_re_build_rdma_sqe(qp, sqe, wr, is_inline);
+			bytes = bnxt_re_build_rdma_sqe(qp, hdr, wr, is_inline, &idx);
 			break;
 		case IBV_WR_RDMA_READ:
-			bytes = bnxt_re_build_rdma_sqe(qp, sqe, wr, false);
+			bytes = bnxt_re_build_rdma_sqe(qp, hdr, wr, false, &idx);
 			break;
 		case IBV_WR_ATOMIC_CMP_AND_SWP:
-			bytes = bnxt_re_build_cns_sqe(qp, sqe, wr);
+			bytes = bnxt_re_build_cns_sqe(qp, hdr, wr, &idx);
 			break;
 		case IBV_WR_ATOMIC_FETCH_AND_ADD:
-			bytes = bnxt_re_build_fna_sqe(qp, sqe, wr);
+			bytes = bnxt_re_build_fna_sqe(qp, hdr, wr, &idx);
 			break;
 		default:
 			bytes = -EINVAL;
@@ -1391,10 +1528,11 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 
 		wrid = bnxt_re_get_swqe(qp->jsqq, &swq_idx);
 		sig = ((wr->send_flags & IBV_SEND_SIGNALED) || qp->cap.sqsig);
-		bnxt_re_fill_wrid(wrid, wr->wr_id, bytes, sig, sq->tail, 1);
+		bnxt_re_fill_wrid(wrid, wr->wr_id, bytes,
+				  sig, sq->tail, slots);
 		bnxt_re_fill_psns(qp, wrid, wr->opcode, bytes);
 		bnxt_re_jqq_mod_start(qp->jsqq, swq_idx);
-		bnxt_re_incr_tail(sq, 1);
+		bnxt_re_incr_tail(sq, slots);
 		qp->wqe_cnt++;
 		wr = wr->next;
 		ring_db = true;
@@ -1420,17 +1558,14 @@ bad_wr:
 	return ret;
 }
 
-static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
-			     void *rqe, uint32_t idx)
+static int bnxt_re_build_rqe(struct bnxt_re_queue *rq, struct ibv_recv_wr *wr,
+			     struct bnxt_re_brqe *hdr, uint32_t wqe_sz,
+			     uint32_t *idx, uint32_t wqe_idx)
 {
-	struct bnxt_re_brqe *hdr = rqe;
-	struct bnxt_re_sge *sge;
-	int wqe_sz, len;
 	uint32_t hdrval;
+	int len;
 
-	sge = (rqe + bnxt_re_get_rqe_hdr_sz());
-
-	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, false);
+	len = bnxt_re_build_sge(rq, wr->sg_list, wr->num_sge, false, idx);
 	wqe_sz = wr->num_sge + (bnxt_re_get_rqe_hdr_sz() >> 4); /* 16B align */
 	/* HW requires wqe size has room for atleast one sge even if none was
 	 * supplied by application
@@ -1440,7 +1575,7 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 	hdrval = BNXT_RE_WR_OPCD_RECV;
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
-	hdr->wrid = htole32(idx);
+	hdr->wrid = htole32(wqe_idx);
 
 	return len;
 }
@@ -1451,8 +1586,11 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 	struct bnxt_re_qp *qp = to_bnxt_re_qp(ibvqp);
 	struct bnxt_re_queue *rq = qp->jrqq->hwque;
 	struct bnxt_re_wrid *swque;
-	uint32_t swq_idx;
-	void *rqe;
+	struct bnxt_re_brqe *hdr;
+	struct bnxt_re_rqe *rqe;
+	uint32_t slots, swq_idx;
+	uint32_t wqe_size;
+	uint32_t idx = 0;
 	int ret;
 
 	pthread_spin_lock(&rq->qlock);
@@ -1464,17 +1602,24 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 			return EINVAL;
 		}
 
-		if (bnxt_re_is_que_full(rq) ||
+		wqe_size = bnxt_re_calc_posted_wqe_slots(rq, wr, 0, true);
+		slots = rq->max_slots;
+		if (bnxt_re_is_que_full(rq, slots) ||
 		    wr->num_sge > qp->cap.max_rsge) {
 			pthread_spin_unlock(&rq->qlock);
 			*bad = wr;
 			return ENOMEM;
 		}
 
-		rqe = (void *)(rq->va + (rq->tail * rq->stride));
-		memset(rqe, 0, bnxt_re_get_rqe_sz());
+		idx = 0;
 		swque = bnxt_re_get_swqe(qp->jrqq, &swq_idx);
-		ret = bnxt_re_build_rqe(qp, wr, rqe, swq_idx);
+		hdr = bnxt_re_get_hwqe(rq, idx++);
+		/* Just to build clean rqe */
+		rqe = bnxt_re_get_hwqe(rq, idx++);
+		memset(rqe, 0, sizeof(struct bnxt_re_rqe));
+		/* Fill  SGEs */
+
+		ret = bnxt_re_build_rqe(rq, wr, hdr, wqe_size, &idx, swq_idx);
 		if (ret < 0) {
 			pthread_spin_unlock(&rq->qlock);
 			*bad = wr;
@@ -1482,9 +1627,9 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 		}
 
 		swque = bnxt_re_get_swqe(qp->jrqq, NULL);
-		bnxt_re_fill_wrid(swque, wr->wr_id, ret, 0, rq->tail, 1);
+		bnxt_re_fill_wrid(swque, wr->wr_id, ret, 0, rq->tail, slots);
 		bnxt_re_jqq_mod_start(qp->jrqq, swq_idx);
-		bnxt_re_incr_tail(rq, 1);
+		bnxt_re_incr_tail(rq, slots);
 		wr = wr->next;
 		bnxt_re_ring_rq_db(qp);
 	}
@@ -1643,12 +1788,20 @@ static int bnxt_re_build_srqe(struct bnxt_re_srq *srq,
 	struct bnxt_re_wrid *wrid;
 	int wqe_sz, len, next;
 	uint32_t hdrval = 0;
+	int indx;
 
 	sge = (srqe + bnxt_re_get_srqe_hdr_sz());
 	next = srq->start_idx;
 	wrid = &srq->srwrid[next];
 
-	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, false);
+	len = 0;
+	for (indx = 0; indx < wr->num_sge; indx++, sge++) {
+		sge->pa = htole64(wr->sg_list[indx].addr);
+		sge->lkey = htole32(wr->sg_list[indx].lkey);
+		sge->length = htole32(wr->sg_list[indx].length);
+		len += wr->sg_list[indx].length;
+	}
+
 	hdrval = BNXT_RE_WR_OPCD_RECV;
 	wqe_sz = wr->num_sge + (bnxt_re_get_srqe_hdr_sz() >> 4); /* 16B align */
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
-- 
2.25.1


--000000000000fb3d7a05c286ab22
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPY4ni+ZULpheHQaMvpTWmX2/UNp
vcJc9ekioSWjZVWcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxNzEzMzU1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBLCPndf+RDw2m4gF528j9L8IPPFwLdOLKppUqicRVnobaM
g5Pa50pa90fkGl2svpPNiKcH02DfNloAiH9JbBT46mwTRvDRXsvRZefsuHYSFjTSVUf0L2dcqseT
p5bTSZDtDpiWqexzT5gUjEJLpaqFJJAJU9gsqpV8EgMFbiHVF1bnjpCqR4SDw0GYECOehK4lgEgw
Y2nJmyDizvML+V2ljzXpQ3SCOyb3DSTdumMVHKMxU9fL0WOnRdq7J4XkQzyeqEmiPJelMHJoYV9Q
lYK3aB7nU1NRsDHfHKRcOlTLz2qU3nSSkgSkWsKlkfZBks0hai5WlsVNXx705QTadbCy
--000000000000fb3d7a05c286ab22--
