Return-Path: <linux-rdma+bounces-19916-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMTzOkmm+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19916-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414A84BE43C
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34A2303CC0C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E93DDDC7;
	Mon,  4 May 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ze+lkmMn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAC3D47D0
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903063; cv=none; b=iXl0aZdXVBNKEprfoSfz9dtMxbyzMYtCXWAUnaf+UaK8Qa9YimjfHakMQN1VUvi4aD77nsOzdbUudDt7YLMBMJJDc7xiPCIrRaKT4sLbxqprseKJWb3XW3hKx5Yfr6glOcmnB1pdeo9rrBcNdO1F1h+6+1j/r/NsgVwdPDsNbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903063; c=relaxed/simple;
	bh=Wp75SvxGhlNQCgzX/68JuUtSRZunNdu4UGnxJ12Qj7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3OxvqwK7z9aVSHu99R99vi7zRw24xQfHZH1CVnkhSsg7WgNtO19sY4Fi5Fuyu9MiFJTNOEqEJBBzvgaNIcNwiRfph9KK7WGJzWqYb+L3SVcFfzhtjnisiGXeGHdK1g/RWUE82r2Q0kCIcFbGmyBJbnBkRJmoag55kU68OeGztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ze+lkmMn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so37588675e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903060; x=1778507860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er02l8yQoAGzugDhVNs+bGzpPeBWYBtLmhEJITbBYvw=;
        b=ze+lkmMn2lX5S+jJEkFs20OO66urm1TE22xt6GMIOKOoANcDToibSjCiuPeHhRGnBO
         fzrIQW0rpqDdqULyLr13kHHmx3rRicnXNK7eFqg7LBRVYAalj0hqFa5FrmTxIgFNEKlV
         BzEiMlZmF7T9EwNbFKV8+d2ebAEiOI3SxWdgeHDo8EvyrQ3jWGJok1dyXKZLmNsZSY7k
         e0JNXLQ48hkcigalnRRuxIodFcgpdFI3qFX4tEidunGHAmKU2M5+vBsa2K6ENFiTPit8
         81oGg560X1Wv/SqDGfSMBz64U4/mZIF7zkcNU1cibp6Pcut7IeO5pGBOhvEk3/cSWnC3
         HCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903060; x=1778507860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=er02l8yQoAGzugDhVNs+bGzpPeBWYBtLmhEJITbBYvw=;
        b=eKkGH60uLszORlwKNNoNaZvdJkyYvt3bvdfMhx2sWpeI//V2syqrVgPwAirVyE8qdw
         1HPciOqJMeyXaL7TLhI8cFuhG9ZoaX1lFkgkglI6mq7A2GayzyP+/czJs3b7tEr0lmen
         JdJfuLCjyuB+PUaUfHSvgkO5KEsM5ObfLS80m03KG7Z+LrCNuiQynmpbbctJF6On0hS1
         xsEuTavzcLvvaoSFii+ylh8bcAuxCWQCpJrp+qHJc1XCBWiahZmOw2f+q1yNo98YCckT
         A1g+Tx05Pts304N7KcBSOgz6+ysXUuzKPlaqTRrHR1Nt0S9k+wZjt/WQriHwbecoSkWz
         2QYA==
X-Gm-Message-State: AOJu0YzhJx82newa4Dh/hAgFoiCyxkgssQWWBRJlSsVEPMEonb4yzU2l
	ZiB+JVbzODqcU/hL//3wsYJuVGVRCqMEgS2u6ZU/G7ClEXvi9WDo6ovX6Vk+n2WNyZwX6wmp7p2
	cwyM6HpI=
X-Gm-Gg: AeBDiesK41CZ/SG96diAZxL+kmmh6QC3oVAfQmG1BQdirNvygd4dW8ibTZu8cJrFOns
	mg0Uf8zREepwa3bpPcwmASHv+C5CnhF1kbxgBgtUzzKOYw2RmSUWK3fc4l6zu/cQm/S0rZlTnf4
	dXMxtTfVjlPLmpjoaPh6B92S59QCaQzK9rCrtHV5rwyvD2Ifzf4Y6No7L5xN6B1J8qxncB5GClX
	DU1s50GX1FHwq3NBH96zYiVv7WhWhZdmLZEO33mlWKvpzlLs+zGnQWrmp9CHaRqkTanRjIZ73s5
	KVsEYoL5wWWGULzDoqDzKXKZ1vgA+gLs8J9Vco2A+iSPwS9k+NXuTcwPdMFGy+2eGYnH7PGoj8l
	QfDYB4iMJuz0+oKPJHRHEOZ8WKugotzEHECbpp4g6OayiiYqIiPDHzrblaZovNCwrlBjCcMnX9H
	ooqZW7vL881nd8j1IOxiFKU/Te
X-Received: by 2002:a05:600c:5290:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48a988c0fd9mr182094435e9.24.1777903060449;
        Mon, 04 May 2026 06:57:40 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fea094esm106213705e9.3.2026.05.04.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:39 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer descriptor infrastructure for umem
Date: Mon,  4 May 2026 15:57:17 +0200
Message-ID: <20260504135731.2345383-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 414A84BE43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19916-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Introduce a per-attribute UVERBS_ATTR_UMEM model so each uverbs
command's umem set is explicit in its UAPI definition. Add
driver-facing wrapper helpers that pin a umem on demand from an
attribute or a VA addr; the driver owns the returned umem and
releases it from its destroy/error paths.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- pushed out desc processing to ib_umem_get_desc()
- replaced UVERBS_ATTR_BUFFERS array with per-attribute UVERBS_ATTR_UMEM
- struct ib_uverbs_buffer_desc: dropped .index, moved .type first,
  bumped reserved to __u32 reserved[2]
- added canonical ib_umem_get() + two inline wrappers
  (_attr, _attr_or_va)
- dropped ib_umem_list_* family + ib_umem_release_non_listed()
---
 drivers/infiniband/core/umem.c          | 105 ++++++++++++++++++++++++
 include/rdma/ib_umem.h                  |  55 +++++++++++++
 include/rdma/uverbs_ioctl.h             |  12 +++
 include/uapi/rdma/ib_user_ioctl_verbs.h |  23 ++++++
 4 files changed, 195 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 6e0906f0f5c4..d9073b1012bc 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -272,6 +272,111 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 	return ret ? ERR_PTR(ret) : umem;
 }
 
+static struct ib_umem *
+ib_umem_get_desc(struct ib_device *device,
+		 const struct ib_uverbs_buffer_desc *desc, int access)
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
+ * @size:          driver-required minimum length.
+ * @access:        IB access flags forwarded to ib_umem_get_desc().
+ *
+ * Return: valid umem on success, ERR_PTR(...) on error, NULL
+ * if no source produced a buffer (only possible when @va_fallback is false).
+ */
+struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
+			    u16 attr_id,
+			    ib_umem_buf_desc_filler_t legacy_filler,
+			    bool va_fallback, u64 addr, size_t size, int access)
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
+		ret = uverbs_copy_from(&desc, attrs, attr_id);
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
+			if (have_desc) {
+				ibdev_err(device,
+					  "UMEM attr (id=%u) and legacy attrs are mutually exclusive\n",
+					  attr_id);
+				return ERR_PTR(-EINVAL);
+			}
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
+		.length	= size,
+	};
+
+have_desc:
+	umem = ib_umem_get_desc(device, &desc, access);
+	if (IS_ERR(umem))
+		return umem;
+	if (umem->length < size) {
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
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 25e90766892e..4897c7599fa3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -73,10 +73,44 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
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
 
+struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
+			    u16 attr_id,
+			    ib_umem_buf_desc_filler_t legacy_filler,
+			    bool va_fallback, u64 addr, size_t size, int access);
 struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 			       size_t size, int access);
+
+static inline struct ib_umem *
+ib_umem_get_attr(struct ib_device *device, struct ib_udata *udata,
+		 u16 attr_id, size_t size, int access)
+{
+	return ib_umem_get(device, udata, attr_id, NULL,
+			   false, 0, size, access);
+}
+
+static inline struct ib_umem *
+ib_umem_get_attr_or_va(struct ib_device *device, struct ib_udata *udata,
+		       u16 attr_id, u64 addr, size_t size, int access)
+{
+	return ib_umem_get(device, udata, attr_id, NULL,
+			   true, addr, size, access);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -160,12 +194,33 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #include <linux/err.h>
 
+static inline struct ib_umem *
+ib_umem_get(struct ib_device *device, struct ib_udata *udata, u16 attr_id,
+	    ib_umem_buf_desc_filler_t legacy_filler, bool va_fallback, u64 addr,
+	    size_t size, int access)
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
index e2af17da3e32..76e94ede668e 100644
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
2.53.0


