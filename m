Return-Path: <linux-rdma+bounces-17187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD11MY5kn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5014819D9E4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 564D330501A6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A74B30EF62;
	Wed, 25 Feb 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jIBv9Ux"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F030E84E
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053637; cv=none; b=I43DtpJ90W7xuC58BgGm/eby9EOnuhisXg4yRNAK/cOvvznx1fUsRs/Lw2bfaRWojoLu7deLtIOdm47U4+crgiqGhM5RKcfRnc33aTn/80TxLp2UC5i93KnRWAqTlalu4A58lmMYOKZcY6bAF5n0sCHSGOD2cyzGtzGL6H09Ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053637; c=relaxed/simple;
	bh=eP/gYjpurCrUMUcl9M0II6t5GT2ionY2jH944MqB7Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eKlu13aQxARfpTc2FB2EkColEaNy5n/C+zoiVJzxt2SGEsLlZUufEBQbd887Gq62PxNPwNrBqRVj5isJlFrrFDXgzc7KuCtSGJJEjFHKW4QbuXkg/X+/8A3DPrpskKX1xjVBeBi74MTy5qFc3c9J/HlCUuQpDzqlcfv6x1daBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jIBv9Ux; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506bfa0441aso732460281cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053634; x=1772658434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrUh0TVwJOErbcSZ14vulChIaHZ5G4zO+/GZ+vRQMIk=;
        b=0jIBv9UxvngP69LwCfR4U2UlzPQBXVmUG8RfdraYJfVhaT17xb5qCS8l0GE4KDqx42
         RK7AX7B4xsFAIFYgFfJZkHeu5pffkN7XKr6IdbOmNUibhRUbvTMIzjXFHGDyUue63Rtp
         SyoiLrx2PCr+N8LdJaWAIpGwtuTqy4eg8hsmHIrKJvUpCFhXBxbxIeNrKftqodArz0qK
         IyHP/8rIQXEMuJFd5pEkIwmj3voBJiMsoV0pjoOP2YsS72Yt6Utw4dG9XmII11lTA0Y7
         NpZUPc4HrUTKbRmSJTwzBmZL4EL5qcpB14HMW7BaIntafhfJYoC3B3cOFTMM148lrlEy
         q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053634; x=1772658434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrUh0TVwJOErbcSZ14vulChIaHZ5G4zO+/GZ+vRQMIk=;
        b=Jy+Dh27LWdsV7ee0Z/QODu0g9wle3gl/BH7dZ0Gr6AEFUoJhJzr69dSrOhfue6cv64
         WqWyz6tSnG6FzRk++HrECndZ3e/gTGfxzk29gmA/9eFjDHjJM/EpalCOe9A2U6o6eXMN
         gdn7nviCqAHZHvcKJPCZDksq7Rc+BpKowKMjxTXGDhi+cVlsGN30cjUTJUF8GasJ1EOa
         QTPnJa0qGolF0xikUZSJTkw83LPTl+7kVQmsb7iTVAs30zIJpXzB4f+O1rT1XorFMhPt
         IiuVVnr7n+wzXjuNBnPQuvmje3IFoAEoAFz845TMYFekIv1jOKTvlX5AbrRkbl5gWe7h
         yIvQ==
X-Gm-Message-State: AOJu0Yz96wVNT8e0NoN+NbtBhTjYWBXgfUD27X+GmVmlBhitD+z3AJzD
	SiigvXVRb8+HtoKwjVzTUCvSzysalkCUxV9FAQJwZGQALQ3EZ2t/xXFRklSoz9oCr3HT2hKxlL0
	m/Uk8QM57fw==
X-Received: from qtec11.prod.google.com ([2002:ac8:7dcb:0:b0:4ee:2425:54ae])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5701:0:b0:4ee:1727:10bb
 with SMTP id d75a77b69052e-50741fd9c43mr25409281cf.73.1772053634341; Wed, 25
 Feb 2026 13:07:14 -0800 (PST)
Date: Wed, 25 Feb 2026 21:07:02 +0000
In-Reply-To: <20260225210705.373126-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225210705.373126-2-jmoroni@google.com>
Subject: [PATCH rdma-next 1/4] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock
 helper
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17187-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,2600:3c04:e001:36c::12fc:5321:server fail,209.85.160.202:server fail];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5014819D9E4
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
index d30f24b90..0c0098285 100644
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
2.53.0.414.gf7e9f6c205-goog


