Return-Path: <linux-rdma+bounces-9003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA63A72E05
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FAF189A5E5
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DE2210F65;
	Thu, 27 Mar 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKlzw0k8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2D20E71B
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072279; cv=none; b=amc7mgclT/3uYOUN42y8WBPUp+D9pmPdXpKDk8TwidpTgn0V8oIC5v2QEq/lXZo35AI2xg7fJwbT9h98ZFfxDixUz/B4yOf8RtdDgJgXuKkb5nuRsvmtVmmK3a+ZUfx7sMASOye8xAkNhgVFS+9On9Hn9qp5GI6ndE2wLWhWjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072279; c=relaxed/simple;
	bh=jU4n6IWZA16UVAMHXvziKTv++8RigMQc/gkO65H7mmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9W3U/EO2yYTtZnB8zEIV7TgxQW41PsSC2HPhsW7WlN4ncznednDQIB582WQdEI7vxQboR5/U3tlWNPx7zaxn0lgY9EaCgU1mrQQOXEGegczvDMysBfe4hH++bP/0khOziItcB8zW7+qCRE2DXeWIYOyxC0I5SaD+fujT6MLk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKlzw0k8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9t4W5dGLSES67cAKB6/mNTM9c41OeoyQ+4Jai1EE1rk=;
	b=BKlzw0k8RH3RCldOrDpgaV3EnRKgAgF94LQS9W/7J5p9TI69Vt4n7d+dh/g9cWkLT15p9a
	r5uXVAnZEjct80ZQtXOC8AdLUeCPwU38HlC8xkWTA0UgVVsGuRUzzr1QKbtdAwmunF9pCY
	7iBD2q3nqe1nNJs/qIsbMf4BQ+zmjWI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-u2qZMJ9IPziW2uZ0K_7cJA-1; Thu, 27 Mar 2025 06:44:34 -0400
X-MC-Unique: u2qZMJ9IPziW2uZ0K_7cJA-1
X-Mimecast-MFC-AGG-ID: u2qZMJ9IPziW2uZ0K_7cJA_1743072273
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so87943666b.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 03:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072273; x=1743677073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t4W5dGLSES67cAKB6/mNTM9c41OeoyQ+4Jai1EE1rk=;
        b=bsSCDtDksjhYItuQo5e8SC8R0x522cpyLFgSUxER5GP8bC4zwJ1wSnMDR/SMqK2Wls
         ucQmZEacxKwrL4uG9C988SyHw3h5oxRH8oi7L/+nYwhuC5lHYvWu18Vl/zO4UlQYkHsh
         dZBEkxa9MPf7JTSMfifHyBz4a/HzuXvHXwm/t/nFyLZWN5gxBJrL3yq35tdZ+XZQgnTJ
         Vvd+bmw1Gy3aBmVNWnmQAe4XVzlw1Rt27pATSWQuy8max6YR6gkE8iQzuOyvWVqLJZeF
         T5uUghKuLJdx70ZbSNBunLfB3D7POdRo/OEuGFhqsSLzsZ3U91MYWqJ5VNTqRKJu3VyM
         C3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXMlmqTO39Sjti1bAiJBaUgjTPMFU0PNyPTiFQEJkBCeqKFAy0C0IF44FgBk9u1WZ9zLCxSYz0yzF6O@vger.kernel.org
X-Gm-Message-State: AOJu0Yztmxv/SQsYPHsP2GqlGovy0A6odvwjAULdUFOlxeUXiqbUpbBg
	lySTJadOeoZRnm9Vm2YrLIem7etc61J+kfYy2A+ssCu0b1hrLmldos0KhOekKAgmWBMh6+Ip/Zt
	rp6Eoja1ZC/ByUJqyiTarif50obrn1r4tPUsJ/a6oYRFJqcl+7k189ubADSk=
X-Gm-Gg: ASbGnctGHGsSlwylkYjPfUoNFL79foFXhsqRG5DJFBAHUIcFwNzQOspqQmyP6IsvO/m
	2JTsVhKdRimGXpouca+I6fz8J0GUBOu+5N5SDbpRapQOv4+Mw5Z3FD2ErQdDIBLgu9ThUJwcCO0
	y4b0PXhu+41oTxrhZjkLP4rtXViFlB8BMWwP/NVwgrShd5tNmJ0M/1iKej2PMuYOUG1g6IjtXGx
	Sdp+gQyVqUtVF9kbQWqXMIqIuEgUnHvBy+JoHO8LX79BO66S0ig7ZumrhUWpcpc1LxE5JYQdYjq
	l5uE9ncoflSU
X-Received: by 2002:a17:907:9445:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac6fb0fd646mr282331466b.37.1743072273068;
        Thu, 27 Mar 2025 03:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5W/lqNkHafWShe6vkN9vTaP1afnDzl/apRQY9StJ2QLIsUkjICNTeJVHXqSm6f8TF9xUcTw==
X-Received: by 2002:a17:907:9445:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac6fb0fd646mr282327066b.37.1743072272623;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd45594sm1193278166b.160.2025.03.27.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:44:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B20B918FCBFD; Thu, 27 Mar 2025 11:44:30 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 27 Mar 2025 11:44:12 +0100
Subject: [PATCH net-next v4 2/3] page_pool: Turn dma_sync into a full-width
 bool field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-page-pool-track-dma-v4-2-b380dc6706d0@redhat.com>
References: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
In-Reply-To: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
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

Change the single-bit boolean for dma_sync into a full-width bool, so we
can read it as volatile with READ_ONCE(). A subsequent patch will add
writing with WRITE_ONCE() on teardown.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/types.h | 6 +++---
 net/core/page_pool.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index df0d3c1608929605224feb26173135ff37951ef8..d6c93150384fbc4579bb0d0afb357ebb26c564a3 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -173,10 +173,10 @@ struct page_pool {
 	int cpuid;
 	u32 pages_state_hold_cnt;
 
-	bool has_init_callback:1;	/* slow::init_callback is set */
+	bool dma_sync;				/* Perform DMA sync for device */
+	bool dma_sync_for_cpu:1;		/* Perform DMA sync for cpu */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync for device */
-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
+	bool has_init_callback:1;	/* slow::init_callback is set */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2d801580a6760eba9393e1cf67b01..c75d2add42b887f9a3a74e3fb1b3b8dc34ea72b1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -463,7 +463,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


