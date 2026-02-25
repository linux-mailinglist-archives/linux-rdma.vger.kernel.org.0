Return-Path: <linux-rdma+bounces-17190-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEukCJJkn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17190-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40119D9EB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 562DC303EC89
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF130F53C;
	Wed, 25 Feb 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEeixMxx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4730F7F7
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053641; cv=none; b=m+nRBSO1vFSZ5aCdZpHQTiVTwUWwVHnsLt9H5t25krMXgVLLFbo0MyLxfkVKrpID8+1ID+0u8y4Nmr67Yx9M7v4MJx4XesctAnRs/dCQ9FNo4XtNDZdwDmRwgjKnr7cEJry4wbB9QiFLH3KPoIsHULlh5SdrAEMOmwi/xH9Vqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053641; c=relaxed/simple;
	bh=7jC1VxlA7T5taSLCtjysceORBrT7IuqzgT2XM921owc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3oI2XVBhWZd0b0leIMhIppglhu+EUZ6jeIwFxplmNFKRu9dPZqd5oZ8MCQ/kknESw541AiLf2tDES48fn49fuHYXJnaSufqmWNokbq88OxkhMeRkOSNDXpG7XqIFQRsJ4LVu7SpfypgSurxL7qfdnoIjw8Hju6bED3VQjFvovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEeixMxx; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64ca99235cdso78638d50.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053639; x=1772658439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BYk4Ru/IuI04AEyNxZCZuW4baUVY4n6WfmpTDq9+bU=;
        b=gEeixMxx8xzZLWCoqHtWEr3vYxEg3zDXk/GVtxKfXIRUpwsSKKzIzsy+YLsxQ9hTjV
         lg3uNE+iMF9UeaLXEqvP9iroQNSsyrWx5ubWY9bE1McfGBQ40cRT7JcOwUux30tHQ/K7
         PG5AnAnxtm76BtAjmAT0QvyPD3c8QQ6kvsE4aoSZ/236x2QwM6vP2vrlF0VIZJxKtAza
         EveHra+6WBdo0f4z9eQBh59Y6JBrhpPIykdPF65WOlXN/m3s1mS1Qkkh6aR5Ce3+J+98
         1T9Vygsu1DB6lnU7E5+XFrbr2dbV1SnSW0aCKpr8lHLhYdjmsQMwvJyHbxbxylETFReT
         iyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053639; x=1772658439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BYk4Ru/IuI04AEyNxZCZuW4baUVY4n6WfmpTDq9+bU=;
        b=v7+jrCv+TQlO89dipGvPpnSNZI5n4CPoO+juBdlxbrNzcZC+c7+dXAZBmKOfFpJbMz
         aXIrVM82ex0whPyjaB6JgzzAL6ZvDNL/lFE9YgFu6vS2wKU3WQhUJ1hcq98xTzWS5Q6E
         VZFbmMh/plR/VfTgi+AUX4M1Swk+UKiUsEtQi3zwSjhZ9ujUfzGqAbEzjB3BkJ2ITd+o
         W81hh6EEQqHTy22nFIB3C0PmQath77ysmpJWa70tFkZtiQ5ovfIfof3lxOuxXXf69Xtt
         OvFqT/H68WKQuIjppPC1qI9JIfKr9X9bFF4veDlzKQMknuO9WchECNKDc2ozsipH8Gmd
         z3qA==
X-Gm-Message-State: AOJu0YxhjAqUmnyi+wEY8T96jhAsPBzkkvY04JNzx7DKNAjTt5MBWSxs
	9CgJbK14Uh7s7amOV8TgKh3ZvWu/qYKxwG+2YQ4RCZOfO915+IqJ1ASW9eC7ev88EcUOD303CHc
	Iqhqcu/heiw==
X-Received: from yxuv12.prod.google.com ([2002:a53:db4c:0:b0:63f:2d9a:64fc])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:b4a:b0:64a:df6e:16b8
 with SMTP id 956f58d0204a3-64c787d515bmr14862725d50.4.1772053639156; Wed, 25
 Feb 2026 13:07:19 -0800 (PST)
Date: Wed, 25 Feb 2026 21:07:05 +0000
In-Reply-To: <20260225210705.373126-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225210705.373126-5-jmoroni@google.com>
Subject: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable pinned
 dmabuf import
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17190-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,74.125.224.73:server fail,172.232.135.74:server fail];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC40119D9EB
X-Rspamd-Action: no action

Use the new API to support importing pinned dmabufs from exporters
that require revocation, such as VFIO. The revoke semantic is
achieved by issuing a HW invalidation command but not freeing
the key. This prevents further accesses to the region (they will
result in an invalid key AE), but also keeps the key reserved
until the region is actually deregistered (i.e., ibv_dereg_mr)
so that a new MR registration cannot acquire the same key.

Tested with lockdep+kasan and a memfd backed dmabuf.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/main.h  |  1 +
 drivers/infiniband/hw/irdma/verbs.c | 71 ++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d320d1a22..240c79779 100644
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
index 15af53237..a92fe3cac 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3590,6 +3590,36 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return ERR_PTR(err);
 }
 
+static int irdma_hwdereg_mr(struct ib_mr *ib_mr);
+
+static void irdma_umem_dmabuf_revoke(void *priv)
+{
+	/* priv is guaranteed to be valid any time this callback is invoked
+	 * because we do not set the callback until after successful iwmr
+	 * allocation and initialization.
+	 */
+	struct irdma_mr *iwmr = priv;
+	int err;
+
+	/* Invalidate the key in hardware. This does not actually release the
+	 * key for potential reuse - that only occurs when the region is fully
+	 * deregistered.
+	 *
+	 * The irdma_hwdereg_mr call is a no-op if the region is not currently
+	 * registered with hardware.
+	 */
+	err = irdma_hwdereg_mr(&iwmr->ibmr);
+	if (err) {
+		struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+
+		ibdev_err(&iwdev->ibdev, "dmabuf mr revoke failed %d", err);
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
@@ -3607,7 +3637,9 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
+	umem_dmabuf =
+		ib_umem_dmabuf_get_pinned_revocable_and_lock(pd->device, start,
+							     len, fd, access);
 	if (IS_ERR(umem_dmabuf)) {
 		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
 			  umem_dmabuf);
@@ -3624,12 +3656,20 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	if (err)
 		goto err_iwmr;
 
+	ib_umem_dmabuf_set_revoke_locked(umem_dmabuf, irdma_umem_dmabuf_revoke,
+					 iwmr);
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 	return &iwmr->ibmr;
 
 err_iwmr:
 	irdma_free_iwmr(iwmr);
 
 err_release:
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+
+	/* Will result in a call to revoke, but driver callback is not set and
+	 * is therefore skipped.
+	 */
 	ib_umem_release(&umem_dmabuf->umem);
 
 	return ERR_PTR(err);
@@ -3899,6 +3939,32 @@ static void irdma_del_memlist(struct irdma_mr *iwmr,
 	}
 }
 
+/**
+ * irdma_dereg_mr_dmabuf - deregister a dmabuf mr
+ * @iwdev: iwarp device
+ * @iwmr: mr
+ *
+ * dmabuf deregistration requires a slightly different sequence since it relies
+ * on the umem release to invalidate the region in hardware via the revoke
+ * callback. This ensures serialization w.r.t. concurrent revocations.
+ */
+static int irdma_dereg_mr_dmabuf(struct irdma_device *iwdev,
+				 struct irdma_mr *iwmr)
+{
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+
+	/* Triggers a synchronous call to the revoke callback. */
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
@@ -3911,6 +3977,9 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	int ret;
 
+	if (iwmr->region && iwmr->region->is_dmabuf)
+		return irdma_dereg_mr_dmabuf(iwdev, iwmr);
+
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
 		if (iwmr->region) {
 			struct irdma_ucontext *ucontext;
-- 
2.53.0.414.gf7e9f6c205-goog


