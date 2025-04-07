Return-Path: <linux-rdma+bounces-9197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67810A7E798
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD143B2745
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49A214A8E;
	Mon,  7 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCvCSyWh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD552139A1
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044927; cv=none; b=NBoMu09/thLgjWqVK6edTPEOShobGmsfiLs6NBdxTGFAtabqYq0UWrcrrB2cj7oiRQ37Ctiws2Ra+DJWJZ+XTC4mA7662+FfFRU2sTwAcN6W4YAnhBHV79KxwCg8Gz8xE7fqxMuOxDEShoCoAn4gjj0Y0ogHEcji0oNHp8UGgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044927; c=relaxed/simple;
	bh=BtnfmSo/pDL7vIDDLNObZDZpUAYRt4VzHUSgexGFvtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgBID6nIFRdcSJKUOOXJteLJckwGdNl44YUNopygiJJJGornRrMxfdh9CcqKMR41dbRl6nF201xKfJS9teTQ78pLyj7/QJOdgyRi3ZutOSjwYld7MIo/At4v8x9UXSc8MVIIWICctVxKoRrR5zzEpGtBuObc4HiiHOB9J8PGaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCvCSyWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744044924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uOjWDhXK5MlXVzffQg4sX2fJ7S1/v80HTUaI6iK6sg=;
	b=cCvCSyWhivi41j/V2Fk0Yd52s+OVutXYMX0FHuce3nS5XeVpZM73mSfg0L0ZHeIKaep98X
	gtv61wYkrkTwU2CBtDt1a57YYFWSieEdfx5JeZOhVv0Qjd8jJT4wXGv1Bn/5oHsYhNYeME
	N8DIm5OSTq9su+OV1JU5P6bQNRY1h/4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-B_TQiaF6M0qdmwfFMaYHGA-1; Mon, 07 Apr 2025 12:55:23 -0400
X-MC-Unique: B_TQiaF6M0qdmwfFMaYHGA-1
X-Mimecast-MFC-AGG-ID: B_TQiaF6M0qdmwfFMaYHGA_1744044922
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bf4297559so36696291fa.2
        for <linux-rdma@vger.kernel.org>; Mon, 07 Apr 2025 09:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044922; x=1744649722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uOjWDhXK5MlXVzffQg4sX2fJ7S1/v80HTUaI6iK6sg=;
        b=K5AgBGCzIV/GZKatXOaZRrsw05nROlTOYtmiPkWu4FSBUeInQ+Kip9Ll69LVFHyy6T
         Bj+9EM4qKpxOR2c8QXVWt84vUIqTK8hC6r/wH8wKf9a/5+fpiyFAkRfCwrZoLnwK37dE
         T5FUQk65TvFl+KjQ6LOiYJoBPvdHrt8A5LAJzjViFmneI1Z/PqHsdjIPgoKGNB/RZmzG
         yDfiCUYdVmEXnlTyEKGTf6nrHTAt0ISQfb5LWhvJW27aVen42l9tf+nZFwcZ4nF8P80Q
         a24jUVwqzuX+yFQOeBrh3V1Cln+ZybSizX3+efSlN2/XOvMYT70B1yKIjBizdjom5gD0
         bYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX17QmOF8UlFJHHl6RrIqXE/Go7tKk76NTjADn+nmClDfGeP/MYgN6jCQzZMN+BKDVK1srwCfM50WRb@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCvCnXq7J9gf8Y/umR7rRORRI3EBjMEP75xdIm5xVzqLKOIM3
	dNlbgkdlf/cbG3D6fapqiKiUWc2m7p+PyXeA3pINGHK258FDWzAjHhbyyzYQEwCTZYXm9QqE8Fz
	AQ7zonGi5voJSTOjV8iB1SyZgUY5kxSFDhoWFMPKUxoM6wEnLpgVaVlo2PrQ=
X-Gm-Gg: ASbGnctIEVmYDAPQsQxSkr7rTHiFCPvb6zHw7jlUQMzDG7YOjY5S1tJxYsJFGkj5KNo
	qj/hCR1EMd7bTnCDupTRusaX0Erex1KzDWsxZjK7HS/Ugrq2JV5g0BZizSRn389BazqFHDjvXiW
	NaR9HpyTdpp23N3tw2jHrUnPpfBcAFAWFAXlvSbHtl48En1b7Yz0d1cCzx+V7W6a/eDy2AjIqK2
	v3F107XSwlZCy5kv4ZVmPQSH9914Hi5P92CCck1GwAw+wwMLgJOLTeWDP5085r7ogD+i288Tlgk
	tG93ukNjeQ3Q
X-Received: by 2002:a05:651c:988:b0:30c:15b:1268 with SMTP id 38308e7fff4ca-30f0bf2dd00mr33421761fa.15.1744044921580;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYWY2hL2juUcMMBXHQzWMHhnwy4fPLxZdp5hY7xQD602JPS3wKfPW5WzTGnq7lmui6fdhOTw==
X-Received: by 2002:a05:651c:988:b0:30c:15b:1268 with SMTP id 38308e7fff4ca-30f0bf2dd00mr33421681fa.15.1744044921179;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0313f430sm16057451fa.36.2025.04.07.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E31619918DA; Mon, 07 Apr 2025 18:55:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 07 Apr 2025 18:53:28 +0200
Subject: [PATCH net-next v8 1/2] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-page-pool-track-dma-v8-1-da9500d4ba21@redhat.com>
References: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
In-Reply-To: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
 include/linux/mm.h                               | 21 +++++++++++++++++++++
 include/net/page_pool/types.h                    |  1 +
 mm/page_alloc.c                                  |  8 ++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 7 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f803e1c93590068d3a7829b0683be4af019266d1..5ce1b463b7a8dd7969e391618658d66f6e836cc1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,8 +707,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954bdccfe1e263d39a59bfd1d738ab6..6f9ef1634f75701ae0be146add1ea2c11beb6e48 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,4 +4248,25 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define VM_SEALED_SYSMAP	VM_NONE
 #endif
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
+ * the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~0x3UL
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
+
 #endif /* _LINUX_MM_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6cfc601e700ca08be20fb8281055..31e6c5c6724b1cffbf5ad2535b3eaee5dec54d9d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -264,6 +264,7 @@ void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
+
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd6b865cb1abfbd3d2ebd67cdaa5f86d92a62e14..a18340b3221835bc81a4db058e5b655575ef665c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -897,9 +897,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -926,10 +924,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
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
index 6cbf77bc61fce74c934628fd74b3a2cb7809e464..74a2d886a35b518d55b6d3cafcb8442212f9beee 100644
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
2.49.0


