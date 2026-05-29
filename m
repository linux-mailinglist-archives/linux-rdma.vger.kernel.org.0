Return-Path: <linux-rdma+bounces-21513-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADlkDXOZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21513-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F960316C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91058310EC45
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721C1624DF;
	Fri, 29 May 2026 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="eOjbYP5H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080833D512
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062241; cv=none; b=ZZrZ02Y60uGAPfV3uqSvdwEo3mcmoajHHWE4FlCO2OdaKqAFBKe+Ib0qvWY63jB5hWhMvMYmJGg0HNq5KdLuEIomox4+caGZxwW6wU0DTzso0KJPV5ziUhllkfC6HCSAnjQ7PCtTb+On2VoaEjdhD7JgzB2y2gCAlwe0UnYsZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062241; c=relaxed/simple;
	bh=IN8XrRHBqyQJf4RvDB4F9UIWoV8ZolcmZ9pYh+ODDGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ply+tKkel3NvWEjHtHsFs4sLG84s//Mz0AyCSuqdzer+hBaDEfqUZo+4IE5H7FnR6Ei2Na6k2sf7EW0npqeE58F3h3v8mDikp03eT7qJ5VgeYyz8CkPusy88F+YI+KGe5JfTBEb5HHMi8cMmjbOz1BrWGtVcLmjeMaB6yjIH4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=eOjbYP5H; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48fde648a71so92522335e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062237; x=1780667037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=eOjbYP5HnEle5PLYL4JUlsHkuo3J45z6xnYaLzdoL+C5Qv82YWD1/Hhm6LmS8CH4za
         fjnMuGyLl+KkJ/ZwZX5emRjVmwR3eB1YwrljmVzm0UvnktrZK2ILAisxccxDSadMTylb
         EF7Xn3c/gNyRfwFDWVAXrMcC9M113vRpg1SJ5iOhwNGVPpZ8QOaLyJVu4VG3US8P7ilH
         825wfSGoZxUy2LhoGZb0s38LVVBBmk2u9V+n6EhghRhL9xixdDxAVOpK8j/LDFTRcXvl
         NaOyT7M+XtNEUaPLoYGph11fH1KUDfQ9x5QKXSNodJmucTFeWa2m54buhKtAqoPUmrzC
         zaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062237; x=1780667037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=SwcL8Twcjpfm7WCbQoJJsm3SdNibFkOoSssBANSXrzedWQa6CcupDt515RbddkhOu6
         Kw2sbaiM5Y8vi4MvtFmNzVVNut1czoxTGMDwOxyDEnANlQN7jis8+JTCADdfT1k7vd6x
         6vW99Za3MLKzjh7X/2EbGIjyUL/fS2lD43UvC/M1lK2zVwNubpeuFcd91CkiZCOVaqUc
         q3ABRi/Z02yS3DFRzKtj19F2+v1+t3iOvqEWzxU2HLcnN4KLvS2YbSnicr8SVn2BVqYS
         fvh1fY6GfoPvatjAQSkqcp+mzYeA46mo/yn7Mz0NLY3YtXM2M57WpuFAi4h97DlvGfmW
         QZFQ==
X-Gm-Message-State: AOJu0YwxG7KEk11vBuAFS67XHq8t8hOQ8yY8tssO45S6+oaNGMX/5eDc
	DyqSHLsNdQNO1YsgYJZmOyReP7+8ZI/NWOGGYKtcMY0b7vhymAWT4tuketigwz2NF68OdYjtRbp
	zkbxHMUWOsTuL
X-Gm-Gg: Acq92OHcdLd9rUJ3FjgRa5NS+TrA6xmyERBX/SuwAikUHzOHu4Wix19kPVoHYhgNGVz
	7p3tAxd9ySoYh4mHQYXfJvDi2EPnloz78x4uH5l+QnooEyqp0woCsnDjqueXNhfsVVOJmLpTQ+S
	q9nzBqTmI4AbgODnhJupGLCx85kqaGOpb0dQj9optC64pqSpuFBPHHvbwRVcDTYunod4ECGah73
	QYu0IA5sfqx13Z+Xa7njgIfAeXgRNQ1DUCiot3vy8GTqSqzaEShq/AEKx9sW2kJSNp3B0xUH+w4
	Fj0R7514sjXUvorVfHL1SWH8KJfJmmXpeJYV4aLj9n/g1gVQUa1O4mCpmP24DrIvqK7tOGxaaxF
	LcUXiIi4aCyC9GKAKNMQPZMwiW/yrL9AKJHOYfPIcbw1vFpa2jxS67Go88Liub8A5a0idAfJ1e4
	xxsHtYVCoaBTPmyonNIzjvlMVS/x7C0szppUNV7v0BsNs=
X-Received: by 2002:a05:600c:8207:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-4909c62336fmr38367255e9.10.1780062237597;
        Fri, 29 May 2026 06:43:57 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c127befsm15452135e9.31.2026.05.29.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:57 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 13/16] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Fri, 29 May 2026 15:43:09 +0200
Message-ID: <20260529134312.2836341-14-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21513-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,nvidia.com:server fail,resnulli.us:server fail,resnulli-us.20251104.gappssmtp.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: B14F960316C
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
index dc5e6e3e5a64..dd5611800531 100644
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
@@ -1700,6 +1717,7 @@ static void destroy_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *q
 
 struct mlx5_create_qp_params {
 	struct ib_udata *udata;
+	struct uverbs_attr_bundle *attrs;
 	size_t inlen;
 	size_t outlen;
 	size_t ucmd_size;
@@ -2121,8 +2139,8 @@ static int create_dci(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (ts_format < 0)
 		return ts_format;
 
-	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+	err = _create_user_qp(dev, pd, qp, udata, params->attrs, init_attr,
+			      &in, &params->resp, &inlen, base, ucmd);
 	if (err)
 		return err;
 
@@ -2289,8 +2307,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			return ts_format;
 	}
 
-	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+	err = _create_user_qp(dev, pd, qp, udata, params->attrs, init_attr,
+			      &in, &params->resp, &inlen, base, ucmd);
 	if (err)
 		return err;
 
@@ -2394,7 +2412,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &params->resp, init_attr);
+					   params->attrs, &params->resp,
+					   init_attr);
 	} else
 		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 
@@ -3274,6 +3293,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		return err;
 
 	params.udata = udata;
+	params.attrs = udata ? rdma_udata_to_uverbs_attr_bundle(udata) : NULL;
 	params.uidx = MLX5_IB_DEFAULT_UIDX;
 	params.attr = attr;
 	params.is_rss_raw = !!attr->rwq_ind_tbl;
-- 
2.54.0


