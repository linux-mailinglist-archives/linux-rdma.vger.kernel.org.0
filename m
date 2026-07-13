Return-Path: <linux-rdma+bounces-23157-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TZmJJZAdVWqHkAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23157-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:17:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB474DF06
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:17:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cpLvNMl7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23157-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23157-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28273070CD4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254D344D90;
	Mon, 13 Jul 2026 17:13:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F7224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962800; cv=none; b=TvJZHM0CUd09ZSZhTCoSZJoGVvHo+ptfSjZ5dBW9In+kE5ghOh3Xf6tMowxzJUyKzJcVaSjNE61G3yktdpIiczq7fpGsSkgMqtyQSX2OaiCSLy7vxl/1w3GGlqb/7xO1p5/1Th4inppbFcSU0OgYZILzXPNz1lyk8ICxy82iJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962800; c=relaxed/simple;
	bh=55dWlEd7kyIW0bp0Kz0+5T7CeN3PWI7OXt2vrxXRKzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gAE0jobjs9kC/Cy81aHFvR4FtwRbxELZImymjpeoBnI+cT1A+y/79tWKQQNHXe6mCTOl6remH3e9olMd9ABpXG/lOM0bWLE5NQo1FDjoEQevtA5FUhovd0Nm7djlJUguY8G6P7saSbCJTqIyvsI8Bn4A2EupOrsWhgUeoHiO4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpLvNMl7; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ec45d9628aso1669976d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962798; x=1784567598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lIXjOvgXSP56l+t5dTb+2RVPB1am1cUzA+nBmCVsqw=;
        b=cpLvNMl7SBNSB6mvbEBVkAua43xzty6UlXVVON80cjgfaQZrdNEptT231MA6eISF0b
         wJ0RsYLGwSxUjC9oz6jIA5ryUmT3h7Hh3UYi13/Jc6juoQmtD7ZdA9lmQI3RFxOjZigR
         21+SYKLgmzixWsU/YPoRmQ37wrPZ+qLFttgnvMb465fbSI6U0N91Zn999uEpHOCRsNDJ
         QuLA4ltKpAKOPqRRGKdwp7OTHi8D5YhU4vH1LbDejd0LpaksIVRi8i24RJZ9kMgJbwcY
         5toGwFQYZaGxJcDlnhYdKa4t9R2ZPdejjN4QQohnMoUvGo98kUxPD7qNAMNVbgaUN+1u
         dupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962798; x=1784567598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lIXjOvgXSP56l+t5dTb+2RVPB1am1cUzA+nBmCVsqw=;
        b=kJNL5CvMYfAzw6WWC2oQ7Tn2U6LJXDQpzzAJRHr/DEipye8kH1NVbRR9DE8vt4V/Zm
         2eByVH6Q6lQPCCPW5HXlCw1vUQat+tKSsa0GjYusSHAU408RdoTGI9UUgxe6S6OQbJGO
         0R3UKI1eSTKQeBmJ0o7IaJK9xccPXs8cB5sg1R/wosDwjZpXMXi5HsKvV/u9X+kyfAD0
         MwGic5uHhg69J6DvqO7ZZbZidhnnqpXM6TYUtRdEgQCJZ6QvckzULCQt4ka6q3R1B/gu
         tq4menRvxpU7tUjYxiyPCw8gjIzn5bdHC1tOcSolaTLMS5U+kZJiiQSfxDWrSfSr0PHP
         OjLw==
X-Gm-Message-State: AOJu0YxwWgSx3Dla2UMkaAKJeqaMn1A4yAGJbyGHNSzcQWcfxqMfZnjI
	JWBcbZoSie12TnUZTBp/NZSeekwadWBNbH6rzI3FVOil9zjnJUzteq6AKjFa+iULC1dLNoxpywU
	ozzhbP04FzA==
X-Received: from qvbbz12.prod.google.com ([2002:ad4:4c0c:0:b0:907:4735:339d])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:4101:b0:8fd:6dc5:94b
 with SMTP id 6a1803df08f44-90404b0898fmr119173166d6.64.1783962797258; Mon, 13
 Jul 2026 10:13:17 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:55 +0000
In-Reply-To: <20260713171257.3131493-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713171257.3131493-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-5-jmoroni@google.com>
Subject: [PATCH rdma-next v4 4/6] RDMA/irdma: Use robust udata helper for QP creation
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-23157-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18AB474DF06

Replace the manual udata input copy and validation during
QP creation with the robust helper.

The irdma driver is backwards compatible with the legacy
i40iw userspace provider. The current create_qp ABI contains
two 8 byte fields. The legacy i40iw ABI was the same but
also contained two additional fields which were never actually
used. Furthermore, the i40iw userspace provider never explicitly
zero-initialized those extra fields, so there is a chance that
existing binaries are passing non-zero garbage values down
to the kernel.

Previously, the irdma driver only copied out the first 16
bytes and did not have any check for the rest of the buffer
being zero, so that additional garbage didn't matter.

By switching to ib_copy_validate_udata_in(), we will now be
checking to ensure that data beyond the kernel's definition
of the request is all zero.

In order to avoid breaking legacy binaries, we therefore need
to increase the request structure size to cover those garbage
fields.

- Legacy binaries will continue to pass down a 32 byte request,
  with the driver copying the entire 32 bytes out but ignoring
  the second 16 bytes, just as before.

- Newer binaries will pass down the normal 16 byte request. The
  ib_copy_validate_udata_in() call will allow this to succeed
  because we use user_compl_ctx as our minimum length (16 bytes).

- If the request is ever extended, the new fields would be
  added after the "don't use" fields and would work as per
  the normal uAPI mechanism.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 41 ++++++++++++++++-------------
 include/uapi/rdma/irdma-abi.h       |  1 +
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c236cec5302..f74e5ca89e1 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -632,37 +632,29 @@ static void irdma_setup_virt_qp(struct irdma_device *iwdev,
 
 /**
  * irdma_setup_umode_qp - setup sq and rq size in user mode qp
- * @udata: udata
+ * @ucontext: user context
+ * @req: user request pointer
  * @iwdev: iwarp device
  * @iwqp: qp ptr (user or kernel)
  * @info: initialize info to return
  * @init_attr: Initial QP create attributes
  */
-static int irdma_setup_umode_qp(struct ib_udata *udata,
+static int irdma_setup_umode_qp(struct irdma_ucontext *ucontext,
+				struct irdma_create_qp_req *req,
 				struct irdma_device *iwdev,
 				struct irdma_qp *iwqp,
 				struct irdma_qp_init_info *info,
 				struct ib_qp_init_attr *init_attr)
 {
-	struct irdma_ucontext *ucontext = rdma_udata_to_drv_context(udata,
-				struct irdma_ucontext, ibucontext);
 	struct irdma_qp_uk_init_info *ukinfo = &info->qp_uk_init_info;
-	struct irdma_create_qp_req req;
 	unsigned long flags;
 	int ret;
 
-	ret = ib_copy_from_udata(&req, udata,
-				 min(sizeof(req), udata->inlen));
-	if (ret) {
-		ibdev_dbg(&iwdev->ibdev, "VERBS: ib_copy_from_data fail\n");
-		return ret;
-	}
-
-	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
+	iwqp->ctx_info.qp_compl_ctx = req->user_compl_ctx;
 	iwqp->user_mode = 1;
 
 	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-	iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
+	iwqp->iwpbl = irdma_get_pbl((unsigned long)req->user_wqe_bufs,
 				    &ucontext->qp_reg_mem_list);
 	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
 
@@ -989,6 +981,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	struct irdma_uk_attrs *uk_attrs = &dev->hw_attrs.uk_attrs;
 	struct irdma_qp_init_info init_info = {};
 	struct irdma_qp_host_ctx_info *ctx_info;
+	struct irdma_create_qp_req ureq = {};
 	struct irdma_srq *iwsrq;
 	bool srq_valid = false;
 	u32 srq_id = 0;
@@ -1006,9 +999,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	if (err_code)
 		return err_code;
 
-	if (udata && (udata->inlen < IRDMA_CREATE_QP_MIN_REQ_LEN ||
-		      udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN))
-		return -EINVAL;
+	if (udata) {
+		if (udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN)
+			return -EINVAL;
+
+		err_code = ib_copy_validate_udata_in(udata, ureq, user_compl_ctx);
+		if (err_code)
+			return err_code;
+	}
 
 	init_info.vsi = &iwdev->vsi;
 	init_info.qp_uk_init_info.uk_attrs = uk_attrs;
@@ -1067,9 +1065,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	init_waitqueue_head(&iwqp->mod_qp_waitq);
 
 	if (udata) {
+		struct irdma_ucontext *ucontext =
+			rdma_udata_to_drv_context(udata,
+						  struct irdma_ucontext,
+						  ibucontext);
+
 		init_info.qp_uk_init_info.abi_ver = iwpd->sc_pd.abi_ver;
-		err_code = irdma_setup_umode_qp(udata, iwdev, iwqp, &init_info,
-						init_attr);
+		err_code = irdma_setup_umode_qp(ucontext, &ureq, iwdev, iwqp,
+						&init_info, init_attr);
 	} else {
 		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index 36f20802bcc..38155affc8b 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -88,6 +88,7 @@ struct irdma_create_srq_resp {
 struct irdma_create_qp_req {
 	__aligned_u64 user_wqe_bufs;
 	__aligned_u64 user_compl_ctx;
+	__aligned_u64 legacy_dontuse[2];
 };
 
 struct irdma_mem_reg_req {
-- 
2.55.0.795.g602f6c329a-goog


