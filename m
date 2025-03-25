Return-Path: <linux-rdma+bounces-8940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6170FA70581
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D0E3B3A33
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8E1F5831;
	Tue, 25 Mar 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLv8Sgem"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F41F4180
	for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917607; cv=none; b=UR6AH2WXfd0jZZZAcLo8ulTTs9vIuQrooBFHjpwoPjKrndY2X+k6ex+eq7YBgosZyeL3MEYAIZ2Tv+pW6pj4IU+EGWXTzqXKaATdGSYz4lgK7zKQ/8Hj4G3he2o5bMLkzDhKO21/hqtXN7DPypBTYHLghmyo9t50ljSjsRKuE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917607; c=relaxed/simple;
	bh=+wrwZMqC093Z7gZ1xPNJ6NEXrS+qn3tLIr9ngcSDPyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzAPX38jBY4ZdN/4SYXa+9jxjcGl2QK1OwnZdhR8SqVMc3hEPPkbhBW62KLIqlt2jyk+wKkzEzBiDi0HpGJSFgkN/YSgPkskJHQQL6ivPeWgR9tJ1aVDci+RYR55RdfYO5JreKi5QWeNRxlfHcCc+YssTwo0QNm37Dq1timxjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLv8Sgem; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qelpf0cr1Bxyx5yCbHo7HXz9cxxZ6ghzCl2hi3M+JE=;
	b=NLv8SgemydbL68Ny5kA7eedDA1dUg4VWgV/VdjJ1MV86d+KA1Ta9UUVSqaKWKgHSWLr2H5
	qlwXCcQX7SqfkxvHRGfjX6S7pS14NGSm+ACcLhT4Q6jYgsJ2AInXoImf540vQvQwPqLoq6
	JwRZDn0p5lCwYLldRw//cIi1fH6q5sE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-OKPMA6OUNByCimBPKfjF1A-1; Tue, 25 Mar 2025 11:46:41 -0400
X-MC-Unique: OKPMA6OUNByCimBPKfjF1A-1
X-Mimecast-MFC-AGG-ID: OKPMA6OUNByCimBPKfjF1A_1742917600
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac287f284f8so392152766b.0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917600; x=1743522400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qelpf0cr1Bxyx5yCbHo7HXz9cxxZ6ghzCl2hi3M+JE=;
        b=DKMAMxKFZyXRXVZwGAxIh8EvehAW25HfNGrTjdYPl+/MZ/WuyqMrXKEFFGCbHAuXyl
         iCccAlxGR3rxpNamTx6DPC/KWzR6aoTtHVIviLgLzZeCGirhrbjEuJnCrM6Z0kOsIYHb
         yq18YN4bw/MNWGHOTRjJS5WrZrYF99Dk1/5DCpin3MmzZh9Vi8S4+7ebZwI/I6j/JIiB
         /8/Xru+rjChVkKhk8l6kD57rruv28a+5rN8wKVmrOwZ8nvzObP/P7IIOlJ4JzzhkNNjO
         ZC+iAjnq/zHkr9XXL2JByac54u46coSYW4Jh/ozStj1l3PTkaqKjiCltr0xCRIvUmvJd
         R54w==
X-Forwarded-Encrypted: i=1; AJvYcCU6JziFFn5Mq6v93n9GFrAosHw+W84Xm6gIEyhQXQkHhoTVPuBdKG12Lm3mvPvPgpX53e5Z6e2WxvsS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqps9/JfxVtMeHA03+kWxhzY/U2h2IBAXpyNTo9cnBBxXXodzP
	EyIfgMj6NAGSzUUSpQ0P/ly6xRn8o1/OVxsctceAYNE7ACzyJYc9UuRjC0tGINT+VBQPSg9NJUA
	+/0tOm6XF//nTKClcdnLCCZz1kx13iKMg5WjuZGHnn6/2KKaqq2DI3eq7Qls=
X-Gm-Gg: ASbGncu7DZZKy6rP70zf1OpI4FvaIhaKBzGdqfoUgwIgf8+Jw3pc67/VkBS0KIT1D55
	0w6nL0LNWsDw5u3Q4PZQ/jhEzPWC8nZ4k1/SPu9La6B3uvWx8HRiikvOgaDNWqVhp6AScKCQgMg
	t4DogSaoZTPqashMWn+0/t+op4cxwXNGE9IXWJkg9KzcdFnJB2CEVbKy8+xYsIC9eeap+8JL0/m
	FYBECEFWIrBUo13b7gngKrgPVQ7NlKbIs+Fdqg2js6tRTxtqktJLR/kW4yAWxLCRuL0krnfLEJk
	P66Al+/8qEDoFyb185FqF9x3yES1zddEFck/EOnq
X-Received: by 2002:a17:906:c109:b0:ac6:cea2:6c7 with SMTP id a640c23a62f3a-ac6cea2122dmr209868766b.42.1742917600048;
        Tue, 25 Mar 2025 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOdJXWY+OX6Pisfk0vOr5e4GyVLnFPg79bwnTUB2L/Or27l1la/vuNBO9tmBFaSgYvASXEiA==
X-Received: by 2002:a17:906:c109:b0:ac6:cea2:6c7 with SMTP id a640c23a62f3a-ac6cea2122dmr209865166b.42.1742917599597;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8675a9sm876497966b.28.2025.03.25.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:46:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8DC518FC8BA; Tue, 25 Mar 2025 16:46:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 25 Mar 2025 16:45:43 +0100
Subject: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
In-Reply-To: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Change the single-bit booleans for dma_sync into an unsigned long with
BIT() definitions so that a subsequent patch can write them both with a
singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
side into __page_pool_dma_sync_for_cpu() so it can be disabled for
non-netmem providers as well.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/helpers.h | 6 +++---
 include/net/page_pool/types.h   | 8 ++++++--
 net/core/devmem.c               | 3 +--
 net/core/page_pool.c            | 9 +++++----
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe2315edeb92850b6a42ab21e509e45..7ed32bde4b8944deb7fb22e291e95b8487be681a 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -443,6 +443,9 @@ static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 						const dma_addr_t dma_addr,
 						u32 offset, u32 dma_sync_size)
 {
+	if (!(READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_CPU))
+		return;
+
 	dma_sync_single_range_for_cpu(pool->p.dev, dma_addr,
 				      offset + pool->p.offset, dma_sync_size,
 				      page_pool_get_dma_dir(pool));
@@ -473,9 +476,6 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
 				  const netmem_ref netmem, u32 offset,
 				  u32 dma_sync_size)
 {
-	if (!pool->dma_sync_for_cpu)
-		return;
-
 	__page_pool_dma_sync_for_cpu(pool,
 				     page_pool_get_dma_addr_netmem(netmem),
 				     offset, dma_sync_size);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index df0d3c1608929605224feb26173135ff37951ef8..fbe34024b20061e8bcd1d4474f6ebfc70992f1eb 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -33,6 +33,10 @@
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
 				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
 
+/* bit values used in pp->dma_sync */
+#define PP_DMA_SYNC_DEV	BIT(0)
+#define PP_DMA_SYNC_CPU	BIT(1)
+
 /*
  * Fast allocation side cache array/stack
  *
@@ -175,12 +179,12 @@ struct page_pool {
 
 	bool has_init_callback:1;	/* slow::init_callback is set */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync for device */
-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
 
+	unsigned long dma_sync;
+
 	__cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 	long frag_users;
 	netmem_ref frag_page;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6802e82a4d03b6030f6df50ae3661f81e40bc101..955d392d707b12fe784747aa2040ce1a882a64db 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -340,8 +340,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	/* dma-buf dma addresses do not need and should not be used with
 	 * dma_sync_for_cpu/device. Force disable dma_sync.
 	 */
-	pool->dma_sync = false;
-	pool->dma_sync_for_cpu = false;
+	pool->dma_sync = 0;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..d51ca4389dd62d8bc266a9a2b792838257173535 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -203,7 +203,7 @@ static int page_pool_init(struct page_pool *pool,
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
 	pool->cpuid = cpuid;
-	pool->dma_sync_for_cpu = true;
+	pool->dma_sync = PP_DMA_SYNC_CPU;
 
 	/* Validate only known flags were used */
 	if (pool->slow.flags & ~PP_FLAG_ALL)
@@ -238,7 +238,7 @@ static int page_pool_init(struct page_pool *pool,
 		if (!pool->p.max_len)
 			return -EINVAL;
 
-		pool->dma_sync = true;
+		pool->dma_sync |= PP_DMA_SYNC_DEV;
 
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
@@ -291,7 +291,7 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_ops) {
-		if (!pool->dma_map || !pool->dma_sync)
+		if (!pool->dma_map || !(pool->dma_sync & PP_DMA_SYNC_DEV))
 			return -EOPNOTSUPP;
 
 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
@@ -466,7 +466,8 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
+	    dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


