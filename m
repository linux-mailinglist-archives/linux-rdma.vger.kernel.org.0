Return-Path: <linux-rdma+bounces-17064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJqtH4KwnGmYJwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:54:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D421817C8FF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD9D3040768
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896AD374750;
	Mon, 23 Feb 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9w7rxpz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5A33A9C3
	for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876419; cv=none; b=b68vJfb7H+W//kU8gFtzSbpP7PxQJv1sezb9D2EzZhVrHqtW6H38tKu95lUfTnhlPHoUrQMSbUt5hX9Hgd+vEJ92XzrS1y5yEj+LQIuBfmmJEZAlDzEb55oMg1EEiumzyU0IeAKo7osTDxpmOtUpr/WGPCgGlC2LG7VO28DwipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876419; c=relaxed/simple;
	bh=W7Q24E5vgln13lk5rZIAcnRfURgeJf+GPLE+2rNTqZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUzzSqgbHfC44Q9XVSLevTjtvrf+LEoDUsRilKtHFOR1LnXeRX9cWvt8wFxgb2VzBNzsaknqDOnAgvlZRJYWKFBPKnQUCq9b1Br756LMRawkjkPIJymBaXXp02XaeamBSfgsvUXRBxdP1olyckA2bRdrLYdlRaMJYMbzZQXOPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9w7rxpz; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70b6a5821so3720473285a.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771876417; x=1772481217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaD8GXrytGhdTHcZBJ1d+bOEicgtucdkYl2gC4xkvWk=;
        b=w9w7rxpzpSjlujolJ/CmWL1CBT8Zk5ngeoOBgheDi3fN5FLUtsuLXEW9dKwqlyYDgO
         mF+AMyhUO51WOsDMzn3qZwpQn19PdnDVFgGbjjouEeicVWEshtNUdD4dN9BpbnDCmueC
         qUf1Lb49fxe6Iku7qRJJDCrKNqdC95acyxoar8JsoaSNeLnWuabDM3XnWbsQaVpfWrwC
         RPasKc8boIQX0x6Pgib3AZEn8ty+BVgdnOUY5ZckvIxkCwAzEtpk1YR+77kRyx6Jkph4
         o+EHki08Lfus8OsF5R14/lRpTedyPTwnosc9k4fNl3uxfvafKG7YAqKsXOosHGGLfa37
         K4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876417; x=1772481217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaD8GXrytGhdTHcZBJ1d+bOEicgtucdkYl2gC4xkvWk=;
        b=fIr0iNSoBAMQc8ORACKxwmBbAYJ1GfxSMn9tY9Fn3Sv8PGGzLAFEhwjEwybyCLizEZ
         2iH/KhywnG3fH63pLSVacmpMpK7yqtgBofmyY+/EmxC04BKj2Er+SVRH6U4xvOD+oNaw
         dQAGwFQ84R4CFFYBibrEL3jF8cd4ibwqnLwZ6YWl8U0ce+lY49CyWjKw6BAoLqMaukzw
         8bsqinSxHy5YrXQW4EQQjXG702y4oCHFtwy/SOH+u/O8NbrAxTOVVYdkTSLaJA+cQ4fw
         Kf4Mrq/E99It2BcMBDS87k2pKUbsFjbaCl81Txe+4TgAaoqOlZw5QOnnWIgYygbA9I8C
         c61Q==
X-Gm-Message-State: AOJu0YzRlp/f4gkBRYBUjXLEfTs1s7c+MjxxKNLyQr5j1WZQxwXxis4w
	guN/WKp1d0UGm6LQtaPqB4ShbsVwNzqfuaqSsoCQFIFXoJs6VUlOPUqfNWLutlnnLtB4AheNCxE
	QsPO9lbBq0A==
X-Received: from qknwd20.prod.google.com ([2002:a05:620a:7294:b0:8c7:a37:5a4f])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:29c2:b0:8ca:2f33:6471
 with SMTP id af79cd13be357-8cb8ca72260mr1175252885a.49.1771876416741; Mon, 23
 Feb 2026 11:53:36 -0800 (PST)
Date: Mon, 23 Feb 2026 19:53:33 +0000
In-Reply-To: <20260223195333.438492-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223195333.438492-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260223195333.438492-2-jmoroni@google.com>
Subject: [RFC 2/2] RDMA/irdma: Add pinned revocable dmabuf support
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17064-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D421817C8FF
X-Rspamd-Action: no action

Some dmabuf exporters (like VFIO) will require that pinned
importers support revocation. In order to support this, the new
ib_umem_dmabuf_get_pinned_revocable method can be used, which
allows the driver to provide a revoke callback for the umem.

Upon revocation, the driver will invalidate the region in HW
so that it is no longer accessed.

It is worth noting that the irdma driver handles MR key allocation
in software; the command submitted to hardware during the revoke
invalidates the key, but the key is not available for reuse until
the region is fully deregistered (i.e., ibv_dereg_mr).

Tested with lockdep+kasan and a modified VFIO that allows pinned
importers by triggering a VFIO_DEVICE_RESET while the region is
registered to ensure that the callback is executed properly.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/main.h  |   1 +
 drivers/infiniband/hw/irdma/verbs.c | 125 ++++++++++++++++++++--------
 drivers/infiniband/hw/irdma/verbs.h |   1 +
 3 files changed, 94 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d320d1a228b3..240c7977903d 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-resv.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/io.h>
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 15af53237217..c269f0954f82 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3359,19 +3359,14 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access,
 	return err;
 }
 
-static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
-					 struct ib_pd *pd, u64 virt,
-					 enum irdma_memreg_type reg_type)
+static int irdma_init_iwmr(struct irdma_mr *iwmr, struct ib_umem *region,
+			   struct ib_pd *pd, u64 virt,
+			   enum irdma_memreg_type reg_type)
 {
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_pbl *iwpbl;
-	struct irdma_mr *iwmr;
 	unsigned long pgsz_bitmap;
 
-	iwmr = kzalloc_obj(*iwmr);
-	if (!iwmr)
-		return ERR_PTR(-ENOMEM);
-
 	iwpbl = &iwmr->iwpbl;
 	iwpbl->iwmr = iwmr;
 	iwmr->region = region;
@@ -3384,21 +3379,14 @@ static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
 		iwdev->rf->sc_dev.hw_attrs.page_size_cap : SZ_4K;
 
 	iwmr->page_size = ib_umem_find_best_pgsz(region, pgsz_bitmap, virt);
-	if (unlikely(!iwmr->page_size)) {
-		kfree(iwmr);
-		return ERR_PTR(-EOPNOTSUPP);
-	}
+	if (unlikely(!iwmr->page_size))
+		return -EOPNOTSUPP;
 
 	iwmr->len = region->length;
 	iwpbl->user_base = virt;
 	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
 
-	return iwmr;
-}
-
-static void irdma_free_iwmr(struct irdma_mr *iwmr)
-{
-	kfree(iwmr);
+	return 0;
 }
 
 static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
@@ -3547,12 +3535,16 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return ERR_PTR(-EFAULT);
 	}
 
-	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
-	if (IS_ERR(iwmr)) {
+	iwmr = kzalloc_obj(*iwmr);
+	if (!iwmr) {
 		ib_umem_release(region);
-		return (struct ib_mr *)iwmr;
+		return ERR_PTR(-ENOMEM);
 	}
 
+	err = irdma_init_iwmr(iwmr, region, pd, virt, req.reg_type);
+	if (err)
+		goto error;
+
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
 		err = irdma_reg_user_mr_type_qp(req, udata, iwmr);
@@ -3585,11 +3577,39 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return &iwmr->ibmr;
 error:
 	ib_umem_release(region);
-	irdma_free_iwmr(iwmr);
+	kfree(iwmr);
 
 	return ERR_PTR(err);
 }
 
+static int irdma_hwdereg_mr(struct ib_mr *ib_mr);
+
+static void irdma_umem_dmabuf_revoke(void *priv)
+{
+	struct irdma_mr *iwmr = priv;
+	int err;
+
+	iwmr->revoked = true;
+
+	if (!iwmr->is_hwreg)
+		return;
+
+	/* Invalidate the key in hardware. This does not actually release the
+	 * key for potential reuse - that only occurs when the region is fully
+	 * deregistered.
+	 */
+	err = irdma_hwdereg_mr(&iwmr->ibmr);
+	if (err) {
+		struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+
+		ibdev_err(&iwdev->ibdev, "dmabuf mr invalidate failed %d", err);
+		if (!iwdev->rf->reset) {
+			iwdev->rf->reset = true;
+			iwdev->rf->gen_ops.request_reset(iwdev->rf);
+		}
+	}
+}
+
 static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 					      u64 len, u64 virt,
 					      int fd, int access,
@@ -3607,31 +3627,45 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
+	iwmr = kzalloc_obj(*iwmr);
+	if (!iwmr)
+		return ERR_PTR(-ENOMEM);
+
+	umem_dmabuf =
+		ib_umem_dmabuf_get_pinned_revocable(pd->device, start, len, fd,
+						    access,
+						    irdma_umem_dmabuf_revoke,
+						    iwmr);
 	if (IS_ERR(umem_dmabuf)) {
 		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
 			  umem_dmabuf);
+		kfree(iwmr);
 		return ERR_CAST(umem_dmabuf);
 	}
 
-	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
-	if (IS_ERR(iwmr)) {
-		err = PTR_ERR(iwmr);
+	err = irdma_init_iwmr(iwmr, &umem_dmabuf->umem, pd, virt,
+			      IRDMA_MEMREG_TYPE_MEM);
+	if (err)
 		goto err_release;
-	}
 
-	err = irdma_reg_user_mr_type_mem(iwmr, access, true);
+	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
+	/* Catch revocations that occur before grabbing dma_resv_lock. */
+	err = iwmr->revoked ?
+		-ENODEV : irdma_reg_user_mr_type_mem(iwmr, access, true);
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+
 	if (err)
-		goto err_iwmr;
+		goto err_release;
 
 	return &iwmr->ibmr;
 
-err_iwmr:
-	irdma_free_iwmr(iwmr);
-
 err_release:
+	/* ib_umem_release will result in the irdma_umem_dmabuf_revoke callback
+	 * being called, but it ends up being a no-op if the region has not been
+	 * successfully registered with HW because iwmr->is_hwreg is false.
+	 */
 	ib_umem_release(&umem_dmabuf->umem);
-
+	kfree(iwmr);
 	return ERR_PTR(err);
 }
 
@@ -3899,6 +3933,28 @@ static void irdma_del_memlist(struct irdma_mr *iwmr,
 	}
 }
 
+/**
+ * irdma_dereg_mr_dmabuf - deregister a dmabuf mr
+ * @iwdev: iwarp device
+ * @iwmr: mr
+ */
+static int irdma_dereg_mr_dmabuf(struct irdma_device *iwdev,
+				 struct irdma_mr *iwmr)
+{
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+
+	/* Causes a synchronous revoke which then causes HW invalidation. */
+	ib_umem_release(iwmr->region);
+
+	irdma_free_stag(iwdev, iwmr->stag);
+
+	if (iwpbl->pbl_allocated)
+		irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+
+	kfree(iwmr);
+	return 0;
+}
+
 /**
  * irdma_dereg_mr - deregister mr
  * @ib_mr: mr ptr for dereg
@@ -3911,6 +3967,9 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	int ret;
 
+	if (iwmr->region && iwmr->region->is_dmabuf)
+		return irdma_dereg_mr_dmabuf(iwdev, iwmr);
+
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
 			struct irdma_ucontext *ucontext;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index aabbb3442098..612c66c91db4 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -113,6 +113,7 @@ struct irdma_mr {
 	int access;
 	bool is_hwreg:1;
 	bool dma_mr:1;
+	bool revoked:1;
 	u16 type;
 	u32 page_cnt;
 	u64 page_size;
-- 
2.53.0.371.g1d285c8824-goog


