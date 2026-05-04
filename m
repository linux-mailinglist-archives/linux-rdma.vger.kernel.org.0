Return-Path: <linux-rdma+bounces-19925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OeSMLWm+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EB4BE581
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D4E3053DD4
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499934753C;
	Mon,  4 May 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="MO7neBQp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712033DDDD6
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903078; cv=none; b=HDu3oYBFcZUqLYg1VS5aaEVuJieVorhRgTuT3NwjLsz/Du2IAYbWV+ELOiEuWadKIDmJ2nXWk4fV2laMiOxuVBldQFy9be2ARM+Gtl8+ymoXmvVMKJCdgHgGkHl1vwGKlq6lydhTOngZPbdLdbkOsu7NAqJ5Xfxi7YK4ynzN2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903078; c=relaxed/simple;
	bh=Cvles9uFUzEeNxA2FpWegDVVerNdUiy20WYHFOOs8/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7NhaXeNK7v2gkND2gV6sFwOjzRMnxm04fj3kvZ0DyaTd1y2B+yBljqTmtzamWJ+L1nnQHBfU4nNq/rZaxWImXwr1vzJEwPDIkceTv9pyXN3NXUyWInzbl88ZisWqtAGu1RrrUdIRMJrvUYdNAFG/OpYA3G9MyHOGw3sFdc4Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=MO7neBQp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso51688745e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903075; x=1778507875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA1lOLpbGDfkec7O/THi5p1zEO7TEcy1/4BaA6IgNzs=;
        b=MO7neBQpIPzsNscwbMwwOtqTH1KegRqYOSEqjS9kE0cZsRmDSCwFGZdexCr5AP2gqt
         MA6nctbtqy4s7EizITrpHdF2HE7/kUDM4vnG6CRc3FydahyWfl2Vh3Sfc+cUnK7QfRog
         JyfL6n828BnxOTQta0aAHO4+YRnDwiLlba4h5U486QFqs1Pcaa7OT74xlJSsKJhrZc4B
         fPgyKPdsUoge8mltMvxpz0uZkGmv2KL5v0Q7Gjz79c/fIeOsmzHzPc75ow19StgrcekE
         5iRfyeShhzCja55bfTOl46ZQalUdOGpfrZP8ayk67nJpjR97e8zPC7x3rii5bJAc+hJi
         cUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903075; x=1778507875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aA1lOLpbGDfkec7O/THi5p1zEO7TEcy1/4BaA6IgNzs=;
        b=l9aq/Ke+MuEGE6OiIZ3iVD2dYdsenxJXdnDeGEyVl/XjAfu/TGFSm9+67YqLFB5Qel
         N7v+bWBtsg+E14e/x+5kCZoDOwT2mWRtIizir1wrsfvFT/UvJUFh0SRqNNhImVuGsBOF
         mBpkJvO4J95HPJ2efQmhaxV4iFUnG38VLbbU0C49hY4V950lV0ztxpxtpX+XO2XwVE9j
         LzqmTNl7FQHr/u5fjrSs0F5m26/3gVbj5qeiVXgdG9Mj4th6P/lH0RAMoEO1K7T/HP+E
         w8dGoUvaJ+zBJ59NkbE1IHb1P6SiXXXuRMCJAsCNIJR7lohqU2TO1ESXp2b9nxo2cpPS
         h1+w==
X-Gm-Message-State: AOJu0YzUTCQNIDap4wGfEratD+VdOWks1EsDm6oYOFq+BtA7yL4CDa6g
	D0MzvOqxC0kuXM3LbilOMH5L/B2TpeQgxAVhsy+qujV8wVOj1zqxbWH7wq3GRz+VciIdSnV46eR
	noPFFtY4=
X-Gm-Gg: AeBDiesE8iTJO7z+VlcukZ7E1sVsZuD+5lMdfHDGWqy5xK8r++pUtBPKHEHIB0g9QT2
	ZfG+QnZwh2U2YGqxTSLZ0eO9ckAEUtuXhBfMVaCaxXDx3X7sNjhSCFQlJWC1d1nPEdNqzDZhoMk
	yzJraMLpaeimtQXsRakwFQH/9cEuvQfPRhaPB/U0Zqj/XqbV8bll3v09RPkSS9GBZzvcy02KCHO
	iJSg4wpwRFhYc7PjqYFK4IoL/hMinCPT5mqj9NUy14TgrT1AMKQDVkPyj92DSbcJ4NfzhhKEaO5
	242J4WDbe9Qy4u4NZ1Bu1M/rCp7TWQpJJzwSm5ldbwCYMPkR3etHm2b4XBp308ZOwjTJ7VEvfWo
	FxsRnZ/EOmgaq05HJLjykeaFJ1rQwHj0PttLd88xLYeqpAiJDkAAZYDynnF9ls07Rcdkm/4nN6Z
	wA/rNXNXhC/X2BBx1yLrt2NYjs
X-Received: by 2002:a05:600c:a40a:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48d09ccf58fmr59393715e9.23.1777903074853;
        Mon, 04 May 2026 06:57:54 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6b89sm328172355e9.1.2026.05.04.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:54 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 12/17] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Mon,  4 May 2026 15:57:26 +0200
Message-ID: <20260504135731.2345383-13-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 148EB4BE581
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19925-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]

From: Jiri Pirko <jiri@nvidia.com>

Now that all drivers use helper to get umem and manage the lifetime,
legacy umem field in struct ib_cq is no longer needed. Remove it
along with ib_umem_get_cq_tmp() helper that populated it and both
error and destroy paths.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of umem_list removal
---
 drivers/infiniband/core/umem.c                | 29 -------------------
 drivers/infiniband/core/uverbs_cmd.c          |  1 -
 drivers/infiniband/core/uverbs_std_types_cq.c | 17 -----------
 drivers/infiniband/core/verbs.c               |  7 -----
 include/rdma/ib_umem.h                        |  7 -----
 include/rdma/ib_verbs.h                       |  1 -
 6 files changed, 62 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 04684411c82e..b1877b83b021 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -475,35 +475,6 @@ struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_get_cq_buf_or_va);
 
-/**
- * ib_umem_get_cq_tmp - Temporary CQ buffer umem getter.
- * @device: IB device.
- * @attrs:  uverbs attribute bundle.
- *
- * Pins a CQ buffer described by the legacy CQ buffer attributes.
- * Returns NULL when none are supplied.
- *
- * Will be removed once all CQ drivers have switched to get
- * their buffer directly.
- *
- * Return: caller-owned umem on success; NULL when no legacy attribute
- * is supplied; ERR_PTR(...) on error.
- */
-struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
-				   struct uverbs_attr_bundle *attrs)
-{
-	struct ib_uverbs_buffer_desc desc = {};
-	int ret;
-
-	ret = uverbs_create_cq_get_buffer_desc(attrs, &desc);
-	if (ret == -ENODATA)
-		return NULL;
-	if (ret)
-		return ERR_PTR(ret);
-	return ib_umem_get_desc(device, &desc, IB_ACCESS_LOCAL_WRITE);
-}
-EXPORT_SYMBOL(ib_umem_get_cq_tmp);
-
 /**
  * ib_umem_release - release pinned memory
  * @umem: umem struct to release
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 30fa08d12feb..2a70774c639a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1079,7 +1079,6 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
-	ib_umem_release(cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_file:
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 05d1294762c0..148cdd180dab 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -68,7 +68,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct ib_device *ib_dev = attrs->context->device;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
-	struct ib_umem *umem = NULL;
 	struct ib_cq *cq;
 	u64 user_handle;
 	int ret;
@@ -117,16 +116,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
-	umem = ib_umem_get_cq_tmp(ib_dev, attrs);
-	if (IS_ERR(umem)) {
-		ret = PTR_ERR(umem);
-		goto err_event_file;
-	}
-
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
 		ret = -ENOMEM;
-		ib_umem_release(umem);
 		goto err_event_file;
 	}
 
@@ -135,11 +127,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
-	/*
-	 * If UMEM is not provided here, legacy drivers will set it during
-	 * CQ creation based on their internal udata.
-	 */
-	cq->umem = umem;
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
@@ -152,9 +139,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
-	/* Check that driver didn't overrun existing umem */
-	WARN_ON(umem && cq->umem != umem);
-
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
@@ -165,7 +149,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release(cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_event_file:
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc67..de7d19fabd75 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2221,12 +2221,6 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 		kfree(cq);
 		return ERR_PTR(ret);
 	}
-	/*
-	 * We are in kernel verbs flow and drivers are not allowed
-	 * to set umem pointer, it needs to stay NULL.
-	 */
-	WARN_ON_ONCE(cq->umem);
-
 	rdma_restrack_add(&cq->res);
 	return cq;
 }
@@ -2257,7 +2251,6 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	ib_umem_release(cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
 	return ret;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 174788a0640d..e5a0bff2c4bf 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -98,8 +98,6 @@ struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
 struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
 					 struct ib_udata *udata, u64 addr,
 					 size_t size, int access);
-struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
-				   struct uverbs_attr_bundle *attrs);
 
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
@@ -227,11 +225,6 @@ static inline struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-static inline struct ib_umem *
-ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
 					     int access)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b4291ae12922..d06071b87d96 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1739,7 +1739,6 @@ struct ib_cq {
 	u8 interrupt:1;
 	u8 shared:1;
 	unsigned int comp_vector;
-	struct ib_umem *umem;
 
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
-- 
2.53.0


