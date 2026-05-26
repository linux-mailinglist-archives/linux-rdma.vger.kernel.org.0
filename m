Return-Path: <linux-rdma+bounces-21309-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIcpJ6ezFWpCYQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21309-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:52:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C85D7FAD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700DA3070DFA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B33FF8B9;
	Tue, 26 May 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="BDpkt9s7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D801400E10
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806539; cv=none; b=SVEdsqw+kr7WX9AHID+AOv96MTYHH4HA2QvDiVA8N03PlQXoXz/UB6a/z1ZJypEoxrFzow6K8s7x8WtjfpKKGNZkS1glZkfiwV1kCP9VkWhucCNTReEC2oLbKxeje7kYRTnhyjgFWRhmoUx02myiQC4ubI9c4Snt5VAC7P5wHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806539; c=relaxed/simple;
	bh=CLgX3VQIBTY+dICeOsOL5sjgoLLXIaNRN46Ixxn025k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJmtpAMkqJFMN9Ijql0ENbZctnvQQfHk0uUjH+8YWTbdFLt5OM3bJn3rEVRpImqJUBYpeOW8pQp41ihPKpvF4JyURBAnmwAfQS6K2eeVD284yih3c7z5h5AKv986ojQlPmJq2gqUm+pKtkqxYkaqFo3dVqiIjRhqxs6Es/X7v3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=BDpkt9s7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so112293725e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806534; x=1780411334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+9fupi/+UKi22l0tlNNOi1XiDiBj9Qdh8qOJ/ZByjY=;
        b=BDpkt9s7+/mhmCh3fy1xiRDiBf/rF+BHWe5ZvnwdMO5TNHreG4and6d5BW2bUyKeL7
         /k/s4ox60CiK3A05Buj5EFuohibuXLICGksCkyEqwHgFAmnLGIPC2xNLiAb1c8dfelnu
         Z6sxavpEmMV+6AV4LGbi90Qxg0XB6fzQNHiimArnMuhQrhB8mNfzx6EIkKzYopRAEK2Q
         pKFeja+QT6sZxSpCCTTtSTHHBH3mL8FeF6KxxFIlRrHccoBPqItuwqhnXMX9/wQN0vsq
         aC9BSumUE3JoYn7Bb2nrha7fg3n0mCXmSZ0USNJZngx1vCbdEceKrK3yrNuTwB+qb7kV
         W71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806534; x=1780411334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+9fupi/+UKi22l0tlNNOi1XiDiBj9Qdh8qOJ/ZByjY=;
        b=Apw3yF3EX/bd6XX6TYVFjoVuSy+IU+WOeA3NsWyFsr6RleZrU7G5jgxL1wlrRuxC1E
         wTHwG6xujfXD0aTjvK7f74g0vox2pz3h67+/6lu6Nva8Ui6L/AacGVyHmYO5+cPvsVVv
         97tDOuweRAqIDVqDARDcIi97o0YDpIpzL3xZQiSK8nvUYyqHzC7QuxhoTZvmOeTXSXIS
         v7/KIVPGE0lr836y4KplpGfEzTBsNc9L16NzBbTscxO6aKtPOKEqdVghIfgEGeK4h7Mg
         SQX9Lddxer5osLqbGQ+SF9nvo+iPNmdYYgMu0p2/+sPkJuuOl3HCMc0G+AG5ak4NqauU
         hnsQ==
X-Gm-Message-State: AOJu0YxT5oRflBfmHAuExtqm72bsv9RKvQ3EHDs4eMLKBbZUlU5SszTg
	rXedvbu66fEtXojk8vRkOxGijYVA6md15EWxcUSeXZry8ym+AB1HODJ3vRaqHX4yw5fJf7heNMP
	BlOUT6m5h5w==
X-Gm-Gg: Acq92OGPzcxU90yPVswM1YpVRIRzTKUsBtchW7EHzXEbIqBbMa6DFf0fXMThiUNN9nO
	7EX1dB3AYIofeScYuFDyfsuLh62uRYTwRhFeEZLINpnUKDa5m8DXvqyrX+5sVlUglPxkfgUTZdo
	ve7btXg/5d0ZHXLfAv8VVhNL4iTk1PiOwfxZjpMLQ63tXl8G99kLE9FXa20UVsK/jubr6i67PZF
	wB9He9VjY/Eu2X6267v3diwqPVGcqgh5PO/06Wf9lxeZu22MZzdL60sFk6n2+WvtYZ4eUymqIoE
	BHFgFSdDwwUiPkHMD4Fb3fIIzeYk+3KGgLa72m5HGYG4toH9AA0bm5/MDr7kpOUIkOYspOiiBps
	rbXsf9V6QwrX265FdrS6AY+LmpKqA1RlWYcf/f0m5XAqjwvDgq8PuhAkOVKSiA8UBF3n6r03cm5
	lsXXIvgQd35IAhwAncUQPs6mK/6w2iZ/reGBAb/8tjcyM=
X-Received: by 2002:a05:600c:1393:b0:490:3890:605b with SMTP id 5b1f17b1804b1-490428e0bf3mr316353285e9.31.1779806534546;
        Tue, 26 May 2026 07:42:14 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm334921285e9.0.2026.05.26.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:14 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 05/15] RDMA/uverbs: Push out CQ buffer umem processing into a helper
Date: Tue, 26 May 2026 16:41:42 +0200
Message-ID: <20260526144152.1422310-6-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21309-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: F02C85D7FAD
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
index ee31c8c87629..37f0f8679278 100644
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


