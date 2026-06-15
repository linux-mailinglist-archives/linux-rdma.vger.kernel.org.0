Return-Path: <linux-rdma+bounces-22227-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4NVOKy9L2pSFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22227-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:54:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 436ED684C20
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:54:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=GBxIjNKf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22227-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22227-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C8A3000FF5
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DE3D45F2;
	Mon, 15 Jun 2026 08:51:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE343D25B6
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513466; cv=none; b=ZL0uS6ip5eIEJUeqttsLAukZciR0kUXNjYzuxPjTeUY0RC3Gv/bRjikZNEYLSlT3wtUuwHEC1mxmf1CZDyQ5etBS31hlfhFcvxUxdVrAGzwegCBAcA8KnKREALLvZlwad4DERA+XuXPJ/5qO8DzMtT9xabhu06aZY/RHQ0vweeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513466; c=relaxed/simple;
	bh=eZY3nMYYu0XsCTjxFSnJOkZ4U4sWD9wJsp4R3yD5DEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpf+DcW660LPgQTG6ft57sylUY0m81hp/41mVoC0uSUvgUMgO1EcyJOVYOOtjra2FJlCF28ZR0tHekmSYNwJYtCw9OsDARlpopPLH6G4r8Lmu5kVpYD41PPI9wrQhGo9Zfji/VTAxqI+7veCTILqmo6eIf/uqSeN/IfQlH9p+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GBxIjNKf; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so2556670a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513459; x=1782118259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt+Nl8hrtYxjV+kNQIdKAar1UWFKkONb8wO9zXaR26Q=;
        b=GBxIjNKfpfHVGJKb9Nt1oddEQQMZly2a2JAoSHJTYcQrKh9YGgHdXqA9gw1k6zHjQz
         8wU1s6NxX5+RJytSmpN8CLJ3j0wcp2S4qbWYCY74FXqG041uJFa3jdMAKm9rIrIwLPZJ
         5ekuy3P5ojICYDHUad8f1eVObzs8x+v1naSRPwP8pWdKreAopBKb8juOE9XT2taEe/LV
         1BYbmbkNPvy+LD1PrnlD7SnkySio7jQpDr+UTzyqwwXjjCu5XTY0vRJScP825nccvTqA
         7ZMCxm9EPQukVGHfegZrT5AVeV1gAQE2Ry6PIefJQI/U4EYdNH+h07O5OturGJ994dvV
         nFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513459; x=1782118259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tt+Nl8hrtYxjV+kNQIdKAar1UWFKkONb8wO9zXaR26Q=;
        b=F3fwRM5esPXf4G6YN77gk7nwTLBJBWNoZuhhjWCDE/UykCzGqBaASfq3bMGOFvebqs
         zgRV1Emzv+FElOKYA3QrtvKF37g3+1KZlHBF6QFNXxneJ8+HxKpuAxRIlK0q1diYB4ZJ
         T5k3U8Hh9TXc29qClmspuT8FUhj4ayQuCSECEwdokRP3QkZYbz6lW/+XZA5B4ywgLc9Q
         n3oXwX8i+Y2ujmRI1ttnFeamGUWgKl7axMr+cdDGzsZZkSNJlEy0SIGyVtGOOu54V4pN
         sO9+c3MQyI9MiAoFNwqPbE7GXaYZWoZXEeUjjx8DywjNC03I4rUYW8twwZmAMI8yp5D8
         D6jA==
X-Gm-Message-State: AOJu0YzrrAkzF1xFZ14mOtn0RoKmozdUUb7/TFm+EIFFMD5H7hBNrDla
	MY1JkjSpjBMMiPBuNWXUV9EW4fmAQvuF88OYW6d5yn+DGCdMa79bjDK2In6V2KMyOlC7DLXPybY
	c8T97
X-Gm-Gg: Acq92OHfEw/oMiRlMLsS3nDWW/Sixm+MmqoI3+cjIou/R9732EwNKqhxTNJr+3caB5H
	tk7JTvJTDib/XDYUF/HVHN4/Ie79F8ZjJ4AFMgjKJT/bs51g+v0Qe6K3LV4+qcH9gQH604SpTv3
	UXXT33m3pEObIfWzNBR9VzNZSogrOJd3kVu5iW7NyvgcjPQd2xtth9dGMdkXPmwTGH2yBUorl7Z
	wvfdzUVdJkqGgm7bkwMC9GGX4d9L8rpfsO/CZN0SgvI6az1q9f2Ps4kc9A4HyL3YB4/Hr7gQk2B
	t8H+Gz8am7PdGGYzF6dosoK6tzlktqi5X4UcpgXdfJPhLRbDLvK/cRvOM8r/aIGm0Zf3HtuWq+l
	Kle+ySnkpjd3o/fyk9XWlXcQ8ISNRaAf/81btvqg+uOKxOEwzsbrxNUPzOWnwJM9Rw/wrYTpgEh
	y2m5kwOWx/JhfAQeaZBHst6Y8xJ2SMdPJlNHPg0KWpJ80=
X-Received: by 2002:a05:6402:34d1:b0:67f:7e9b:afe8 with SMTP id 4fb4d7f45d1cf-693784ddf38mr5783338a12.6.1781513459490;
        Mon, 15 Jun 2026 01:50:59 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693794ae998sm3057247a12.30.2026.06.15.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:50:59 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 4/6] RDMA/uverbs: Add ioctl method for CQ resize
Date: Mon, 15 Jun 2026 10:50:38 +0200
Message-ID: <20260615085040.1396623-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615085040.1396623-1-jiri@resnulli.us>
References: <20260615085040.1396623-1-jiri@resnulli.us>
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
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22227-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 436ED684C20

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
v1->v2:
- removed unneeded cq check
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 43 ++++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  7 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 148cdd180dab..4699747f4ad3 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -228,11 +228,52 @@ DECLARE_UVERBS_NAMED_METHOD(
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


