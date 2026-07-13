Return-Path: <linux-rdma+bounces-23155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LpSBMYgdVWqCkAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB6C74DEF8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WTogYdg+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23155-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23155-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF763045A82
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1063446A7;
	Mon, 13 Jul 2026 17:13:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6796224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962795; cv=none; b=QKo6KFtRMbgU3pcNXvglW3pIZOsrtpxF8cB1C7ROBRtC+HEXrKJN1WRTx4M7Or7oIlPB2M8V3ENRgFjtJyn7w2pRjPSAb28LTGjfUi+mvu/JAi4atYW8WGS6BYTfU1w5qwTJwkBv+9eibxM52J0k2wvNWjrEM3acYUL3sUsAvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962795; c=relaxed/simple;
	bh=/AynH1IgEOOw3Fj4yIhJDk4W40R+SwvoiT8GNCd6ypM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mf8+g2tItucxrnnh0tbFlAX1HNUfr5iQnfMhUdYuctk7IyA6uwkrrF3te9Qo470lmHMNgcTQOQdNeV7y7VQCdYExobsBwVVf3iCcKYHg5XSF1D0eyymBmCSx6iVfWYs/eiXUniu2LY2fdXYA8q6ZTvQVImVH6ca52Nv/EJZnBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTogYdg+; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51c1c7f135bso1770211cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962793; x=1784567593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DD005DMu2gcrkTBF375bRlQ0ikpiRHpVKPPTNM5Jnk=;
        b=WTogYdg+AklvG4L7K6Ynfrnor6EfnbXY5GsZ5KZXF0VCe0EmXLG6xOLlZXUv9s6NUw
         Ttj/3p6HOmA7+sdnnnDENql9+KQLT+1jC/7EboqRR+G6LZN23hGl8YnyZmm6zt2NSowC
         pdhpyBnLSWT71zbuHNzpLtuVsmyaHk0YYOf0uhxyZ9yJQfWMHj6j/EUrMnsccsNp7umh
         umbGZR+2+r10+y1NS/AT9LQLcUZI/xIoX8LssERTN9RURCb0EZVSBnC2vTkVzPp+QKlP
         O27lPer/XCaQRa+d2Fy0djGXnBIyou1CtrvnKbebGC0xH1qf8ieyZDsNmJKOmWc3gnH6
         k1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962793; x=1784567593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DD005DMu2gcrkTBF375bRlQ0ikpiRHpVKPPTNM5Jnk=;
        b=VHvlTVjTlS/IaanD8hk7P4FRgtvRDRbqeDx6224kRc5XzdS5UqzkltxrVu2L6ZFpNF
         P2pKe/wRkXT+dPnr174gpBqIkKRwP2k+qkXwJWPbZNXMQnaQBy80SGt4IWHF+Uyt1wod
         sVSfhBWCLy/TjqiLiTpQiI883yvBnOXv5IqwBwq3dopo2aDEoF8nHk4ZCYfPZdcD60g0
         IQQMVK+hTCwQI3lUjBYY3CEsI4tFPDwZC2nTEkV1NQdjgGNEqBCUWX0Pgj+6V7CNrCfU
         QKAWlxsQCaKEGUKBBriyf1hMBD9gUbdSnYmKBSmtv/+TnR/WxCVIcM/tR+FCMDE0EVli
         rOcg==
X-Gm-Message-State: AOJu0Yxfj1ivtIaJvajhWlkHx/+/NEZ1tbD/JneUQzZboarzolIK/epB
	gZOP5pDNBpBL7kIzQCtdm+7kFb2FBTFqX6lrwxDeuvaQ7dNOgsnMc2HY1Q9dRYBa5u0uDIEnodG
	OxmZYzIzSYw==
X-Received: from qtbhx4.prod.google.com ([2002:a05:622a:6684:b0:51c:afcd:4647])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5954:0:b0:517:90d2:598b
 with SMTP id d75a77b69052e-51cbf1b5c96mr97641551cf.39.1783962792359; Mon, 13
 Jul 2026 10:13:12 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:53 +0000
In-Reply-To: <20260713171257.3131493-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713171257.3131493-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-3-jmoroni@google.com>
Subject: [PATCH rdma-next v4 2/6] RDMA/irdma: Clear udata response buffers
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23155-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FB6C74DEF8

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
index db297974214..c002dd6ead4 100644
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
2.55.0.795.g602f6c329a-goog


