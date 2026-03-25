Return-Path: <linux-rdma+bounces-18620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLs4Li4DxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:45:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B132854C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3834D312D21B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0383FFAAE;
	Wed, 25 Mar 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2ZBusll+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8253FCB25
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450856; cv=none; b=mIURnL7XDoIWa0lRf+rxtfyzBkJpV1VleRmmEpA/GXidM8X6+7FWJgv8TPhHNAnBMPJM+u15Lz5mtH+K+rGd612duR4kM4CF77JRm/2+M5ruXIkHANsW3PMQtK7Ml9k+TxI2vAoUCz8CicYvkZgyzUq16i2Ihgo51UiYvFHXvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450856; c=relaxed/simple;
	bh=m8Maetn/AfCR7BnGPTc2AB/dlmtqG8e/x8OmwZCeHxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vjv86iL5FQlOwp6QojC33lNA6QdNdl7NACWXtEq19P3Uxn7J85W09IWmWijjS+uoDnQyyOwo7jZeB3xEpcl8Gn2MJXYIo/7SPJ0zE8kp9LVbPR9Z+aU8DB1bSkvuC8bOnILLMxPzlkiUMqIrbwgFtGwBkgxRINGeXDfjw/UJ6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2ZBusll+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso19497925e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450851; x=1775055651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7Hg5DwMpB0UhH7SUutynHj9KGP5zTubB7rDRHVs8AI=;
        b=2ZBusll+2JgbjD12e+J0xTEFfqvGsWV9sGgRg7Ka3Gz7XtoxCj8FG1jGWHFKTNB9Pg
         M8mIs+M3MQZzDDTnGZEoSRcLcY0ThSU4+gnGyAfFVUJKKd4sURmAsQYs1n9KGhdGKgbf
         lB+pbU+7dfLKF0+ZedUtttRvpxcfUBw3C/lMMhrkpxMwmzmFWn5DRGSzjIxXm67YwEpq
         BGUgD8RENCn5Wif+nyNYHZ59XKxobGhhdtTgL/Vd6JMlJ3Tk+QcfY7uiHs8BnbGbp4fy
         rgARLXOmYhMRzZmWMnFk/xSV7Iu6LeuDtItKfVHbkuYk1umqc7YgYCzlqtiWCbk1Ag9j
         HUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450851; x=1775055651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7Hg5DwMpB0UhH7SUutynHj9KGP5zTubB7rDRHVs8AI=;
        b=T/xCuITU/jCqwKYYQQZiEOA2ngmHqbZbpYke+HoAiLZOHcsHqX4XvEdcXkqlmwRdYY
         oMlseuLhAiDbUtfnXR1IN+wmB0/X6uZqdWjhWC8IaAxblhqSoPD3zcBDj40D7Q9UGbVs
         +xUpmLUI/m5ECXKEzPibr8HDe6BThKNXIPRgjWVKZhnnlvsCgSbGpnRTtnU/TkKrH4Bx
         2hRjaXmslR++LomE2JDDzvfz8ETd/Ww1qKUEnZm2hXV9EIMlzh7JmrgBQQlMHMhkIlco
         FznZ+XSgTiQ9J+dAENixKF+9pZT/ApeELBD8vNxhwRYiWSjhIh6MPdy9ewGdylOtwWKp
         yEfg==
X-Gm-Message-State: AOJu0YxgD2RS6Wn6VqFPCU+8xNk76rPGocMRvWqPTJc5BFeADPTrxkyw
	MoRzYrmGpdMvyrtHmSC6WPAOEJ7Y9NQv2XY0biBK1l3wi5NUB6hCbTRj/XGGcc6LC/gJYBrfvCL
	S/N3teP0=
X-Gm-Gg: ATEYQzyyqPpQ3VFOJcR2I4aRovSwl31DOpMWN8kDLft9dVdCGDZgByv8zFLmlzCH1S0
	tLyZOkYl0Y1aukqgqZkelgCrdhBfu19Le10m6TPa48Ohu2G8oFC2BKsmrlSde+RqTuDkbPuCVmx
	BaqSZVU5z6+T/6Yea26+rcT32vvD2/VqJh/jpm9AMItjJkMWW/fkdRlJVM2q8IlhMIp8QlaCLQu
	AwE/jojzMxDQnmmN5NjNaMW6pmR+laRWp10bRl7fRgdwKuKDy6zrGW4O6oJ51Ngh41PjXsMAzhr
	+Hy6Hrvi2MvioGLaMMz/u+KmmYllB4jZLUl9LEmRbO/GOYndgMeu/6YeoCfY5xpmRM+8UIMwosv
	rj3PiIgt/MtzslVZ2z2Ws5BTPQ+2s4BXH4jD7FQ23hRZI0qP17BfYFGphOuTopg7iZKP0baxm/6
	+G/LmHPbjST29KFA==
X-Received: by 2002:a05:600c:4685:b0:486:5f71:5829 with SMTP id 5b1f17b1804b1-48715fc3870mr60505495e9.5.1774450850896;
        Wed, 25 Mar 2026 08:00:50 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e6cb664sm298685e9.12.2026.03.25.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:50 -0700 (PDT)
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
Subject: [PATCH rdma-next 01/15] RDMA/core: Introduce generic buffer descriptor infrastructure for umem
Date: Wed, 25 Mar 2026 16:00:34 +0100
Message-ID: <20260325150048.168341-2-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18620-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 183B132854C
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
index 4eef7b76fe46..b430a331844a 100644
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
index 38414281a686..1e00a3a524af 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -11,6 +11,7 @@
 
 struct ib_device;
 struct dma_buf_attach_ops;
+struct uverbs_attr_bundle;
 
 struct ib_umem {
 	struct ib_device       *ibdev;
@@ -79,6 +80,36 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
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
@@ -229,5 +260,28 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
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
2.51.1


