Return-Path: <linux-rdma+bounces-21384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM4ACoUlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE95E82F8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608A63034220
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615544BC97;
	Wed, 27 May 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cJpDz/B5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2933BE632
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901809; cv=none; b=sZ27uWuNa52rbkx2dJjMBRmt69ST6MqZ20ISOcK4Rq+27OzB6mvSInOagqZzx/lI2t5jz7qpu059+3rSVtXb0fSGSFiZOnnak5x8SI7VBkEzuagmhyzOExm7te9pUdWqoCzUzedhoCTZbKkc8xgXKmdnUK7x1GGxAMVt+3b0H5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901809; c=relaxed/simple;
	bh=wbs47rFZJN+RCb3Xjbs/9C78HN+t1FHjzUXxaQ3TnZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o90EJdl6OGfpnuUmxMru2anFMn9U/IGEc6oJYT5NSTDVxfQ04HmXKbpY7H941aSQRc2S+31cOoSJRxKLonehMoiJbdIBfhUSlA/ZS/9Y6+oXUM+PqgWs/ZKTjL1nOz1ILX4vG72P2ymkQmzSULy9bax33IS/kD/8Jrf568DKK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cJpDz/B5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ed9336049so1648641f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901807; x=1780506607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBSLksn3PJ3RDu0LqZq0KvfRFk/w+iI2nwrN8nz5oSE=;
        b=cJpDz/B5LBt7ROCCQ2S/72ZuCCmRDzxeAdXu3TZ03WwK9X+ahxyGXyiQ7lURSnEI1B
         2gAAn+FQyRM3sGp1770W1RDdpov8HNnRkpUlMoyAuIwwNYZ+xSEJmy6KCQukmTqArBNq
         T1z0X1xlSJPugMldriPFiLjotvhGsb83Th+RPMIo8gngr6+LOmkCGNvzD7a4VuLz3ynP
         BNmqAEx8x+vknyl+2rn6f1o018ppJZdGwhHJmh78crCon6c7wbiC2hcLoVDAZWCszA+W
         /+IWUX/l/8pRi2bfxSwJrRh7sIMUTPcR1otAAtx20oR/v+ANcgOVNy/YGmzTxg2jv5qB
         uEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901807; x=1780506607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBSLksn3PJ3RDu0LqZq0KvfRFk/w+iI2nwrN8nz5oSE=;
        b=tZQ04Pr1YZjKk6OTL0q6DB/cqXN2ii3xq2K3HgXvPgxnGDxx7LLHXCmAgszPGOQAN1
         me3n/FtAQRDZRTFf36L3vzv67veclcn+Dm7r1DBpT7jYCuxxVZraiKMQkT/BxTy5Bcq7
         tkifU/CknP7nmTc5gGJwDXseJqzgT0PtYR+G15ZWwF3rkzRZrsPsQClyNntPPwRRA8GN
         i7wwDnh77yL5FG1ueUAs9x6NHnXBS3HCsW0Be3SbU7itQfISVenfqcqfIMFBcwTPvHCB
         VABwpNv7YbiWYOA7flxUbnsb19n2qdstFLJO4a2MhZB8H90z1FnJ8y4hsp+hfHsVdn4v
         XJog==
X-Gm-Message-State: AOJu0YzNzgNVviZaMkYObM8jdWZLu6JyVwBuHuohRsD7WSlMrHr4C52A
	fc9enS0d31jPcwOuBoRfEnW7BmuMf9QmDV22Jr45MyXYRCY1d1CqQbcDwVwX9Jd51rnI04kFcMb
	/UX6ahv4IrA==
X-Gm-Gg: Acq92OFjj3AsLCYl7VzoBlBnohqG417K+lIWgFPbv3N4ddrI+R6xOwrGspy58DuKH+t
	9BprJXiBgbFCUNUrwztAbDf0qDQULK5/Mjsqm0Gd4rplE0lOaveDVgQMw0dJpHakT65lze1djnb
	RwPBrBAyQ2lYgnWgxmtKiDK3GJm+tglml3bZEIXgumMxuPE1y3ffh4dV/X0bmoaxl6PlHfNGbj2
	A312HGg1WnO7r1V/C2m2tEK1hnhOHb/16TGIMPtlUhNoA7yrMaLt6CT1rC17FU+GUwjYAW2zurq
	eoMzk/kr/g6TzrUoQ8Macf3glvkJbb+gpt3YAxRwtli05xUf6PEXQ12TgD0O7b91PM0h7e9cnMK
	sjQ6oxbC5YeT6EoaSL8O51UsmY61XRZuTRV7MnoVOJRTtjIWo/g9gH7pyk9CKiVAIWnUimuUWV0
	jEyLKU+SPM8pBTUHXn0x+JeCry1tefI+I=
X-Received: by 2002:a05:600c:5288:b0:490:50e8:45c3 with SMTP id 5b1f17b1804b1-49050e846f9mr338267955e9.0.1779901806411;
        Wed, 27 May 2026 10:10:06 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac676sm443567765e9.13.2026.05.27.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:05 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 04/15] RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
Date: Wed, 27 May 2026 19:09:37 +0200
Message-ID: <20260527170948.2017439-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21384-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9BE95E82F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_get_va() is now redundant: ib_umem_get_attr_or_va() with
attrs=NULL and attr_id=0 covers the exact same path. Make it a static
inline wrapper instead of a separately exported symbol.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- rebased on top of ib_umem_get() made static
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 15 ---------------
 include/rdma/ib_umem.h         |  9 +++++++--
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 7823ce24d86e..31e99c6e3904 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -430,21 +430,6 @@ ib_umem_get_from_attrs_or_va(struct ib_device *device,
 	return ib_umem_get_desc_check(device, &desc, size, access);
 }
 
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
  * ib_umem_get_attr - Pin a umem from a per-command UMEM attribute.
  * @device:  IB device.
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0f373679ea81..908eafa52840 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -83,8 +83,6 @@ struct uverbs_attr_bundle;
 struct ib_umem *ib_umem_get_desc(struct ib_device *device,
 				 const struct ib_uverbs_buffer_desc *desc,
 				 int access);
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access);
 struct ib_umem *ib_umem_get_attr(struct ib_device *device,
 				 const struct uverbs_attr_bundle *attrs,
 				 u16 attr_id, size_t size, int access);
@@ -93,6 +91,13 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
 
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
+{
+	return ib_umem_get_attr_or_va(device, NULL, 0, addr, size, access);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
-- 
2.54.0


