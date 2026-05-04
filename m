Return-Path: <linux-rdma+bounces-19917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP5iHVWm+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8AD4BE461
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ADA302D132
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366133DDDCC;
	Mon,  4 May 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="YZaDW35d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD052183CC3
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903065; cv=none; b=DFf7C9L2n0l46ortVufBxujdONlp6oO1Dd2wf1WOwdzZAPvvEZ8Kd/HQ39gKK7KiT8JLAlrRlo4icYD71hpcAqN3EsT3+BkivKVeJo1xvPPqYNBvc2pWADpmIU7b9eKmZtyg66NmIVxgv343t+9uBLc8LM/LOwukxK+WHwP4UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903065; c=relaxed/simple;
	bh=iYQVK2XsLxav0msJuktEvJsP/R008GbpSVbOGR0ID9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM73pKWgBeyKqQdpURp7cULiYeFy1bO4aYDgaN3ulv9j1bsfgYI2DLomaaGz3L1vgm2uy6AhFQe3MpAEDlaRI7wcJV1nypEICFl2DLs6hqttHEP0myCWeLLxvE2F6j8pfEN+IDLiOH6q+4TEgOGtN6nAY7Zm+5+iPZz0w0yi9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=YZaDW35d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e5624c053so567304f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903062; x=1778507862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8A7qlvVgt/00gLtm8+ufb2aymcugTupQxED/trSs3M=;
        b=YZaDW35dLNU3HDHVFLqkmTJkfSJJyJ5UZoM2MFm9O/ScMC7SNJhrD/8OSCgUCVutEh
         DW1CoWkjIP+BWOrccFvi5NKYCogPA9zTLM1l82qRhpAEgp+E/pnfirmEX6nNzlbndHbR
         YAG9qns7GoepOxiaNFKY+yi/vxnUtcEp+Bz3VIFgYTEphKAiOoRLH4FMRtOSBoQG4QXQ
         XKEumOybY185ppV1ZSJdkN5zhmNgqo0FqsU1+iT3ciZbGDGp2jGkPogJTDMawDxUvzyk
         L2inEhXpl3W+uhMZuLhbIWnUsnAjn4Zi0//srRyiOQEO0+LSaeyeZZo1qBXPdDw6hljp
         oESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903062; x=1778507862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8A7qlvVgt/00gLtm8+ufb2aymcugTupQxED/trSs3M=;
        b=BXYddAd/Zl0+0v7C8xwoqq20SVkiFibISjgUVPIycq/o5ynriYb8HyaJVxbMS6f0S2
         HzqQ61jmtp/hAZZokaB7flQtL3QvOVzw8WmbcJCMa1tsxLkmhi6iOQrJ/MVuI60hrGPU
         m7syr0x7IasieBb1C9cFzpmM8Kl8rZGbExdTW3E9MLzDvE6TpccoGdjjF8yjSlIpkTur
         9dtwJC+nr4NtRVR7Dv6D6ERQvNglPNdkpbriuzjUuIKTMkSFkSHDCmKhKXJalskcNIh6
         yjHC53+uXTp2h53y3Ok6PTTE5ED6D6Ylnl+KpNDqiROL2b17k05WtSt8cpz3RGNPYEfq
         ++Kw==
X-Gm-Message-State: AOJu0YypjBhBz6KpksLZIw4JwTfzGr2ux/1tnHbwYr/8eursO22tBV4R
	Cqb/iF74sBL0v+AFGnmNGEwDnRHR5AbYq7/hl/g4Xh+5bMQDlCAn7MYD3Wr+6IBPElfgep7Eq47
	BJi299fE=
X-Gm-Gg: AeBDievhUAx4fj+GYvqQnducji5/3GFpKRV8nAeu8akw1RRYI2xAXci6m+Jw0u6v3ln
	K8JW++t+m8cc0FvvtclU+ijnEK0v0LBKh4x1/pqwUe1bsLIX85yeMgv3T0yAXQl7WjpPX6yyHLF
	WaywUsTfiHooz61Yp9F/K6Bm7al2dTmx0n8aVaD/cnfeFy9osGw3GPQeCb0M930JE9U3AXbdkmj
	dFlooqpOboldNluI3h4sNSyGUcRifNrLpJ+nRsvYnd1LPKs4c6UiLsj3hygcIhOnUrOnpetvZp5
	uGZljaq9WYTXRu1Vmxu4DZxsIF9z1SgQKmta+rfz8/O2qRu4Yykcl2Sa4nlcfErf6XgRjvlGbV9
	ha/ijxW4/qKpeMg2p6AN8U1k7AlJ78O/ucdFAa4C2GrH9ZswZnV0JGHkIwr+uqY5/gUYWzwxIlI
	j9yk7kcnHP5C9y+s5eY5As9/hL
X-Received: by 2002:a05:6000:184f:b0:43f:e94a:e773 with SMTP id ffacd0b85a97d-44bb558caadmr16257924f8f.27.1777903062088;
        Mon, 04 May 2026 06:57:42 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f424032sm25884285f8f.15.2026.05.04.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:41 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 04/17] RDMA/umem: Route ib_umem_get_va() through ib_umem_get()
Date: Mon,  4 May 2026 15:57:18 +0200
Message-ID: <20260504135731.2345383-5-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 9C8AD4BE461
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19917-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

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
index d9073b1012bc..b0ab4133d47d 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -377,21 +377,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
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


