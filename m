Return-Path: <linux-rdma+bounces-8962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0094A7127D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042AE3B35CF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFF17CA1B;
	Wed, 26 Mar 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQw6CBJk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D21A2564
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977146; cv=none; b=kyYz3FvjmXGWla+2krvtUH2RKLolHRwE2oGIZCZrANkJX0VaRzM7sU+/ANue8Z6p0XsBKQIJihbkIukNAOpoa03G39MlOVXaMXOJhon3xWsZP6jnx6kd3LZxfBZ8U+a57HmKiE6fYbQU9DPxx/mMlWL/TsjK8S8jt8rsOgcl2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977146; c=relaxed/simple;
	bh=vSoD9pwpfcSbP4dGBoxGCSAK3A6a6LNtloWC3DjyTGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9PPEf8j2ZHwtwtmb9b1l1BQMRUOLKt6+Utxf/Lknh0wQlZKV7LqxZTdJdfFzzydpWmNSNVTD+E/A//ZBrW+sKbzZssBmF8zpOHg+WoVJXNM4TyqD3qWIhNcuKs+DZvrhp74bvYq1Wgh6eJGRAJ+zZaJiGVVN7j+Xw2OEAjie7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQw6CBJk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
	b=WQw6CBJkS2LVy9n9cDDgU3EeLNx2zOfTEMHAZ/TV76K4d18aPKuQNd99aKiCGAuzb8ZEZ/
	SD4iO1oGe3+0RPdZ1zm0ULqAw/79BqVsZKCIgpWmRdzBcZEgW3Tzbqx0af7AWZGkgZn0Pa
	tk3Ot/z9LiofSW8Lq8zsijauOor5O5E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-5GVPGp6gPEO2bxBW2b5RHQ-1; Wed, 26 Mar 2025 04:19:02 -0400
X-MC-Unique: 5GVPGp6gPEO2bxBW2b5RHQ-1
X-Mimecast-MFC-AGG-ID: 5GVPGp6gPEO2bxBW2b5RHQ_1742977141
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e6c14c0a95so4858984a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 01:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977141; x=1743581941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
        b=uAxFu9SC6zv3+XTExo92ypCou85tvonVxC1Qkmc7xvmQNUI4Av3qc6mW1e9sZI7yFM
         H+2SstrNFzs1WOgi/p2iPJeyUK/HaelgmORXSabPL0Sah50mScX+gvztUa7oqPLzD53U
         x/CZN5VRUY8rhuUv06cqvZx9Xv6kth5y/QBCkWf7izwRo5kIUsQxE51ZXC2+QfFU6fpu
         h4CE0wEzoTbqb2LjtwZsKCfDExIGfIPrlwA412zbXDBvInZXCVjdZ2fbI1lK6223Hy9h
         TJukIhJKbPWFBJKRN24oYuxyxcY7rl8QqElqyRyhpEmik1eLw4h1alZ0ef68UYMhgXJ/
         aAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUtIXc/13JZjJn8l2pU500orLZDrZgY1FYxNZJb/ByeHqf7DxelCewEBIIfIrL+BI1SvEKhnhc6rfUb@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGN25JuupEKL7i3oMNehJ7sSTNkHLZwBeRsPAQ626bXLipXBo
	3mQpeA2l5ABZs9U6ZZC2K4AYcY2b7Hbd0vQCneTn3//Xjw0HKgf/Hcqmxi4n1HTUNIxfSy/8KPV
	wiA/Dk+cCJp1c1sk9R3DmpYsjp9Xc8Il5VCBVACb5lkg8RO/9sPh8NI9Y3Lo=
X-Gm-Gg: ASbGncsx5mGJviUmQfXFaxHrdGV+YZyeBbSIhxiJ0G9VksGlt9clGNvErMJnT+NWDmN
	OjOgapHvzmqjRFdMxTlW2IurNAMHTl20T4kWdVxna1dAAL/1ozUCGgGZBw1cluHgEAb1ENMCExi
	ws5ym6o8MPZkjmckbINebU5igpZ0Oqqabuxv9MA3ClWnuSESoQXNcFzZYVjFMWIdVFaVWN0hxwB
	X0/Gt4H51EhI0QOQGJerA7tDtkLmTF16LGl5ZsQ9SSMpR67iE9gnII5xKIMlNh6CqNIvaYKyLse
	SAAm1Kpjb4XJAp2H7i7lQ9617bDeUwuMYaP1KCcB
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532758a12.2.1742977140849;
        Wed, 26 Mar 2025 01:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbdeo79z8qV2b7AKSc5yQktiHryMqsZHBcfBd1BlUWJgmAJ39Ce+nU2q92PUFekHQpyPfq7Q==
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532610a12.2.1742977137314;
        Wed, 26 Mar 2025 01:18:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfae189sm8870097a12.37.2025.03.26.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:18:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5291A18FC9CE; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:39 +0100
Subject: [PATCH net-next v3 2/3] page_pool: Turn dma_sync into a full-width
 bool field
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
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
index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..fb32768a97765aacc7f1103bfee38000c988b0de 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -466,7 +466,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1


