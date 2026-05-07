Return-Path: <linux-rdma+bounces-20146-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCLPGEGL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20146-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B24E884C
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4D73032CDE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9183AB275;
	Thu,  7 May 2026 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="nnpdIlPf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C53F1651
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158361; cv=none; b=o8oexkUr0LPrCeson6BGaDKQTQbyyx0D3vy8tGpZAxt81bc2lhUZovUN+gl5p0anlyXE3oymSheovKVXmFx5wiRRyHWCIgZyxlKMl6nRR7sTD2PBOCH7To69e3pjPQ+xm1DZ5mRJeJhRi9Bekvdi/vCUQ4I0D2nxvsezcNP3cRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158361; c=relaxed/simple;
	bh=tmsjg+Etxqr6V+hp72JixkUm/hqrMRMVi5v4y6uAUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9uhvnth4MA+cHbHBRnnyhy4UrN3TSO+QQThAEWSHf/C+8kaSoFkmdidv3OP83vy1Vqr5ZTXY4ylm/PPZJAhxXp1wvDjd7c+e3yuT+bbXJvZKhPC/GTb9S8SHoDGA7Cls4kITXP5GKA+txmgGtoqTbS/AF5Kclu/OTl2dX6hTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=nnpdIlPf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso6330485e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158358; x=1778763158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWaOc6Z+4IHpfL7UbxWDnnqnz4RqsOC5J6tY4txS2dk=;
        b=nnpdIlPfZD7fYTbxOVwXa13AzrRPjSWxPAwn3NvZf6mZv5bUwOFi2CFFTHBUexlX7V
         0P1QKXAw2wFR4ZNQv2TdeM02YUCuKaVskKoQjff51iN4Gj3YCWk28Sue3vzJaI8cPtQ4
         VWqdZSetH4Rbty4NeRNl2B4w/93TA3DKwUgdIkND1YGNpJAqKeiiXjIkw5bl/E9DT6JL
         izn8g6UtkuKgyfU3uqkMh22H7QG/9XU49thvPK8N1Dwvl3Yu27pfQUWEO33nLpRixQfA
         OKIxIQtGBzQjCU36x+HDYeMjM0dwWzQJUAe8UgoXOoZuYyiQ7A+gU/AHqhRMysmKGN5N
         VZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158358; x=1778763158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWaOc6Z+4IHpfL7UbxWDnnqnz4RqsOC5J6tY4txS2dk=;
        b=S0i/QVOWVoMQEK7fB3SsMopE5fv1A8ATvyWz9z+9CEMNQgDGm2/ejNg6Suzw9lK3GI
         Mt7zwToXSO+Wrc4/jZ1xbD0bktB5/MlnA7f8bDrepPuoxvfYhSKQiAj6ZZf5bt1rUkOU
         PDACyHieSw58DfPVQQg4+l1UFMY3hdXfxr/OMNsSuz+wleUPVBXpQERUrhybN5ZcexvD
         x8mKNjQuKX92CQPLOEPsCTVtg8bqd8fsmaqQbK5L08G3VUM7psuyddbwu9r1cBIZMoer
         gBq6Qyaxy8SuAUgaD0IKOy+v88IgraJuQyhi2rdxBLXtAWcSGBCqvtQUOqZzrJRSvWYF
         CAvg==
X-Gm-Message-State: AOJu0YwDHRxW3LwG60H/MjD7lcEM8q0WIlMduRxKdU8uM3rs+Q/9TSgU
	O3uMdl5WADxGHL/YpH08OcAg8HU3FjONpv7tnwPg/xGc1yi6OOu+YcwRl+uZxuAHp1kJY8DIvRL
	Pcdzn
X-Gm-Gg: AeBDiesN9qJ2/lJVrIGge1s63RdkJQKHX9fXclMbPK3DKA6pYMTUaEwHiRGwIyLKRH8
	R5Ecuiw2VVy2f7m8kvQtPdami9pPRkDspHkUbCwPPPele5ajW7rTh0KQM6KvTUcRRBNfBXaIU8F
	wlDVfga0EZL8hJPTwOek/cp9y6q6iJswZmrm3w4j0ti1w0UbFDsF2wSN8YSyXMwrm2GCtmoE4UT
	MKWcci+8gfrg4NNMYuRrGNSZalheTTvAQvuzB2sGV3E8lCFd9dLL+tyjq/KAbYfA5rK/8uPwQ8C
	6AhvG3SshZFgpo5mmrvkayDkiWizAzlKgMR+Xo3LaFaCXSUNaMAiaMy3g6+T/ttN8+T9kHBhqAK
	uEDFCW0qU5s+yF6fjeoxJKsOS5z3fPJyicbEJrRAb9LNr/+ckEVPAwA6Z72fpQv+NdR2X3D7slO
	5D60YDMfAqZSSWULng1Sxf9vetErEROFnnsXQbZ/W/do5bwedsbjTweSj6JDLBQkVM3DpmtcZe2
	opXRQ==
X-Received: by 2002:a05:600c:608f:b0:48d:35e:84a0 with SMTP id 5b1f17b1804b1-48e51f4a29emr133736355e9.28.1778158357947;
        Thu, 07 May 2026 05:52:37 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895f0asm135580655e9.2.2026.05.07.05.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:37 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 05/16] RDMA/uverbs: Inline _uverbs_get_const_{signed,unsigned}()
Date: Thu,  7 May 2026 14:52:20 +0200
Message-ID: <20260507125231.2950751-6-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: B81B24E884C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20146-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

uverbs_get_raw_fd() and the related const helpers expand to
out-of-line _uverbs_get_const_{signed,unsigned}() exported
from ib_uverbs. Callers outside of drivers (for example the
about to be introduced CQ buffer-desc filler in ib_core's umem.c)
therefore cannot use them without unnecessary extra dependency.

Both functions are short and only call already-inline
accessors. Move them into the header and drop the two
now-redundant exports, making uverbs_get_raw_fd() and the
related const helpers header-only and usable from anywhere
that includes <rdma/uverbs_ioctl.h>.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/uverbs_ioctl.c | 47 ------------------------
 include/rdma/uverbs_ioctl.h            | 51 ++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index b61af625e679..a2182d3401da 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -785,53 +785,6 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx)
 	return uverbs_set_output(bundle, attr);
 }
 
-int _uverbs_get_const_signed(s64 *to,
-			     const struct uverbs_attr_bundle *attrs_bundle,
-			     size_t idx, s64 lower_bound, u64 upper_bound,
-			     s64  *def_val)
-{
-	const struct uverbs_attr *attr;
-
-	attr = uverbs_attr_get(attrs_bundle, idx);
-	if (IS_ERR(attr)) {
-		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
-			return PTR_ERR(attr);
-
-		*to = *def_val;
-	} else {
-		*to = attr->ptr_attr.data;
-	}
-
-	if (*to < lower_bound || (*to > 0 && (u64)*to > upper_bound))
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(_uverbs_get_const_signed);
-
-int _uverbs_get_const_unsigned(u64 *to,
-			       const struct uverbs_attr_bundle *attrs_bundle,
-			       size_t idx, u64 upper_bound, u64 *def_val)
-{
-	const struct uverbs_attr *attr;
-
-	attr = uverbs_attr_get(attrs_bundle, idx);
-	if (IS_ERR(attr)) {
-		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
-			return PTR_ERR(attr);
-
-		*to = *def_val;
-	} else {
-		*to = attr->ptr_attr.data;
-	}
-
-	if (*to > upper_bound)
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(_uverbs_get_const_unsigned);
-
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size)
 {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 76e94ede668e..70caa7299dbf 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -900,13 +900,50 @@ static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
 	return uverbs_zalloc(bundle, bytes);
 }
 
-int _uverbs_get_const_signed(s64 *to,
-			     const struct uverbs_attr_bundle *attrs_bundle,
-			     size_t idx, s64 lower_bound, u64 upper_bound,
-			     s64 *def_val);
-int _uverbs_get_const_unsigned(u64 *to,
-			       const struct uverbs_attr_bundle *attrs_bundle,
-			       size_t idx, u64 upper_bound, u64 *def_val);
+static inline int
+_uverbs_get_const_signed(s64 *to,
+			 const struct uverbs_attr_bundle *attrs_bundle,
+			 size_t idx, s64 lower_bound, u64 upper_bound,
+			 s64 *def_val)
+{
+	const struct uverbs_attr *attr;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	if (IS_ERR(attr)) {
+		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
+			return PTR_ERR(attr);
+		*to = *def_val;
+	} else {
+		*to = attr->ptr_attr.data;
+	}
+
+	if (*to < lower_bound || (*to > 0 && (u64)*to > upper_bound))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int
+_uverbs_get_const_unsigned(u64 *to,
+			   const struct uverbs_attr_bundle *attrs_bundle,
+			   size_t idx, u64 upper_bound, u64 *def_val)
+{
+	const struct uverbs_attr *attr;
+
+	attr = uverbs_attr_get(attrs_bundle, idx);
+	if (IS_ERR(attr)) {
+		if ((PTR_ERR(attr) != -ENOENT) || !def_val)
+			return PTR_ERR(attr);
+		*to = *def_val;
+	} else {
+		*to = attr->ptr_attr.data;
+	}
+
+	if (*to > upper_bound)
+		return -EINVAL;
+
+	return 0;
+}
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size);
 
-- 
2.53.0


