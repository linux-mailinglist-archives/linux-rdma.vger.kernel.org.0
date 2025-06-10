Return-Path: <linux-rdma+bounces-11131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E7AD34BD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148F03A8F66
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CCA226CE7;
	Tue, 10 Jun 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkJr4faw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB1226533
	for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554173; cv=none; b=nnNdOAITCkjWvQ+av0HWKLtlJEdvfUHKkp5sQZkz5QTSuh6EPaL4LFF1Q48tjtXUZIBrUREgiwj0GlBr7bsp197GHBHCUk6axzhBXSi+sWru5vbNVkHhnIrxFgkgLGf3/6pJh57SXIzYZk6pqpgYx/6mMFE/QqMOLJTAbkijMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554173; c=relaxed/simple;
	bh=Pq58LFalI0G1zQzquQdKV8kMWEePGzvcw/jnWKRfvvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4XI+KETSgYtaHLdFqLsJVrdx4Xgtg/MDtKJglhrT5Axg0pTnSFsWFJIB02G0LSd+XbafmxR11fXVgp1GJOiLFBerOptWZfYNo7JNrAW6aKdjFRv772y7uzEAndvj/6BGvVhw/hVilI8nnQdKYJlrPYIDydUMIA5wMFMi9RIuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkJr4faw; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710fd2d0372so24169807b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554170; x=1750158970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRYdrxByQfviVMjn3PfJspn+iiLr6NbvXjzKXMXNGnw=;
        b=WkJr4faw7/WgrZ4DiFxmW4xIQOv8za+iao1hOKEeGPZIa43hR6Eg3PMrgOpoUSSeBz
         FrA3VP1I9wG/a+HFL7xoThaZAvsAQI7f/QOjNZcFVqupnIRCTLEEC+H32g7EzV/VxWx0
         PwNIOarldN3Go/atYWgQMH6lveSlS9FqV7JsgOa9mdr0y4FupnMZyv0BHdembghLooj/
         r721pOBJF2BS+li5IxOi8eW8md1Hozp4Be6HTb/JZ/0vjttQnwArG7O1KymFzWfWgIg/
         wN0HL3ivj7YNGN2BvTywz9RL7yBtyCNc1Us3HJhqjmKsVHBGH/Ddr5zrX3d4EUCBRYvx
         itOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554170; x=1750158970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRYdrxByQfviVMjn3PfJspn+iiLr6NbvXjzKXMXNGnw=;
        b=JepvaDcOOC+1QO4ZcaVEnPA19ZO5pWTUrpLR7aON9mNvwf1JQJ2XHB1VfWCqcMLC1P
         tHrZVzZGrrlS9MxrHO+BRlOqC2u2+jREChe0S3XIQOB2Ap0LnSnat0LTGgLNEDRpjZUe
         U4SwKnNKeQWde9cF/cQt6JOUOlE+u9Z+MYMAxRdYVkrNADoT9ZeXO0QzpyKf0plWVw1M
         WE0x0VfPRJ/B8DbBlE7SE5Hw5nRwAFxRLT+rltd7VFa/ZBjBVb7g6dPTjGkxvGfMSra7
         9nXhbAgQV/WbpXblq/tZg2HSMZduju3D6kSxqri0Ok8HqA5Bm8T5PgjkpZFwnLB6toPa
         SF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVr4DSMm/5ue5546WkFs0jI2MAw33imOK3sK4rVKtwaB2UEso4mS6Pnl33Dvup0grXxPxswlFQEXsXz@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3UmeOaZa2vFAASG7KM0OLmlJSVbxm25S+0on24WgJtZtjgbo
	q0QCjJdoBXzPTSFSVXGWa3tElNHkIUXfVfXN6pHOWvGa6Diny6kT7wcwYRMTKy9ZCBiDw3RMYcy
	ymTeJuGWx7fBxlJkpBSMsYvKon26EBU5eoOPSLwuLzA==
X-Gm-Gg: ASbGnctW6gSI3h0XRhw7jRcAGdAK5ebeVMMZ4mwnhwMjrRoVwuEpSvFWj2Wppmz4W9a
	1GgFQG5cHT6iuloUO7jd99Hf+tTo2olnWWAHZbWp4PvGfOI1UJlJZDM8AVsfukA5Ox+B0w1oTv5
	stf75bw8R93i8z3I0Q59Oyzvb9cZt0Z1t94vcQwRGcuLhX
X-Google-Smtp-Source: AGHT+IFiYu6L+0hOxUKTy81XogIL5OBe3zG8xFQH7UF6Pa7lD69xoMiBUt6KHLP9DHyWMKkzA1qKEvCm9OEUHUfS28M=
X-Received: by 2002:a05:690c:9b06:b0:70e:2804:9925 with SMTP id
 00721157ae682-711338b2842mr43149497b3.9.1749554170517; Tue, 10 Jun 2025
 04:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-3-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-3-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 14:15:34 +0300
X-Gm-Features: AX0GCFu56urTmOISlprLwgHXC6db0zVW3wr-lqRXXoQOUbGJ5t4MqPrNUZKW9wU
Message-ID: <CAC_iWjKn6y9ku6HE7CcdPT6jL8P2Ee92oN0joMN3aJv9UsG27Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 at 07:32, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4011eb305cee..460d11a31fbc 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -371,7 +371,7 @@ struct page_pool *page_pool_create(const struct page_=
pool_params *params)
>  }
>  EXPORT_SYMBOL(page_pool_create);
>
> -static void page_pool_return_page(struct page_pool *pool, netmem_ref net=
mem);
> +static void page_pool_return_netmem(struct page_pool *pool, netmem_ref n=
etmem);
>
>  static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool=
 *pool)
>  {
> @@ -409,7 +409,7 @@ static noinline netmem_ref page_pool_refill_alloc_cac=
he(struct page_pool *pool)
>                          * (2) break out to fallthrough to alloc_pages_no=
de.
>                          * This limit stress on page buddy alloactor.
>                          */
> -                       page_pool_return_page(pool, netmem);
> +                       page_pool_return_netmem(pool, netmem);
>                         alloc_stat_inc(pool, waive);
>                         netmem =3D 0;
>                         break;
> @@ -712,7 +712,7 @@ static __always_inline void __page_pool_release_page_=
dma(struct page_pool *pool,
>   * a regular page (that will eventually be returned to the normal
>   * page-allocator via put_page).
>   */
> -void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
> +static void page_pool_return_netmem(struct page_pool *pool, netmem_ref n=
etmem)
>  {
>         int count;
>         bool put;
> @@ -829,7 +829,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_r=
ef netmem,
>          * will be invoking put_page.
>          */
>         recycle_stat_inc(pool, released_refcnt);
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>
>         return 0;
>  }
> @@ -872,7 +872,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *p=
ool, netmem_ref netmem,
>         if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
>                 /* Cache full, fallback to free pages */
>                 recycle_stat_inc(pool, ring_full);
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>  EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
> @@ -915,7 +915,7 @@ static void page_pool_recycle_ring_bulk(struct page_p=
ool *pool,
>          * since put_page() with refcnt =3D=3D 1 can be an expensive oper=
ation.
>          */
>         for (; i < bulk_len; i++)
> -               page_pool_return_page(pool, bulk[i]);
> +               page_pool_return_netmem(pool, bulk[i]);
>  }
>
>  /**
> @@ -998,7 +998,7 @@ static netmem_ref page_pool_drain_frag(struct page_po=
ol *pool,
>                 return netmem;
>         }
>
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>         return 0;
>  }
>
> @@ -1012,7 +1012,7 @@ static void page_pool_free_frag(struct page_pool *p=
ool)
>         if (!netmem || page_pool_unref_netmem(netmem, drain_count))
>                 return;
>
> -       page_pool_return_page(pool, netmem);
> +       page_pool_return_netmem(pool, netmem);
>  }
>
>  netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
> @@ -1079,7 +1079,7 @@ static void page_pool_empty_ring(struct page_pool *=
pool)
>                         pr_crit("%s() page_pool refcnt %d violation\n",
>                                 __func__, netmem_ref_count(netmem));
>
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>
> @@ -1112,7 +1112,7 @@ static void page_pool_empty_alloc_cache_once(struct=
 page_pool *pool)
>          */
>         while (pool->alloc.count) {
>                 netmem =3D pool->alloc.cache[--pool->alloc.count];
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>
> @@ -1252,7 +1252,7 @@ void page_pool_update_nid(struct page_pool *pool, i=
nt new_nid)
>         /* Flush pool alloc cache, as refill will check NUMA node */
>         while (pool->alloc.count) {
>                 netmem =3D pool->alloc.cache[--pool->alloc.count];
> -               page_pool_return_page(pool, netmem);
> +               page_pool_return_netmem(pool, netmem);
>         }
>  }
>  EXPORT_SYMBOL(page_pool_update_nid);
> --
> 2.17.1
>

