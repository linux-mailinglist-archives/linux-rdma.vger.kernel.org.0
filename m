Return-Path: <linux-rdma+bounces-16424-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNXdNwO3gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16424-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E597D6648
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85BD330292DD
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B1396B88;
	Tue,  3 Feb 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="J4mqqiaX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1A396B76
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108613; cv=none; b=YSR4BvTJ5SZGNv12nSi93AQfNcspu7+hVt0+emm38dVgOmf31Fy+KHk4RZ+RusEq6GlKo5o2ydArpuExt+HPJzhpTn4yt2QARdsOuSgtig/XZBb1el/HGdndHsy1vUsVvsn6pJizulQbhjDCBDTraq4F4yNBdL1xl4wP698CZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108613; c=relaxed/simple;
	bh=Qo2cyVx58/2wu7X+xQdblP9DxsEqAQMa72xPa5Cr560=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzI1YmjJzk+Kb52Ahl4C2oyslRhA7r3J+MXpLHdd23/aqHVyVls28BEmlkFVr2H+owJi2VaArF5n5IJWyLsq0gNZ30PF28tqO7kygrR8NzEotDcC3r7ZmR20m6H9Ftq9FpWqCZV16UPDW55Y7E0SNP3UVeEzPYQWDLYaluiv2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=J4mqqiaX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48068127f00so45524835e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108610; x=1770713410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd4s55xOvLadKwHSzfILMrqbJs1qXW7xm3/NNEfgyeM=;
        b=J4mqqiaXc85pBjzY+zKDh4zSLWI8RqqWYFl4KsACIm0N5j39UwbVc2u8ZeZwZsdumj
         QvMzg1PXLIZTJEdO6esx27p2Dwda9UjVRRG0OrRqJagxqVPre7/8v9YzjWGDnhD+FsOl
         uP6HJ6ncUWzitKHPwCb+ehEC6WqRrSBxqNkyCxqTvVb2dYB1lS21A9GshQlN4gAqi5wT
         gXDYMRkifqyHs6SKx/iRnPAMw7S196//ehylktoxIQyjOw/sLFKTvtDzAs5YjuqnBobJ
         zj1sWWcd61grIcrJY7oUZNMpj1sgjs4htDMgwSqiPUFt0rU3PDlNoVQOF9HpaxOWUufp
         qC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108610; x=1770713410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pd4s55xOvLadKwHSzfILMrqbJs1qXW7xm3/NNEfgyeM=;
        b=BTBLPW45lQ++g9duYRCj4lQmfW4B51zIdYZj7iwuyUJS3PfE6hY40IIYeXeJAgIc0a
         Ta57XwDFT1mxElhI6a9B4LA5DD7FxD94N2WJdmCFxR88E6pS0OImZVhzQCxLPn24Uxe8
         1XlAawcHt3g7P1MQZ22uN1hReRe9mq2rfZ+IbNj2hOx6SSCTCXlre24I3Ak8ZQpVAauX
         z/cqRQhVioGUJX7+bxjPrsspM+pLC5MaLinaod52OU2J/bHKpDvLP9MC7YwLQ3KnLLEz
         ZbFdKuekTg39+XsWqk6JCpWCNSDQYVIho6rUniwqZoFUXBzyvnR8qtHdbddq0gi1PLRx
         kF2A==
X-Gm-Message-State: AOJu0YznvMeXBqVwbE+/uVabU9YlfP1nUU0DwPOVpwB8DhQ88O/P6N0m
	luJofa4WRvrSbvH0VWT0BE/dmFhuU+0SUZVSo3fGPRkZ+qzikmMHgG/7fU/Do0Ttgyz3Gl8Bsfw
	XX72c
X-Gm-Gg: AZuq6aIMuD2kJbmz7pbrvDZLWCweUDXKbw/kQKu1FevdOriI2sqy7FCgxMOe7WqcYt2
	WBz0b4cx2P+LgFfgcP2+DqSzlWOao2PkhyWguXUKJs/l1ffGNqLQIeo5Kz9BpIJRGcHRXhJQ5IH
	4n0N8+LBmt09mR/xLES3meg5KdkKi5qwEmEA+HnRg0i6Sdt2OSdz0ry9o4saNWZ9+vAaVhqGd6R
	ZEbZqK3RSbDnNHzdqQPNIb9u8ak8hpQCjbF+AQwLMrZJDuamIuf+eQu4cORhr8TC0S6+q/q0bOP
	nTvyVSVSkBS2LY5QtU5zIqm1hqFW3gdkcd73XsNlStrmBrQFGM0yVaE3Adq4FIEOw67f4jMNVlB
	cBpmWYLgOdwJeuoV6Cv4uJZm9ErPeeF4uIXjgP2XecL43dCStiH/DKzRg2vwyNyFGQhLFUQot/U
	McFw==
X-Received: by 2002:a05:600c:c4a5:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-482db492454mr175150545e9.20.1770108609900;
        Tue, 03 Feb 2026 00:50:09 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e61dsm49213615e9.8.2026.02.03.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:09 -0800 (PST)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 04/10] RDMA/uverbs: Factor out common buffer umem parsing into helper
Date: Tue,  3 Feb 2026 09:49:56 +0100
Message-ID: <20260203085003.71184-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16424-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E597D6648
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Introduce uverbs_get_buffer_umem() helper function to consolidate the
common pattern of parsing buffer attributes (VA or dmabuf FD) and
creating an ib_umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: If76883934c4020fbfc0cdc9378934244dc406a49
---
 drivers/infiniband/core/uverbs_ioctl.c        | 68 ++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c | 69 ++++---------------
 include/rdma/uverbs_ioctl.h                   |  7 ++
 3 files changed, 87 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index f80da6a67e24..581b0705b496 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -32,6 +32,7 @@
 
 #include <rdma/rdma_user_ioctl.h>
 #include <rdma/uverbs_ioctl.h>
+#include <rdma/ib_umem.h>
 #include "rdma_core.h"
 #include "uverbs.h"
 
@@ -847,3 +848,70 @@ void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
 		  pbundle->uobj_hw_obj_valid);
 }
 EXPORT_SYMBOL(uverbs_finalize_uobj_create);
+
+int uverbs_get_buffer_umem(struct ib_device *ib_dev,
+			   struct uverbs_attr_bundle *attrs,
+			   u16 va_attr, u16 len_attr,
+			   u16 fd_attr, u16 offset_attr,
+			   bool has_umem_support,
+			   int access, struct ib_umem **umem)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	u64 buffer_va, buffer_length, buffer_offset;
+	int buffer_fd;
+	int ret;
+
+	*umem = NULL;
+
+	if (uverbs_attr_is_valid(attrs, va_attr)) {
+		ret = uverbs_copy_from(&buffer_va, attrs, va_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, len_attr);
+		if (ret)
+			return ret;
+
+		if (uverbs_attr_is_valid(attrs, fd_attr) ||
+		    uverbs_attr_is_valid(attrs, offset_attr) ||
+		    !has_umem_support)
+			return -EINVAL;
+
+		*umem = ib_umem_get(ib_dev, buffer_va, buffer_length, access);
+		if (IS_ERR(*umem)) {
+			ret = PTR_ERR(*umem);
+			*umem = NULL;
+			return ret;
+		}
+	} else if (uverbs_attr_is_valid(attrs, fd_attr)) {
+		ret = uverbs_get_raw_fd(&buffer_fd, attrs, fd_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_offset, attrs, offset_attr);
+		if (ret)
+			return ret;
+
+		ret = uverbs_copy_from(&buffer_length, attrs, len_attr);
+		if (ret)
+			return ret;
+
+		if (uverbs_attr_is_valid(attrs, va_attr) ||
+		    !has_umem_support)
+			return -EINVAL;
+
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset,
+						       buffer_length, buffer_fd,
+						       access);
+		if (IS_ERR(umem_dmabuf))
+			return PTR_ERR(umem_dmabuf);
+
+		*umem = &umem_dmabuf->umem;
+	} else if (uverbs_attr_is_valid(attrs, len_attr) ||
+		   uverbs_attr_is_valid(attrs, offset_attr)) {
+		/* Length or offset without VA/FD is invalid */
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 380e4e4d6fb1..64c43dbd96ba 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -66,16 +66,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		typeof(*obj), uevent.uobject);
 	struct ib_uverbs_completion_event_file *ev_file = NULL;
 	struct ib_device *ib_dev = attrs->context->device;
-	struct ib_umem_dmabuf *umem_dmabuf;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
-	struct ib_umem *umem = NULL;
-	u64 buffer_length;
-	u64 buffer_offset;
+	struct ib_umem *umem;
 	struct ib_cq *cq;
 	u64 user_handle;
-	u64 buffer_va;
-	int buffer_fd;
 	int ret;
 
 	if ((!ib_dev->ops.create_cq && !ib_dev->ops.create_cq_umem) || !ib_dev->ops.destroy_cq)
@@ -118,58 +113,18 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
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
-		    !ib_dev->ops.create_cq_umem) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
-
-		umem = ib_umem_get(ib_dev, buffer_va, buffer_length, IB_ACCESS_LOCAL_WRITE);
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
-		    !ib_dev->ops.create_cq_umem) {
-			ret = -EINVAL;
-			goto err_event_file;
-		}
+	ret = uverbs_get_buffer_umem(ib_dev, attrs,
+				     UVERBS_ATTR_CREATE_CQ_BUFFER_VA,
+				     UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
+				     UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
+				     UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+				     ib_dev->ops.create_cq_umem,
+				     IB_ACCESS_LOCAL_WRITE, &umem);
+	if (ret)
+		goto err_event_file;
 
-		umem_dmabuf = ib_umem_dmabuf_get_pinned(ib_dev, buffer_offset, buffer_length,
-							buffer_fd, IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(umem_dmabuf)) {
-			ret = PTR_ERR(umem_dmabuf);
-			goto err_event_file;
-		}
-		umem = &umem_dmabuf->umem;
-	} else if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) ||
-		   uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH) ||
-		   !ib_dev->ops.create_cq) {
+	/* If no external buffer provided, require create_cq op */
+	if (!umem && !ib_dev->ops.create_cq) {
 		ret = -EINVAL;
 		goto err_event_file;
 	}
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e6c0de227fad..2f96edf395bd 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -861,6 +861,13 @@ int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
 int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle, size_t idx,
 		   const void *from, size_t size);
+struct ib_umem;
+int uverbs_get_buffer_umem(struct ib_device *ib_dev,
+			   struct uverbs_attr_bundle *attrs,
+			   u16 va_attr, u16 len_attr,
+			   u16 fd_attr, u16 offset_attr,
+			   bool has_umem_support,
+			   int access, struct ib_umem **umem);
 __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
 			     gfp_t flags);
 
-- 
2.51.1


