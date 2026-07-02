Return-Path: <linux-rdma+bounces-22715-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 932mCm2oRmqYbAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22715-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:05:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0A6FBD47
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=N6xBQ9+A;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22715-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22715-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03EDC33DCB5F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A720933D6FC;
	Thu,  2 Jul 2026 17:07:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A933BBCD
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012037; cv=none; b=LqZsLl7HJsE47PevxjRK88/v6AQTod6UP4yQ2vLQLTSXYMEROVwKPlTPXRxPwGT5VbCtkCEaUYgi60w0EgKGfjxKpna8JKU4WgcGdHEj78nDje/QRSOLUfprDA77eLCYyS5ibsSe4WZnVTPI1Mtb+fUPFx7X9jyr22R/TWa/hlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012037; c=relaxed/simple;
	bh=S/LRgotf8KJ49JdukdW0ZcLuC7wReK3iHRpZ4/lBsf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOg/RtBcBofn2oBkO5XqiyizeQI1RTK9XS0QqmqjoUkqaRE8wTRTHR/HV65C2oCewflBhCzbq8dpzMmooEJpgGncr1KIDMSjb4aWnwQKVeY8szKxJVHQStEJpshxIwfwkLwyskbRFwwaocel84rsApnFmK8LGIY/lEg/Apb68gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6xBQ9+A; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92e8004d60eso173008585a.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012035; x=1783616835; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aj8ji38bIwicu9xGcRTJhulBCw6fYZxLmAMUww+aCkQ=;
        b=N6xBQ9+A3Ln0CGZBM/mOL7Jvz+sBHcJxIVOJQ29IllX0Y39xKaMhR3dBx0cRS2nhsr
         creUQ/bo+oMdbpX6CTDZe7C4ru1sBEoq+4CHbNrFWM2QQZT9kVKHGkdjfyejg9+S2/QX
         KJFiNIvtmnC6h5Hhro29yCsIhbcvLu+aQ9rs9Ctc/ZR3Vw1fYOwr6LJqr7t5rZS/fce4
         jAtifi4S6/RzIAsKRgcMVQJvQCrIXson5uH8K53qrTzxJDY+axiq10EgfqIJ7uMvJ6/D
         kF3RCVXg3VdAD7EiW/4O/m6lsoJ5ovpXViWnYk+i0zhzE6joKau1MO+6K1++KsHM3K5T
         kMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012035; x=1783616835;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aj8ji38bIwicu9xGcRTJhulBCw6fYZxLmAMUww+aCkQ=;
        b=eJmEVxbHQ0sE1iio4OLrlN/D9PZRopMYw0Ae1zG+vkGY8zL1pS74bHFNsGrdRbWxmk
         OK+CHzaaaaMuv86lqHRe//hHGafRh8AHOzCh5jfbtlRz8hAKFTH667oJvlcheeCP2WOE
         CoTteoD9XvtqMISwH5wlYTZLgG24kNYtZmWD6w4DiZQh2EeOuviLFcRKSMJARK36j4ct
         AJRgIRa6MS6LEUD2DAMowC6kWYc620e/feN2FQOZ1NaoyxrbdTZK1X/MVOgmNixhpG/q
         YjjMDO+i6eDCKq50PykeE7s8+/ULq8NMnyaYcbVwS6ch+bfyWawQ18qP1ze+V6IcL8Zw
         0s0A==
X-Gm-Message-State: AOJu0YzVLMx9vX+Khzu5gsQRR/GMNZ2GUrJvesuXwiM4kFbXF97DIOF9
	yqhDd3iQul6FOBY7Oxb4pUIOlis3L6CRSv0YnQM5HIZ2I3qO39+pvMlRvCZhPfi+jog90hlGuHu
	cOBL9Ra2snA==
X-Received: from qkgn22.prod.google.com ([2002:ae9:c316:0:b0:92e:6612:f04b])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:3728:b0:92e:7733:e39c
 with SMTP id af79cd13be357-92e7b41a4e0mr881186485a.68.1783012034450; Thu, 02
 Jul 2026 10:07:14 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:50 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-6-jmoroni@google.com>
Subject: [PATCH rdma-next v3 5/7] RDMA/irdma: Use robust udata helper for QP creation
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
	TAGGED_FROM(0.00)[bounces-22715-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63C0A6FBD47

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
index 519ac780e9f1..00a648922c7b 100644
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
index 36f20802bcc8..38155affc8b4 100644
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
2.55.0.rc0.799.gd6f94ed593-goog


