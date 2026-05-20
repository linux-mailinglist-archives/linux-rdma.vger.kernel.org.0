Return-Path: <linux-rdma+bounces-21041-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIUmI16KDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21041-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:18:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C658B9B4
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B4E30F9EC1
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911B3D667E;
	Wed, 20 May 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="R5HVVO5S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38BC3D5647
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271910; cv=none; b=aYRhS+cJUr9rGZOL2xQsZyA/b805NQg82PPC17Qgc0CkBV3pbV/16M/6mdd5AQMCcEUvLXcWHa9Ziatb49q8sxAUMz8FvotqmX4f7ZkeFjBI/e/PcEtm96qPFHVRF2o11lZo5azIj5JRzH/qSMJuC9uQqT8sKw/puGEm+VswSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271910; c=relaxed/simple;
	bh=JL1ALejby8xkWWceZ2B1S9dc9zBQ8fnbQTFwn72Yjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGAqP6NhpRz+wnzSS27+4WAbz/3+E3JHjXVV2VtCtqhYBJ1mmT5roa41cdeX/FdbFWkgF3tAac+W2nlAnCQE7spDLfnes9nqpqM0WvaEtzht7NeIue/NM9oq4oFSTij6/jw9UasJbSv4WIVzDV54Iy7x0WA/HV4KU0VOkENUock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=R5HVVO5S; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so35968885e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271907; x=1779876707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=R5HVVO5SN1bUTGKNbjcTHhzIOgFWPkOa28fN6Ok909RFlLCXYeMysXlYLk2BQ8LQfV
         bWaa317n3A/0LBexf/gzkYcc0Om15CK31G2ZVRWUDUubFju+R4O2f+i3wNx0kNBrwPfI
         EqdKkPCM21yZ6ZiuJdfbUpFZ/uX0aAWGSqtR6LQaEuvySVJZpKC2I8OBS+6EqQqfyYxs
         7auK7LeJqr5lC9s5+6N0ODz6uOU/E261GCw57r7KLdfojmdKMt2Sbp5MyofvqPixS9C3
         m76MJ17DoEDrAR8c639eKAFtfRvT3tejt2f8HxiaxOhi2Igd3mYt7eYf2g+PTt63vQxO
         j9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271907; x=1779876707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=TDN2QtZFRKPR1yG+9I7WIc/9/7ABgqb29HI2NlfzYnECYIJGVsmKlrKhE0hQvvCRA5
         /iZ7zuuHDUH5sHPtUolGg84cPTtw7fvzR1vda3+r3FfnaVGQZlmCLPLf9QQZK6ePSDz5
         JtoZkInnapBcCyMT5gb5onEnH6O4vkXVZLE9+ULSpXV1LqjcMeZkR7cw07Bg6TYR/gDP
         4sCQ1ah2LR6b0TiGJmof2MDgZk4wuHP6YdXALO4RApIPblDFBub7VzzyKrr8oc26DgZ+
         cEAZdBbPOZqDi2dAb5upFrloBt0NHyRpOzDdRa22tOrVzJAY/q5m8G3Iwue0jZVDCoLC
         zWTw==
X-Gm-Message-State: AOJu0YwWEHnqbO+hz6W8Abxhne5R6pUWa9XpIQdQzzShTvQsBDt+/aUO
	DHChnQ45k3L11vTCGLtlEeHeEzzYXToQyK360guQyZs4xIE2MvmsxJkwUCnHsBPijf2xh9Z6sht
	URtZgta2L4A==
X-Gm-Gg: Acq92OEFQi0ZhObCF1Pp+ObKGvl/BfjJu3STjtFEG/SE6tOPHFV7L7E2GOAsGwO452f
	ZxDObvudF0CgbIu7M0VtI3Tf5oCZO6Ob9BzgeZ3laDPwLlsgNskAEf02xxDvb91+1kAiPIc50w2
	G2jGhHMd9F+S1BBB//Nfq0yFj+7VknuhDez/hI+OJ9IoRnrREchmiX7LpclfrnYNylZrpbf7TPZ
	t4gaUgP0t/HRQ3uBVVSFtPVU8oVm04XBnjaIzbL+41Xs4xl9Vtl2KaQY2Pz/3NicqNWe47dS4YW
	H34UhVupIMTdjkE85f7UvgX3OUZPSUV82BhNDLXQDXFi2BgImMPEphgjd2J4DvWN3oqdFTHV+mi
	eC/OE6byiO8m352EMZC4D7UWZZIX/kXlFU+t7sFN740BrW8cl3mRyLPIPzQb+5tuaAay5JvEzaL
	mfCd0S8Xp1wSREHJAO1JZyKUyiidHRbUTB
X-Received: by 2002:a05:600c:8b45:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48fe63253f3mr349268705e9.21.1779271907023;
        Wed, 20 May 2026 03:11:47 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm403026355e9.8.2026.05.20.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:46 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 08/15] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Wed, 20 May 2026 12:11:22 +0200
Message-ID: <20260520101129.899464-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21041-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: DC8C658B9B4
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


