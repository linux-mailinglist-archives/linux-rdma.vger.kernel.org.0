Return-Path: <linux-rdma+bounces-20066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GoRLLAi+2lvWwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:14:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489C4D9A3A
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A509300D74F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6307423A95;
	Wed,  6 May 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="t3tXyiXL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD5423145
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066094; cv=none; b=lSShU7qQs5ujEgi3T3iwc2LkBBYBrW53nlxO7h/xdAuS/okENdWB6UDS5QgXJdT3wD7xV7mwbn5HR1k5dbILR3wETKN61ECuN2Lq1MqOnCgLyQddRx3VhlKSOn3l7ybM7A0ywUrlJ4cV28+ns9eqpMOM4ZX8o2S240Y2ThJH8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066094; c=relaxed/simple;
	bh=WCCKIpkWTnG5GVfw5a4HEKQfXUBi4Jidl61GpVyxhhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=basF2z99wdOEJTIGlai8dj0w3TonzJ26En8rViYCceEipfJ+IzOR1P8IHqGN3gCdZtBi2LzKPoruRQvQS6qqgBELjlIbgvYREmS+mx6Zgl28Lq1Ywbbec7pEY5xtgW1V+1HH3C7z9sG3aJ0QpKBi/30vgsGq9DORWlSB9EgqBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=t3tXyiXL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso69085515e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778066091; x=1778670891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GG5COaYt/5X1PJ2x1KhSOcwn9vhVm1oenBEfc1DfKE=;
        b=t3tXyiXLo6UjTHNRGz2I9RDNcSSzBVE7aeL7DIu28+M5g1nSBlOgCGsV1qbHQdsNJd
         tjxwQhn93SDxH+9c/4K2IECcv3ydmX3nB13bLDSOGMa2PHT1vPXq1oXerHk2MhNDXcv6
         mjmuvgzsTPVWw349Zj4gtVqDWHtpA8F7ma+vfekI8qiDK7Tn3KEnnK1D/yNg/jeKH+Jc
         bC0wDWs0w+33m/WBOc4VYZXIVj9OQCXz3J51Hg1DfKo0MJ0Zppy+zyE1WalFEEBSeBvZ
         RCo3E7DkTa9YHY/kD03DP7TqYogZpv6MqZuPb8Rob1ChOBZE8cXjPkeCI8l9eCiBLpAJ
         UO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066091; x=1778670891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GG5COaYt/5X1PJ2x1KhSOcwn9vhVm1oenBEfc1DfKE=;
        b=LgPyBZSspOzJkAIuVx+wB4zZjkTLKi0lOU73N5y7ey2LPB80u1EYhQQZGLURWmExYU
         iMGwlOomMG2NVraU1JbQtbMrqQjXlbf49kzAthwNFTXv7zfaU/LvCkwDwKLapgidyKtj
         uyS6n5sLR+Q2f2TShV8D1TM9wRV5rErV+48j9noxrYfzercSE1VFHvXgUhqkYGqV2t++
         l0wNQpGEFi26Pe6LSUd77/loLETDfOW5IAIG+tz7ZNoYJf5NNHXwCU2mMZGu9Sae64uh
         UcVcB1tSl4ipw1ppcze3KDh+GDUwYIZn/hkYAORR63OqbM2Qf88PaVpaVSmRJ6G8OCAY
         S+YA==
X-Gm-Message-State: AOJu0YwPECJB50wffhlbwJaarWH+YVyEm49cSgZOmB2NdTZsawebgyoE
	/7yP/ghJmzS6FyiRxjZbn48vsS6N8ybJfuG98skgKykNoJN2eAinm4R0LSg18Sv8eDqb6LM+w+c
	Oew1u4sQ=
X-Gm-Gg: AeBDietxLmqBZwA8q3NfCj5LfXLtWyxgpw8f8pYD2u6iG76SHZrICwCmtLbyd+Jc3DX
	ZJ5bh+hKh7iTgVd7YLrgjEXRN72xZusbecMuOBaXRQLCMJwyiVPlNRhNt0zLsTjGFXC8QeFLwPQ
	yYlT2aCKnU9qOF66HhEfW84rw/Yh81k/eNSMj/gjo2VHlezCzZq9I37gAK5NeZ70pwNF+4rNVPJ
	p3ZO0kbnW3cETJDDIdn1mKI5keU01+NcBDMJmFa1tTwmtNTXZ3JyEmqyR4y07qsLCjAgP8PAoQ4
	TkdP4k8MLm0M0FurPzeyhXgRbYKexwCsGYkbVp/p/9siKyGs2PLhUKORjFUpCV+YYJLUbqCs2VK
	VjWvpqCg7gKbMZtlkimtSaE9j/0zR350I2/eefOSEUIO7Gr3iSsWwRhgb53GVl5UCVWM4S9hxsx
	vUVuIFs+qXscZvo49OghK67UqR
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr48076935e9.13.1778066091352;
        Wed, 06 May 2026 04:14:51 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm13093721f8f.28.2026.05.06.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:14:51 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory registration under CoCo bounce
Date: Wed,  6 May 2026 13:14:47 +0200
Message-ID: <20260506111447.2697789-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506111447.2697789-1-jiri@resnulli.us>
References: <20260506111447.2697789-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5489C4D9A3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20066-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid]

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
index 611d693eb9a2..b1877b83b021 100644
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
2.53.0


