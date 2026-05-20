Return-Path: <linux-rdma+bounces-21039-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF91F5qJDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21039-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:14:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21258B82C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 668AF3030519
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E93D3CEE;
	Wed, 20 May 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Ycy+PcVK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643413D5663
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271907; cv=none; b=eOxBRSVXEaAkMwtzIeut0nz+2kixttwizOIFtUFRTY54SC+3pTrBHziMEGoraZTA5UyUAiCMbizVdkpeDTMl609oB9fUmW2d8yoz2ey/JUUUC8UQR6LFG+1TKvUS2kkGrtJutYC85gLuL9qB4haiUb5pbQAeqkyRa7px9YPnNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271907; c=relaxed/simple;
	bh=/21P8IIjPXQkZupjQhtOmyFgF3+DjPr+sncIiLryHCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eencwncHuPd+ZA5f2luDwnE/cGKhl0YfmKaetgZs7aqV1SHsoAhG4wfXdJ5C7K+56xMOW9y1hAblq+shVwpPC1AoBtU48TjMHZ8lwTJrpjbZJo7/ss1lL2qNA/M787QHz6orqOeqscwY8yt06P/CV9IjtCT8iCTWfj73h7jU4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Ycy+PcVK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so38434715e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271904; x=1779876704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cmCpiZNCZwVD/lW4tHD8xhMyf+Ia1pmEfDupzVL9Ns=;
        b=Ycy+PcVKYkBJNSyrIiceXmHG0cHL9PlaDDKNQqWaEf4Nc6jOw+aU+mj+jK3Oof0fYu
         raFaa5NPWMzI+hYfQWNMzYY3+GkA7mHmkA/O4zVXdLzX+APs2ZDYKgnZLB7NrDlu8Y42
         jUxI5MK3Ad0G5gEKviF4RfdK1hm/mLraigJihb39pBCjVYgT5CboxNeCjcww4YPZWmNH
         MphF0j919d9JS6R8UKj01C74tzGAM5wp24b/U+VSAgcLlAXyZpxbQiUF4tr0vumX/lQA
         5agNC317EJbsQkRICLaImy6j3G+du92LJVpmuw9P33HMzBsnkAGtl/C6dhDo9PoPFpPT
         LsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271904; x=1779876704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cmCpiZNCZwVD/lW4tHD8xhMyf+Ia1pmEfDupzVL9Ns=;
        b=ZM33tU17hXIhc3bbrJVhzIQlYWOomOaPp9NWEBNajNeJkXjbIFYg3vKrQSrcbQgV1q
         qXRATFJKOhCJxc231POejcLon0Z56za3cbRbyD1haixw01B+WvwMPdA9E5jnVnoKRypC
         1yqK5WEa17BXjEYdfOpXykWKhUUgbsG/fofazCzMSgu7R5hipG7N368tl+MgBfeZon2J
         X6HJai4OV6wqdwRhLKvYS+gnFd90imA6yiw5pj20JnmVSfvobh2F9qtmiotjsH9V9nmi
         lD95bBZUTM0sQfmkCLuSPh2Z9JXR6FALR48Nv9BM14rjVW3QD/CCVITZ2IHdYQcl90Ox
         g4Fw==
X-Gm-Message-State: AOJu0YwNON6nKIatrg2tgVuwD1fGVtpF7rEvVy+PN2dgdaT4JugnqaeX
	7yXa2WJyo33XAh3CGT0oB1AkUEisukykerGz/mr78VIGi/fVQsgleL8TdfvZUaVm5v4yc9Rdkce
	bjfBSCLToZA==
X-Gm-Gg: Acq92OEx8L7Rf6ps8IpAiFM0PpkMYeYAzFbDy3HkZLimjDofOFgf4QGjukGXbBOD8o5
	DZT3cx9efF4UQXhwy3E+lr5ZHU7/iAACtF1kS5B+MV8nIHgdkRkJBu6rJJGcmiUcMLXrE6bqSnK
	T0Q17ypj9hon1/zkR0oxKaBKhNpEN6ymbU9/a0fJ7nIhrrLqVF5/eQHd9nhBOjrDkmYR8tfN+7o
	FeAye+4N6YpL5jHNsdc9JRBW3Paeom5yPv+w0mTk/vPbYfcEG47JaHcBX8IbTOL04aNTHCX+eHh
	wgdmFK85UzdjV3OaM8/0teUm1JfOWQboijJ/r1TQRH22cUqo1nbMeXUSCN1Dcl7vYdlwj06nw2H
	4wL5KyIEEIUBex4tRK5z7M0YDIxMgBuSuYqMwFJRCJZq26M+Vx/0iyX9LD1nj5uBjOIGRAeUefH
	9IW2mwbTz2aA5biFHjOZb5tzi2qI0tcB/8
X-Received: by 2002:a05:600c:34cf:b0:48e:5990:9698 with SMTP id 5b1f17b1804b1-48fe651588fmr371985405e9.24.1779271903750;
        Wed, 20 May 2026 03:11:43 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm55027108f8f.29.2026.05.20.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:43 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 06/15] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Wed, 20 May 2026 12:11:20 +0200
Message-ID: <20260520101129.899464-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21039-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B21258B82C
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
index 0d6209bd5e65..233c4631f3a5 100644
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


