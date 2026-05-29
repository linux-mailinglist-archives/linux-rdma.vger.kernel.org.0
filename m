Return-Path: <linux-rdma+bounces-21514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG35FXWZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E686F60317B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8AA3111719
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F633B97B;
	Fri, 29 May 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Ios/2Rt7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C533D6EE
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062243; cv=none; b=Zaaf4cyrAagjeRvVhIFbw06h8XkmDHPMW36cEmLqwiTMKQwKHcFTMacI9Xwz7QRc5cJxurUUpSVTXULLY780Zxq44sAvKYi+vqrGrWu2rVo5OL6InkdSPmB17hXFdTHu8nWsSZj3el1VJKL0WRaXr0auGxsnZhxlTy35Q97XOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062243; c=relaxed/simple;
	bh=2DIekAvfggjLi7/64hyA/yZfKar+MktSEgjBNbFyyTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI5duEsc8wVRENAG37EfLSuEQWJBu3SlvlcD7Z6+u4QjUsJOz/NIDALSCwTTjHyCtfuyFonIOcl5C9vAbKVdHNOAE/ZEfqkyWBgOlAgD5yPRAX/glk0IokAJK8cxfEKQjAAhUZtmR2eHuV2tEA7RgAzoqIe7lPuyYHzaOxLX/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Ios/2Rt7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso120737805e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062240; x=1780667040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty074by5kmjgXYxYCJGY33UvHDzlJhNzelzq5q6ScRM=;
        b=Ios/2Rt7p6+/ZEiCPDg51LmkNAzHG8hlKzQ8URgwsU9ojNOnjAOlV6Q5aYZ+EL4Yss
         6yBXIT5WUTPkCYZ9Tg1GpCHpIzPrtUs16IQLAS4+9/rWWUkj5ORnUsNRt5fk8wpS5ksq
         gzd+7NlYzOCrFOXRPONjmTVT/TB8yMV0ddYz8SKKgVK1lQ46n/JE8A1jNtGiKOUAU9po
         sCHzvY1L+mXBia+c6HsQzzQkS1TVx4vdY7A3CBrMF0vxASskcOswUpu8nVZFDyXwWMJr
         3GJqPNohkd1DUVPIwe4iHd8j+L4+9sh1k7Np4phh2fsesqghLr3X424+tu3YJBMKVbjz
         MMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062240; x=1780667040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ty074by5kmjgXYxYCJGY33UvHDzlJhNzelzq5q6ScRM=;
        b=hORUBjlRsM3DVUoYnN/YGSUMDekJ0wKZuqRliDSExNGuqTzPCbDIYImdHNl4ma7UN1
         euh/X0K5+EXN5ZQbcWmr60acALKeHl53iKsoOuWDBtwJedT0tngDVJRZc6HJAvuaC71J
         v0eIBC4WONRVFa7hI5pF65ByNL2h5eaW6wGy1QYFyShxOjcXg4P2h1N9a55dbWyyrnEZ
         +nFGq5LFgDceLizFXCrDNAe04Nr/s0RyPNBDsnU045uOkgiv12VboM8vqsTWKh4CVKth
         nAJu2mjl3smAzBOFCISphX+68/ScsduJxif+7hFy9kW58PtIW2pRvA5/bzGYWSKjDteq
         WZ6A==
X-Gm-Message-State: AOJu0YwaYLi+OKLE3uCD/dw5Pr0Q4MrF+0uITSRLu4vZcmLPkdAU5Ys5
	Ik9P56YGYfZcMwOmMjAKUL6F9Udwtk9kCiFzl89EpgWW/BHZWQoBfq9F304wtvEZjPWIdblZ6ez
	9hY5Azrdj9w==
X-Gm-Gg: Acq92OFn53Ca6u9cEihIWFbVtwmZl6LoRlarjm58Qt16yEqeMHxqJkBxcno/C1hNJiR
	3a0EbfSIpx7zDSSFrpTxIJW5oXPvD2GuO4IFn8Xk42ZUPCbSKjAwaRBFNnUKgBN+MHaOf1nhyjI
	002kwLL0M7hNcD3cFMG1WhUCEu1mzTrm7zRK8V1aAX2CYAqAS/IiR4seeQiEyJp3zNC77od2Gtx
	2+gRkD8T8k8USmXF20FtTp5OpbivgA7gW0TrGpxZmVtfCSsfW8oezqJknlQYbdE4s8X7RZcUkxi
	YXeRHyxJ37A0pUOqsxS0jvcsSEnLQRGew+D/9Cq83ilB5p2c09nQs8EVU0eHls/FnMYibBj6/el
	CNbxwKrQoVjLzQBsOQ7D5TyUod75kPVERJBCAwL1MAuEqCKn7a6M3obum0UkJjp9mJAvqHzSYeL
	cnIXCUTE6x0UNPYqgbN3Z1AYO8ff9Dv/NZkCKNClB65wY=
X-Received: by 2002:a05:600d:6414:20b0:48f:e245:394e with SMTP id 5b1f17b1804b1-4909c0c8cc0mr41113095e9.27.1780062240494;
        Fri, 29 May 2026 06:44:00 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm36020915e9.13.2026.05.29.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:44:00 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 14/16] RDMA/umem: Add ib_umem_is_contiguous() stub for !CONFIG_INFINIBAND_USER_MEM
Date: Fri, 29 May 2026 15:43:10 +0200
Message-ID: <20260529134312.2836341-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:server fail,resnulli.us:server fail,resnulli-us.20251104.gappssmtp.com:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-21514-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: E686F60317B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_is_contiguous() is defined under #ifdef
CONFIG_INFINIBAND_USER_MEM, but the #else branch lacks a stub.

Add the missing inline to fix potential broken build.

Fixes: c897c2c8b8e8 ("RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v8->v9:
- new patch
---
 include/rdma/ib_umem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 370d802f0e63..bc1e6ed73b3f 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -244,6 +244,10 @@ static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 {
 	return 0;
 }
+static inline bool ib_umem_is_contiguous(struct ib_umem *umem)
+{
+	return false;
+}
 static inline
 struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 					  unsigned long offset,
-- 
2.54.0


