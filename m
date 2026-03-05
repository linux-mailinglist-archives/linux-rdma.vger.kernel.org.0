Return-Path: <linux-rdma+bounces-17555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGfeLI+5qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE2215EFB
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90F631B71E3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637013D2FF4;
	Thu,  5 Mar 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cihKrkVq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3157332ED0
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730522; cv=none; b=gTElEZLKgOGv6jMS2kH3q1fAKEyIDXr/JAO+TEEfPESHD67EB1XDGS0GA89iBIOAQD2CTCyLEBq78m1rxS3nO9U3BXc2IRMa8RNyHpvikMl6MbSox9fFtYFjH3RukorzjKsQo7/svg9g3X6FlrCVj6NJz9/Eqbnm0oPL5OSLtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730522; c=relaxed/simple;
	bh=35NL9CNoUmqD/RALh7Edf5OEKyRd8/DAI4/p+PBL0hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rx9egdZ4f9FLVXvs83yVwgQmXF42eIUod5Pfoj3ie4yDlPLe/t5YLH5eSWdWjkJYlGN+gReuNA34aWRqAk2JA03VBqaAfl2ciNTpcgKJYgrIcCUDdADqf2tqm57pDetoSD1BlpKiMdHsCtzMIsqPIwCcbhiDpSwGgWkADVU7gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cihKrkVq; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64ca99235cdso12857941d50.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730520; x=1773335320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lk8QJ4Yz7nZJ/jtDSnblbyCmIoPCwzYx9ur/dt64w+Y=;
        b=cihKrkVq6Axsz7pbc5dFoMa1vktKSZXoX+TM1RXMksgw7O9hCSuF1MNQ/kcQ08uc1R
         qGR99Gs8JcBeG11vBrfqqVowxfTvFBo5TwYeHNRp5nh0m2rbntgvDIoht6byQtDhgGsx
         bay/r9jE9SKuaze//TrfGr8ZntB/diu9nhLDNLhmuW/aFBeWbgIz/05nN3B08yjk6cTc
         JODwlErOQ9lycLksk7eJTFpTNh35fDlEsdxH6wCWsrgQzqTGT9SMRPidLAYzLv2Ysflr
         LWz/W4x+qCbJd1ZYhhIJFjdz3zdiefJ4OaIpZtOmYBlrVgI3cC7SOUhxccMwgzWuvCEW
         vQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730520; x=1773335320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lk8QJ4Yz7nZJ/jtDSnblbyCmIoPCwzYx9ur/dt64w+Y=;
        b=J3SIjuf6hWW0gtMDz4tKUu9kikYUXV+0baFj7FYDkNcp4c/q7fO4u+BGjuX9fcmCCK
         KwZTC7veXsIc3GIqE3Tu7Yh2bOLn4ozEiLF/0nXPaaS9gPc4KJZysMRHq3vzjYMeb2Cv
         egkHj8D3huB58H+wHei8oeMmydprwiQuKrpiZF7KLf7hS4GIP9GTI8UBwp6bSMwrH+gN
         zJXj8zpK+POMWKAfF7VskeGdWIH7DBaag2GsCV5gyJoqJ427t0ZAEQnpFAQXjDQovlH4
         oXkUZ3vOKw5181wlsFO9GzcMGfJ27xrptQORzili7O1pUmN5KVdn5MZ1XO9iUjyeCU8e
         T4IA==
X-Gm-Message-State: AOJu0Ywve4St2po5jNRppeFnQPAx1NTUewGXBebuxTQHaAraq2P6JlDG
	wP5x9QZDNomvm4TVNnDZhIdxEOBcKa/oXgT7vTp9cgcHsvT9jqZ0W+rlfk28NjJP+Y8IUNRGKsd
	PAnAoAe3Rag==
X-Received: from yxut7.prod.google.com ([2002:a53:db07:0:b0:64c:eb93:6915])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:e26:b0:64c:a5f9:9b2d
 with SMTP id 956f58d0204a3-64cf9b4dfaamr4374450d50.21.1772730519644; Thu, 05
 Mar 2026 09:08:39 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:26 +0000
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305170826.3803155-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-6-jmoroni@google.com>
Subject: [PATCH rdma-next v3 5/5] RDMA/irdma: Add support for revocable pinned
 dmabuf import
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5FEE2215EFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17555-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use the new API to support importing pinned dmabufs from exporters
that require revocation, such as VFIO. The revoke semantic is
achieved by issuing a HW invalidation command but not freeing
the key. This prevents further accesses to the region (they will
result in an invalid key AE), but also keeps the key reserved
until the region is actually deregistered (i.e., ibv_dereg_mr)
so that a new MR registration cannot acquire the same key.

Tested with lockdep+kasan and a memfd backed dmabuf.

The rereg_mr path is explicitly blocked in libibverbs for dmabuf MRs
(more specifically, any MR not of type IBV_MR_TYPE_MR), so the rereg_mr
path for dmabufs was tested with a modified libibverbs.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 105 ++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7251cd7a2147..1d0c2d8453a8 100644
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
+	ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
 	return &iwmr->ibmr;
 
 err_iwmr:
 	irdma_free_iwmr(iwmr);
 
 err_release:
+	ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
+
+	/* Will result in a call to revoke, but driver callback is not set and
+	 * is therefore skipped.
+	 */
 	ib_umem_release(&umem_dmabuf->umem);
 
 	return ERR_PTR(err);
@@ -3749,6 +3789,8 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	struct irdma_device *iwdev = to_iwdev(ib_mr->device);
 	struct irdma_mr *iwmr = to_iwmr(ib_mr);
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	bool dmabuf_revocable = iwmr->region && iwmr->region->is_dmabuf;
+	struct ib_umem_dmabuf *umem_dmabuf;
 	int ret;
 
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
@@ -3757,9 +3799,26 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (dmabuf_revocable) {
+		umem_dmabuf = to_ib_umem_dmabuf(iwmr->region);
+
+		ib_umem_dmabuf_revoke_lock(umem_dmabuf);
+
+		/* If the dmabuf has been revoked, it means that the region has
+		 * been invalidated in HW. We must not allow it to become valid
+		 * again unless the user is requesting a change in translation
+		 * which will end up dropping the umem dmabuf and allocating an
+		 * entirely new umem anyway.
+		 */
+		if (umem_dmabuf->revoked && !(flags & IB_MR_REREG_TRANS)) {
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+	}
+
 	ret = irdma_hwdereg_mr(ib_mr);
 	if (ret)
-		return ERR_PTR(ret);
+		goto err_unlock;
 
 	if (flags & IB_MR_REREG_ACCESS)
 		iwmr->access = new_access;
@@ -3775,18 +3834,28 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 					&iwpbl->pble_alloc);
 			iwpbl->pbl_allocated = false;
 		}
+
+		if (dmabuf_revocable) {
+			/* Must unlock before release to prevent deadlock */
+			ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
+			dmabuf_revocable = false;
+		}
+
 		if (iwmr->region) {
 			ib_umem_release(iwmr->region);
 			iwmr->region = NULL;
 		}
 
 		ret = irdma_rereg_mr_trans(iwmr, start, len, virt);
-	} else
+	} else {
 		ret = irdma_hwreg_mr(iwdev, iwmr, iwmr->access);
-	if (ret)
-		return ERR_PTR(ret);
+	}
 
-	return NULL;
+err_unlock:
+	if (dmabuf_revocable)
+		ib_umem_dmabuf_revoke_unlock(umem_dmabuf);
+
+	return ret ? ERR_PTR(ret) : NULL;
 }
 
 /**
@@ -3909,6 +3978,7 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct irdma_mr *iwmr = to_iwmr(ib_mr);
 	struct irdma_device *iwdev = to_iwdev(ib_mr->device);
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	bool dmabuf_revocable = iwmr->region && iwmr->region->is_dmabuf;
 	int ret;
 
 	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
@@ -3923,17 +3993,28 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		goto done;
 	}
 
-	ret = irdma_hwdereg_mr(ib_mr);
-	if (ret)
-		return ret;
+	if (!dmabuf_revocable) {
+		ret = irdma_hwdereg_mr(ib_mr);
+		if (ret)
+			return ret;
 
-	irdma_free_stag(iwdev, iwmr->stag);
+		irdma_free_stag(iwdev, iwmr->stag);
+	}
 done:
+	if (iwmr->region)
+		/* For dmabuf MRs, ib_umem_release will trigger a synchronous
+		 * call to the revoke callback which will perform the actual HW
+		 * invalidation via irdma_hwdereg_mr. We rely on this for its
+		 * implicit serialization w.r.t. concurrent revocations. This
+		 * must be done before freeing the PBLEs.
+		 */
+		ib_umem_release(iwmr->region);
+
 	if (iwpbl->pbl_allocated)
 		irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
 
-	if (iwmr->region)
-		ib_umem_release(iwmr->region);
+	if (dmabuf_revocable)
+		irdma_free_stag(iwdev, iwmr->stag);
 
 	kfree(iwmr);
 
-- 
2.53.0.473.g4a7958ca14-goog


