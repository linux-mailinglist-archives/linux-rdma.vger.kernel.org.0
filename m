Return-Path: <linux-rdma+bounces-11130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E933AD34AB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19E5169E2E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295728DF4C;
	Tue, 10 Jun 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sf9ftl8t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A628DF37
	for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553953; cv=none; b=bVh21CkEAioS9ppygZMb3jiKNWS/su4UtnQ1jWAdsbKBF7Q9iHoH62dUc4ZFkXSL9m0vTVaZvbOBajG/LeiLbCYfACd/08am30W+QGSdtXCHvz9AYCFnB+vl9nCaKEJQcxi5LOurqDwyCcN5StJHX+iDuMG96szkWENeJX97Iew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553953; c=relaxed/simple;
	bh=bVBYTD4v+/Ier+Ih6qhzzgjDmtl/7PTYTLiH0yhjTJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la5Qt1/YTlu9zHDQdL9QhLAylgwKqhu00P7FPFWwfVL0TcPX8qHfH3S3CLjzryY4NNGFOVy6RZLpKEX7/ReQEb6wrm9LqnhSB6vP3wtlPk2ugWcHladqlKO9yQhdlizOTe4qRdjIrOQyXM/xVEL2PyRwDUhfYAgLAZqAiolfG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sf9ftl8t; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70f862dbeaeso53609667b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jun 2025 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749553950; x=1750158750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGJoap/WPosW06fDBcr7SQqlOi1DYaMmMX1oaY7kRo8=;
        b=Sf9ftl8tNkdDyvMWCnAzzm/hw+2pgqq6esUgXlU6Be6xD3AnLrrD3k+1rkNZ9iIZBG
         /O+wyaDOjO8Az8v1JZd8IWbB4P3B2CS/hGVvtg9IM3nSWr8jtBw5FezH1njk4cPnyB0j
         iWMXbl7NAlVbuvjlTlLGnTdHXwW9E1rUflKEWH7V/Nkf3yTx+bVWIUscccKFY/FCwrGL
         non1QN3ApzQQpfELVeEhKEgxel75BejUWtc5yF3jasPUyHU73ua/W5betIcfBAo19haI
         d/xzBZ0oMqJCKhM1/x6GyUvtLXiV+Wr6R43xwKtDsB1ynfM7rUDPMn8hzXFKq+nioCki
         YM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553950; x=1750158750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGJoap/WPosW06fDBcr7SQqlOi1DYaMmMX1oaY7kRo8=;
        b=lGU/vEzT3jsNMwq02zGC/q/T3iICfkxk2j2+QaCGg4Kq3ylnbltJblCIOS70ZkcQrP
         0uaByaQatcUVG+y20qaw28CoVkf1+fa5BxNdJm3g+b7iNpVP9avojcV7djVae0Vn2Udz
         YvlGpLWaSSAJEplrtk1ucQWD0Pgv1/rUismdWkqRbpwjCJvnLJ5AI1TlofjmbpdVJkHC
         CJvXfiSH4K0tfnPmsV4kYQydM01ZCELnxElT6eGJW3iDzMiOpw0C6aWtyE9qqnKQlSqU
         pQs8IvCZYEsMexsRhZFhtxXBZYUuoN3w30H8Qltyl+N8Y92sPHIN/viskCmaFSsJunIm
         uoGA==
X-Forwarded-Encrypted: i=1; AJvYcCWUvweEqQTbR+H8OkYE6jOmDVOt6M91dN+EWA6C8Q0jdNBJrcHC2GTzTzqrdJYWlK+FckEjewNQv4eG@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdVvbKQTTp7oZjHDrl+aYBho2Vass1gS46GXTGLA/lRdGrxbo
	TB47VIU46NP1n0vX+n2Uc1vH+dqmM+04BDzpZcwtwBwn5kcp37D1Dx2fFMicOkW+fbmmJFQJt/I
	3htfi+8xb2MoIyslFIhG1ikB4/ioVMrxEP3vajU4Ysw==
X-Gm-Gg: ASbGncvyX6z9m9Yq6KWg+BnnMC9zTnFLXPVV5jACckJxQHymOP8M0uEyWZRzLCu6bLP
	GYEXtiAx5ny1lhgfhWdoY0mTw6QE6WigMY2A9Fu6oF2S4UJfs8QnoAANDiaops8e3aHFBVlpwDU
	Hpp8d6HMJz79wVxhbFIEO/5GQ+2eCPVnsQ6k5eYlkiFsGg
X-Google-Smtp-Source: AGHT+IG8zsawN3xDkIiHoqtoDeuKT1Bq9JS9Q1xXDw1TdS7PPhQJHt3vukBAJDXQ5rpuyqj39qP+g+huLdHgKtWsHJA=
X-Received: by 2002:a05:690c:6d12:b0:70e:2d1a:82b8 with SMTP id
 00721157ae682-710f772b158mr238734027b3.34.1749553950407; Tue, 10 Jun 2025
 04:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-4-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-4-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 14:11:54 +0300
X-Gm-Features: AX0GCFsoN4Lw-oBn0iS9Ed66FhTtsA-gk57hCRDoaANAiIafqJARqdL3Be-QVJk
Message-ID: <CAC_iWjJQ7k2drnPZh8bjaLvVa9rd2mLw7_=L3hV3scnWBQBvRQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
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
> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 460d11a31fbc..8d44d1abfaef 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -673,8 +673,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
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
> @@ -721,7 +721,7 @@ static void page_pool_return_netmem(struct page_pool =
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
> @@ -1139,7 +1139,7 @@ static void page_pool_scrub(struct page_pool *pool)
>                 }
>
>                 xa_for_each(&pool->dma_mapped, id, ptr)
> -                       __page_pool_release_page_dma(pool, page_to_netmem=
(ptr));
> +                       __page_pool_release_netmem_dma(pool, page_to_netm=
em((struct page *)ptr));
>         }
>
>         /* No more consumers should exist, but producers could still
> --
> 2.17.1
>

