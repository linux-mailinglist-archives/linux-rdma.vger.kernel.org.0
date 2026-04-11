Return-Path: <linux-rdma+bounces-19230-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OY8O7Bf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19230-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FA3E06CE
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8396730160F8
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F1246774;
	Sat, 11 Apr 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Cgh1x75p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2122D3A86
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918965; cv=none; b=Gu2KQ2n3nX3vUen/uJa33NkAnQlMh7qDj+0w7ztyAfUk1Mt3Ixn9WiW3UN112Cy4f53DRckhXmejO5juApupjhVPkfmvDiEL0XS//WRRi8EazKjNyLWeil7QUvlMlwb8YZzZKQMa2MA5rqdvZX15AmojEU+fcGUG7YNeV6iLcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918965; c=relaxed/simple;
	bh=i3BWk9nT6QRtyD589GzMMvzZHzOAirt7Q1h/GO+LlBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acU4jlnkRkRwVrjLs5yZWBoDNYyP08EprJO7/ISVv0Q75OMKEkyobI60wEr+QZc5QabeYRBCT1glP7p9CqHJhsnWZsaJviN3ciAUi6XLEpvQrXETh6FI+NXvW68d1vsw7Pgo45602SZVApjqyMZ7h3lHunxUfN0BqN+tZxzRdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Cgh1x75p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1864101f8f.1
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918962; x=1776523762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNlzD/sJ3x73XhNVjbdZYMNSspOvxqGP66ZAFax5gB8=;
        b=Cgh1x75pCmIZ4HDwFCAYHSiEHQ3tqdg9tunhBU3bzJ7D1xmjELDBbw43PArydIdqZM
         hm0fQ77yfDfSTyGm/++oNxjSWZ+HacDQU/yaSzZTlM2LWKA4ZGXu+NWx1Zf9/us67p98
         fmQA/VeiDr0lx7SCz4NIb6fl7c+WjHg7ioip32iMn/6GljiJhc/K+UwrUXAc3JhR7X83
         pqJaJmNoGyCRoIcLDroXJopj30jdruN5HFrvZWkAB0vfA+dS0cD+sLhhuWscxoBPEneb
         UxexVyVa6jxBxp+dpu0lvcMwsmupTRjPHJdafhLWq3QpVrS4U9fbp9YoJnD03+r7JXC5
         fehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918962; x=1776523762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNlzD/sJ3x73XhNVjbdZYMNSspOvxqGP66ZAFax5gB8=;
        b=T6JGlSvSKeu4KNo1/oc87rSAMsqn28fRwp7n3h1tJrAbJz9zxn81r6gkWc+CiMalrk
         DMcN9qptdS06ZbB0WB1BeGcY4XrqMHTX4t+iBLqK1CdlyBeKUUBgOVaXwVWP8uMQXqxH
         ebfMbWdqeiCM6I5DzmsqYbd8Kdo/8gTkxUq8gilpt1Nnw4Ys1XR2+UQE2WM8lZzMpdUS
         TpZ8w7vRTm7RiVmdJu0btcwUCFOKJWN4LSjBV0Ggp1X6Mx9Q1s6ieaXWsetaum70OMYC
         WjsIHj8TheBO+uDRqFLKd+Yw4we9zAo29fBkTvrVVwxnJa57CwS4Upeo0E7tTqoNQiHd
         RMYw==
X-Gm-Message-State: AOJu0Yy7VqY9t56pi8P03oGfv9aiKXks6XxVAkZAc6QBk0bMlek/1Yia
	jG0a7jcnJjDOXqxtrSGZjlLvM/fVf1UNg2ppdH6hNjISH9GXBryZl8rcLzwNpY54Oshnd/j1k0K
	FOIGP
X-Gm-Gg: AeBDieunjVORWyKqeLyNmQiO5bgtkrzgrrt8yblaRI2L0Jrs7X4HA4WKjmdVaFXikQE
	XV7/8NVX/XCMQBO3HDIb5aEMuOTp/YZVNpqc156gVEhkoFn+DcRDfmFMpUiNYG5cUq+mr2JlAYS
	Y5vqnHXSwddrYM1qoKOssL7hcRABnxOFUl5q3BMjlGveltuefj0evGvmKBxNujKuA+3j+J5jNO4
	V87R2d+o3P8WTnsPne7lehpLBePF3YbWOTlWbkJBJh7bKFpHXaZl71kmgOlCblhwIpyXR1RqvYO
	R276pF+JPHSeYJ5Ixl5F97mkZBIZBW0A+flLbw4dEpHzYC+tZ5eKGn8jL0B5GB/Hg3SDdNSK+eW
	4HtvMg15HIxqT5mlSXbihFjO2rJnehjOgTmC9CITU9iGo7eDogWAACqxexVWcxOTg4KH64v/dN0
	UirkwpfpIxyCcDn2ppz7wKnG8CPFQzSEFOktBzit8l0Kc=
X-Received: by 2002:a05:6000:2504:b0:43d:677f:cc6b with SMTP id ffacd0b85a97d-43d677fcdbemr7663625f8f.5.1775918961653;
        Sat, 11 Apr 2026 07:49:21 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm16732152f8f.24.2026.04.11.07.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:21 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 03/15] RDMA/uverbs: Integrate umem_list into CQ creation
Date: Sat, 11 Apr 2026 16:49:03 +0200
Message-ID: <20260411144915.114571-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19230-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 623FA3E06CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Wire up the generic buffer descriptor infrastructure to the CQ create
command, with fallback to the existing per-attribute path. Add
umem_list field to struct ib_cq and define the CQ buffer slot enum.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 15 +++++++++++--
 drivers/infiniband/core/uverbs_std_types_cq.c | 22 ++++++++++++++-----
 drivers/infiniband/core/verbs.c               |  9 +++++---
 include/rdma/ib_verbs.h                       |  2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  6 +++++
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a768436ba468..77874834108b 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -42,6 +42,7 @@
 
 #include <rdma/uverbs_types.h>
 #include <rdma/uverbs_std_types.h>
+#include <rdma/ib_umem.h>
 #include <rdma/ib_ucaps.h>
 #include "rdma_core.h"
 
@@ -1011,6 +1012,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 {
 	struct ib_ucq_object           *obj;
 	struct ib_uverbs_completion_event_file    *ev_file = NULL;
+	struct ib_umem_list	       *umem_list;
 	struct ib_cq                   *cq;
 	int                             ret;
 	struct ib_uverbs_ex_create_cq_resp resp = {};
@@ -1044,16 +1046,23 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	attr.comp_vector = cmd->comp_vector;
 	attr.flags = cmd->flags;
 
+	umem_list = ib_umem_list_create(ib_dev, attrs, UVERBS_BUF_CQ_MAX);
+	if (IS_ERR(umem_list)) {
+		ret = PTR_ERR(umem_list);
+		goto err_file;
+	}
+
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
 		ret = -ENOMEM;
-		goto err_file;
+		goto err_list_release;
 	}
 	cq->device        = ib_dev;
 	cq->uobject       = obj;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
+	cq->umem_list     = umem_list;
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
@@ -1079,9 +1088,11 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
-	ib_umem_release(cq->umem);
+	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
+err_list_release:
+	ib_umem_list_release(umem_list);
 err_file:
 	if (ev_file)
 		ib_uverbs_release_ucq(ev_file, obj);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 4afe27fef6c9..f87cd11470fc 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -134,6 +134,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	struct ib_device *ib_dev = attrs->context->device;
 	struct ib_cq_init_attr attr = {};
 	struct ib_uobject *ev_file_uobj;
+	struct ib_umem_list *umem_list;
 	struct ib_umem *umem = NULL;
 	struct ib_cq *cq;
 	u64 user_handle;
@@ -183,17 +184,24 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
+	umem_list = ib_umem_list_create(ib_dev, attrs, UVERBS_BUF_CQ_MAX);
+	if (IS_ERR(umem_list)) {
+		ret = PTR_ERR(umem_list);
+		goto err_event_file;
+	}
+
 	umem = uverbs_create_cq_get_umem(ib_dev, attrs);
 	if (IS_ERR(umem)) {
 		ret = PTR_ERR(umem);
-		goto err_event_file;
+		goto err_umem_list;
 	}
+	if (umem)
+		ib_umem_list_insert(umem_list, UVERBS_BUF_CQ_BUF, umem);
 
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
 		ret = -ENOMEM;
-		ib_umem_release(umem);
-		goto err_event_file;
+		goto err_umem_list;
 	}
 
 	cq->device        = ib_dev;
@@ -206,6 +214,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	 * CQ creation based on their internal udata.
 	 */
 	cq->umem = umem;
+	cq->umem_list     = umem_list;
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
@@ -231,9 +240,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
-	ib_umem_release(cq->umem);
+	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
+err_umem_list:
+	ib_umem_list_release(umem_list);
 err_event_file:
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
@@ -281,7 +292,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
-	UVERBS_ATTR_UHW());
+	UVERBS_ATTR_UHW(),
+	UVERBS_ATTR_BUFFERS());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
 	struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc67..ed163fc56ef8 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_cache.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_umem.h>
+#include <rdma/ib_user_ioctl_cmds.h>
 #include <rdma/rw.h>
 #include <rdma/lag.h>
 
@@ -2223,9 +2224,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	}
 	/*
 	 * We are in kernel verbs flow and drivers are not allowed
-	 * to set umem pointer, it needs to stay NULL.
+	 * to set umem or umem_list pointers, they need to stay NULL.
 	 */
-	WARN_ON_ONCE(cq->umem);
+	WARN_ON_ONCE(cq->umem || cq->umem_list);
 
 	rdma_restrack_add(&cq->res);
 	return cq;
@@ -2245,6 +2246,7 @@ EXPORT_SYMBOL(rdma_set_cq_moderation);
 
 int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
+	struct ib_umem_list *umem_list = cq->umem_list;
 	int ret;
 
 	if (WARN_ON_ONCE(cq->shared))
@@ -2257,9 +2259,10 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	ib_umem_release(cq->umem);
+	ib_umem_release_non_listed(umem_list, UVERBS_BUF_CQ_BUF, cq->umem);
 	rdma_restrack_del(&cq->res);
 	kfree(cq);
+	ib_umem_list_release(umem_list);
 	return ret;
 }
 EXPORT_SYMBOL(ib_destroy_cq_user);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..dd6c0d68497d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1740,6 +1740,8 @@ struct ib_cq {
 	unsigned int comp_vector;
 	struct ib_umem *umem;
 
+	struct ib_umem_list    *umem_list;
+
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 10aa6568abf1..375e4e224f6a 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -120,6 +120,12 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 };
 
+enum uverbs_buf_cq_slots {
+	UVERBS_BUF_CQ_BUF,
+	__UVERBS_BUF_CQ_MAX,
+	UVERBS_BUF_CQ_MAX = __UVERBS_BUF_CQ_MAX - 1,
+};
+
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
 	UVERBS_ATTR_DESTROY_CQ_HANDLE,
 	UVERBS_ATTR_DESTROY_CQ_RESP,
-- 
2.53.0


