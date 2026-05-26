Return-Path: <linux-rdma+bounces-21317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCG2CS+zFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4105D7EEF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98B0231BE598
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DF4014B8;
	Tue, 26 May 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="yrz6BkTO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E1405872
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806566; cv=none; b=IGlFmXyjTa6mp58TuBZX0iFoRI+HsGb4b9JQZ1CzU6x1FjzK0UppYne6k2Ap+dxnCtqYgF8YlE7hazgeHOHetsgRavRjUFAvgQgwH7Fo+8uvoFRIMArwvE5yoyrHusCPlGaXSPx7H/C3mQKExtemvDczFgNqPYe+2A+Z35rCjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806566; c=relaxed/simple;
	bh=IN8XrRHBqyQJf4RvDB4F9UIWoV8ZolcmZ9pYh+ODDGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ady/z92G7rgTtoxgOf4nv2r7+eHZ4XU5GF3n8W9pgJpDzNZhMSDDOj+Z/moCES8nBpICZQaBjAHLF+GEDzYIDgpbnqeF5/61T3bIe82Vhu5I3Pilu5+FRdCN+WcKNYhb0xv9AlkJ2hN1NDX85FOo1xOvOvSXYO+osoOB7VI0kXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yrz6BkTO; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso20473775e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806563; x=1780411363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=yrz6BkTOeMe7Mp/TtWwXiIpKjTC3CEV5MgHZr/EvAyWULcJbzlNWhYZiowCQWu2fqX
         5FPNP9yzF+3AQXrJMdZoqlS3P798AmyaxDCMoFIgjHpqds3+a1zIrbZuqdgAUgzNJ0G5
         EtplcqUYx5+Gaxqa+8SFmgJzZwLZghnfpLyTlKLey7hrT4AjZAL5PghnHZ7F4O0LlN6L
         81S5L7sGiurX0qq1lksF1CvLqyRUYgv1ZHC77c1B+xIYTpdzsZXJZYevMHTcI447nrPk
         en6BTuCuLa2PKyRHw5BKzDGt0s3HWPBW3Y+BZWSrgdoPAeZEyGEmiUxTjG8ENoFUv/+o
         HCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806563; x=1780411363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9ybo2OUCBIL4On7jktasfAHvutgvVVerka/CoM3i5w=;
        b=b7KOte0qS28zYLfeVk0Fcpy6kfpYElOgsgJXaSJl0YveFLgcMF9MErKQfCcmKN5bdZ
         9ANDDi3JaBRn10/+JFD1fhzcUQXqZ/J2XA7pjP/DoVurzlc4B6koKxPkZPZmY7SRKazN
         wGna/EYzpXBXN/FeTcdUvZzgX6g4L/RHgNzxPHVknnmowYNHG75OozH5BlnzlSC8Ti/G
         RzJw5aXUILVUx5CELqKVdUk8l1PFJyHyNcEQzS02Wt7y8uv5luN8GJ3RKABOaSqSOJEX
         0aQHCBbcaaIwEZUHZzt0+t6njibeC0NV2Dc2KW7p3cWsrqnplfJB0ZGocomCRQ1GoqHP
         9HtQ==
X-Gm-Message-State: AOJu0YyIRsU1/XXbwbTmslH7/jL0Hh+gvzO2CDUH8ud2/oF1ofcrDxbh
	X89VmJmnoUE5vm0VyaG7iqEkRSz+3QoU1ickGYJKv0H6z+ZfUSkx0vBlJCOvujuVOwhQXTuWk4M
	oeLqQIugHKId0
X-Gm-Gg: Acq92OE3WZnLpyh389UQ5niCtq2pWRLn7+ic4idBab3MhIJsOErtekR/cTr7q0kPqZ3
	EWuh3PGujYWMXjYf/tBJzVrwj9YSUO016DTpZPdXa1jnY9WSbT2KFTvfxaTi0Bg4bQxJYhsZ37N
	DzyYW45ldvAsym4TVDkEYrjOzocJ7YpojT5oQD1tJ3vEBl8zqm/14Cnmn45VT+BPWH3nXIB2gaO
	YtuUG8FSu+mEbwKn0vJlSqrfFErxPG76z6DHomlbcUlrl6POo3HYsqfhJT7sgC3DKRIh03G7dgj
	El77CCrTSTS1wMqasa+5StmOlfzB0P9pH/7UW2x56szzfl7H7WfMXb0ENW2mbm6vqu12C3POXtx
	1Uir2Cm53njMzPYmEaIeJIHjFagd7r8UOpOPi7jNMy2bVoAW1yB8ZeJXy8qeE8GkXzX5Z8xsqSs
	CymoUBzQVoJYVgiGivzn8P7cNZ4HYyKC18
X-Received: by 2002:a05:600c:46cb:b0:490:40f1:5330 with SMTP id 5b1f17b1804b1-49042482485mr322531255e9.6.1779806562506;
        Tue, 26 May 2026 07:42:42 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490456274ebsm316082815e9.15.2026.05.26.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:42 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 13/15] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Tue, 26 May 2026 16:41:50 +0200
Message-ID: <20260526144152.1422310-14-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21317-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D4105D7EEF
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


