Return-Path: <linux-rdma+bounces-21038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCZoMDmKDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64B58B952
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B7D3052B66
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7FF3D5674;
	Wed, 20 May 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="b+Xr6zvX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E33D3D03
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271905; cv=none; b=dQ/iUFh/Hh2nCY6vqD2YtBpebuI6vWbNToM9QQt0XGOVoMqrV7Y1KJObH1EwXmnl/usqfpqXjFPSiydHf9OsgE91I3dvAOZgeU9S4uEg3MON5dBtupfPiesvO9BOjGFPPrEK4/FE2bVgW6YZU0dsND+DtNA11nes2jCSfgHbtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271905; c=relaxed/simple;
	bh=TpeaxKj5pYTyBn3+ZEfG4cwcv0VFiSXoB3UUJbmERO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqQ8mBw6/UzqUxHkxQoujB7S18Wv3+O4g7NrYab5qIJDyXmhGSq4ef+8v1MPWcfBYZqUXOGkxlHS5tj+93COSRvjdtS4n71SO08fIyPoK/wVV2UHSPhvWZ+OZcmZkTXpBh8j9vH3LkZdQJ/oacCkvh3bMjxfywvhLuWzoie1IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=b+Xr6zvX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44e5624c053so2802882f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271902; x=1779876702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPErIGA9nyzIIjS3BPiMkTzwu6HFoDUmxiDhikeBWd8=;
        b=b+Xr6zvX52tqChVzMbQH0dRKRni31LVcv/YBf7AM0mpD0L29AQ8w3Lg9PpPQcoMIzY
         Ipvxv9ARMtiWO/WB6AtOLE3cdecMZ67DGPxsbF7NS1c29YJnhfk1z3w5RUe4QMLY+/SG
         9YDAHj/+STXaeyndTYeu84339xArbdGMG5op9/SYJCSUcHZoO50CXu1IjgDqCGDNr+HC
         n3TUgam8ikRdIRJi69yKWpyYr1WFyau1He9Ctl/EIY+18U7lvMoESc0hfpmlSPFaL2ze
         fil713+jTTSNWzEHoexVMG47oTt3BXoBxvhXgSWNFqEiEssR0+/+IknfMcyAL6MFMihC
         wxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271902; x=1779876702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPErIGA9nyzIIjS3BPiMkTzwu6HFoDUmxiDhikeBWd8=;
        b=mg8I44oSw4o6GNt7G7pEAmP9D/FoYpIRrTmlfS1xja2SbOO5Vv1Ood/N0JoBWIMxWI
         C5DFgqMv613SlBxeWb7ctx6Vte4SoG3P/0uK6xn0rludiFPs4pG9/wne2KxWC1Mxp/xA
         oWMEkkbY4903k65YOu2dy18RU6r2qJ6B3iV4+dX8j3+8W8aD6bxYN8wlm6MFv3Nt/RrJ
         EHOEfZI132Dw3Xex0ArDlVPhgYZogkcQIpsW6bgNCD0DgIdyf6Ry2uZ5XEEhyBL301IP
         vZv/4KAxl+bnK+VawZhx8oxGcWSWdk8njg3+w1rQrdHRuQmsrO7fVSDF1Prykcgh6bOt
         +wGg==
X-Gm-Message-State: AOJu0YzsibpgrgsRZyuDMKxpfM+yvZWPJ935rdBRfZwd7awPaf8s09jK
	1jbYe9rgzrtLJVp24zw/ze4blIGV170R6dlGH5Osti5sbnzwjoO166Et2oYFqBlWKbwQ0VHgwSH
	pKhXZxKHllw==
X-Gm-Gg: Acq92OEMD/Nv5kW/0EXNVFwdMvZ1bDQbI3ZDNOP9L1PYJ3JWhk20fieZ5dRwFuOMdMH
	+oq4RUeS5h3abM+qGZFz9LaD+gxwEnxV1iS3lKN7k6QSqtVSigrzjGWZwTi1CiU6jQV43kRW4CI
	CGsXp3ALVY1P3jgAtoME9dHq2gmNJr/YLsgtQNrWlY65EjgX/Ry/qS0Iy7UNc1nesUM27kvoKbm
	3CNloATaKrMqb+XUQ+IEI7evoKL2H0sMb8VinkVmA7Qzvsz4pqeUGcBgtjg9FxSrA0hYgwbX5AZ
	wyjinq82+1O5eDrZbl8by8VxLPrbWQSDF1U5Qq5cILdCWueBf1qfh4WCMQAn3pZOC+hXE9twI6D
	A5lbNvG8U0KDWDnvBdvA3EVjBLW2PpWRhQNR2xpp+LmVDIpfggtBzveT9R2PDSqUOy/CgnREaqV
	LWZO51H1mhnqNVoiSO1pG4QuJEg+jLJn3A4FWVaunxcv4=
X-Received: by 2002:a05:6000:2584:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-45e5c5e6d3dmr38086300f8f.43.1779271902012;
        Wed, 20 May 2026 03:11:42 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm49596193f8f.0.2026.05.20.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:41 -0700 (PDT)
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
Subject: [PATCH rdma-next v6 05/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Wed, 20 May 2026 12:11:19 +0200
Message-ID: <20260520101129.899464-6-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21038-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8C64B58B952
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
index 4ffce2a54dbd..0d6209bd5e65 100644
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


