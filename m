Return-Path: <linux-rdma+bounces-20824-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDcSJo1gCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20824-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4C55F7E5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD14C30087D5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB62D46C0;
	Sun, 17 May 2026 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="TRuZV0ms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876692BE7CD
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999429; cv=none; b=tOGnluQN/MBlMOeSe2W6EEyef33IOyZ68Ld42v5iZPA4BupwdCnvEihmie84MAJ2jE5lBfUczZqQ3mSDBatbyPybPcUyJNQkRCLRp9SL3gWCdQJZMeNnmrwM++7jrSlidI6eXSxXUanisU2G5u1Luafg9xEgjdYUDzuivby6qWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999429; c=relaxed/simple;
	bh=KqmyMLprhd8g8JeC2zw0hOQbd1WGmMguLsDfJlzXNew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw5RvqPyr7WGYsD7CGT66nkxZ5WT4c0Q5AyL9D3J9GO8LRQ4Lumtnq/rH3knwwjfLfM1ctt8vXSYiVPu8p9lBLLkdhNJMKAoXPvjKEFDLay/YDBBihPkBxaGkBgdNZyibKBIADnDsZ5a7KbuNledEsPhmUcVgjKNL6Ab7xBPhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=TRuZV0ms; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so13447975e9.2
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999427; x=1779604227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuFExZX2cBVNnDkrEiAFcspDW+Jwg/9AZMx7dc06eyg=;
        b=TRuZV0msiFUtVG1/5ShiCUWNpWDIGF8VuVuH+CW1NSlRjLrzeWgFkgxSmPmWMmGoJW
         g9Vwc9fND3yet8dXotXfd1fwssmwgK4d8zg5XaqBIWZ5Vis0UxD0dANNbtVFv6ZgiWW6
         JzwsStt3VN/GGGY3pJ1fZcKOfLWYsYzm0yrQtvNbrrwMlQICn9v6eRMziiY1elrN7P+u
         7dXLLW8d8oY/9Pse3cYgSKv9T/x8sdGHbVDeh+snJpwXtf49Ydgo5LeujL7LC4TiOJqf
         /h8so9vf3vndBWMYRxeRcVoA3s4xI7GaDNIr9AtwhIVrFRsEcRmaa4SjdNCu6atiD4kx
         +pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999427; x=1779604227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuFExZX2cBVNnDkrEiAFcspDW+Jwg/9AZMx7dc06eyg=;
        b=NKualw52S+rQidxeVl5kbZneT1ZwwCHcv0rv8h6P7vUu2+zLTitMJgmTP2X6d2jqPT
         /7p1KyVTRZseT+z+x9H5Z0KgbLayKAmlziHaO3IdNSui9sRzr+7DhFImTfyZqKSqe9bH
         UaEvI4tKIxP42XmAzzVxpy99FJE8fWwmPBlnDP4psLTZZlNd0ypYZ7xz70vpQfuL5j16
         IgA4kG6gkOsIbiQDUGMtNhyIv3saw0mImuXEdW0ihms4bjP+k49SLh/CQ9IaS+qnb9Qo
         kR4fiZvOn+RukKTFDBtsYKyo0TiQrZyflNLRQUw4bN357311wc3Z05QNgQ2eYMHv/flb
         l18Q==
X-Gm-Message-State: AOJu0YziySxJNwaVV9Xc/8a0MHRApsRbbYXgiCa1sAG4fuaxggmVsrEM
	8pT8YQV1WADOrhFZCOOFB7AI7Z8A7DKn3CGAZynC3lFGYYTsupF88iMj08Yy2qynhRe5NfZlU3j
	C/luK4BInUsqa
X-Gm-Gg: Acq92OESwBJ87zRBepmU2c+09nZ6STeB3/rMkR+yF2x2Ctxh4WTeG0BNMrBliE7u0FF
	mqz5ObX0OGeqTOYfnoyhSsXl1ltk63ICD51Z0j8ii1YgXLuQ9uEZrtRKqYArWYEZsbYJphb9RkP
	L4vfWrgqgDg2Ig8Wk0PG4fE2oTaQDvprrsKCHjaTq0fRKOjaTXeqC0NLLlkW72mQMZcr7YeRfCC
	UVGHw7qlQCpwtG4Ys9Z/aH9Bs0XFbGEnw5HdDNP7YUoZLgufFKV/o8YU+O685++s/usldL+KIcN
	x/yaA4RUHNXe6crLoeJFLa48Py209MLteBmYr6GheXqMo5nd8l7qcf6duIwDMls6jxc5KaMVQ2D
	Zr9xg3lFuKZs1TswgVDUJoahoI5F/K1Jj2CtB+n/ZGjlno/OMGm1y1WJDB+Wjtn/ENYP03gH5Qy
	No7puYDeu1K2H1u/RSF90qnVqSP/hvnCmS6VJ2SOSno5i30Q==
X-Received: by 2002:a05:600c:8b47:b0:48f:dfe3:dae3 with SMTP id 5b1f17b1804b1-48fe63223edmr156394775e9.17.1778999426975;
        Sat, 16 May 2026 23:30:26 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm175287505e9.0.2026.05.16.23.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:26 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 13/15] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Sun, 17 May 2026 08:30:04 +0200
Message-ID: <20260517063006.2200680-14-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 7AD4C55F7E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20824-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
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
index a982cea45f3b..bd4e5971720c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -934,6 +934,14 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
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
@@ -994,14 +1002,20 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
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
@@ -1011,8 +1025,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			goto err_umem;
 		}
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
-	} else {
-		ubuffer->umem = NULL;
 	}
 
 	*inlen = MLX5_ST_SZ_BYTES(create_qp_in) +
@@ -1348,8 +1360,10 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
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
2.54.0


