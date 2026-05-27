Return-Path: <linux-rdma+bounces-21393-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNqEAtAlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21393-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 201815E8365
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED5433024888
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDCC44CAD3;
	Wed, 27 May 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cK/g7cUj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC744CAE0
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901841; cv=none; b=QlVr1bHGN/2+m4YZf5w9AK6viaVSaLC5fxbDfAOBCCtzaKyKGyhvWtTn3MUmGhlQG0PYOqI//rMZXsXn5MrQPLZApB6cyulMugb3fY1WULAPta+wRuUfVTLq5es87XtEgsGWHuQa+g8MY5MpkXBz54am0TWkVGg8kQIJ3jGgg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901841; c=relaxed/simple;
	bh=IN8XrRHBqyQJf4RvDB4F9UIWoV8ZolcmZ9pYh+ODDGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsyprSDPR9wOC9E2G9ez00pYCxl4Aw9thsf+0vEB5FRQ0KqBSixDrxkZ3HmQ6P0F9wP4yn8XwpAOfp+NRhUMT121VY4TNkekFg/X3ABY++0kvh+dfkFAjQTWVP4gyP1nZNBohkabs7fpuBzdrrLW88kHfSFAN0g9duWm9K1cD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cK/g7cUj; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ed9336049so1649062f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901838; x=1780506638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=cK/g7cUj+qURxsW3BlIS8+PGtExab0guJXrR4lpQbOxlvF2ULOVwvazVNdLSWCB3T1
         ATHvbWyUUEiEsN6TV6nYtjt3N2xhdpn/4FnQzLNTLyJEgtnb2O4ms+e0I6CfCNP1esrW
         im5xekUyKkWw8wI43nKOTzHaFcWFcFR++/JpkGwN6/SKFi3nPEonKsmagXG//iylZE4i
         EuHcpXrz+22hHbINsVZ2IlJSznilctXEtPM7956as+p0XsewtWnU+w0zkJM7mrgjCaSd
         G4GAqqL3toCewY3T3vfVccqumhioJCqDZMCgIczFVbCDbN4q8kiqmsfxAR/V/sk04JLS
         1m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901838; x=1780506638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=HX9mgSS2IgtIrCkSztUIFTBNvE0tiXGNUdkJn4rQBRFhDGp/Xs7B1NhI5WvT2FZvzH
         NTcw6WpsXpcuD8MuBD6wzHr4/5IhB4JqJyzR8a+EjtxuS7y0TXSqv15fM/1IMOak5c2A
         TiBhKmWUMmlLb2Hzae7uKGUscS1di+Lp08Lv8SdF8MVm1y3hqMi0JZKUic8ky3/TAs0N
         21v6Oj8658WUwzsibq6+Nmz1RC/aZn6GqIbZk5qmIdU2Mdk8IfFhCeBzJrfvbYc8D6fQ
         FsD5J2GYYcuKleUtjuhnRc+75NpCPyUv/ZQ9ieeycvxIkoiN+GWr4d7Z9JCkE000BeVM
         N0Cw==
X-Gm-Message-State: AOJu0YxaYW+LEEVF74+0xFOJrXCBt+KnBdZjjptWvXJWB8ETjDFqGe+W
	lDyAdwhfSFdHFsJhjl/x8mmA5BQKT+V45tvla6wHn/vbRE4lXHDya5xoJNm63peweP37dxEYyXz
	RdRhNtbrXGgsw
X-Gm-Gg: Acq92OGl/GLgFECTrQ1APvOXnph7Yh1fzXDH5Ie6FJbIHj4mfwOpI/RNPypczM+DBy3
	IvuzvR8YMdUzj7X0xxPgnszCpetPREFzKIXBdRLdtOrFaMnqnTw+RXFK0FDD8s2DkNgmpCqwXMA
	GaxOpE+YLk9r9hRAzaAoWE7yf7OFK9JP5mJPXuobqGuIfm3yJjV0JH9XiZbr/Qx0gNedMIqugj3
	m+0p95Lsu0ef+3Fhar6WwCKQnC5NFrBeIY1KehmKXn3SguhaXuHN6KAnkTY9+WQ3jWPU6PyZGCt
	madexeDB7pel2ZdRXK8Xih0X+/hQAH+d7HcRyEdU1s/jbuRgCU8CaWNJX1pypFqBh+WDfC7aSeV
	6rFt0rA3wJn79MUIB1fFKlQaKhA6eNQa+VCLZ9XxCRCbNRbm6WGm8PaAUd/kUDDORLboFlIVXNq
	JcnAg3MXxRGOzRQt1QNfjl3DyzDPjbvu4=
X-Received: by 2002:a5d:5e8c:0:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-45eb36acd72mr38691071f8f.23.1779901837649;
        Wed, 27 May 2026 10:10:37 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c1e59sm6730932f8f.33.2026.05.27.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:37 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 13/15] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Wed, 27 May 2026 19:09:46 +0200
Message-ID: <20260527170948.2017439-14-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21393-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 201815E8365
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


