Return-Path: <linux-rdma+bounces-22572-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lG9BAf3+QmqeLwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22572-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 01:25:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5536DF361
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 01:25:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=k1hYrZHt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22572-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22572-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBB4F300C324
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A213CF022;
	Mon, 29 Jun 2026 23:25:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05F3CDBDD
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 23:25:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775546; cv=none; b=IV8DcUZLKG5yTtqyIZQ75mkRNd4aybgAgvV5TMNkoZ7GgN9Y10ar+hOd+sqBBh3nBNhuEE/bSE+8dkD3kUrhEILJU24YwiMrhEIh3HgmPa8ZXqJw9HnVo5zMaPUe36RnuIdhAyu7jJ61o03GM8soEZS1dGEwMRvjNNT/cOfq+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775546; c=relaxed/simple;
	bh=5wyL76y1Cs0FyfW+pH4PzPE720IdSyDFZ728S0PeYRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ttWu6iyR+nIf/295IMm3mR8t4dfTgtmOxEFd12CbG3e9ATGhO7jrHtx//v25UNH7I+MUpDjA8rdG/kMIuAXhhtAqj3+duNHSKTg98cDowtm+8rGn55y93CY4UJRaTxJe8ky5je2CxG8XQ/rbDBN0GPzVgruGNGrfVqIULpAfQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1hYrZHt; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92e623b0e95so93351485a.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782775544; x=1783380344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eGJ/EhGAKgm05wfT+2FbIW9vVNFHjPyIHeWIwgz0AE=;
        b=k1hYrZHttxKbambeBS4gZc9WGF5ny3YFVrWXDggTgj+vHTAI3rH5osCRqBW65eaiYd
         iQFTq6z5XCSP2ulVqJR5SfqXXWEFuYybMldNlPAbWCMX9njklNWf5gHL4PL6a0v2xgut
         st2ice+YlEhBRV7vvaiEqgUKH9chcz2xeCJchEqgI/TkUSim3RXS6fIj4S2fH7NiY5WX
         +v8JWUSZlqaCYfPcny37DNwlKmrlQqI41IIStJ/9YZ4OzHYoybKVylBuqqHDsz0RWPxF
         mefAC4JNutbW3rSG6ib52eDIIdmmkRPNpjNFWMHOD09L9kUQDWF9brbwGcES0oOpmpwc
         9/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775544; x=1783380344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eGJ/EhGAKgm05wfT+2FbIW9vVNFHjPyIHeWIwgz0AE=;
        b=aPl5BIeiXwDnLe9TMBAjryQrAe/A8dYImUMwz/6341ZHaoqGOFyKnZ4nMWs3h7E7aC
         Fhjr1mgXv9bmS5lTUlP6Wiv7rtT29enwZQjY2mRRs5C4aTLGjTPQ2//o30QL3OMdqWan
         ytzEzX1XUqW5Epuo+0lxGV+4vR/rwvYy9BfNInJtGKHNp95pC1IjGO3EZKiINKIIdrws
         xPQzlL7fLdkEK+8yCdpmF/PA1dmNkhtEvZpeiBiQD5TSRkCUgDUDEnRfnrr9d+xDlneV
         96SogVr5Gu/AWHbfqE/fKXHSTr5pVMo7mISOvroDcp95f1o3nWs16lajGlrQBHYW7rPl
         /6bg==
X-Gm-Message-State: AOJu0Yx/sDkmftAynbRRchhtRrTaluvinI8V+fs8Cl9qOqs5R0UOA2WJ
	NeBppDiLEGq0aYzi3aUPJ/wEw39WRikpS/h5G0ul6t4wb5N8WOQKdpIkMvOsiKoWbFcQJesTdPl
	9N5SUoMic2g==
X-Received: from qkax27-n1.prod.google.com ([2002:a05:620a:225b:10b0:91c:d162:1811])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:7002:b0:915:351b:3ae5
 with SMTP id af79cd13be357-92e627921a3mr261921585a.41.1782775543563; Mon, 29
 Jun 2026 16:25:43 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:25:29 +0000
In-Reply-To: <20260629232532.2057423-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629232532.2057423-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629232532.2057423-3-jmoroni@google.com>
Subject: [PATCH rdma-next v2 2/5] RDMA/irdma: Use robust udata input copy helpers
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22572-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D5536DF361

Replace the use of ib_copy_from_udata() with
ib_copy_validate_udata_in() where applicable.

For each modified call site, the last argument of
ib_copy_validate_udata_in() was determined by taking
the last member of the ABI struct as per its original
definition (i.e., when it was first committed).

Some methods like irdma_create_cq required special care
because the last member of the current ABI def is beyond
that of the legacy i40iw's ABI def which we need to
remain compatible with. In some other cases like modify_qp,
the legacy i40iw provider never provided any udata at all
so the validation is only performed if inlen > 0.

irdma_create_qp is more challenging because the legacy ABI
was actually larger but the additional fields were never used,
and even worse, never initialized in the provider. This will
be handled in a followup commit.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 73 +++++++++++++----------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e1c894fba2af..074dfa46b35c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1310,9 +1310,15 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if (udata) {
 		/* udata inlen/outlen can be 0 when supporting legacy libi40iw */
-		if ((udata->inlen && udata->inlen < IRDMA_MODIFY_QP_MIN_REQ_LEN) ||
-		    (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN))
+		if (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN)
 			return -EINVAL;
+
+		/* For current irdma, validate against ABI def. */
+		if (udata->inlen) {
+			ret = ib_copy_validate_udata_in(udata, ureq, rsvd);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
@@ -1555,10 +1561,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
-					if (ib_copy_from_udata(&ureq, udata,
-					    min(sizeof(ureq), udata->inlen)))
-						return -EINVAL;
-
 					irdma_flush_wqes(iwqp,
 					    (ureq.sq_flush ? IRDMA_FLUSH_SQ : 0) |
 					    (ureq.rq_flush ? IRDMA_FLUSH_RQ : 0) |
@@ -1666,9 +1668,14 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 
 	if (udata) {
 		/* udata inlen/outlen can be 0 when supporting legacy libi40iw */
-		if ((udata->inlen && udata->inlen < IRDMA_MODIFY_QP_MIN_REQ_LEN) ||
-		    (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN))
+		if (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN)
 			return -EINVAL;
+
+		if (udata->inlen) {
+			err = ib_copy_validate_udata_in(udata, ureq, rsvd);
+			if (err)
+				return err;
+		}
 	}
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
@@ -1758,10 +1765,6 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
-					if (ib_copy_from_udata(&ureq, udata,
-					    min(sizeof(ureq), udata->inlen)))
-						return -EINVAL;
-
 					irdma_flush_wqes(iwqp,
 					    (ureq.sq_flush ? IRDMA_FLUSH_SQ : 0) |
 					    (ureq.rq_flush ? IRDMA_FLUSH_RQ : 0) |
@@ -2033,7 +2036,6 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 			   struct ib_udata *udata)
 {
-#define IRDMA_RESIZE_CQ_MIN_REQ_LEN offsetofend(struct irdma_resize_cq_req, user_cq_buffer)
 	struct irdma_cq *iwcq = to_iwcq(ibcq);
 	struct irdma_sc_dev *dev = iwcq->sc_cq.dev;
 	struct irdma_cqp_request *cqp_request;
@@ -2057,9 +2059,6 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	    IRDMA_FEATURE_CQ_RESIZE))
 		return -EOPNOTSUPP;
 
-	if (udata && udata->inlen < IRDMA_RESIZE_CQ_MIN_REQ_LEN)
-		return -EINVAL;
-
 	if (entries > rf->max_cqe)
 		return -EINVAL;
 
@@ -2089,9 +2088,9 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
 						  ibucontext);
 
-		if (ib_copy_from_udata(&req, udata,
-				       min(sizeof(req), udata->inlen)))
-			return -EINVAL;
+		ret = ib_copy_validate_udata_in(udata, req, user_cq_buffer);
+		if (ret)
+			return ret;
 
 		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
 		iwpbl_buf = irdma_get_pbl((unsigned long)req.user_cq_buffer,
@@ -2265,24 +2264,20 @@ static int irdma_setup_umode_srq(struct irdma_device *iwdev,
 				 struct irdma_srq_init_info *info,
 				 struct ib_udata *udata)
 {
-#define IRDMA_CREATE_SRQ_MIN_REQ_LEN \
-	offsetofend(struct irdma_create_srq_req, user_shadow_area)
 	struct irdma_create_srq_req req = {};
 	struct irdma_ucontext *ucontext;
 	struct irdma_srq_mr *srqmr;
 	struct irdma_pbl *iwpbl;
 	unsigned long flags;
+	int ret;
 
 	iwsrq->user_mode = true;
 	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
 					     ibucontext);
 
-	if (udata->inlen < IRDMA_CREATE_SRQ_MIN_REQ_LEN)
-		return -EINVAL;
-
-	if (ib_copy_from_udata(&req, udata,
-			       min(sizeof(req), udata->inlen)))
-		return -EFAULT;
+	ret = ib_copy_validate_udata_in(udata, req, user_shadow_area);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&ucontext->srq_reg_mem_list_lock, flags);
 	iwpbl = irdma_get_pbl((unsigned long)req.user_srq_buf,
@@ -2487,7 +2482,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
 			   struct uverbs_attr_bundle *attrs)
 {
-#define IRDMA_CREATE_CQ_MIN_REQ_LEN offsetofend(struct irdma_create_cq_req, user_cq_buf)
 #define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -2511,8 +2505,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	if (err_code)
 		return err_code;
 
-	if (udata && (udata->inlen < IRDMA_CREATE_CQ_MIN_REQ_LEN ||
-		      udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN))
+	if (udata && udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
 		return -EINVAL;
 
 	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
@@ -2554,11 +2547,14 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		ucontext =
 			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
 						  ibucontext);
-		if (ib_copy_from_udata(&req, udata,
-				       min(sizeof(req), udata->inlen))) {
-			err_code = -EFAULT;
+		/* Even though the last member of struct irdma_create_cq_req
+		 * was always user_shadow_area, we need backwards compat with
+		 * the legacy i40iw struct i40iw_ucreate_cq which stopped
+		 * at user_cq_buffer.
+		 */
+		err_code = ib_copy_validate_udata_in(udata, req, user_cq_buf);
+		if (err_code)
 			goto cq_free_rsrc;
-		}
 
 		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
 		iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
@@ -3541,7 +3537,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 				       struct ib_dmah *dmah,
 				       struct ib_udata *udata)
 {
-#define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_mem_reg_req req = {};
 	struct ib_umem *region = NULL;
@@ -3554,9 +3549,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
-		return ERR_PTR(-EINVAL);
-
 	region = ib_umem_get_va(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
@@ -3565,9 +3557,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return (struct ib_mr *)region;
 	}
 
-	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
+	err = ib_copy_validate_udata_in(udata, req, sq_pages);
+	if (err) {
 		ib_umem_release(region);
-		return ERR_PTR(-EFAULT);
+		return ERR_PTR(err);
 	}
 
 	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


