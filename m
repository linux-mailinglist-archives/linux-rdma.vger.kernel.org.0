Return-Path: <linux-rdma+bounces-10861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFBAC7235
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C332B189C4D3
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AEF221D86;
	Wed, 28 May 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hb1th95"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAB2206BC
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464168; cv=none; b=S9UWx4WA/pztp4rPACauPoCXzLV5KP6EMDupsQncWTI2W4Dm0Hzq8+q0tA2eIvtmA4HBvZzS1/JEn5KKv4XpS2kc4H++aUX0+a78zEQmLQOGjwQl3mx1P26vXbnTjNID00vYMyvtLuTPRyyoo9O9uVhhBAVdCYvg/dImZdqmeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464168; c=relaxed/simple;
	bh=WL3JbFFeB8hz9dp4apUh9xBal5aOrNBvFds8l+hj0cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQaBxZZwnFSKh6VjjMS34YRR4bVlQDjlvshYjd48Z/rzubNyAPlihHA2AlWTObCEgty4zT47n/JbbCFLb9bbzyrQPDRcrXrg1hdvJmFlGPXRTfdhKd+ctq5YxIkuQbVfr0zAxZ7pgLY03rtqAclInIp17wQ/x8HxBXmkgOo9KsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hb1th95; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348a45fc73so48345ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748464165; x=1749068965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtuCwhZW/OpdzghCypJVgYdX1gC23Z08ZYJNUJxLNwY=;
        b=3hb1th95TTdKuGI1fBAtfJwujPFLw6hQtPYB98Nt73eFhsA1SekT4piFCJ53TSG9pA
         hMwV2hbX2VdCB3DLvthVTckwR39otOzZgfivCnyF+RZVWiC/d1B+bj3TT1KOoftqfiDM
         mPLn69ruhiZHKX5h+Mw+UJEe0UgapRCBqwlUQPitsAxRrjbGjisw/9V9UydAHXtivuaz
         B2uAPz66vLxtmLkH9gjwQutRCUeGUy5HvrDxT+zkYoqMTyst4xy9vvRd0NWLCfCllcrk
         fLjtU/hmpzoDPeH9/IZ1rThnzqAhoJ53Y1r9ugyncZGFA52C4GJCl739m+p4CzVQcuTl
         RRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464165; x=1749068965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtuCwhZW/OpdzghCypJVgYdX1gC23Z08ZYJNUJxLNwY=;
        b=IkEUCOXNZTtXrY3fZXNMFEZ7QA+AeOO2V6zmB8eQA6ypgD5LBTCWIGDWQciJDS41XO
         yu1cnL+5Ol8+VMQFP3tumcNEDoLcZpbj3aKemVFjO2dsFsg0l/H+1ApMyL83uEPsWKB/
         IQ8nk9STaIvFzUzwdw9sa61HodlsG6xqIIN4BA25i/HGrqXgUzbymcF4Oqgb0HsGL0ox
         KVkLcW4n4ovZuSMgEH6E7CBM8HRa2o9flDuuEvVSGbYuwa9mDISVOQXhVcRgESe4pLBW
         vglHMF9n3/tIPclWbmpc/R52BfaJGSGC6qufHTbk7lcIVd5TTB+oL1XPsIVxcJ0TFwkL
         RbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW499WV3IO3wKXMti4UuFV2vGm7egEqatxUc6XICgy36ZJbDJ66vAuX6xqd8W85GH4J2T/K5qlyO+9e@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2MS4in5dedTRjRsynSB2aa/Z75ZpaOFsaAeXfJYUPHpCNA3g
	EUrE7YiBRaA2irKJszOUpnl4PPt3LayPMz+KtknKJqn8ftLOxEXBgz2XKyzEmL7Slqcr3U2QfIb
	h/QZL8wW2eyPXQVesr4OU56X4S2AnoLxm9W7knaZ/
X-Gm-Gg: ASbGncvA+fnDvS9BreNujCwrnKFIw29Yoh/7TbGpjWyPYxxP36/8QIoEcuXJliVeag+
	A0+lWJJuGlHRONIygc3uLscbd62G0xCY6DbZn2qdTBNv+zULabgyjFJGz+FNoyrdacYStIW3itm
	UkpM5HOYBcmnT9HQy5U+W0mK/1i1bWFt8JTdwQ9nn6MHKt5KEGWCtitSt3FYaNWA47iVWqreZB3
	A==
X-Google-Smtp-Source: AGHT+IF3olouht4/h+Yom7odAZXWAlWP3Jr74zvGxmzUXYZiqm+ZrYb9dZ0Z6AtwKCQgKYoDWgVpborgGQhXum1PIXo=
X-Received: by 2002:a17:902:f68a:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-234ffe67a1dmr777355ad.6.1748464164902; Wed, 28 May 2025
 13:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-9-byungchul@sk.com>
 <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com> <20250528055625.GC9346@system.software.com>
In-Reply-To: <20250528055625.GC9346@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 13:29:12 -0700
X-Gm-Features: AX0GCFtLmYzec5bNXT46FH3Zh7xYXq7-lgq8DUSSH3cP76DeHTPqGOw_dzekarY
Message-ID: <CAHS8izORW+42nFBFas6t9RcOrRVG3KvQ9+3We4u4f1kXFzz=7Q@mail.gmail.com>
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

On Tue, May 27, 2025 at 10:56=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> On Tue, May 27, 2025 at 08:21:32PM -0700, Mina Almasry wrote:
> > On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > Now that __page_pool_release_page_dma() is for releasing netmem, not
> > > struct page, rename it to __page_pool_release_netmem_dma() to reflect
> > > what it does.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  net/core/page_pool.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index fb487013ef00..af889671df23 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
> > >         netmem_set_pp(netmem, NULL);
> > >  }
> > >
> > > -static __always_inline void __page_pool_release_page_dma(struct page=
_pool *pool,
> > > -                                                        netmem_ref n=
etmem)
> > > +static __always_inline void __page_pool_release_netmem_dma(struct pa=
ge_pool *pool,
> > > +                                                          netmem_ref=
 netmem)
> > >  {
> > >         struct page *old, *page =3D netmem_to_page(netmem);
> > >         unsigned long id;
> > > @@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_p=
ool *pool, netmem_ref netmem)
> > >         if (static_branch_unlikely(&page_pool_mem_providers) && pool-=
>mp_ops)
> > >                 put =3D pool->mp_ops->release_netmem(pool, netmem);
> > >         else
> > > -               __page_pool_release_page_dma(pool, netmem);
> > > +               __page_pool_release_netmem_dma(pool, netmem);
> > >
> > >         /* This may be the last page returned, releasing the pool, so
> > >          * it is not safe to reference pool afterwards.
> > > @@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *p=
ool)
> > >                 }
> > >
> > >                 xa_for_each(&pool->dma_mapped, id, ptr)
> > > -                       __page_pool_release_page_dma(pool, page_to_ne=
tmem(ptr));
> > > +                       __page_pool_release_netmem_dma(pool, page_to_=
netmem((struct page *)ptr));
> >
> > I think this needs to remain page_to_netmem(). This static cast should
>
> Do you mean to ask to revert the casting patch of page_to_netmem()?
>
> Or leave page_to_netmem(ptr) unchanged?
>
> I added the casting '(struct page *)ptr' above to avoid compliler
> warning..  Do you see another warning on it?
>

Ah, sorry, I misread this on the first try. I thought you're
replaceing page_to_netmem with a static cast but you're not. You're
just casting a void * to page*. That should be fine and should indeed
remove warning.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

