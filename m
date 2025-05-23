Return-Path: <linux-rdma+bounces-10646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E26AC2920
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 19:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D53A74AA
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8F299929;
	Fri, 23 May 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOUs8Z8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274F81749
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022970; cv=none; b=WPnF14mb96R2HY/QW+6Bd9q2p5TGStVNeyKGxCAj0DcDsG/2mZlOeiiawa/xFXb3f2PAtJIz/MVisYdLgMMvdT6PWp1reOLAzlz8FZxcStZASDRKZ8d/1vSdgy/2yOo8Y/m0kYQUpq8NcCiKqms+UPQSZvWdHQIJaWWZmPq//WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022970; c=relaxed/simple;
	bh=WRdnaGverlu7vTJ/60vt4tPf27macSfbJ1NcFaxcNBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs67c7Kwf96W9YMrUVH5uKRQZMXO9O18wHk/8gga0IbqDZPCfGTsS0eYky580CDj+Whqs+kXtKMMU3OzmfOqStXJcFqKPZj1cUxg5u5xr6mCcBb1yYBRxLfgSYiqy+l8vfDU/pZw3sgdUzAmA1LtuOZAgs4YHjZgOiA/nAMDn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOUs8Z8s; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231f6c0b692so20505ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748022967; x=1748627767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKcG0kIzVQf2DFouXJTY346ztiLo6ETHd82n5f0p1Bw=;
        b=yOUs8Z8s6c/C4RQQNv1FU7Guh1Tu1dVHcoYHiuG11x0R9RnzkCP+r/ZNI5iHnw37LN
         m+juLUTs2ui4CerCmTy3zw8bLSwGx25B2eiFBftZhkPyh9onz72r8sj75Vo5kdAoBZm2
         BX98Jp7mA7kdd99V+ATBsssAaprGsFPpzqpeCnp3+G1OgTjM2IiwZJzvXNlpErLBTRRB
         dPmO89NzU6yeIuTM9Nwo2ozlNf/S4TD1U2Rm+zwvpaguzcbO6TzYoPZQLex6OypDF9m4
         7K/6pjFiiNi9787QNNorvKP3tXyr65d5nclf26p38Kr7mMHElWtumnxpu5iRgsMANTuW
         zjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022967; x=1748627767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKcG0kIzVQf2DFouXJTY346ztiLo6ETHd82n5f0p1Bw=;
        b=h5Qed2J6RSyi/doFVEYM7EOZRasm2no/Njl2mZhKt1hMDGET/MsFd4Ragpr7D+hXoO
         TpzXDj6sAOr9IKwQBZS/sYpYMUScytPq55DDdCC2SFFBwyMISLGIcgU2LhpJwREhAKGg
         fqq7T1iZAoMICDOLNby/oW4auhIrW9+Op34mV4WlFSVajGKIczQYuz6pWChZT76MWwlW
         iNAxWZpvSNam4l9doJnEWA9wS2kjLsct92j8LuCnuq6Kv/ej2MrpI41xKjYoTsU4w6zl
         q8LtY67QvanNQ880lq3CVehxlDplm52yAvCHLy7Kv69ILk1IZfvfa8sjvB8/mFDX7q9Z
         ktaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDz0W8HoAlp+NEH2N1BZM2qO/AkrGVm8bNRyzenXnwrvWW+IH9VFyk5bsZ/jWuvH18W9O9X26zINVN@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYXle1UmnaEjv4qmr3yaPm43engrFbK54spb/g9SuRQzBiz2H
	/UEH0b5Kmv07mY4T80aNT/ErCbc9YWN2XOps4csOUkunv1uiPS8qwQynkhIxFuULjJXXYrkblXo
	5zKDs1p4ULJplJFYWSsGoots+AK+TYePFXnDmoUqI
X-Gm-Gg: ASbGncv/mkb05gwCAQALSvE20Iz4Bs9D0Rkb9/s9oRy2nzROknzOV17f8MGP+OyrgEx
	JiOvSzV8ATRQqd1We6VBGp9qqAxKuLC70uFPSmINrl5z0+wC921/nVVdmqOYnzBKr/jmB+/xl/N
	bChZAKJf2xUg5tOMkpZbvAFPckGdQi22TdC71v0qdhkTk/sEGuj2879aLXtCT8cUGfxfGxNk/Su
	Q==
X-Google-Smtp-Source: AGHT+IHG7QjmSnQi5VQF7H68jYu342TfgU01VfBj8sRrando2xNin21bTuvUh2YHtW/IvW4mbUWhDr+UVPFZB1gCm/k=
X-Received: by 2002:a17:902:dad2:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-2341808c7d7mr64375ad.14.1748022966452; Fri, 23 May 2025
 10:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-19-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-19-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:55:54 -0700
X-Gm-Features: AX0GCFsYNuzYJlporwz1mSapGXVg6LAugMmId4ntk8vawow7YJm9vkQ7qXBE0cE
Message-ID: <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
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

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that all the users of the page pool members in struct page have been
> gone, the members can be removed from struct page.
>
> However, since struct netmem_desc might still use the space in struct
> page, the size of struct netmem_desc should be checked, until struct
> netmem_desc has its own instance from slab, to avoid conficting with
> other members within struct page.
>
> Remove the page pool members in struct page and add a static checker for
> the size.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h | 11 -----------
>  include/net/netmem.h     | 28 +++++-----------------------
>  2 files changed, 5 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 873e820e1521..5a7864eb9d76 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -119,17 +119,6 @@ struct page {
>                          */
>                         unsigned long private;
>                 };
> -               struct {        /* page_pool used by netstack */
> -                       unsigned long _pp_mapping_pad;
> -                       /**
> -                        * @pp_magic: magic value to avoid recycling non
> -                        * page_pool allocated pages.
> -                        */
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index c63a7e20f5f3..257c22398d7a 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -77,30 +77,12 @@ struct net_iov_area {
>         unsigned long base_virtual;
>  };
>
> -/* These fields in struct page are used by the page_pool and net stack:
> - *
> - *        struct {
> - *                unsigned long _pp_mapping_pad;
> - *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> - *                unsigned long dma_addr;
> - *                atomic_long_t pp_ref_count;
> - *        };
> - *
> - * We mirror the page_pool fields here so the page_pool can access these=
 fields
> - * without worrying whether the underlying fields belong to a page or ne=
t_iov.
> - *
> - * The non-net stack fields of struct page are private to the mm stack a=
nd must
> - * never be mirrored to net_iov.
> +/* XXX: The page pool fields in struct page have been removed but they
> + * might still use the space in struct page.  Thus, the size of struct
> + * netmem_desc should be under control until struct netmem_desc has its
> + * own instance from slab.
>   */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> -       static_assert(offsetof(struct page, pg) =3D=3D \
> -                     offsetof(struct net_iov, iov))
> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> -#undef NET_IOV_ASSERT_OFFSET
> +static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
>

Removing these asserts is actually a bit dangerous. Functions like
netmem_or_pp_magic() rely on the fact that the offsets are the same
between struct page and struct net_iov to access these fields without
worrying about the type of the netmem. What we do in these helpers is
we we clear the least significant bit of the netmem, and then  access
the field. This works only because we verified at build time that the
offset is the same.

I think we have 3 options here:

1. Keep the asserts as-is, then in the follow up patch where we remove
netmem_desc from struct page, we update the asserts to make sure
struct page and struct net_iov can grab the netmem_desc in a uniform
way.

2. We remove the asserts, but all the helpers that rely on
__netmem_clear_lsb need to be modified to do custom handling of
net_iov vs page. Something like:

static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_m=
agic)
{
  if (netmem_is_net_iov(netmem)
     netmem_to_net_iov(netmem)->pp_magic |=3D pp_magic;
  else
    netmem_to_page(netmem)->pp_magic |=3D pp_magic;
}

Option #2 requires extra checks, which may affect the performance
reported by page_pool_bench_simple that I pointed you to before.

3. We could swap out all the individual asserts for one assert, if
both page and net_iov have a netmem_desc subfield. This will also need
to be reworked when netmem_desc is eventually moved out of struct page
and is slab allocated:

NET_IOV_ASSERT_OFFSET(netmem_desc, netmem_desc);

--=20
Thanks,
Mina

