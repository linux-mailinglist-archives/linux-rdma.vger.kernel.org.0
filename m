Return-Path: <linux-rdma+bounces-19238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJSkOOJf2mlB1AgAu9opvQ
	(envelope-from <linux-rdma+bounces-19238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687F3E071C
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527DE306F3BF
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920C387371;
	Sat, 11 Apr 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="o1/3IYuz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A1246774
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918975; cv=none; b=lf4uy7n2QiCvFbqmSDHYcb3dkJ6YBLVlicw6JP3DFAduiACKj4PGgx0jG/7FcVm/jph0kWrP2S1HUPQChM4ZHFoWK4E6gamv0ByBIPW6XdAmfDzm39oS+sVkMag4cOtJdPMMjijp4dL66C5oMStP+XHCwV4GyRj0UEEXpzQdd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918975; c=relaxed/simple;
	bh=+0DzQBQhT78hsFqoTDBACiSB5SDKF2PmhCH8Un2joNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKn6dplxaSU5MSIFYIgzFge+MQlsx++Bd/gDt4KoBW29u/LWXnpZ95ePXolTCWM4u3XST9ruvljSzr3QhZ9qFqecb5QNUXgbtj+zbDk/0PNjUpF6t8zffVHG9arq6z+JThCOyHdKCLFiUBCFjl9q14aPgVQk7SJyDDZRmW8S7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=o1/3IYuz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso2980435f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918973; x=1776523773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rphpThFnLB+mdCcuMLiR4eDkZgV20tWB9ATqVxiV6o=;
        b=o1/3IYuzKKKjStUzvNKNHrYk9bnLEGbA4cAhibxJyZdTCd70EnOsYQrZi5DaGJsNBY
         nWPseVutE/WqsqnvJxdYaMKs9C+4t1xMDUMZP3Rp3e1kvK8hGjVKBithoz+FofdVGERU
         kh+sZi8w7rmRhe99BczHAtCkqKIoUTsbtfufySBsuoWZksh2Ht07J3hJaJI6FHfp2178
         AmlCBg6xEUMDDDUYD6k90/ec9HWg4usal4ZsSYjmKU9Y0S0kXhwNDkgAdw6CJCHRWsWZ
         sQpReuqMLmtmfgvWmh3tOQ3yhv6D7f4amz+VjBZrCC/t13lSe0kewKF52eHWvqCzt9CH
         om9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918973; x=1776523773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rphpThFnLB+mdCcuMLiR4eDkZgV20tWB9ATqVxiV6o=;
        b=cC24cqrUwb4XRxKXTZlUtJnUi4Vrm4RYV2ffE1FtcCIauZ1JLhwQzMsdmTk+xvOEZ6
         uhRkNWwvcDX16zvvdAtP+xAQ10IRSDEpUBxXycJtIMs/7t5UudB1Bu6CDtWdMfCugD/a
         Tfrq3C2ZRV9hvQnnYh1SLyoZY0A7lKjn6s+ZnyY6VpFk2hL9VLVS7Z9tRt1fifnjNH//
         fsxyQpXoroyap6ftKoVJQupMdUhYGPTruY1ApDd08DPX8buH7XRu/0b3otWEgPWnetGC
         DRs/Tlw3f58ouY0xtXvYmAKxV0t/NzV01bzPbA/0rfsHDmeJLd2VW2ZuxBCoEgNzt7Bn
         oBgg==
X-Gm-Message-State: AOJu0YxebvOGNmWp48WHZL36CMKMtjKVOX6h6/KwBV33UveEuh7FiTAF
	z1RQ6kLrlPf0nsK1CxBmDwpZHVtNUHmBPMu95R8mCjIrZmjvLlayuzXJaDo6S/ul+DiYs20VcE8
	vDhM8
X-Gm-Gg: AeBDietiu0KvwI2XH9tthRFRhSyyvzXgj0MD3/9swKwWAUdAI/lewQtdTG2bKDnAQaR
	O4nCxXVfTnM9M0Dem5QrvRJRqgStnE/DYnB1Wa2oMx+U/gLXK58YR5MzYrzz+vOKfGoG1guZ4Eu
	vvR63GHzu6GbbKYkTWQJvqiOb2+J8KBFyFg6MFzY0tCXjxILDHXk6u+bgan5dndAI8LKY0PLhYI
	txakhtbTtrIg8PovBHb/m3Q7ummUa0+xOYek2AIr2XBbdmJNUIixPfDgL8yWcFDx4JQZL+GZ84j
	ZnLmvuwI9aHfuidSsIz6+Ge6++DhmM1KEYGjeL4AUuOPgiSdSRHrHbNvO4NEBH8u+8FCkUCjHsJ
	fPQmt6h5/rc0BEorXINdE+8j6KX4P6qw2/qKN39/g7S8/Bu4fKhlSBMn3IZSrxv+wq+sqxx2W6y
	Xa2U2f8iJ8FTF4RXcJkN8lTspCZvgZq+3F5GMhfBtINcQ=
X-Received: by 2002:a05:6000:1a89:b0:43b:9060:8829 with SMTP id ffacd0b85a97d-43d64289411mr10469089f8f.10.1775918972940;
        Sat, 11 Apr 2026 07:49:32 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm16533188f8f.29.2026.04.11.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:32 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 11/15] RDMA/mlx5: Use umem_list for QP buffers in create_qp
Date: Sat, 11 Apr 2026 16:49:11 +0200
Message-ID: <20260411144915.114571-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19238-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4687F3E071C
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
index 8f50e7342a76..ba5b41fa5ef9 100644
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
2.53.0


