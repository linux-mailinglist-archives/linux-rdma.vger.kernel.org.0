Return-Path: <linux-rdma+bounces-19229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMlUMLpf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5853E06E3
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1904430570D5
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C0387361;
	Sat, 11 Apr 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="rmTXlunX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341C246774
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918964; cv=none; b=nf96Rl72iCcwr37Q8LT18waVuWzpVKxcKFbKJg/OielGHSr7ZZz8NHXCl3EZqNs272/Dd9uHoioRYz2fIeM7feoP9QFakd+iN19yA20zfeASpLXwnvUrUgv/Wg42vMv5MIrT0ElYMywmGJJ7JSfR7mFMzS1EH0Mwhph7/n8LIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918964; c=relaxed/simple;
	bh=zXdplC+SZBcw8Jf4OCjiPzlTkT4ziN3XRsXOuXzKy68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU2J16Pg//V6JNRGf3ROAuRvbmbv8lK98H28VnrFYdsJR5JATp5plKKT7n4h951P2MLipsj/hiO0U+AbBGv8RTmeBw5zFzHojpEn44vJY7b8oTqKaOoMin3TbEA6EKnaNYqSogNPNOjCnv4eLj7mIgABlGVlViKIayjmF98kti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=rmTXlunX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so39640105e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918959; x=1776523759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znxG3+G2Ges7Vf0rL9Z2hp6aINp8xWm8GVYlmCq4JcU=;
        b=rmTXlunXoV88wE+SSXhCGUgnI89ZgEk04FL/w/LKUMokf7ufAOtYiNq8xxN3stUgGU
         aytmPK4OFr6lT+/t+Xw/CT1swSof7LlaZ7AXS6Z0siHa+XrwL3L51eoySLUb//gRYaPi
         CKCEeRwD1KfB7jdTPLpkUZKVz5RRnF9lOI/wUarkEdArN1EIIU0U5oggGE6RjDrf4lsa
         HcjNnIirGzUEvGA8Ch93mcctMwAnHmWvnVWT9WkjL7NxfU9W4n8wvN+3WaVh0uFXu24W
         qR2pJOBbJbE92VWJqlM3rNqFhzGsvB9DCBTqhyYUz2hHIbMtHkYHVt5myi+2VHlsJoCm
         ZMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918959; x=1776523759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znxG3+G2Ges7Vf0rL9Z2hp6aINp8xWm8GVYlmCq4JcU=;
        b=XgUQ72ZtRjWewvdqphnY7kWkUx1HpzFZhkFJr14arFjJjXz8V/W6Y6ujXcfjpGdLjp
         HGdB400A4pjPcA2k/6syTWFMINE/c37jPKnyNjxuZmwjw2MctUqlP3r5J7DKzmvd4QiA
         e70e+j76uDuLOcop9sPBVHaifgTb4UOWALeYei1n5XidyZYLdBzZkw9JmBti9oJFhBiT
         rMA7PaRYoZl4Un5EU49hX0JW9noQ9S9Eb7tRt62uNWiqSpZrHNJFsx4LqdPXkcu5RIuK
         /VVzam1OFMDWmRlLHBOvZOYYuwzmal5vKwJ/JG5bi97cUHyPMdou+ICDHprIFbOSsO5A
         6K8g==
X-Gm-Message-State: AOJu0YwpkkbrUzO80va/abr0H+IEUC+IDIWjc962eG0mULEwBYMSVnz0
	bPKZ3Fa4BPB7kHFVTtD+5/rklFk3/pTMLzCo9HenYZREVZJbvyoLp2VFiSAda7hZ8/dU+PM1PpK
	N/C96
X-Gm-Gg: AeBDievzl6lANTtztM2T1UrkFuFoIyGqRCtzBmsZ0sLC4NDe1Q+1i6ttwLQa7M4VjB7
	S52ACfaBAiIbfNy24DiDJPVCIIXxeOokOUC7SWZM488y0YdK2J513WVfTmatMT1kFt1M6snIA5Y
	bcbLrSNzOj5d2axnx6zd3uLyhhBjIX+N9lNGH42ucRjmgXjfl+737eNTf4W1eiKsYjMioW2oh/l
	VqGOxb8LL8QnvZ64DofBYpwr2BQl7OL8njZFGl0oUQeBAESOhMUpXRCJU/W/XHWyquhGTx4/4ml
	hxlnbZSFVRYbMQGwFx/68aKpqEWvPBCAMAlhyZys7sUcecyVcYqn6TUVvH+ADbAnrZ/uEqJkFI6
	fgJYA4bpkvcOjqsrsMPnDaGwORPlm5RKzfPfPrt4SsbvQmVcEK2YdJDfCwkZ0yAfVReS1dYGeni
	8Jf57E8jA2jME65isZkPiEatIYrcE99AcNwXPI7WYSNi0=
X-Received: by 2002:a05:600c:30d2:b0:488:e192:6fb5 with SMTP id 5b1f17b1804b1-488e19270cbmr11353835e9.24.1775918958640;
        Sat, 11 Apr 2026 07:49:18 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d53808b2sm177577905e9.11.2026.04.11.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:18 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer descriptor infrastructure for umem
Date: Sat, 11 Apr 2026 16:49:01 +0200
Message-ID: <20260411144915.114571-2-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19229-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2A5853E06E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Add a unified mechanism for userspace to pass memory buffers to any
uverbs command via a single UVERBS_ATTR_BUFFERS attribute. Each
buffer is described by struct ib_uverbs_buffer_desc with a type
discriminator supporting dma-buf and user VA backed memory, extensible
for future buffer types.

The ib_umem_list API enables any uverbs command to accept multiple
buffers indexed by per-command slot enums, without requiring new UAPI
attributes for each buffer. A consumption check ensures userspace and
driver agree on which buffers are used.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/umem.c          | 248 ++++++++++++++++++++++++
 include/rdma/ib_umem.h                  |  54 ++++++
 include/rdma/uverbs_ioctl.h             |  14 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h  |   1 +
 include/uapi/rdma/ib_user_ioctl_verbs.h |  27 +++
 5 files changed, 344 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 786fa1aa8e55..f5b03e903b9d 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -37,6 +37,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
+#include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
@@ -332,3 +333,250 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		return 0;
 }
 EXPORT_SYMBOL(ib_umem_copy_from);
+
+struct ib_umem_list {
+	unsigned int count; /* Total slots in the list. */
+	unsigned long provided; /* Bitmask of slots provided by the user. */
+	unsigned long loaded; /* Bitmask of slots loaded by the driver. */
+	struct ib_umem *umems[] __counted_by(count);
+};
+
+/**
+ * ib_umem_list_create - Create a umem list from UVERBS_ATTR_BUFFERS
+ * @device: IB device
+ * @attrs: uverbs attribute bundle
+ * @slot_max: highest buffer slot index (count = slot_max + 1)
+ *
+ * Return: umem list, or ERR_PTR on failure.
+ */
+struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 unsigned int slot_max)
+{
+	const struct ib_uverbs_buffer_desc *descs;
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct ib_umem_list *list;
+	struct ib_umem *umem;
+	unsigned int count;
+	int num_descs;
+	int err;
+	int i;
+
+	if (WARN_ON_ONCE(slot_max >= BITS_PER_LONG))
+		return ERR_PTR(-EINVAL);
+	count = slot_max + 1;
+
+	num_descs = uverbs_attr_ptr_get_array_size(
+		(struct uverbs_attr_bundle *)attrs, UVERBS_ATTR_BUFFERS,
+		sizeof(*descs));
+	if (num_descs == -ENOENT) {
+		num_descs = 0;
+		descs = NULL;
+	} else if (num_descs < 0) {
+		return ERR_PTR(num_descs);
+	} else if (num_descs > count) {
+		return ERR_PTR(-EINVAL);
+	} else {
+		descs = uverbs_attr_get_alloced_ptr(attrs, UVERBS_ATTR_BUFFERS);
+		if (IS_ERR(descs))
+			return ERR_CAST(descs);
+	}
+
+	list = kzalloc(struct_size(list, umems, count), GFP_KERNEL);
+	if (!list)
+		return ERR_PTR(-ENOMEM);
+	list->count = count;
+
+	for (i = 0; i < num_descs; i++) {
+		unsigned int idx = descs[i].index;
+
+		if (descs[i].reserved) {
+			err = -EINVAL;
+			goto err_release;
+		}
+		if (idx >= count || (list->provided & BIT(idx))) {
+			err = -EINVAL;
+			goto err_release;
+		}
+
+		switch (descs[i].type) {
+		case IB_UVERBS_BUFFER_TYPE_DMABUF:
+			umem_dmabuf = ib_umem_dmabuf_get_pinned(
+				device, descs[i].addr, descs[i].length,
+				descs[i].fd, IB_ACCESS_LOCAL_WRITE);
+			if (IS_ERR(umem_dmabuf)) {
+				err = PTR_ERR(umem_dmabuf);
+				goto err_release;
+			}
+			list->umems[idx] = &umem_dmabuf->umem;
+			break;
+		case IB_UVERBS_BUFFER_TYPE_VA:
+			umem = ib_umem_get(device, descs[i].addr,
+					   descs[i].length, IB_ACCESS_LOCAL_WRITE);
+			if (IS_ERR(umem)) {
+				err = PTR_ERR(umem);
+				goto err_release;
+			}
+			list->umems[idx] = umem;
+			break;
+		default:
+			err = -EINVAL;
+			goto err_release;
+		}
+		list->provided |= BIT(idx);
+	}
+
+	return list;
+
+err_release:
+	ib_umem_list_release(list);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(ib_umem_list_create);
+
+/**
+ * ib_umem_list_release - Release all umems in the list and free it
+ * @list: umem list
+ */
+void ib_umem_list_release(struct ib_umem_list *list)
+{
+	int i;
+
+	if (!list)
+		return;
+	for (i = 0; i < list->count; i++)
+		ib_umem_release(list->umems[i]);
+	kfree(list);
+}
+EXPORT_SYMBOL(ib_umem_list_release);
+
+/**
+ * ib_umem_list_check_consumed - Verify all provided umems were loaded
+ * @list: umem list
+ *
+ * Return: 0 if all provided slots were loaded, -EINVAL otherwise.
+ */
+int ib_umem_list_check_consumed(const struct ib_umem_list *list)
+{
+	return (list->provided & ~list->loaded) == 0 ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL(ib_umem_list_check_consumed);
+
+/**
+ * ib_umem_list_insert - Insert a umem into the list at a given index
+ * @list: umem list
+ * @index: per-command buffer slot index
+ * @umem: umem pointer to store
+ *
+ * Stores @umem at @index (replacing any existing). For use from create_cq
+ * when the buffer comes from legacy ATTRs rather than the buffer list.
+ */
+void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
+			 struct ib_umem *umem)
+{
+	ib_umem_list_replace(list, index, umem);
+	if (umem)
+		list->provided |= BIT(index);
+}
+EXPORT_SYMBOL(ib_umem_list_insert);
+
+/**
+ * ib_umem_list_load - Load a umem from the list by index
+ * @list: umem list (may be NULL)
+ * @index: per-command buffer slot index
+ * @size: minimum required umem length
+ *
+ * Return: umem pointer, or NULL if the slot is empty or
+ * the slot is out of bounds, or ERR_PTR(-EINVAL) if the umem is too small.
+ */
+struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
+				 unsigned int index, size_t size)
+{
+	struct ib_umem *umem;
+
+	if (!list || index >= list->count)
+		return NULL;
+	umem = list->umems[index];
+	if (!umem)
+		return NULL;
+	if (umem->length < size)
+		return ERR_PTR(-EINVAL);
+	list->loaded |= BIT(index);
+	return umem;
+}
+EXPORT_SYMBOL(ib_umem_list_load);
+
+/**
+ * ib_umem_list_load_or_get - Umem from list or pin user memory
+ * @list: umem list (may be NULL)
+ * @index: per-command buffer slot index
+ * @device: IB device for ib_umem_get when the list slot is empty
+ * @addr: user virtual address for ib_umem_get
+ * @size: length for ib_umem_get
+ * @access: access flags for ib_umem_get
+ *
+ * If @list has a umem at @index, returns it like ib_umem_list_load() (and
+ * marks the slot loaded). Otherwise calls ib_umem_get() with the given
+ * @access flags and on success stores the result at @index when
+ * @list is non-NULL.
+ *
+ * Return: valid umem pointer, or ERR_PTR.
+ */
+struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
+					 unsigned int index,
+					 struct ib_device *device,
+					 unsigned long addr, size_t size,
+					 int access)
+{
+	struct ib_umem *umem;
+
+	umem = ib_umem_list_load(list, index, size);
+	if (IS_ERR(umem) || umem)
+		return umem;
+	umem = ib_umem_get(device, addr, size, access);
+	if (IS_ERR(umem))
+		return umem;
+	if (list && index < list->count)
+		list->umems[index] = umem;
+	return umem;
+}
+EXPORT_SYMBOL(ib_umem_list_load_or_get);
+
+/**
+ * ib_umem_list_replace - Replace umem at index, releasing the previous one
+ * @list: umem list (may be NULL)
+ * @index: per-command buffer slot index
+ * @umem: new umem pointer (may be NULL to clear the slot)
+ *
+ * Stores @umem at @index. If a different umem was already stored there, it is
+ * released. Used for CQ resize and similar.
+ */
+void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
+			  struct ib_umem *umem)
+{
+	struct ib_umem *old;
+
+	if (!list || index >= list->count)
+		return;
+	old = list->umems[index];
+	list->umems[index] = umem;
+	if (old && old != umem)
+		ib_umem_release(old);
+}
+EXPORT_SYMBOL(ib_umem_list_replace);
+
+/**
+ * ib_umem_release_non_listed - Release a umem that is not stored in the list
+ * @list: umem list
+ * @index: per-command buffer slot index
+ * @umem: umem pointer to release
+ *
+ * Releases @umem if it is not stored in @list.
+ */
+void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
+				struct ib_umem *umem)
+{
+	if (!list || index >= list->count || list->umems[index] != umem)
+		ib_umem_release(umem);
+}
+EXPORT_SYMBOL(ib_umem_release_non_listed);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 2ad52cc1d52b..924acb8d08c3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -11,6 +11,7 @@
 
 struct ib_device;
 struct dma_buf_attach_ops;
+struct uverbs_attr_bundle;
 
 struct ib_umem {
 	struct ib_device       *ibdev;
@@ -80,6 +81,36 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
+
+/**
+ * struct ib_umem_list - collection of pre-mapped umems
+ *
+ * Created from the UVERBS_ATTR_BUFFERS attribute. Each entry is indexed
+ * by a per-command buffer slot enum (e.g., IB_UMEM_CQ_BUF for CQ CREATE).
+ * Drivers use ib_umem_list_load() to retrieve a specific umem by index.
+ */
+struct ib_umem_list;
+
+struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
+					 const struct uverbs_attr_bundle *attrs,
+					 unsigned int slot_max);
+void ib_umem_list_release(struct ib_umem_list *list);
+int ib_umem_list_check_consumed(const struct ib_umem_list *list);
+void ib_umem_list_insert(struct ib_umem_list *list, unsigned int index,
+			 struct ib_umem *umem);
+
+struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
+				  unsigned int index, size_t size);
+struct ib_umem *ib_umem_list_load_or_get(struct ib_umem_list *list,
+					 unsigned int index,
+					 struct ib_device *device,
+					 unsigned long addr, size_t size,
+					 int access);
+void ib_umem_list_replace(struct ib_umem_list *list, unsigned int index,
+			  struct ib_umem *umem);
+void ib_umem_release_non_listed(struct ib_umem_list *list, unsigned int index,
+				struct ib_umem *umem);
+
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
 				     unsigned long virt);
@@ -230,5 +261,28 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
 static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
+struct ib_umem_list;
+
+static inline void ib_umem_list_release(struct ib_umem_list *list) { }
+static inline struct ib_umem *ib_umem_list_load(struct ib_umem_list *list,
+						unsigned int index,
+						size_t size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct ib_umem *
+ib_umem_list_load_or_get(struct ib_umem_list *list, unsigned int index,
+			 struct ib_device *device, unsigned long addr,
+			 size_t size, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline void ib_umem_list_replace(struct ib_umem_list *list,
+					unsigned int index,
+					struct ib_umem *umem) { }
+static inline void ib_umem_release_non_listed(struct ib_umem_list *list,
+					      unsigned int index,
+					      struct ib_umem *umem) { }
+
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 #endif /* IB_UMEM_H */
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e2af17da3e32..05bcab27a87d 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -590,6 +590,20 @@ struct uapi_definition {
 			    UA_OPTIONAL,                                       \
 			    .is_udata = 1)
 
+/*
+ * Optional array of struct ib_uverbs_buffer_desc describing memory regions
+ * backed by dma-buf or user virtual address. Can be added to any method
+ * that needs external buffer support.
+ * Each entry carries an index field selecting the per-command buffer slot.
+ * Use ib_umem_list_create() to map them and ib_umem_list_load() to access.
+ */
+#define UVERBS_ATTR_BUFFERS()                                                  \
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_BUFFERS,                               \
+			   UVERBS_ATTR_MIN_SIZE(                               \
+				sizeof(struct ib_uverbs_buffer_desc)),         \
+			   UA_OPTIONAL,                                        \
+			   UA_ALLOC_AND_COPY)
+
 /* =================================================
  *              Parsing infrastructure
  * =================================================
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 72041c1b0ea5..10aa6568abf1 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -64,6 +64,7 @@ enum {
 	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
 	UVERBS_ATTR_UHW_OUT,
 	UVERBS_ID_DRIVER_NS_WITH_UHW,
+	UVERBS_ATTR_BUFFERS,
 };
 
 enum uverbs_methods_device {
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 90c5cd8e7753..41ed9f75b4de 100644
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
+ * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
+ * accepts this attribute defines its own per-command buffer slot enum.
+ * The index field selects the buffer slot this descriptor maps to.
+ *
+ * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
+ * @type: buffer type from enum ib_uverbs_buffer_type
+ * @index: per-command buffer slot index
+ * @reserved: must be zero
+ * @addr: offset within dma-buf, or user virtual address for VA
+ * @length: buffer length in bytes
+ */
+struct ib_uverbs_buffer_desc {
+	__s32 fd;
+	__u32 type;
+	__u32 index;
+	__u32 reserved;
+	__aligned_u64 addr;
+	__aligned_u64 length;
+};
+
 #endif
-- 
2.53.0


