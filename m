Return-Path: <linux-rdma+bounces-16422-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFG4LNO2gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16422-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B09D6601
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D12DB301C565
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AC2392C4C;
	Tue,  3 Feb 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y+qEn+uw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D61392C3A
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108611; cv=none; b=jzmpvPxNSUTksMHd3P+eRP5touxrh5dKt+OfrCjzySKoyEnS7zHpquGaOjr6fcgV/8uQz0Q9kxVWfQ/OIxPFlDn4wSw7HvOsaX2JihCkSLVvwFwISdE7gZ8ujWMiiPYXKpQcwhzSPMdM5LaJU66nx9wIuY1pIR4D4wYoudcRTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108611; c=relaxed/simple;
	bh=pv3mSeEWlqxRTCf5n0BbaG9G8jzDkPguLGSPDrGuTUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joZqxSeILMoalt+g1OTly/cY138H7XtqG6QFRImE+jE+rlb1sN7j993898RGT9aKDv8YFXhtai5Uf0VPO5oZKxM4a2eRCSLKlVZ4f6GA3z3XP0QobS/S7AKPBfJBk5rrFstHZS1IQQn6kl9P8ApRNF0VJwzbjnNR/ijbjwNJWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Y+qEn+uw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so56914325e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108606; x=1770713406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+1ZJcDT5cS0bMwkYCrlpEQ8pa1JKseCWzEDe2/Ia0o=;
        b=Y+qEn+uw62aYyST7Cu4yxKW0gBkC18HSvMtBi3nxSy6+xU+nTutRxZNvtZ2BAdH+6H
         UapJpwS9OO/DMmYBYD94ZQUTqL7DJC4cLHhFBfCCpAU/ynu02MJcZjSEk3dhKdUk9dKf
         vL+nA54cJ9dPpm6ZmC4hPJlPelgDkkSluY+b4zqjM/RaiNrLBZxYJs+y0j1GJyJfdgjM
         XQBPesa1KP13dbLboM/J8G1/bPg1HN4NJWGR1xDxcVtJBxj+nZLiOyl7Xm0oBGWawHcB
         WOAI2PKqu/XUXSkQ9tIpnzGUmX7A3oI6OE80aWYmrNVEQ+nNUPdg4IarRvjN9rJeU1cI
         oUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108606; x=1770713406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+1ZJcDT5cS0bMwkYCrlpEQ8pa1JKseCWzEDe2/Ia0o=;
        b=qd8psWx/++nSBPG2oONGLs2APBCLbFlTdl+6wf85u67anEnTAvjoP/nZ6L4iIuWv27
         751yritUrR+XkMzHiyXSiHtlsQsPKjy6KqivobXt9U54b7/qGVWo2XeBzh9u0Oroa/gr
         NKGkW9+BkdWnPD7/dsG3mDlvnNCKIMfFWvSuj4c2yfviRRk54Ryzdzyj5lpgS08jPCXa
         Ze/OZOTWZSrEftx4T4jojEXP3ntXbTcbjIx58UB/kZGO8BK9W2z7eKBG7otkNdA6HEJH
         KKtE18fgXFSdHqwNuuZqva0WA4XtGF3J5ei6suhxryuNgjU8jE0uJnI93orPGSi+ibgO
         iEJw==
X-Gm-Message-State: AOJu0YzykIuS7xanP/J+r7cm5eHmYMRac/Iqv+RZrZjljmD4HqyNpm1o
	qgi4KoiRtRtDQyYFgBJuaOHds0UxRw4N9reoDxGsd9P3f3nufI8GfBmC3KjmIFyvsRkdN6fOwO2
	+ZQyf
X-Gm-Gg: AZuq6aKFz33FLP5sgBGIOFCuJ2rL6nI9KvgIJ9uSrIsJetMa4vOZS/AUUbDRMJHdxVE
	fl94EByWpf0J5nWrdh4mmQR5geNcmbnxOuql/R6H+ay9b4rJliT3L4tCg0dIs4+XMbPKh4i9td7
	bZgcyo82hMFRgn/IwmeViBxljfkkvtt9FOVGchI3A6Y8smwXP53MxOvlGGMoHkuNJLsGV7RtBf1
	7LOfdbRpwxZCS2L4TEKKYttWEaX0NeJ9CsCBNVQDOCLgMRBwKkS9yjbp7/tfx8hmLAYZOZvYoiF
	5bTNsVqv18p59js0bPejBDbkbbwiaTctDorxS52E//zl7s/BmmIPC93KToQaZqwMp4u+DMGEtxX
	yrnRMqt6epKO+QMG7IeAsHQeooCFx/VJJ2gWis9Xw95Ncx0JHoucuj7Z/nk73J60qiQlBejOjP1
	mNfg==
X-Received: by 2002:a05:600c:4f47:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-482db460714mr210577975e9.10.1770108606013;
        Tue, 03 Feb 2026 00:50:06 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511ccd0sm43254205e9.1.2026.02.03.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:05 -0800 (PST)
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
Subject: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to ib_umem
Date: Tue,  3 Feb 2026 09:49:53 +0100
Message-ID: <20260203085003.71184-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16422-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94B09D6601
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Introduce reference counting for ib_umem objects to simplify memory
lifecycle management when umem buffers are shared between the core
layer and device drivers.

When the core RDMA layer allocates an ib_umem and passes it to a driver
(e.g., for CQ or QP creation with external buffers), both layers need
to manage the umem lifecycle. Without reference counting, this requires
complex conditional release logic to avoid double-frees on error paths
and leaks on success paths.

With reference counting:
- Core allocates umem with refcount=1
- Driver calls ib_umem_get_ref() to take a reference
- Both layers can unconditionally call ib_umem_release()
- The umem is freed only when the last reference is dropped

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
---
 drivers/infiniband/core/umem.c        | 5 +++++
 drivers/infiniband/core/umem_dmabuf.c | 1 +
 drivers/infiniband/core/umem_odp.c    | 3 +++
 include/rdma/ib_umem.h                | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8137031c2a65..09ce694d66ea 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
+	refcount_set(&umem->refcount, 1);
 	umem->ibdev      = device;
 	umem->length     = size;
 	umem->address    = addr;
@@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
 /**
  * ib_umem_release - release memory pinned with ib_umem_get
  * @umem: umem struct to release
+ *
+ * Decrement the reference count and free the umem when it reaches zero.
  */
 void ib_umem_release(struct ib_umem *umem)
 {
 	if (!umem)
 		return;
+	if (!refcount_dec_and_test(&umem->refcount))
+		return;
 	if (umem->is_dmabuf)
 		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
 	if (umem->is_odp)
diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 939da49b0dcc..5c5286092fca 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
 	}
 
 	umem = &umem_dmabuf->umem;
+	refcount_set(&umem->refcount, 1);
 	umem->ibdev = device;
 	umem->length = size;
 	umem->address = offset;
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 572a91a62a7b..7be30fda57e3 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 	if (!umem_odp)
 		return ERR_PTR(-ENOMEM);
 	umem = &umem_odp->umem;
+	refcount_set(&umem->refcount, 1);
 	umem->ibdev = device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
@@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
 	umem = &odp_data->umem;
+	refcount_set(&umem->refcount, 1);
 	umem->ibdev = root->umem.ibdev;
 	umem->length     = size;
 	umem->address    = addr;
@@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 	if (!umem_odp)
 		return ERR_PTR(-ENOMEM);
 
+	refcount_set(&umem_odp->umem.refcount, 1);
 	umem_odp->umem.ibdev = device;
 	umem_odp->umem.length = size;
 	umem_odp->umem.address = addr;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0a8e092c0ea8..44264f78eab3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
+#include <linux/refcount.h>
 #include <rdma/ib_verbs.h>
 
 struct ib_ucontext;
@@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
 struct ib_umem {
 	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
+	refcount_t		refcount;
 	u64 iova;
 	size_t			length;
 	unsigned long		address;
@@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 			    size_t size, int access);
+
+static inline void ib_umem_get_ref(struct ib_umem *umem)
+{
+	refcount_inc(&umem->refcount);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static inline void ib_umem_get_ref(struct ib_umem *umem) { }
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
-- 
2.51.1


