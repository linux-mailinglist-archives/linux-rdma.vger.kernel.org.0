Return-Path: <linux-rdma+bounces-17553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUQBKW4qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:08:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E4215DF7
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C57930106AE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D4D3D2FF4;
	Thu,  5 Mar 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEtpGYp5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DD1D45E8
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730518; cv=none; b=W25Nl+TIdoVHDC5OGjKjmotYnUSQ78DXPYAcuh1QteSQVstJnqWtsM4NOGW7al2J+qQfU2KFSK4446T9A/xF4PUyL0vasoiiFC8eSrd4dGkk1yQMlCfidJmAesEHWZYJQ+F7q7n2z02Xmn/NcquQaBHTkhZmcV3ss9BYVEvIwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730518; c=relaxed/simple;
	bh=aiimRlcC35lyfT8U/DH3Wv8fouHOaZabn5x+OitHF9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STFM8PRFnltxajHWmUna/zfW6l3lj23T71Yhg+fpcQXLuANaK5V27BZAJo6kQGriOhX3X1GECVsS/EVO8gfSHbkCPbH6YZhD/HatzX0EqSUESPlg0YB7JWMcjR9XkSLejs+wKr5hfzVS7Lzv2NtqEqnQ3tmKTZYQUuOxbwlfTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEtpGYp5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7983f854288so145449447b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730516; x=1773335316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLVPMsD7IgARhnK9M00AySUdhbHtL9KEfshqimuR8dY=;
        b=TEtpGYp5GvdbinDywg9hm8qP/EFHJ2GqnFgPtKvo4oIdhC5+4Rk5B9RlEh9gSsTNWe
         v3E7zOt3iAiidMV5ZricZJT6QTGwTWZ98m84xYLOJj7gwgPC6rCg4hf9d3/574DUlKqS
         PGF6rHUZclDMNC8l6tg6S1QEjL2mS4j1xcd8DBzqH2wrtjCbneotV72dCFwlICHhsh6g
         n1m4OoqmTvX2y3NV1twn9WBz6BAoBmz05YOnkA+gce3Gh46j/KOrjh37yVUCQvULx3ia
         LaOs9bzBmgHHHjNOT1qoQY6uk7/h6g8QVEzt7RvUY1Ex9nwFR1heYMdwEk1/n86IODAN
         eu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730516; x=1773335316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLVPMsD7IgARhnK9M00AySUdhbHtL9KEfshqimuR8dY=;
        b=vFL9E3ES/Ml1uHJhJbbpXbl9YAT7m3kG7DGJUpdytY9is0T1EnEMD+uOCXc3+THPhp
         x2zJrjJnlehbMOHq0+3+Ob9lm1BxYa7LDZjYaZycWmEY/2ihJiFKYmaqJoorrRi2kK+p
         G4JAd0TsGsmt9w0BqyGhGMHPileqrAKsRIpfALUe4vVpGIYYMe92oRmW4Ixv2jyuEHQ1
         F+s7d5RLBPcvrdnCmZPxga6QIDk/fBfyohaMhP2SZBsm1Qt+GJFCRGv0njI+vgNTF/Ja
         CTQwxIDuqDp+AzsgyULc2VjxSmBxeb59v5VIJghIVhUC/De0YBC8Yj45fiHS30Mz+acF
         e3rA==
X-Gm-Message-State: AOJu0YxwJFaykiTWYooctM9Gem0BT83z3jqLLJPzw/YqIatt4p7V+283
	iwa+/I7QwrXzxK/zuU7Rw+EtRlG1Y5yphr6BFOJLDbN4y23d1hx9Y7W5PYU4nY5pt8pxrMai2oK
	yeLO+VyJhIQ==
X-Received: from ywbkd15-n1.prod.google.com ([2002:a05:690c:4f8f:10b0:798:599d:fdef])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:82:b0:798:5880:26ec
 with SMTP id 00721157ae682-798c6be04dcmr47951597b3.16.1772730515711; Thu, 05
 Mar 2026 09:08:35 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:24 +0000
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305170826.3803155-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-4-jmoroni@google.com>
Subject: [PATCH rdma-next v3 3/5] RDMA/umem: Add pinned revocable dmabuf
 import interface
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 127E4215DF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17553-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Added an interface for importing a pinned but revocable dmabuf.
This interface can be used by drivers that are capable of revocation
so that they can import dmabufs from exporters that may require it,
such as VFIO.

This interface implements a two step process, where drivers will first
call ib_umem_dmabuf_get_pinned_revocable_and_lock() which will pin and
map the dmabuf (and provide a functional move_notify/invalidate_mappings
callback), but will return with the lock still held so that the
driver can then populate the callback via
ib_umem_dmabuf_set_revoke_locked() without races from concurrent
revocations. This scheme also allows for easier integration with drivers
that may not have actually allocated their internal MR objects at the time
of the get_pinned_revocable* call.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 61 +++++++++++++++++++++++++++
 include/rdma/ib_umem.h                | 19 +++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 9cf9cfc93006..1a810dbdea9a 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -203,6 +203,10 @@ static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
 
 	if (umem_dmabuf->revoked)
 		return;
+
+	if (umem_dmabuf->pinned_revoke)
+		umem_dmabuf->pinned_revoke(umem_dmabuf->private);
+
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 	if (umem_dmabuf->pinned) {
 		dma_buf_unpin(umem_dmabuf->attach);
@@ -211,6 +215,11 @@ static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
 	umem_dmabuf->revoked = 1;
 }
 
+static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_ops = {
+	.allow_peer2peer = true,
+	.move_notify = ib_umem_dmabuf_revoke_locked,
+};
+
 static struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
 				   struct device *dma_device,
@@ -263,6 +272,58 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned_with_dma_device);
 
+/**
+ * ib_umem_dmabuf_get_pinned_revocable_and_lock - Map & pin a revocable dmabuf
+ * @device: IB device.
+ * @offset: Start offset.
+ * @size: Length.
+ * @fd: dmabuf fd.
+ * @access: Access flags.
+ *
+ * Obtains a umem from a dmabuf for drivers/devices that can support revocation.
+ *
+ * Returns with dma_resv_lock held upon success. The driver must set the revoke
+ * callback prior to unlock by calling ib_umem_dmabuf_set_revoke_locked().
+ *
+ * When a revocation occurs, the revoke callback will be called. The driver must
+ * ensure that the region is no longer accessed when the callback returns. Any
+ * subsequent access attempts should also probably cause an AE for MRs.
+ *
+ * If the umem is used for an MR, the driver must ensure that the key remains in
+ * use such that it cannot be obtained by a new region until this region is
+ * fully deregistered (i.e., ibv_dereg_mr). If a driver needs to serialize with
+ * revoke calls, it can use dma_resv_lock.
+ *
+ * If successful, then the revoke callback may be called at any time and will
+ * also be called automatically upon ib_umem_release (serialized). The revoke
+ * callback will be called one time at most.
+ *
+ * Return: A pointer to ib_umem_dmabuf on success, or an ERR_PTR on failure.
+ */
+struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable_and_lock(struct ib_device *device,
+					     unsigned long offset, size_t size,
+					     int fd, int access)
+{
+	const struct dma_buf_attach_ops *ops =
+		&ib_umem_dmabuf_attach_pinned_revocable_ops;
+
+	return ib_umem_dmabuf_get_pinned_and_lock(device, device->dma_device,
+						  offset, size, fd, access,
+						  ops);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned_revocable_and_lock);
+
+void ib_umem_dmabuf_set_revoke_locked(struct ib_umem_dmabuf *umem_dmabuf,
+				      void (*revoke)(void *priv), void *priv)
+{
+	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
+
+	umem_dmabuf->pinned_revoke = revoke;
+	umem_dmabuf->private = priv;
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_set_revoke_locked);
+
 struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 						 unsigned long offset,
 						 size_t size, int fd,
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 1cc1d4077353..28075e617480 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -32,6 +32,7 @@ struct ib_umem_dmabuf {
 	struct scatterlist *last_sg;
 	unsigned long first_sg_offset;
 	unsigned long last_sg_trim;
+	void (*pinned_revoke)(void *priv);
 	void *private;
 	u8 pinned : 1;
 	u8 revoked : 1;
@@ -137,6 +138,12 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 						 size_t size, int fd,
 						 int access);
 struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable_and_lock(struct ib_device *device,
+					     unsigned long offset, size_t size,
+					     int fd, int access);
+void ib_umem_dmabuf_set_revoke_locked(struct ib_umem_dmabuf *umem_dmabuf,
+				      void (*revoke)(void *priv), void *priv);
+struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 					  struct device *dma_device,
 					  unsigned long offset, size_t size,
@@ -189,6 +196,18 @@ ib_umem_dmabuf_get_pinned(struct ib_device *device, unsigned long offset,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable_and_lock(struct ib_device *device,
+					     unsigned long offset, size_t size,
+					     int fd, int access)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void
+ib_umem_dmabuf_set_revoke_locked(struct ib_umem_dmabuf *umem_dmabuf,
+				 void (*revoke)(void *priv), void *priv) {}
+
 static inline struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 					  struct device *dma_device,
-- 
2.53.0.473.g4a7958ca14-goog


