Return-Path: <linux-rdma+bounces-12047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFBB00B7C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301B37B2B6F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8C2FCE3E;
	Thu, 10 Jul 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5VgZnHB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DF2FCE14
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172549; cv=none; b=MIcakgMKO4yiuOHEM92IeLXNSeQcjGDQjsw/nApqfn93tOsqnAwDn/kJOQGAZoAekYR70lrjm5FrN5W6lwUoy9w9RJc1caDT6LasEEcn97JaWXkwIuwnc28DUyrfFEbIL+nk/HPaNuZialy4ZVKXyal2/3rMitLIRtXPaLCAEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172549; c=relaxed/simple;
	bh=BQi/oAxmvttoMCkmYmgHMY9tc5kt6YdUCM6RxGff5II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKSnW30g8Ep+Xjzpy63tVMAsVDnn5CIyde5WiQyMfhYvKAAMnbSqVdwQ5HgG/PDINamjDcFwgPinQ53YOfjHl6xKcH8ow2aNzmzRf11jk++/SBn71OYnVCHteLi1ZqA3JTWHGcQeURTmJPzahu6Uxh/pmF0+D8U4Py8GHvDz114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5VgZnHB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dd9ae5aacso25915ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752172547; x=1752777347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUFyFG64jchMDy9nJZhwnx6mFvVO2+1zDBN4KcsNtGQ=;
        b=V5VgZnHBUAwpIKTq3Kone9pNEIxn1KsfehINSGQXDEJfYnBfLnPl21en0eF6+49Qfs
         IPEJOc8dP9hY6i4PbXLFaSWPpd4u/BMAuR8BV3qOcZuLxkYayCSzAwwTQX4zu9nf5vBp
         r1kGNnpX6l1kYIdXy9XwnzsZvOrOMSuK1VNBw6KJbTceShJ1ZD/VRlIyTrsVYcw0R5eJ
         a5xbvLIeqGPZs3bORCV26MrxNxkd/QG2JikR04f4cA66sAmjo0xfQxvVduEcfrGgaq9m
         a8wbPnuILhBPwzAg+1iqeYBopGM5PoqkBRdJ41S1Ybp7lD6+mFpxx5MI7QLb3FBLVv4t
         03tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172547; x=1752777347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUFyFG64jchMDy9nJZhwnx6mFvVO2+1zDBN4KcsNtGQ=;
        b=i7Iq357GjEF4GbxddUNcrGkQhvB/xv+sok7T+MWUmrjV5Bj/WVcYSCCoozUXpkzHaz
         /r1q1R0OaPli8W/2qJSARxPEBX9pCObEtaAj9jrAx8DAgOdAQdkU6RjUTpcJg8qFigCQ
         xs4ui3GSfyFtyJiK7eedVvtQT9GKPc26WoC+xqgt2CI5fDGI419gM97rRhEoNubwWtG4
         gZHbtDUFNFbY3GSjWyHGiWMRD9YywBHZIamYkmSBomiclnsKbcN8lKZ3ZdDvnm8yCvXe
         x6yQwstpYgHVWGgTw2KWYNx0uIaNEDdqWPjdRQ7SSCemEnNULJmJ7go2CX/77PGaZE/p
         LU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxYZT4hwDJY3vx6+coEPgld6ThCdMYlWlidU1y6nC7DMx6XZ9GkRsvc9daTmIwneu7JKmxuSaaDWRs@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJdl8o+T3ztkUEvn14dnWysGfxq/lXs6NQxjn41KzYsC/bVQT
	0DLa2+26nX/iuxLCvJX6kJTT803Bitvnl2+XwWV4MiN1w6VBFF1ekVLfGaE1hc4sF0jaJ/GR676
	vaiPkFNqyr9kicqPH6fkM+Q4Uxa7srnT8zDCixDsz
X-Gm-Gg: ASbGnctJamWNsShSN4Xb422vwitVwLdHaPp7+AZ+NXRtEv5Q0pABRKDXjIbmY5lX12M
	nHu/ytEB5ro/G3WuTnXftn3MoXhAAqLKOu/GPV2upNCJMFw7O30B6S14WavbGz4vgMkCZxkh+i0
	7NJ2WyKaajYR8ogn8RLkrvbGKyz+8iHC+4ru2VIYtg2A9oGiPAwt5l7HlNRGYM6UqFMxhi+1M=
X-Google-Smtp-Source: AGHT+IEzZmw78/OSXjJWOTZycozUs1vUEUMKIB/o/lKBX8kmUgnw2fbBaI4EEfFVqfugsZvpbjLQdKz5IhYTiVxWNgo=
X-Received: by 2002:a17:902:b095:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-23dee18a914mr236695ad.8.1752172546684; Thu, 10 Jul 2025
 11:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:35:33 -0700
X-Gm-Features: Ac12FXzCBZV3mzo5-D0lWEghMlDgKwI9NFBNKAUpNVy6DriBk8SQ-mKMDpELnTI
Message-ID: <CAHS8izMie=XQcVUhW9CmydTqYEscp5soeOT4nwvFj2T+8X1ypA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/8] Split netmem from struct page
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
> Hi all,
>
> The MM subsystem is trying to reduce struct page to a single pointer.
> See the following link for your information:
>
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for page pool.
>
> Matthew Wilcox tried and stopped the same work, you can see in:
>
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infrade=
ad.org/
>
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
>
> The final patch removing the page pool fields will be posted once all
> the converting of page to netmem are done:
>
>    1. converting use of the pp fields in struct page in prueth_swdata.
>    2. converting use of the pp fields in struct page in freescale driver.
>
> For our discussion, I'm sharing what the final patch looks like, in this
> cover letter.
>
>         Byungchul
> --8<--
> commit 1847d9890f798456b21ccb27aac7545303048492
> Author: Byungchul Park <byungchul@sk.com>
> Date:   Wed May 28 20:44:55 2025 +0900
>
>     mm, netmem: remove the page pool members in struct page
>
>     Now that all the users of the page pool members in struct page have b=
een
>     gone, the members can be removed from struct page.
>
>     However, since struct netmem_desc still uses the space in struct page=
,
>     the important offsets should be checked properly, until struct
>     netmem_desc has its own instance from slab.
>
>     Remove the page pool members in struct page and modify static checker=
s
>     for the offsets.
>
>     Signed-off-by: Byungchul Park <byungchul@sk.com>
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 32ba5126e221..db2fe0d0ebbf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,17 +120,6 @@ struct page {
>                          */
>                         unsigned long private;
>                 };
> -               struct {        /* page_pool used by netstack */
> -                       /**
> -                        * @pp_magic: magic value to avoid recycling non
> -                        * page_pool allocated pages.
> -                        */
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 8f354ae7d5c3..3414f184d018 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -42,11 +42,8 @@ struct netmem_desc {
>         static_assert(offsetof(struct page, pg) =3D=3D \
>                       offsetof(struct netmem_desc, desc))
>  NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
> -NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
> -NETMEM_DESC_ASSERT_OFFSET(pp, pp);
> -NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> -NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
> -NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
> +NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
>  #undef NETMEM_DESC_ASSERT_OFFSET
>
>  /*


Can you remove the above patch/diff from the cover letter?

--=20
Thanks,
Mina

