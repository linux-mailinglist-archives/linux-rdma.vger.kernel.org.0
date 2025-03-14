Return-Path: <linux-rdma+bounces-8698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF6A60E6D
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 11:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2CD1B60C0C
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1BD1F3FD9;
	Fri, 14 Mar 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2rtmMru"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05301F3B91
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947144; cv=none; b=GDeQraEubxoJzkCF6KOjLwqfh4BG9VR7HxFJRwpkYYAE72okMowvYNEM9EVNajksSb+FpwCi0y7/vJ04YGbQ+eJshQLs6zseRtWnIG9KY7oM+6AcQRshQ66bn70aZP3+ol6urb47lGLOSf3utjH1UEd1jcr6ZPEXgHKFMbjvuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947144; c=relaxed/simple;
	bh=VzvXCYiJB66dpmGnvt1GQ4j7QA1QWPVA0WnnxJNRFz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pj5dGW/ZiTzOKhXDYH9Ctw5pZszweXzn9ONLNQfj5aLbU+2wHqKlhQjprVsZDtTeao479tnG8f0nBgZKimORK8J362XK5Hy+f5dkLox5fmKPx5qJfIW3Am/tsZ4RWq3CoWZIDNZybyyRq4aMlgnlSNShcCl0Hn10cYLTVYiM6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2rtmMru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741947140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ave2IjOyoZ2UosD/vzUXfIW4ywUrT9zR4dZ7jLrzKAc=;
	b=A2rtmMrugjQglCy8L/VKTb92n45r6Wb0LJ6g51vHSM0JTJSj1K41CdX71FvCC7pz5LRKW+
	fGDP2mVuFH5aoXUD8yvQloUdKG7qAtbKxrAQTO6M9QXtDZDIXmNr4RrDGHVo9gWAxuT3EI
	QRM4gGPeLKtE18LnpzRlsBaTkd8f1k0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-bug5JlMWPT-R948obr99wg-1; Fri, 14 Mar 2025 06:12:19 -0400
X-MC-Unique: bug5JlMWPT-R948obr99wg-1
X-Mimecast-MFC-AGG-ID: bug5JlMWPT-R948obr99wg_1741947138
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-542a77b4a4cso1153036e87.1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 03:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947138; x=1742551938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ave2IjOyoZ2UosD/vzUXfIW4ywUrT9zR4dZ7jLrzKAc=;
        b=D8ME/RD3eEbawow53gTB3/FvI/+six52YqTSSYE7B6mhN5t+bk9v8im9UgiT/QC0YZ
         Q7YWBdFQBQUBbV0hh2RjaVdEWya32hc/B4h5qiXHdx42gdThDnZUr1HEVstHvENpqZuR
         tl3564QiV+9POaSckrZs2oWenFm8XZ9rA2oIcSooZJCx6Puc1g50kX0vN5DBBfxkxcxK
         4FqW3b3ExSJCs9HB/5sJYLVaCKJ3BUf7f9CAbWUWJqebeDXI7L0Rd/JLPFJpbyzRjDHV
         UDbLcEfJnMtbcRHRMHUHfDu3HAnFLY0DOHDZ/a87j/xxKFQa0DWbXgGCWwWo8iC0PHpl
         l3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Fsx6SsIkEaMsvSX+/kM85TZkgGlsgRPolalD2OevAO9rdNiM+ec8gacXvuZt+Ca41GbLOb+KbsWv@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUwy180OFpv4Yqi6JfKYlPBbm0f/kxxLiVuwmsITHMlJ8h7xr
	DXNrAVat3uzOetEr9iRZEzS2okzQkPolf6EX8L/FYhIejt4imSnnvSZkHuLxeB9+GpSnpn3teLm
	KxfF8p6AXDZN0A34wh0qfxVxGM2bQ34042FQg8+ayTk/AoRMIfv5pDyjQ7KU=
X-Gm-Gg: ASbGnctjzncn1TC5Zd7zZ9y+0yaF/vPbSvB0lTF3jZ9/3AW0SyxfeRuUyb1Uz/nH8dK
	TpdDbBJdYWk94Kkl7RzmfCDKwFm8z1cnAca4+OyFEIrhc/FNLIf/5Vwtzf0o8zter5qCw5VSDjY
	pr5Ny59m1RA1VYC0WHXVv7sj+irUCiMw3DZxWN+XKqHg9P3hv5syURhgEyhfjhs/OzyM/GJJmJa
	FfJBTHt3cbqknCTc7TtFH0Yy3qWCQV3b62hDaB6NqcATFVF+NMJH3qVwlxE+jkDsvuCP+xxcyS9
	1RqFJ8fZrAe9I5DPDAX6jyEM+4PuFIp6tjB5NOog
X-Received: by 2002:a05:6512:10d1:b0:545:3031:40aa with SMTP id 2adb3069b0e04-549c38f209cmr513459e87.9.1741947137923;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzxGfVA9udR6p6TQJwZ91X1aXY0n12wGHzdlM1JECrgnA89h9JnwLyeEXzDY94I1wIwwBIgA==
X-Received: by 2002:a05:6512:10d1:b0:545:3031:40aa with SMTP id 2adb3069b0e04-549c38f209cmr513435e87.9.1741947137461;
        Fri, 14 Mar 2025 03:12:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8804a9sm469301e87.168.2025.03.14.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:12:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 09C6918FA92E; Fri, 14 Mar 2025 11:12:13 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 14 Mar 2025 11:10:19 +0100
Subject: [PATCH net-next 1/3] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-page-pool-track-dma-v1-1-c212e57a74c2@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
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

Since we are about to stash some more information into the pp_magic
field, let's move the magic signature checks into a pair of helper
functions so it can be changed in one place.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
 include/net/page_pool/types.h                    | 18 ++++++++++++++++++
 mm/page_alloc.c                                  |  9 +++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 6 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 6f3094a479e1ec61854bb48a6a0c812167487173..70c6f0b2abb921778c98fbd428594ebd7986a302 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -706,8 +706,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb26173135ff37951ef8 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -54,6 +54,14 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
+ * the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~0x3UL
+
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
@@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 {
 }
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
 #endif
 
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c7bfb7b0d847d51af702a9d4b139a..0268b68935ceb27d9781e59a474a234a6a61ea74 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/page_pool/types.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -872,9 +873,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -901,10 +900,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-#ifdef CONFIG_PAGE_POOL
-	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+	if (unlikely(page_pool_page_is_pp(page)))
 		bad_reason = "page_pool leak";
-#endif
 	return bad_reason;
 }
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e002fd1cc2cef8a313d2ea7df76f301..f33162fd281c23e109273ba09950c5d0a2829bc9 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -18,6 +18,11 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
+static inline bool netmem_is_pp(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 {
 	__netmem_clear_lsb(netmem)->pp = pool;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93299f503e5c298b87e18edd59d555..a64d777488e403d5fdef83ae42ae9e4924c1a0dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_netmem(netmem_ref netmem)
-{
-	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -995,14 +990,7 @@ bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
 
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely(!is_pp_netmem(netmem)))
+	if (unlikely(!netmem_is_pp(netmem)))
 		return false;
 
 	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
@@ -1042,7 +1030,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(is_pp_netmem(head_netmem)))
+		if (likely(netmem_is_pp(head_netmem)))
 			page_pool_ref_netmem(head_netmem);
 		else
 			page_ref_inc(netmem_to_page(head_netmem));
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a77eb63a96a85aa6d068d3e94f077..0ba73943c6eed873b3d1c681b3b9a802b590f2d9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -437,8 +437,8 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		netmem = netmem_compound_head(netmem);
 		if (napi_direct && xdp_return_frame_no_direct())
 			napi_direct = false;
-		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-		 * as mem->type knows this a page_pool page
+		/* No need to check netmem_is_pp() as mem->type knows this a
+		 * page_pool page
 		 */
 		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
 					  napi_direct);

-- 
2.48.1


