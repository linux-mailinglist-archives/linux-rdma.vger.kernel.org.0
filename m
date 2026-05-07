Return-Path: <linux-rdma+bounces-20148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJWOA0mL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0D4E8863
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E7C3037155
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B23ED5D5;
	Thu,  7 May 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="keTT3rX6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C95358D27
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158363; cv=none; b=KmG05sQ02SnzSk7tf29w9RKuGi3RSUmi3W8sLYvor5uVPXeE0Y8Dh7jIhBYeN3/kzVeWDFswnhi5QOYpYyjLERKBDWb7mtXh565xGBQowLEKMGpeTjrf5VNv2geA0EJkcFTHlD2K5NWuVT7OK2PLuf9TVwMPXhsnGwLen6hHamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158363; c=relaxed/simple;
	bh=yQbVcIqHClDrt2k4SFjcZNJg4ee9/AWFM4ZTnE4nkZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNf1u3cQr6QDJTBX5BQ2zs91/IxsdlTTm7nNqFm701b8QAZ8xHrqfYJ+ZbhpKcvjzJVGcsmSDXuGPa+yMGDLdlIVcH+mvwKiZdUAGev8ER7pEPjYFJrI8bxcIvuVngntP65Y/b3qldhENWkwiyndNy2jU+kepzKAvOitiqug7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=keTT3rX6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0046078so7108165e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158360; x=1778763160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5IdSoicCISEUakglFiCP6zRTC+RD6+5zoHMs9P8+i0=;
        b=keTT3rX6DihayeD7Z9TS8mCHtzyWdzKAU55c6V/0W26605GJC07tZ5zPUrHU6GELOd
         Dmm9wwYPyA2u4HW94VLdawIxOWJRNMD94wvT4OMQ89p/QdeNK165KyR49xVfB5IdD/wR
         Pc47aC3tGOucND842d/8riJOUK4Tot36hnBmJ4b10B5Hcr6d+iF6Zn6q6dOMtsiNR92W
         v7etv097zsYnjHUeFZYYzUdG6npGIus+YVWNc0VMqr3R0sDbP8lM7x2N7NVkdvt2Vgzl
         /Znjz1V4hNgFDX5Xmh59DhUeiJAhuSmEOHqZQFssalKkqM9M/4YfS3Jc5ZgP2ogaNJ06
         kSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158360; x=1778763160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5IdSoicCISEUakglFiCP6zRTC+RD6+5zoHMs9P8+i0=;
        b=KjjIL2q6TuOm9/Eor7GI6kPJ+x37TkKZm2vemqe6TY7mf7cxjle1mQemmZM00WRmHG
         2fU8DQNTe4ufszknhPiD/77xEG7Bqp77rXtkC9xA0Myt/56scUMYeZ31useWn2nYf8gB
         OPnm5a2gWbWbCgxcLd0aqbf0aUsDje6VNvz8lVP2FVO4iE+Si7fpnQkPWrqOc4nNCm72
         LV6tNCteJ4itQPdxqsdXbGgBNUpAVNgFdM443ue6Q2Wmqc4MCApC6b0O+Bwo0IqqIeuc
         ZAaJYqTH6YXn0wVuOLBjtTN7do9a3uhVWk2FwQ/C9C9qp78tsZRJeE4eBM/wYUVE/lXJ
         GV5w==
X-Gm-Message-State: AOJu0YwUjjZ3XQ4+xDqZcdKoP9tPQN1tDWEWJj3yW2vHbkiiegolybsS
	VBHD+VUy66v1giuHbI0yzT8R4cVVNHbAZKRnOHpRtye70VJsNXrIP7+lHrlOIGGOe48rQmzOnHi
	7KxNp
X-Gm-Gg: AeBDiet8qnl94EAQGgTLrhJvCLb7WMQUTIvkm5xTQb3FH0oSg/vKEJfYLDN6NnthjGi
	WXq3bdDVTAMDGrWfzsdp+0/1dKRbcsVXh7uGcqzGKq34GAQlo2E9K+tzfqCgwdA8c9QC0YI0aK7
	WcuOeaXbtV4LCAMJN+EmqviqY94YvHmDsaP/lx/H/N5kaFT5+BkHOUY5oMhU7rmcMptyujmhjZB
	WnVvja+9YbsM2zBs2KkRdPuiOkGQ7cJrohpR8H0xS2VrzEpFDeeXFmpmciSjSs6YE11kxRew797
	kqvvzQeMfA3wSko6NCv1e3JD7MmdhxUfNRDNTA6NppPXJzSKj969Bmk/iOp4vZ0pgAlnn7d5mmm
	+WK+krgnbHb+CvKNunR03iCODn3rhQ61FtaiRDcfpp+lb8bepeleobwX01SNNY3fppv8Pwda1Fr
	FgvtSQAZC7xjlG98eR3hRHhJ7CIywSER+bkx/1jk9a8ZT3VDp5PHpLj4uwEv9zhl0rIwc=
X-Received: by 2002:a05:600c:354b:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-48e51e0c802mr124190665e9.4.1778158360139;
        Thu, 07 May 2026 05:52:40 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm209771955e9.10.2026.05.07.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:39 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v4 07/16] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Thu,  7 May 2026 14:52:22 +0200
Message-ID: <20260507125231.2950751-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95F0D4E8863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20148-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
that pin a CQ buffer umem from it. The wrappers reuse the
existing legacy CQ buffer-attr filler.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c                | 48 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +
 include/rdma/ib_umem.h                        | 19 ++++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 4 files changed, 70 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index d36b61436c3c..f407c4dc255e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -420,6 +420,54 @@ static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
 	return -ENODATA;
 }
 
+/**
+ * ib_umem_get_cq_buf - Pin a CQ buffer umem from per-command attributes.
+ * @device:  IB device.
+ * @udata:   uverbs udata bundle (may be NULL).
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
+				   struct ib_udata *udata, size_t size,
+				   int access)
+{
+	return ib_umem_get(device, udata, UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			   uverbs_create_cq_get_buffer_desc, false, 0,
+			   size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf);
+
+/**
+ * ib_umem_get_cq_buf_or_va - Pin a CQ buffer umem with UHW VA fallback.
+ * @device:  IB device.
+ * @udata:   uverbs udata bundle (may be NULL).
+ * @addr:    UHW user VA used when no per-command attribute matched.
+ * @size:    minimum required CQ buffer length.
+ * @access:  IB access flags.
+ *
+ * Like ib_umem_get_cq_buf(), but pins @addr/@size when neither the
+ * UMEM attribute nor the legacy CQ buffer attributes are supplied.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 struct ib_udata *udata, u64 addr,
+					 size_t size, int access)
+{
+	return ib_umem_get(device, udata, UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			   uverbs_create_cq_get_buffer_desc, true, addr,
+			   size, access);
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
index afe12a1bedb0..174788a0640d 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -92,6 +92,12 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    u16 attr_id,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr, size_t size, int access);
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   struct ib_udata *udata, size_t size,
+				   int access);
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 struct ib_udata *udata, u64 addr,
+					 size_t size, int access);
 struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
 				   struct uverbs_attr_bundle *attrs);
 
@@ -208,6 +214,19 @@ ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+						 struct ib_udata *udata,
+						 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+						       struct ib_udata *udata,
+						       u64 addr, size_t size,
+						       int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *
 ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
 {
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
2.53.0


