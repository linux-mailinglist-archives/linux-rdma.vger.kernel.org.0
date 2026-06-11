Return-Path: <linux-rdma+bounces-22119-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ftCoKx/RKmrgxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22119-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB97672FD1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=GbEKoiXx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22119-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22119-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE23930D0F2D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92BF3F7AB4;
	Thu, 11 Jun 2026 15:12:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1A3EB10D
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190768; cv=none; b=OR3ab1vPyV3R/+IgQubL3cvhlkG2AzIjNZNja2la2jcClqyY1wWIDYVJV6Uu36iUYXbjsjFd7SllGibL8u21opeujvCJsbhqHpueT9sXtVnFq9lFvhTukV3YKIBnq1azSE+NV8busaeKai9Rrs7JZmbOenJT2WbJ89aM/lbiSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190768; c=relaxed/simple;
	bh=wGCHT8I1oMNulNK1H2b3Zwuzmv811gDjZuWEexx44mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk1yngBCK7AlFP7y4vf3fuVCo1mcOJoThaUQV+rRcA1C37qf3KeoQa+0eKv0FybgaIG2xwLhnbZCVSR67HA914sx89Jfq4JPOMksb1AOLNQGP2R/mwqm2bJnY6TY5w2AXrOoL6meiW4r183gdnYSaeZ/47gra2ZCrCtVWSvyylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GbEKoiXx; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b9318997so59894605e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190766; x=1781795566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY5eNXl6hmwBkA54xdPpPAlYXJxo56wU/UlORCHwyIM=;
        b=GbEKoiXxCpWrvBrG//b99TgzYQoDm6pBZLO3WliQGniA95LjwcHABOt1e2bdthyOtF
         raoIVJ7vUGTQFBfqy/pjprMD+wRlvIHjY/yPZWljbfNQxR/VPmERS5New9RfvtI002f5
         gk4IPKTO+6+8DBCVJwX4EAvXi4tY+QKOVbeR+3z1xy9/Zlsqzoek4TwG09MKAHs91AxY
         /tdQPeun5zUwZzavtJylfNnhTmIfOpe7G6c1AfxDeXvENGaJE8Xeq2oYHCaQDYd8PWn1
         JRLWPSLZc6v4ntwO80QLh6tnRLHm7TIAEtA+4316CGoDNZUAeNM8xcJJzas4vj8e8SCq
         yEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190766; x=1781795566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fY5eNXl6hmwBkA54xdPpPAlYXJxo56wU/UlORCHwyIM=;
        b=fUipgDc3nKnZIs8DyIIzTWG/8C7p3nQ9wuY2M/VqXVjPTA5pSREm9yBSTae2C9+JBQ
         BVCBPXu5lqpZUXk2Ir0HoqAskpgKT+t1tWyNxkMdd5mhVSpiplRrnLfcdjhqevNAqhZY
         +zT/wBuOGxGSF5txbzO26nQ40OgYAmDqhsNwGJT92n025lKTDtI5m4ZPSNqiScNRUSCS
         A4LLOUX4fMmMse858ib+sb8pUfbv2NLzc9LUxnpklKh2CscGjjB/HwY5k6KEsL626VR+
         vIAjjTsNnkj5ch0yBykc32GBH3NL9/ZP89/t9hKV1hi6wF6e5L6k4YGjuy8EkC+s8j9o
         qr8w==
X-Gm-Message-State: AOJu0YwUOoHAuzA+4nye2QINMB9m/IMmwye/whIPTnbFWtKU1DmR8LMH
	wm+jNJRTGEN5Hyt02rDyFbf8wIWLK5oFymlqieCnI/g+uRbWQbcjhkg9xDX7DAqBVMxlc/Civ+h
	VtAGGt3fKFg==
X-Gm-Gg: Acq92OGhXu4jfEhJp9XdOKZl8OMJAf1cIkIy6J54Hqq90Y2D2tsuRMhbK/UzvSZXdTT
	x4oMU7h829Oj1kkuH6payccb8200S+PNkllfn7u5uMlJqQstM+BqFWSPs+N2tnkkFXbLY9DA6ta
	ol0/BJFxApvFXAsHSi5Jd1aDIE0ro+Hi7ehiQa/cLpfAtulynI0vJzhNC5Jnagw/rRGY9nI0e2+
	YP14+Xi06o87HtPUfvuZ1+XodZF5cRzak5fCd2w6fJY9oqZGkx25QJ49zAQJYmkRX32N00WfR5T
	sviQOFFvXx6XUnsWaGhOZw9gMdwVrpgy8ncYZML+HostQbJTm01qZEMVBy0DzLRWw0C1sWzE9sA
	3s2fggsdbQFOqYjS9tNoEJTgu3KJADXISATgrP+vqB8dUbvDEN+qa+r4XTYcsrJrDFaUWKoXD2W
	fO0xWmWERi1A/eFaONQ+LlU2oklyDXWMrmoPona7D7cQc=
X-Received: by 2002:a05:600c:a215:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-490e5610170mr28533735e9.22.1781190765647;
        Thu, 11 Jun 2026 08:12:45 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52b361bsm51436485e9.7.2026.06.11.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:45 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 4/6] RDMA/uverbs: Add ioctl method for CQ resize
Date: Thu, 11 Jun 2026 17:12:27 +0200
Message-ID: <20260611151229.879514-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611151229.879514-1-jiri@resnulli.us>
References: <20260611151229.879514-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22119-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CB97672FD1

From: Jiri Pirko <jiri@nvidia.com>

Resize CQ is currently only reachable through the legacy write()
uverbs command (IB_USER_VERBS_CMD_RESIZE_CQ). Add an equivalent modern
ioctl method, UVERBS_METHOD_CQ_RESIZE, on the CQ object so the
operation is available through the ioctl interface and can carry
per-attribute extensions. The handler mirrors the legacy command: it
looks up the CQ, calls resize_user_cq() and returns the new cqe count.
The legacy write path is left in place for ABI compatibility.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 46 ++++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  7 +++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 148cdd180dab..43530e55f128 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -228,11 +228,55 @@ DECLARE_UVERBS_NAMED_METHOD(
 			    UVERBS_ATTR_TYPE(struct ib_uverbs_destroy_cq_resp),
 			    UA_MANDATORY));
 
+static int UVERBS_HANDLER(UVERBS_METHOD_CQ_RESIZE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_cq *cq =
+		uverbs_attr_get_obj(attrs, UVERBS_ATTR_RESIZE_CQ_HANDLE);
+	u32 cqe;
+	int ret;
+
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
+
+	if (!cq->device->ops.resize_user_cq)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_copy_from(&cqe, attrs, UVERBS_ATTR_RESIZE_CQ_CQE);
+	if (ret)
+		return ret;
+
+	if (!cqe)
+		return -EINVAL;
+
+	ret = cq->device->ops.resize_user_cq(cq, cqe, &attrs->driver_udata);
+	if (ret)
+		return ret;
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_RESIZE_CQ_RESP_CQE,
+			      &cq->cqe, sizeof(cq->cqe));
+}
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_CQ_RESIZE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_RESIZE_CQ_HANDLE,
+			UVERBS_OBJECT_CQ,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_RESIZE_CQ_CQE,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_RESIZE_CQ_RESP_CQE,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_UHW());
+
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_CQ,
 	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_ucq_object), uverbs_free_cq),
 	&UVERBS_METHOD(UVERBS_METHOD_CQ_CREATE),
-	&UVERBS_METHOD(UVERBS_METHOD_CQ_DESTROY)
+	&UVERBS_METHOD(UVERBS_METHOD_CQ_DESTROY),
+	&UVERBS_METHOD(UVERBS_METHOD_CQ_RESIZE)
 );
 
 const struct uapi_definition uverbs_def_obj_cq[] = {
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 1fef1e86b302..5d2451a03a83 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -125,6 +125,12 @@ enum uverbs_attrs_destroy_cq_cmd_attr_ids {
 	UVERBS_ATTR_DESTROY_CQ_RESP,
 };
 
+enum uverbs_attrs_resize_cq_cmd_attr_ids {
+	UVERBS_ATTR_RESIZE_CQ_HANDLE,
+	UVERBS_ATTR_RESIZE_CQ_CQE,
+	UVERBS_ATTR_RESIZE_CQ_RESP_CQE,
+};
+
 enum uverbs_attrs_create_flow_action_esp {
 	UVERBS_ATTR_CREATE_FLOW_ACTION_ESP_HANDLE,
 	UVERBS_ATTR_FLOW_ACTION_ESP_ATTRS,
@@ -205,6 +211,7 @@ enum uverbs_methods_srq {
 enum uverbs_methods_cq {
 	UVERBS_METHOD_CQ_CREATE,
 	UVERBS_METHOD_CQ_DESTROY,
+	UVERBS_METHOD_CQ_RESIZE,
 };
 
 enum uverbs_attrs_create_wq_cmd_attr_ids {
-- 
2.54.0


