Return-Path: <linux-rdma+bounces-17063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K7eNESwnGmYJwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:53:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29C17C8E2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B12D63016BB0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973A374188;
	Mon, 23 Feb 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVK3ZQue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408819CD1B
	for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876418; cv=none; b=J1r//XoMaZRJJRUNFFwzN/x0ZBRo+aHKlGSYFnhwxylpu3njj3AQB/oftuODv7WAYGY4a26hOZTv7gsJwqF2xwZQurCbGzWBBCIPJTmiqO4G4JnEgEeIskDARAQ8IXTKe92q5wouxpF9ofTyAGl3miTDe1WiQoxzPrVXHlu11mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876418; c=relaxed/simple;
	bh=MoF8W4Y9Xgzh0gXO2e8Efz2Q9/4RF1bhKadkZl8Uyyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DNEhgAUIC0WsYYhLHB9d1Cj9tu/Jv0MPWINTENQkT3TiMovhIUV0ZgwEm9b+NQw9AzsuWZe6En4JlP9cXVuzY5XlUkmjuy9O51CZbn5z3+3MEehMLFXEoWBpAgJaZNWjgsSj5DBXvGi4snsu/K2k7oglw6pkpl94MZVLFjci258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVK3ZQue; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb390a0c4eso1789095285a.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771876416; x=1772481216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5O17ZRCckIuA3qxb2QvF48kOYEKNorMsGimFxvrRnz4=;
        b=kVK3ZQueH/DqXqgFi0+w5VZ3qpuDJsn69jtLCp0GR7mUMfgENxnOypY9+lWOFPLWT5
         FN/5aZkTRg4uUxmJR3+aNh/YcpdyRkVxA5HvndmB5pFoImu/5n0F4KNztVrAlFB0sNqY
         xhlRrnuxe54Jv5n872XrfZXf1sPDxYy5+RhpKN/6sL7LAYhRmjfAvIkuA6A+n85FMEJW
         aekidz88hUOhwsyiAOMGUG+EohpjpzItz2LwNNsyj8s6dK02DsXauwGUz9b7ukiLijQh
         2zOUvJQ01AKY/bOZyP7XuE0QfWFdgooDQGCDrbIit8GSNbyKhT+wwcS+yU00dVEN+YoG
         WOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876416; x=1772481216;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5O17ZRCckIuA3qxb2QvF48kOYEKNorMsGimFxvrRnz4=;
        b=onzajBqz9uH/ZXQLlpkDKlP516BoKwSDxY+k9Szo58NDNlZMTjthttCOen5sBTHqrH
         MeOPscuU7WhraRJSkDo1hwpwKeEENAwkMFiEacnwGccenZNUkW/rrUjIVSUSgoD30dhY
         jnCQcRKN7IGaElW/rPSUgcgDQ04aO2XnofrWsZo8+6r8GAvfFOMysunybiQ5eCKCvH2N
         j+K1zOuT8M8Mo9JnZ49xcmjMX8loRjWhqrGF9PyuyQZYFxnt+Dg7QgyIlUM0ff2Cwr2R
         pl/UuQ/OnrVkaq3PkkVteDl+6bFRG3hIZNhaqd9LHrxBs0kVcZlkS0emU0MKjRSJ4F0d
         0W5w==
X-Gm-Message-State: AOJu0Yz83Wg+4WHlDPeHTiznoMCJG9+prRvgwIX31d0GNEzlPr6O4KQm
	5XQoCrIB9LtPjgg0IQyIA6ZVawzng0g0BD9fdx1Tj8o37dyQlU3jP5yE2/1uHV68xrHK/gZXnUf
	jGk6novFxPA==
X-Received: from qvbom26.prod.google.com ([2002:a05:6214:3d9a:b0:897:287:bd55])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1927:b0:8c6:a8a6:e164
 with SMTP id af79cd13be357-8cb8ca64fc7mr1265803685a.45.1771876415609; Mon, 23
 Feb 2026 11:53:35 -0800 (PST)
Date: Mon, 23 Feb 2026 19:53:32 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260223195333.438492-1-jmoroni@google.com>
Subject: [RFC 1/2] RDMA/umem: Add support for pinned revocable dmabuf import
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17063-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E29C17C8E2
X-Rspamd-Action: no action

In order to eventually import a dmabuf from VFIO, pinned importers
will need to support revocation. This can be achieved by allowing
the drivers to provide a revoke callback when obtaining the umem.

The drivers can use this callback to ensure that the region is
invalidated in a way that guarantees no further HW accesses, but,
in the case of an MR, does not actually release the key for reuse
until the region is fully deregistered (i.e., ibv_dereg_mr).

It should be noted that revocation is asynchronous, so drivers that
wish to switch to this new routine must ensure that their internal
state is protected.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 109 +++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/mr.c       |   2 +-
 include/rdma/ib_umem.h                |  27 ++++++-
 3 files changed, 121 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index f5298c33e581..cf97653df9a9 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -195,22 +195,64 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
+static void __ib_umem_dmabuf_revoke(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
+
+	if (umem_dmabuf->revoked)
+		return;
+
+	/* Will be NULL for drivers that do not request a revocable umem, or
+	 * during the (protected) window between attach and pin+map_pages.
+	 */
+	if (umem_dmabuf->revoke)
+		umem_dmabuf->revoke(umem_dmabuf->revoke_priv);
+
+	/* HW should no longer touch the memory at this point. */
+
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned) {
+		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+}
+
+static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_ops = {
+	.allow_peer2peer = true,
+	.move_notify = __ib_umem_dmabuf_revoke,
+};
+
 struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 					  struct device *dma_device,
 					  unsigned long offset, size_t size,
-					  int fd, int access)
+					  int fd, int access,
+					  void (*revoke)(void *priv),
+					  void *revoke_priv)
 {
 	struct ib_umem_dmabuf *umem_dmabuf;
+	struct dma_buf_attach_ops *ops;
 	int err;
 
+	ops = revoke ?
+		&ib_umem_dmabuf_attach_pinned_revocable_ops :
+		&ib_umem_dmabuf_attach_pinned_ops;
+
 	umem_dmabuf = ib_umem_dmabuf_get_with_dma_device(device, dma_device, offset,
-							 size, fd, access,
-							 &ib_umem_dmabuf_attach_pinned_ops);
+							 size, fd, access, ops);
 	if (IS_ERR(umem_dmabuf))
 		return umem_dmabuf;
 
 	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
+
+	if (umem_dmabuf->revoked) {
+		err = -ENODEV;
+		goto err_release;
+	}
+
 	err = dma_buf_pin(umem_dmabuf->attach);
 	if (err)
 		goto err_release;
@@ -219,12 +261,17 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
 	if (err)
 		goto err_unpin;
+
+	umem_dmabuf->revoke = revoke;
+	umem_dmabuf->revoke_priv = revoke_priv;
+
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
 	return umem_dmabuf;
 
 err_unpin:
 	dma_buf_unpin(umem_dmabuf->attach);
+	umem_dmabuf->pinned = 0;
 err_release:
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 	ib_umem_release(&umem_dmabuf->umem);
@@ -238,24 +285,60 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 						 int access)
 {
 	return ib_umem_dmabuf_get_pinned_with_dma_device(device, device->dma_device,
-							 offset, size, fd, access);
+							 offset, size, fd, access,
+							 NULL, NULL);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
 
+/**
+ * ib_umem_dmabuf_get_pinned_revocable - Get a pinned but revocable umem dmabuf.
+ * @device: IB device.
+ * @offset: Start offset.
+ * @size: Length.
+ * @fd: dmabuf fd.
+ * @access: Access flags.
+ * @revoke: Driver revoke callback.
+ * @revoke_priv: Driver revoke callback private data.
+ *
+ * Obtains a umem from a dmabuf for drivers/devices that can support revocation.
+ *
+ * When a revocation occurs, the revoke callback will be called. The driver must
+ * ensure that the region is no longer accessed when the callback returns. Any
+ * subsequent access attempts should also probably cause an AE.
+ *
+ * If the umem is used for an MR, the driver must ensure that the key remains in
+ * use such that it cannot be obtained by a new region until this region is
+ * fully deregistered (i.e., ibv_dereg_mr).
+ *
+ * If a driver needs to serialize with revoke calls, it can use dma_resv_lock to
+ * avoid needing to embed a lock into every MR.
+ *
+ * If successful, then the revoke callback may be called at any time and will
+ * also be called automatically upon ib_umem_release (serialized). The revoke
+ * callback will be called one time at most.
+ *
+ * If unsuccessful, then the revoke callback will never be called.
+ */
+struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable(struct ib_device *device,
+				    unsigned long offset,
+				    size_t size, int fd,
+				    int access,
+				    void (*revoke)(void *priv),
+				    void *revoke_priv)
+{
+	return ib_umem_dmabuf_get_pinned_with_dma_device(device, device->dma_device,
+							 offset, size, fd, access,
+							 revoke, revoke_priv);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned_revocable);
+
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
-	if (umem_dmabuf->revoked)
-		goto end;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned) {
-		dma_buf_unpin(umem_dmabuf->attach);
-		umem_dmabuf->pinned = 0;
-	}
-	umem_dmabuf->revoked = 1;
-end:
+	__ib_umem_dmabuf_revoke(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_revoke);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 665323b90b64..ad8b5bcf1b41 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1648,7 +1648,7 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 	else if (dma_device)
 		umem_dmabuf = ib_umem_dmabuf_get_pinned_with_dma_device(&dev->ib_dev,
 				dma_device, offset, length,
-				fd, access_flags);
+				fd, access_flags, NULL, NULL);
 	else
 		umem_dmabuf = ib_umem_dmabuf_get_pinned(
 			&dev->ib_dev, offset, length, fd, access_flags);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0a8e092c0ea8..3d37d5b79dd4 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -36,6 +36,8 @@ struct ib_umem_dmabuf {
 	struct scatterlist *last_sg;
 	unsigned long first_sg_offset;
 	unsigned long last_sg_trim;
+	void (*revoke)(void *priv);
+	void *revoke_priv;
 	void *private;
 	u8 pinned : 1;
 	u8 revoked : 1;
@@ -169,10 +171,19 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
 						 size_t size, int fd,
 						 int access);
 struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable(struct ib_device *device,
+				    unsigned long offset,
+				    size_t size, int fd,
+				    int access,
+				    void (*revoke)(void *priv),
+				    void *revoke_priv);
+struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 					  struct device *dma_device,
 					  unsigned long offset, size_t size,
-					  int fd, int access);
+					  int fd, int access,
+					  void (*revoke)(void *priv),
+					  void *revoke_priv);
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
@@ -220,12 +231,22 @@ ib_umem_dmabuf_get_pinned(struct ib_device *device, unsigned long offset,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-
+static inline struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_revocable(struct ib_device *device,
+				    unsigned long offset,
+				    size_t size, int fd, int access,
+				    void (*revoke)(void *priv),
+				    void *revoke_priv)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 					  struct device *dma_device,
 					  unsigned long offset, size_t size,
-					  int fd, int access)
+					  int fd, int access,
+					  void (*revoke)(void *priv),
+					  void *revoke_priv)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.53.0.371.g1d285c8824-goog


