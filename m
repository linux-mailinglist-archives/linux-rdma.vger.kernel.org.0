Return-Path: <linux-rdma+bounces-21386-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLOgFKElF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21386-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC35E8332
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BDC3043C27
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C873BE632;
	Wed, 27 May 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="TBO6HYUU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE773EEAD9
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901816; cv=none; b=hqbaJMYlZTI6g8wLkZ/llpjSHlNulSRJJBSYWJwD+ewJYg6voSIEQHn0VufXem/OCmuJuDgGdXbVzFv0ZAxj8dAu3jfIAO1NmR0ElJHQZb8safuceN/tSJ4K7TTg/JL0t2zURNwrC4AQu9bwnV3nMLnp6dfzBRa7beZaebbIJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901816; c=relaxed/simple;
	bh=6WCNEJjeCP1x/Mj4A3LUTcl+0uJm82/d0eyQmUzD10Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6a9AG6QwuICAKPMf73V4nuny+LZcb38wxl7eMi27TZ2QKWwzgYIpT2CfaJAhXCyw85G9VfqIMNyfdmxVBarbx6iguudKtWHEGzMkokb7fv73zphZ7f2IWoDs54qNh2PmbiYeXWNboM1ZrNC9VhZ2YBRu356nehIz0ndxrPKPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=TBO6HYUU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4906238c62eso33433735e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901814; x=1780506614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSp/fiqo+koKutdpQZpH2vpBjno3H7BqwKoTOkS98o0=;
        b=TBO6HYUUzKKublYCkj57TYBJ6/a0cEzl+Ufs5JKSPQ+UyZTEEi/Eygprqx80ieGKHc
         ICWodQlxstYZaKVvp9n/JLFP4MOyAd4Z40y1x9taNLJAGMgvE3dqrkBuY8H3OgxyDeho
         I4J7BForXofP9JEuVUrrLH5k5DzFHfYv1KGHC4V9teTpmC36RzeoH3y0oUjbMfgbtQuN
         3tzNF/+FoGTHx8OqV0RzLc2RQ7W2zWC9LNqvtDwfP1OL4u40M8icyGeaSZV+gbtGR3Yy
         /XAzkkjRdESm0BLBEJLbNEItxzO+8dWfzcyvse7HShtNCxPz1JfLs61L88+XejGlmtkt
         TYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901814; x=1780506614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSp/fiqo+koKutdpQZpH2vpBjno3H7BqwKoTOkS98o0=;
        b=TR804NOVVc1rp6vjGCy+xnbTLfh2tkkK+4mROMYypS3/bTXy74FA24d9WjjB5RbsDK
         09tCMpWgsRqIKCog94BCWa4czsmgClb607q7hGY/bHkk7He/neZMoeDR8jfljCFG5BcM
         AAgwbAraaJdyYhEqvA7jL5egaB6tlO8pTOyxBYw2Ps4yQQDY9sX+6mbDVN/fIxTdW8NV
         9fYw+/qrAiupEiQD+xZ3V6EThfy+c7478vcX5tiBXTashDNqfwKw+15NpPVXN9Ev0d71
         BnqxEQteufAjSkLSnrkWZs+1hNskuYGoFOXZo9csI+Pp52DOddUL9cAxKV5shw+A0/7E
         N9jg==
X-Gm-Message-State: AOJu0Ywo0rpa7wAPNLpunneE3NlduhUeUfi/1Xak8Y/fb+iAcMLEmvRq
	64sZDyoeEr3yubbo1AZqoYy8XDd3VmWwB6B9XNKW13hKMew3i3FaHeZe1Qja7CIoo8cc1585ktC
	4z0DsfN2Rnw==
X-Gm-Gg: Acq92OF6R1cuC25uDQpGV2IZjMHcuhzfeB2KndederaXgkTvGcWETqjnlhRnsg0zDxi
	8mm5j7WDnHBUi8HciNyoqinUCKOz1bwsWAteg38z3ZRnvTYJdGzTmEKg82iiTn9uhkdrwpLfjAa
	AcFsTtXGw9s720UEuTCP/PFzLjRB4kv3+4G5yX+H8UZBtd4F/jqX3DFNYZayXkPJeKzn5vJ3Rfe
	MwKRULNk21cCf9k+aQoWY98x4faHdcB4ZVR3vj4j6UdYbgQZx31z7Q/E3dLrB3VIheKOg2QC0Gt
	HSLZc3J7sBkXjas/DZnTOGAtGR4AfDHD5WkQIGX6Flwlt3N9JI2YYBRBiisXYztc/YKc+UlW5/2
	TZ4ayMExbB88whVtYvtB277ysRwsp4JG2c15E7pP2CBOPX3Pi8lVanh0tw7/EKORIzsPdJvgtpw
	p5WErK6v0u9BFd3aMkChXOTFVUXEXrn9Y=
X-Received: by 2002:a05:600c:354f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-4906e11c4b1mr188650665e9.13.1779901813624;
        Wed, 27 May 2026 10:10:13 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm438003345e9.2.2026.05.27.10.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 06/15] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Wed, 27 May 2026 19:09:39 +0200
Message-ID: <20260527170948.2017439-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21386-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: D6CC35E8332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
that pin a CQ buffer umem from it. The wrappers reuse the
existing legacy CQ buffer-attr filler.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
- use ib_umem_get_from_attrs*() helpers
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c                | 57 ++++++++++++++++++-
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +
 include/rdma/ib_umem.h                        | 20 +++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8fd42a001705..4022657b42e6 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -484,7 +484,7 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_get_attr_or_va);
 
-static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
+static int uverbs_create_cq_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
 					    struct ib_uverbs_buffer_desc *desc)
 {
 	struct ib_device *ib_dev = attrs->context->device;
@@ -534,6 +534,61 @@ static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
 	return -ENODATA;
 }
 
+/**
+ * ib_umem_get_cq_buf - Pin a CQ buffer umem from per-command attributes.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @size:    minimum required CQ buffer length.
+ * @access:  IB access flags.
+ *
+ * Resolves the CQ buffer from the new UMEM attribute or the legacy
+ * CQ buffer attributes. There is no UHW VA fallback, so the caller
+ * must arrange its own backing (typically an in-kernel allocation)
+ * when no source is available.
+ *
+ * Return: caller-owned umem on success; NULL when no source supplied
+ * a buffer; ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   const struct uverbs_attr_bundle *attrs,
+				   size_t size, int access)
+{
+	return ib_umem_get_from_attrs(device, attrs,
+				      UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+				      uverbs_create_cq_get_buffer_desc,
+				      size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf);
+
+/**
+ * ib_umem_get_cq_buf_or_va - Pin a CQ buffer umem with UHW VA fallback.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @addr:    UHW user VA used when no per-command attribute matched.
+ * @size:    on the attr / legacy paths, the minimum required umem length
+ *           validated post-pin; on the VA fallback path, the length to pin.
+ * @access:  IB access flags.
+ *
+ * Like ib_umem_get_cq_buf(), but pins @addr/@size when neither the
+ * UMEM attribute nor the legacy CQ buffer attributes are supplied.
+ *
+ * See ib_umem_get_attr_or_va() for the note on @size's dual role and
+ * the migration path for drivers that would distinguish a user-supplied
+ * length from a driver-computed minimum.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 u64 addr, size_t size, int access)
+{
+	return ib_umem_get_from_attrs_or_va(device, attrs,
+					    UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+					    uverbs_create_cq_get_buffer_desc,
+					    addr, size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf_or_va);
+
 /**
  * ib_umem_get_cq_tmp - Temporary CQ buffer umem getter.
  * @device: IB device.
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 711bad0aa8a3..05d1294762c0 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -215,6 +215,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0d6e90a35f3a..492c8d365730 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -90,6 +90,12 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       const struct uverbs_attr_bundle *attrs,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   const struct uverbs_attr_bundle *attrs,
+				   size_t size, int access);
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 u64 addr, size_t size, int access);
 struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
 				   struct uverbs_attr_bundle *attrs);
 
@@ -210,6 +216,20 @@ ib_umem_get_attr_or_va(struct ib_device *device,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline struct ib_umem *
+ib_umem_get_cq_buf(struct ib_device *device,
+		   const struct uverbs_attr_bundle *attrs, size_t size,
+		   int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
+ib_umem_get_cq_buf_or_va(struct ib_device *device,
+			 const struct uverbs_attr_bundle *attrs, u64 addr,
+			 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
 ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 72041c1b0ea5..02835b7fd76d 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -117,6 +117,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.54.0


