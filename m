Return-Path: <linux-rdma+bounces-19918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMXgAlam+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916974BE463
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D09303EC08
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331713DD53E;
	Mon,  4 May 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="VrUI5EgD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686423DDDDE
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903067; cv=none; b=MUY9HpeNfHfICVvlWlrUjtH39OxjHWFt1XqF6vYnGPpTIM1utzROX/4W1Xbm7uvKQA6A3L6eQ5EtT8zC+gJPootNcKUVtyQAj7kU9pp0/arj7Z73/ymUussFsPkMfiA4ZHPFZp4qCsd0uHUJewe+mR6MASqqIevpl8X8CqzCkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903067; c=relaxed/simple;
	bh=tmsjg+Etxqr6V+hp72JixkUm/hqrMRMVi5v4y6uAUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQBiOmqFaimPQeB8d6uJYyrHCwicJA1bHUIJB61icaFJWogALRbfR9+5rJTdtbaFYisWb/cBtPsBuYwDktuHaUp/GpSMW0oyCA5wmp2Bb8fBvzsSnybCWTlQFg/ZQAKIYP+HAFXlA7Bkg9wEVC49GhG+THLNoI0bp3FEF38cIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=VrUI5EgD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d734223e4so2391321f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903064; x=1778507864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWaOc6Z+4IHpfL7UbxWDnnqnz4RqsOC5J6tY4txS2dk=;
        b=VrUI5EgDNBTFkjSB42noTiHBIJzZEGNcbnkF8LU2e2uQ83+hbbYu3oMqtNlGnjNV8P
         GLBE9D469lPjUnZBLWaBAI1mwbFwCMquSiLFQUqHW0dH9Xfn55GVGz1exQ12HVmKGYkO
         ze9xTJZV6+VqWPquKHmjKTE0Z3sb3bErAVdhRr4KuvUIM66f0rCdeEjbVuQ0IaQoDRkr
         3+HtU+SPD+eahM7a/viyvXi04L/herqwQovqkNrSMidBeiMGLwt+tOLbsqJyI4ZQMR98
         S1AsUpY/oBEZhL2RgTfp3oDz2aTXsmsXYlR+7KT8WKguWc8FVymMKhscIC5n2GpiC4eF
         wHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903064; x=1778507864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWaOc6Z+4IHpfL7UbxWDnnqnz4RqsOC5J6tY4txS2dk=;
        b=oz7DbJg1RxjTmNTsD6w+naP/Nq7ZHVVDqLo/nnPyLyzNh4rsIWJAWeB4lVtFxKZaa4
         uMLMH4Uqq19y/aCvK3gyRgvTX+jsptZDLCVYjxsoRlLjfckM52QlbNTNTp6xr549gIUP
         eg1p5hgDZJGEVjTBYNEa1iD2ID6OmYBwMpTvAIVysdXKuztdMM6S9WYe53Pjp2PIeW64
         ivPbD3sc/VAQnT/GYvqQ1LDnDgRqHX1HUEfUHV2iiOmDR3g2402RwXmi/HR5SOkmfPb6
         7JM6dx/NBeJouhw4oi3TPbfTny2jER9RSj6af6pf/ZLnYHT7MuHoa4B23NSJFupDHdYC
         vvmw==
X-Gm-Message-State: AOJu0YyhC6HO6y9j2JcWqwYTMhyjDKfhBW+0HI7gvbzj+c0nRsyuH6N9
	2Wz9n8tOY4OVGQboMP7cFlJveXbF6/2DiNi2TYjftSvz4n/yLXFTmataxKcGoeZYtGOUgMvlbPk
	6f7CUTnA=
X-Gm-Gg: AeBDieuu9TeOT5vB/0lWI4Rw85rb2k/EFNpcvSgOGS9+b7qz+FsM5UAZYHlvR9la4CP
	PbgeWaKPpbb2omZ5xtpsttfjmf8OHrM20/eSTOQotO+di7R1CzWW4C1lv+WH3C4porecreSejWd
	dcJqy/WQ8OJ5+S4okS2JP3zC7oqraITLkcapMqVvyXk9W7Gtm2p0n9OEim9L1a1+w4pGirTArkD
	rMx+4CTEbWvB/88Mv3A7TMeeIzMRksimNHJsaNJ1QTPWAqpgDhcQ40ddF3gPIAvFHNzC5sUWFUJ
	5BXOCjZuzQsLvkuBInmdKCsj4swicOIFPMxj1bPGz26q2bh1cX+0hDKqlUhP5FQ7rWvUQEAJ8yX
	zPq5AUUw8pwd3o+i4oG2cz2uqCkc4t0HsH/NgYO0e1kYqSVCKmPI64U/8KDqqgi7mT2DhAgeeZw
	wegamPaMe2kaqx+K9lNvCtdwNg
X-Received: by 2002:a05:6000:44df:b0:43f:e56a:636e with SMTP id ffacd0b85a97d-4494fe78a09mr18498965f8f.18.1777903063701;
        Mon, 04 May 2026 06:57:43 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f237368sm24949912f8f.14.2026.05.04.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:42 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 05/17] RDMA/uverbs: Inline _uverbs_get_const_{signed,unsigned}()
Date: Mon,  4 May 2026 15:57:19 +0200
Message-ID: <20260504135731.2345383-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 916974BE463
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19918-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

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


