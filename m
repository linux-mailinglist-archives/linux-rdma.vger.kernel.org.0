Return-Path: <linux-rdma+bounces-19234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s4iKNdNf2mlB1AgAu9opvQ
	(envelope-from <linux-rdma+bounces-19234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4E3E06FF
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5F5306465B
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495B2DA749;
	Sat, 11 Apr 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="hBmD0O3R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7E2D3A86
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918970; cv=none; b=Ko7Q/cGcYkwh6bimTfyUYltVYcYRJySaN0Bb5QWjp68maA85YB9pPNPZwXFI50W7hbdj1U+gjipTRgiBVmde50vMPSGXaMBlWeHSadMj86VV1843sDgHI1XjvMO4wbrVIl8AVXyTS0hHWR3tvX85FTiguiw3MNrZsSbDXVs7Elg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918970; c=relaxed/simple;
	bh=1mS892vnxPODr7xBUTFSnmJsno09djyEi06t3xiQrvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCaTFuFImG8i50PbU8CTUt+HQQu+BvDc095AWjmQ6n8/x/tRGfKn6cJanUq+3/ybPtjz+an4w0yUplfBD7bjeayQlMjnpU/7a0WW2b8h52ZqFFnOZ3oZ0M1hxSI91TmStC8r5YgaFXuY1Z5i48l/QnQYFkM2tG5llDpPv4y4d00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=hBmD0O3R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso23063135e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918967; x=1776523767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0l/+4jphO5XarQHL6yd50GP+H/TkcxNzvVt4uFPRdg=;
        b=hBmD0O3R+qHuqVgf1/bMGhSxux+WU1MqZbxvD/SiFiQe0tF2cmlQBsRFNxeMfZaZLO
         ifstXZtpuzr4KF0R9vZMJYFh4JiQYNS6AEvQRgN3QwKF3ZgmHXPQAhE2L7Vbc7e5tz6X
         ZxU2OvnFQU2IFYlahJ2cP3MvIGXzJhgooPx3ap9wswQKCP62mt+t5zkoqKcT+YNuVPlE
         uOR7+X5P7fvar8x0XqbASmrb/EQV++0jluZ7vWgJdk3/AckptGcmJp4VQs6i8A7TwHj5
         gRdc2AzyMZhtt6dhDnDozM3hGohDC8RIE+64WYJL2a1akj/1Hs3k1JFBK/ys+v9FrOzf
         splQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918967; x=1776523767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0l/+4jphO5XarQHL6yd50GP+H/TkcxNzvVt4uFPRdg=;
        b=iec7Xx6Pec/Og7dknNZPgkQd6NeoGpYAg3BV44w8o5KbaEDYaUcQ3zC8zN6J/mNo1B
         P/uqtrCsaVyWGiHCx3pmPQZp/xKtSEiYIbd9v3vw0nXVlTueDVuvlqq7t8XKU3o7QVNA
         l5zJG5HEPAhvzHG0Ql40XeOm+BIETMmy/gmaUe716H5sbGNEGT6bs1ffKL2F/ZycPI7u
         gSa91p3/wy5f44DPOjnA4oaggbJYr3u1kluYKUvNI4eniAXocWkIXn3o0TOXH0r3H7WI
         nxoQ5I+Z16u1b7hlM190N4ve4fkreIyAF2C7E237Ty2UYoXsmHbDRXBOGzBidLEZcvl2
         dhAw==
X-Gm-Message-State: AOJu0YzWkH06lGr8BuDHF//Yu2XHm9UePlmGjNGHa2NUqkRoigMZP839
	lLzu9v3nf/KwOSiBi7qk7sRipVULREdwOoKp4+GkjN018CyPcvVInvbFizHM1AJgImuPy2Va55r
	mLSUy
X-Gm-Gg: AeBDievDHvwth3ZKBdS12AglXGKFbpxMbaeX2jl5MBLqCMc5KaOuFWSVotelKwGeBVY
	YIUCq2YgZMsmU1I9XyFa/YqeVUDBGe0nSwMH82pQooT9HVIa8FzBH3hfS+ydkTE0oiM6mHJTOKf
	dqTjAUf5W1pdG6JWPeb99FkxzTfDfBokDgdUOjYrq8vB+TVwGz2Q2tkJyebuJX8njIIz27c3/Q0
	154nlJMc2Kt8sk2U7hnYWR/qTCw6Xb84j0xALSykXIdD4mcZw/vP+k+lahp60dmT/fCTo2vHw35
	mLzKjvR7mXJtPdke0mnq8Gtg0LSWLnSN/hFxGmZJI/Xe/+fWxbcBQu+DwG2PcxuRZjkcR92ok+I
	zJjWfN/kvmyeERvqnKlYNuoeS3jd9GUWJsRQJE+ggEgw9TO+Rr7JbBL1/2RFO4nKdNwH63uAbgc
	nxiOMQ5EI3+JcOhGDzzF+CF2hhkGGUHYLW27ztajq9gr0=
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-488d68af201mr102409045e9.31.1775918967142;
        Sat, 11 Apr 2026 07:49:27 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5734a94sm146738655e9.0.2026.04.11.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:26 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 07/15] RDMA/mlx4: Use umem_list for user CQ buffer
Date: Sat, 11 Apr 2026 16:49:07 +0200
Message-ID: <20260411144915.114571-8-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-19234-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: ECD4E3E06FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use ib_umem_list_load() and ib_umem_list_replace() to work
with umem instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebase on top of Leon's fix
---
 drivers/infiniband/hw/mlx4/cq.c | 40 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 7a6eb602d4a6..f6ef85cc37a1 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -152,6 +152,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	int shift;
 	int n;
 	int err;
+	struct ib_umem *umem;
 	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx4_ib_ucontext, ibucontext);
 
@@ -172,22 +173,30 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_cq;
 
-	if (ibcq->umem &&
-	    (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT))
-		return -EOPNOTSUPP;
-
-	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
-
-	if (!ibcq->umem)
-		ibcq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-					 entries * cqe_size,
-					 IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(ibcq->umem)) {
-		err = PTR_ERR(ibcq->umem);
+	umem = ib_umem_list_load(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+				 entries * cqe_size);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
 		goto err_cq;
 	}
+	if (umem) {
+		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT)
+			return -EOPNOTSUPP;
+	} else {
+		umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
+				   entries * cqe_size,
+				   IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(umem)) {
+			err = PTR_ERR(umem);
+			goto err_cq;
+		}
+		ib_umem_list_replace(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+				     umem);
+	}
+
+	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
 
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->ibcq.umem, 0, &n);
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(umem, 0, &n);
 	if (shift < 0) {
 		err = shift;
 		goto err_cq;
@@ -197,7 +206,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_cq;
 
-	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->ibcq.umem);
+	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, umem);
 	if (err)
 		goto err_mtt;
 
@@ -471,7 +480,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (ibcq->uobject) {
 		cq->buf      = cq->resize_buf->buf;
 		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->ibcq.umem);
+		ib_umem_list_replace(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+				     cq->resize_umem);
 		cq->ibcq.umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
-- 
2.53.0


