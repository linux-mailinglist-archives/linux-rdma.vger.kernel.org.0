Return-Path: <linux-rdma+bounces-21506-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDU2IlyZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21506-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD739603141
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA5230D768F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489433AD91;
	Fri, 29 May 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="iUD3mz6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44333B6D1
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062218; cv=none; b=TTo6mJ5sYOI0sMBLme9vUwjfKfQRlB6hQGY4c1yhbb/Uyz0h4QZAacZELD9NWUQMPVXFydE1a9GWpoJ+sVSTRZ6MmhSgGsGxUWkf6rj1N15aSqGreMjzhiSu4L/5KPMIdWjGVXGQx2Cq4Dyd03HX1nd6t/tMrCmUNvL0MWGkPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062218; c=relaxed/simple;
	bh=MOFeZ70kxRZ8D1xtIBaz86zHRZSdCEY+oGCneR6LKWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9E4JJXZrTyqoTn4IAAWY+GOXRzx0R7D8l+XrF/lyowixr4jk5m0Dj2IK1hu5zN27sNgyEF+zXXNEZ3jevY1KH9rILI21FqzAYsjbHctu7WZApPAWf8fGnrcrwltuNBWy/uLN3hlfi1EfMQQWfNvB+94GGXlBRRZXqMk6ATv//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=iUD3mz6g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fde648a71so92519895e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062215; x=1780667015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZZVG6/OfVROGlVCmwj9bS21RKVVyXSMMASar4lH8Aw=;
        b=iUD3mz6g7l2SCeMaN1VFeqeQbcMhFtp3s0yDeXLsZCP8MzzXQsX8yB9nJH/m9MaWDb
         HSTnlkMi3eWpKArjV3Itvtrlc8NI2lsmVBTsG5Cf7voDLQakpt0p63dQAZ9cNrS35++0
         44iI8AcACca6i7VwpR7MrEnU/R2cSgY7BvjorfUxvGQg5ONteXr7Zhe/aZvXcMyoa9oY
         Iq1frrqE990UnLMBDP0dkVPGEGjGkDI1YhLHE6nd7qJ/QbwYncEWD6CFAaJsTmdwJXWG
         wfW94Lby8qOY4MaxxY8j8IKM/5Jvx5tV+J1n7s355D4lPDv2WlsWGP1piXMNnShE5Lf2
         dPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062215; x=1780667015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZZVG6/OfVROGlVCmwj9bS21RKVVyXSMMASar4lH8Aw=;
        b=Vx/Q7/wZ0A4GrYWmxeFb/vHV6rSIAMARdn4HxD+IT3YS4CKcLK4DPZ5qE45Hb1L8oa
         NZXgF3NLA97c6uUGqzzPBeEjg2HUVxOu6KbjQ9oNp2DTRXqps9+6b/GrYjJcBim9y0Tt
         EcqhNiLQLZH6uuJeQBTCiwff+TuREr/R4CDniL6RUYc64dWRR4jyNI3jjlsz93fZHZr8
         chMPU3AxoSOAtJZnDH2CutFuKWpfzjIkmqTf/nFmh9DeceVEKtvMeM5dD51Z2bwxmvhP
         USiEEgbczBGKjW3hdXJfq0Hv35HPBchKrGPASKpqrRPRcYuoObsQqbU9kV+yU5w/HQoV
         yxjw==
X-Gm-Message-State: AOJu0YwJfiKubJGy1OHyZou32UFi0tAxzhZmFgL4P4Scyni6+jFC8F2S
	OvwPeGs0sETHDZB/f7CUr8Uu058fI1gmnsVkK77nhVvlZXC3RDjwEDDJ0R9HSJaea8KH0sgy+w0
	B+Peljr7+Lw==
X-Gm-Gg: Acq92OEweoKLad8496EEnlzVrahQBOrr2+AEL8cvRsBj2v5aYSOEqebDqMaRggt0l84
	qoUlo0ss2a2QYhkkRAGttrX17LmBwdyKCQK6MnuEP2VCfaTGr9rW6TNCpUofx7fsq3dc9hbPJeh
	6nouGwUvKpuuk0EbpBe1Jdq6ZkLopOXFnS7Mcrw7d9DbdkuTpGmODlh0+TMltJfNKhoLhpTC9DY
	6Zrrzea9gAAoHcKKH+bqREL6XesLdqbp12pkPjvWlXtgNpAAyxJu3fEpR1Xhdrsudu015yc7Uc2
	Sq803+TlmjAQ87At8OjvaIYWHMyJwCM/S8FCfwK3zBnaFtcySpihCvkUiC2ceSd5k2HrhIJpkyL
	UdNuP4OnQIGUFGGF3pJ6ggHtEjXkPs6KEy7TKqa+tXByfc3VmOJyLHm2fqEk3HO5q+9NSB/R33t
	6qIT0huTUIdDm15vlERza+Yj3eDJZzw7GfP9V2J/OGYwY=
X-Received: by 2002:a05:600d:8496:20b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-4909dc336a3mr22000685e9.2.1780062215148;
        Fri, 29 May 2026 06:43:35 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490a25e4fe7sm2702475e9.0.2026.05.29.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:34 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 06/16] RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
Date: Fri, 29 May 2026 15:43:02 +0200
Message-ID: <20260529134312.2836341-7-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21506-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:server fail,resnulli.us:server fail,nvidia.com:server fail,sea.lore.kernel.org:server fail];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BD739603141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
that pin a CQ buffer umem from it. The wrappers reuse the
existing legacy CQ buffer-attr filler.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
- use ib_umem_get_from_attrs*() helpers
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c                | 57 ++++++++++++++++++-
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +
 include/rdma/ib_umem.h                        | 20 +++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index d364a5ab0558..b3261b924a71 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -497,7 +497,7 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_get_attr_or_va);
 
-static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
+static int uverbs_create_cq_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
 					    struct ib_uverbs_buffer_desc *desc)
 {
 	struct ib_device *ib_dev = attrs->context->device;
@@ -547,6 +547,61 @@ static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
 	return -ENODATA;
 }
 
+/**
+ * ib_umem_get_cq_buf - Pin a CQ buffer umem from per-command attributes.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @size:    minimum required CQ buffer length.
+ * @access:  IB access flags.
+ *
+ * Resolves the CQ buffer from the new UMEM attribute or the legacy
+ * CQ buffer attributes. There is no UHW VA fallback, so the caller
+ * must arrange its own backing (typically an in-kernel allocation)
+ * when no source is available.
+ *
+ * Return: caller-owned umem on success; NULL when no source supplied
+ * a buffer; ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   const struct uverbs_attr_bundle *attrs,
+				   size_t size, int access)
+{
+	return ib_umem_get_from_attrs(device, attrs,
+				      UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+				      uverbs_create_cq_get_buffer_desc,
+				      size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf);
+
+/**
+ * ib_umem_get_cq_buf_or_va - Pin a CQ buffer umem with UHW VA fallback.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @addr:    UHW user VA used when no per-command attribute matched.
+ * @size:    on the attr / legacy paths, the minimum required umem length
+ *           validated post-pin; on the VA fallback path, the length to pin.
+ * @access:  IB access flags.
+ *
+ * Like ib_umem_get_cq_buf(), but pins @addr/@size when neither the
+ * UMEM attribute nor the legacy CQ buffer attributes are supplied.
+ *
+ * See ib_umem_get_attr_or_va() for the note on @size's dual role and
+ * the migration path for drivers that would distinguish a user-supplied
+ * length from a driver-computed minimum.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 u64 addr, size_t size, int access)
+{
+	return ib_umem_get_from_attrs_or_va(device, attrs,
+					    UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+					    uverbs_create_cq_get_buffer_desc,
+					    addr, size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_cq_buf_or_va);
+
 /**
  * ib_umem_get_cq_tmp - Temporary CQ buffer umem getter.
  * @device: IB device.
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 711bad0aa8a3..05d1294762c0 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -215,6 +215,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
 			   UVERBS_ATTR_TYPE(u64),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0d6e90a35f3a..492c8d365730 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -90,6 +90,12 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       const struct uverbs_attr_bundle *attrs,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
+struct ib_umem *ib_umem_get_cq_buf(struct ib_device *device,
+				   const struct uverbs_attr_bundle *attrs,
+				   size_t size, int access);
+struct ib_umem *ib_umem_get_cq_buf_or_va(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 u64 addr, size_t size, int access);
 struct ib_umem *ib_umem_get_cq_tmp(struct ib_device *device,
 				   struct uverbs_attr_bundle *attrs);
 
@@ -210,6 +216,20 @@ ib_umem_get_attr_or_va(struct ib_device *device,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline struct ib_umem *
+ib_umem_get_cq_buf(struct ib_device *device,
+		   const struct uverbs_attr_bundle *attrs, size_t size,
+		   int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
+ib_umem_get_cq_buf_or_va(struct ib_device *device,
+			 const struct uverbs_attr_bundle *attrs, u64 addr,
+			 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
 ib_umem_get_cq_tmp(struct ib_device *device, struct uverbs_attr_bundle *attrs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 72041c1b0ea5..02835b7fd76d 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -117,6 +117,7 @@ enum uverbs_attrs_create_cq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_FD,
 	UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET,
+	UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_cq_cmd_attr_ids {
-- 
2.54.0


