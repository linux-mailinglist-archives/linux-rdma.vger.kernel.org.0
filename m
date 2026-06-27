Return-Path: <linux-rdma+bounces-22504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WTiALQA8P2qDQAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED836D0CF4
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=PsIOipB6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22504-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22504-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF7FC3028108
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916C331EAC;
	Sat, 27 Jun 2026 02:57:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B61419A4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 02:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529022; cv=none; b=Kn6mqZsM+lQ6LsTVgAFw6EcHl48btZw3BDjizC3n0gCrFjl7MnvDFZHjKiVLzzkn/iCenUUtEiKsJJ6WiVAJUfuFy6mFXIcRB/5zm5islN/dszBwjXOWQO6O1mpGRgge/bFmyn5Pm2R5NiwnjFH7pDnjIcbUGMvLBfIGj/pX4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529022; c=relaxed/simple;
	bh=0rO4Ah73ZRwzyZD4DgBSyL9b9VYP50ujX3Odkk6LThs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=peN3rGIr0ACPOZzlmva+IWrRCCwhwtMDPsccZQN0H3QehH/Y59PrkvrDdML1cs3zkRn3QFnjCWym69qlKHCRosgP0ZATLHfnV7yxbc92plo69SFqhQ0TxMGeCa9kEQkcxZaZAMaEWvmKUMOsYsuRA53rMmJ8po3WKjWMuyJAfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsIOipB6; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6647bc8fa18so2499132d50.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782529020; x=1783133820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VisgpESuvwFwPvA1/UcqYzYv2MNl4l+FqjCmhCY/qvw=;
        b=PsIOipB6oS5hic/slE4mnKCejZtI4z9fAyQTpKsZkyItmJPCU4p3CUDLngYIHW6uB+
         WgaTftsCkNHOaCY4Yk6EXczJEBWoV+S4nCVjtiwoFqGjx+IpagsL2lopPIAkzwmG2+ju
         SZ17nSR+36pdZ8kBq+y2vMg1asU4I7yQInZLiyi+Eewz+IpN77AGcXmPXAumBaHOqDp0
         wGDJzvCizOLHbeDr6C5aWRZWinbc7BZapHTVDpK9MbSYSazkbVdq3V5KWGzHoX+cqAX9
         lCKbafQic+i2bDs8qJRrZniTugfKE3LaB3Gywp9qQ0xzv94XD8wvjWWKCIAxLhv4ZB1K
         +TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529020; x=1783133820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VisgpESuvwFwPvA1/UcqYzYv2MNl4l+FqjCmhCY/qvw=;
        b=WmjJ2RgKHC02LoXdTlqQZCPgg3x22zJsvt4q5h8vtvJck2gr6nX81g5YOPWIf+zO20
         1maQ9CbFLxVGoikJBEM/IUzQYxcVUvPEtaS5fXMxgsR9f0A4X6gY+LY3bikTYJBSlfWi
         sZqLpBUjhsshKYBRKggnDmlnf3au+wUMxfTyCw5mFY2jRkFat56ZQZB6ARlpRgrcls8F
         E1IobXnruRC72fPfTXijD8i52lu5cjSIzdrYhqwsUI54gFjpQmIZsq4f2YSK7UjcRaKZ
         bjIe2GPebnanCCFVxn8m206bDB4Ek4A8HuZxHusfQy7vL/yj+M+PyKs9RoyhCUfFZ8f5
         GlVA==
X-Gm-Message-State: AOJu0YzT6aarr07pi5KGZnZsQ7c3LmdmywaiXiVbaHTWwsIVrNWasF8O
	fy1Du3W0m+aLo6sbLFSMNQBjUxhOXj6ZmObbi8bH8/GycN0CdbzAyOdkcAEKbXj7SHFqVxXbBU2
	zpEPlwcgI4g==
X-Received: from yxss1.prod.google.com ([2002:a05:690e:2581:b0:660:430f:556])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:11c1:b0:664:8df9:103
 with SMTP id 956f58d0204a3-6648df904ebmr7095029d50.38.1782529019802; Fri, 26
 Jun 2026 19:56:59 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:56:41 +0000
In-Reply-To: <20260627025642.4064973-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260627025642.4064973-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260627025642.4064973-5-jmoroni@google.com>
Subject: [PATCH rdma-next 4/5] RDMA/irdma: Use robust udata helper for QP creation
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22504-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ED836D0CF4

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
 drivers/infiniband/hw/irdma/verbs.c | 11 +++--------
 include/uapi/rdma/irdma-abi.h       |  1 +
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d06df520d9be..f07c11a0569b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -638,12 +638,9 @@ static int irdma_setup_umode_qp(struct ib_udata *udata,
 	unsigned long flags;
 	int ret;
 
-	ret = ib_copy_from_udata(&req, udata,
-				 min(sizeof(req), udata->inlen));
-	if (ret) {
-		ibdev_dbg(&iwdev->ibdev, "VERBS: ib_copy_from_data fail\n");
+	ret = ib_copy_validate_udata_in(udata, req, user_compl_ctx);
+	if (ret)
 		return ret;
-	}
 
 	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
 	iwqp->user_mode = 1;
@@ -962,7 +959,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 			   struct ib_qp_init_attr *init_attr,
 			   struct ib_udata *udata)
 {
-#define IRDMA_CREATE_QP_MIN_REQ_LEN offsetofend(struct irdma_create_qp_req, user_compl_ctx)
 #define IRDMA_CREATE_QP_MIN_RESP_LEN offsetofend(struct irdma_create_qp_resp, rsvd)
 	struct ib_pd *ibpd = ibqp->pd;
 	struct irdma_pd *iwpd = to_iwpd(ibpd);
@@ -994,8 +990,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	if (err_code)
 		return err_code;
 
-	if (udata && (udata->inlen < IRDMA_CREATE_QP_MIN_REQ_LEN ||
-		      udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN))
+	if (udata && udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN)
 		return -EINVAL;
 
 	init_info.vsi = &iwdev->vsi;
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


