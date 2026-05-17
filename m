Return-Path: <linux-rdma+bounces-20816-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHdfGoxgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20816-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0ED55F7D7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E042301D30F
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2C2D46C0;
	Sun, 17 May 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="0kFXid02"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94A2BE7A7
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999418; cv=none; b=e6uFevJwW28VLUqoOlGMvHt5ygu5pdCTmQKZwzae9MPeyJfD7TVuDTZiIWRaw5MWIobe+AUfW72095LoySqQJArBBjIBgUyOpU+iX2nA6tWB8IXT3JxV0Po0jSPPuQGtYkP+9g/h22NljwKHSiFOghR4LlCrjmuNqgYBW858QIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999418; c=relaxed/simple;
	bh=5gv88isocAKRcl3DuUH6O6dm/oZXOumq7K1XJeiJHw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFzCfk2tCqui+uRg9i9rKwSyS+uGYUiMoWd9QW9bI/xx5JAvqMTxAzYhJ6RzdvPwXrhqZFdTGQAAE0aEtGauoS9cy8OL/36bRur7lNShyqVz9yF6S8DedZykmcMQWlY1S9n/VZ8MAXYReqincCS/DIKA+/bu0M0PcIC2SuC2mX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=0kFXid02; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so11403445e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999415; x=1779604215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=627asbKidTVXCb0Cx/OVAa06oriKH4kyo0uzZEiVAKk=;
        b=0kFXid02tooKbYtXlK5zvU1XN60xXn4ev1qzsJ0cFhKCc/TPbMFnTNXyFmIPAe5Q44
         v2Ha1NE26UBVa094LyFOBHKAE7/sCA4Vlsn8qQajkNb+idGwQK9wJAhJsvms1N5dY3sH
         m04XqWZdCEkA5xa2EUGm646xgjJXB6+aFDpyK9xsdzm5IarMxXH6D6DwxucWyJRfWEmh
         Pb5++UUy5nFTseGck+4Fg2WFqwpnsTPKFVFok4LZuwWOWNwIHTWngJKLjx1aBuA8vM1H
         4W7kVIOO+mpIBeF3jMb/v+PB2JwO6A7/kdDGrCyuAeA9qMxlqWGS0CWTf9FR+F9M2OvH
         8rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999415; x=1779604215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=627asbKidTVXCb0Cx/OVAa06oriKH4kyo0uzZEiVAKk=;
        b=CuqiW3TyziRfhkuSnLPR6+b+qdyJnxGTpy0vTNNKpLREL+Nr2lBonvZ7mOFfJGlbi7
         IhhB/mj0GEAsQmQ5tHEDsUZTeCS1xK7NlJr1gKtyFYaB0kB08c0UkjXw7zDjny8A1KzW
         HP7QH9EysZT9+kr4vT+YBS7LaCaJglwYGj7ZDUuigmUElfAlTebbgWZhDnzTVSJ5Vqrf
         WYzRtLrAdok9VdHZ7Wa2dkBK09HlFgIJUY1iIUS7BUksHWfg57HNLqMsB+WW/slcXV7C
         ho9mX2xOZWk6XYf836MQW5CIutr+g4/8Z+Y7zDzka92bAATqvy3JuVf5r2QKlzUNRzKa
         kyyw==
X-Gm-Message-State: AOJu0YztPXxbgG+0r50RuEDrOK0dxzFZGw6ctOkUHxwHPszPT16jkySB
	LQk5LTL+fPMAaXAKyeyNabgVS4J17QPtE4ZmtaFyuILctG/sWgssJVJIfRgoB3sqFFCp41B3b+4
	19qZs+VweIDNP
X-Gm-Gg: Acq92OEGsR1eoq/68ho1dJUldE2SRKZH4KJ2B8Gac3RUxANuMn7R8nJjji+rkbURjuO
	Qm+GM2rFMprqg/cDdz03N8s916dFvQGlQTs5BSKQ+IPNX0yxSpAIKNFtmO7/CLOloYnJGufVyQh
	NeuHgPIGCxAPGngyGxZEteP1NlBIJfY/NurfXu9w2fodo2UzFD8mFjsvPnoTQOaZWziQK2FGtcy
	3JvbMTIZ/eh8DJA6Sk0ONDTpjdaj/Vtdbvo6D0kaUPp32H/tylIGIEkHvyhp7mZ6IYW91jN3yZ3
	hPbVaDtdKrFkNErlNUu3EbtV9cdp61mypYV/u3rrikwSNKosGniq9+iM8kmUmvGCjFLbGHROkj+
	kxTwV7+DjhSZPrxeI68zkUKZWWrhH6PTBD2IRKQK+ZR+cOmoO6vvws/OubqsK2tChcidI04S/Zl
	VJX9wk1m93AGfsXoozhvrmGFH4YMrkwHLESy14L6r/g1mGtloaIQWX+huS1oKuOzPvlew=
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe539198fmr137776365e9.13.1778999415243;
        Sat, 16 May 2026 23:30:15 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm198408985e9.15.2026.05.16.23.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:14 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 05/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Sun, 17 May 2026 08:29:56 +0200
Message-ID: <20260517063006.2200680-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB0ED55F7D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20816-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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
index 5815bde36e53..54830351b050 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -394,6 +394,85 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 }
 EXPORT_SYMBOL(ib_umem_get);
 
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
index e152699666ac..0c32b055257a 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -96,6 +96,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr,
 			    size_t addr_size, size_t min_size, int access);
+struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
+				   struct uverbs_attr_bundle *attrs);
 
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
@@ -217,6 +219,11 @@ ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *
+ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
 					     int access)
-- 
2.54.0


