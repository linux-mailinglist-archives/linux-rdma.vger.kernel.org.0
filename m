Return-Path: <linux-rdma+bounces-16426-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJL+Kwm3gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16426-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68310D665E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1F5306ECB0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13846396B76;
	Tue,  3 Feb 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hdz08YJI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9C39525B
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108615; cv=none; b=S0tgp7smcDTlh8Yj5ZHBeEtDrZeBeiXgPNYxO8vcmfYxXhLg3O+iVpq0cMW3YDfFuA9dIXfzbGBdSpGq07m9wg+qd1p34lPCUCZcEJ12M3y27y+1LWALhZnf/svfhecePzBUgIPaMh/FCAlAJg/IBfgOpgsIRu0Eq7vJPQjrQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108615; c=relaxed/simple;
	bh=70XksUxXISey00VKAmFLtgGTd3Z9x/L+cjeySdeKT0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ciahp/QcAcblOpu8bCQJ2tbNHWSWtbi5xP+ouU/UplvTrcHmXVGoqXRwCrXmaowvFcrw66WhRSgEw036PBEA1pKRZznm173nZKXpc/UFv132MEZxZ0N1JxDZrzcVpcOpQ42gYdV1NMni5mhr26WFYvY63J9wZTfPe1rF7XK5gFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hdz08YJI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so3383135f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108612; x=1770713412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii57nL4DyQb8hGIbYXf5p+zOezvq+H3U24RVqRUyVUE=;
        b=hdz08YJIKtRxa+QZoCiXhfj42EDyQ8sfsbIuqEQfLjYF3zbYnCf0tAhPu9phEzlqZB
         DBeguP5LAldUn97EJex5GaRBmtmuF0cgbbe8FsnGPgweTGjZa1ildHB/4aNRpMvn1w/x
         m0BPrgI+RK6D0PFTWsmBKww6Z9pOoDwFD647EnB/cq5HvVIz2plMDp4CFrUlvjMJE5Un
         PDQ85b1gXqXV3sbQkUJ19NYDUBtzkwxgUck9l1WBByR/5eVnNxjWNn0VQMnSy9GHkykL
         4Nu4KAhJn4Gpaxy7HgmTqKEGbRLgLa8Hr85V6dPldh+El298lrQzdWSsdoJj6tRPYPNx
         XT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108612; x=1770713412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ii57nL4DyQb8hGIbYXf5p+zOezvq+H3U24RVqRUyVUE=;
        b=dNgaVje/Qc/DGfed1TYCNRA83rhoY5cEfYMhZHq/7r2NZccmGNkGUHaQSYrL0K4V8Y
         Rt1E/jdhR1RoXJVckSuMMFCGSVtFIb4FrM8B5QbwTVNSAKU7NmKYpoF0J2IspvOaawak
         0YzhjXU4sMH0rDzx04h2TUlShAROeOB2h1M2Ayd+OVGgiD0W5Dn6AtlCzSjnSIZdFbF6
         HEvvF7Ho2Huz+ZVawyqWl6UJE6MK09KGguKsrvl0ALetZKANi9Zk6Grypd5yKulQaeCx
         EGwJ8jSivneIjjaj2TD3QKE0U5J43HK+npn0ux8v0ZnZaWi/0GFSvXHl7A5oWccJpt4S
         XduA==
X-Gm-Message-State: AOJu0Yy44aAo8K5Opio3ypTk1MRN9TgJOkZ8Svl4hXZR6RtB8M5kgee1
	l1bZESGf+TmQk4uy+gdbJvUy7VT9/t4TxXTMc3mudvB4RGESRDML4p3FzMxZMIsEenEPY3gMphc
	CgJWY
X-Gm-Gg: AZuq6aLqU0gHceAsiGtiIoUbucPmYvgsZV/IXVQfXzYGaggrncotrjcBD+/+8W8B/Vo
	0h8UFZlE2ht0UFeQd4CSzG3lqAxJWUfrhHEhVtM9Gx1/bGdjtCQUKDXfKhKP+a2PIDvB5ETdzfO
	GlQ9H8KotO8gFeT7NBGr0jyCy5B96nA4A8rtw6JUH+PqpMkrkwiDspqJ1LqWwk2shurGzNdRygg
	lZcUNtDW/onyYTFSGkk9rCcb4aYKdVJnit3xuI8FWFtUOQ5YRbWVuhLl1fB0Z57alm8jvDeDNTV
	iwnmkaWz/IYC47+BChoS+ApTTLwaAfjji6dprsxyIdcqrR/PLSS3GqraAR8DG5D/ZzRO+5Glp25
	qf/yvSXzy3hqq4BrWhStFpuFsXmRSAdBEQMNTVg0IfQviKJ+Lmy6d+1gylEOEfciVom8n7CE2MU
	UOkA==
X-Received: by 2002:a05:6000:1846:b0:436:14d2:5414 with SMTP id ffacd0b85a97d-43614d256b7mr1038999f8f.55.1770108612374;
        Tue, 03 Feb 2026 00:50:12 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322dc7sm50423209f8f.37.2026.02.03.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:11 -0800 (PST)
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
Subject: [PATCH rdma-next 06/10] RDMA/mlx5: Add support for QP creation with external umem buffers
Date: Tue,  3 Feb 2026 09:49:58 +0100
Message-ID: <20260203085003.71184-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16426-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68310D665E
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Implement the create_qp_umem device operation to support QP creation
with externally provided umem buffers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Id53b7a0bfea91b6653ef6590f019498afffb58ab
---
 drivers/infiniband/hw/mlx5/main.c    |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  3 ++
 drivers/infiniband/hw/mlx5/qp.c      | 81 +++++++++++++++++++++++-----
 3 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a719738ebd0c..e77a46e463c6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4449,6 +4449,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.create_cq = mlx5_ib_create_cq,
 	.create_cq_umem = mlx5_ib_create_cq_umem,
 	.create_qp = mlx5_ib_create_qp,
+	.create_qp_umem = mlx5_ib_create_qp_umem,
 	.create_srq = mlx5_ib_create_srq,
 	.create_user_ah = mlx5_ib_create_ah,
 	.dealloc_pd = mlx5_ib_dealloc_pd,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 25efdae83d27..755d7c17dbfd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1356,6 +1356,9 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp);
 int mlx5_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		      struct ib_udata *udata);
+int mlx5_ib_create_qp_umem(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_udata *udata);
 int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata);
 int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr, int qp_attr_mask,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 69af20790481..010f707e209d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -943,7 +943,8 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			   struct ib_qp_init_attr *attr, u32 **in,
 			   struct mlx5_ib_create_qp_resp *resp, int *inlen,
 			   struct mlx5_ib_qp_base *base,
-			   struct mlx5_ib_create_qp *ucmd)
+			   struct mlx5_ib_create_qp *ucmd,
+			   struct ib_umem *ext_umem)
 {
 	struct mlx5_ib_ucontext *context;
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
@@ -998,7 +999,26 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd->buf_addr && ubuffer->buf_size) {
+	if (ext_umem) {
+		if (ext_umem->length < ubuffer->buf_size) {
+			mlx5_ib_dbg(dev, "External umem too small for QP\n");
+			err = -EINVAL;
+			goto err_bfreg;
+		}
+		ib_umem_get_ref(ext_umem);
+		ubuffer->umem = ext_umem;
+		ubuffer->buf_size = ext_umem->length;
+		ubuffer->buf_addr = ext_umem->address;
+		page_size = mlx5_umem_find_best_quantized_pgoff(
+			ubuffer->umem, qpc, log_page_size,
+			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
+			&page_offset_quantized);
+		if (!page_size) {
+			err = -EINVAL;
+			goto err_umem;
+		}
+		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
+	} else if (ucmd->buf_addr && ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
 		ubuffer->umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
 					    ubuffer->buf_size, 0);
@@ -1335,7 +1355,8 @@ static int get_qp_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq,
 static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 				   struct ib_udata *udata,
 				   struct mlx5_ib_sq *sq, void *qpin,
-				   struct ib_pd *pd, struct mlx5_ib_cq *cq)
+				   struct ib_pd *pd, struct mlx5_ib_cq *cq,
+				   struct ib_umem *sq_ext_umem)
 {
 	struct mlx5_ib_ubuffer *ubuffer = &sq->ubuffer;
 	__be64 *pas;
@@ -1353,10 +1374,21 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
-				       ubuffer->buf_size, 0);
-	if (IS_ERR(sq->ubuffer.umem))
-		return PTR_ERR(sq->ubuffer.umem);
+	if (sq_ext_umem) {
+		if (sq_ext_umem->length < ubuffer->buf_size) {
+			mlx5_ib_dbg(dev, "External umem too small for SQ\n");
+			return -EINVAL;
+		}
+		ib_umem_get_ref(sq_ext_umem);
+		sq->ubuffer.umem = sq_ext_umem;
+		sq->ubuffer.buf_size = sq_ext_umem->length;
+		sq->ubuffer.buf_addr = sq_ext_umem->address;
+	} else {
+		sq->ubuffer.umem = ib_umem_get(&dev->ib_dev, ubuffer->buf_addr,
+					       ubuffer->buf_size, 0);
+		if (IS_ERR(sq->ubuffer.umem))
+			return PTR_ERR(sq->ubuffer.umem);
+	}
 	page_size = mlx5_umem_find_best_quantized_pgoff(
 		ubuffer->umem, wq, log_wq_pg_sz, MLX5_ADAPTER_PAGE_SHIFT,
 		page_offset, 64, &page_offset_quantized);
@@ -1568,7 +1600,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				u32 *in, size_t inlen, struct ib_pd *pd,
 				struct ib_udata *udata,
 				struct mlx5_ib_create_qp_resp *resp,
-				struct ib_qp_init_attr *init_attr)
+				struct ib_qp_init_attr *init_attr,
+				struct ib_umem *sq_ext_umem)
 {
 	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
 	struct mlx5_ib_sq *sq = &raw_packet_qp->sq;
@@ -1588,7 +1621,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			return err;
 
 		err = create_raw_packet_qp_sq(dev, udata, sq, in, pd,
-					      to_mcq(init_attr->send_cq));
+					      to_mcq(init_attr->send_cq),
+					      sq_ext_umem);
 		if (err)
 			goto err_destroy_tis;
 
@@ -1708,6 +1742,8 @@ struct mlx5_create_qp_params {
 	struct ib_qp_init_attr *attr;
 	u32 uidx;
 	struct mlx5_ib_create_qp_resp resp;
+	struct ib_umem *sq_ext_umem;
+	struct ib_umem *rq_ext_umem;
 };
 
 static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
@@ -2122,7 +2158,7 @@ static int create_dci(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return ts_format;
 
 	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+			      &inlen, base, ucmd, NULL);
 	if (err)
 		return err;
 
@@ -2290,7 +2326,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd);
+			      &inlen, base, ucmd, params->rq_ext_umem);
 	if (err)
 		return err;
 
@@ -2394,7 +2430,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &params->resp, init_attr);
+					   &params->resp, init_attr,
+					   params->sq_ext_umem);
 	} else
 		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);
 
@@ -3251,8 +3288,9 @@ static int check_ucmd_data(struct mlx5_ib_dev *dev,
 	return ret ? 0 : -EINVAL;
 }
 
-int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
-		      struct ib_udata *udata)
+static int __mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
+			       struct ib_udata *udata,
+			       struct ib_umem *sq_umem, struct ib_umem *rq_umem)
 {
 	struct mlx5_create_qp_params params = {};
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
@@ -3277,6 +3315,8 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	params.uidx = MLX5_IB_DEFAULT_UIDX;
 	params.attr = attr;
 	params.is_rss_raw = !!attr->rwq_ind_tbl;
+	params.sq_ext_umem = sq_umem;
+	params.rq_ext_umem = rq_umem;
 
 	if (udata) {
 		err = process_udata_size(dev, &params);
@@ -3351,6 +3391,19 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	return err;
 }
 
+int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
+		      struct ib_udata *udata)
+{
+	return __mlx5_ib_create_qp(ibqp, attr, udata, NULL, NULL);
+}
+
+int mlx5_ib_create_qp_umem(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
+			   struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			   struct ib_udata *udata)
+{
+	return __mlx5_ib_create_qp(ibqp, attr, udata, sq_umem, rq_umem);
+}
+
 int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-- 
2.51.1


