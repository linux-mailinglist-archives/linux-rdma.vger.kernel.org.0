Return-Path: <linux-rdma+bounces-22714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ggs3Aq+cRmqOaAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977C6FB2A5
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lOpKeCw7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22714-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22714-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 429D3306293C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18C33A6F2;
	Thu,  2 Jul 2026 17:07:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FC33BBB9
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012034; cv=none; b=B2/KC3hvp02176VNS0SIW0xZ0w6qYY11zd9gphuuv8FjQzVY6vH4CxYKsvRls2Aog5Px3O1mL5xTUrlzeQPeatctHfj3MDWBwtskFIx8EIP42sp6weT7ky+itFmCQk32B1Kn/Q1QUavXGkTXEXNmryKI1n16SmHUDv83XyHV26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012034; c=relaxed/simple;
	bh=kdyxrk+ulNXB12nDgh1gKs99EUgqxFe+dan37mHqS+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CY4qqxDRVKv+LBax0ssA/FpwNODv8STdaYvcftPb44N07Xp6TOOFWAsxivHF5+9eo5Cg5rJnedkEmVaFrwx0PrBn0Lj5xjhdRhR90LAD03Iy0QxM8rrRAOEoPlxFX2119YopWfzvtmpWpIHqJJqRXHeudeyXr2sVC8hwFuhBur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOpKeCw7; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92e56b2b350so373132185a.3
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012032; x=1783616832; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvdGeRxWjuuWPXFiLaePiWqTgGsr/2op6a/iXwxuSDc=;
        b=lOpKeCw7hAy9KtPC1w42VpZnfeN+0AetElVYZBfYbT110bq3ZLMCn4UUsxgbE3vYNy
         Psm80EDs5wMO+STzQR/nF6iDWrDl8ofuWyP32oLi5VsCWCjj+Nqo+u8twaQVjn+2xny/
         rutldksXGxkF39dy3kuXJg5L6uscGASN6ooHq0t4y4ZtMwJ1aWa3nHk/1CKn05nOjn9d
         yXUv6Qi/h/JC5G1XgDEinMbWvIEiNwRMtT73WkGYNcKQABVaonc1NYweYo7dHCnp8NzI
         k0rh5p+AM5hr7FCFOyfGB+vGe1KBChxIXOT4dRY9DuO+lTgCfSZ5IQrLbiOKNBH/3KKv
         6s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012032; x=1783616832;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvdGeRxWjuuWPXFiLaePiWqTgGsr/2op6a/iXwxuSDc=;
        b=OYuoAcd/Jno+gb/ZsY88hh+LI3x8k+3EI6PuCxggJShdb9VjePDwPCcAQJRoWMjwPQ
         QJB+R0RgCV3iHhUhtq1M6szq4J0AkVfzQxE/MPhVvIl2QtJz+eIg6BlLX/m99AYVOD/k
         AS7V5jcUTui/n9WkHey/22hIfi1ut/9laLcPrTC4E5krDxxpynAdWVeAUr+C1nzXOZll
         gJvesHvlXjb0OsHKMLSqTvE6PlmDO3FbHQdAo0roz2wB2fB0qdATjJjMMOMLZWbSTbjO
         l2kRZbTYCUKYRu75PDf/1uD53ud4IRyZpWpzn+8HpX5dBMhzxITZc1f1PfjuEj7vyHGR
         Bi8Q==
X-Gm-Message-State: AOJu0YwgcYV5vNew7J2X1Dp618JSpCg0a6GBC+VsLvs6WOJNSlcwIx2v
	46XWL073sWVv1Fbwdem4YUU3DiPse64wgXsk4XizMEceyUkVC5PfWIgX1sGpvfiqlzS+NUxWzqI
	58NsG7kHVBA==
X-Received: from qkll6.prod.google.com ([2002:a05:620a:2106:b0:92e:5d6f:2e24])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:700e:b0:918:4137:6be
 with SMTP id af79cd13be357-92e7850141fmr1029956085a.53.1783012031119; Thu, 02
 Jul 2026 10:07:11 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:49 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-5-jmoroni@google.com>
Subject: [PATCH rdma-next v3 4/7] RDMA/irdma: Use robust input copy helpers
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
	TAGGED_FROM(0.00)[bounces-22714-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 9977C6FB2A5

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
 drivers/infiniband/hw/irdma/verbs.c | 79 +++++++++++++----------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d5795d4fe7b3..519ac780e9f1 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1300,7 +1300,6 @@ static int irdma_wait_for_suspend(struct irdma_qp *iwqp)
 int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			 int attr_mask, struct ib_udata *udata)
 {
-#define IRDMA_MODIFY_QP_MIN_REQ_LEN offsetofend(struct irdma_modify_qp_req, rq_flush)
 #define IRDMA_MODIFY_QP_MIN_RESP_LEN offsetofend(struct irdma_modify_qp_resp, push_valid)
 	struct irdma_pd *iwpd = to_iwpd(ibqp->pd);
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
@@ -1327,9 +1326,15 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
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
@@ -1572,10 +1577,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
@@ -1665,7 +1666,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		    struct ib_udata *udata)
 {
-#define IRDMA_MODIFY_QP_MIN_REQ_LEN offsetofend(struct irdma_modify_qp_req, rq_flush)
 #define IRDMA_MODIFY_QP_MIN_RESP_LEN offsetofend(struct irdma_modify_qp_resp, push_valid)
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
 	struct irdma_device *iwdev = iwqp->iwdev;
@@ -1687,9 +1687,14 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 
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
@@ -1779,10 +1784,6 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
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
@@ -2074,7 +2075,6 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 			   struct ib_udata *udata)
 {
-#define IRDMA_RESIZE_CQ_MIN_REQ_LEN offsetofend(struct irdma_resize_cq_req, user_cq_buffer)
 	struct irdma_cq *iwcq = to_iwcq(ibcq);
 	struct irdma_sc_dev *dev = iwcq->sc_cq.dev;
 	struct irdma_cqp_request *cqp_request;
@@ -2098,9 +2098,6 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	    IRDMA_FEATURE_CQ_RESIZE))
 		return -EOPNOTSUPP;
 
-	if (udata && udata->inlen < IRDMA_RESIZE_CQ_MIN_REQ_LEN)
-		return -EINVAL;
-
 	if (entries > rf->max_cqe)
 		return -EINVAL;
 
@@ -2134,9 +2131,9 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
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
@@ -2328,24 +2325,20 @@ static int irdma_setup_umode_srq(struct irdma_device *iwdev,
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
@@ -2559,7 +2552,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
 			   struct uverbs_attr_bundle *attrs)
 {
-#define IRDMA_CREATE_CQ_MIN_REQ_LEN offsetofend(struct irdma_create_cq_req, user_cq_buf)
 #define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
@@ -2583,8 +2575,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	if (err_code)
 		return err_code;
 
-	if (udata && (udata->inlen < IRDMA_CREATE_CQ_MIN_REQ_LEN ||
-		      udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN))
+	if (udata && udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN)
 		return -EINVAL;
 
 	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
@@ -2626,11 +2617,14 @@ static int irdma_create_cq(struct ib_cq *ibcq,
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
 		iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
@@ -3614,7 +3608,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 				       struct ib_dmah *dmah,
 				       struct ib_udata *udata)
 {
-#define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_mem_reg_req req = {};
 	struct ib_umem *region = NULL;
@@ -3624,6 +3617,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_copy_validate_udata_in(udata, req, sq_pages);
+	if (err)
+		return ERR_PTR(err);
+
 	err = ib_respond_empty_udata(udata);
 	if (err)
 		return ERR_PTR(err);
@@ -3631,9 +3628,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
-		return ERR_PTR(-EINVAL);
-
 	region = ib_umem_get_va(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
@@ -3642,11 +3636,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return (struct ib_mr *)region;
 	}
 
-	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
-		ib_umem_release(region);
-		return ERR_PTR(-EFAULT);
-	}
-
 	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
 	if (IS_ERR(iwmr)) {
 		ib_umem_release(region);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


