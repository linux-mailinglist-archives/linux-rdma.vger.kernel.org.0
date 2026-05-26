Return-Path: <linux-rdma+bounces-21315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DrsNR+zFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C65D7EC9
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DDBF300D95B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1080403EA6;
	Tue, 26 May 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="0AiyV9hu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E8403E89
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806559; cv=none; b=QvMtMCZcorlEEWTFooAgy8E9ON1AWJgNevivrdLScam48fdgyPz0qKdB8EaHfmqa7agw8vjjBxXEi/stjNc0/QfzAkS+j9NC7hqgtGrr52IdFGwzVMpCzuUxOGFbG8Xnz05z0PSc/h5yQwYzFzIJosAsUxOCAUC7xDStB9pzrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806559; c=relaxed/simple;
	bh=q7y585gOaCH0EOywjV2DKcQ/1Hhamk/ZphJ99yFCx88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwjZLUPhT1tWf7QhA74AsNtShVACaE07f2kKSA0QHBouLFOpKvVD/EdiK3LBAL9zLgagt6KTezstoTHmqwVUm7PdO3zVbPnSxmlRW4qsc7/eGFKBXqHmIxYW4jYup1NAmQWxgDeK9kDreE2xjax/PPNybesh3sSy6QjB/G3tXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=0AiyV9hu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49039a8851fso51413415e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806555; x=1780411355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX4EpGwuWpfZBFoOxQKoiapYn9Xq8sgzJjREcLAP1Zo=;
        b=0AiyV9hu4CMMFkuqbVllZcxFuSeL48mbQpaFgYk53rGvwY7iVp1eCmPeqblYaAapBj
         zX99z4+Iv5PxW9vIjz5FkINNvy4DUuxNugo9yGcszl7XuE7FwDR+45Y+gAy6hYpp/qJr
         YQKRBYgGnsQE0V3LxVszbJL+Omw1CMoSzSVYqioYJP/UgIB4qH5Cv9/vX6/IL1ltlqQz
         DnBtPln2URsSkcKJpfrs5pptSk+5xKJED4NfSYO3cEdm7AtC3hhbjfL7gkeDkkNwCYMP
         lFdB/dDu7Ko+bXpUKkE+gQkU8lhFM7gWZTu1+W7T6nXLFzBRSLtr00JOlwwSe7JtTwtS
         qkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806555; x=1780411355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QX4EpGwuWpfZBFoOxQKoiapYn9Xq8sgzJjREcLAP1Zo=;
        b=EWsdS+KwvjPQzXMUIMyI4F7RWrTCcRigigLgXsfjSHTfIgstpnK4ZsW6oCfOrx6DNL
         d9bjmwORLIKgqG4ayPx3Hm6vrXpiJDI2XLFAXne5R/EoFp2aUxXRpMBHOnwOkvT/MuQM
         hjNwwTYOwOJbwjnWixpBm7Uot2f0fHgut/obmEuWlsYcQma3CxRajt6wCjc7XKP5Usx7
         K+Evh21UunRt4kXU3E8lE2TtfQvQriReUjd1sRRG1I2rPT4ztMUVQp4JP8gba9EBdpRd
         DBA+CMWpaxynkFaf8V4hnMfYLSiRyKOt6IeTqMstQA9oClMd5tpe6H5c0it0JIV0of2N
         AGYQ==
X-Gm-Message-State: AOJu0Yz93EH+Lb6DNDcrwLuc0o1QhvroegqgSlzFf65h/8Qkp4Mh5dJs
	280L7FUeHGKjIIEuZw4Btoig3OZ71sxnxg1xBdUlwOh8tm//znQoBf4SfZGmvyNgPnNOeDolsaa
	xM9jXnaA+sQ==
X-Gm-Gg: Acq92OGqBjjUl6+VEV+KxmfPuIXk+zZ+Hd+2VF6vUwoGvGhq3iP5I7nST+4csStW3Gs
	USSp3fHCuViGL9zYojQmsBtIi5oqfAzcLOYTozPRjyA7JgGciWiI9ZMPPj3YJ1w7Ed5LlTiXU5c
	dwK+cQokQukNVpifK+uCn7uXY0QMnq+JlXDzsPlAN6so0ghyoA4MDylzGKqg0KrSd6y4UXchjAT
	/XJCoGaDXn/q/UatNd7iIlAqzo9HJdV5urGagICM+MC8m5hDtwlfgbpxLm6mnjfv/Yi63opEOai
	7YqIihpkwLWAfgZJoMplN3rlPWs6zpEVktsCOalpva1e9wIpqvN8wUYfjo/Pgscfjhjnu/yxRrl
	iCDNrv8ulVkdVrjdEsffuF2McpGiclmmuef0AU1R58DqqcXCL91npAudZvhNEZ74tYSnjWbB3Tb
	2Sd8I8tFP+UWl7gP1w/UGZZh6MvF+/Uyau
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490519170bamr261172975e9.18.1779806554904;
        Tue, 26 May 2026 07:42:34 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d63f8sm110912095e9.18.2026.05.26.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:34 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 11/15] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Tue, 26 May 2026 16:41:48 +0200
Message-ID: <20260526144152.1422310-12-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21315-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC7C65D7EC9
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
index ec117aaf337d..025f6950a1eb 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -589,35 +589,6 @@ struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
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


