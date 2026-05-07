Return-Path: <linux-rdma+bounces-20150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ2UMFCL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E14E887B
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32FED303AB64
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC563ED5D5;
	Thu,  7 May 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xHdgyrKU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628F3F0AA6
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158365; cv=none; b=IQZYT2nXuvczzXdf8FzFJH/wM/S67HUL8bSnUguRAMDmDEkz4LJU60yl014LG20gf2SqMy3t9Gvs4V5gunMAcBXUdSWW0eJBFsMRygcLM3RkVhhcUdSgHUxgrBQ3j3FHTftL00Z+b+cz4Gr7bhxpe6JtyGJYy8+iqbikvQTTqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158365; c=relaxed/simple;
	bh=A1eouMws/GEUXgpbK33NPZa8qhOcGksyaSuOQpYHLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkrRAe+80HQJH2vFrY8iwrjN5glD9l9OnKpjYwaD5Es1tuD73M3G6ZTUu5pDQc2hdJwn3nUCZ+fsfW5FdSaI3r59mZMh6MtSheOh25Ns+3UAlPkTHh5MHmUcDyjJ6NT1NT8yPmJoPsAdJaDV2TanpWxDLS4LbX25O2Fz6JRijx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xHdgyrKU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so5560965e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158362; x=1778763162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1jiZqIrHeAeROylg5+oRpDcz8Ay28efQQqp+wGJRUM=;
        b=xHdgyrKUtxjGZVxvSk4BYnSyH24QkyjhH8hPzzrTBw83N7g9oayXVU978m+0bL1cAA
         m+yc0qsONBQaNb705lm6TvhNQcj+ttU8Xi6yTUxC6ONkneQRSWVKjrUGMAfw1uLORffN
         lBr3Mqa5/TEmJtRnRuuPAU3cU3P2ZY1Tj1kk5Jtu/TEv3im3iBq64yE0f30QVXXGvs2I
         1SXU2q2zgfl5qhf6KfPyOUxBKesnkXpd755tOOez/UXam3Rl1TQKeTZhVtRI3ACwwmMo
         lvLrABnQT8B2IRR9bPGt/5jTw8kg2ZWq+Uiep0EyVgARBYAD1BTDdi9ANnU5Amnw3Zh7
         ivlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158362; x=1778763162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1jiZqIrHeAeROylg5+oRpDcz8Ay28efQQqp+wGJRUM=;
        b=qGgUO4iKpDubOSmk5gzAsY1rjR0sZbvtohXIwDL+9si/PMlUO5DzAQ5b3SsgWXjUNo
         ZEy7PXsbrd/xT8Bkxx0bPYrwzWc+rOMbAQMMX2qPm+HxqrjoefblBY8bFpJ4ne1hZNaa
         H7/kjkVv24eoSSCu12Z9BclTQmJwKmixdPu0FkkPa0FQ9Mu5qql2LX5kgVV3+l0RIAGo
         bshNzJn2qdpKe8/0YsrtJs6NBfhtDjDHOX06HfMsA64NI2jazdgf/2zptpjfKdROzrlW
         /R+4DoaVA61w8jFECDOOJ/VktNlvWdoY7eUmGdYKEH75idvH5HlKtK1GK8w67vuJO8+B
         hP7w==
X-Gm-Message-State: AOJu0Yw8e/VZyR2IUYWO8vGQstO2mWubkkQ0JAMGsQmqyI6vghHqRv6g
	ETp5jp/0NJxsZjttI6SAki7RxxHylKMwEkfue5C0NpFh4reriN5PCoxUA2rowlm72F7ui9YsxXt
	oy+eZ
X-Gm-Gg: AeBDieuyeGqpKL+14c0bQM1N+4EnDoQVsKeuWEclgYJZ8mefxKdYR077kfQwyOes99j
	3FDKY7oBiWV/TH9YUYl3pJgO6DYt+U+UmKuv6Ujuie7E5RQD2TrhJYR02xpvPtUYAywym0rezZA
	kHAGAb+9eF1jr763HDQeec7JYeCSauRusJQ+Jzp0eFgPRYWLqGb6zd6X8nO4r8rTj1lb5dRklKC
	+qkeFgLgvK7OT+unlaA3EJemSe9GzQ4VhQoAu0b315Al+dz+7G+mr3zYaKgmPVaL4QWKgrqp8lT
	mwV8XNWCe1coj7DZqggNGJeqJfPxDGx2lpQFyuQnl4yV+qtj+1PDhmnFqjkfX2XBKU4LebU66Is
	+i7B42QCUuz04qiutpj1te+u8Se7w7qLBlJHCuDjfqbnyfhFeIic+0y8TugkGxZ3J4b58203TFn
	HqOwRIpBITPJHD22SwLj3aeCZlvmDISJ4f8k8+Mml6JXUDIga6UVTC62dh
X-Received: by 2002:a05:600c:32af:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-48e5dfcd722mr26516485e9.1.1778158362271;
        Thu, 07 May 2026 05:52:42 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm195491585e9.15.2026.05.07.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:41 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 09/16] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Thu,  7 May 2026 14:52:24 +0200
Message-ID: <20260507125231.2950751-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 215E14E887B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20150-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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


