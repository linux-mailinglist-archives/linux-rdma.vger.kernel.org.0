Return-Path: <linux-rdma+bounces-17349-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDsZFLfWpGnYtgUAu9opvQ
	(envelope-from <linux-rdma+bounces-17349-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E526D1D2099
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DECA3012C73
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5516DCE1;
	Mon,  2 Mar 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/ytfDXJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34E430B85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410546; cv=none; b=Wx71xeAaH0da3K7r2k71mfdN6qYrGD6kAaP/D8Vf6rijmFc4q79qs3RIiNxSwj3qp1Nh2RRoELPDr48aStXsT0cuaBMkZ6LEsBvz8z5imwzp3uQFMAwyvWAkG5G8hFEIzY00qjR2QbrRKJAPSSweHR+3C0ksVYz0gB4cV5j/L5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410546; c=relaxed/simple;
	bh=4YTVLOfO/68i79VL9jmNJPLDaptTdN8kMsA4i2W+VQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gpbQD+Vd2IoVM6ilQHShJVFHWriwRsk5qYadyIZYXkuWJqYwzIJUMXfN18HKIAZC9l0/r5AiO1tmpAYd2RoAXpz6K/lu0hjFQSBavNmnQiBgfHh1rNqDNvbWXwcunbx60YTrQ+XggG5NCh1uelXfM0Maz8iRKYR99gK8lvsk+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/ytfDXJ; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-896f84e69b6so557264226d6.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 16:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772410544; x=1773015344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMGyFolL1CfAofrbL2Wi24oq8rCu1FJBZisiftP+mYI=;
        b=Q/ytfDXJDnnI4UOn3bjh3dDht+AjodiXBRK+j9u1YCePME2D1hPBwbwiJ1k0OiSgCi
         XhO5W1RDmiPsjo0tGJOc0bHrm9e98+nHN67ygzNqmCQ3HDX9tNRzKZP4tbsdQLDvSNl9
         2MVVJimJjzjD79TRzG7W7heAop78o3McB57O555z1bNPBP/vcOW78Vq3DaM9FvibYjxQ
         yHH4HUFgjbPId410+a2RA0uIsWA29UXKIKcyotDMvRXa5gUgop0q//vGHbIt66JaoSLI
         Gm28F2fxoEBx8xObCBAoCXkpEUMMBHhIgwObWPVDxuyj61eqfIIpyagETYhcwvSvzGox
         zUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772410544; x=1773015344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMGyFolL1CfAofrbL2Wi24oq8rCu1FJBZisiftP+mYI=;
        b=DVTor+O6pPQ6wfM28OY5bKRyCeoj30YdR3RNLOGuT0IlL3GY0OQ5jipdvT/e+gsBzS
         0J3O4QeUcRp83gtgxERq3uTXY7KsiBUF7nn3QgSv2Ros5QuTWYXgc9ivXwgwEsxHj5CS
         0mq489U5dD3F6LIhIws5omklGomYaZEKa2NPeHpT4PuiQSwcHfbUer718iaHYGaT5mR3
         qYq4uZZno3I4aYwZN8xVo7YxZLqPwIKIJmevnyWAZMUO1/0gT0metSarGyyWBmVbd3NS
         FkmhZz+jD9HMTK82oz8NSI4J9dKZl62018PPoCbSvBlgXIIuQTPHAm5mE1tiUkIyjLGz
         CuDg==
X-Gm-Message-State: AOJu0Yw6VnlI+wxkiFbGAdMSZWQHFZiRsnaD0gmtR0fqOm8+/vv9UPdX
	8nLe/fWkyhCFYNh/wG6gJc8php6Q7pNqqVHOcYcQynqn7jPoQPe/6xQr7KtnSokRijuSrl88rfZ
	uJHLYU9ibsQ==
X-Received: from qvbpc16.prod.google.com ([2002:a05:6214:4890:b0:897:12e:8e9a])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:28d6:b0:8cb:4059:a908
 with SMTP id af79cd13be357-8cbc8de4dc5mr1250612785a.22.1772410543433; Sun, 01
 Mar 2026 16:15:43 -0800 (PST)
Date: Mon,  2 Mar 2026 00:15:35 +0000
In-Reply-To: <20260302001539.2275303-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302001539.2275303-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302001539.2275303-2-jmoroni@google.com>
Subject: [PATCH rdma-next v2 1/5] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17349-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E526D1D2099
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
2.53.0.473.g4a7958ca14-goog


