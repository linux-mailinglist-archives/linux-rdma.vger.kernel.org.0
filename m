Return-Path: <linux-rdma+bounces-22646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HtQnHYwNRWra5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:52:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B90136ED9B0
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:52:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=aLpk84UA;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22646-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22646-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0E632BD9CF
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB948124D;
	Wed,  1 Jul 2026 12:40:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B647F2F4
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 12:40:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909629; cv=none; b=WSL9LW1tRVi6+3iW+oPCyCY4pd40AO4V8jhCSDoAn34kugamHQhkrhqyqM8W+ZzCMlIAJitGtucWsKbZzWpTRADnbAmzRIHbal/RRzdVKDL0pF5FUknbuarEGARXflHbjc0OCxvMttcjgpvf47Kd6Njg7E+ZsHDLP39Z49aTMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909629; c=relaxed/simple;
	bh=1dtjekxpal9QSMlkmnf2TJ7lm8VDz2yYsV9PGORCcMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C218jzhj0y7PiSSoOID1Aden+wCZGMRPscofGTPEyRdjoXiGh10yeWUVVDVp2DKMUyczaN9Qo4Flw5E79YAAnCeZoq+XHH0lFoFxr/HjGAtKgwPZGDGlk8cS/C7LzpgO7SEAFwRF4vIg/fRoNSXjOTh50rj7e1j4K/P3fhmEavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=aLpk84UA; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b27c7451so17825725e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782909626; x=1783514426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=aLpk84UAg/OTNiNj7zoxiwT4lDD+mZ7WpspCQgG4ugwlQoEbM9lDgJOHzacKLY5pEc
         viG1jJvjv4LVDEMTs1aM/e55Ps7AXWD1p9yaqLLLLUTEDMmdrp0HAkDY3sJr/b8LbDCT
         6rsoSXHbDaZhcvAqJWk6AaQVNvew0QX23KPakJU0O0oIJqF0IEpRc6qT12YJqgLWPU4x
         mPODuF8LLZa9BQWD7dx/GGIPGN/886+/WpdB0lAbnL2sSn3R/oRPi4zmyPoQPJXlHRMb
         Wp1jvOpILavWBbnBr/e2fqwMGWeQidrIfQSO70VG2W62ioL7x8Pi3mS/qCZdZIOTZIn9
         h3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909626; x=1783514426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=q5WeNI768ty2ynFuOk+7Fdjlu9tcRxu8TaqhMRwO/JyL1O0rSzq182GY8KIGRki0rI
         sdllIpwEWjRiiWiFIcjlJ2hbHL2rjzHu1yiSjX15cIxg3OawS0guIUt7KYXlUi5dg/KB
         ZtChi13ZrpcOUVQAlKzCAiMEsZ0+MsSCWlXaYoBpq3FqXh9fAfd9eEL5CCvxIYIae/FO
         rZwOsjGL/6EE+ypYWEZD40Hk0RA5RcgJuD2SxHnTy3F8j94no4jEiKkYnUXiOmdI2Jjv
         0/mlnU1cNjedVgAaWLTXVdr+NldjekLTH9cZqfNvfLWgdZ7nvvr4AY2sY/S16PwHIsj+
         CKuA==
X-Gm-Message-State: AOJu0YzzITouVD/s0Dcyat14DMhc/1Mo3oWXZU8dNYNeemYThsfMTGEn
	Phz8X8KuuOvDUUSQMOWxJvUD9aezYcJ/ZQTjqsmA9AsMniXYXEntxAfPLhcdj/Gvf8bsfYnYdMZ
	7PJOk
X-Gm-Gg: AfdE7ckkt48hi6ZmgJrBZYePBR+V/58XFZ1gsBAH4gN2/Q940SCeW9NTX6NbaI+kUDK
	wDQWp4Ll+7NXnGpKmvNty5UM96O5V1eWxDPP8UQPyc8EccQdExPY2VQoUAeLccrFadLRwPzoqrz
	/40GOx7nBCxy1pLMptd7TUmY7LyQM3243xSIibxosLqJ/vySPybvBcDCJUqxS4b5moJxrpslEDV
	1C17IJ9/A9D1zxBjGFx4SHR3OLVSuW2wFL0CMZKXtEddJ0lrtSpN63DvyP/1qLbNts8dzqXq4e7
	xV9tmaI/ZGLn+t8cLF/afhBefEW+uBOErKyWommFoYzCh6tI5VVi7i+0fxV1+xSgvRRMZmgnH77
	aw0iNzR80v9w+vcPNl/q/CAPg+4yetf51STfG0yTOwxqSXCmQUJWODjSOZZjMfaExtaXygRszlj
	fpIdeMbZUtdvIHwTlAwgvybw==
X-Received: by 2002:a05:600c:8106:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-493c2313932mr20622055e9.4.1782909626495;
        Wed, 01 Jul 2026 05:40:26 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c3874f62sm14930975e9.2.2026.07.01.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:40:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v3 2/3] RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
Date: Wed,  1 Jul 2026 14:40:14 +0200
Message-ID: <20260701124015.64350-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701124015.64350-1-jiri@resnulli.us>
References: <20260701124015.64350-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22646-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B90136ED9B0

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helper to pin the SRQ buffer umem on demand.
ib_umem_get_attr_or_va() resolves the new CREATE_SRQ_BUF_UMEM attribute
when present and otherwise falls back to the existing UHW ucmd->buf_addr
VA, preserving the legacy behavior.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 5bc48fef3744..6fa4c5a9a0d5 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -48,6 +48,8 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	struct mlx5_ib_create_srq ucmd;
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
+	struct uverbs_attr_bundle *attrs =
+		rdma_udata_to_uverbs_attr_bundle(udata);
 	int err;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
@@ -66,7 +68,9 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 
 	srq->wq_sig = !!(ucmd.flags & MLX5_SRQ_FLAG_SIGNATURE);
 
-	srq->umem = ib_umem_get_va(pd->device, ucmd.buf_addr, buf_size, 0);
+	srq->umem = ib_umem_get_attr_or_va(pd->device, attrs,
+					   UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
+					   ucmd.buf_addr, buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		mlx5_ib_dbg(dev, "failed umem get, size %d\n", buf_size);
 		err = PTR_ERR(srq->umem);
-- 
2.54.0


