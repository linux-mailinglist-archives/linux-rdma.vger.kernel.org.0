Return-Path: <linux-rdma+bounces-12156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D936DB047AB
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ABD3B4061
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59E92749E7;
	Mon, 14 Jul 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ze0aM0vG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C413D531
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519746; cv=none; b=S7ayAbaG5KWO9vIj+Qrg5cX19ENi+Jzc8ksL/8NNcytB3a1CLsUY5L+d9I0SwmX8XO6dHmq4lw1qtmRAJziqN+RvcnMZGxd3puZpt+pk7DuGRG//3WRgngCVeB/qljzMzdBo2LYaZn+FW5Jea3XB1a1vZ2BWQlQ69L5nqdRKHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519746; c=relaxed/simple;
	bh=IlC6zSATruhsMz1ZplTcZDwaO5Ka3Y33EyLYUL4LW70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajv+YbR48ZH4mW5zU2rgWmbjROU53tjWLDi47hLK0B/dylW0U8/lZCXjj7bKYwTb0r/EG8Sucqio41i/Pjf6DwY7lHjCLS/5KXZ2l5oRbFuzEKNbX/pzpqdPvhOcj8udS1NqCx8KQ+UfgwUOhSWVchPdEw4vSvY5NXrbNtLDXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ze0aM0vG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237f18108d2so34245ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519744; x=1753124544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VNuZztsVJnCZDih7ufg2t56wYe/NpWWBgR9l5kOONY=;
        b=Ze0aM0vGdX4i5f/qfOpVz7HayrDETwVBsMj/UjGARrE3xuQM0slF+8+sed9Bw7eug7
         K6doNqC18sC94AS2vMSbEW2qYjOWDrMeCqu7/csady6veIMo1whCm1CQCKZRp7hhBNSK
         1piweQimn6FbIquD/AcDQBSM1i0fccLORn4Utj60e4z6zlSTMxsOf2K9uCEeHjo7/LI7
         REOGX2leJjk7ESfyeszVd5dyxBvwUZl5VEbwdvrUxrGqqgveh+nyPl5dHM5OG2mkbH07
         QIotVnOIJSKTX9I0hrlzMkxXjiEZ2kDPf8qXd7oAIWNOfDmCRWHTYFNhTuU6KFq9+dG6
         J9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519744; x=1753124544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VNuZztsVJnCZDih7ufg2t56wYe/NpWWBgR9l5kOONY=;
        b=Bs+SxBu2svEsZVg12r2ygxdkMSLG6J403aI/pcCN8KOpSonxtIHrQn8rpNE8vL461V
         DmKG/L8OUixjjaP6fjH1ckupxF3W7PYGXDZbKWomNyXaCr2UgLw0Kpv3TCzE3WKhtbHi
         43bp7+dXPhZz4lLjvobujPEkXjHRHONaqSOlwv9PzWB/Ty/SHKNd+SEXqZIB6rynx+mP
         1spBXIvP7YmrwmJmMErWFwrsam7SIN+MCR26nZT9A303v+PMiFoNG6EuDW2SIrSYzXpR
         hcP/s+vCkdVBEJ5K6Jc2sFrWkWkwoysGJs/kVjSJKz5RKKzpJegB7Tom+HRjmTww3hTe
         yyQg==
X-Forwarded-Encrypted: i=1; AJvYcCVYS8GM6ulb3VnqMkuA9JuDEXZ2CXvrNUssQRmpku3c3KFbxoGzD8HXxdWrMR1aegqh37If+7E1WpE7@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYuTITW4hP0R2KlbvraXAhpbzyXTuq8N635NfmhIvWzwQDJlS
	imi3EzmwcYGLVONpQs5tBkSKKPA86BVhgOeJ4NF+woBRIJqgaUWVhb8uflASYvLZErEo+MckcxM
	5/2Z21Vb6/k5psiA9+b30i3Gg5QUCR8GpDFZ3nFac
X-Gm-Gg: ASbGncs3VAiFvv+Li8U01a0GIarUaQfVQT1/mSvCFbGBhM1M9zbmqQlRwRBFHynaKn5
	RpoJHJjvJt+PVELI484c5wt89aJ5u6lA45z2g4iQUfTKeNXaBcMKClYmFzPGnpJDoAGv6A+khrL
	C1Kjqn0Roh1cmV3MJyW1p8bmwK9Wr1AkzOUWEI/nWbMVmXTyp+19FAAh5vBK7YoddPFgD2CQBCQ
	bQIAOhR95326FdENkng/U2VFaljeE8nanRfRQ==
X-Google-Smtp-Source: AGHT+IE6b3u0FEYbE/5zU2GFDjTpZUgGKFIuxC3GHJP9usTARJ45zz7VYQPM3TtdZ3Tr5Ox8uT4ZdAfccFl5CsvEYCc=
X-Received: by 2002:a17:902:e552:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-23e1ab000f4mr410435ad.12.1752519743690; Mon, 14 Jul 2025
 12:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-7-byungchul@sk.com>
 <CAHS8izM9FO01kTxFhM8VUOqDFdtA80BbY=5xpKDM=S9fMcd3YA@mail.gmail.com> <20250711013257.GE40145@system.software.com>
In-Reply-To: <20250711013257.GE40145@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Jul 2025 12:02:02 -0700
X-Gm-Features: Ac12FXxeXh1UoBnGrAUfq0hNcg_aduZtehgNTdEPgSN61td1YzR9QhWexF1R0b0
Message-ID: <CAHS8izOOZ5w_+5W=uYGrr3V8VjYXfo6fzs3cjJF1eoZsqcm71Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/8] mlx4: use netmem descriptor and APIs for
 page pool
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

On Thu, Jul 10, 2025 at 6:33=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Thu, Jul 10, 2025 at 11:29:35AM -0700, Mina Almasry wrote:
> > On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > To simplify struct page, the effort to separate its own descriptor fr=
om
> > > struct page is required and the work for page pool is on going.
> > >
> > > Use netmem descriptor and APIs for page pool in mlx4 code.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 48 +++++++++++-------=
--
> > >  drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  8 ++--
> > >  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  4 +-
> > >  3 files changed, 32 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net=
/ethernet/mellanox/mlx4/en_rx.c
> > > index b33285d755b9..7cf0d2dc5011 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > > @@ -62,18 +62,18 @@ static int mlx4_en_alloc_frags(struct mlx4_en_pri=
v *priv,
> > >         int i;
> > >
> > >         for (i =3D 0; i < priv->num_frags; i++, frags++) {
> > > -               if (!frags->page) {
> > > -                       frags->page =3D page_pool_alloc_pages(ring->p=
p, gfp);
> > > -                       if (!frags->page) {
> > > +               if (!frags->netmem) {
> > > +                       frags->netmem =3D page_pool_alloc_netmems(rin=
g->pp, gfp);
> > > +                       if (!frags->netmem) {
> > >                                 ring->alloc_fail++;
> > >                                 return -ENOMEM;
> > >                         }
> > > -                       page_pool_fragment_page(frags->page, 1);
> > > +                       page_pool_fragment_netmem(frags->netmem, 1);
> > >                         frags->page_offset =3D priv->rx_headroom;
> > >
> > >                         ring->rx_alloc_pages++;
> > >                 }
> > > -               dma =3D page_pool_get_dma_addr(frags->page);
> > > +               dma =3D page_pool_get_dma_addr_netmem(frags->netmem);
> > >                 rx_desc->data[i].addr =3D cpu_to_be64(dma + frags->pa=
ge_offset);
> > >         }
> > >         return 0;
> > > @@ -83,10 +83,10 @@ static void mlx4_en_free_frag(const struct mlx4_e=
n_priv *priv,
> > >                               struct mlx4_en_rx_ring *ring,
> > >                               struct mlx4_en_rx_alloc *frag)
> > >  {
> > > -       if (frag->page)
> > > -               page_pool_put_full_page(ring->pp, frag->page, false);
> > > +       if (frag->netmem)
> > > +               page_pool_put_full_netmem(ring->pp, frag->netmem, fal=
se);
> > >         /* We need to clear all fields, otherwise a change of priv->l=
og_rx_info
> > > -        * could lead to see garbage later in frag->page.
> > > +        * could lead to see garbage later in frag->netmem.
> > >          */
> > >         memset(frag, 0, sizeof(*frag));
> > >  }
> > > @@ -440,29 +440,33 @@ static int mlx4_en_complete_rx_desc(struct mlx4=
_en_priv *priv,
> > >         unsigned int truesize =3D 0;
> > >         bool release =3D true;
> > >         int nr, frag_size;
> > > -       struct page *page;
> > > +       netmem_ref netmem;
> > >         dma_addr_t dma;
> > >
> > >         /* Collect used fragments while replacing them in the HW desc=
riptors */
> > >         for (nr =3D 0;; frags++) {
> > >                 frag_size =3D min_t(int, length, frag_info->frag_size=
);
> > >
> > > -               page =3D frags->page;
> > > -               if (unlikely(!page))
> > > +               netmem =3D frags->netmem;
> > > +               if (unlikely(!netmem))
> > >                         goto fail;
> > >
> > > -               dma =3D page_pool_get_dma_addr(page);
> > > +               dma =3D page_pool_get_dma_addr_netmem(netmem);
> > >                 dma_sync_single_range_for_cpu(priv->ddev, dma, frags-=
>page_offset,
> > >                                               frag_size, priv->dma_di=
r);
> > >
> > > -               __skb_fill_page_desc(skb, nr, page, frags->page_offse=
t,
> > > -                                    frag_size);
> > > +               __skb_fill_netmem_desc(skb, nr, netmem, frags->page_o=
ffset,
> > > +                                      frag_size);
> > >
> > >                 truesize +=3D frag_info->frag_stride;
> > >                 if (frag_info->frag_stride =3D=3D PAGE_SIZE / 2) {
> > > +                       struct page *page =3D netmem_to_page(netmem);
> >
> > This cast is not safe, try to use the netmem type directly.
>
> Can it be net_iov?  It already ensures it's a page-backed netmem.  Why
> is that unsafe?
>

Precisely because it can be net_iov. The whole point of netmem_ref is
that it's an abstract type that can be something else underneath.
Converting the driver to netmem only to then say "well, the netmem is
just pages, cast it back" is just adding a lot of useless typecasting
and wasted cpu cycles with no benefit. In general netmem_to_page casts
in drivers are heavily discouraged.

> With netmem, page_count() and page_to_nid() cannot be used, but needed.
> Or checking 'page =3D=3D NULL' after the casting works for you?
>

I'm really hoping that you can read the code and be a bit familiar
with the driver that you're modifying and suggest a solution that
works for us. netmem_to_page() followed by page_count() without a NULL
check crashes the kernel if the netmem is not a page underneath... so
it shouldn't work for anyone.

What may be acceptable here is netmem_count helper and what not like
we have netmem_is_pfmemalloc which handles net_iov correctly.

However, it looks like this driver is trying to check if the netmem is
recyclable, we have a helper like that already in
__page_pool_page_can_be_recycled. Maybe that can be reused somehow.

--=20
Thanks,
Mina

