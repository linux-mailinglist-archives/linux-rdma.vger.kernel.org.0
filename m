Return-Path: <linux-rdma+bounces-21503-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DMnDQSYGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21503-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C560301A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BB7A30769EA
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572623385AC;
	Fri, 29 May 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="lrurSocb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27748330B09
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062209; cv=none; b=l6T9gE7Kq18/vcudyWliC2T2IqmGD4aSWeGP/5LRPJKznU/AEeHDvow33xX3G9s+xDs/egrHL0vP6KB+i6MJikaCfjc5Fj6QWtUWIWicFpDUqf6oCIGPXMzUnZlXGyBflNLoKHK0BnVLTivFeo7dGh1s7j19KK/c/5u88SLViM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062209; c=relaxed/simple;
	bh=rnopZ3VZGHiGSmE9P97cLgK3B/E09kpLuKqU/FjxQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEYZQjlU1YCWW1ohzbMbsylNRlfnqjPNUJHelCS3Yhfo3bcz2NG4n53dFtrTcbuVShmNC34KbJ7nQf+KZ1i84yky6wGIaAa7CzhT5DNaj7lpQT9M4lJCf2SqZU76T+VvSdZvHEA/OFY1pHXTzQnPU2qtfnVaFMdQMQ7CDhdWUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=lrurSocb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so82253545e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062205; x=1780667005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmLjwYoCDJ9YsevPMHIfFbJrdqfJ132zgaLQA/rhO5w=;
        b=lrurSocbx1NnzxpssF23g2bXhiWRzmA98Ska7j825yb9V7IFbagXRuOdziN4Q4aXrZ
         qvPDVKeg+ET82puDLOhY0bWlNozKfqUSlMgAX7z9kUVWzRoaVLtXoqSVqm7nz2xar+RU
         8N8exWkWKFi5bsrRQyLeLRO9JChquJ7l4R7vRtYSnwLhKC15xJFi6nasZifW21W2nYVE
         iUnwI0F955odHI1dg6YLJ9zYtUI3yhwP/Of0bsIIUzETX2QM2659PSSUYhKMw7EeszMA
         8J/95zSN75lxmcn0OT0/jEqICX6vFSiJuWI4Kv0wgnU3qb7d4hWoFrn30nlFPP1fV0Fy
         hNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062205; x=1780667005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmLjwYoCDJ9YsevPMHIfFbJrdqfJ132zgaLQA/rhO5w=;
        b=iDangMO6MTDufO7XZlu9D0smbH3oRGEWeijxNXD+FWWt8aRUTmqQMs7pEpR+XhaZ45
         7vEauhy5UsVsBU1JP0HaG3io06M8xVe5OHg96GuyQ8omcxfEX/pBHUAZ58fi4vEgU8xv
         zyUtA9Nq5eIoW06D2IUpmkrdwpHzcFr853v5/IyVoINZ+i2FnTrpFQE5Ep/ZhkC1BONM
         pbrmFJums/JNYHMbzKnL4BMkJMlE3/J4afREXTvG6w2jMDrrVV39o1b/p7jdWLSDnfmx
         1dU6lmtj6lgz/jwGDxircMSCXSLiDWpWdb61HIkrWn/zklkAuf3QzF4021HGtl43Qvik
         cOXQ==
X-Gm-Message-State: AOJu0YyzJoIZF0rSnK1RLbFt1NPkAFSX5We3uCfsGsUOU9LxOWEMWgy+
	9tSygD8lZ3Z2zZIOVy/6PzpkxNxQcfq2KJXBXhy6hjcQ+gKiPuN6nMY0g0Kl+iKxmsrkjTzhCvD
	q57kI02bJhA==
X-Gm-Gg: Acq92OETnsewrArpUoohlmcUYnKXPQ5gHOTi0F4dDkzlds3c3n/oxAFIOTN3e3aI85R
	C/yc9hU1d/xlhaIFs2Or/k05846J4C4jE4KhEIc8BQkgN2bwfTAG/qcgIcaKo7pwU8vGbFOKbI2
	IVtBnHe9ftTmmgR9GO4sZqFH4eb7lzWvnK1uE/+je7PEy/RFJ+e8BCac456lIr41xCdhN30Db5S
	BaDuqQYcSNJ04uWySSxvqkhqPDPCRE2nbS7vVHFEXXC/nlEE+e84B/jm2fLyJEmmefsHfhuxXnY
	vLINWdoEozBiYPRkF9if5Ko7Mk62r399P4Aw2MIsYUim631FmnVkzr4lFyO0WetxURSvRwV8dhj
	/8Fi15tIYbLSJnBGdZKa+Togeuq/uTG8PGK8T2PaNidXRVg9UxdCcRHCVR+zG92tEiHcWFQSm5s
	6CbbsajmRX/RCgl7DkwHgvG82Ssr4MlNp7SG7nd/HnwZs=
X-Received: by 2002:a05:600c:3b13:b0:490:44eb:c1d7 with SMTP id 5b1f17b1804b1-4909c0f30c7mr53068445e9.30.1780062205374;
        Fri, 29 May 2026 06:43:25 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0a93b5sm14907945e9.8.2026.05.29.06.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:24 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 03/16] RDMA/core: Introduce generic buffer descriptor infrastructure for umem
Date: Fri, 29 May 2026 15:42:59 +0200
Message-ID: <20260529134312.2836341-4-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21503-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 066C560301A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Introduce a per-attribute UVERBS_ATTR_UMEM model so each uverbs
command's umem set is explicit in its UAPI definition. Add
driver-facing wrapper helpers that pin a umem on demand from an
attribute or a VA addr; the driver owns the returned umem and
releases it from its destroy/error paths.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v8->v9:
- added missed const to attrs_bundle for uverbs_get_buffer_desc() stub
- added check-fail of addr/length size to ib_umem_get_desc()
- added kdoc size sections
- extended uverbs_get_buffer_desc() kdoc return values
v7->v8:
- moved uverbs_attr_get_buffer_desc()to ib_core_uverbs.c
- s/uverbs_attr_get_buffer_desc/uverbs_get_buffer_desc/
- s/attrs/attrs_bundle/ for uverbs_get_buffer_desc() arg
v6->v7:
- replaced reserved[2] in struct ib_uverbs_buffer_desc with strict
  flags + advisory optional_flags
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
- split ib_umem_get() into ib_umem_resolve_desc() +
  ib_umem_get_desc_check() + ib_umem_get_from_attrs[_or_va]()
v4->v5:
- rebased on top of Jason's ib_uverbs dependencies patchset
- split "size" arg into two, documented the semantics in kdoc
- split desc extraction out of ib_umem_get() into new
  uverbs_attr_get_buffer_desc() (uverbs_ioctl.{c,h})
- exported ib_umem_get_desc()
v3->v4:
- removed dmesg print from ib_umem_get() legacy filler check
v2->v3:
- pushed out desc processing to ib_umem_get_desc()
- replaced UVERBS_ATTR_BUFFERS array with per-attribute UVERBS_ATTR_UMEM
- struct ib_uverbs_buffer_desc: dropped .index, moved .type first,
  bumped reserved to __u32 reserved[2]
- added canonical ib_umem_get() + two inline wrappers
  (_attr, _attr_or_va)
- dropped ib_umem_list_* family + ib_umem_release_non_listed()
---
 drivers/infiniband/core/ib_core_uverbs.c |  25 +++
 drivers/infiniband/core/umem.c           | 228 +++++++++++++++++++++++
 include/rdma/ib_umem.h                   |  36 ++++
 include/rdma/uverbs_ioctl.h              |  30 +++
 include/uapi/rdma/ib_user_ioctl_verbs.h  |  27 +++
 5 files changed, 346 insertions(+)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index b4fc693a3bd8..6e063e05f796 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -708,6 +708,31 @@ int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
 }
 EXPORT_SYMBOL(uverbs_get_flags32);
 
+/**
+ * uverbs_get_buffer_desc - Read a buffer descriptor from a uverbs attr.
+ * @attrs_bundle: uverbs attribute bundle.
+ * @attr_id:      id of an UVERBS_ATTR_UMEM-typed attribute.
+ * @desc:         descriptor to fill.
+ *
+ * Return: 0 on success, -ENOENT if @attr_id is not set, -EINVAL on a
+ * malformed descriptor, or any other negative errno propagated from
+ * uverbs_copy_from() (notably -EFAULT on copy_from_user() failure).
+ */
+int uverbs_get_buffer_desc(const struct uverbs_attr_bundle *attrs_bundle,
+			   u16 attr_id, struct ib_uverbs_buffer_desc *desc)
+{
+	int ret;
+
+	ret = uverbs_copy_from(desc, attrs_bundle, attr_id);
+	if (ret)
+		return ret;
+	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
+		return -EINVAL;
+	desc->optional_flags &= IB_UVERBS_BUFFER_DESC_OPTIONAL_FLAGS_KNOWN_MASK;
+	return 0;
+}
+EXPORT_SYMBOL(uverbs_get_buffer_desc);
+
 /* Once called an abort will call through to the type's destroy_hw() */
 void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
 				 u16 idx)
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 0056f23af57b..7d2256583bc7 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -269,6 +269,175 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 	return ret ? ERR_PTR(ret) : umem;
 }
 
+/**
+ * ib_umem_get_desc - Pin a umem from a buffer descriptor.
+ * @device: IB device.
+ * @desc:   buffer descriptor (VA or DMABUF).
+ * @access: IB access flags.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_desc(struct ib_device *device,
+				 const struct ib_uverbs_buffer_desc *desc,
+				 int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+
+	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
+		return ERR_PTR(-EINVAL);
+
+	if (overflows_type(desc->addr, unsigned long) ||
+	    overflows_type(desc->length, size_t))
+		return ERR_PTR(-EOVERFLOW);
+
+	switch (desc->type) {
+	case IB_UVERBS_BUFFER_TYPE_DMABUF:
+		umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
+							desc->length, desc->fd,
+							access);
+		if (IS_ERR(umem_dmabuf))
+			return ERR_CAST(umem_dmabuf);
+		return &umem_dmabuf->umem;
+	case IB_UVERBS_BUFFER_TYPE_VA:
+		return __ib_umem_get_va(device, desc->addr, desc->length,
+					access);
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+EXPORT_SYMBOL(ib_umem_get_desc);
+
+/*
+ * Per-command legacy buffer-desc filler.
+ * Returns 0 on success (desc filled), -ENODATA if no legacy attrs apply,
+ * negative errno on validation failure.
+ */
+typedef int (*ib_umem_buf_desc_filler_t)(const struct uverbs_attr_bundle *attrs,
+					 struct ib_uverbs_buffer_desc *desc);
+
+/*
+ * ib_umem_resolve_desc - Resolve a buffer descriptor from a per-command UMEM
+ *                        attribute and/or a legacy attr filler.
+ *
+ * Return:
+ *    0       @desc filled.
+ *   -ENOENT  no source produced a buffer.
+ *   -EINVAL  both the UMEM attribute and the legacy filler produced a buffer.
+ *   -errno   propagated from attr read / filler validation.
+ */
+static int ib_umem_resolve_desc(const struct uverbs_attr_bundle *attrs,
+				u16 attr_id,
+				ib_umem_buf_desc_filler_t legacy_filler,
+				struct ib_uverbs_buffer_desc *desc)
+{
+	bool have_desc = false;
+	int ret;
+
+	if (!attrs)
+		return -ENOENT;
+
+	ret = uverbs_get_buffer_desc(attrs, attr_id, desc);
+	if (!ret)
+		have_desc = true;
+	else if (ret != -ENOENT)
+		return ret;
+
+	if (legacy_filler) {
+		struct ib_uverbs_buffer_desc legacy_desc = {};
+
+		ret = legacy_filler(attrs, &legacy_desc);
+		if (!ret) {
+			if (have_desc)
+				return -EINVAL;
+			*desc = legacy_desc;
+			have_desc = true;
+		} else if (ret != -ENODATA) {
+			return ret;
+		}
+	}
+
+	return have_desc ? 0 : -ENOENT;
+}
+
+/*
+ * ib_umem_get_desc_check - Pin a umem from @desc and verify it meets
+ *                          @min_size.
+ */
+static struct ib_umem *
+ib_umem_get_desc_check(struct ib_device *device,
+		       const struct ib_uverbs_buffer_desc *desc,
+		       size_t min_size, int access)
+{
+	struct ib_umem *umem;
+
+	umem = ib_umem_get_desc(device, desc, access);
+	if (IS_ERR(umem))
+		return umem;
+	if (umem->length < min_size) {
+		ib_umem_release(umem);
+		return ERR_PTR(-EINVAL);
+	}
+	return umem;
+}
+
+/*
+ * ib_umem_get_from_attrs - Pin a umem from a per-command UMEM attribute
+ *                          and/or a legacy attr filler.
+ *
+ * Return: caller-owned umem on success; NULL when no source supplied a
+ * buffer; ERR_PTR(...) on error.
+ */
+static struct ib_umem *
+ib_umem_get_from_attrs(struct ib_device *device,
+		       const struct uverbs_attr_bundle *attrs,
+		       u16 attr_id, ib_umem_buf_desc_filler_t legacy_filler,
+		       size_t size, int access)
+{
+	struct ib_uverbs_buffer_desc desc = {};
+	int ret;
+
+	ret = ib_umem_resolve_desc(attrs, attr_id, legacy_filler, &desc);
+	if (ret == -ENOENT)
+		return NULL;
+	if (ret)
+		return ERR_PTR(ret);
+	return ib_umem_get_desc_check(device, &desc, size, access);
+}
+
+/*
+ * ib_umem_get_from_attrs_or_va - Pin a umem from a per-command UMEM
+ *                                attribute and/or a legacy attr filler,
+ *                                falling back to a UHW VA when no source
+ *                                matched.
+ *
+ * @size is always consumed: it is the length to pin on the VA fallback
+ * path AND the post-pin minimum-length check on the attr / legacy paths.
+ * Callers must always pass a meaningful, validated value.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+static struct ib_umem *
+ib_umem_get_from_attrs_or_va(struct ib_device *device,
+			     const struct uverbs_attr_bundle *attrs,
+			     u16 attr_id,
+			     ib_umem_buf_desc_filler_t legacy_filler,
+			     u64 addr, size_t size, int access)
+{
+	struct ib_uverbs_buffer_desc desc = {};
+	int ret;
+
+	ret = ib_umem_resolve_desc(attrs, attr_id, legacy_filler, &desc);
+	if (ret == -ENOENT)
+		desc = (struct ib_uverbs_buffer_desc){
+			.type	= IB_UVERBS_BUFFER_TYPE_VA,
+			.addr	= addr,
+			.length	= size,
+		};
+	else if (ret)
+		return ERR_PTR(ret);
+	return ib_umem_get_desc_check(device, &desc, size, access);
+}
+
 /**
  * ib_umem_get_va - Pin and DMA map userspace memory.
  *
@@ -284,6 +453,65 @@ struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 }
 EXPORT_SYMBOL(ib_umem_get_va);
 
+/**
+ * ib_umem_get_attr - Pin a umem from a per-command UMEM attribute.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @attr_id: per-command UMEM attribute id.
+ * @size:    minimum required umem length.
+ * @access:  IB access flags.
+ *
+ * Return: caller-owned umem on success; NULL when no source supplied
+ * a buffer; ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_attr(struct ib_device *device,
+				 const struct uverbs_attr_bundle *attrs,
+				 u16 attr_id, size_t size, int access)
+{
+	return ib_umem_get_from_attrs(device, attrs, attr_id, NULL, size,
+				      access);
+}
+EXPORT_SYMBOL(ib_umem_get_attr);
+
+/**
+ * ib_umem_get_attr_or_va - Pin a umem from a per-command UMEM attribute,
+ *                          falling back to a UHW VA.
+ * @device:  IB device.
+ * @attrs:   uverbs attribute bundle (may be NULL).
+ * @attr_id: per-command UMEM attribute id.
+ * @addr:    UHW user VA used when no per-command attribute matched.
+ * @size:    on the attr / legacy paths, the minimum required umem length
+ *           validated post-pin; on the VA fallback path, the length to pin.
+ * @access:  IB access flags.
+ *
+ * Like ib_umem_get_attr(), but pins @addr/@size when no per-command
+ * UMEM attribute is supplied.
+ *
+ * IMPORTANT: @size is always consumed. On the attr / legacy paths it is
+ * used as the post-pin minimum-length check; on the VA fallback path it
+ * is the length to pin. Callers MUST pass a meaningful, validated value
+ * even when they expect an attribute-supplied buffer to be used.
+ *
+ * Every in-tree caller passes the same value for the two roles of @size
+ * because no driver today distinguishes a user-passed buffer length from
+ * a driver-computed minimum. Drivers that currently accept a user-supplied
+ * length without cross-checking it against a driver minimum (vmw_pvrdma
+ * CQ/QP/SRQ, qedr CQ/QP/SRQ, mana WQ/QP, ionic CQ/QP), once tightened to
+ * compute and check a real minimum, will want to introduce a separate
+ * helper that passes these as distinct values.
+ *
+ * Return: caller-owned umem on success, ERR_PTR(...) on error.
+ */
+struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
+				       const struct uverbs_attr_bundle *attrs,
+				       u16 attr_id, u64 addr, size_t size,
+				       int access)
+{
+	return ib_umem_get_from_attrs_or_va(device, attrs, attr_id, NULL, addr,
+					    size, access);
+}
+EXPORT_SYMBOL(ib_umem_get_attr_or_va);
+
 /**
  * ib_umem_release - release pinned memory
  * @umem: umem struct to release
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 25e90766892e..0f373679ea81 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -73,10 +73,26 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
+
+struct ib_udata;
+struct ib_uverbs_buffer_desc;
+struct uverbs_attr_bundle;
+
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
+struct ib_umem *ib_umem_get_desc(struct ib_device *device,
+				 const struct ib_uverbs_buffer_desc *desc,
+				 int access);
 struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 			       size_t size, int access);
+struct ib_umem *ib_umem_get_attr(struct ib_device *device,
+				 const struct uverbs_attr_bundle *attrs,
+				 u16 attr_id, size_t size, int access);
+struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
+				       const struct uverbs_attr_bundle *attrs,
+				       u16 attr_id, u64 addr, size_t size,
+				       int access);
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -160,12 +176,32 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #include <linux/err.h>
 
+static inline struct ib_umem *
+ib_umem_get_desc(struct ib_device *device,
+		 const struct ib_uverbs_buffer_desc *desc, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
 					     int access)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *
+ib_umem_get_attr(struct ib_device *device,
+		 const struct uverbs_attr_bundle *attrs, u16 attr_id,
+		 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
+ib_umem_get_attr_or_va(struct ib_device *device,
+		       const struct uverbs_attr_bundle *attrs, u16 attr_id,
+		       u64 addr, size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 9d7575d999e1..24fd36213023 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -590,6 +590,28 @@ struct uapi_definition {
 			    UA_OPTIONAL,                                       \
 			    .is_udata = 1)
 
+/*
+ * Per-attribute UMEM descriptor. The payload is a single
+ * struct ib_uverbs_buffer_desc identifying a memory region backed by
+ * dma-buf or user virtual address. _access selects UA_OPTIONAL or
+ * UA_MANDATORY. Drivers obtain a umem from the attribute via the
+ * ib_umem_get_*() wrapper helpers.
+ */
+#define UVERBS_ATTR_UMEM(_attr_id, _access)                                    \
+	UVERBS_ATTR_PTR_IN(_attr_id,                                           \
+			   UVERBS_ATTR_TYPE(struct ib_uverbs_buffer_desc),     \
+			   _access)
+
+/*
+ * Bit masks of the @flags / @optional_flags fields of struct
+ * ib_uverbs_buffer_desc that the kernel understands. @flags is strict:
+ * any bit outside the known mask makes the call fail with -EINVAL.
+ * @optional_flags is advisory: bits outside the known mask are silently
+ * dropped. Both masks are extended as new bits are introduced.
+ */
+#define IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK		0U
+#define IB_UVERBS_BUFFER_DESC_OPTIONAL_FLAGS_KNOWN_MASK	0U
+
 /* =================================================
  *              Parsing infrastructure
  * =================================================
@@ -862,6 +884,8 @@ int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
 int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle, size_t idx,
 		   const void *from, size_t size);
+int uverbs_get_buffer_desc(const struct uverbs_attr_bundle *attrs_bundle,
+			   u16 attr_id, struct ib_uverbs_buffer_desc *desc);
 __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
 			     gfp_t flags);
 
@@ -920,6 +944,12 @@ static inline int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle,
 {
 	return -EINVAL;
 }
+static inline int
+uverbs_get_buffer_desc(const struct uverbs_attr_bundle *attrs_bundle,
+		       u16 attr_id, struct ib_uverbs_buffer_desc *desc)
+{
+	return -EINVAL;
+}
 static inline __malloc void *uverbs_alloc(struct uverbs_attr_bundle *bundle,
 					  size_t size)
 {
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 90c5cd8e7753..51030c27d479 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -273,4 +273,31 @@ struct ib_uverbs_gid_entry {
 	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
 };
 
+enum ib_uverbs_buffer_type {
+	IB_UVERBS_BUFFER_TYPE_DMABUF,
+	IB_UVERBS_BUFFER_TYPE_VA,
+};
+
+/*
+ * Describes a single buffer backed by dma-buf or user virtual address.
+ * Used as the payload of a per-attribute UVERBS_ATTR_UMEM-typed attribute.
+ *
+ * @type: buffer type from enum ib_uverbs_buffer_type
+ * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
+ * @flags: required flags; the kernel rejects the call with -EINVAL if any
+ *         bit is not understood. No bits are defined yet.
+ * @optional_flags: advisory flags; bits the kernel does not understand are
+ *                  silently ignored. No bits are defined yet.
+ * @addr: offset within dma-buf, or user virtual address for VA
+ * @length: buffer length in bytes
+ */
+struct ib_uverbs_buffer_desc {
+	__u32 type;
+	__s32 fd;
+	__u32 flags;
+	__u32 optional_flags;
+	__aligned_u64 addr;
+	__aligned_u64 length;
+};
+
 #endif
-- 
2.54.0


