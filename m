Return-Path: <linux-rdma+bounces-17551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIikIXu5qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D54215ED6
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E3931AE9B2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE893DEADC;
	Thu,  5 Mar 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkYK9yEd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F611D45E8
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730514; cv=none; b=jQt2SzNvBRhLX8i17LbNadjfjLtHUZ1StZBRzGpQThHhmEeYnCLSkHj/PgT5XWjWUgq1e106pUp1CkrJfmjewI81JGAAc1nwD8bREukGSI3FBEwPgMom/W2sCy44E+T3hCkxbe65sHyox/kmGhck0vAg8N+xvpqHErZ4l6cyLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730514; c=relaxed/simple;
	bh=JzvSCC4wHETW5PpPn0xmJGH/cqWlzhdpqLostLoRqnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EhvOTq9LBcUvbeFwnmrBkAW68pkbyx06DCudydTR6pL8BHLCsg4l58QdjNr5NOEQRsP+4nvCo8zqBPcV4EqiSkUHOWtIUcB45ozr7vHYDvE19jJqPfoU516UB4km/lfaOTz4egcGB922zlmmCOI5qEm/Le2TxprB0jeX1wyVR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkYK9yEd; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-506a936d7afso758417971cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730512; x=1773335312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AZQbGnYT34PMI8rOMdkyBAOI3gwiqzYNlfh+WtTo8=;
        b=AkYK9yEdUcGTao6hjMd6eAcUANZJ2jT8WMdxVbTAX6laCoSZVBAtaULWf1eWJ3Sj8m
         oQYwMAZl2cAa5xbz2WArq6q3pf1oGE32sRnj38+AXqBrVGQN+ztf4S064YaDEDzr3zHq
         YFfBliztpxFCW4hVb5qXiShiNvmZbCftjHlXH7YM9EQmbn3DTerhxNun/dg9+vqGMZeS
         T+g0keWvzbiileBOd8rHresZgCank6Y+WTkA+ouK9n+w9J6IaAS9c5XhtfGmLR54Li+u
         FqwGfIT9+qsOfHqpiJnyZr5AgakCvdYe3ItbUOE+GmCRHkAaL1P8qxHWgWu1bmlMZWps
         Elqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730512; x=1773335312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AZQbGnYT34PMI8rOMdkyBAOI3gwiqzYNlfh+WtTo8=;
        b=QsA1VQCacZJqUDqi7y7T6/7bEMRo1VUoNnatml1AARVKzf1qLfSLDPVfFkA4A1GqEw
         LMsaoDMnTNaogghMswrzNLhFsOQgQK7WfFPJMtSIVYLSZcJ83wXD+wOq+l3DB1lfiMJH
         MyhAG3OCxr1rszVZs3INNYeubQRntVfEE91DHwXDAaCVghYQBNpTSnKW/5VLzQ0BBFoL
         B/K1Ie1KqdO58+5A4RBtMK1k3bQ2isdp9M9ffIaHhLGDoq5oUTlIH2BOY7G8wF2SpCUq
         YtI9nnq+5Se+Petq3CcXMQrtNtZTMKjyc7wB4JdZX9R6M0UvJkvVqCZHWUbyuMzIGcsu
         4Wlw==
X-Gm-Message-State: AOJu0YwzWNB8BgECtgHWu9h5jVy5+H3EnNRyFWuD+8g4rimn8as0b/8D
	Ts5wnsuCWz4RfVRw5PUbzB7NCB7gWVPQxPQ/Kxf8zE7W9OalycCrOanJsJioCMDow3/6WtXAqi+
	TLv05K2CHoA==
X-Received: from qvkj27.prod.google.com ([2002:a0c:e01b:0:b0:89a:14d5:7127])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:57ca:0:b0:4f3:4eed:aa8a
 with SMTP id d75a77b69052e-508f1dd4364mr3817091cf.40.1772730511935; Thu, 05
 Mar 2026 09:08:31 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:22 +0000
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305170826.3803155-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-2-jmoroni@google.com>
Subject: [PATCH rdma-next v3 1/5] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock
 helper
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 27D54215ED6
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
	TAGGED_FROM(0.00)[bounces-17551-lists,linux-rdma=lfdr.de];
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

Move the inner logic of ib_umem_dmabuf_get_pinned_with_dma_device()
to a new static function that returns with the lock held upon success.

The intent is to allow reuse for the future get_pinned_revocable_and_lock
function.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 35 ++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index d30f24b90bca..0c0098285c38 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -195,18 +195,19 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
-struct ib_umem_dmabuf *
-ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
-					  struct device *dma_device,
-					  unsigned long offset, size_t size,
-					  int fd, int access)
+static struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
+				   struct device *dma_device,
+				   unsigned long offset,
+				   size_t size, int fd, int access,
+				   const struct dma_buf_attach_ops *ops)
 {
 	struct ib_umem_dmabuf *umem_dmabuf;
 	int err;
 
-	umem_dmabuf = ib_umem_dmabuf_get_with_dma_device(device, dma_device, offset,
-							 size, fd, access,
-							 &ib_umem_dmabuf_attach_pinned_ops);
+	umem_dmabuf =
+		ib_umem_dmabuf_get_with_dma_device(device, dma_device, offset,
+						   size, fd, access, ops);
 	if (IS_ERR(umem_dmabuf))
 		return umem_dmabuf;
 
@@ -219,7 +220,6 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
 	if (err)
 		goto err_release;
-	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
 	return umem_dmabuf;
 
@@ -228,6 +228,23 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 	ib_umem_release(&umem_dmabuf->umem);
 	return ERR_PTR(err);
 }
+
+struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
+					  struct device *dma_device,
+					  unsigned long offset, size_t size,
+					  int fd, int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf =
+		ib_umem_dmabuf_get_pinned_and_lock(device, dma_device, offset,
+						   size, fd, access,
+						   &ib_umem_dmabuf_attach_pinned_ops);
+	if (IS_ERR(umem_dmabuf))
+		return umem_dmabuf;
+
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+	return umem_dmabuf;
+}
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned_with_dma_device);
 
 struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
-- 
2.53.0.473.g4a7958ca14-goog


