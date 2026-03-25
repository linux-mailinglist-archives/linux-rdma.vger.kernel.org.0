Return-Path: <linux-rdma+bounces-18627-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBbsCD/9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18627-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:20:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E9327C95
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B20DC3050A6C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362BB4014B0;
	Wed, 25 Mar 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GSsHn9bx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA1401494
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450867; cv=none; b=XYMoqknRCx/r3rh9ydx4Be5GiYOp85/J0UxfSqmC4eyOZ9WDfxckLzPqKsF76VtTm6M0QJMLhORnRL6aVM1PCejvgnuH7AoDiSsQZelnhniv7HbKQRrS/nnZPTLU5dWgMokpf5p53krZV6757sRGsMeBY/Ea7JbUyDqSNHpx964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450867; c=relaxed/simple;
	bh=1lTrqF+bPLqUum8cE40APOYnvmU+InaQrlun5+uV9ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QreUws64pepVYAFgfwLNsX/wxtGTRcOTeLLSvLQFOJnWTm9hA11qevLTzPmVuWYnKL+cPPAZmQhsZj7vY6WYdJRKVckmgtmamjLX4L5OBRuaIBbwqAXzPxFOaVdZIflMQRLYyGwSkuI0PQnVFgsrcj6pmXmWdOUDUn/MuQMY3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GSsHn9bx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9874675e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450864; x=1775055664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/HGaAICZLnhZVougIHq0dkitKTJIIFf6wW7Q5K8gno=;
        b=GSsHn9bxRWqI5Q+NeKLcBt3FZ4ai0G84wlQ87KqnbXnN1+D9hsBl5YJ8gHhcIztGI5
         8ERYnKRGRqo4IQOS9ofheFjKO75CIjAlAfdZQusaXPoBSbet0gdJ80mj5uUK8Y65fXR8
         3+vAYVwc/Am58eoIuvVC5CKQJrjFYNxFWhEiEffk48HSmkNDDJYew9fvwxPYwtM+2CRF
         ZLyLsUn9qJ1BMYtP30VXADKfwraDbBjqkW18ZoyDu3Kaz+Ha51qb2mPd8/XB4NTecbbU
         o9l9yCgAjXB4Rgyckhik1ilFmXh+Ioeb3jumQuJjZIzc5bh9oUsRqkRcV0WV0BTrkgu3
         b+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450864; x=1775055664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/HGaAICZLnhZVougIHq0dkitKTJIIFf6wW7Q5K8gno=;
        b=UkuaTC6c+WFlFsLPIQNW9eqTWpEcBUzuLs9QMyztL601ZQEKNIS8JbkfxCpolSNn9L
         xehncu0q7uAEJHyCBQFGS+7MIb6MEARQPchvJYe60SjjYOuKRO/gMuLOdbBLjFRabVU3
         ODlgSRhVu2t2BaILLWFUNYXYeoIw7ME5WwfDyzuTLCf20gd2XNSIbKdMCKSj0TScH4Ar
         /KpM826vldDIOFj1/waImBBMqSlf+yf3RDVs1E2VMYE7/0O8MSqvyz23dA4avuu1xAWX
         YILpWDorUR7W6gsXwIJgHoLmWKAwtstreJhDzgYjdNVUXffTc1UvDpN1uNIw60SQDcXO
         IvMQ==
X-Gm-Message-State: AOJu0YwN8CBmP7gJf1vyTsqxsFCtJjrAVjXgbR5HEFHs675CHazE/wH4
	R/w0J5g/ElcYtN2UbTHY8AnMskLnkL/9OeJ+iHgsiiaFb1o44OOQfgcFZAXGewxTRB/aLsdgOjI
	2/EGc3sA=
X-Gm-Gg: ATEYQzxAyYqXh0nox+0X5J05v+Gv8opTQJCvi7uvsco9iZHy+/aE1wwe099Vnysk9xK
	e7eL6RKs+5sSuSJh9XHR3YPEu6sl04qpT+6it0Cce+bpA+dHDOnwyKdegrR3sTncuZXvROsdCbm
	fVQn33dKR+QVo6svicz6Anr4mzCYrsSxglb6h0JWdoIPfUAlTu7LXFKg75lzNX6JLDb0jYZU+DU
	mhqZ6LEVxvJWKa1Q7xcEqLgM5KUaKh7FIk22MjWMtRWXSDc3zhv/1L3mfgbFVrNfeoluNDMJkGZ
	hMW8YxAT9n7KhaLeUHA5b/1aYnrxmhepLRWBSMWA7R9rmkNWIpBL1NVSEcdt70l/yvB5jbqK5wf
	JELSPx9J+skUw2J8sn8MCtJpdqfagxp+cK8MFdDn0AzaemPG7c8/QH6V0LS/ezdt+p7R73ogttq
	ZmCZ1XFPMM8vI5Eg==
X-Received: by 2002:a05:600c:888c:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-4871608eb93mr44529035e9.12.1774450863523;
        Wed, 25 Mar 2026 08:01:03 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e5d18f5sm958265e9.2.2026.03.25.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:03 -0700 (PDT)
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
Subject: [PATCH rdma-next 08/15] RDMA/uverbs: Remove legacy umem field from struct ib_cq
Date: Wed, 25 Mar 2026 16:00:41 +0100
Message-ID: <20260325150048.168341-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18627-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid]
X-Rspamd-Queue-Id: 9C7E9327C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Now that all drivers use umem_list for CQ buffer management, the
legacy umem field in struct ib_cq is no longer needed. Remove it
along with the associated ib_umem_release_non_listed() calls in
error and destroy paths, as buffer lifetime is fully managed through
ib_umem_list_release().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 1 -
 drivers/infiniband/core/uverbs_std_types_cq.c | 9 ---------
 drivers/infiniband/core/verbs.c               | 5 ++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 1 -
 drivers/infiniband/hw/mlx4/cq.c               | 1 -
 drivers/infiniband/hw/mlx5/cq.c               | 1 -
 include/rdma/ib_verbs.h                       | 2 --
 7 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 77874834108b..60fafa1fb7b4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1088,7 +1088,6 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_list_release:
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index f87cd11470fc..c165ff5446f6 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -209,11 +209,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
-	/*
-	 * If UMEM is not provided here, legacy drivers will set it during
-	 * CQ creation based on their internal udata.
-	 */
-	cq->umem = umem;
 	cq->umem_list     = umem_list;
 	atomic_set(&cq->usecnt, 0);
 
@@ -227,9 +222,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
-	/* Check that driver didn't overrun existing umem */
-	WARN_ON(umem && cq->umem != umem);
-
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
@@ -240,7 +232,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_umem_list:
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index ed163fc56ef8..35700bad8310 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2224,9 +2224,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	}
 	/*
 	 * We are in kernel verbs flow and drivers are not allowed
-	 * to set umem or umem_list pointers, they need to stay NULL.
+	 * to set umem_list pointer, it needs to stay NULL.
 	 */
-	WARN_ON_ONCE(cq->umem || cq->umem_list);
+	WARN_ON_ONCE(cq->umem_list);
 
 	rdma_restrack_add(&cq->res);
 	return cq;
@@ -2259,7 +2259,6 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
 	ib_umem_list_release(umem_list);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5c6fc81fad6a..e63780c78781 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3518,7 +3518,6 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 	if (cq->resize_umem) {
 		ib_umem_list_replace(cq->ib_cq.umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ib_cq.umem = cq->resize_umem;
 		cq->qplib_cq.sg_info.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 9db58d9bb8ab..21d8b2cbf5e2 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -470,7 +470,6 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		cq->ibcq.cqe = cq->resize_buf->cqe;
 		ib_umem_list_replace(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ibcq.umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 9dbced5a474c..29cb584692c1 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1436,7 +1436,6 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		cq->ibcq.cqe = entries - 1;
 		ib_umem_list_replace(cq->ibcq.umem_list, UVERBS_BUF_CQ_BUF,
 				     cq->resize_umem);
-		cq->ibcq.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
 		struct mlx5_ib_cq_buf tbuf;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index dd6c0d68497d..cf7fa69415a1 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1738,8 +1738,6 @@ struct ib_cq {
 	u8 interrupt:1;
 	u8 shared:1;
 	unsigned int comp_vector;
-	struct ib_umem *umem;
-
 	struct ib_umem_list    *umem_list;
 
 	/*
-- 
2.51.1


