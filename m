Return-Path: <linux-rdma+bounces-21046-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGQ8Kq+JDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21046-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:15:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28D58B84F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 378BC3033A71
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186A3D6690;
	Wed, 20 May 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cHvYO01O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4F3D6463
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271922; cv=none; b=ktbeZGhzImONlNi7K3pJzBpr/7dIWmeFaHfvDf8oM3BzK3USr4yQza3r9aokyXNaZ/ieKVenT/C7/4rHA2LtgyEsBR06CBqZdBGSY33P5Yt0GdzFjTOEFmEJ4cCgYvGMoXudzPikVpwXcx/8XVWz1jNrqEfnPRIkrmrRe9YkVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271922; c=relaxed/simple;
	bh=p3sdFZSoyJUpVz+EYqm18BMz5s15SjuNl9dDahjDnds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWChYfrGx78djul8OCA8qJGQikZaaZr39ozE5jGcxx3Y+VIEwNytVXfKpa7KM3mPFyB8mgDr1y8si5ur41XZNVrUreJYkPRZbd6GqFiG5nmW6DyxuYywCLJ4y8ZF+0DJhJQTDDSSSVv9dy0z8Wpx0fuws71SKuqk9Ug9XODakLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cHvYO01O; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48896199cbaso37201985e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271915; x=1779876715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev3jHG9glZbz28G01jwqK8zLmNjzQKjBFoZSnddw7eU=;
        b=cHvYO01Op0nTl/RKVoQJlnuh1TPKEJVOb+a8MGzp64/DxFmXoQRymCO/5QfmJsoME9
         Xc6kQ9KGgJ62ia6xy6xk+bUroPtWCmATJR2za97WXp1spaLTyzT0TgKrnczqyXM+14DY
         S/80aWfgekP2BfwKl0MX+QtdFCG684W4Zk9/yo493NV3F9vwGHNYrNDB3NAuWxfIIpoS
         Jb5FZvTY9IuQKHCiaXnph+/d5T59XLoH1/emsTWf0sm7rjgQdocx3u9DDFimC5+I9av9
         ecnjEUe7IzUo4AZ2hnfcBvLK+7tog5/7ZSnG10h6IOpgC4B3GZHp46efLYt4fSc9v3ep
         RD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271915; x=1779876715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ev3jHG9glZbz28G01jwqK8zLmNjzQKjBFoZSnddw7eU=;
        b=b9jRR2uTaN4i4kDk1hhfLX44TU0StEqvyGmcnwpXgTzCUk7RK9eFoR28m+5gaChqw1
         2JOfAGvo8R5LK0JjZ65oWEeP4u6rRKUY6InKNgd9kkBXWsXaig1PBiW6zONtxa/NMUBJ
         qHmRJW5VLGgd7lNbW9NAL1w3c0aOOlSp/Ry+UxqJXFFsMNylE1jAr8X/xAvpCv61Fbzx
         Ch5bcIAMsC92hdKAVmD4dUNbwtvMwGZh5sN76wlT/MnopAVrDbxY5xdl3kHEqOMpK91m
         JJCHZnrhC5z5DyB3Fb94fTc/0ApTDz8sazGluVUh6yNA8I/n4JGXZThynL3YQKpgvpUh
         zm1A==
X-Gm-Message-State: AOJu0YyLrwYMDe94jFIy6/VntfJddyzKbUjEV0j44UPwhAc4MzyEkNtY
	2dLw2zeCVI0qN2rkfAW8bPMWVqvkcfsGcEoY34YaeI/MqFN0SzOx/0FkwKRNKTaCRv074m8aPqY
	G9s8JGlcdWJGK
X-Gm-Gg: Acq92OHXaW2C3p+N2yndJlSo893c4RS1S6SRd9GaO92I7EIKafLdvrShm2T9AfFjFqv
	Tke53sNjheV9QEhgAC+cu/CdOeZMY4P9HOY7HebrbVCfsyRafpvQgXJp/IbNQjGNAZdH8a0mEco
	8Xoz6KTGnwCGU0euTaCXHdw+eAThqPr6FE2+UP61X1uk70yJiGAq6b3GbeHS0GOZj8r5RbxEhpe
	aB0xd0f9EZzIc3R4yOAqwdnX6XVdo4QQk+/aDD0Nv+8UOHNYb/FdncuAwBVxpNWRc+kGuwRLwSs
	7vGtwykkDnmGWhEws1wSx1h+MaVKjqPgWqQsa4Qe9EaT8V0UM2dEzVagES7POpddUSMqq1ppJ90
	H+6gDpgoHx1VfQgqV2EcSeISHCWcNyHjUq7XGCrBGBC4mekQaFSjrmHx6/qfZgH2oO6MBw2CSIM
	wE+tRD5VjQajS1LwGJp11Zt/EbA+qCacD2K2NgxjAyKGo=
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-48fe6631679mr370349175e9.33.1779271914855;
        Wed, 20 May 2026 03:11:54 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm667147515e9.6.2026.05.20.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:54 -0700 (PDT)
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
Subject: [PATCH rdma-next v6 13/15] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Wed, 20 May 2026 12:11:27 +0200
Message-ID: <20260520101129.899464-14-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21046-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: AD28D58B84F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helpers to pin QP buffer umems on
demand. The QP-type predicate selects between the BUF and RQ_BUF
attrs; raw-packet SQ uses its own dedicated SQ_BUF attr.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- changed to pass attrs instead of udata to ib_umem_get*()
v2->v3:
- changed to use ib_umem_get_attr_or_va() per-attr
- added ubuffer->umem / sq->ubuffer.umem to store umem
- renamed mlx5_qp_buf_slot() -> mlx5_qp_buf_attr()
- replaced ib_umem_release_non_listed() with ib_umem_release()
---
 drivers/infiniband/hw/mlx5/qp.c | 46 +++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 57cc3aadb8e3..11b1deec7f42 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -934,8 +934,17 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
 				bfregn % MLX5_NON_FP_BFREGS_PER_UAR;
 }
 
+static u16 mlx5_qp_buf_attr(struct mlx5_ib_qp *qp)
+{
+	if (qp->type == IB_QPT_RAW_PACKET ||
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN)
+		return UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM;
+	return UVERBS_ATTR_CREATE_QP_BUF_UMEM;
+}
+
 static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			   struct mlx5_ib_qp *qp, struct ib_udata *udata,
+			   struct uverbs_attr_bundle *attrs,
 			   struct ib_qp_init_attr *attr, u32 **in,
 			   struct mlx5_ib_create_qp_resp *resp, int *inlen,
 			   struct mlx5_ib_qp_base *base,
@@ -994,14 +1003,20 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd->buf_addr && ubuffer->buf_size) {
+	ubuffer->umem = NULL;
+	if (ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
-		ubuffer->umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					       ubuffer->buf_size, 0);
+		ubuffer->umem = ib_umem_get_attr_or_va(&dev->ib_dev, attrs,
+						       mlx5_qp_buf_attr(qp),
+						       ubuffer->buf_addr,
+						       ubuffer->buf_size, 0);
 		if (IS_ERR(ubuffer->umem)) {
 			err = PTR_ERR(ubuffer->umem);
+			ubuffer->umem = NULL;
 			goto err_bfreg;
 		}
+	}
+	if (ubuffer->umem) {
 		page_size = mlx5_umem_find_best_quantized_pgoff(
 			ubuffer->umem, qpc, log_page_size,
 			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
@@ -1011,8 +1026,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			goto err_umem;
 		}
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
-	} else {
-		ubuffer->umem = NULL;
 	}
 
 	*inlen = MLX5_ST_SZ_BYTES(create_qp_in) +
@@ -1329,6 +1342,7 @@ static int get_qp_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq,
 
 static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 				   struct ib_udata *udata,
+				   struct uverbs_attr_bundle *attrs,
 				   struct mlx5_ib_sq *sq, void *qpin,
 				   struct ib_pd *pd, struct mlx5_ib_cq *cq)
 {
@@ -1348,8 +1362,10 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					  ubuffer->buf_size, 0);
+	sq->ubuffer.umem = ib_umem_get_attr_or_va(&dev->ib_dev, attrs,
+						  UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+						  ubuffer->buf_addr,
+						  ubuffer->buf_size, 0);
 	if (IS_ERR(sq->ubuffer.umem))
 		return PTR_ERR(sq->ubuffer.umem);
 	page_size = mlx5_umem_find_best_quantized_pgoff(
@@ -1562,6 +1578,7 @@ static int create_raw_packet_qp_tir(struct mlx5_ib_dev *dev,
 static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				u32 *in, size_t inlen, struct ib_pd *pd,
 				struct ib_udata *udata,
+				struct uverbs_attr_bundle *attrs,
 				struct mlx5_ib_create_qp_resp *resp,
 				struct ib_qp_init_attr *init_attr)
 {
@@ -1582,7 +1599,7 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		if (err)
 			return err;
 
-		err = create_raw_packet_qp_sq(dev, udata, sq, in, pd,
+		err = create_raw_packet_qp_sq(dev, udata, attrs, sq, in, pd,
 					      to_mcq(init_attr->send_cq));
 		if (err)
 			goto err_destroy_tis;
@@ -1695,6 +1712,7 @@ static void destroy_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *q
 
 struct mlx5_create_qp_params {
 	struct ib_udata *udata;
+	struct uverbs_attr_bundle *attrs;
 	size_t inlen;
 	size_t outlen;
 	size_t ucmd_size;
@@ -2116,8 +2134,8 @@ static int create_dci(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (ts_format < 0)
 		return ts_format;
 
-	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+	err = _create_user_qp(dev, pd, qp, udata, params->attrs, init_attr,
+			      &in, &params->resp, &inlen, base, ucmd);
 	if (err)
 		return err;
 
@@ -2284,8 +2302,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			return ts_format;
 	}
 
-	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+	err = _create_user_qp(dev, pd, qp, udata, params->attrs, init_attr,
+			      &in, &params->resp, &inlen, base, ucmd);
 	if (err)
 		return err;
 
@@ -2389,7 +2407,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &params->resp, init_attr);
+					   params->attrs, &params->resp,
+					   init_attr);
 	} else
 		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 
@@ -3269,6 +3288,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		return err;
 
 	params.udata = udata;
+	params.attrs = udata ? rdma_udata_to_uverbs_attr_bundle(udata) : NULL;
 	params.uidx = MLX5_IB_DEFAULT_UIDX;
 	params.attr = attr;
 	params.is_rss_raw = !!attr->rwq_ind_tbl;
-- 
2.54.0


