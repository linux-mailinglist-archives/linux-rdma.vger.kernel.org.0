Return-Path: <linux-rdma+bounces-10804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FCAC6000
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA23F3AE913
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87F1E834E;
	Wed, 28 May 2025 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0d1Qa5uG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5041DF273
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402509; cv=none; b=V40z12YQBAWx4/Ylv8NjEF9Vl0wg9OjSgL/tR+h0tD5kWoEGwTwagHM3QhAG+l1bcGkQsyrHfUJe1VoZ2pKhR13knCody3xSPhhd+DjuJHFVxfSZXkw8PDQrELr9ntiJX4n3HXtEYJVpBN+IVQHGfZdd25crfvlBz8hw1Eq8ELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402509; c=relaxed/simple;
	bh=NCjG12I8e9v4tbFYWsDY0jzDx/gYU5XqMSNRRjnDooE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFlmw9QvAshyOvUjGWKtjT6I6ChmOWK+cNBmuaodAlAUsX4GAfF+IAFlfH3BXS71MHHAPG1GXgJojFAbSWBSjMTbCciGYgSNxG+AkGlTOeBVqWUuXHEbXSHSt5RJJK75iYKgJeCJ/7oaek0HzBs3sT+pWNE6br8ynXmYDAecLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0d1Qa5uG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2348a45fc73so108025ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402506; x=1749007306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhQg5ilX/7ks5QXGrPE6JGn51EXjxRWzA8aArpEVP8o=;
        b=0d1Qa5uGmSoUTHlwR2KqteuJH/C36jiGYEJEqY1hCEEA/pi1+q9moPlQJDbkDMUV3p
         2wYOqbO8duI/ZbnjxIGat5VLNAyXAqGXI3IQaUaWATnbjB5EeUmsumvh0ydB1+7I+3Sv
         n2jc4+kAXWUcg9zjk7CcRd9jziT8cGLvaVX6xaZRVlG593jZVpR98mRorOv3WmdkDeoL
         fzdNsnxly4+wsN9EYrPdEB33lDRTwkiE70n+/3NKdxLG7MoR0Rl1xdZDLJbVoA8uK5rl
         s1m9VJn6zPN/cQk3d8J884MdaBIh2iJGhdKfN0MzK+3k8d0tIFeqr26fdrj2PBtTuhVA
         hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402506; x=1749007306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhQg5ilX/7ks5QXGrPE6JGn51EXjxRWzA8aArpEVP8o=;
        b=t2T/n+VqRHvP4djQqI2CRXF+jkQZg8eFfOUqr/s/YcfjvAe+GOo1OCy7qwiRj4W40b
         F83E2dIFK67B2ELoHo8gXxv1KqAZ72ZiQB6/7A+8my+g1UbA+qxglZF6XBoKuAWGGa90
         rGE3Key6hYkc6AS6cFGmxj93A2sZGVnbN0X0qlmc6KbzriqB+pSPgVjVuQ4usadFmGaM
         sFh+FbU53vvuEmKwwC5ayEFjPR4AwaI2dgvGOIEWr2cVF/eWVJLAX1AcW0Uv3E8ymWZg
         k5nrP9ynr+d76aM416HHeLX64ZPBOgvK1LWa4EKG0J+7hDAY/Eo+LaG1OtAtl6i7mqs+
         C1lw==
X-Forwarded-Encrypted: i=1; AJvYcCW8jDxm2DXypNxEsTCd00SJYEgEYgGHK5V5ePBLVYPdCLXQq8btgEzPork3DSt2wtwVQU+kzg2z6SiR@vger.kernel.org
X-Gm-Message-State: AOJu0YzO68nYiHVZwKrPSDJ9jAiNzet6Prg1PiOX5vZnv2+Oz3KRJ0xP
	kEOu/ePNXWyKGlCutpbNIkwu//E/Heq6qURiFpKnCUd3WQXjlmaVLIH33R6AUsN+9phJXtC1Cn0
	YNf6OTGgeWFZ94byv9rVuyxfy4dhyLl3l9PssuREL
X-Gm-Gg: ASbGncuq6+E00GYoGUoZvi5bfV/8i9gEa0RtneZgPIts0VGoJUTiAf4lobc3CL4cAVI
	COO5UpX1C3RMCprKR0OpL9MR6HZYESo2pF5Rrf/Na1veQZJZJGz3HEB3xLmwJhD6D5//3RpIgoX
	zhFBP54l64w4l5IQQNpRXzD6hSNLjPDdbxQHFtfujlYBb/
X-Google-Smtp-Source: AGHT+IGZGnQ5Nmgjax4hfouh4pp4GgqporWXwvbytliAh+njgVO1gpTaYGIF9zH1gwkhGw9nWKCJTA0EdVPWxStUTNs=
X-Received: by 2002:a17:902:d4c2:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-234cbe4f90fmr1102095ad.25.1748402505375; Tue, 27 May 2025
 20:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-9-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-9-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:21:32 -0700
X-Gm-Features: AX0GCFuYtIrmK-Wu9BHLQmtJy90lb0ReYg5ZuhjcJ5k8V6K_B7GDLKrd1odKdxE
Message-ID: <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/page_pool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index fb487013ef00..af889671df23 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
>         netmem_set_pp(netmem, NULL);
>  }
>
> -static __always_inline void __page_pool_release_page_dma(struct page_poo=
l *pool,
> -                                                        netmem_ref netme=
m)
> +static __always_inline void __page_pool_release_netmem_dma(struct page_p=
ool *pool,
> +                                                          netmem_ref net=
mem)
>  {
>         struct page *old, *page =3D netmem_to_page(netmem);
>         unsigned long id;
> @@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_pool =
*pool, netmem_ref netmem)
>         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
>                 put =3D pool->mp_ops->release_netmem(pool, netmem);
>         else
> -               __page_pool_release_page_dma(pool, netmem);
> +               __page_pool_release_netmem_dma(pool, netmem);
>
>         /* This may be the last page returned, releasing the pool, so
>          * it is not safe to reference pool afterwards.
> @@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *pool)
>                 }
>
>                 xa_for_each(&pool->dma_mapped, id, ptr)
> -                       __page_pool_release_page_dma(pool, page_to_netmem=
(ptr));
> +                       __page_pool_release_netmem_dma(pool, page_to_netm=
em((struct page *)ptr));

I think this needs to remain page_to_netmem(). This static cast should
generate a compiler warning since netmem_ref is a __bitwise.

--=20
Thanks,
Mina

