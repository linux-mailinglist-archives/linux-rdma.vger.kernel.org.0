Return-Path: <linux-rdma+bounces-21508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC+HJxKYGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE19603029
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C44043029B00
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BE33B6DA;
	Fri, 29 May 2026 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="D7HEtS87"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66832E12E
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062224; cv=none; b=oBn+UIjpCvql9Fi+HeA1lQ9TYdAcejJsZPFwxUOL7r6nlcfXFmuelilmbofnivYoMiLPJObKq7TzvquKqYI4wmhbElWM0/6uUKrldNu4lXSNEl+3IsgsYmTXshErne+lVWF31a7HqoQl3yJlG70oCqDF3Zt4WZTLWE7q+sbx2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062224; c=relaxed/simple;
	bh=JL1ALejby8xkWWceZ2B1S9dc9zBQ8fnbQTFwn72Yjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7e2zI9zQ7qCpceB+TNhSPSiIOsYFSwANuQA9RjplXoH/Qd8nYHM3z6KV3oFTmdm+TsGSOXpjOQ75Inio6Rk7Z7rv63WdGjr/MOZzEOW+m1TP9Vmh9Ws8UXE4cpqqcz3U3NifHN6y6WbVAUbubgumQ4mOkAEbCCCKaHgKInVuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=D7HEtS87; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43eb05b1875so7288986f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062222; x=1780667022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=D7HEtS87vvwO7/olYLDPr5Bu1D4SWzTefgdxyQ0wIb0/aw3No8mh7GwBrBKJysGQmE
         AEiSJ+66T6J5ScPVD5ShQJwCd3ZsxMd/9uD2YfT65JWaAeCdwxqWBJPaLfTWW7cOs5Wy
         Va6AMT8NMY9lplOb4wat890XR9/c+7xUWme2jJv1jeBNuelsARPOjfREnzbdemqU+4sL
         XW0gvNOkBnWygL9F+ATSsDtHjOCrvtHQx+yKxTdm7kvpa8QHbSIuZRXeduovs9pQWi7C
         T+bjuO0YTK4eZZ459aREDt+jKlf3SvoO22I2XyrHNM8CgiJbzeszFlgQJrlrq5h8NKs3
         osVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062222; x=1780667022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=C8FcQFoZ5x+JRq30Fqptowyt5Im9InL59wZ9NHM57A0KaT8fMW2S8sNgWGkFjNYFIC
         7iqukeTobQ6meGHFR3JyMSZc90k26dr+cLn7M4rwM6r10tLHk3muPbRUK6+Kdrpd+/aN
         S8tR1NdktYABKafJjQVxYVCf0lzNgqgPPyLKnQEoO1AVa+xLJBn7uuvvhxKlt4Dwgant
         jSvSkvlGLgxTUi5oagSRFPjGbNtH00ugAvqwC0BJ0W/5vQvmeidmKLI0yrFwiqap6RHi
         3yE/hPGEVC5guEIb5SS/kQqpEM7QAXkmcvYjlSyYXIpHQaofstb0eOf8XFqs6gJhpEHe
         1/kw==
X-Gm-Message-State: AOJu0Yy++eZxWV+jxkAh2QsDdhBEk20lAvQbFC9bjhuEQ/9oSn91TNN0
	vE/ip3+rd1nHXL2A4nVG1rde4jksgWfo6vGl0Fr117xJuXRs/0xsNsYgSNonaUkVjjNJT/eFPda
	BfsPTdPpvNA==
X-Gm-Gg: Acq92OEKQmFSjRayLISzvKHfTEzD/5Pq2Ku3vqJDdFdJQl/X8dVIQyd44Gd8JR3CI/R
	O6DPsZ78ftGbv0GWDnixii06VufGSKrLJ8u6+JBy8qMOW4Vxtwa9UK+Tw83hVa2x6t3Sw1V5b3a
	UoOxM+0tu5XFeqJnelR+8UmVOSuw1iGrsakyvBuwhDnvCK6ptMeaEW00HCEa6bqwpucApi+nuiM
	C7/Oz2S1e1WG2A960SgYu2REGLpuyX4z2Bi+DJxAo4/ud5pRSf+RsVxN7AfHNd4/9bQpJh4MeN2
	a/oPysz/mPTQVURQ9uSO7X/NSTdQypUb8rxRbCIjJ0hWgE5iWzdUYpXdOfAdpnyVGiaBVJNbxMK
	PpMVlyBy7mqCedMteqkXPsqU5ShUjQRHynYDZ+wENDGkXPdIkDBlCoB3zcBguv5aylFt5o7R4w5
	eyWhFsTrnzWztAbZvK1dqd3ioTzg+ucSjC0CSEcdvdtIs=
X-Received: by 2002:a05:600c:c04b:20b0:490:3cb4:f1b3 with SMTP id 5b1f17b1804b1-4909c0ba682mr40760495e9.16.1780062221591;
        Fri, 29 May 2026 06:43:41 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm3338678f8f.2.2026.05.29.06.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:41 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v9 08/16] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Fri, 29 May 2026 15:43:04 +0200
Message-ID: <20260529134312.2836341-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21508-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 5AE19603029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf_or_va() and take
ownership of the umem in the driver. Apply the same ownership
pattern to the resize path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- used ib_umem_get_cq_buf_or_va() to get umem, stored in cq->buf.umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to destroy_cq_user() and the resize error path
---
 drivers/infiniband/hw/mlx5/cq.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 5a89676ebeb2..e8f8fcc106c8 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -746,15 +746,15 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 
 	*cqe_size = ucmd.cqe_size;
 
-	if (!cq->ibcq.umem)
-		cq->ibcq.umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
-					       entries * ucmd.cqe_size,
-					       IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(cq->ibcq.umem))
-		return PTR_ERR(cq->ibcq.umem);
+	cq->buf.umem = ib_umem_get_cq_buf_or_va(&dev->ib_dev, attrs,
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
@@ -765,12 +765,12 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
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
@@ -781,7 +781,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	}
 
 	pas = (__be64 *)MLX5_ADDR_OF(create_cq_in, *cqb, pas);
-	mlx5_ib_populate_pas(cq->ibcq.umem, page_size, pas, 0);
+	mlx5_ib_populate_pas(cq->buf.umem, page_size, pas, 0);
 
 	cqc = MLX5_ADDR_OF(create_cq_in, *cqb, cq_context);
 	MLX5_SET(cqc, cqc, log_page_size,
@@ -854,7 +854,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	mlx5_ib_db_unmap_user(context, &cq->db);
 
 err_umem:
-	/* UMEM is released by ib_core */
+	ib_umem_release(cq->buf.umem);
 	return err;
 }
 
@@ -864,6 +864,7 @@ static void destroy_cq_user(struct mlx5_ib_cq *cq, struct ib_udata *udata)
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
 	mlx5_ib_db_unmap_user(context, &cq->db);
+	ib_umem_release(cq->buf.umem);
 }
 
 static void init_cq_frag_buf(struct mlx5_ib_cq_buf *buf)
@@ -1436,8 +1437,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
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
2.54.0


