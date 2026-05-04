Return-Path: <linux-rdma+bounces-19922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK9OBnSm+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA014BE4E2
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E3AF302F71C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC73DDDCF;
	Mon,  4 May 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fVjM+Xyx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C223DE420
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903073; cv=none; b=atsUyg/TIJNwFRA/WtrM/1LBWFW2Wau7z5HVPvQqFmdZtkrkDhpOquS9u0CUkqF7OmHiaXTjKulJUpJrTkPGVB+MMibNWnEGHyEopZav4//hshaS3zthdp4F6+1B0P+hazxM2IJktXFUm9HPhSlUzVJ3ffsyUoAUWvQGwSAllEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903073; c=relaxed/simple;
	bh=A1eouMws/GEUXgpbK33NPZa8qhOcGksyaSuOQpYHLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1bCE1PkSZnzBqSYd/erdDvv/4cGmrgxU22VzvapyEzQ0iYL2ZPdNFB2WaqYJeXP4f/BvCaDSh+2WPePhmjrolV7TqulUdkRZiCnsE8qoPvwhi/yU7Vgtbg3+hDdit+Aqpgd3v/8g4X46GDkhDwKTAK36TKsah1BdYau9r4SEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fVjM+Xyx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44c350a5b87so909205f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903070; x=1778507870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1jiZqIrHeAeROylg5+oRpDcz8Ay28efQQqp+wGJRUM=;
        b=fVjM+XyxSdH15XTHPcttqJYnxItqowU++90FowTrZK5nUEr5GnBEe+CspMkdGWQ42L
         bI14FEAXzpgoVEixMKp67bwxAwUT9+OuuCzkJoPXDsX1ZTDaTAy/+94HOMoMmJborC+F
         zxmAeiqIisqVSZR6RgGZmUrM4JII/M+NMWdrXmfCD3yp2Xsc5558ufiAB53Bdf6j9lSK
         TK7KBvWzj00hJQpeVoS6cWJHu/SV25tc0Xxd5FK93/NPAp2ZlAaqxBn3C1ARbH6wsXg1
         AgAFDKk0Ia5Yn6jsDaibggMvkez2fHEwS7AvGR9oSyqXcOv/ShN6v/9j5wTeMBjIQtwp
         RRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903070; x=1778507870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1jiZqIrHeAeROylg5+oRpDcz8Ay28efQQqp+wGJRUM=;
        b=ByGE08xbcQhxKDmb59J6FTZwxQGb2jA11lF+j9jyASsV3E2+ru7QoMRd+yRTjDXj5a
         pDZhxYXDtOLC/7IpjxaJ+uEau5yJLIyJXmj51+E1yRhhUyP/COdOmhycak9ci+4WKlAG
         iUZ2PFrLkinRa7L2MSDxw635FqTBnjzM3gvQ/SjRFZPwf4Q48csvfhkCmBHmcYPET5k9
         q+wz1K8v9fIRIEjGLLrSnAxHoG7a4AB/iXsUp84BkOhs38eDjrnkcg+XWVavyAas/P2D
         jc0exTtzKa3YVJ7wOONvLcXPrf9B/bDmA0dikn/4WW94gHXyHPn1LY/leTPxiDorhQ5x
         Vx0g==
X-Gm-Message-State: AOJu0Yxo+S7Nq8fClukm5SxASR4cs/syS2HDSM82jvEtBIlkOqNpQuBf
	OsTzfcOg5A9qyRs+tHlPoVas0NjGvZ+hDFZig7JWPn05zOcajxWy0Z/8+13O9ADcX9qQ//3iZ5r
	UGw/k+Dw=
X-Gm-Gg: AeBDietXlNMQ7gHugsafM4WmdYshIa+oNxy+OdlacVLrbYGycXRfKc6K5TS63i20YUm
	HHRQnY14vga23ewMV+rmIoyDUv5fxRy/p3R92i0YiVHsk9MVlZwZGVXjspHuIgGc5tnakj5wVsA
	mwcNGxLuMiZ/3j0r0FFmy+Pw4aHMvh55fP5aS7CJ1hnUvj+f0FpfavhTnfOzdRSfJwhzJPqhDTy
	oBnZoBIyrTvIqdX851+J0HlJ2+z2TQlm2R16MFJYnaIwDw/4TWgWOxp0XTHP3A7VxLu5ic6cHUL
	Q1znG0YUB5fiyzo0sJNwX+zYN4WeTMxCvt3JawmEGTWTaAOqgmZT6lwj0geRtqlgQ2jN6L6FdRS
	H4ypfqehvnqufNdfETR05D7Ld1M1pcXxn5UybPnQAb9Ub+UIcc1c0zfAV2hiC5eLr/T4rYuGCu5
	nom5yQ2Jvx8l+Z+I1DUr33XIMA
X-Received: by 2002:a05:6000:1841:b0:43d:7dc2:b655 with SMTP id ffacd0b85a97d-44bb3aa9a9fmr16717377f8f.15.1777903070290;
        Mon, 04 May 2026 06:57:50 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cf97sm30538463f8f.6.2026.05.04.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:49 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v3 09/17] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Mon,  4 May 2026 15:57:23 +0200
Message-ID: <20260504135731.2345383-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FA014BE4E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19922-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf_or_va() and take
ownership of the umem in the driver. Apply the same ownership
pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- used ib_umem_get_cq_buf_or_va() to get umem, stored in cq->buf.umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to destroy_cq_user() and the resize error path
---
 drivers/infiniband/hw/mlx5/cq.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index b8a4a69c5686..fb6172a9be57 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -745,15 +745,15 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	*cqe_size = ucmd.cqe_size;
 
-	if (!cq->ibcq.umem)
-		cq->ibcq.umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
-					       entries * ucmd.cqe_size,
-					       IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->ibcq.umem))
-		return PTR_ERR(cq->ibcq.umem);
+	cq->buf.umem = ib_umem_get_cq_buf_or_va(&dev->ib_dev, udata,
+						ucmd.buf_addr,
+						entries * ucmd.cqe_size,
+						IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(cq->buf.umem))
+		return PTR_ERR(cq->buf.umem);
 
 	page_size = mlx5_umem_find_best_cq_quantized_pgoff(
-		cq->ibcq.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
+		cq->buf.umem, cqc, log_page_size, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
 	if (!page_size) {
 		err = -EINVAL;
@@ -764,12 +764,12 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	if (err)
 		goto err_umem;
 
-	ncont = ib_umem_num_dma_blocks(cq->ibcq.umem, page_size);
+	ncont = ib_umem_num_dma_blocks(cq->buf.umem, page_size);
 	mlx5_ib_dbg(
 		dev,
 		"addr 0x%llx, size %u, npages %zu, page_size %lu, ncont %d\n",
 		ucmd.buf_addr, entries * ucmd.cqe_size,
-		ib_umem_num_pages(cq->ibcq.umem), page_size, ncont);
+		ib_umem_num_pages(cq->buf.umem), page_size, ncont);
 
 	*inlen = MLX5_ST_SZ_BYTES(create_cq_in) +
 		 MLX5_FLD_SZ_BYTES(create_cq_in, pas[0]) * ncont;
@@ -780,7 +780,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->ibcq.umem, page_size, pas, 0);
+	mlx5_ib_populate_pas(cq->buf.umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -853,7 +853,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	mlx5_ib_db_unmap_user(context, &cq->db);
 
 err_umem:
-	/* UMEM is released by ib_core */
+	ib_umem_release(cq->buf.umem);
 	return err;
 }
 
@@ -863,6 +863,7 @@ static void destroy_cq_user(struct mlx5_ib_cq *cq, struct ib_udata *udata)
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
 	mlx5_ib_db_unmap_user(context, &cq->db);
+	ib_umem_release(cq->buf.umem);
 }
 
 static void init_cq_frag_buf(struct mlx5_ib_cq_buf *buf)
@@ -1434,8 +1435,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	if (udata) {
 		cq->ibcq.cqe = entries - 1;
-		ib_umem_release(cq->ibcq.umem);
-		cq->ibcq.umem = cq->resize_umem;
+		ib_umem_release(cq->buf.umem);
+		cq->buf.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 	} else {
 		struct mlx5_ib_cq_buf tbuf;
-- 
2.53.0


