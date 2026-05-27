Return-Path: <linux-rdma+bounces-21385-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG74IJIlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21385-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD35E8315
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77CF83000BB8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4F44CAC9;
	Wed, 27 May 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Z64zEy25"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1623BE632
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901813; cv=none; b=Jz9HHor+USp8Q+xaxYfy1/IRrRUGPf1rEdrJaBRV6oOOSYYXDm5750VRJwU6zhYc15q/Agh7DYGdCfMrYKOU4nnC9McAbF7YWwoO59HM47u6Kl90UZp9ZVU3N/NFZNob/ttL2A1wfpEFFCpRXib+oX2WhCRDct2ev+3Va0bftfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901813; c=relaxed/simple;
	bh=t27kS9ilslz5gV/UyoqobWlw2Kovy6lN01GIHZzPUA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBMIGlEz775aXYkfxvPk3ZzvmAq30ZGaYTOViWbBqQWYf+nNVHEfd+YC6dZWKCY9llPR6Dxjio7dEdNwcd+4hYqWCAVDIniC01WIxbwgBHD6xN7vF5fENdqGsTD8PEyMB4yOrjztg5hRMXVgJ9G5DFHmMBdBa/SWJOljTz+mlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Z64zEy25; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73422431so8508864f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901810; x=1780506610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dwXbNhC66fiuQKDUkcHy6dxW0OdeD4acZhjThKhfLI=;
        b=Z64zEy25j9nwiNBR5b9piBvMqab9dS+JrjZmTlrJw85wk9T3Qgbw0rKCehMZbSZQo2
         Tuy+esLJJeKLVeMK1CoE7tRHrsek9JCte1SnGoXGE6lwZ9vSIt4UkZNbYm2cWkV9uKQg
         xeWUNUyQ6IUkERRWFnMn13VuckkJuS80IdUV5sppJVuFhN9OGh+Z6pHLtEWpaXep8RaD
         vj2Y/bFwSMGu3/7mDT0D/EhraHP5H6s5a6KpOvmrN9FlSCt1Yy5Lhj22JsAcdXZ8fGCT
         QZjWj6qmx1Q/ms4wNEMWyc918SpxiE7UbhlmPFZINmFugziVlpWLxX4ghac8lUdfszoD
         /0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901810; x=1780506610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+dwXbNhC66fiuQKDUkcHy6dxW0OdeD4acZhjThKhfLI=;
        b=oonTQFGaYhv2+ZzYmMeURZksZyFUJspM0KjUyUPGZqCpg0+cyJM2iRqBs7fN1BxtBf
         +UKwxOtjhRTpVkaipLhK4v6WC7lOO7cymDaUSGrezEGME77flezMHIvMzYbtUl2ufcoI
         7GFt49lWTz2ziorS0ReaQy6iVy9/ODKQ3dZEM+/U1WEWwlXKnIdB8yDN4CzBqbCXo3Tj
         s1/baSwN/7yDjdjIXNTquCbfzoBocy9t66LEYtEQpSqhaahrL/2N7PHlir0V2LZSe5Aw
         jwiwg8C/sU4HAQRkbkepVFFAIG8MgGdV040Mn+G3osIFAgUTS2PzkfDbzdraPISJ42NU
         0cQw==
X-Gm-Message-State: AOJu0YxtLYCVxHcGDEDbgR29U+wDcDHazqjJcGmRs6CL/31WpYk1tG6Z
	xNPQkU+43ymk7S8HXWIwPWu683sjmhUywpXiOrNk1wPaPw9O6xJAP782szC3oaskAQQ7mt6Je89
	f5LmEe71t9g==
X-Gm-Gg: Acq92OG1bBlqMoZJH+i0McBZKhEFodg+WMqyJNpwS6vAM1RAyWokRuCEGJG4L/1BMT4
	IdQDnhf7b64Nba0pcmryQD44YXF8+6TEHzMku3JXxfx103+8hELOKir+/38CLW8KhrUMzKJkhA0
	7tZrkEIomAyFY4dTR7J5aKg+m5BuSDVhp4K/2VHLItVj/VDIC8SH3Gz8v0KfIB8zVFKblxAPLhI
	UsZsWs8xXgKyO9xKiNNIj0Sg8Zthv8lqQrqB5o+MeSu0M3vjkdpJD0P7+9eFktcVt4DRTFy0HSL
	czBL9j+uCsBx+3L11TqxltAA12TFiZMfeRLBYDV4lyZFBEHfZmtSIaHY/8MPl+spGn8wq47rzr6
	IKt89xrOzX7iPJ+kRuCG2MP9mgVxmxtGDxWepN4yzH7lMYyCjoI5FedhEWgk77TuXsnHY6JSJ4d
	J3YZGg+16WlcGs0WgSzvXwvfeNLAPQv05q9A54FHJfcQ==
X-Received: by 2002:a5d:59c4:0:b0:45e:5c98:c8ed with SMTP id ffacd0b85a97d-45eb38af486mr36566085f8f.21.1779901809963;
        Wed, 27 May 2026 10:10:09 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c27e7sm7313106f8f.35.2026.05.27.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:09 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 05/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Wed, 27 May 2026 19:09:38 +0200
Message-ID: <20260527170948.2017439-6-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21385-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 78DD35E8315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v5->v6:
- rebased on top of ib_umem_get() made static
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
index 31e99c6e3904..8fd42a001705 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -484,6 +484,85 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_get_attr_or_va);
 
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
index 908eafa52840..0d6e90a35f3a 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -90,6 +90,8 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       const struct uverbs_attr_bundle *attrs,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
+struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
+				   struct uverbs_attr_bundle *attrs);
 
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
@@ -207,6 +209,11 @@ ib_umem_get_attr_or_va(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *
+ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
-- 
2.54.0


