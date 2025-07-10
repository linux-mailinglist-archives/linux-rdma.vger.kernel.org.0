Return-Path: <linux-rdma+bounces-12041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713ADB00B3A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5965118993C8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699C2FCE08;
	Thu, 10 Jul 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVTsrauV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182752EF9DF
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171608; cv=none; b=JLE/pPgYRd43ojpEBe25VSOuJI998rslXLWTSwoMyjl5TTEPes8gmG00dWmgdlCfw1CAFPy1Kt2gl39tvUtcD12lvte7X3YlkUjp8JKpht0lus4At7bfzQP0OxepjC7H3Vhwhlm2xy6mXkOSRggU+Axx+4sJGJsrO0xt5eDBEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171608; c=relaxed/simple;
	bh=EPb99Ej9S7eTJEfY1Nzk/x3khOnYOd7XdYVqfG7FoJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf3l/DMh5ylqXiaLtd/P17FbDUSQFVIT+3M8WwJDR1/nrmOK2slW0CBkGPNbLcr3bH+t/Zx8spolCwleb15JNGqHrN/RpCihYla5BPhji9TfnfkMlZgo25SIdtaQs9IPyHxL/9RdgFQgTlZs3T3+HkUj6U1x2FaukDq4wOl3dws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVTsrauV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2357c61cda7so22975ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171606; x=1752776406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj46vkefhs4SRIRS/QU5g/lyrMXzFbGQlucGo0/msd8=;
        b=aVTsrauVNuKpK9aafet69r3jPNTQoC2Xc0YUgkx/B35Jxv8F0Fy4jS1RiJp9dK/3j6
         CbfDww2dCKMRktYkMSRpLfVDUTJbQu0BKAfK+PPbsHD74oERvK6ZG2gtOmgga5bm6T8H
         ruoSDy1aV6Q34ohrHP1GOD0H/8NChnHJOC1bCIhchiRT4Dg5TkSnYU/DM7nf4CMuQZ9i
         vrNPoFwc/6+EkdcycRocjHzQIQ0rK2fzm6bz4ymjllZWaxyDP6EDImQIoHQV/5yaMxvS
         KBK2n8chtEhCKJidQpPIQazll1I6andpOc9PZkZlS3EUgag365LQjV57tPqdjGarFE0/
         Jy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171606; x=1752776406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj46vkefhs4SRIRS/QU5g/lyrMXzFbGQlucGo0/msd8=;
        b=SEeT0+wbJXT0FbHo///TA6GbWQAaWt/pE0oSZ2rAVMmz6RP2IxkBlJOR2ZvQ77pgAa
         Vj4LA9aEcl1Nb7JXY9RM74/X5KDGjLyfBdmGqnhzuy2QvqRg+/st+KoukW7R/qQmJbtI
         PH16N4fxXVLUDVktKkE20ezmTCJ15uyE4IjD7Nb8OcMLsUD/bsuHLjsJpWNM9+E6vP/x
         /SkzatD1Vs84yrrLfNjO1pbzcBKuHrTRK8dGz70T+tlC79YC+l3JX3RtmSqg63OswAnH
         ptjr+OkZdMMlGIWNNdgEcE2lGY6h+YCCYfiKNGKRWO38duTN3opycXAKrh7pCasBhikB
         tOdg==
X-Forwarded-Encrypted: i=1; AJvYcCXo18W98XXkGiF5cl2+kIdWNUBOFHrip5mDhMZMCsGdIYxw4CRrtonyjXPAPnVLTaCjN8kizGUqEjjW@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhMu5FX84y2NV8v1+NeLMtjsTB6aU+PToBhJiX/WqVEKBDro1
	e8qCvI6EV2zYhwS+S+FYIQi3TIKAOxV0Er3uBW8WqMZrdhLUoQiuLVXoW9PIKYEqgQCgGNOyaY+
	2f1nmdL+HTUZDn9oFirT7QyzQXrJZY4CJhSx2ck1a
X-Gm-Gg: ASbGncsdcNNKh4iMCUpgC4AgqirVhHl4YZvBD8Iz9BYSGyqend6w0dfTzxmLnHM0Nh5
	7FjAvsRMjT6aZwZ6YPLH/IcFHXnnKii10/PNupzK0/5W1eGO/jFYPu65yfMdXIuGLwVJs6n/PeJ
	BaxKCUbC9pjbpyfU6ZXjyONx9NhZjkDxuFx8hlQsHmA1wI0n9w1D9iYhbdkCyLseeMgDqqh8s=
X-Google-Smtp-Source: AGHT+IEnsQr2vt1xRK9+Gg05s9Ioj58hP/Frug0vVmNYyI/waR29AKDxjbFsuLIHKriJNaWLDKD8Qv90dKQTUZAuhEc=
X-Received: by 2002:a17:902:d4c1:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-23dee4c480fmr119455ad.5.1752171605810; Thu, 10 Jul 2025
 11:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-4-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:19:53 -0700
X-Gm-Features: Ac12FXw53iJ9LLYfmK6k3qWagqoxpTOfsxU_34s2pmiydSWa2zOUfuaE-4Qlaes
Message-ID: <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/mm.h   | 12 ------------
>  include/net/netmem.h | 17 +++++++++++++++++
>  mm/page_alloc.c      |  1 +
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..0b7f7f998085 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index ad9444be229a..11e9de45efcb 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -355,6 +355,23 @@ static inline void *nmdesc_address(struct netmem_des=
c *nmdesc)
>         return page_address(nmdesc_to_page(nmdesc));
>  }
>
> +#ifdef CONFIG_PAGE_POOL
> +/* XXX: This would better be moved to mm, once mm gets its way to
> + * identify the type of page for page pool.
> + */
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       struct netmem_desc *desc =3D page_to_nmdesc(page);
> +
> +       return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}

pages can be pp pages (where they have pp fields inside of them) or
non-pp pages (where they don't have pp fields inside them, because
they were never allocated from the page_pool).

Casting a page to a netmem_desc, and then checking if the page was a
pp page doesn't makes sense to me on a fundamental level. The
netmem_desc is only valid if the page was a pp page in the first
place. Maybe page_to_nmdesc should reject the cast if the page is not
a pp page or something.

--=20
Thanks,
Mina

