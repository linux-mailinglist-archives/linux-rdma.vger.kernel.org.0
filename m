Return-Path: <linux-rdma+bounces-18630-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG7YM379w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18630-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DE327CFD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DE6233F430A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0D401A21;
	Wed, 25 Mar 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BtgQEhjz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F14401A04
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450871; cv=none; b=iDgdxjdo/MMTZfhvGXGaafymdhtRfSZAmi/uPNWw+/4TFtMLbGJqTdx/MaIoE1aP6/3hJ/NUqKRoOhchtmRKaQTb9brxcYzm5lt1fE/lsBcovKEA/y9szB4ZRJPPFnkQdbveEZgE/zf5Yc5zZcuzRYqLGfkZTPbHwR8pulIBTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450871; c=relaxed/simple;
	bh=A8I8NTTIeX1K0nM5zGV6JQ5MhssXNMGuF6cytuLKTWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaCiWKKNbuT3PVXuMbJTZMPm0Qr9iv+s7HGkFnNPdLJlNaDFyJVFO4+bzJs6Cd4nQ984HZwsfpjelTFlwmPmOr8wfOiqsfX5qem2jA8r8Driy2wCjSIJl5VGVaw16lL3HeBPZa96sMVYzJSC7HattPPvpso0YTrcvSsUNzwIThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BtgQEhjz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-487035181a7so30262815e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450868; x=1775055668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Ni0Q8Bxl7rLe+WjyFwajZGfdy2HRP7y5Qand28NJU=;
        b=BtgQEhjz7bA0yQonnVIoDPIGlfNNwaC4+tBFGAKhin9AJSinz7UtrsUzp0C6udIrMF
         q3MxqcDxsjZmRJxvv+gVzSRo/q046OrlEP2si3fImuyVpgx+n3YwaWsLvkTHaYCVChIO
         qmiNmIqDNtPwPsgpdIXDcC8YAeS7DGfJTO+gZGiPqz3QrZc2UOPsDREY1rrxE+na//Sx
         8LyYo63y0VMm2UsxhF9KfUl99La1IQGXN5U6Cz41tlxQmKuJiafcUB2vccjI9Y8GPWmJ
         hGYwOXekPhq12j2kldOJ5HnajTHfsDZo1A7xsQ+Upl+Y6xkMIE2Xc2hmohiVDFSc9KR+
         Cpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450868; x=1775055668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3Ni0Q8Bxl7rLe+WjyFwajZGfdy2HRP7y5Qand28NJU=;
        b=mxkutX004D+078knpWwNfNol+jjVHq+9CmJ8RHJj/QzhpGt3GebACgMZGwgMu/PoPb
         a0WYwa7m13IKv7CW/dxNEgvJnjCUi4OEihxMMzESJYXXznvRQ23+/YNaFAAVXGJ9e79L
         jCQRQBM1ynrRjNLFRd0+UmjOTCxyDYLvLmxUMsjFYW+ncbhdxY1DfuzIRC/bJ8LZyT01
         U1SF8PoExwGX5q/+GpNoq7SlrdMIVTswsPzhTbsXv1cS38A/ncpPP0YicKtL1J2vBI/i
         +/XTi10YwbJ/7RwtqreuHVufCrszVwJnMNYdbp8refvqNz4wb7zGnbJh3aTXO3iO5J0A
         GivQ==
X-Gm-Message-State: AOJu0YwpHXqsB+eTUeqqJ15g+XwC1oqiwemxWxxW/BvlRic1fyPnZEM9
	ezy2FLL5XnavhRMeM68RWn5YL3Hp/ndUw3egC+surA5n6bmy879Yk2mwzH1J/qV49QhJYH57PPM
	DHtB3l14=
X-Gm-Gg: ATEYQzwauhSfnjgez2SOeKBF+9kDklUE21o67luMYYRFPL9r3fzDE+mAcw1ToXkMai9
	xlZCWqVWYmxmmto7JFFgzqw9Z90RYASuFD1O1uZJW3CXqmh4x25rL89ik3lrLXGZL7ukOy0yFsN
	ZsTLwAtUgN5sb5Ag2FwAPz7AF1U8YaGE8TjQ/freHKGPxfntl0ejYzcYcHShp4zCr1SqUfZBWES
	b7x6w+am/GDguDKE74M83HMGauj62tJnmwD9aWfSBOJJEO/nImOR0EXg8Dyj1bzipi/fy/wSKFQ
	smgQ+KS949rz+KEA4kofu07ULIlNGUevlBvWa6hygvvDYQ+XST5Q48qEqtHVNh7qhJOFwDSgk/4
	4KTGcgo+twj5DAT69eywLf9FoWEob9gEvMV8S17DjWWFqDd9BQpI0okbUYCS82mdJsNRgmGK4im
	1hlqs6SfyiOc6xDw==
X-Received: by 2002:a05:600c:8b6d:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-4871604b905mr63576155e9.28.1774450867611;
        Wed, 25 Mar 2026 08:01:07 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cefd7sm284674f8f.17.2026.03.25.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:07 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 11/15] RDMA/mlx5: Use umem_list for QP buffers in create_qp
Date: Wed, 25 Mar 2026 16:00:44 +0100
Message-ID: <20260325150048.168341-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18630-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 576DE327CFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Load the QP and SQ buffer umems from the umem_list, falling back to
ib_umem_get() for the legacy path. Use ib_umem_release_non_listed()
on error and destroy paths in order to release umem properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 70 +++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 59f9ddb35d46..7d42eda81794 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -938,6 +938,14 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
 				bfregn % MLX5_NON_FP_BFREGS_PER_UAR;
 }
 
+static unsigned int mlx5_qp_buf_slot(struct mlx5_ib_qp *qp)
+{
+	if (qp->type == IB_QPT_RAW_PACKET ||
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN)
+		return UVERBS_BUF_QP_RQ_BUF;
+	return UVERBS_BUF_QP_BUF;
+}
+
 static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			   struct mlx5_ib_qp *qp, struct ib_udata *udata,
 			   struct ib_qp_init_attr *attr, u32 **in,
@@ -998,14 +1006,26 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd->buf_addr && ubuffer->buf_size) {
-		ubuffer->buf_addr = ucmd->buf_addr;
-		ubuffer->umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
-					    ubuffer->buf_size, 0);
+	ubuffer->umem = NULL;
+	if (ubuffer->buf_size) {
+		ubuffer->umem = ib_umem_list_load(qp->ibqp.umem_list, mlx5_qp_buf_slot(qp),
+						  ubuffer->buf_size);
 		if (IS_ERR(ubuffer->umem)) {
 			err = PTR_ERR(ubuffer->umem);
 			goto err_bfreg;
+		} else if (!ubuffer->umem && ucmd->buf_addr) {
+			ubuffer->buf_addr = ucmd->buf_addr;
+			ubuffer->umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
+						    ubuffer->buf_size, 0);
+			if (IS_ERR(ubuffer->umem)) {
+				err = PTR_ERR(ubuffer->umem);
+				goto err_bfreg;
+			}
+			ib_umem_list_replace(qp->ibqp.umem_list, mlx5_qp_buf_slot(qp),
+					     ubuffer->umem);
 		}
+	}
+	if (ubuffer->umem) {
 		page_size = mlx5_umem_find_best_quantized_pgoff(
 			ubuffer->umem, qpc, log_page_size,
 			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
@@ -1015,8 +1035,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			goto err_umem;
 		}
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
-	} else {
-		ubuffer->umem = NULL;
 	}
 
 	*inlen = MLX5_ST_SZ_BYTES(create_qp_in) +
@@ -1056,7 +1074,8 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	kvfree(*in);
 
 err_umem:
-	ib_umem_release(ubuffer->umem);
+	ib_umem_release_non_listed(qp->ibqp.umem_list, mlx5_qp_buf_slot(qp),
+				   ubuffer->umem);
 
 err_bfreg:
 	if (bfregn != MLX5_IB_INVALID_BFREG)
@@ -1073,7 +1092,8 @@ static void destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (udata) {
 		/* User QP */
 		mlx5_ib_db_unmap_user(context, &qp->db);
-		ib_umem_release(base->ubuffer.umem);
+		ib_umem_release_non_listed(qp->ibqp.umem_list, mlx5_qp_buf_slot(qp),
+					   base->ubuffer.umem);
 
 		/*
 		 * Free only the BFREGs which are handled by the kernel.
@@ -1334,7 +1354,8 @@ static int get_qp_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq,
 static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 				   struct ib_udata *udata,
 				   struct mlx5_ib_sq *sq, void *qpin,
-				   struct ib_pd *pd, struct mlx5_ib_cq *cq)
+				   struct ib_pd *pd, struct mlx5_ib_cq *cq,
+				   struct ib_umem_list *umem_list)
 {
 	struct mlx5_ib_ubuffer *ubuffer = &sq->ubuffer;
 	__be64 *pas;
@@ -1352,10 +1373,11 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
-				       ubuffer->buf_size, 0);
-	if (IS_ERR(sq->ubuffer.umem))
-		return PTR_ERR(sq->ubuffer.umem);
+	ubuffer->umem = ib_umem_list_load_or_get(umem_list, UVERBS_BUF_QP_SQ_BUF,
+						 &dev->ib_dev, ubuffer->buf_addr,
+						 ubuffer->buf_size, 0);
+	if (IS_ERR(ubuffer->umem))
+		return PTR_ERR(ubuffer->umem);
 	page_size = mlx5_umem_find_best_quantized_pgoff(
 		ubuffer->umem, wq, log_wq_pg_sz, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
@@ -1412,18 +1434,21 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	return 0;
 
 err_umem:
-	ib_umem_release(sq->ubuffer.umem);
+	ib_umem_release_non_listed(umem_list, UVERBS_BUF_QP_SQ_BUF,
+				   sq->ubuffer.umem);
 	sq->ubuffer.umem = NULL;
 
 	return err;
 }
 
 static void destroy_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
-				     struct mlx5_ib_sq *sq)
+				     struct mlx5_ib_sq *sq,
+				     struct ib_umem_list *umem_list)
 {
 	destroy_flow_rule_vport_sq(sq);
 	mlx5_core_destroy_sq_tracked(dev, &sq->base.mqp);
-	ib_umem_release(sq->ubuffer.umem);
+	ib_umem_release_non_listed(umem_list, UVERBS_BUF_QP_SQ_BUF,
+				   sq->ubuffer.umem);
 }
 
 static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
@@ -1567,7 +1592,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				u32 *in, size_t inlen, struct ib_pd *pd,
 				struct ib_udata *udata,
 				struct mlx5_ib_create_qp_resp *resp,
-				struct ib_qp_init_attr *init_attr)
+				struct ib_qp_init_attr *init_attr,
+				struct ib_umem_list *umem_list)
 {
 	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
 	struct mlx5_ib_sq *sq = &raw_packet_qp->sq;
@@ -1587,7 +1613,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			return err;
 
 		err = create_raw_packet_qp_sq(dev, udata, sq, in, pd,
-					      to_mcq(init_attr->send_cq));
+					      to_mcq(init_attr->send_cq),
+					      umem_list);
 		if (err)
 			goto err_destroy_tis;
 
@@ -1651,7 +1678,7 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 err_destroy_sq:
 	if (!qp->sq.wqe_cnt)
 		return err;
-	destroy_raw_packet_qp_sq(dev, sq);
+	destroy_raw_packet_qp_sq(dev, sq, umem_list);
 err_destroy_tis:
 	destroy_raw_packet_qp_tis(dev, sq, pd);
 
@@ -1671,7 +1698,7 @@ static void destroy_raw_packet_qp(struct mlx5_ib_dev *dev,
 	}
 
 	if (qp->sq.wqe_cnt) {
-		destroy_raw_packet_qp_sq(dev, sq);
+		destroy_raw_packet_qp_sq(dev, sq, qp->ibqp.umem_list);
 		destroy_raw_packet_qp_tis(dev, sq, qp->ibqp.pd);
 	}
 }
@@ -2393,7 +2420,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &params->resp, init_attr);
+					   &params->resp, init_attr,
+					   qp->ibqp.umem_list);
 	} else
 		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 
-- 
2.51.1


