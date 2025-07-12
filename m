Return-Path: <linux-rdma+bounces-12070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA3B02B86
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC67A40767
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6420285404;
	Sat, 12 Jul 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBaLs5Jj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB0275B12
	for <linux-rdma@vger.kernel.org>; Sat, 12 Jul 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331976; cv=none; b=qetGFHjlkKHYi/1jAp5M8mRFreNQuHcnkyQT1AwF90atUtSPMQ0DKSSDRXkBdnt0ISH4/N+mZ2QaUbIiRt/ORBCKuh4eFnqO32EZnTTY2+ryUk07c2y0iQLaw/0xHHn0KWnd5lDdvPSHvkC2dNcLpUutc+nqmllfF+gl4BQgY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331976; c=relaxed/simple;
	bh=TP72Vt69VONP6rjYxB9pwcH0goxX1aelLVIyintpX20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxqHdEKpcTViAPkKNd9dI7tWZIMu0rNu0/vvme2/ixPIK2/36ly6wgOkBx6KnNcwTaqW9yGy1eRxqQmpy7AJ/yJVFJBz15Bgv5/YYahzs/Vm8REhqOx1a/XxZlRW0rAI8nCIsCLWk6Fnqppr6aAPBZ0hmOXO/HeTfLCmkbdut28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBaLs5Jj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752331973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HWccxkCXxuajKrmAuU1sLkFm+tfKnJGEInwGIoGkUmU=;
	b=HBaLs5JjeRhciZIwjRdCndYlnfei9/J5B3+mgvDsVnEpfQdLQF0LruUvtudD+PLTBExFt6
	4F5A0Ze4W9gD82PxqYz9eBhUhx8aUj5Z3ZUo1CU6WrzD6aZuX3X32/fcxkSbHR6nh1FJ2U
	ARqGi4IOP3fNFXeepgc+mPr8rCx+ub8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-wxH1Y0ktOuyaP4YJ-hhRpw-1; Sat, 12 Jul 2025 10:52:51 -0400
X-MC-Unique: wxH1Y0ktOuyaP4YJ-hhRpw-1
X-Mimecast-MFC-AGG-ID: wxH1Y0ktOuyaP4YJ-hhRpw_1752331971
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso16809935e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 12 Jul 2025 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752331971; x=1752936771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HWccxkCXxuajKrmAuU1sLkFm+tfKnJGEInwGIoGkUmU=;
        b=nbLG90Uw/+yrKgukSJX+HpvLX65UgAItK6v8UJ0WJsxcAhyNKi/sb3K3H2lU+H0UPh
         Q2F7FcjrKhiPqqG/Hes5AAKzbuFGZI8Rj3v0zjLut7H+1M0tgYA9lgulcc9Ut5B7kEDU
         tBeqnqIWfzrQienllwruyRsfMlMgycEB304hgjyN0AHlQn28SX1hJe+M5w2Yoenkw8/d
         tzex+QKz6MzE5B98BsJhilDCNsi+z8AQei4QWcxeRLZu91TsLk2O1q2+TEKxL+QSPwsy
         hsKEHfr8HznruRGU2ZMpZU7bgW90qtmxVlxtcVoZscnoV4OmRv9flOTxNpSB3ymr7+eL
         cTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBveyqqZ4I8J8te8oyx6aE05Cc7LKwFcv/cK3aaHLDWP02xWIFsAiPlLtZC7D+L6zX6lKDsF0m/kSz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbat+I8xY2LvDJJnMZWgn6d1q96UjQ5gZDXh8HqY9G4g7iSOu5
	hovsiPKvPFxeLBxeh49dDJZPF4DJazGYkGhqGtFcOOjQMR0dfVgNpFyw4X7pcOM2o19cZ67xDYo
	hykBt36lSg68yTC2qmbMHgxf30T2so556XCFexytSuNeAoUJcN042g1zFsGct+lo=
X-Gm-Gg: ASbGncstOrxsyTA+EXr6snWHA3d3kRWLWj4eCCbADGZdAdQwyBGmc0azyYRImWyHRUs
	8o9xLMMFms9B/fz7iD2E69UraESzDJrVN7CvYIwvlcBD4qw71Kh7GdVB+BZGMdIEi9UwmYVKC3E
	LvQ0ruNVS+Br4gg62r4ip/Mm4xBhnCknBgolLRBtnbyZiyUUNu9GcmYQB6xXm6uYBGpK3Ergxi7
	cJSgmYARYns5DsyULgZ9O4Md3XyJDEMoxZQn9LmJbOYJr1RDs4yK0r1zzgBpADWA+cYQfAnwceY
	PUbEDiSejcgK0GJbwHLTn8Ryb/0xhAAQMK/V8Ynw0qJmx38/hy3/VU1P8bIopLjdkBstN4P7P79
	oVG/+Xm+h2IG908xRwirsEnLsIvNiTyhwPfoMV6opvT6/TCglkfyqNsCjier/k7475+Q=
X-Received: by 2002:a05:600c:3e83:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-454db8d8d06mr112045055e9.16.1752331970666;
        Sat, 12 Jul 2025 07:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI0Jdvn0mZ+OKJIfLwFbj8UH/AqPLNeecxxGrUnR0H54nG4V7l4C2eBcDE8jXu8TJAJaFkMw==
X-Received: by 2002:a05:600c:3e83:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-454db8d8d06mr112044665e9.16.1752331970078;
        Sat, 12 Jul 2025 07:52:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:f800:2113:1f36:a0b7:668a? (p200300d82f23f80021131f36a0b7668a.dip0.t-ipconnect.de. [2003:d8:2f23:f800:2113:1f36:a0b7:668a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560dda2263sm8517455e9.1.2025.07.12.07.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 07:52:49 -0700 (PDT)
Message-ID: <3acd967e-30b3-4e76-9e1b-41c1e19d4f31@redhat.com>
Date: Sat, 12 Jul 2025 16:52:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Pavel Begunkov <asml.silence@gmail.com>, Byungchul Park
 <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>,
 "willy@infradead.org" <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.07.25 15:58, Pavel Begunkov wrote:
> On 7/11/25 02:14, Byungchul Park wrote:
> ...>>> +#ifdef CONFIG_PAGE_POOL
>>>> +/* XXX: This would better be moved to mm, once mm gets its way to
>>>> + * identify the type of page for page pool.
>>>> + */
>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>> +{
>>>> +       struct netmem_desc *desc = page_to_nmdesc(page);
>>>> +
>>>> +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>> +}
>>>
>>> pages can be pp pages (where they have pp fields inside of them) or
>>> non-pp pages (where they don't have pp fields inside them, because
>>> they were never allocated from the page_pool).
>>>
>>> Casting a page to a netmem_desc, and then checking if the page was a
>>> pp page doesn't makes sense to me on a fundamental level. The
>>> netmem_desc is only valid if the page was a pp page in the first
>>> place. Maybe page_to_nmdesc should reject the cast if the page is not
>>> a pp page or something.
>>
>> Right, as you already know, the current mainline code already has the
>> same problem but we've been using the werid way so far, in other words,
>> mm code is checking if it's a pp page or not by using ->pp_magic, but
>> it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
>>
>> Both the mainline code and this patch can make sense *only if* it's
>> actually a pp page.  It's unevitable until mm provides a way to identify
>> the type of page for page pool.  Thoughts?
> Question to mm folks, can we add a new PGTY for page pool and use
> that to filter page pool originated pages? Like in the incomplete
> and untested diff below?

https://lore.kernel.org/all/77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com/

We then want to do (on top of mm/mm-unstable)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa09154a799c6..cb90d6a3fd9d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page 
*page,
  #ifdef CONFIG_MEMCG
                         page->memcg_data |
  #endif
-                       page_pool_page_is_pp(page) |
                         (page->flags & check_flags)))
                 return false;

@@ -1069,8 +1068,6 @@ static const char *page_bad_reason(struct page 
*page, unsigned long flags)
         if (unlikely(page->memcg_data))
                 bad_reason = "page still charged to cgroup";
  #endif
-       if (unlikely(page_pool_page_is_pp(page)))
-               bad_reason = "page_pool leak";
         return bad_reason;
  }

@@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct 
page *page,
                 mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
                 folio->mapping = NULL;
         }
-       if (unlikely(page_has_type(page)))
+       if (unlikely(page_has_type(page))) {
+               WARN_ON_ONCE(PageNetpp(page));
                 /* Reset the page_type (which overlays _mapcount) */
                 page->page_type = UINT_MAX;
+       }

         if (is_check_pages_enabled()) {
                 if (free_page_is_bad(page))


> 
> 
> commit 8fc2347fb3ff4a3fc7929c70a5a21e1128935d4a
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Sat Jul 12 14:29:52 2025 +0100
> 
>       net/mm: use PGTY for tracking page pool pages
>       
>       Currently, we use page->pp_magic to determine whether a page belongs to
>       a page pool. It's not ideal as the field is aliased with other page
>       types, and thus needs to to rely on elaborated rules to work. Add a new
>       page type for page pool.
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..975a013f1f17 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4175,7 +4175,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>    #ifdef CONFIG_PAGE_POOL
>    static inline bool page_pool_page_is_pp(struct page *page)
>    {
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	return PageNetpp(page);
>    }
>    #else
>    static inline bool page_pool_page_is_pp(struct page *page)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b..9bd1dfded2fc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>    	PGTY_zsmalloc		= 0xf6,
>    	PGTY_unaccepted		= 0xf7,
>    	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_netpp		= 0xf9,
>    
>    	PGTY_mapcount_underflow = 0xff
>    };
> @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>    PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>    FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>    
> +/*
> + * Marks page_pool allocated pages
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>    /**
>     * PageHuge - Determine if the page belongs to hugetlbfs
>     * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index de1d95f04076..20f5dbb08149 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -113,6 +113,8 @@ static inline bool netmem_is_net_iov(const netmem_ref netmem)
>     */
>    static inline struct page *__netmem_to_page(netmem_ref netmem)
>    {
> +	DEBUG_NET_WARN_ON_ONCE(netmem_is_net_iov(netmem));
> +
>    	return (__force struct page *)netmem;
>    }
>    
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..e38c64da1a78 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -13,16 +13,11 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>    	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
>    }
>    
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> -
> -	__netmem_clear_lsb(netmem)->pp_magic = 0;
> -}
> -
>    static inline bool netmem_is_pp(netmem_ref netmem)
>    {
> -	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	if (netmem_is_net_iov(netmem))
> +		return true;
> +	return page_pool_page_is_pp(netmem_to_page(netmem));
>    }
>    
>    static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 05e2e22a8f7c..52120e2912a6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -371,6 +371,13 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>    }
>    EXPORT_SYMBOL(page_pool_create);
>    
> +static void page_pool_set_page_pp_info(struct page_pool *pool,
> +				       struct page *page)
> +{
> +	__SetPageNetpp(page);
> +	page_pool_set_pp_info(page_to_netmem(page));
> +}
> +
>    static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem);
>    
>    static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
> @@ -534,7 +541,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>    	}
>    
>    	alloc_stat_inc(pool, slow_high_order);
> -	page_pool_set_pp_info(pool, page_to_netmem(page));
> +	page_pool_set_page_pp_info(pool, page);
>    
>    	/* Track how many pages are held 'in-flight' */
>    	pool->pages_state_hold_cnt++;
> @@ -579,7 +586,7 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
>    			continue;
>    		}
>    
> -		page_pool_set_pp_info(pool, netmem);
> +		page_pool_set_page_pp_info(pool, __netmem_to_page(netmem));
>    		pool->alloc.cache[pool->alloc.count++] = netmem;
>    		/* Track how many pages are held 'in-flight' */
>    		pool->pages_state_hold_cnt++;
> @@ -654,7 +661,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>    void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>    {
>    	netmem_set_pp(netmem, pool);
> -	netmem_or_pp_magic(netmem, PP_SIGNATURE);
>    
>    	/* Ensuring all pages have been split into one fragment initially:
>    	 * page_pool_set_pp_info() is only called once for every page when it
> @@ -669,7 +675,6 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>    
>    void page_pool_clear_pp_info(netmem_ref netmem)
>    {
> -	netmem_clear_pp_magic(netmem);
>    	netmem_set_pp(netmem, NULL);
>    }
>    
> @@ -730,8 +735,11 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
>    	trace_page_pool_state_release(pool, netmem, count);
>    
>    	if (put) {
> +		struct page *page = netmem_to_page(netmem);
> +
>    		page_pool_clear_pp_info(netmem);
> -		put_page(netmem_to_page(netmem));
> +		__ClearPageNetpp(page);
> +		put_page(page);
>    	}
>    	/* An optimization would be to call __free_pages(page, pool->p.order)
>    	 * knowing page is not part of page-cache (thus avoiding a
> 


-- 
Cheers,

David / dhildenb


