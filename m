Return-Path: <linux-rdma+bounces-21388-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIgKJKglF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21388-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076555E8340
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2FE5304799A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9244BC9F;
	Wed, 27 May 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="dvFysfZ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38244B69F
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901823; cv=none; b=EVQar5ZyDoL7pr+294to86hIUHFdq5Ou+5lZ4TB7cZ2rh5ceTVzPgq1hF2vfiGzjhqIT2bltUzZQzDGbSEhqqzno53KkuKaN/5B7XeV5si91Hs8f2OsV/Ja1pLkWJCnn7OZ4YJifn4Dk0JBebJRrP/p7nbRLKtU3ZjGm3Pr+Inw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901823; c=relaxed/simple;
	bh=JL1ALejby8xkWWceZ2B1S9dc9zBQ8fnbQTFwn72Yjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoyosAPA8c2Bi99+TRLo6bfSeYFXd1Rp+KJfF9wbldLe4VNkg/+h1Rrc2Bg9qW7rMCWs8jHHUR09f5FQPg0XgWOcq6TQM1lvRYT04HYfz733+FvIRSizrK/7uGk5qKEhpzKWFwk711dCVka9FyW3Ngk+zt1mJkjjVJ+B42drhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=dvFysfZ9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-449de065cb3so11750636f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901821; x=1780506621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=dvFysfZ97mUVZ/RocuNpiG37mvS6Gh1FsyiHBle/+bxRNhVpE1k8+TUAIqBOX2Pvgu
         Xxe3HxfCKO4go1CL4/euohX7lOJUmA/3MmLNzMU2UDUyGjXxMLZDpP50NA6BYb5v3YFD
         lZDn6tNhgNau3XkZg9EpHwMuqOcfhjUook9XX+G66QxQBVTYjAASZKhW0yB/wYZL6l6G
         xRn8CNEviJyxsTNMSYvgNTvx5v3mFe7StvmbngtL2iJi82wSqzZlLo1aZbFoPbuj8GWr
         QffQY0xTWuArhF6TCUahNuxiLXxTuXRHod0jfbZu8cZZgHhvWR5cn2tsonw8F76waf14
         2g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901821; x=1780506621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=IdIQ6/UP+ablbS8zIqFyZrtaP+gGK2o4qhvSpSuOAZainjpOYpv+hzawKrffydsOBJ
         I9LAgjqKqWnYkLEbTe4PCvqC7wZzc/y8/c26N8JSiQ4VwZdgyYECuEa3WSeMpjz7YcBE
         luyUwimhmRNhR4ylihmxJ4fd1/5kgrq1J6IcVjoy99lXOSS2py2nB5vDw5k+R/g41Arr
         pBARvlAQfiT8GqbmNp9R2UTr4Z0p2wOb3b6RrZ4fzeMESxQxsa1vxNfzmIDyVCwZYwYf
         p6b73VxL/XWabkTSwGElP5JkoPRpk0A7pEYula/LHR/WQ6tR1AxLqHW1xHrxXk3/VEd9
         g3ng==
X-Gm-Message-State: AOJu0YyhG22LOtIc9i49HGA13UxJdh07g39vlYGLjZgnRJ7sHRsEDt/L
	IWsoROwR7y6SsTO5dlV/sfhDrHxZyW/QPPilIPGF62mJ+2VxIXCP7y/lwaFZeEZGV7gS3/a1mxy
	27V53r4v/Gw==
X-Gm-Gg: Acq92OHnu1+s+tWMfXMIVf6RHr0UuLKkwnN5Sy2RRYqOHzBxiNIZZ+fmmx6SicqROGB
	jT1hCRxD2ZGCuikE0qfBu1+KcfIJRtCzonIH6XqmymWtVitreehqCkpNHDNTG08Q/R4DC1mH59Q
	JfwkrzPd075IlFnRHq8OCUz09BNaW9OZJQTMKIvELMN7uGFcI0YjjragFtllHlRR2y7HurZOIov
	JQ/n++8noy/7YHfTVAntYarFGgFX6RtinI1ftEsIr+OCjAf8OZgzLbjdekUvhH8ZSZeHXZK3Ebm
	oBUf2lJlmK1qKadS0qgiHiKUVFInzWnKeFik2ZxMmDZZAZAGnU06Qbb7RB151OOtnvWFjNWtMZF
	uDO/27/+7pds7WrkE486jeFWsrUdun582AASn+rBynTKSbzXeHirUteO3mfhDBvGfXi0o1hs5bw
	41veYUX0vGZIZG+d6yOndyAF4+keMABwXXjE5Ae3t0XQ==
X-Received: by 2002:a5d:6f08:0:b0:43d:7c1b:b8c7 with SMTP id ffacd0b85a97d-45eb36ac4cfmr37015768f8f.21.1779901820787;
        Wed, 27 May 2026 10:10:20 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b19aasm8093679f8f.25.2026.05.27.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:20 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 08/15] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Wed, 27 May 2026 19:09:41 +0200
Message-ID: <20260527170948.2017439-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21388-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: 076555E8340
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


