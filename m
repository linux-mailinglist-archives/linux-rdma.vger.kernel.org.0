Return-Path: <linux-rdma+bounces-21310-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAxsDjyzFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21310-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B35D7F06
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9082F31039F8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6EB401A23;
	Tue, 26 May 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="UQKJ0t9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFA3FFACC
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806541; cv=none; b=FATnr/sb632SHSbsasCjwBNxz35kANbQlwm4uc2v4mZMGslIqtVlG6X6OlECO+yU5/3WaPvEW1IsbE29t3wdYqWJphcyBZRAwDkO4iuaVzFpOgY9gS91M1gKlMcjzx2Ke6kKQR5AcDhLflWZrC0qbIiYeIK7DCfsfAeAI5+IckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806541; c=relaxed/simple;
	bh=5k1hrORSRIKuvhuJS9zw9X3JQXnAXc7IqHvdAshoap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnPFpWICAvKvPsDrDtGoDs2S/2qW6jiIKPE+H+EeGA0NiLq3aLMhnwyeGFq0kk5tpBnJ22F33TLz5b4c5gjr1QfKVY93Xl2NYogrCqjpOodPerK63YXFP8oCpBqUss7Sc/GXppK6KFM6WQvE7siB1QBZrkXpFzQflUFZOtpgx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=UQKJ0t9p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903974854dso44859405e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806538; x=1780411338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PjAjeWlGu+WY+4yH1Ln8J5JmQbwP5DX97H79DWKR5g=;
        b=UQKJ0t9pylUo2fdsXdCLTMB1zOX+io4AFUr6kF9d2q8yUxugYuLR5y10rj4RoaJC/6
         3mifn2C1aMfeDqvZwp9XJ/5TGAhuChn9Nlow1JeqJbPbtlr1/gnw4E+h8SwUQQF09kBg
         a0jqL+OvfomRz0fO5JwA21yeoQHsVn1WuSp+pMC52WtxLsyqa1BGisnDR/XwwbjHNeQm
         6Y9y0Dm6BC9ygIUtiNoELPfGH0mkjel3ObmQu1jmszPeA0iZfQYr1LkbQbOQl3gjw5bb
         5fT5ESB1lNWtDp/P44348umaIzj2er1Wrs5/TWIo0BTsTtws/ttjyf/FOKMN3zJ46+Bq
         Ossw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806538; x=1780411338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PjAjeWlGu+WY+4yH1Ln8J5JmQbwP5DX97H79DWKR5g=;
        b=Y4tvlRbhMivracHQi4jnys/K5dsa2r8vxg2ml1yYPHOCPUU9e0J4GTML1aDpVWSZql
         yeNjDMJQIsgvDZt5ypTEqvu4ouLLdC+cgBQ/1I+zubba5XLo+24wStbI2RvAdzpWsRmj
         IHwzwop7w14IhM8I5sVDtgfn3M5/K6QfdmgDJ3GH0gj3FIgOSbwvuy0LsUl0E3TKnMqD
         uyrr2jArVApy4goUFHSHBtBe47bpomOJyu9moSBiHMbYRm+kPIPJYdnwEJl6RwA0HcB4
         BtGt8lJOTDV80MGNeP5Yc0UxZsd/+V+/xi7JqAV3HJYNKIcg09cHsC4EhdOUuU4YLN6C
         oKbg==
X-Gm-Message-State: AOJu0Yzdrj5rWJd9rdQ5JDQlfkuUq5/nBC2K/Bqms1m4QUhyBpWxXL5M
	tQ1nuJmcZuxFoB3VzqdtgNVHcW3PqSmaT+qKqjyTGxoYfew75AvMkFSnW+qptaQLUR5HJM5oxW8
	pfn9bKVkbBw==
X-Gm-Gg: Acq92OFkux2iAlx9mXrVxr62XAvmQFvxFy9AVkeBSESwwjYgtL4OZMw5a1H3g0o3dND
	9cochsuxizcYS4tFNUfD8taFND2/5HFxmZialOcbKAj0uM71NctqgON9XObvVbpNMk9ACxVPZrW
	D9kYyCHuRNVIpY19I3cBANL9GzJy7vax+9616KD6eaoZ5337ZceVITIy0LyZkVkAt7uiaOei2je
	uVIUCLcM581d41udChY5Aa/g4alAnq7+Yu/WaS6EomnzxULC6IFS/MfeS8kF1PKj6uGwyIMRKSY
	XFAia1UUz3Kxh4IqeaKqUPcGYQX2dOSfcE0IDrUX4TJvqMMzYH4JB0YwN8sya0U6LBfKWP0Iqje
	hqtgMIegU0ookoO06ynbfvwXZgHpBqYqjdtYRCDQZIzSRz8UyHTkxz8muAD9AhNI1GeIVoG6RQs
	eIXdNBXjQNk+eqRAuZ7/dUGwtNNwaiiLau4ynuCjbjcH8=
X-Received: by 2002:a05:600c:3593:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-4904225ae0emr360268775e9.0.1779806537685;
        Tue, 26 May 2026 07:42:17 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49044f2bad3sm359499925e9.0.2026.05.26.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:17 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 06/15] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Tue, 26 May 2026 16:41:43 +0200
Message-ID: <20260526144152.1422310-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21310-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE6B35D7F06
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
index 37f0f8679278..ec117aaf337d 100644
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


