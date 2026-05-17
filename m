Return-Path: <linux-rdma+bounces-20845-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB74BgrNCWq2qAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20845-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847C56183A
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB258300C937
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86E2F8BC0;
	Sun, 17 May 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xaHjwfM2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C352241695
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027206; cv=none; b=gOU9YyrL0ctDoltAGxqR0K9tQ+4HvXQnY03pt73YpxKw3o8s691hyp5J4+ycC/LRmj5rZqeaB/2cSxIP/rm0wAoaOoCbDcOj1agJ6ct9s0TeXXgVoFkj+AwJVi5N66o0jMFuUdgo83QUs38Hub9xadk5dj0XVnGkGvTv7s++oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027206; c=relaxed/simple;
	bh=vAv9EXnz+1uNb8aDOucg6zW4ZoD9U36w1QT4wRbUvmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWNugvr49OOy4Zt98mEZLWMiDEH993HpuVzwTtJsZlKRhC/xoF3B5rdHMiJhge8LiD9ntVzIfUUwZYnpCVC+pZnDn7UELd8UKLUHHD6ObE+i7+tyCnVlKQJncd5IlAWI+MubXVZxusUIUE1EiRv2y6MuH/B5WzsBFHezCZk4JME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xaHjwfM2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso10642605e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779027203; x=1779632003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVmxQnSks4ZWuZy1u165nNTOppPQv7rHiHuk7h9/nAo=;
        b=xaHjwfM2meC0KkdsLA5sOIhUO7qVXuxHj3JqxAwLJM4qOYWqEKabiEQUYy8IK4P4st
         6COD8PoagNASyJWFxDkV/EZTWEX/pMe3KcOH8kriipnhL09eeqN0552kTUPgPA/PKr32
         4DLWJqPMjv7nwaNx2RsaNaP6xBbOAVpLp0M7NpDlgvrVUF3JX0cAd0na23HaVBioWoFI
         Qoi8poF2sAwPr89ePgmoNddQn19WRXhhu/k4sHOeBgNWEYa0wfSfX0sp/TjGhJ75NA2J
         qSK518jXaUhjYFxcR819Zs5WE0WqVh0AquQ2LeJXLBRuTbZ7B9fUVb9txixfT1ISfcj7
         bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027203; x=1779632003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVmxQnSks4ZWuZy1u165nNTOppPQv7rHiHuk7h9/nAo=;
        b=sdJ+RMGACkwi4pAnbgraOyxhybyGiupl8rZryCbrH9doOj/vEgNR1tR7aMENM/LiPA
         ORwmJxYGCfi0xp7HIeWM+icJ25sQrrneRQldn2ZRzLa+pD6nZZRD1EIB3feIQKYgeVZJ
         UR/9ejyNbTGd/EiX8dof0oYN1Aqv377rDkSzjMI2aHKiogwXalDHgUlpz984uY37IrHl
         +S0lVGHFNAWdZbg1yA2fHmyvwcYjBec3ON8WOuS6MfbgvrPglJRqM8im5M2pUttOrHjp
         nDlJymz6IQp4KOm8ysohNcJOVK/Js8rMJNjv1BuVr5Wsh9QoRX2PbX/NkTI1YwtPHlZK
         CJ8g==
X-Gm-Message-State: AOJu0YzbvZpegTdXvhxTQmRxHxaJCCeB8ZN71cvQqjWxcN5RfZ8CPBgZ
	bwegupjxHvb3Jl5s8ybrmC6ulz0mHQ4SqkZBgjZ6LLyLlhRLyoPFApjXbnFIenH3Jg2gFddGhA1
	I26d7f08Vm6W6
X-Gm-Gg: Acq92OGuOvzJgYEqAxt6fbNnZBVBc4KsKnV/A5sAj8Umrraw7OrXuNvlpvpm/cbT/19
	fXduQq/am6G4walfBPLRpFdB/Ys/TIk9UExb3DV/Yy8PN2Sp3eoHPdVlwq69foyGVoDjVVj2OyL
	je7v+tzg5h/K/CmfGCfgHpnJTPGX/wsNWx7xOTwMYwipsbC7NER1Nm5y85wR1uYUfLNQNascQeY
	i5SobgA50VKjCkb+utQmlvCYY5OjRVHFgyhIvvTBDbBa6FPHHPrMmh5wj1xnnDn9mPFvNwdkEFj
	L+NfHJzGRuzn3En51Rfxn/EDLx4XMZSGc+XXO//Wn80ZN8zoFoWHTln3pGRiEe5kkEt9Gl4DbNg
	47yboMJGWnNBVkF0sqTVYmCgW4IYQybWoGyzhAZTdFnwsv7JZRTG8pTtZ1wXEconNzVubzs/4gi
	j1n41IipHZLY8dYRAdsagQVMBvvVFpcM8XSRymC/0eaYy8yZ1R/SC3
X-Received: by 2002:a05:600c:848c:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-48fe60ecc19mr170072445e9.10.1779027202948;
        Sun, 17 May 2026 07:13:22 -0700 (PDT)
Received: from localhost ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f8799sm86798265e9.2.2026.05.17.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:13:22 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 2/2] RDMA/umem: block plain userspace memory registration under CoCo bounce
Date: Sun, 17 May 2026 16:13:11 +0200
Message-ID: <20260517141311.2409230-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517141311.2409230-1-jiri@resnulli.us>
References: <20260517141311.2409230-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7847C56183A
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
	TAGGED_FROM(0.00)[bounces-20845-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

When a device requires DMA bounce buffering inside a Confidential
Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
redirects all mappings through swiotlb bounce buffers, so the device
receives DMA addresses pointing to bounce buffer memory rather than
the user's pages. Since RDMA devices access registered memory directly
without CPU involvement, there is no opportunity for swiotlb to
synchronize between the bounce buffer and the original pages.

The registration would already fail later on, since the umem mapping
is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
instead, so the user gets a specific error code to react to.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- updated patch description with mention of DMA_ATTR_REQUIRE_COHERENT
---
 drivers/infiniband/core/umem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index eb1de32bab9d..b32bc2a5d7d0 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 	int pinned, ret;
 	unsigned int gup_flags = FOLL_LONGTERM;
 
+	if (device->cc_dma_bounce)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * If the combination of the addr and size requested for this memory
 	 * region causes an integer overflow, return error.
-- 
2.54.0


