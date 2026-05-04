Return-Path: <linux-rdma+bounces-19919-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCcnLlym+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19919-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C78264BE487
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 725E930080B8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042B3DD53E;
	Mon,  4 May 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gNhgzm7R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1113D47D0
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903068; cv=none; b=H+CowwTfs+G4XmNjR6nM2CrFOW0DHugOveygtRcN3Y7tV2moar+yNHd+fzBU6aJUD2fEd9cYf3vyafxSRMYReNg5FPoDczzQTdfigEGrFo+9vQU7ttgzNjbdCLaWJws5m7eSY3hpcWxJo9N0jIYv3aIG7H+Tx3hKRgw4H8jSIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903068; c=relaxed/simple;
	bh=A57O4zDrrCYFi9fqlUrshiJqsbdWdcWo3UxDhXpeY4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASFt8RFBuv73cbU/dhagQEn0NnECkTUuhp3X50XR8tXQynuLfV2NSiVFRbGr+bItrpuzIwIGatc2GP0SLTsarGV1MCexw/1P5Ra2Zn4zo/JceowGoT7NMZdl2YKpkaoSLPw4Pzfuvpk6QQz9dEqxxdTuS2jDh4tpsgZZRXOMlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gNhgzm7R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso39039495e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903065; x=1778507865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvjIVhpIV8KcNJHYwwBGmANMjtePYLbaSXCShhQ9RSU=;
        b=gNhgzm7Rg/tprGTnh6zoJX2/5voqdCC0xjCjbpzCXoLSDcBQW+fsLx1xrQXZuFxpDT
         42QHv4NdvRaOKLGS7P/zOo2gt20buJD6pge14eMXmiDOeprpz72JnLr0U4DhbvTBxWVT
         DKlSTuVdqqD0ke5eKQiovetIakIhTEaLQW2sJtmGG/W02tgGltlB/v4pRwJIDWeU3L8y
         +i2VJA0kYoC6R6xKn/2b7v7g40Cw5QbDgtNyjj/CybH/mrAyWltauXkeMGXCbP1GFY8r
         eIupSjMtFazoBa+JH6vGSZfYjbkROfv4MLUbuEiWhD0fLja6ipQfueToI5LX0r6r9J5g
         yNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903065; x=1778507865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvjIVhpIV8KcNJHYwwBGmANMjtePYLbaSXCShhQ9RSU=;
        b=SN+FnK3W7ge3rKrCjiavrQcciUX2m4ceUU2hvPknoWydVgIav4mNpinCUXGonYD0E1
         QEpUekAAJ2ibJ19/8xaV12B5k779NZc5rlprWv44oBx8JRuTpdVaEnXLNe4qFdb6XGG5
         8C9mrmRji47Fe3ugS+Ad2jpxcXiAUfmd65+bKwgYodDnT6ixUcMUa5SXHtEu971/Mk/8
         DjqHDflt6UmwJ0Z6V2hSY5wepgH/QkIIu7IskxalNEwYgAYjUjXIhp7TcRsyPHzh8IeF
         2EuBqtfOexNL7HpxT0A0TNQmDEWSVrgmhWQ7oI0A7EDBulkziWl2PeEpTxkIICQODEaR
         6I8w==
X-Gm-Message-State: AOJu0Yzj/m+svhCzsjI9ahGK5N5HNtfELt4ticHJaMQLWETxetW2nBZ0
	Q+AKmSFX/kIiw1bQb3Xp3UQFHN+nahlA9u3shGb/mA69FayKwVn9jRkcD0WmENG/fSMtnMrEir7
	kqnGPrGg=
X-Gm-Gg: AeBDietUeoci+OBMNKWhKcFYUTeVwGfr5brBY2AiaUV6PMBIHqS2CATrpVtzEptA7W7
	4VZzv1dpM8LJt0Vmc4kce9Teoftuz7AFRMjPtjQkMKKhKDK/VBPXjp/6eOA2UgNRYCMGwsQ12ap
	jBTCPu6h60/9NAjwSV6lnlBsxro8LRtfM+GOlntrdnp4zqDOxeQO4Z0rzOIRadhbU5Jk50Vfk7v
	qY1m0Eai5c1Kzl1o4jB8QHrhcQrXTLIefOMdc+PG3S2sDTm+Bd76yZ1bVQHUOwHcKij6ay4LpjK
	fvM50aH4H5Puoc5RqGi295OZ2eF/vzTJTYaZWi5dishNcjcUn8gt+9cqWUeGPC/iLQOl2RMk0ED
	LJOhfBxB1DdUfk7aoAV6LXFZNlEAKOVJk/uA9aaJinkH9pHIekeuxoxtnp4mgJE69lhr7hPtFte
	grAxZyUvQtTNiheS9PkYsRz720
X-Received: by 2002:a05:600c:8906:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-48a98667decmr123184045e9.22.1777903065413;
        Mon, 04 May 2026 06:57:45 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8feb3659sm94699815e9.14.2026.05.04.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:44 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 06/17] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Mon,  4 May 2026 15:57:20 +0200
Message-ID: <20260504135731.2345383-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C78264BE487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19919-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Extract the UVERBS_ATTR_CREATE_CQ_BUFFER_* parser from the CQ
create handler into uverbs_create_cq_get_buffer_desc(), and wrap
it in ib_umem_get_cq_tmp(), the umem-producing helper the cq_create
handler now calls.

ib_umem_get_cq_tmp() is temporary; subsequent patches replace it
with driver-owned ib_umem_get_cq_buf*() wrappers built on the
same parser, and remove it once all CQ drivers have switched.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- renamed uverbs_create_cq_get_umem() to ib_umem_get_cq_tmp() and
  moved to umem.c
- split legacy attr parser into uverbs_create_cq_get_buffer_desc()
  for upcoming ib_umem_get_cq_buf*() reuse
- rebased on top of "RDMA/core: Fix user CQ creation for drivers
  without create_cq"
---
 drivers/infiniband/core/umem.c                | 79 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c | 60 +-------------
 include/rdma/ib_umem.h                        |  7 ++
 3 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index b0ab4133d47d..f720de8cb162 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -377,6 +377,85 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 }
 EXPORT_SYMBOL(ib_umem_get);
 
+static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
+					    struct ib_uverbs_buffer_desc *desc)
+{
+	struct ib_device *ib_dev = attrs->context->device;
+	int ret;
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
+		ret = uverbs_copy_from(&desc->addr, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
+		if (ret)
+			return ret;
+		ret = uverbs_copy_from(&desc->length, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			return ret;
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
+		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+		    !ib_dev->ops.create_user_cq)
+			return -EINVAL;
+		desc->type = IB_UVERBS_BUFFER_TYPE_VA;
+		return 0;
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD)) {
+		ret = uverbs_get_raw_fd(&desc->fd, attrs,
+					UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&desc->addr, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
+		if (ret)
+			return ret;
+		ret = uverbs_copy_from(&desc->length, attrs,
+				       UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
+		if (ret)
+			return ret;
+		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
+		    !ib_dev->ops.create_user_cq)
+			return -EINVAL;
+		desc->type = IB_UVERBS_BUFFER_TYPE_DMABUF;
+		return 0;
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
+	    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH))
+		return -EINVAL;
+	return -ENODATA;
+}
+
+/**
+ * ib_umem_get_cq_tmp - Temporary CQ buffer umem getter.
+ * @device: IB device.
+ * @attrs:  uverbs attribute bundle.
+ *
+ * Pins a CQ buffer described by the legacy CQ buffer attributes.
+ * Returns NULL when none are supplied.
+ *
+ * Will be removed once all CQ drivers have switched to get
+ * their buffer directly.
+ *
+ * Return: caller-owned umem on success; NULL when no legacy attribute
+ * is supplied; ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
+				   struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_buffer_desc desc = {};
+	int ret;
+
+	ret = uverbs_create_cq_get_buffer_desc(attrs, &desc);
+	if (ret == -ENODATA)
+		return NULL;
+	if (ret)
+		return ERR_PTR(ret);
+	return ib_umem_get_desc(device, &desc, IB_ACCESS_LOCAL_WRITE);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_tmp);
+
 /**
  * ib_umem_release - release pinned memory
  * @umem: umem struct to release
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 1a6bc8baa52b..711bad0aa8a3 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -66,16 +66,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		typeof(*obj), uevent.uobject);
 	struct ib_uverbs_completion_event_file *ev_file = NULL;
 	struct ib_device *ib_dev = attrs->context->device;
-	struct ib_umem_dmabuf *umem_dmabuf;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
 	struct ib_umem *umem = NULL;
-	u64 buffer_length;
-	u64 buffer_offset;
 	struct ib_cq *cq;
 	u64 user_handle;
-	u64 buffer_va;
-	int buffer_fd;
 	int ret;
 
 	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_user_cq) ||
@@ -122,58 +117,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
-	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
-
-		ret = uverbs_copy_from(&buffer_va, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
-		if (ret)
-			goto err_event_file;
-
-		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD) ||
-		    uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		    !ib_dev->ops.create_user_cq) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
-
-		umem = ib_umem_get_va(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem)) {
-			ret = PTR_ERR(umem);
-			goto err_event_file;
-		}
-	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD)) {
-
-		ret = uverbs_get_raw_fd(&buffer_fd, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_offset, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
-		if (ret)
-			goto err_event_file;
-
-		ret = uverbs_copy_from(&buffer_length, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
-		if (ret)
-			goto err_event_file;
-
-		if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA) ||
-		    !ib_dev->ops.create_user_cq) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
-
-		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset, buffer_length,
-							buffer_fd, IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem_dmabuf)) {
-			ret = PTR_ERR(umem_dmabuf);
-			goto err_event_file;
-		}
-		umem = &umem_dmabuf->umem;
-	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH)) {
-		ret = -EINVAL;
+	umem = ib_umem_get_cq_tmp(ib_dev, attrs);
+	if (IS_ERR(umem)) {
+		ret = PTR_ERR(umem);
 		goto err_event_file;
 	}
 
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index fd45162eb017..afe12a1bedb0 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -92,6 +92,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    u16 attr_id,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr, size_t size, int access);
+struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
+				   struct uverbs_attr_bundle *attrs);
 
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
@@ -206,6 +208,11 @@ ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *
+ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
 					     int access)
-- 
2.53.0


