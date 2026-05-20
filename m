Return-Path: <linux-rdma+bounces-21037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDxeJh6KDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F394F58B8FD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D315306D622
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF573D47DE;
	Wed, 20 May 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ZHSB0yhA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAD3D1AA0
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271904; cv=none; b=hI93EiGS45YZ2LyV8ggktkXQZSkGSyAxHJWylfocQKeDaHaARwoLv4AgavX+mAfDzT6qAt1TBvfsekvYxja6LxYXCFXj1RlAnRRUdIJTSED9I3ujmYHeDGeykKe/EGQoBTTHlwJo30Sm0rwZHck9pG1BQMm22t+BLvA2zzZKqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271904; c=relaxed/simple;
	bh=PQsisfnHKi8Yqz0tkmWpnZPtq4M9t3RDKJ4KCm1/2SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaAhUU81aA4P2NoRzE9XU9Ae0MR8oZBftWLXsimJNcLvL7M3XgkYSJpH/Iylvws5twcXV4oolboIKCOcIfOke+fMtJTdkWUHjGm9OS+xiJFJY2+/xAFR+h+ypt82F4Hlnn3TYn/mW+g7vqJi3lK3w9hHCLqVjModLwmps1QElZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ZHSB0yhA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48909558b3aso49481505e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271900; x=1779876700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NYinGUcN0HHpFh0o0aY3DqM636NorLcn+8X1elhO1c=;
        b=ZHSB0yhAMgM7TDwDj0EdcaGwUaHDBiQp4rDWwoHXAJtV1eE6/SV3JF7yhzaOjidW6G
         Pj/5ODe3qMhp47CAtV4g4BNS6ol1bRBjsN1E0wilO+EGQ8CIkmPpRuTkFiJFFsIGg0ER
         iNAAAt8kK+0+jb5IdlCIHzpj/ne+3pwjhYM/M4Kxq6ObHB0rGdp/IizbqGlyA7afR5vd
         aQuZXLzkvEEf5F78S/0LMR/YArAsg4xHazEV3Js+Sc576fKvbXXTfX01lsYsinTrKV/4
         D+8hS54D1ZUPPm1NA4Q0uKjijPXLZV0lMd+zin3Y7MS21dLuYOX80sFB/5haxZjaiLr6
         aYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271900; x=1779876700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NYinGUcN0HHpFh0o0aY3DqM636NorLcn+8X1elhO1c=;
        b=a47fjhKx6q5ZTLDYKvAxmDvQjzgN8yh1yhVV+dkcQW07IRosv7ulCHK0jNvIUHRuVB
         +7c8XoawbtfYJvqCWxuecEfEpBj+mNnBbou+Gb6h+7heMR0LW2+WpT8XQjdjmySUhBiQ
         Z+D4q5DZPail8gGicCtVthSRhIwVYLTSJbc5W6VMN/O8gLGiWiZzbG30LEjkLAYHXLxF
         njXarNJI2Mn0B+8LAsYXs9DZgsDjBzDbHomyOLk5LhUYf7jqyMoJ3nEdAGS0Qct5zrRy
         tthiVMo2zroD/TAdx+FsjpyPm44PsFuYYHd4W6j9+Uk7xH8npyvF+pMo8RIaAVL0oB8w
         RYUw==
X-Gm-Message-State: AOJu0YxdZO34M57+15SuyjdTHHCTH5LOHVBqAl/tZ6Tlr61JGjQ74tXR
	njTj0GQ32PPrMelFp/DJT7k3c6rLFUlAGdHtCx+qPaNLwgT6LDESt2ro7dfN6cgh787TGdNKm+8
	KhdCL+1zK8g==
X-Gm-Gg: Acq92OGtpcZ15/mT1TUwymnWxldjttlCJXFsnds8GY2kejgtyg4EOE+6x/nl40/IXru
	Eui48fmBlJ/lHnQEV+hk8LzKdcI1U+IjK5TD+6DyM5tPC153MPq4fchsRkA7tc8h6zheNArvtE9
	kOLIbusx38n5ZSX+cLcianM7dvNcs2+556JC42DlDrqNGVXD87vSP4Ye1WycncyNuVK81JYUrKw
	y/QLQBjmPZBDK6UzNfRFJYvhcBA3TY0t2ltLEvZAPFTiY5BW1LAffsf6x056IMt+LP3OvMifz1G
	mWvgfN9vIMLflH5cWcGDKdFz6/mX16b7e46i8YUqn0Ns4+xVYgI73Xc5gZQIKYTGH88eI4dFcKl
	mlUsD9jrYJ1FYVQjIzFyR3Q9GdGYeVejfUJJhbLd9vhzaMRlIi56rGgC9mnpf0WRkyGIy31GeK8
	T5WBZy4KA1Z7jyDYR15i8JjwS5grdRBE59VEN4VYmGe1o=
X-Received: by 2002:a05:600c:3b26:b0:490:261d:7dfe with SMTP id 5b1f17b1804b1-490261d7e2bmr61874845e9.6.1779271900340;
        Wed, 20 May 2026 03:11:40 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm367901385e9.12.2026.05.20.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:39 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 04/15] RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
Date: Wed, 20 May 2026 12:11:18 +0200
Message-ID: <20260520101129.899464-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21037-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F394F58B8FD
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
index 6dc046dfac4e..4ffce2a54dbd 100644
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


