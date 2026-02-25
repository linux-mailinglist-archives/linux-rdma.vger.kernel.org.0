Return-Path: <linux-rdma+bounces-17189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEgeIpZkn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2219D9FA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A1F3065F0E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DB230F53C;
	Wed, 25 Feb 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvsiZ7sA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8230F95C
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053640; cv=none; b=XfT7wo+cM+5c9bK4gxPOnK67JFlZnHjLQw0GVDsM5XsMKG7xg8yQs1LpFRQDq4Q50qRQZ4PolXIgvL5oa1X6dartY0In4kfs+UoSW2YZYiX5chA4P/oncZsHB56+e1UYuDu4Y3FvWyOpmsbRapK1RGmmoGy8C8QzzECjujs7whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053640; c=relaxed/simple;
	bh=Btt9b84Ik57IQkFgmZprcKud7sdciLg+Jtb427EK3wE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfTRUHepTK3iwh7WpEfHtKcpP9uH9G9oDb1TlIRxQqRiw3M5Uo8MuTG3f6t8kKrxR78JWyGjitlms1wRKXmoAb6cd3fVY2E+too5nDvY1tSOsQMGSJ2g9Ov/77Cv6h+ogSuCvVJoYkWSQZNVkZEpKQvcnl8vAi83aVB9Mve3Tt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvsiZ7sA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70d16d5a9so30958085a.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053638; x=1772658438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyxfEG20KzuD7lwZYtwxeXYofnmO5ulQa5tuqNUuAHw=;
        b=ZvsiZ7sAQg6do9kjszO0ZiohAbO9QFOGteDrobbZiX8WmUko7eIYuUcL+a31uptM1J
         496AJlsIaxNhIBHtoE1XjKPGm+CvK5Ct53mxdIVeZUK6tgJUfRd8Q0BvSdpZS3uRluX6
         gtpzht8yxyBFktRSzXj7ZHP2/FVeHObzAJ4ZrQlvuq1YL18Pun+eaYdG7h3VOrIM4tyD
         hdI7fX/MNqkM7jjAcFw4aPd5ayjQD+dGXpW/lsazh3Li00u3TiJiXJrRTuiuifNGrWrg
         LkNWSfLA+zvb0HJNBySSBKlt8suVdSZ/ywDA8ds7SWUSEmXiypvhMgLOWOx2H6L2yp6i
         phFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053638; x=1772658438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyxfEG20KzuD7lwZYtwxeXYofnmO5ulQa5tuqNUuAHw=;
        b=cP+07OfBwclp3rPXLVRhz190775mZRBvytgjqc2xGhOSepAuwL5Tp1cFv+R2qD4TaF
         r36LmnTMqtmtYnntq7k/w4xol4Vkmt06U2kQBGEmivv1Lq0l3nhnJ7coQ7Nu6wfD69yg
         YCy2RhuhIC1G+XmylTgWXmbYfDvWI9Su9qCZLgPz6yONead5ccN5xYv7ZO3lVNSiAmoU
         OgtAXizlGBF6Itu3Cu3luX5LeOh0k/OxrpQNVfEoytDueo6FzUmOXi7nq5gCXwGVaUtn
         3VX7e2BlCGKj/iGsDEQP/sIpvVghHK88Ec0Or1pOJ+NttGZ/ephpWLtP7F5EHHJnOQVk
         4QOA==
X-Gm-Message-State: AOJu0YxJQFf5vnguc1ITmh2qkFTPOui9kt4X6mQ13/eXAvCWRafvY5M/
	urzpJ29L86uVts0C7LhDBiMAP7DgfuuHxt38avtAV668Pi8bsYaQEVCQqY6J9UF5GHDEyyzPsh2
	5BQKa3GWVvA==
X-Received: from qknsn10.prod.google.com ([2002:a05:620a:948a:b0:8bb:38a9:e9d0])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2905:b0:8c7:b5b:cea7
 with SMTP id af79cd13be357-8cbbcf2e9c6mr289872185a.12.1772053637467; Wed, 25
 Feb 2026 13:07:17 -0800 (PST)
Date: Wed, 25 Feb 2026 21:07:04 +0000
In-Reply-To: <20260225210705.373126-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225210705.373126-4-jmoroni@google.com>
Subject: [PATCH rdma-next 3/4] RDMA/umem: Add pinned revocable dmabuf import interface
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
	TAGGED_FROM(0.00)[bounces-17189-lists,linux-rdma=lfdr.de];
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
	BLOCKLISTDE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail,100.90.174.1:server fail,209.85.222.202:server fail];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F2219D9FA
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
 include/rdma/ib_umem.h                | 20 +++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 9cf9cfc93..7892e33be 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -203,6 +203,10 @@ static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
 
 	if (umem_dmabuf->revoked)
 		return;
+
+	if (umem_dmabuf->pinned_revoke)
+		umem_dmabuf->pinned_revoke(umem_dmabuf->pinned_revoke_priv);
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
+	umem_dmabuf->pinned_revoke_priv = priv;
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_set_revoke_locked);
+
 struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 						 unsigned long offset,
 						 size_t size, int fd,
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0a8e092c0..3de8c2efc 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -36,6 +36,8 @@ struct ib_umem_dmabuf {
 	struct scatterlist *last_sg;
 	unsigned long first_sg_offset;
 	unsigned long last_sg_trim;
+	void (*pinned_revoke)(void *priv);
+	void *pinned_revoke_priv;
 	void *private;
 	u8 pinned : 1;
 	u8 revoked : 1;
@@ -169,6 +171,12 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
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
@@ -221,6 +229,18 @@ ib_umem_dmabuf_get_pinned(struct ib_device *device, unsigned long offset,
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
2.53.0.414.gf7e9f6c205-goog


