Return-Path: <linux-rdma+bounces-22713-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Udk1NLioRmrLbAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22713-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F26FBD89
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=EW2nBsk3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22713-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22713-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40AFF3294281
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD833689F;
	Thu,  2 Jul 2026 17:07:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD842FC893
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012030; cv=none; b=j+Zh6z5i+n/W0gmjMnJewUB02gv90mIgaqwqoYaRnNs/R0vJf7LkwEHFCxG2CgrFXbiYZffAxzBEf/z5FvLsRgM+weA0mo+OaZB2v3K5VE9XBrj7iT+94H40cfXwaLYUg8HtkhcgZFQCM0KRUsp3FyIspXc9zGcBy1xGiqres4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012030; c=relaxed/simple;
	bh=rc2BtaROwwQEGblNi8phTU+BXEZ4q+LkzQTEo/HYTi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXpZwHblhVXi1AXeBBqZ8HLrtc7u0xO3y00xdenu89jI1uLaG+CyQQ4B1ZWl84wkbx7rzEhYRQcc0wHcJu+Lm6tsGNT6m6JYl+Vyg5F7D9L6H8zdpyXLLJzy8UKinF/Ea0oipe37YQzvVjwISFXtH4VHYoLKek1S5Em7PdJ/C6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EW2nBsk3; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8e3ae05d649so30540626d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012028; x=1783616828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd6cbnIf0GmwOdBAFyJjr36VrBNw4VQ9nYy5aXbe6Ag=;
        b=EW2nBsk3e1N1VRbcq0FLu8b7zZ2sKV67MZna7OP9J8fDhapjhOBao1uQDmq3A+eJXL
         AGYhriQRTjhaM+wsX71fTXYKUd4DmyBTT6B/9g094Bnpu8C6i/oZa83omLm4GFiKNG0J
         leW/4Pb+1HWKb/0y/uKi/PXwEdK2V7GkcEYJaF0zYQ2renGH4z+ElYzUbOYBGZh8+0g8
         8aVEWsv8hJEcwJLmv8MK+YNl1yy4sEXHt+a6pD7ErUwRAMxYf4SyouElTJy1qEi4nFCI
         6WXWsvv5YLt0qiL/CL7keVr2oPwxRzRyH4mu4L3SpuzcmlQ3NnsZyufN99OmOlDgCXEQ
         qU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012028; x=1783616828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd6cbnIf0GmwOdBAFyJjr36VrBNw4VQ9nYy5aXbe6Ag=;
        b=fqLFi7XK+Md3sbrikNznpKas82Wbnk/c0tPD1Xy7HMBY8EL7EezGCVOVLR9ug0nV+j
         ssDdevG6B170cUwDjlgGnw93LhjjiX0DU9NQgnzb0qMXE4yozDGVIqDeLkBxezBgxozR
         mijmap1CptI1qKOBuUWpHxTcdjnvMMpfvqYDCkUPy1niBtcH0te1yT43Tzp8qjsHZT7P
         Ae7kYSLiSZN71EfTVhmDSxewwPyiUmQjPSSLM0TepMSuuXYXJ5hjGod5hLrZ3LSdL+Ym
         NYaEuaoY48/Pf6wxz/Q7ph+FPpNG1BFAE+sZU5AS4jgf6fS2tYh6/jF4gzMKh4+azs6o
         DBxQ==
X-Gm-Message-State: AOJu0YwwmB+BfLEMSgcrGna4IOA37TFHSVf4grS5k8ThDZNq6bfp84k1
	GsMtIwVXPMqXpbdXaAmdUPsInYp1lJPbiSsyRkwAUsU6BpfHP8L5srYlN5sIlfS2lop/CK3DGQQ
	sM5cHqPA4Yw==
X-Received: from qval5-n1.prod.google.com ([2002:a05:6214:8385:10b0:8dc:9073:dce4])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ad4:5c6e:0:b0:8ae:5fcc:8069
 with SMTP id 6a1803df08f44-8f3c70bbc8dmr100531216d6.22.1783012027893; Thu, 02
 Jul 2026 10:07:07 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:48 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-4-jmoroni@google.com>
Subject: [PATCH rdma-next v3 3/7] RDMA/irdma: Clear udata response buffers
 where necessary
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22713-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D3F26FBD89

Methods that may accept udata input but do not provide a
udata response should use the ib_respond_empty_udata()
helper to ensure that user response buffers are cleared.

Since the ib_respond_empty_udata() call itself can fail if
the user intentionally provides a bogus output buffer, it is
called at the beginning of the method to fail early before
mutating any state that would be difficult to unwind.

Additionally, add missing bounds validation for udata->outlen
in irdma_create_srq() to ensure it is large enough to hold the
response struct as per its original (and so far, only) definition.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index be964f777e64..d5795d4fe7b3 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1316,6 +1316,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	u8 issue_modify_qp = 0;
 	int ret = 0;
 
+	/* Clear the response buffer (if any). It may be updated again later. */
+	ret = ib_respond_empty_udata(udata);
+	if (ret)
+		return ret;
+
 	ctx_info = &iwqp->ctx_info;
 	roce_info = &iwqp->roce_info;
 	udp_info = &iwqp->udp_info;
@@ -1676,6 +1681,10 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 	int err;
 	unsigned long flags;
 
+	err = ib_respond_empty_udata(udata);
+	if (err)
+		return err;
+
 	if (udata) {
 		/* udata inlen/outlen can be 0 when supporting legacy libi40iw */
 		if ((udata->inlen && udata->inlen < IRDMA_MODIFY_QP_MIN_REQ_LEN) ||
@@ -2095,6 +2104,10 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (entries > rf->max_cqe)
 		return -EINVAL;
 
+	ret = ib_respond_empty_udata(udata);
+	if (ret)
+		return ret;
+
 	if (!iwcq->user_mode) {
 		entries += 2;
 
@@ -2395,6 +2408,7 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 			    struct ib_srq_init_attr *initattrs,
 			    struct ib_udata *udata)
 {
+#define IRDMA_CREATE_SRQ_MIN_RESP_LEN offsetofend(struct irdma_create_srq_resp, srq_size)
 	struct irdma_device *iwdev = to_iwdev(ibsrq->device);
 	struct ib_srq_attr *attr = &initattrs->attr;
 	struct irdma_pd *iwpd = to_iwpd(ibsrq->pd);
@@ -2415,6 +2429,9 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 	if (initattrs->srq_type != IB_SRQT_BASIC)
 		return -EOPNOTSUPP;
 
+	if (udata && udata->outlen < IRDMA_CREATE_SRQ_MIN_RESP_LEN)
+		return -EINVAL;
+
 	if (!(uk_attrs->feature_flags & IRDMA_FEATURE_SRQ) ||
 	    attr->max_sge > uk_attrs->max_hw_wq_frags)
 		return -EINVAL;
@@ -3607,6 +3624,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_respond_empty_udata(udata);
+	if (err)
+		return ERR_PTR(err);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


