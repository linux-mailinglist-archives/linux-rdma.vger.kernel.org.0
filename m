Return-Path: <linux-rdma+bounces-10803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91AAAC5FF9
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A217717AF6C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7641E32C3;
	Wed, 28 May 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBh6UFSx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513521DC997
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402368; cv=none; b=AT1sF7xp58oY5WwUAagnY5QpziCYxsfBbV9o2+QsrKQ03G7J59Th6czQ5pX/FE8Yn3p+e/hZuURwKGH4n4cafStdkC3F9uGLAj2Rqx4slovGkx9xM7nmZSZ+wrqgVWkpyBQHOTKt65ek92tmkIzsAIUCDwx9P6WgU5k9oa9/qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402368; c=relaxed/simple;
	bh=WqcUut7Uh6IFoCVTQzBZljWlhhZKI5JTjf2oc7UNTiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkFSMgnyxHyv93bW4dVQUDFcOx1iSWPknqRCYRc/M48/fjFAkxcevgqdQ3a8ts7urXpwz07P6x/rRfzJQf7t595LImdYjsS3t4rOQdYVETC/01RcPahwN7n0Mp36YhmXKTBaNMXaZPi6p5x3fmmPah60xXn+IYbZ2Uisi1zoByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBh6UFSx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so70765ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402367; x=1749007167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckbc5erWWTU5DVNbSyTtw3zIMaPaxLHk1njW0B9XZNI=;
        b=yBh6UFSxoaptUtmKLUpiiIXHD5L6dnNa2wArQMMi7FYSMNHGMU5idihtmhCPOLNuak
         ZAQktBnczjVuue5ABKH9WOqnYrv/zHHzv13vsLE2tWZLZm+8uoh82uK2spXIdCxoTT3t
         j4mj4HMtKlfJdyPyWmdjc37Aiji9QR84LFpbaqdVJXpfR8Jyu9U45gkfozEwLjtFgRg6
         pxTVyLy4svAHxh1u9XLOMfjlBk8uToCNINApCCEspSVHvs+74Es8wXnpCOOXRV+J4+j5
         QADTZzaXMG1KtWrn/aCZ7a/3M8OnDTz1pTTFk0+xh7BwS+D1gKWGKwMBUI8oVFT+1pTA
         K4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402367; x=1749007167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckbc5erWWTU5DVNbSyTtw3zIMaPaxLHk1njW0B9XZNI=;
        b=aYHMu1cGK5uLIfQaCTRyaVx4lh3AAsNihrZSNZG1wdmJIgY5r8EFGWoXPWYl9a+VmV
         fs7KJA4MALbm7JNALQwsmunLwpjyezONg+gD8BnbEH71SL5hzT+kap/lAADtPJ+XawwP
         Fo0nQaoPu2b4hui05ERzWMr/aXwfTCcXp3qNcV9ReO4Isqn8bFfUahfW0+tiFIJFozhn
         OoW7GCdOZ8/YpkOXL2IqYnu23ea3tPo8ifGCp/xTItpzV/hEFO7H3XxHJrM461FYwQmW
         KVDu/5olWfvsLY4NUku476xqY6KAFo6C5onfuWmLCMgWMG2qtYNrja6wpMciZ0IuP5IU
         Rxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXWdhExlJjwCuY3zLjRuhJH8AGRNy7sYdR6tfdgKtOej4ulrHAqCW+o9mFohVa7fuBx11jtjdclW8FC@vger.kernel.org
X-Gm-Message-State: AOJu0YxDK8LyRV1KdOYynHRGkqcTvdNHN1i32i+tlZHpr4Rpj4+QP0s4
	lvOoFmB+AIO332l0Bjvl0sjuW2xRdbEiUj/pVkWiTZ8GyP5aHVvi57WjhyH0LcXCxHohyq4Fzu2
	BiGO3fugOlOcEWKt0s0TDNaU41F2xHdTVm89P/cOI
X-Gm-Gg: ASbGncvqrAOripiwz2s+6Xsmxbvcd7jabhNzgvpXeFkjiG+zvWeaG6++uXhzPS7Ste7
	QdbgonBQWMPVB4ql7EM6NCD4uu8k3LxZhCoCOIUYAuuVPujfXWdrz+viLiDxBPYYgLsbtlx4Yrh
	b07z70gcNfkCdUN5Nbt8/kOl9ADHW4vWYGUmtw4+uk91qb
X-Google-Smtp-Source: AGHT+IHzKv4vl5a+TBuv6dmOrk3OjFYKjtBWg3LPXvPu2uRbrhu1w2zFUqDX9TMsKiHX67noNgYjWOe7sB2HYbypdAI=
X-Received: by 2002:a17:902:f641:b0:234:bf4:98ba with SMTP id
 d9443c01a7336-234c534cc66mr1628865ad.6.1748402366370; Tue, 27 May 2025
 20:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-8-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-8-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:19:13 -0700
X-Gm-Features: AX0GCFu8nwxheVYTgVQh0YpzLPLEu-yPdp50ge0yNj9j14UdYtJf-iaH_MWsx1g
Message-ID: <CAHS8izNnCYOo_bUnfpUXoh5Dqg0=cDKfZP4=BbukZMJN2SPUdg@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] page_pool: use netmem put API in page_pool_return_netmem()
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
> Use netmem put API, put_netmem(), instead of put_page() in
> page_pool_return_netmem().
>
> While at it, delete #include <linux/mm.h> since the last put_page() in
> page_pool.c has been just removed with this patch.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  net/core/page_pool.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 8d52363f37cc..fb487013ef00 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -20,7 +20,6 @@
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/page-flags.h>
> -#include <linux/mm.h> /* for put_page() */
>  #include <linux/poison.h>
>  #include <linux/ethtool.h>
>  #include <linux/netdevice.h>
> @@ -712,7 +711,7 @@ static __always_inline void __page_pool_release_page_=
dma(struct page_pool *pool,
>  /* Disconnects a page (from a page_pool).  API users can have a need
>   * to disconnect a page (from a page_pool), to allow it to be used as
>   * a regular page (that will eventually be returned to the normal
> - * page-allocator via put_page).
> + * page-allocator via put_netmem() and then put_page()).

nit: I think the "and then put_page()" is not needed.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

