Return-Path: <linux-rdma+bounces-12399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB0B0E65D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB697B07BE
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93195289340;
	Tue, 22 Jul 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KASwnnT1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B82882AD
	for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222821; cv=none; b=L9qtOSGxOS8xU0JU+1Nqn9h3BSqPraMwM0ghZBxe7ZatYcXvi7yaLD7Cb/cQEDSOVao0h1jlzHud7saRdrlV4lRT0kJQ4AnY1ocJpHY+x25GoFhHCzRBuITkaZ5/TxDO6XBHCcapTIJ3GFKMgMmuMnUA6FaYTyj0e1Noz6ih974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222821; c=relaxed/simple;
	bh=KocGrJA2Ps6aJTENvIIuem9ofzkRJ4o80JKPBVLHtCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFu76KsvU5YOgw82VS3wEhX0egXOFZ5hFT9ATGUyqhzuhVSqtKGT2FsN1ZJZ4+YDXtlLe9i5UHbqDHYJdn7JvUu9L24cBSyJY6anEMmu/LY+dPiZMDX3ZMJ+0AVIJhj9QgVRrCFe+3RryelnZBd2TNdeJgFhql6oSkv22F8yejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KASwnnT1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e389599fso88115ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753222818; x=1753827618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUgAXknrynl1PVAEbmko9jsFy37xoKt232CbGC5xnSo=;
        b=KASwnnT1IM0bapm3dBB3dF81HbyN89veE00MpoJJ1OtroNdUXXJNGsBi64zmjp9V5F
         n7pRoAUpB9JIyIW5H561rHqf7vGcun47h3TWHAXxI1/Y6+ulYnkDKvb/cTz3a/HPzxu8
         ztUXgEUurG+RGd7KItrM3N8W0bkzekWWQCvy90jYqdrqAJf0GWg4XE48S61rwDJO9QvY
         pWjilfx+wPYllh12cIMMpOGIYGJuJLk9KJRAfp4ifIGH1GcsbiAPETOjpO56vefNt0Gj
         GCRfwpz523C4/1jCnCCcIAQPWisXUNBFI8cV4msd1RZm99kerwe7kokTUNJb6efKRShi
         SKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222818; x=1753827618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUgAXknrynl1PVAEbmko9jsFy37xoKt232CbGC5xnSo=;
        b=chz4q+Om5MSTYFigJd1SfpUApr3rJioFqscFS8EHiA3Ws5yj2d+eMO/qn+Qs6zyx6E
         ObI0c9JauCCEZSOEhaVufccl3h04bDSJJHFOxF1Qt7Lkxxyr/eN7toIE/+d4sVg8KfbB
         12SllrFYFqcrr4yx/yJsSKz848A08U8emD5kE6SIQWNgHVqqBIjc3ciCT/e9ZspFxmdX
         7U0MPHUSaBQjqzOHgu532zhluODx3BcJ4PS5uOF90xnQ3doyKVzOE0LCagzk1dgQiZMP
         hTujkNG2zx3zIq3ZH0koVBAqmI4SvNF1GOn20Mqtn8K+g39KX1PlNG+rhn8H9AFYZJsk
         tR/w==
X-Forwarded-Encrypted: i=1; AJvYcCV32Ne30GoUyEuta4hwEph1BBGSFa3/UQ7dbZ5w/iKHWD1PKNJXWu/AjvFUAuiB8lIRMEtNkaDIjNok@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2MX78vuZULZH2iTpwP9Kr+roRK/J6dSZqw9USM/+dhCwOeau
	LX34cn1QFuKuoqz6+0B5xcHR/ug3+S1wopns6tTTTRogf0IKB2Kxp2/PmUSBMexl7vEzjeX3Br6
	sf7uTYkUBZ77xi7yPX6GTKAaqHSIwxWgGQIw4v3KW
X-Gm-Gg: ASbGncuqsLtxX4UMIMqxsQWmBle9E2VYEJsPrUwVwpxgCl1PFcqQqKzVa24IhF2ESK+
	AP9FcPUVwQCn1H2ln1Vgw4qeE+39awILF/pTW7bDVdDmw4NtLt44O3kR/FV7JZe5ZLJr2P95jhq
	gBfX5Qt2vpXuOmnyTcX+uQhvc/tOHDF/knbl8FGTH1Eiuhf9ccPNKKqtiEEUNkPL1UyjKfHW6mO
	iJQVO45xaQLFPDc2JaqD24R9J1Lr5LNtAoaWvGF99+3hSca
X-Google-Smtp-Source: AGHT+IEJT44DyruhFdmOQYM4W96ZZ3Rqdwh8/66PV5JlsG3oxzJ17BtYsAJ9a8lIS9JPty9YbWXGIDpfJrmGPSXLLK4=
X-Received: by 2002:a17:903:b4f:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-23f9774a735mr1113195ad.6.1753222817810; Tue, 22 Jul 2025
 15:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721054903.39833-1-byungchul@sk.com> <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
In-Reply-To: <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Jul 2025 15:20:04 -0700
X-Gm-Features: Ac12FXzc1yuJwF_iFb86CzQvJ9VHTzSRxkDhmv6GFozlbXOI8GKQHpDpguZKYVU
Message-ID: <CAHS8izM6h1_qoPnWDHmPiiFj5e_mcJqQFTTLJT9dgBymJuk8rw@mail.gmail.com>
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:11=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/21/25 06:49, Byungchul Park wrote:
> > Hi,
> >
> > I focused on converting the existing APIs accessing ->pp_magic field to
> > page type APIs.  However, yes.  Additional works would better be
> > considered on top like:
> >
> >     1. Adjust how to store and retrieve dma index.  Maybe network guys
> >        can work better on top.
> >
> >     2. Move the sanity check for page pool in mm/page_alloc.c to on fre=
e.
>
> Don't be in a hurry, I've got a branch, but as mentioned before,
> it'll be for-6.18. And there will also be more time for testing.
>
> > This work was inspired by the following link by Pavel:
>
> The idea came from David, let's add
>
> Suggested-by: David Hildenbrand <david@redhat.com>
>
> ...> -
> >   static inline bool netmem_is_pp(netmem_ref netmem)
> >   {
> > -     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> > +     if (netmem_is_net_iov(netmem))
>
> This needs to return false for tx niovs. Seems like all callers are
> gated on ->pp_recycle, so maybe it's fine, but we can at least
> check pp. Mina, you've been checking tx doesn't mix with rx, any
> opinion on that?
>
> Question to net maintainers, can a ->pp_recycle marked skb contain
> not page pool originated pages or a mix?
>

IIRC last I looked at the code ->pp_recycle technically means it could
be a mix. Technically it means "consider this netmem for pp recycling
when the skb is freed." and non-pp netmems don't get recycled to the
pp obviously, because napi_pp_put_page rejects recycling them.


--=20
Thanks,
Mina

