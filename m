Return-Path: <linux-rdma+bounces-20145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDqLGvaL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:56:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE654E8955
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C728306CFE4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B943EF64C;
	Thu,  7 May 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="N5qr3J/G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988053EFD12
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158360; cv=none; b=L80ZVVsgFjqEc/BIG7MnLoatgDhsEL2o6IMcx5SOB93gwT5VyAEAVEJ85NEEN0VA/0I6Oerk/2Fpujwckchpv8GZa6VOR65VkAz2dTvyWiKNg2BFT6lN8171PbxMNtwycVjxVtVIPGlzYQLyOsIcSGVAKzWTrEWSEFC72WtXAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158360; c=relaxed/simple;
	bh=5euqZL37DQU43tLVIFPeF5Z7BxUb8byxOrMkynkhog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehN3HgeCqwMD8i5Fd/eIrGG3gLtTOFa/VmpQfEZfU5ETarzpB50Jta3DIU7GRWDxFDgwu5bwLz+mEFgpROVPV5TQTemOCf8asbSdF1CNFP1wLkA5jGvkSbkMekKjzVoaE0iuvTJhSAwwxMa0vppQIih7rEAvBV5vrfnJ/6/pBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=N5qr3J/G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso7064735e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158357; x=1778763157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju0iNE641AatU8KdMuPMd2vKpJmJL5bRIZpXEOlb+cU=;
        b=N5qr3J/GHEqPXK03FFVGw0JgAScZXo86JTFs6fUwPr1Ix/xfxL84Bu7Wx51zv24dNS
         0QOFrIVmmSwzN3+rRMdbLoXYQz3ercrJxyJ9a989r6L1D5NFlNUEOM453wuZZPd2ThXD
         Xk+P3nbYXbsrqc03xu4/hhNVRG9h95S8p+ahOb4nZNYlkInzzbDp/BTmwM/ffKn/cXzn
         upGWDybYDJdIwb5LEZol2JYZP1klJ7Mw0z4LvNBS+3zF4MaIhGIRRcVDCOkmo6FjHNW4
         wIEdoqbwiQJ9TKSduB7xjXW4H6bIxvbkK6r/0ZdhM9oK3Kj1o23y/qlpgWJrHiJKPuHP
         ZTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158357; x=1778763157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ju0iNE641AatU8KdMuPMd2vKpJmJL5bRIZpXEOlb+cU=;
        b=jZTonRNbM4GuR7KCOsvOsXMeWpQL8+ZpXMavqgjnkqARDqN7CvPO90rFFtbO4O5Dur
         8TVvMtHwBlLl8wJzPJR6hwZ8ctGYCbPKiizTIAqkXS1j3fFXnsM7D+d/HHXQnwZZNZ56
         +PuTzd+FNTW2aHg3mnRw3L/+iFue9UvknELl3ymY/YmNU1Hgk/spwLcZKByzrB6HLGsA
         4O2SHiSDw0LqfvLEimvs4HaKOxS8Tpbb+gvvvm9ovE8kwMOBu6af8GEyk7ewEyslZ/FI
         OkJSz9Om34Zw34Q7n4RPN2rJFTiROAt38zhvsSV4/DlRDFTLzkGctgO8rO62tO158DTy
         bwwQ==
X-Gm-Message-State: AOJu0YyHvgyBCOY4T2Ra2KEgiHDH4WXrC/kv6lOPLIIJKlEgXHztq23t
	eWN40EfYIMiYeQc+7wIxrp8oQDsEqABKvmbCepNDAsH/Ps5CpVPINahPgi37ouLN8hZ2ueBc/qj
	cjQvu
X-Gm-Gg: AeBDietFH64/hcYzDcFpE9O1+UX2nOHUaJ/+s19QjDGUl2c+GgvraToUKY+bZaiTy+i
	V16VhLWl6znSWnsFUFD6+X/qNsT8oe2kYTWuc8I6WbwkJyviPeT6YHN4YCRsh/0X9a95y0ujxYW
	sWl0USVvkQBNCm1Q7xkFsbZ2OAcn8RGUMAmY76OR00+BiJ7a5lHGenOIT3I2DNQ34+6WRSslkaD
	VIsIjKkeKDCFKc+mlx+8LBhyHlDymRGBBZNB61Y4OqjWA+oWhYX8VKWEFno731v8Qn3Gu6Q4oVk
	/eQrmxxVIDQr6Ap69CfW/lTDKozCs+NPu09DriurlYAnyasQgsIBf+a2+Lmk6yC7PAq1KP7IR17
	e4XWMrn3qIZqNuDF7qO4D1l1rEbD7/i0tDzwe4IzwgeFDkng/OzY0WQLG3BUSNiThFAghk/onBx
	PpoBKb5b7hFvi2kqkMCEheeB4ofz9ZZmYqDWU9WjfioXmJdASuqooGGDZUWHZzSApVi4k=
X-Received: by 2002:a05:600d:8496:20b0:48e:6262:3e59 with SMTP id 5b1f17b1804b1-48e62623f17mr14192945e9.19.1778158356887;
        Thu, 07 May 2026 05:52:36 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895f0asm135579375e9.2.2026.05.07.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:36 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 04/16] RDMA/umem: Route ib_umem_get_va() through ib_umem_get()
Date: Thu,  7 May 2026 14:52:19 +0200
Message-ID: <20260507125231.2950751-5-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: CEE654E8955
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20145-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_get_va() is now redundant: ib_umem_get() with va_fallback=true
covers the same path. Make it a static inline wrapper instead of a
separately exported symbol.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 15 ---------------
 include/rdma/ib_umem.h         |  9 +++++++--
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index da7dcb227271..6617af4f739f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -370,21 +370,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 }
 EXPORT_SYMBOL(ib_umem_get);
 
-/**
- * ib_umem_get_va - Pin and DMA map userspace memory.
- *
- * @device: IB device to connect UMEM
- * @addr: userspace virtual address to start at
- * @size: length of region to pin
- * @access: IB_ACCESS_xxx flags for memory being pinned
- */
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access)
-{
-	return __ib_umem_get_va(device, addr, size, access);
-}
-EXPORT_SYMBOL(ib_umem_get_va);
-
 /**
  * ib_umem_release - release pinned memory
  * @umem: umem struct to release
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 4897c7599fa3..fd45162eb017 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -92,8 +92,13 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    u16 attr_id,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr, size_t size, int access);
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access);
+
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
+{
+	return ib_umem_get(device, NULL, 0, NULL, true, addr, size, access);
+}
 
 static inline struct ib_umem *
 ib_umem_get_attr(struct ib_device *device, struct ib_udata *udata,
-- 
2.53.0


