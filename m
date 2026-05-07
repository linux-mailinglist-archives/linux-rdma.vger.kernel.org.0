Return-Path: <linux-rdma+bounces-20153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E+PElyL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979774E8897
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5148130427EF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAC3F0ABF;
	Thu,  7 May 2026 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="bdAePI1j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D03F0AB2
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158368; cv=none; b=DGUBm4GBOsHXxD+v43a+EByV5+6mH/AkppOORXR2PXVXX5uZnrOPcRzlYxWIYb9RLe6RvEcpNqDkOJMFgxCc+BE9yWpfQsRHfHU0EVezcNUEggDt9nb1HpxN6BjtD3tMHbGInYF26MELix0PkaQCvVzNABUQTg5zhwDc4cpWkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158368; c=relaxed/simple;
	bh=vhsTDlzopwl2O4tPO/XGe7oOpNz4avYjagtogjls5dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrfNA2GMQkJdo2emI7FFMGvTXZ2usQlV6rswDV/tpQUsf/8xUXTbuKPzwb/fcsTHEJ4TvbO0UTfUbGuJF26aacV2TbeAQNGLVtXJ5kYC4vzncOV9EZu1EmJ1Pnlm8ib0OHgOWGsO87mKA8Jj/WIDHNqxwEV21o0dKkNSlhIdf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=bdAePI1j; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so549033f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158366; x=1778763166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLex929toMNovb3KPjCt66k3LC6vv2Ptn/myeUGWoWQ=;
        b=bdAePI1jUaTLTV9+q0Q4YkTNYb0xw0T3n3yA02ywl6hBjTp0Jl8NTjtXVE9jD/I75m
         9KGXTUfYbWxgc21rdybbkaJSMAp9rTpmRDJMXAc+6lsZVfUlyILeukkYnK95A7pYXA33
         8X0H29E+8ht2W60krUoY4OzbQf67JDsOGtGaWPS+SZwsow/LoYHM0tNKSk22YevqAhAC
         VE6msfijUC0+aceXMAMzaqIdm/VEIKtD6Njjx5W3X0ZiIpiTObRObtXlg4hCfmt88igz
         kHSMyFHCTgcnHdKgAv4Il/T3fjj8x8cJe9k7MGlL4dGw3FKoQQVc+vz/63GSNCNOflCs
         +C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158366; x=1778763166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLex929toMNovb3KPjCt66k3LC6vv2Ptn/myeUGWoWQ=;
        b=EnIfvv1RKVarUU7EvGdr1xIMi2zu7ZL6SYPP2IVbgt6Iq/mC3tP5HLRzE0W3Wcemi5
         YNIfwoKPhe6uowMcOr7oacYv5JaqZiK8Ej4fu8AQ8ctZOj00s9qAVyZRrSQU2QTKU205
         kenDVEeMZ2hnOYWzjU+BAYoiczB3EJ4S/wEy8H1VV9H5CvjInbLKBUtZxuFpoTG8PkBI
         x3AQiiVaWQADVqRh9fUa9E7zFPzdFEfRg80sD0WupUwYx/m6o1fr/+hKMH/EIGH5/nUl
         N47Nx2nLNsBQDFJsCkSlodK/7MdG1GJWIGGroNJgf6Q68EDhyXXcPgQC9wCCz/Mw4+/m
         aBPA==
X-Gm-Message-State: AOJu0Yzf9VQ/Fp0ePMP5mDjRxte6x9ki5Qk2GMi9VKXcMxL/l5AO2ESg
	fh4izTb5BJ8qdNOpzN3rwm5Q1yDGtB9eH7TjdeLjIoAgNmkopI1qksCSYxep5+VunBrh6SZDmEO
	Ddssg
X-Gm-Gg: AeBDieufSyjXVqjl4CTZ3/Y/9LVZlkJaVmyztEHlhC0+GfqdBNizoP+l/oDoIiJvuTz
	rymoeaYtEyEudPNb8f8TpHk6nEAymSHv17/ukpy/wNaYuKw1SYocXyKcgJ0tWTgiD18/9fqIUYB
	hHHRRAPEDhkS029WJf1/kYDTwdBgshqgTHExZfpXO3StVKp4rqP/NDXweAl5P4U4uuS6cK9h+31
	6bhDZqvgwfgLou7dB4u+f3tooxRLhOt4I6Rp5SjeMfhrg0HuEQbTCX+yF1Btv72X3jsUbREaAG1
	Ks0qciThwbKSr1jH7w60vUoEtDJ3jAkxkJoLRwkCM+meGgzCQ994+K2PjyoIps+IRwRW5L8c+H7
	ApR8haAfaOPjvH+6/ygrZfmhTabe6nZXsXO4f62+1JoDu0z/waw5EUhBMFL5C/9u1HlCdfnsL4/
	DU8og0CImh6nzca2x8p0icW1rsTbww6qjm0t6FNn91g0JfVQ40S1UaVch+TbIu8BgPhsk=
X-Received: by 2002:a05:6000:2403:b0:441:2381:b630 with SMTP id ffacd0b85a97d-4515c575330mr12947144f8f.24.1778158365612;
        Thu, 07 May 2026 05:52:45 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm20273612f8f.37.2026.05.07.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:45 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 12/16] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Thu,  7 May 2026 14:52:27 +0200
Message-ID: <20260507125231.2950751-13-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 979774E8897
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
	TAGGED_FROM(0.00)[bounces-20153-lists,linux-rdma=lfdr.de];
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
index f407c4dc255e..80c3a6a68ec4 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -468,35 +468,6 @@ struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
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
index a768436ba468..240f8a0cfd86 100644
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
index 9dd76f489a0b..167fb924f0cf 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1738,7 +1738,6 @@ struct ib_cq {
 	u8 interrupt:1;
 	u8 shared:1;
 	unsigned int comp_vector;
-	struct ib_umem *umem;
 
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
-- 
2.53.0


