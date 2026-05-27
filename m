Return-Path: <linux-rdma+bounces-21391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAR6ENolF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D25E837E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E188A3069F3E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5844CAE4;
	Wed, 27 May 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QPL5VSOh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09344CAE0
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901833; cv=none; b=OFg0+XC8xbw37BCxRbSTwP8Ve27LATPJ8v7dVf/+NKhmcaYaRiu5Fh9cIeXUBEOcIHvW56EIhIL2ZzDCxrxwFo3FD69k0l0dsGI4cuJLFjSSTZDVfZ/j6QNXH8aab9LxvD1zZ63liYj0krsuLuIwKzO7cSRPklWsyi192isNQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901833; c=relaxed/simple;
	bh=T1jHZLdY0ODBbdhfgdCmElBMuuNQ1TcWMSMWPM7M91I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBudcWsRC/5R/t4SOA9C0TCdyOr8txo0qLob3Co1uXR/kSwALK/pPP6uG80ZhHNhSsgTBCfMEqQAwPQke9GgdqWZ9S15lB9MQU9UHB+ukbb541wiQAl7qr9dFnUXpw4tBY8pMPbX/mP02PNMQykSgcIREw+/0t8uA3V3LGMLFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QPL5VSOh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so125865375e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901830; x=1780506630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q17RsNy5iguZ/m6Mlsyn+qkmTTvK2wwg28R7Ml1yPlk=;
        b=QPL5VSOhfkWpxZIFktls/uhbyKA/bQoCLNBxn7lHbQqC7STtQK0Jhk4P1ZYGVJuG0+
         Asllu0VCggxKxudd50UZvnxD27ptiX6jklIP1WjrbxJ4QKcfnpL210IDX39brGt5P+qo
         1Cn70Pu/SbSMSvvI7+rwHOZFpdS5headlzwKyabQUSwmPyvvFO8/Dyr2AyxV4zkiCOEG
         kmyv2l6RJ64ZMjCKn8n0uoRJpLnSzTMMIIMC9VsWMUbyB0x1pLjF7TNBlZTExh13QTze
         uBQ7UGf1Wax7CB/UVQGr+BgpDM5z/Egcj8oRgM4wV26OV925L1itBsTdGyQwMD+Bhvb+
         Kobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901830; x=1780506630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q17RsNy5iguZ/m6Mlsyn+qkmTTvK2wwg28R7Ml1yPlk=;
        b=otDvBYjmEDKEiFHEjMwsJ2DYjAC2ics3uchDO+JIv7ZxDI1F7mv5ekX9HsJOacOa2i
         d/KskgzdYGDI896/ZC7BXqCUKLL5bX+1Hfw74q0t9iE/iDX9i8qMffdaEsWmbBYZG4TU
         I5EeIOn4iK7zPD1H+TtZ+x6Gku8tLmI5MHdyIXPaFD2A2FxWxePjMSrpKLxtc2jlCb8r
         N2mTH6WAG6+WG8yUdc8Xv14JGLeFdl7URzRPTJoi4i1aGijwt9ewFNvH90gOmDaVQr7v
         V1Edt9A6Co3Yy25liGlMRw7A8NAIgPbyX3W6P4a/AyBEhiA4x9xJUu7UeFCVwqBa1PAi
         RLGA==
X-Gm-Message-State: AOJu0YwmhheML0uu5k174pj0XtzZOKXWB1yug/wj0KQlh1MegawI6y5R
	0F1tzovtfyFbgQ2POR4f/2NNbx4o0CIWt253dI3DAEBFMxnT107kgyEaBZ2c0Rae1oKKi+CKoPT
	eQZLJ3nywjA==
X-Gm-Gg: Acq92OEaVxdgfE7OM2LfLPhdvBR9tm5mnIf8eoOk/EQJN++VL16Aad3g4s6DusEPgVP
	Xe8TJarTsRpsgBReYtvhOLjGtUqJz1V0hcmYVAhN7u/ZyC45DuYaU7TWn/Vs4bjz+houRpzB3DU
	qmdRySUu1ZxEBCPBr0E88Tq3wvfu3kwueiNFe4vs5mkt2MUyFQ+yDXtRONPv4WV5dwEYTEiCZcK
	wxorq8cQt3/UCIsemQXVGarPBdQKy9bGvUoDBiJFKBJTtZAwzOAKGwmUcJFC2fQS16Ac+uEDTzt
	oKz4ae9bjzG2Nl0o88cst7r9VQNfv0wdI2O03x/bWXPhPSuQcc3yqOFAm19maSs0/Bx4o25kB3a
	IRKfHwwvm5lBH4ru9yjQxuEO9sJkRwHXksg36DLZTNsvDEBna3Az7f4+OWAjNS64OkDYlCXSEHQ
	QXfBRUEcgISo++dmcQH5GrR7Mzih9bR565I5LgJfBG8g==
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr182770885e9.23.1779901830028;
        Wed, 27 May 2026 10:10:30 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a160sm468417975e9.9.2026.05.27.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:29 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 11/15] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Wed, 27 May 2026 19:09:44 +0200
Message-ID: <20260527170948.2017439-12-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21391-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B48D25E837E
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
index 4022657b42e6..4ce7fbecf3bf 100644
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


