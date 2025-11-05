Return-Path: <linux-rdma+bounces-14251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C88C33F33
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 05:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 963BF4E2DF2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 04:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0012246781;
	Wed,  5 Nov 2025 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lE2Xe52w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B122B5A5;
	Wed,  5 Nov 2025 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318299; cv=none; b=qED860z/LI/q8o+er+FVvPiADsEfvOdG4AjlMtWa+b4ZkSBPph+zSj1ydlMnQQ8dbtkLlB5SLw7jifxoedgr6PZkgqO/jEpVq1CzhSHS9BtHWuqmfGse0laE2g9odqTDDNpw74QUfT6R8o6nOiVdkpJk8/iwh1yGf0iYsXhtMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318299; c=relaxed/simple;
	bh=sZB8G529unNpWy/FyH90fT8ohk3mTLsQ5PJlJmE8SPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wko5zcR3jxbpKqK0iWmEWOg86TrTq5yu7Vt63JWzF+HH9yIXN5+YDRTJTA5TjI50T5tZDcmZt5tHDPWpI3Yrj/3JVTJmljjsT/R1+u/gNFulVnxzIbaq6LvYVvVU95/TO8PWiYhK3GAgcg4SjXznR+XfCoIbnPrKzgfwH7qSPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lE2Xe52w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2k5Kp89MAx36JxKWDQj+W8fBkTj0Ai55gOiGWH9soyQ=; b=lE2Xe52wHaoem0E59PgUZKKJy4
	VgRNKgo+gIdfvDmjBvlql6xa/HUINS3C3eutu/MRRb+f6soB1o9FVpyL2nxiMt+1luHRmgKMsv7YB
	1EklvIav+4q1P1pF3+M0MXUloD5VLkeWxkm1WqZ9Rs2vpTVEgQ0mk2RkPiz9sKOf8VRjY8kquw0/h
	ydNE5joEw+hjlq3ZUrx5dVuGyNOCfJ8aYMs9Bn1RdmpWUYTYMtqCsxfHy+o8w5LBK0uivlNcKkH6c
	RPk+oOKvGNDS5ozpRPpsPgNJwNYQk5Tg8AlOvEOK+2GxURAGvh5ol6L7JIxEzh96z6ni+QeC4xiDD
	0S1/skgw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGVUV-0000000D12U-39Ra;
	Wed, 05 Nov 2025 04:51:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments
Date: Tue,  4 Nov 2025 20:51:27 -0800
Message-ID: <20251105045127.106822-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the kernel-doc comments format to avoid around 35 kernel-doc
warnings:

- use struct keyword to introduce struct kernel-doc comments
- use correct variable name for some struct members
- use correct function name in comments for some functions
- fix spelling in a few comments
- use a ':' instead of '-' to separate struct members from their
  descriptions
- add a function name heading for rvt_div_mtu()

This leaves one struct member that is not described:
rdmavt_qp.h:206: warning: Function parameter or struct member 'wq'
 not described in 'rvt_krwq'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 include/rdma/rdmavt_qp.h |   70 +++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

--- linux-next-20251103.orig/include/rdma/rdmavt_qp.h
+++ linux-next-20251103/include/rdma/rdmavt_qp.h
@@ -144,7 +144,7 @@
 #define RVT_SEND_COMPLETION_ONLY	(IB_SEND_RESERVED_START << 1)
 
 /**
- * rvt_ud_wr - IB UD work plus AH cache
+ * struct rvt_ud_wr - IB UD work plus AH cache
  * @wr: valid IB work request
  * @attr: pointer to an allocated AH attribute
  *
@@ -184,10 +184,10 @@ struct rvt_swqe {
  * struct rvt_krwq - kernel struct receive work request
  * @p_lock: lock to protect producer of the kernel buffer
  * @head: index of next entry to fill
- * @c_lock:lock to protect consumer of the kernel buffer
+ * @c_lock: lock to protect consumer of the kernel buffer
  * @tail: index of next entry to pull
- * @count: count is aproximate of total receive enteries posted
- * @rvt_rwqe: struct of receive work request queue entry
+ * @count: count is approximate of total receive entries posted
+ * @curr_wq: struct of receive work request queue entry
  *
  * This structure is used to contain the head pointer,
  * tail pointer and receive work queue entries for kernel
@@ -309,10 +309,10 @@ struct rvt_ack_entry {
 #define RVT_OPERATION_MAX (IB_WR_RESERVED10 + 1)
 
 /**
- * rvt_operation_params - op table entry
- * @length - the length to copy into the swqe entry
- * @qpt_support - a bit mask indicating QP type support
- * @flags - RVT_OPERATION flags (see above)
+ * struct rvt_operation_params - op table entry
+ * @length: the length to copy into the swqe entry
+ * @qpt_support: a bit mask indicating QP type support
+ * @flags: RVT_OPERATION flags (see above)
  *
  * This supports table driven post send so that
  * the driver can have differing an potentially
@@ -552,7 +552,7 @@ static inline struct rvt_rwqe *rvt_get_r
 
 /**
  * rvt_is_user_qp - return if this is user mode QP
- * @qp - the target QP
+ * @qp: the target QP
  */
 static inline bool rvt_is_user_qp(struct rvt_qp *qp)
 {
@@ -561,7 +561,7 @@ static inline bool rvt_is_user_qp(struct
 
 /**
  * rvt_get_qp - get a QP reference
- * @qp - the QP to hold
+ * @qp: the QP to hold
  */
 static inline void rvt_get_qp(struct rvt_qp *qp)
 {
@@ -570,7 +570,7 @@ static inline void rvt_get_qp(struct rvt
 
 /**
  * rvt_put_qp - release a QP reference
- * @qp - the QP to release
+ * @qp: the QP to release
  */
 static inline void rvt_put_qp(struct rvt_qp *qp)
 {
@@ -580,7 +580,7 @@ static inline void rvt_put_qp(struct rvt
 
 /**
  * rvt_put_swqe - drop mr refs held by swqe
- * @wqe - the send wqe
+ * @wqe: the send wqe
  *
  * This drops any mr references held by the swqe
  */
@@ -597,8 +597,8 @@ static inline void rvt_put_swqe(struct r
 
 /**
  * rvt_qp_wqe_reserve - reserve operation
- * @qp - the rvt qp
- * @wqe - the send wqe
+ * @qp: the rvt qp
+ * @wqe: the send wqe
  *
  * This routine used in post send to record
  * a wqe relative reserved operation use.
@@ -612,8 +612,8 @@ static inline void rvt_qp_wqe_reserve(
 
 /**
  * rvt_qp_wqe_unreserve - clean reserved operation
- * @qp - the rvt qp
- * @flags - send wqe flags
+ * @qp: the rvt qp
+ * @flags: send wqe flags
  *
  * This decrements the reserve use count.
  *
@@ -653,8 +653,8 @@ u32 rvt_restart_sge(struct rvt_sge_state
 
 /**
  * rvt_div_round_up_mtu - round up divide
- * @qp - the qp pair
- * @len - the length
+ * @qp: the qp pair
+ * @len: the length
  *
  * Perform a shift based mtu round up divide
  */
@@ -664,8 +664,9 @@ static inline u32 rvt_div_round_up_mtu(s
 }
 
 /**
- * @qp - the qp pair
- * @len - the length
+ * rvt_div_mtu - shift-based divide
+ * @qp: the qp pair
+ * @len: the length
  *
  * Perform a shift based mtu divide
  */
@@ -676,7 +677,7 @@ static inline u32 rvt_div_mtu(struct rvt
 
 /**
  * rvt_timeout_to_jiffies - Convert a ULP timeout input into jiffies
- * @timeout - timeout input(0 - 31).
+ * @timeout: timeout input(0 - 31).
  *
  * Return a timeout value in jiffies.
  */
@@ -690,7 +691,8 @@ static inline unsigned long rvt_timeout_
 
 /**
  * rvt_lookup_qpn - return the QP with the given QPN
- * @ibp: the ibport
+ * @rdi: rvt device info structure
+ * @rvp: the ibport
  * @qpn: the QP number to look up
  *
  * The caller must hold the rcu_read_lock(), and keep the lock until
@@ -716,9 +718,9 @@ static inline struct rvt_qp *rvt_lookup_
 }
 
 /**
- * rvt_mod_retry_timer - mod a retry timer
- * @qp - the QP
- * @shift - timeout shift to wait for multiple packets
+ * rvt_mod_retry_timer_ext - mod a retry timer
+ * @qp: the QP
+ * @shift: timeout shift to wait for multiple packets
  * Modify a potentially already running retry timer
  */
 static inline void rvt_mod_retry_timer_ext(struct rvt_qp *qp, u8 shift)
@@ -753,7 +755,7 @@ static inline void rvt_put_qp_swqe(struc
 }
 
 /**
- * rvt_qp_sqwe_incr - increment ring index
+ * rvt_qp_swqe_incr - increment ring index
  * @qp: the qp
  * @val: the starting value
  *
@@ -811,10 +813,10 @@ static inline void rvt_send_cq(struct rv
 
 /**
  * rvt_qp_complete_swqe - insert send completion
- * @qp - the qp
- * @wqe - the send wqe
- * @opcode - wc operation (driver dependent)
- * @status - completion status
+ * @qp: the qp
+ * @wqe: the send wqe
+ * @opcode: wc operation (driver dependent)
+ * @status: completion status
  *
  * Update the s_last information, and then insert a send
  * completion into the completion
@@ -891,7 +893,7 @@ void rvt_ruc_loopback(struct rvt_qp *qp)
 
 /**
  * struct rvt_qp_iter - the iterator for QPs
- * @qp - the current QP
+ * @qp: the current QP
  *
  * This structure defines the current iterator
  * state for sequenced access to all QPs relative
@@ -913,7 +915,7 @@ struct rvt_qp_iter {
 
 /**
  * ib_cq_tail - Return tail index of cq buffer
- * @send_cq - The cq for send
+ * @send_cq: The cq for send
  *
  * This is called in qp_iter_print to get tail
  * of cq buffer.
@@ -929,7 +931,7 @@ static inline u32 ib_cq_tail(struct ib_c
 
 /**
  * ib_cq_head - Return head index of cq buffer
- * @send_cq - The cq for send
+ * @send_cq: The cq for send
  *
  * This is called in qp_iter_print to get head
  * of cq buffer.
@@ -945,7 +947,7 @@ static inline u32 ib_cq_head(struct ib_c
 
 /**
  * rvt_free_rq - free memory allocated for rvt_rq struct
- * @rvt_rq: request queue data structure
+ * @rq: request queue data structure
  *
  * This function should only be called if the rvt_mmap_info()
  * has not succeeded.

