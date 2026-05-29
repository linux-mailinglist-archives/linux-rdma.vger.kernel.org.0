Return-Path: <linux-rdma+bounces-21511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKilMHOZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823D60316E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34BC330F94F0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A533B6FC;
	Fri, 29 May 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="DmoOD5mr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F12338906
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062234; cv=none; b=sKloVgF3FYQqX+hxGakfkfzVUOaKRb9Y2LN6f46DNksDxvk6QgAEGu3OPYckJEBwCrosqdeOX3YXgQTuIUDLdhTc4quP4LlNNxBuhJh4uN/f+dZNkbuEkZFRQlyU9g/zwNivCVDIXTwMTVoMpKyFK3iefw+x5EErj6mw5Qwh0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062234; c=relaxed/simple;
	bh=MNCi2V/FiZPZZYwF3A+Ih5UGlD3+4tB+7jFbqCrPvTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeX81+IF+48o0+sHjKsjRWcgVSJDItqg4yV0SCmn8k7xZrEIniKEBm9eAxGW8hCZLsJOpVG75h39TiEqY5Wjrsr16IszVuqQOKNZIQrwioGVgCLnX8Z/X5PczkBv05PmFUu/SAKUAaH1SImtKxe5sYwCerqoJ7xF6uOXnyLFuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=DmoOD5mr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef4223be7so351454f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062231; x=1780667031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lefASPGl126/P0qKbYoiAvc8H8UkNkTWTI7MaDX9LEc=;
        b=DmoOD5mrPzabqMDyGH0fHOZy88968K4PC6TrqCDTAFWHRgsQhWjPaaCRJZOjiie2vQ
         3oIzHXGLqQfxg6n4YgHvp5vBj/QjE3yqQESVXnTz7rBuO/JxOsb11B+vJbbRI9YlSmU7
         fiUFKOb/BBevFcVbmnGESg+QxsKW8/Y08tE2E9v2k80qAQoaHRDiCPeQ5W1U22eEsr1k
         jh2m8bghaiNrxg+t//j8LpNnZ4QLhgW4H/q4AYDoaB8hmKBeNFlFJtFhGmkr23ahMsLa
         /uH16fJcT9QS390Liy2+/x1Vh00I7zglIdLNovsbDVd2m2jSAybvtuctJ5I2AQiLkvsf
         n/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062231; x=1780667031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lefASPGl126/P0qKbYoiAvc8H8UkNkTWTI7MaDX9LEc=;
        b=JAGRjcJcNEEtK2saUo90Oj8sjMYbhiQSukiGE/xH2NE2A4L09MEg86ZWpCifsa2YJm
         aM7LD5QA2wf3rcmyjfgKFQUoaoZULqK8RFhepMCfyPiQ1nZkkeY4XCE0U+sl6E4OoaUl
         CCf8qWH4DtKeeaGe/GqTFv4LEUT87iir0ooDzLGPb2k9wDQPqwo+aYwhQRjPJOC5wwgP
         1W0js7aADFoNSBqw0GWD2WnZ1GtTXcrA2dy043k5RJUDr1T4AUh8DEpHZ9dDTQ9zAYtN
         +P4tFkj/t1jksKzUaPdU2q/FWWVdnDgX+RjigvzKHcYWHuWdVg38b71tz2qErlzOAOHI
         VS7g==
X-Gm-Message-State: AOJu0YxUMJCZVrMEc+XYLl/JQmE3s/0MA9x1zYRPozSDKvOdNjlnhmNb
	e34WyYi3/0Ktwts78xlOHD4fVFJFZirKZXZPE/JF0aaeJ5IL2dSVFN/GOzm4exjTAoucCWCFsoY
	/gPQnflIYDg==
X-Gm-Gg: Acq92OEZsosazMJJr06OMRAG0c+qorUHUwgDu5RwMge25Z6FrWsafC8+ABEXKGbUN9d
	TFdQB/Km8iq9slu/MDMJDDc4HqWX291KO0E8z+95TnBwX1X9WxUFgN83Z9QUYCsZi+/jkMWDiwf
	f4nVEhvDr2gVEbWCiyFUe9npC6iW1F6AlvxMH9FSZ0TkhsxYypFFAtzC3Vi6TlEgCIKEiKAa/W1
	Q+feDqlMSqaskRnYlmTR9LKujFrtF6LzxhHaJE0OUYQCbw32HzlAot8smPbNnbvQYNYS/qGhuVe
	LfCDW091h4Fmk8WqQl/yvWgsNBFqPcsBifF0AC3A4XGCQWsOZkh1uLh4Pp8mA+HFweWwlKq0aSX
	Q1fabhEn/wTuuZm+f1GM0UlvibAH7xnb6VlUWZb+MYlbvGGeyk7qZjcr24xkF5IpePDLFqXdITv
	t8+I8i4185XOgJK80DxahqQTklUr6pPEasSGd3iNR/EG4=
X-Received: by 2002:a05:600c:348f:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4909df1f2c0mr43307095e9.28.1780062230967;
        Fri, 29 May 2026 06:43:50 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6975e2sm65573075e9.6.2026.05.29.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:50 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 11/16] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Fri, 29 May 2026 15:43:07 +0200
Message-ID: <20260529134312.2836341-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21511-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:server fail,resnulli.us:server fail,sea.lore.kernel.org:server fail,nvidia.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 3823D60316E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index b3261b924a71..89311fe65619 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -602,35 +602,6 @@ struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
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
index 32914007bae6..86df7ec83b3a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1084,7 +1084,6 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
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
index 492c8d365730..370d802f0e63 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -96,8 +96,6 @@ struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
 struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
 					 const struct uverbs_attr_bundle *attrs,
 					 u64 addr, size_t size, int access);
-struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
-				   struct uverbs_attr_bundle *attrs);
 
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
@@ -229,11 +227,6 @@ ib_umem_get_cq_buf_or_va(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-static inline struct ib_umem *
-ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 01e0eea0703f..893cb5b73951 100644
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
2.54.0


