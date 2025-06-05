Return-Path: <linux-rdma+bounces-11046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672FACF870
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 21:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689153ADCC2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738D227D786;
	Thu,  5 Jun 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvn0v0VU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36B16FF37
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153346; cv=none; b=TBoXp4ihpLgVWiJBSq+DZ8hhqYyhdalkesTLHTgYi8bk2b7jWX8MYhEOm+zahY+V8pR3uyCOdhNc9Vvm+HLhDmadu0pp2nygSWCfTwaRz7z/EF9QamPuuAbC5bTKrlk1EaUeK8OJJIw15nzcvnr8k8vtNES2TRAB81rC8azViwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153346; c=relaxed/simple;
	bh=o9mEMtyvFGc0zBf2lesOPiM6c+iqKDwQ57v5sgzNAbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcJnwKzm8Y6CzmwPY/5M/4lt2BohA3S1k88Eq9Wr/h1ZDk5TezX/RyMPORR1uNDaOJrWUyx9WAuX1/VUrn7cYmXlmeuTFA0tj4tkIjfNggxXk4Q7vfYwU+LgtR5HXCFJsxvAxZmtEd86nN/S8F/c8lssaJgwc6sXtIOmN1VKPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uvn0v0VU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235ca5eba8cso39565ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jun 2025 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749153344; x=1749758144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaGimUCU1zGGvfY9Mn8mz26Pj9z4GAUe4JLOgwbUwZQ=;
        b=Uvn0v0VUAT9wYUVYjQOEfkoU2eYmf1eCfpB9Omq813WZYW6h/6R+vb+0fxKvFzHe7D
         Iwe6VoKGfaD8V5Cv7lsOHJCIpCK45SAIgHlyk59fjwYidtntxPieolOsaGCuvXjgHMG4
         V3vy/ZGR3icgf5nc8V/wcuY0Iu0sT0N8jaqq1r3Y5jbe2gWSrc8rX3MXIhPj65CIwlSy
         RKJPreZ1rvuLyegJINlCYobUfSQ/LyHxGghiCYww7blMy32pR6EdMMSHPqiSFUXMAx5h
         FVObqUympGQxBUoEsES8FYmrM2hILBsud/o00EdWZ+/2BgcbcsbOfxlDv9mVMEX5OeFQ
         733Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749153344; x=1749758144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaGimUCU1zGGvfY9Mn8mz26Pj9z4GAUe4JLOgwbUwZQ=;
        b=ThakkxTU/xA/7h2TD4RVIGCCmf32kfAipfFzQfBM5+algh6dHv3RAt8ROwvDZ7enay
         U7ov217tsAKFkqvOAQiYlvcOkLXPqrddnknUqJQwA2bNsRzH2U3krMSie1hEZirgaa/9
         Ey1QeNeDkW/cFy2emJAM3D6mzzTEOKI2/9XKlJqLvwfPYdWU9SVf7u5DvzLkC+Yeq59/
         bVwzma/3t5VdOqprhPIDYj9J3yXJcsHvHRXBKurOhcg8g04fUjMb5eEqjx3++VqwmeRg
         +DskDY23Ewk5sgz3/MDucKgqtCxxOkHvqc1BKIdW0KwoZ7GRmHZX0oefN6QsMjWpolWY
         2HDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGbzkJcZp5HoXGFK1P67vLUVNLodyuoeyAveU4tsfkJ8D1S3fy7lzJyyZqNJSx29zVPMzIozrmdb2v@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwRyQorYYdFXiHyAHmTLaYIJEQbI54j51798Bl2luOdRtkh80
	uSluEB5Ww9Ejpv+F5caFmTswveVqEuJt8mOL2b2WwEmQaLfO7xJfZ9D/ktq25Q/SOx3qwL6auzi
	8BJYGdySW2lnQErckGX9BWRqHeCqx7IXsqZxRK5yV
X-Gm-Gg: ASbGncuNQVhV7Nf7JWpcwk+fxeNPLas5HhXiU1uLc1LbF0UrGs5GxBkzzknAH1VYFOn
	NfivHg+DpUm1ygRFvY6oqOwphqMySceXOAj6dQm2Cc5JQDu59dBm2HKAN4SfChV1iSL3FMThPyD
	Hw8zN5pmBi20DDfrBQEY9rq2p0MaL8ADg4Rg8ne8HLJBx0pz8hJQkIMcg=
X-Google-Smtp-Source: AGHT+IEbDYUxJCrIU5Brh7cnuMJfzIWyAE8NR3PlzWoOLOAmknLGWMiWPBhbHrXSP1lOx8L1UkuKv0q/wSg0HLr5qIM=
X-Received: by 2002:a17:902:bd01:b0:235:e1d6:5343 with SMTP id
 d9443c01a7336-23602368069mr421065ad.20.1749153343599; Thu, 05 Jun 2025
 12:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604025246.61616-1-byungchul@sk.com> <20250604032319.GA69870@system.software.com>
In-Reply-To: <20250604032319.GA69870@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:55:30 -0700
X-Gm-Features: AX0GCFuuQ92ndxwEnSpPABdXmG7bIUeEpcPA_xt_UklLH28k3XHKW3c6yOYdwC4
Message-ID: <CAHS8izPNKe+3A9HAk13idouEzvePnp5Tih0GmSQNzEcsxuvoPA@mail.gmail.com>
Subject: Re: [RFC v4 00/18] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org, 
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com, 
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:23=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> On Wed, Jun 04, 2025 at 11:52:28AM +0900, Byungchul Park wrote:
> > The MM subsystem is trying to reduce struct page to a single pointer.
> > The first step towards that is splitting struct page by its individual
> > users, as has already been done with folio and slab.  This patchset doe=
s
> > that for netmem which is used for page pools.
> >
> > Matthew Wilcox tried and stopped the same work, you can see in:
> >
> >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infra=
dead.org/
> >
> > Mina Almasry already has done a lot fo prerequisite works by luck.  I
> > stacked my patches on the top of his work e.i. netmem.
> >
> > I focused on removing the page pool members in struct page this time,
> > not moving the allocation code of page pool from net to mm.  It can be
> > done later if needed.
> >
> > The final patch removing the page pool fields will be submitted once
> > all the converting work of page to netmem are done:
> >
> >    1. converting of libeth_fqe by Tony Nguyen.
> >    2. converting of mlx5 by Tariq Toukan.
> >    3. converting of prueth_swdata (on me).
> >    4. converting of freescale driver (on me).
> >
> > For our discussion, I'm sharing what the final patch looks like the
> > following.
>
> To Willy and Mina,
>
> I believe this version might be the final version.  Please check the
> direction if it's going as you meant so as to go ahead convinced.
>
> As I mentioned above, the final patch should be submitted later once all
> the required works on drivers are done, but you can check what it looks
> like, in the following embedded patch in this cover letter.
>

We need this tested with at least 1 of devmem TCP and io_uring zc to
make sure the net_iov stuff isn't broken (I'll get to that when I have
time).

And we need page_pool benchmark numbers before/after this series,
please run those yourself, if at all possible:
https://lore.kernel.org/netdev/20250525034354.258247-1-almasrymina@google.c=
om/

This series adds a bunch of netmem/page casts. I expect them not to
affect fast-path perf, but making sure would be nice.

--=20
Thanks,
Mina

