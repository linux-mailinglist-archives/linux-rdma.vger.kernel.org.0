Return-Path: <linux-rdma+bounces-20155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOnBMmOL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BD4E88A5
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FB8304502E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4F3EF65F;
	Thu,  7 May 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="SF8a8Sci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCE3F1651
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158371; cv=none; b=kNrCSyCtf5ezvQe/sRAF6dO1BL2dkvoo09rYK432KXHtQJ0Vyi1+qhQZqL6Oeu10VpKTY3zlG38pbQDu2WUzwYc5y2FdJW7kwc4dLEKoSSu3SlvNIxCCI16N3UgNbNE/mjlhJSNGWY7zlu//JYsGbS7XXYv2N8TKzC4rUEfXRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158371; c=relaxed/simple;
	bh=gABPEPrINVsmNm2kPuoC4XU+FiIuPDV42sEnHT594Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CABkIHkrsPiRaqaTKnmPuin9/XKPkDhQm8qMuZPDSv6ObshbRNXEMGnKWvWOgtkhlCzRVQ+gv6V4kQmqObparak3vQmTgeAPfSLxVgimD2WYLySGOua3I2g6qNfwkbDU7i8x0AyiPPx7uv2fMRpheIp+AUOcZcDX+5qwotTDa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=SF8a8Sci; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so9830725e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158368; x=1778763168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck/LWvFuXnQuEuDnYHrJV0AD8h/kdwztdGUOToGCZ4I=;
        b=SF8a8SciRmK1QN0uNrQb5Dun//vxCB5kyrr0uzK8gTI95Yjnp8B9PX4E/LAkcReACd
         fx/RWhnjmlGgLHgBUyz5cZPlRw6/tbbjN4Gwv+sHMe19iNFkzcbgUPCNjoJSnYeoP+YJ
         QjZILZKQkdgTwemham+ctDqnChD/8QMDAhsiQNtECvzBhayRkCU/V5l7bUup/KE4zgLT
         WBdZraQVL762UVrRtdfVJfhOrGzqZvzgFEKlJvflXyUSkAYKbJkZzyUOBk98z/v1F7Gp
         Ym1cveAfWA285pNzPebvKcaT0DVwNqy2Z0wLI9FNm3+Tw0nmIRCI+RrHUYENCMfAbsuF
         W32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158368; x=1778763168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ck/LWvFuXnQuEuDnYHrJV0AD8h/kdwztdGUOToGCZ4I=;
        b=SOo7nDxw8JL4juU/W3Px4WmMgDQWOL7zCA4VceDKOuladcWM0FVtOyKcaw18ETomUi
         nYCU+vt4hmMe/r0sT3ey18Nf7NK4jjud+G595p4A/FOYzkKG53UpAKb3AuVsI37ka4au
         wru2kgXy8DiCudSpZp+E8Q3mvw+rWtFkSQjPaW1eT2uW/ZZNJVVxa59sBtdPrPc3BZOw
         R8lvzB7KT2kUa/c/a+uzn2hhLqNFL6c6BfvqRzZ8lVfl9A97ASTa3hpAm/1V3H5zWF8J
         1ouakl0aawQD4c7sg8dNLTsDUDcwXiHJbAmJWiLJukQFKxSbWdZZnZRA0BvocBNKj/k3
         glCg==
X-Gm-Message-State: AOJu0Yy2xt/42giAgvKmGuDgkcIkbUOniCb0krTCObx3hFT23j0521Uv
	J0rj0VbEFJtnpEXv6xUPL1NR8XhQ85hl5HKhDb/XTaCE4V4giobiIjLLILNGrJZdgvx+Sq+n44B
	9klxq
X-Gm-Gg: AeBDievygpdXsfA7REjzv/RZOZlUKEmt+OVB90bguXlFaEOlwmAfin7uLIBxVi3Gxof
	0isLlw/p+XCJx8tBWhcet1bZvwNYAe425eSCcsOpbenM09j87EzuplD0i7Ae+ZxzoS96jk0kJPJ
	a5IClmzSL/dS5kt5BSSvBE7LEhlShfGQkWUUV2uD5Jxdz3qqO4bOXaNgkGzCSVeTdaSa+Aq04Wf
	RkRvvexcuduTjBEtLkieBZent9RPEKD0wOhm3lIu+SWa2Qs3VdDNJB7q/45uvTzGPSSRlZ6bs9x
	4liljhGHFB0b3qPWL+Pm/uUAc+1A4cFZXLpeudK8wr0OTrJQ4IwW1YESvCUQX/MBgqzvRnNieGb
	Ena57p0XA/0fPLhtES3ali3i9gK9qzfezh8fuHtNofk3c9u6N5kZEgs5BQ/FUKeu3MmknbEWuGO
	DHooG48LiOpeI7futrkUxxf2bMZaA3UBINdRqTUXqMAx3aI5luZ7DYKJ86
X-Received: by 2002:a05:600c:a404:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48e51f3bc75mr114932045e9.18.1778158367837;
        Thu, 07 May 2026 05:52:47 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052953383sm19120949f8f.13.2026.05.07.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:47 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 14/16] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Thu,  7 May 2026 14:52:29 +0200
Message-ID: <20260507125231.2950751-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 735BD4E88A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20155-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helpers to pin QP buffer umems on
demand. The QP-type predicate selects between the BUF and RQ_BUF
attrs; raw-packet SQ uses its own dedicated SQ_BUF attr.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- changed to use ib_umem_get_attr_or_va() per-attr
- added ubuffer->umem / sq->ubuffer.umem to store umem
- renamed mlx5_qp_buf_slot() -> mlx5_qp_buf_attr()
- replaced ib_umem_release_non_listed() with ib_umem_release()
---
 drivers/infiniband/hw/mlx5/qp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1bc279d14749..1b764a573dd7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -938,6 +938,14 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
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
 			   struct ib_qp_init_attr *attr, u32 **in,
@@ -998,14 +1006,20 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd->buf_addr && ubuffer->buf_size) {
+	ubuffer->umem = NULL;
+	if (ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
-		ubuffer->umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					       ubuffer->buf_size, 0);
+		ubuffer->umem = ib_umem_get_attr_or_va(&dev->ib_dev, udata,
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
@@ -1015,8 +1029,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			goto err_umem;
 		}
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
-	} else {
-		ubuffer->umem = NULL;
 	}
 
 	*inlen = MLX5_ST_SZ_BYTES(create_qp_in) +
@@ -1352,8 +1364,10 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					  ubuffer->buf_size, 0);
+	sq->ubuffer.umem = ib_umem_get_attr_or_va(&dev->ib_dev, udata,
+						  UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+						  ubuffer->buf_addr,
+						  ubuffer->buf_size, 0);
 	if (IS_ERR(sq->ubuffer.umem))
 		return PTR_ERR(sq->ubuffer.umem);
 	page_size = mlx5_umem_find_best_quantized_pgoff(
-- 
2.53.0


