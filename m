Return-Path: <linux-rdma+bounces-20819-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK9/JZVgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20819-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF5B55F808
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A542C30205C8
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB62F87B;
	Sun, 17 May 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="jP9BYLTV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC625D527
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999422; cv=none; b=DJastBpUyVz0p0IK8Bz+hoLV9xYvYd+MaD6kia0s0eALFVV5CckfbmMBT0vD6/jgehvFrQofYzFe9eK7IlG2g2XdjnhJNRZSwmZ3RtzzwmQin8xojWTNA8VQB+sgmKrmlToS9Hqtz+0UVlMEV0D6v9CCDZZmAOMzInhBDvIc57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999422; c=relaxed/simple;
	bh=T2bj7fZYtaM97oEacKCJRES7eazgpv6sZs97jTarllk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hynydkn/QSmWA9fA7fmIiBYumre0mAv0aZWVCXsn94PQWkJCZpjieXSFSxXo9a1KzPHwTn339xrtfHFxTtU+X19bEbqSwLHzlteadLZpUsSpZCP/l+CxhUwilPx7jzK/LWn3BsOF36r8vmPK8tjppLx5pLG9naSSXadRk+2NsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=jP9BYLTV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so10929465e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999420; x=1779604220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTJjNIUYALrCrZc6pQDmoqxGYNn8eJv3o2LGcZRBDfM=;
        b=jP9BYLTVo2o6i9DOcP/uihsFNW2T27UBREF954MYvpc+6qV9+8EN0M9sUBhOG2yZfQ
         Id0SH353HdbkNV54xriTlteuO8aL1lrJA+7KhrZAOijcpX82e+SFKPT2GYOZMnk+7Jf/
         8eIQnCljfLfRPOIU40sNRIX7+fmiUlSSoc5ty/yfUf+/TH0p9rj7E0JWl7yIiuNGK8Wm
         P+1SdrbpXIi9ZVbVL+1xYOkdy/7uuaRZ51fjUqbo3H/TSQJjptmDbSawnb4JCZeJl7WO
         WIBrNdp6VwM0sr2XLTfURvGTV+sA/dtv4qcTOnG5LCmuLDSbrFx88oo6eW1wSzTI91ly
         u74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999420; x=1779604220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTJjNIUYALrCrZc6pQDmoqxGYNn8eJv3o2LGcZRBDfM=;
        b=ToUMM6O0Z1DYox7dIaJmoeSabnqh5RlOSorwRhbp0GUKFyHUKyrnGyWTyTqcdhxfue
         VFg7BZN3d2HFDt+7X1Se0n8gXk7mbuvCSpq2k6Sr0JUsYbibKXzkyE7Bxw8kHuo4ioRz
         Fv0FxKYyNUOo4BcGzBr075vIsuD6KT2LuciuqycCIZDCiGlW86Z2QYC9WPuFuK9G2cvL
         LUn+NNpgDN5lW8f6B1lyJ/ztm3BSVr7gmdM1zPwd9T5FV+ox0fS7TaiImNdyATuW2Hh6
         McnS1cdoCw/SBducm4lHjVY2Y3flqKl9m0mtOytp5+55S4oenXz8563UWxdX2JvnF40I
         V7MQ==
X-Gm-Message-State: AOJu0YzQZPqBZHAreMc7int5bK60D/b8sIO29gt+95UflV9DnQMl4uUh
	B3hdsWHLC2bPoM7PFPdkXmBykmt/pxKz8+VYOxcYcS1TwKKwjlJHDaaalUTeU3ztSfkyUq5AAEe
	tia3kT2xg53PE
X-Gm-Gg: Acq92OEsp+N2DLBxpbcQecA+Oy2zrBRIJPiu4YteKv8oiypOnBEHoYWH+UY/AQkviPM
	7+AgXFL2EZgid1Yj8iutuc5y0cjui4TZp6qlPIXWWil/VLAE1vi6vUktRonSUPlnkysaJQoOosa
	nQKYYMu60xR/435lJ17q1gRSApMcU/M/MhjaiQAsNlLD5x9/V+rKIG9F8AUWkVI2aUrOPf6JyTk
	y/OLKwzfxzrpHLHZ4RVmMjEYfE3oj144OjPzCQS+VYndtJiszQfWXPP3eTG9DSqsSVM82oheBiU
	jRj9RPoh5lOfUTSaUZDmG30kDU76f0dqyJ1oGjg+Va9PUWTkKVlfIcfm9vDhRkIKTEJd8Qm5hiI
	NLs7iNO+i/kTJP+9xWZ7iuAjbOp3AKEaNqrEQJWMmex+zVorOQtttEurSIB6TAPmTysda8v/HgC
	6DJ5n9lYBZbvE6/ubcO5agbGLvhKCyxgKwabzzeY2iyvfSKw==
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48fe6325978mr142031325e9.20.1778999419827;
        Sat, 16 May 2026 23:30:19 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ffed68baesm22591275e9.0.2026.05.16.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:19 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 08/15] RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
Date: Sun, 17 May 2026 08:29:59 +0200
Message-ID: <20260517063006.2200680-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DF5B55F808
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20819-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
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
index 39d51f294bcd..04917e454d29 100644
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
@@ -1435,8 +1436,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
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


