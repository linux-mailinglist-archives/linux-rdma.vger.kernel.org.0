Return-Path: <linux-rdma+bounces-23277-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aIt2AG9pV2qjMwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23277-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:05:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6925075D48F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FijBLDHi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23277-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23277-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103503072B47
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA3446849;
	Wed, 15 Jul 2026 11:03:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A5334692;
	Wed, 15 Jul 2026 11:03:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113419; cv=none; b=geiUYtZm6ZyK950YVrUcZ+x7BfSFuIYUSIa9VjHMDKID0ERGCtgHLNCIaOGcUu8d5/ivdV+Qq4PY/SoTT6gke58kSSkFDTJO+QuSNJVswyKYIzvvVdO6bthCeRBBtIjsQ0nOp7+6kC9N4DbzVOODsROt42i1IMoVWHZwCsuA6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113419; c=relaxed/simple;
	bh=mIpyjSxJCIDvrqI9R1Kq81l9GrFi0L+7TF/IXvrEpXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaYAUlT340fYy8cm6WJ9CJrSSn5yHnaibz0Cef+a9ZCWn1Ziv9yvSPIOMsN1cIWTjimNnycbzjnjQT4VYJzx5VV0c5M3jHBODUZrwzlwcudf8ehCHUiLiQskdmS8SoniDz5dQPIUZltYBNn/+b3n96r2P5tAV4HeYh/S3ZZcqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FijBLDHi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858861F000E9;
	Wed, 15 Jul 2026 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113418;
	bh=CA2d2kU1oTVwSL1+B4sDmaQjh3T/3PPYj8qWh2dEGxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FijBLDHi3oiIEPNxkrWpk2SFIneNFQXitLXJSUuRh3KY/FNwz8cE3nz8Zb5PJiyso
	 Obz2fSg0VUTkK6VdNIJc0QSGIMyzK5hZuTeINTo1Udt62izMmgxnfkyCi30suVWi3+
	 33FX82L9TF4wubAmzEHQtz5BA5hRFkZG+PuJmzN7OBwihR3kNNhpKzfaEhuqRdWk8w
	 h9zSTacVogivN80NGtTUsf/l73UBnxkVESv97hxVvXTmdAxx6wMDxlkGUSzLMaK+Ba
	 y4mh5J/tla5zKFRmcMU6Vj+AXsEsgpg6+lZ54K78aaduP1GNPZi6OFfdVYWZknyFQj
	 BvCU8rk61aCMw==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH rdma-next 4/4] RDMA/mlx5: use kmalloc() for UMR translation buffers
Date: Wed, 15 Jul 2026 14:03:12 +0300
Message-ID: <20260715-get_pages-to-kmalloc-v1-4-b0b7fce288be@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
References: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:jgg@ziepe.ca,m:yishaih@nvidia.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23277-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6925075D48F

From: Leon Romanovsky <leonro@nvidia.com>

mlx5r_umr_alloc_xlt() allocates physically contiguous scratch buffers
that are DMA mapped only in the DMA_TO_DEVICE direction. kmalloc()
provides the required contiguity and alignment for these sizes while
preserving the existing GFP allocation policy.

The emergency translation buffer has the same requirements. Convert all
of these UMR buffers to kmalloc() and release them with kfree(), which no
longer requires the caller to supply the allocation order.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c |  8 ++++----
 drivers/infiniband/hw/mlx5/umr.c  | 11 +++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e8bba5a76d4e..d65ebdef2823 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5500,13 +5500,13 @@ static int __init mlx5_ib_init(void)
 {
 	int ret;
 
-	xlt_emergency_page = (void *)__get_free_page(GFP_KERNEL);
+	xlt_emergency_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!xlt_emergency_page)
 		return -ENOMEM;
 
 	mlx5_ib_event_wq = alloc_ordered_workqueue("mlx5_ib_event_wq", 0);
 	if (!mlx5_ib_event_wq) {
-		free_page((unsigned long)xlt_emergency_page);
+		kfree(xlt_emergency_page);
 		return -ENOMEM;
 	}
 
@@ -5540,7 +5540,7 @@ static int __init mlx5_ib_init(void)
 	mlx5_ib_qp_event_cleanup();
 qp_event_err:
 	destroy_workqueue(mlx5_ib_event_wq);
-	free_page((unsigned long)xlt_emergency_page);
+	kfree(xlt_emergency_page);
 	return ret;
 }
 
@@ -5553,7 +5553,7 @@ static void __exit mlx5_ib_cleanup(void)
 
 	mlx5_ib_qp_event_cleanup();
 	destroy_workqueue(mlx5_ib_event_wq);
-	free_page((unsigned long)xlt_emergency_page);
+	kfree(xlt_emergency_page);
 }
 
 module_init(mlx5_ib_init);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index c595b85b428c..80d0d190b26c 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
 
+#include <linux/slab.h>
 #include <rdma/ib_umem_odp.h>
 #include <rdma/iter.h>
 #include "mlx5_ib.h"
@@ -517,22 +518,20 @@ static void *mlx5r_umr_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
 		     MLX5_MAX_UMR_CHUNK);
 	*nents = size / ent_size;
-	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-				       get_order(size));
+	res = kmalloc(size, gfp_mask | __GFP_NOWARN);
 	if (res)
 		return res;
 
 	if (size > MLX5_SPARE_UMR_CHUNK) {
 		size = MLX5_SPARE_UMR_CHUNK;
 		*nents = size / ent_size;
-		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-					       get_order(size));
+		res = kmalloc(size, gfp_mask | __GFP_NOWARN);
 		if (res)
 			return res;
 	}
 
 	*nents = PAGE_SIZE / ent_size;
-	res = (void *)__get_free_page(gfp_mask);
+	res = kmalloc(PAGE_SIZE, gfp_mask);
 	if (res)
 		return res;
 
@@ -548,7 +547,7 @@ static void mlx5r_umr_free_xlt(void *xlt, size_t length)
 		return;
 	}
 
-	free_pages((unsigned long)xlt, get_order(length));
+	kfree(xlt);
 }
 
 static void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,

-- 
2.55.0


