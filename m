Return-Path: <linux-rdma+bounces-17351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJmEKr7WpGnYtgUAu9opvQ
	(envelope-from <linux-rdma+bounces-17351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021681D20B1
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3943012E99
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF15A188713;
	Mon,  2 Mar 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYTZV4bS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39821430B85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410552; cv=none; b=YpPHz6I8JtdNPEdtcTuzNiXAsleQ5mUQRMv23QLU+MDmYXUcTs2dKXw9C4+ig2JrOTLtRSKKDkfVeDNTAiltZTDNDfRtRRDpcorUPVPjd041tdwphmvsiOBNeF52o5M0HNdyv8+DBS5Dvg+0FhGe6U7hhni6s66IqK3dfALbm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410552; c=relaxed/simple;
	bh=wF3OM7I5xlP5W/gR9JsMumrdDEG5OUnJx8c1032m7pQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLaJu6GEUNV9LeU102CXmDMm8tYUa6wSWh0pV1LN21Y5HbDMZ5Re5UtLiyEiRcIggXZP2ZPdapmt+GS35RI3+ECV7coKG20P1NjMf8AQUXL9M6CmaMaBFRIpztxGwV423QNLjKYb8IxR+NmPmDKFhetMM3+j8qRoIRoV/GYFtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYTZV4bS; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-896fe47cab0so50039146d6.3
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 16:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772410550; x=1773015350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETp7VWLyQ0S9iUEhmB2d4g2XY8GrkAnl366kQedIhFU=;
        b=nYTZV4bSTEmylaUOmA56oqkHtry95X5WBzAL22JxU5LTDf0eMEr6VI7OBDRUee1HFz
         8OK4VtgKl7BOiUU9yTsxc9jjJEwEFg3qGBxkpI23DHf+HxFSUFxBEczAdbQs0saaGp9W
         bjmqgMwY5wDWoF2rddJUkkDLTSYx0n6d989B2xq2Nxd3lymH//yBykKDCw4R0TMc4uZY
         GVhEB4RIZTVRRqPugnghATkJnmCO8OPN+KFfWKSqF1W9VfI+Hml/AFKJ6BEdGSLIIwFf
         +ollt+kOpQfbHM1GMxV8gxq7V3VxAutU2k2q6x/1tUV0oy32+kqeB54TnCL10speVAa1
         KpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772410550; x=1773015350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETp7VWLyQ0S9iUEhmB2d4g2XY8GrkAnl366kQedIhFU=;
        b=n131KLd0ucruxGbEvgKBJRSo2QWknimY83Zobc5iKLOl3QqPK+A+3XAskpNX6Cw/c4
         +N+jtSbk1lJ/RbariVBQ+8MmHBSwuV1awnhlzV/agxeDzEc1oT+3jixAA+qcrDIpWlKC
         N0KspWMo4HFmGis0/7zbLgu2OOimJx7/XEvuD833aAXmxNfDBcDhr5ji0V6iUK48ykhi
         eqHi6qe2dHskPkbRUUScddS7zZ6XYh8ySZbspWaLFXSwnohgtNNZb34A/OFA4GE++Uwj
         8vbA24ag7Liu1QeZjy+Eh/nghDGte1x87mtEk3I0YKKsLGVDIA8Pww5Gse6iB9DHAJCZ
         VbzQ==
X-Gm-Message-State: AOJu0Yz6e829YzmMcZVSSoq8Udg2AZvtW5bTtmJQEwBhb48kFfQjzoYd
	fLIAke7rjuyCUEbSky++UxndAL7dsjaVL+74VOFKwtuPPKnwfGvybXRElw/Ts04nvN3Fm6FSU0y
	HsM5spydkHQ==
X-Received: from qvct11.prod.google.com ([2002:a05:6214:21ab:b0:89a:48:d8])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:d69:b0:894:3c57:dbc0
 with SMTP id 6a1803df08f44-899d1e34478mr155934506d6.39.1772410550001; Sun, 01
 Mar 2026 16:15:50 -0800 (PST)
Date: Mon,  2 Mar 2026 00:15:37 +0000
In-Reply-To: <20260302001539.2275303-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302001539.2275303-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302001539.2275303-4-jmoroni@google.com>
Subject: [PATCH rdma-next v2 3/5] RDMA/umem: Add pinned revocable dmabuf
 import interface
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
	TAGGED_FROM(0.00)[bounces-17351-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 021681D20B1
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
index 1cc1d4077..0fed9435d 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -32,6 +32,8 @@ struct ib_umem_dmabuf {
 	struct scatterlist *last_sg;
 	unsigned long first_sg_offset;
 	unsigned long last_sg_trim;
+	void (*pinned_revoke)(void *priv);
+	void *pinned_revoke_priv;
 	void *private;
 	u8 pinned : 1;
 	u8 revoked : 1;
@@ -137,6 +139,12 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
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
@@ -189,6 +197,18 @@ ib_umem_dmabuf_get_pinned(struct ib_device *device, unsigned long offset,
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


