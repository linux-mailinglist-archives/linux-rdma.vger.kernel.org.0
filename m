Return-Path: <linux-rdma+bounces-18540-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNa6Cz+ewWmFUAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18540-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 21:10:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA112FCEF4
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 21:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5A133002F75
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDE369208;
	Mon, 23 Mar 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KASqr5Am"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F13382F9;
	Mon, 23 Mar 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296629; cv=none; b=swGoDFs53qmPaUwDTt/OurwUOyPmtQMZY+BwWsiE25MynTiCJNuyJ+SCL7SKWdXalC/fZJhOnfHgoYvt26Fc0y6ThQDzUa8dN5UT+OobSau4dltKhanrUqQuMTiII+KwkaYy82y4mDkgjpJJ0WHxS5f2GQIuUqC9gcov6Vp5u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296629; c=relaxed/simple;
	bh=9EUqw43IRwPSs7AIcAVQ7yfdM9pOZ5dryGY58RHj5z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RkJXMKf4Q26ucaqC+IzhDFJ30DiD33Ol/r8k8Rg0bTR2+4xlknLhaaVhLICwmR0gbFMYDf+tty4N63eMW0iQfoY6hEgEjlir01IsRGaw5aPT4plUgxGGsqzVAozLj7yVhOJYbXoDXPZcfTZEd5c/insShz+N+Uh6C9RNfsPTr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KASqr5Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396CC4CEF7;
	Mon, 23 Mar 2026 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774296629;
	bh=9EUqw43IRwPSs7AIcAVQ7yfdM9pOZ5dryGY58RHj5z4=;
	h=From:To:Cc:Subject:Date:From;
	b=KASqr5AmhkM3gcEi1v6BDOlCnS/6pUAWljiTOBEs+DyysTe+TumqZke4+oItRAeqX
	 vdUxyKau2goR6wYYvCF80xO4HN2JmRIwG2WGN4OpDBXrwfkkCzuGpHyEqrsQB/P3iI
	 DQGv4J1SUsraHwQK8AFLRgFjFPdhGLjrfkLEo9bB8zxdGudQqXTCApk2yU5QAuQ1DW
	 wEdZ99HVXimy7d/MA0A4WeNlC4Q2F8Ul6JZg6d1AsfXcgKPaWHNNYKX5j/jbsWXudZ
	 l7DUp3S9fc6gg0hlVbni6Y4XW2eraN/qiq09fH/Oal9ISIjcA6zGMWjDFFLtv6bGUe
	 jxaARiCCDeUGA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/umem: Use consistent DMA attributes when unmapping entries
Date: Mon, 23 Mar 2026 22:10:18 +0200
Message-ID: <20260323-umem-dma-attrs-v1-1-d6890f2e6a1e@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260323-umem-dma-attrs-8e2b80e09c4c
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18540-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BA112FCEF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
The DMA API expects that mapping and unmapping use the same DMA=0D
attributes. The RDMA umem code did not meet this requirement, so fix=0D
the mismatch.=0D
=0D
Fixes: f03d9fadfe13 ("RDMA/core: Add weak ordering dma attr to dma mapping"=
)=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/core/umem.c | 11 +++++------=0D
 include/rdma/ib_umem.h         |  1 +=0D
 2 files changed, 6 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c=0D
index 4eef7b76fe465..f5f187593ef17 100644=0D
--- a/drivers/infiniband/core/umem.c=0D
+++ b/drivers/infiniband/core/umem.c=0D
@@ -55,7 +55,7 @@ static void __ib_umem_release(struct ib_device *dev, stru=
ct ib_umem *umem, int d=0D
 =0D
 	if (dirty)=0D
 		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,=0D
-					   DMA_BIDIRECTIONAL, 0);=0D
+					   DMA_BIDIRECTIONAL, umem->dma_attrs);=0D
 =0D
 	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {=0D
 		unpin_user_page_range_dirty_lock(sg_page(sg),=0D
@@ -169,7 +169,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, u=
nsigned long addr,=0D
 	unsigned long lock_limit;=0D
 	unsigned long new_pinned;=0D
 	unsigned long cur_base;=0D
-	unsigned long dma_attr =3D 0;=0D
 	struct mm_struct *mm;=0D
 	unsigned long npages;=0D
 	int pinned, ret;=0D
@@ -202,6 +201,9 @@ struct ib_umem *ib_umem_get(struct ib_device *device, u=
nsigned long addr,=0D
 	umem->iova =3D addr;=0D
 	umem->writable   =3D ib_access_writable(access);=0D
 	umem->owning_mm =3D mm =3D current->mm;=0D
+	if (access & IB_ACCESS_RELAXED_ORDERING)=0D
+		umem->dma_attrs |=3D DMA_ATTR_WEAK_ORDERING;=0D
+=0D
 	mmgrab(mm);=0D
 =0D
 	page_list =3D (struct page **) __get_free_page(GFP_KERNEL);=0D
@@ -254,11 +256,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device, =
unsigned long addr,=0D
 		}=0D
 	}=0D
 =0D
-	if (access & IB_ACCESS_RELAXED_ORDERING)=0D
-		dma_attr |=3D DMA_ATTR_WEAK_ORDERING;=0D
-=0D
 	ret =3D ib_dma_map_sgtable_attrs(device, &umem->sgt_append.sgt,=0D
-				       DMA_BIDIRECTIONAL, dma_attr);=0D
+				       DMA_BIDIRECTIONAL, umem->dma_attrs);=0D
 	if (ret)=0D
 		goto umem_release;=0D
 	goto out;=0D
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h=0D
index 38414281a686b..2ad52cc1d52bd 100644=0D
--- a/include/rdma/ib_umem.h=0D
+++ b/include/rdma/ib_umem.h=0D
@@ -18,6 +18,7 @@ struct ib_umem {=0D
 	u64 iova;=0D
 	size_t			length;=0D
 	unsigned long		address;=0D
+	unsigned long		dma_attrs;=0D
 	u32 writable : 1;=0D
 	u32 is_odp : 1;=0D
 	u32 is_dmabuf : 1;=0D
=0D
---=0D
base-commit: 1c3eaf5186228f0b20ccb776e86233f069475380=0D
change-id: 20260323-umem-dma-attrs-8e2b80e09c4c=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

