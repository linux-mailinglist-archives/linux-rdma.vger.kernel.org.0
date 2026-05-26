Return-Path: <linux-rdma+bounces-21312-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKwnMyyzFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21312-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D605D7EE8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A95D304F40B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C73FFACF;
	Tue, 26 May 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="TP/I/3dN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC3400DE4
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806547; cv=none; b=cP6AuO5iAm2FdQQLPfm24/wKXT5dfYQxJIupwon+49EdZy90a2FqtNdHk5wybgRBRh/eHvldCU2s9zdB0XCmDRlepuCWMdA6/ODdqXmc+PUuVWHq7wTuNI8v8uSoeiyynJzM3pwLAAJhMz6F65cTSbsyTgBt0G1K3/H0tHc18cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806547; c=relaxed/simple;
	bh=JL1ALejby8xkWWceZ2B1S9dc9zBQ8fnbQTFwn72Yjzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3xPrPaz6eLoCI6wZdBHtfdJZEKFs8f2F+VgpLhcx72QPWs34mOnCS2AZwo/4yw4dUlz+CmVv8dDoaJOTAoJ6yL+McqxpX8RrJ/U6YTpxrZDYYdZ9YUUB7sbtGyzBzHLk6Ac5GsJK/X4jyRRzl8rTLEfp+46gOKK1dn1XrOgxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=TP/I/3dN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-459bf19e87bso6325740f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806544; x=1780411344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=TP/I/3dNW0MRvwmaUvdt76SL06c6JfjDivzk2vVOhqG8S7carA352tXWen/ggJIYJv
         lsE5/KzTmHrxunN/1lnryr4A0NMbpXpVeoIz1QTgboFgem79Gemewvpnjh3k0ZKqP1QB
         z9s3s75ikEgdnw9cSKrwA3HZlFyxxfgdlZ8TuiTU63GA0D3t9/AJXgOB9yfb3LrxtJ7d
         lj0WPfuN3HkcTgc27Lk+AgxqGig9rwbj7VtCatJPxAO4g3zlCRF/BVJLsW38MQ7tM9Qq
         BXwLb496Mf3SdrxDSMP8Y4iHWwYRCV4PpQm7sQnLdyn/KEwR9iZ1M6kaR92LljI2djWd
         Mhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806544; x=1780411344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqkXGmR2/PUHI9Cm4beBm0J+ILFxbZgRlzc+bhspsLY=;
        b=i+uy6/A/yTvlHaejyXqPZvERX7wDQ7cFhRjHIxDc6nBWyYW4WhD3BbsOsH1mmp6v+h
         ZP425HLC4z5a8y6cn1KQUB4pkZMYnEUtWHOEltIidl/v8PPsio+mBA8O2AQ8NEm1yrRE
         2NDhnC43mz9s4asWlCADW5L+c5vOM8XVdUDvDim4LBsijhJQthoXJ6XD7cUUBuFi4C0E
         +HBf48nw2fEwh+LVED5V/XWmNEaE66vKpMuOTnp2vgyTBBMOJA0YVmYwE/JB/g/DNutK
         YencPvrUomgMY8/YKHrr+iVVUrkyPDnRyMMxL2AF/Muq37Z1QRmTebXRNx3ktyWWFrvk
         Svkg==
X-Gm-Message-State: AOJu0YxsQFJ7HkC724wKxlfjouoBsZed2DU55XWh+3+WdYu2vI7uj2sZ
	Uds3U/Zm1P/2MgaFPc+gghW6ChCfpJD7owIchXKSZ7Mw8sYRYUU2BfsziMugDFaqrYTQE7UYPse
	xQXXUWgjAJw==
X-Gm-Gg: Acq92OGANiBwrN9GU65P+CBjAddfnBY8+ZCCJbzvoRj9ohzGoWhBZIsnl2eFl/xmORd
	G7Kla2SBZT9f3JZmYhHOeHiUrRY8sAS5E937tsBZiDfx5Wks/ZKil7i3Gsf+TZb748h/+U06yBz
	g/TV6Mq/7Qkqktl58ti2iJ7qP4eeU/KqFdygvVOZi8RB7vmvIZWQEjoowK2fT77xW7DzZb3WRGI
	DMMQIpXLG+YoBnHYO/COu8D89P/lt9v6qwRjyz1Rge2vVa+VpaIKGNyFnQCwSdcuFHQOnUx3SM6
	teta+5i2Yxw1SK6pvvN8sTi4StL6Q/QTnwnGACMs8srnk57b1MTZ76lj5DxfrKwrh3uYo6AB8d1
	ZKuzf8Mm2FOlLohm3aMiELcSx3rC/YJ11RhXbrZsA+OGwkep5gp4MPdSJxGshMrytE81Vg0JYAy
	bEVeYCr3r1JNVlIEXLKo8EUy3c2QozIq3U
X-Received: by 2002:a05:6000:2dc3:b0:45e:9366:94c1 with SMTP id ffacd0b85a97d-45eb38a9291mr32308160f8f.18.1779806544193;
        Tue, 26 May 2026 07:42:24 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm37283112f8f.34.2026.05.26.07.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:23 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 08/15] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Tue, 26 May 2026 16:41:45 +0200
Message-ID: <20260526144152.1422310-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21312-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 49D605D7EE8
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


