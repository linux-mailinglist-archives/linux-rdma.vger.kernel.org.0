Return-Path: <linux-rdma+bounces-22502-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oFxqGf87P2qCQAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22502-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360F6D0CF1
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nf0NPrmy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22502-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22502-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B648A300680E
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 02:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BF3314B9;
	Sat, 27 Jun 2026 02:56:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBD1419A4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 02:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529017; cv=none; b=biHAjvLif+LMufx5w6mW86pwnLAJa+3Edo0mDUXP9rkVWJAWiOFXoAA1fQktVy7E+b8YB74T6TW2UUNf7qWwDwJkxeaV6Q+zaPGhr2X0dpCJMrlcoxkoYLFi7h0ortsPHTUTq8PG4FPpxLR32QFpmdHIMm+JP6ilvqzBxZvKR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529017; c=relaxed/simple;
	bh=Mce6kv7K6WihY0I5BfOMQnkbV97xakMYTBQp5rUtbN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDlahxZ0FQSrzmDStKZFuW/H3KfZ7OJMre9lFz/4M+PNJqDt35XWVDvVTY8WBdOcE0DvgP/TGRzI/IbcznGolYc1MIL8lTchcDYqtXZ3KbDtuGzyEKxqsLY4xQT6zfC1FFNxw4cZ8IyV/DDO3TNsAoAIM97o6qXmoRdz08eprPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf0NPrmy; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517e054fe07so42258371cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782529015; x=1783133815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVJXnFDRBWMacbDUR9CFwrSNI3vmRc9ozREnnPUjNP0=;
        b=nf0NPrmyUVzVv8XDX1rws26ILt0PnuvF0Z1MBX+eE2WEbkfWrsXopRehZNc/GJJuG9
         ttEYbkDJtq2gMtkLCRpA2dq2yrAVOAEk7JWFZ/1HQGcuQwWcqejMJe24KiGP5EdlbQ14
         pxKNfEMFBO9zSL3Wxqn9SWkZnnkdT/Q08zxL35pQDPPUB7x0pfsa7X+GV54Uoa6Q+x6M
         YKy4J6SOUqKDePDKz/0UospXrGKTOpH75Fg6wY6E8ghMS4u5Tgs4Cen54Sz26YCLFzCB
         kYIulO/fM9AnsxZ35Ml7kJfnTPdydj/WOp2D8eg/L/Y8IwUNkzSk6hT1cIj1DQc/8/bV
         7aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529015; x=1783133815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVJXnFDRBWMacbDUR9CFwrSNI3vmRc9ozREnnPUjNP0=;
        b=jNfQNQKQPbulvf8XsiJtCQk37l3T+oS3InKOOnKSzwN96upj6yvSPKviQY+FHKZVgi
         /Itth2b9B2ugzG+RuZnJJTnKQM3Whw0gr2I+EB4bcj3wg007qdN0huc+1lq1idwahhmz
         0k++sQDNZyGMHnM15ZDRvVgxKRpmDmdlUymsVmAyQSxMiuVpq2Bc0Mm86++zcCTMcJ10
         CCwJEfTD1/qpWisl4a6VDTVncZNN2Tytpap8oZt5IgBkgc6wnz88Ncusf5+fXfVFUTEv
         Mhzle3fKyC7ryYu48ZdtnRqxYCBBRgW1PKbZTOU1SgJhRXgKGEiExQ3j1zyItd/QFNvA
         xELg==
X-Gm-Message-State: AOJu0Yy2toBJl6tUG/GCYyH5qxz6HmMEWW2sMC7GEQu/Z50GAs3CYLfo
	mGGQYMMHvkjGTbbdrBZ/c4kA5hsmal75TIewiwbuW6nCvP9EtKfnMPJIPWhniW0JfwPiiR1k/w5
	nk6laxfbUTA==
X-Received: from qtz4.prod.google.com ([2002:ac8:5944:0:b0:517:697f:f2b2])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5a0f:0:b0:517:6b31:804a
 with SMTP id d75a77b69052e-51a727a03famr136422221cf.29.1782529014831; Fri, 26
 Jun 2026 19:56:54 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:56:39 +0000
In-Reply-To: <20260627025642.4064973-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260627025642.4064973-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260627025642.4064973-3-jmoroni@google.com>
Subject: [PATCH rdma-next 2/5] RDMA/irdma: Use robust udata input copy helpers
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-22502-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6360F6D0CF1

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
 drivers/infiniband/hw/irdma/verbs.c | 61 +++++++++++++----------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e1c894fba2af..19dcc475c355 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1554,10 +1554,13 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
+				/* legacy i40iw does not send any udata. For
+				 * current irdma, validate against ABI def.
+				 */
 				if (udata && udata->inlen) {
-					if (ib_copy_from_udata(&ureq, udata,
-					    min(sizeof(ureq), udata->inlen)))
-						return -EINVAL;
+					ret = ib_copy_validate_udata_in(udata, ureq, rsvd);
+					if (ret)
+						return ret;
 
 					irdma_flush_wqes(iwqp,
 					    (ureq.sq_flush ? IRDMA_FLUSH_SQ : 0) |
@@ -1758,9 +1761,9 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
-					if (ib_copy_from_udata(&ureq, udata,
-					    min(sizeof(ureq), udata->inlen)))
-						return -EINVAL;
+					err = ib_copy_validate_udata_in(udata, ureq, rsvd);
+					if (err)
+						return err;
 
 					irdma_flush_wqes(iwqp,
 					    (ureq.sq_flush ? IRDMA_FLUSH_SQ : 0) |
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


