Return-Path: <linux-rdma+bounces-20814-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OZ+IoVgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20814-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8C55F7C9
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0565301A430
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21725D527;
	Sun, 17 May 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qmmQ4EBa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E027AC4C
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999416; cv=none; b=Gg0nseyMZl0xuC8Kj7P6qcyjpRYT5D0PW72rXVVKt1N1OiLjpZDIjlnk5Qz0SKkRogQiQUHkGzYDfsai6t8P1jT7T3evLD0xb6pd0k5xOV/iiChHkw0Uj6a29+8UnZH4lxeQd9ZcHufZKsZD1HF+gzpA+2XEMXsxu87d5YjNsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999416; c=relaxed/simple;
	bh=nTbB/pI1NwjrpyyNtnnfCe3n/q8BHBpXBY/8s6clcSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXgkND/Nz6JGyAgXhbGz7Chu9DPf17EcMpJfExdggjcSXtnOjJ4MI1npvIWZBgPu6msL8Yc+w8JNRI6iMEyIjlmk5jQl/kt0mrWWvqVaDEahqiTp0efBZAhZrLtoHC0+yewMRjzA2lEHHV29bgnJWZ9s9Auh/79fvebW//jT7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qmmQ4EBa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a044cb827so758131f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999412; x=1779604212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc9GYDk7W4uB7/Decfi+oubITwKb0MA616bpvi3E8ys=;
        b=qmmQ4EBa8/rme0gBUoIW4DdvTZWgQbVtt2L2tBhpxo2h/7+xQaZFTTndVh4FfdHXzg
         8I65E6RtDZN36lUU86yVQbGsLivsscQDbdNDgnL7P9cmmEoi02pgXD9FtpohrMnELC8G
         d+GhcIHCDgayYxu3q+9VSSb4UmFr5lsYEe8dS5j7ufvXLFehMUvtg+qbMiMOil6Dx1DV
         TBajQ82og2JRSBOXZ2r7r/uPd9uplHFu3L440rzfLYDAx7aTt5j7iD6E63zIMXVTIfBg
         iOr7sT93w/nRxrP/ysrpDxOykG0GvD0qXypBDJFlzdQtTa2FnrzkVCvRs1fiXzpWV5l6
         1aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999412; x=1779604212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yc9GYDk7W4uB7/Decfi+oubITwKb0MA616bpvi3E8ys=;
        b=qU8rCNa+jzFCUSvGl/qXkOK9z/790Dc5fcaldYosbqJN34MK0b/KnIrYGnvnu3uJYt
         pn003KHLmpTU22bCfrHI4gAMzOCXGDJlJtpZQvZHeznwBdOfGgRdzqi8JpQCBHJpGNg0
         +x2RgVehttuoGhXyENhRkj8KmN5FU/stxp8ITXuHAGzOVBYejajIaLdAqC50JFXjIuuk
         xRsji6vlngEbAv+T2DFhfd17TsCCeXoBtgntlEwgCqsAw8egHxlMQXBHZInH/PNfdZ5y
         zdW2ePJhcYAmhOktnCufPjQ3aZN12KxXcE6q5OM7ekkVi4uNJ0Tr45e0DwOQ135XHOFF
         wFCA==
X-Gm-Message-State: AOJu0YzAILsiOziXzj3BUbRBe/XRVOHIdojZx9EtguolfyM8AxI2UBp3
	l9US36U8amBiD/rx2AATsaP7FoykDSglgUCkdT2QUGxUXcB+yO9BjGsSeZXoTJoqUDVLIUQSO+2
	wKViIvXZ541Rk
X-Gm-Gg: Acq92OFFlNj9+R5zJEpTg5gTkY/xRzQWgoQ7yFQkoBZpI+SHAuqXzMoUK+bLwN9mcj8
	Scj8zTYJOpCKDV/VelzR64OX3GrMC8gEgC8M/Ax8VoA6adj87VpFHF0HYUQCfg7OKIVgE6zs0zE
	hHizOrCHWf/cEOeiT4CpVgiUomZOcTNK40cr+64jA5wTax5VOfBG/H8FH/j300B1zHozr4AJM9G
	D3vIA77CyOltlF5HcyeEgxMtfEqPOsp9bLvdychPk0bC1kUshqOmSkie6nms2of3FBPQG4+hbbS
	+H3MYw33BHWhyehAq+3i3sKV13WW/y5+4WT7C9m1QaAVCQXhb5isPHSsrMVX9GV2L1COUrS3TFu
	WQRBkS9g5nSMKvWCRrxEFeYgdM0Qo2evAxwM7zbKaiCuiaRVDLcJJNp2x+kEauBBpBtInyMoHVE
	FP/Xskd0ORvlVcZ3SoRamO3njP6fUg+CnRsKybXIX/ZnOkxLAEjpnzKRe0
X-Received: by 2002:a05:6000:2383:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-45e5c5ccee2mr15330808f8f.33.1778999412438;
        Sat, 16 May 2026 23:30:12 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm26585368f8f.19.2026.05.16.23.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:11 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 03/15] RDMA/core: Introduce generic buffer descriptor infrastructure for umem
Date: Sun, 17 May 2026 08:29:54 +0200
Message-ID: <20260517063006.2200680-4-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 18E8C55F7C9
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
	TAGGED_FROM(0.00)[bounces-20814-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Introduce a per-attribute UVERBS_ATTR_UMEM model so each uverbs
command's umem set is explicit in its UAPI definition. Add
driver-facing wrapper helpers that pin a umem on demand from an
attribute or a VA addr; the driver owns the returned umem and
releases it from its destroy/error paths.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
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
 drivers/infiniband/core/umem.c          | 125 ++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_ioctl.c  |  28 ++++++
 include/rdma/ib_umem.h                  |  65 ++++++++++++
 include/rdma/uverbs_ioctl.h             |  21 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h |  23 +++++
 5 files changed, 262 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 0056f23af57b..3f5cb276c29a 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -269,6 +269,131 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
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
+	if (desc->reserved[0] || desc->reserved[1])
+		return ERR_PTR(-EINVAL);
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
+/**
+ * ib_umem_get - Canonical on-demand umem getter.
+ * @device:        IB device.
+ * @udata:         uverbs udata bundle (may be NULL).
+ * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
+ * @legacy_filler: optional command-specific legacy attr filler.
+ *                 invoked if @udata is set.
+ * @va_fallback:   if true, build a VA-typed desc with @addr.
+ * @addr:          user VA, used if @va_fallback is true.
+ * @addr_size:     pin length on the VA fallback path, sourced from any
+ *                 user-passed length (e.g. ucmd.buf_size). Ignored on the
+ *                 attr / legacy_filler paths -- the descriptor length is
+ *                 used there.
+ * @min_size:      driver-required minimum umem length, validated post-pin
+ *                 against any descriptor produced via @attr_id /
+ *                 @legacy_filler / VA fallback.
+ * @access:        IB access flags forwarded to ib_umem_get_desc().
+ *
+ * Today every in-tree caller passes @addr_size == @min_size because no
+ * driver distinguishes a user-passed buffer length from a driver-computed
+ * minimum. Drivers that currently accept a user-supplied length without
+ * cross-checking it against a driver minimum (vmw_pvrdma CQ/QP/SRQ, qedr
+ * CQ/QP/SRQ, mana WQ/QP, ionic CQ/QP), once tightened to compute and check
+ * a real minimum, will want to introduce a separate helper that passes
+ * @addr_size and @min_size as distinct values.
+ *
+ * Return: valid umem on success, ERR_PTR(...) on error, NULL
+ * if no source produced a buffer (only possible when @va_fallback is false).
+ */
+struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
+			    u16 attr_id,
+			    ib_umem_buf_desc_filler_t legacy_filler,
+			    bool va_fallback, u64 addr,
+			    size_t addr_size, size_t min_size, int access)
+{
+	struct uverbs_attr_bundle *attrs = NULL;
+	struct ib_uverbs_buffer_desc desc = {};
+	bool have_desc = false;
+	struct ib_umem *umem;
+	int ret;
+
+	if (udata)
+		attrs = container_of(udata, struct uverbs_attr_bundle,
+				     driver_udata);
+
+	if (attrs) {
+		ret = uverbs_attr_get_buffer_desc(attrs, attr_id, &desc);
+		if (!ret)
+			have_desc = true;
+		else if (ret != -ENOENT)
+			return ERR_PTR(ret);
+	}
+
+	if (attrs && legacy_filler) {
+		struct ib_uverbs_buffer_desc legacy_desc = {};
+
+		ret = legacy_filler(attrs, &legacy_desc);
+		if (!ret) {
+			if (have_desc)
+				return ERR_PTR(-EINVAL);
+			memcpy(&desc, &legacy_desc, sizeof(desc));
+			have_desc = true;
+		} else if (ret != -ENODATA) {
+			return ERR_PTR(ret);
+		}
+	}
+
+	if (have_desc)
+		goto have_desc;
+
+	if (!va_fallback)
+		return NULL;
+
+	desc = (struct ib_uverbs_buffer_desc){
+		.type	= IB_UVERBS_BUFFER_TYPE_VA,
+		.addr	= addr,
+		.length	= addr_size,
+	};
+
+have_desc:
+	umem = ib_umem_get_desc(device, &desc, access);
+	if (IS_ERR(umem))
+		return umem;
+	if (umem->length < min_size) {
+		ib_umem_release(umem);
+		return ERR_PTR(-EINVAL);
+	}
+	return umem;
+}
+EXPORT_SYMBOL(ib_umem_get);
+
 /**
  * ib_umem_get_va - Pin and DMA map userspace memory.
  *
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 0e67de0fff57..4c144ed50882 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -595,6 +595,34 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
 	}
 }
 
+/**
+ * uverbs_attr_get_buffer_desc - Read a buffer descriptor from a uverbs attr.
+ * @attrs:   uverbs attribute bundle.
+ * @attr_id: id of an UVERBS_ATTR_UMEM-typed attribute.
+ * @desc:    descriptor to fill.
+ *
+ * Copies the buffer descriptor payload of @attr_id into @desc and validates
+ * the reserved fields. Drivers that want to inspect the descriptor before
+ * pinning call this directly.
+ *
+ * Return: 0 on success, -ENOENT if @attr_id is not set, -EINVAL on a
+ * malformed descriptor.
+ */
+int uverbs_attr_get_buffer_desc(struct uverbs_attr_bundle *attrs,
+				u16 attr_id,
+				struct ib_uverbs_buffer_desc *desc)
+{
+	int ret;
+
+	ret = uverbs_copy_from(desc, attrs, attr_id);
+	if (ret)
+		return ret;
+	if (desc->reserved[0] || desc->reserved[1])
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(uverbs_attr_get_buffer_desc);
+
 /*
  * This is only used if the caller has directly used copy_to_use to write the
  * data.  It signals to user space that the buffer is filled in.
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 25e90766892e..65fdd0eed8b3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -73,10 +73,48 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
+
+struct ib_udata;
+struct ib_uverbs_buffer_desc;
+struct uverbs_attr_bundle;
+
+/*
+ * Per-command legacy buffer-desc filler.
+ * Returns 0 on success (desc filled), -ENODATA if no legacy attrs apply,
+ * negative errno on validation failure.
+ */
+typedef int (*ib_umem_buf_desc_filler_t)(struct uverbs_attr_bundle *attrs,
+					 struct ib_uverbs_buffer_desc *desc);
+
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
+struct ib_umem *ib_umem_get_desc(struct ib_device *device,
+				 const struct ib_uverbs_buffer_desc *desc,
+				 int access);
+struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
+			    u16 attr_id,
+			    ib_umem_buf_desc_filler_t legacy_filler,
+			    bool va_fallback, u64 addr,
+			    size_t addr_size, size_t min_size, int access);
 struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 			       size_t size, int access);
+
+static inline struct ib_umem *
+ib_umem_get_attr(struct ib_device *device, struct ib_udata *udata,
+		 u16 attr_id, size_t size, int access)
+{
+	return ib_umem_get(device, udata, attr_id, NULL,
+			   false, 0, size, size, access);
+}
+
+static inline struct ib_umem *
+ib_umem_get_attr_or_va(struct ib_device *device, struct ib_udata *udata,
+		       u16 attr_id, u64 addr, size_t size, int access)
+{
+	return ib_umem_get(device, udata, attr_id, NULL,
+			   true, addr, size, size, access);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -160,12 +198,39 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #include <linux/err.h>
 
+static inline struct ib_umem *
+ib_umem_get_desc(struct ib_device *device,
+		 const struct ib_uverbs_buffer_desc *desc, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
+ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
+	    ib_umem_buf_desc_filler_t legacy_filler, bool va_fallback, u64 addr,
+	    size_t addr_size, size_t min_size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
 					     unsigned long addr, size_t size,
 					     int access)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline struct ib_umem *ib_umem_get_attr(struct ib_device *device,
+					       struct ib_udata *udata,
+					       u16 attr_id, size_t size,
+					       int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
+						     struct ib_udata *udata,
+						     u16 attr_id, u64 addr,
+						     size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e2af17da3e32..db5d51c027b7 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -590,6 +590,18 @@ struct uapi_definition {
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
 /* =================================================
  *              Parsing infrastructure
  * =================================================
@@ -863,6 +875,9 @@ int uverbs_get_flags32(u32 *to, const struct uverbs_attr_bundle *attrs_bundle,
 		       size_t idx, u64 allowed_bits);
 int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle, size_t idx,
 		   const void *from, size_t size);
+int uverbs_attr_get_buffer_desc(struct uverbs_attr_bundle *attrs,
+				u16 attr_id,
+				struct ib_uverbs_buffer_desc *desc);
 __malloc void *_uverbs_alloc(struct uverbs_attr_bundle *bundle, size_t size,
 			     gfp_t flags);
 
@@ -919,6 +934,12 @@ static inline int uverbs_copy_to(const struct uverbs_attr_bundle *attrs_bundle,
 {
 	return -EINVAL;
 }
+static inline int
+uverbs_attr_get_buffer_desc(struct uverbs_attr_bundle *attrs, u16 attr_id,
+			    struct ib_uverbs_buffer_desc *desc)
+{
+	return -EINVAL;
+}
 static inline __malloc void *uverbs_alloc(struct uverbs_attr_bundle *bundle,
 					  size_t size)
 {
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 90c5cd8e7753..6dfb95d56770 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -273,4 +273,27 @@ struct ib_uverbs_gid_entry {
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
+ * @reserved: must be zero
+ * @addr: offset within dma-buf, or user virtual address for VA
+ * @length: buffer length in bytes
+ */
+struct ib_uverbs_buffer_desc {
+	__u32 type;
+	__s32 fd;
+	__u32 reserved[2];
+	__aligned_u64 addr;
+	__aligned_u64 length;
+};
+
 #endif
-- 
2.54.0


