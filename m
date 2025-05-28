Return-Path: <linux-rdma+bounces-10809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE19AC6029
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 05:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AADB17F5B6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069301EB9FA;
	Wed, 28 May 2025 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5rWwBqq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B401EA7C4
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403598; cv=none; b=aH9NJdIsHCtfpsS8WulLE0Zp0WYhkJ3paB4WTBjDwXIJJil27RS9FvBcaHpYbpQYuc/ZEnoV2zXF5ZExEIJF2FPGlpawi5gyZStd+Hqewz1jEeZ7zWmmXq6sCZHKP2x4FaMbmOX4dKHuQB41GFRwCb/cpfYOL6Oras67wVydvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403598; c=relaxed/simple;
	bh=GwW69SNTqzGr2OriqqPYYKEoROS1fPdGoQyps42QbuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZud+WFUbNcvuboDh6NxBtP9eqTHvBqws9p7U2CLnlaOMMoch7TDNZBb7UpDNQVMTHDiz/SP8c2Eqtqr1PHijkRVTuJkcUPJBGInYJtp4huDohujfg1vScnRZhKdhglTjjXc/rdQMcLxUfhO9U+dIyYnNqV+VjsqXp4yKzTT1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5rWwBqq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231ba6da557so84215ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748403596; x=1749008396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzMo1es6YzCF+mytak0KHHshSSIz5JiRwR0oN2yEmjI=;
        b=T5rWwBqqvPuS46f/n6mFL3gALohXauq2L+hQ0fCRUhcz4CAOsySFB3hbDHMZP/YYD6
         GSn98SsHOp1evSoGSw/vKpDzSlhhk9XIXf4eWkx1vJb1XfiQvbfYHiZNuu01BD86jL1B
         W6y2uQV8/JdZrWqW90sTuXsP6vG1AeLqbYUmnCJzdMPcwMvAJpdUsRiuxaxrXBuTB/AU
         tJ5bX5jJ4C2O7o0m+NF/vjrTG1qWlXSefDCtvUpyHnWxZYU4kHfVEocl4oBbMVntoACn
         lbKeYFOFs+LfJPnuTBhgISLstdZDx7vdMgdELpmYkeY1Cvu/ZNP4tK8u4ZmzqdF5v6p5
         9OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403596; x=1749008396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzMo1es6YzCF+mytak0KHHshSSIz5JiRwR0oN2yEmjI=;
        b=smT3UgJXnZO/yqMfGlQg1PwCXPsC803nKBR0dfFwFW0qWDSnwU0OOcrEIQcIIubbzx
         d8PvoJM+WbnVcwgqAxdnrB+jajCFYMmYGkY2CGke7fRpC3lOdHtjebpXQaR809QheYUg
         ny1rsTqpX/h3agnXx+BTjyCXnvsXQhSA87op3OrVWqiFCWMio6WZIqtX+ZtALZUUb7Q/
         lM/X6CiSp6EJNxQ5TXw3CgOZok6XNfKCjqk0HeycPu3RLW4mC3qP6IKITpJZ86hHjERl
         OAcW5JjyqFbKhoe3ne7AG8M7yrZTpxZWr+2o2oVOVWdz36BDG6R6bHshF/KNcPLbd44K
         RYmw==
X-Forwarded-Encrypted: i=1; AJvYcCW9pSLMX1Tc5fHkaAwcBm9QwzLOaHXIpSrKAFMuv4tFh75/C1sj38C+/PUvjf2tgiilnSceOnhcCYP4@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBdf+jDl2g6hh+cGkMK3Muh+OM8P18VExVWN8mE4rvf2hHKeg
	Qpdf3e9QzkqsplQLtwzMGKP3e2EfCw7xn90+nq1ElR6So8OwSHqQMzQ8MFt0Cmj/+N9KnedF9LD
	Xx+lVeJb1BUc4Pb30tJ3+cjUqj6Yp6OuAsd0JoipI
X-Gm-Gg: ASbGncv2bDO+gV9IZyt5s3mW6pfGqzeX/wht+VAAlF3JQ0ZE+FFXuLc3up3pIUzswUg
	f6Gg+K+uSWTgmXSg9C3AykbaCTQlioEO2uSdkwBgGiD9JU/eI+u0aQWMICjj4Qayhad70k7pyMj
	ZP/slC7BPphqYlcukKisQWuhH+hRliRVcaU53Sfd38fa42
X-Google-Smtp-Source: AGHT+IF0DtQH7lMaEywzvH79+pjzPiS7W3l062O4jZv96hZEQBimhQXlYIdH+KSq7PDb45c71p8VC9s++X3ZaxARsEI=
X-Received: by 2002:a17:902:d582:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-234cbe3a8d4mr936825ad.19.1748403596010; Tue, 27 May 2025
 20:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-2-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:39:43 -0700
X-Gm-Features: AX0GCFvYZCAPoakcUYocTbtCbfWiIMZbRpUPZfb9hmdDb55iCT3pzFSwcWwav8Y
Message-ID: <CAHS8izPTBnSL_zrW-u0mKBXC=iP9=WZcS9etCRpufCkpCwYoAg@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
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
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
>
> While at it, add a static assert to prevent the size of struct
> netmem_desc from getting bigger that might conflict with other members
> within struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

This patch looks fine to me, but as of this series this change seems
unnecessary, no? You're not using netmem_desc for anything in this
series AFAICT. It may make sense to keep this series as
straightforward renames, and have the series that introduces
netmem_desc be the same one that is removing the page_pool fields from
struct page or does something useful with it?

> ---
>  include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 386164fb9c18..a721f9e060a2 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -31,12 +31,34 @@ enum net_iov_type {
>  };
>
>  struct net_iov {
> -       enum net_iov_type type;
> -       unsigned long pp_magic;
> -       struct page_pool *pp;
> -       struct net_iov_area *owner;
> -       unsigned long dma_addr;
> -       atomic_long_t pp_ref_count;
> +       /*
> +        * XXX: Now that struct netmem_desc overlays on struct page,

This starting statement doesn't make sense to me TBH. netmem_desc
doesn't seem to overlay struct page? For example, enum net_iov_type
overlays unsigned long page->flags. Both have very different semantics
and usage, no?

> +        * struct_group_tagged() should cover all of them.  However,
> +        * a separate struct netmem_desc should be declared and embedded,
> +        * once struct netmem_desc is no longer overlayed but it has its
> +        * own instance from slab.  The final form should be:
> +        *

Honestly I'm not sure about putting future plans that aren't
completely agreed upon in code comments. May be better to keep these
future plans to the series that actually introduces them?

> +        *    struct netmem_desc {
> +        *         unsigned long pp_magic;
> +        *         struct page_pool *pp;
> +        *         unsigned long dma_addr;
> +        *         atomic_long_t pp_ref_count;
> +        *    };
> +        *
> +        *    struct net_iov {
> +        *         enum net_iov_type type;
> +        *         struct net_iov_area *owner;
> +        *         struct netmem_desc;
> +        *    };
> +        */
> +       struct_group_tagged(netmem_desc, desc,
> +               enum net_iov_type type;
> +               unsigned long pp_magic;
> +               struct page_pool *pp;
> +               struct net_iov_area *owner;
> +               unsigned long dma_addr;
> +               atomic_long_t pp_ref_count;
> +       );
>  };
>
>  struct net_iov_area {
> @@ -73,6 +95,13 @@ NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
>  NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>  #undef NET_IOV_ASSERT_OFFSET
>
> +/*
> + * Since struct netmem_desc uses the space in struct page, the size
> + * should be checked, until struct netmem_desc has its own instance from
> + * slab, to avoid conflicting with other members within struct page.
> + */
> +static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
> +
>  static inline struct net_iov_area *net_iov_owner(const struct net_iov *n=
iov)
>  {
>         return niov->owner;
> --
> 2.17.1
>


--=20
Thanks,
Mina

