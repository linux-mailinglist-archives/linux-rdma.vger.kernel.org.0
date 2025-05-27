Return-Path: <linux-rdma+bounces-10770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C2AC5B31
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 22:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545AB3AE233
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D9204F9C;
	Tue, 27 May 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgkStVp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3F4685
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376227; cv=none; b=kIKb/mGfkTCUyyvK8fHwHdpqHN7/dqYHBuE4kkk5uAenAssSFchGwZP58v3Etn7rGZ72tKDTRAkSnmdja6x7va03yU79iR2qspNhKl4aajOOivWA0vihFlrqpMAyeMD4ElT4U+dRItDqJ2kfnm5VSjJdsYoTVSMQAuVS+hADp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376227; c=relaxed/simple;
	bh=XCRePEtybr4g8bPvuFUSge14CpPV5pqGRnXt8bWbS7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GROVlUxSABQR0h89P9xR9O5YzVhhofHWuEYtNjdW/hPk9KQ5NPH29Bl1Kp3cGojSUr+AEJ088tCwWfMzzwTWKNC8Xn2tjsTsEw8szBGUd7GeOSlhH4b2sf/4nJsyuZVQQvouioC2YX3uepE9XP6XpLzqSYb+dp1i5NbCx2ph6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgkStVp7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2348ac8e0b4so6115ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748376225; x=1748981025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9dz0ws5wSMj6T2W2k35nGsxHRv0jWVpPv3Vh+2hBGc=;
        b=EgkStVp7+ed22JBuVfSYxLIpkB9yK270/DslYHqulqnqfJvOhqBUHu9Y/XHFuzsqdk
         wP+IU1R+WRSM+naIdPX4DZ8NUJgzBvP7fO+mH5jFFNhUUeHSb4aQZhA3FyTYNXKg0pkl
         NWm/p2+l16q/7Z7G7RCDqwmxzHvVP6LXnoc8b5h1ecqvP2ENRGwVJh+MPUOwXyDa2VLp
         wKnLzXPvIL511AXSKCdRhduL8VedczStcftB6Bl46PqiKY7DyH68U1NsmUA41B+7c6D0
         afOk5hEwBb+N8HpgNh3kMZZULJpqBI9ANEzoENVB5etEOnT28VEFqzUSx/NINveh6PDO
         Nt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748376225; x=1748981025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9dz0ws5wSMj6T2W2k35nGsxHRv0jWVpPv3Vh+2hBGc=;
        b=oZRhsHIChiMolb8rtSav91msPPVWAbeHn9LClo1o/qh0Gpx7OUdtkntaQa6cLCo8Ps
         V8lZr65ZqyXix44s4/4eAiFzHHAJKuJbhl+qNN3tWzcFf+kzsI386TSrky7zjDokuxIw
         UExi7FwtdCB3+6GTnwuGwiO7M2lWY08Zcr4DLAqYvVWDo6FBh79Un0Omb6fjrhxQNAdl
         CYkTQn5WcMuloBn7yn5AEhV0XObNS5DCl7ImKs4I4ruUcbAOWuDYNk5Ez5lFsHzLK6xC
         Ui3GVPhBVjckM2zEd58x5kT9gXxv9fV30z5djZ8YvHpzgVjl/HTWA3JrIGV9/4ysbPJW
         /JDA==
X-Forwarded-Encrypted: i=1; AJvYcCWvpjgC3ygGMCUtEmIoeyntyiP2ej7ZHcPicQU3oolGBIIy2n5EGIXc2/bdC5x63ywxwNGH/UqPz4sz@vger.kernel.org
X-Gm-Message-State: AOJu0YzaemHn+yyPjltbR8ap5//pLa6hO653Eu8h4LsQU9edEjMz/80o
	eR5wvMXE+klUzPnlPQAyamO+smkH79JF2Q7jmNahwXFWNppnvKqDiZz7E5qLtbujbKQzVo18Edt
	B+ZrMht9nL1U6XkLwHhYgEcOUboaeBXoI2/HSCUa7
X-Gm-Gg: ASbGnctxXIv28U8LuU3r/2ndkBQXL+xQ404zoTLCuLE0Sie+wzDUfA89NeHQiVJpaBL
	R0LVMDXfC72WxdLs7aUOmzmxRDH+XexzOoeCmnl3pVDfbqKgLmLBxcjPsFt60I3qH1LOKXfjhZr
	sXIjVOopE1JhfWKw4kQRGqkIOwchTRy2Yx8ygM5p21+BE4RwN5RqiGyJJADcLx9O5W3GkGXLW0b
	w==
X-Google-Smtp-Source: AGHT+IHQVJN4DbRxvYDuHpB5h+PIroixwpeUhP8CEFDbawUwaYaKS06ZXwlx5TNq2vDV+gnge25smvMObf/GzpJzcwM=
X-Received: by 2002:a17:902:e5c4:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-234c5b776efmr483995ad.13.1748376224659; Tue, 27 May 2025
 13:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
In-Reply-To: <20250527025047.GA71538@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 13:03:32 -0700
X-Gm-Features: AX0GCFtJVZCEXBjwMxqvaH9kWHgitMv7x6i4UovC30AFbm7wSMX4R7wbC9s9-Rs
Message-ID: <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
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

On Mon, May 26, 2025 at 7:50=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Fri, May 23, 2025 at 12:25:52PM +0900, Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, reusing struct net_iov that already mirrored struct page.
> >
> > While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/linux/mm_types.h |  2 +-
> >  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 56d07edd01f9..873e820e1521 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -120,13 +120,13 @@ struct page {
> >                       unsigned long private;
> >               };
> >               struct {        /* page_pool used by netstack */
> > +                     unsigned long _pp_mapping_pad;
> >                       /**
> >                        * @pp_magic: magic value to avoid recycling non
> >                        * page_pool allocated pages.
> >                        */
> >                       unsigned long pp_magic;
> >                       struct page_pool *pp;
> > -                     unsigned long _pp_mapping_pad;
> >                       unsigned long dma_addr;
> >                       atomic_long_t pp_ref_count;
> >               };
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 386164fb9c18..08e9d76cdf14 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -31,12 +31,41 @@ enum net_iov_type {
> >  };
> >
> >  struct net_iov {
> > -     enum net_iov_type type;
> > -     unsigned long pp_magic;
> > -     struct page_pool *pp;
> > -     struct net_iov_area *owner;
> > -     unsigned long dma_addr;
> > -     atomic_long_t pp_ref_count;
> > +     /*
> > +      * XXX: Now that struct netmem_desc overlays on struct page,
> > +      * struct_group_tagged() should cover all of them.  However,
> > +      * a separate struct netmem_desc should be declared and embedded,
> > +      * once struct netmem_desc is no longer overlayed but it has its
> > +      * own instance from slab.  The final form should be:
> > +      *
> > +      *    struct netmem_desc {
> > +      *         unsigned long pp_magic;
> > +      *         struct page_pool *pp;
> > +      *         unsigned long dma_addr;
> > +      *         atomic_long_t pp_ref_count;
> > +      *    };
> > +      *
> > +      *    struct net_iov {
> > +      *         enum net_iov_type type;
> > +      *         struct net_iov_area *owner;
> > +      *         struct netmem_desc;
> > +      *    };
> > +      */
> > +     struct_group_tagged(netmem_desc, desc,
>
> So..  For now, this is the best option we can pick.  We can do all that
> you told me once struct netmem_desc has it own instance from slab.
>
> Again, it's because the page pool fields (or netmem things) from struct
> page will be gone by this series.
>
> Mina, thoughts?
>

Can you please post an updated series with the approach you have in
mind? I think this series as-is seems broken vis-a-vie the
_pp_padding_map param move that looks incorrect. Pavel and I have also
commented on patch 18 that removing the ASSERTS seems incorrect as
it's breaking the symmetry between struct page and struct net_iov.

It's not clear to me if the fields are being removed from struct page,
where are they going... the approach ptdesc for example has taken is
to create a mirror of struct page, then show via asserts that the
mirror is equivalent to struct page, AFAIU:

https://elixir.bootlin.com/linux/v6.14.3/source/include/linux/mm_types.h#L4=
37

Also the same approach for zpdesc:

https://elixir.bootlin.com/linux/v6.14.3/source/mm/zpdesc.h#L29

In this series you're removing the entries from struct page, I'm not
really sure where they went, and you're removing the asserts that we
have between net_iov and struct page so we're not even sure that those
are in sync anymore. I would suggest for me at least reposting with
the new types you have in mind and with clear asserts showing what is
meant to be in sync (and overlay) what.

--=20
Thanks,
Mina

