Return-Path: <linux-rdma+bounces-12200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CBB06679
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF4564A13
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7672BEFF5;
	Tue, 15 Jul 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk8z4fdz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632712BDC3E
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606413; cv=none; b=iesZIaNMg1MARFQAhQmK1Vu7KwfK9S0cJ6+kCcOp+nZU2BySXizfEndBgT5DCf16h4SBT4apXC+vkVlV7NlMRnUsFU7gPAC1MkSaLjr4Cplsf5SHbaRpUq/CAu2VaF6OtTCr2BbaxYPrW7ro9hFOaW+aJ4LSsMlmhYbxI7YB7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606413; c=relaxed/simple;
	bh=sN4QN3SKsFD89oM64C8vf3kZbJolgxRcrqdfdWWS2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI1JPNniUWq9dFFFCprr8KK5S6OqRFE222vC2LXeA06blQNwZ0lvh78+ulvgFDe9WxDMzfHaso0foAdED3cRZQdCpM8DdGNvnp4e1tD7BaglKN3g+V7kR/qu/TRuIJ/oziYZd09jQp46DJOMUTV6Zw10rp05euYE6xjx/j8bUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk8z4fdz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f18108d2so46315ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752606411; x=1753211211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzQixld7pSKyZ/Q/HfBpbSkDP1wbVsZogbStCOaFhmk=;
        b=Fk8z4fdzie74innj7D79z4BbhEvHGRuB1AHDlsTBByDHH0KNTWCoC4qhYasoLNxbHF
         XTWZo11HpXYIweZnSxbNiqUSjT7JcrAzglobEvdX/oeKEPoqIvq2UzcmOeAB/S2M/Ti+
         e5FPyUwzsNW6UkGsxVGnjJvL9osjGKmwnNEUJFahgwffrzNnZdmu604N04mYO+3AImpx
         mo8s5j65R94/oJNjlUcXNtGT97VuKi7tq+ndEhvZCIC8rFz4I9RDAzMEhXH6x3tpFCfX
         cirpjfF0CveXPdB8ReKX3OUU0zAafDeef17Kb4N4jD561W4luksmdvpoLKp11JBeKtGv
         R5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752606411; x=1753211211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzQixld7pSKyZ/Q/HfBpbSkDP1wbVsZogbStCOaFhmk=;
        b=n2PZSFfNswCODmL6PdP/2BK8RPxlRCsCXZIDvmgK8/NCOD6sn7YxxI0qN9FmofxlDe
         IcUh2PM5UGNSVzw+cruRVSa29tQNNVCl6GgEMzHrwSZ8p5aOKcSfOz1pvBZlHy2H9VI4
         bM5m1jiMGCvH66hjo90Q0Vlw9ckqfSJPbCCf1CtwaRCVJAwWpmNi0kLxdP0ET0xXL+kR
         kq+RImv1HtYcMZRvN2HBovQ2lprMzzyifLsn8bv2PasexJthFQmXEDRyDUCGShReD3a1
         gE+oEk/5wcDsWVK8iHS8XsERzK6v5bPGk7KwvlodLQ4DSyMJ60tz4hEalyMnAJC+Qm10
         geww==
X-Forwarded-Encrypted: i=1; AJvYcCVmjSUj06wny5ON9QZ5zk/FRXhZH5OFmrB5Z1S4jVPu0dEhfXa3X4UTQE+I8HW8eaXs3pzNAEAACoM+@vger.kernel.org
X-Gm-Message-State: AOJu0YxHat6Pj99paIAyvJu4GjFmuE1P3Fn5LCPKc9qBiaSjVm/gZqkL
	fCm0e9xEMrM46Aqq3s9pVcSWT9BJVZpMrhxI3FF7/UMhhxwRfSbxx3jD4LS72JecUyx6Xm/z5dC
	x7xs54On4Vslt5KB3eXBZy0Tn8oEjRhJIqhQBYEPZ
X-Gm-Gg: ASbGncsv23WaEfyUG+IUluqGAKbaAxMMF7hIXqxFmEDDASJ/C2Y/2ly54bwj3SWsywC
	t2lLHkADIoRau9Nnb0Wkx0eVw8s9/sfBjpwXGDV5N9GkyaAScHQY2Qo/Bk8qC8E7MXfOxON9t9i
	yo2NGxoLHpTU85fjmqvTowXU/D2Itx8x9RAH6TJLaThe1/IOgV9MhTJ/1FLG4GmvkAyp60m3jC/
	CgbmKYHg+WNgUCT3zqod1MIRoFsHkvHTwHjBQ==
X-Google-Smtp-Source: AGHT+IERW8BNAcLICEi0xDHHwbh6I9mZCyIk3Mt306+jQnPwqHCieheEaqBVCmnvb9hqZyStUnuqxe9DuyWkdC9x3QM=
X-Received: by 2002:a17:902:cec3:b0:235:f298:cbbb with SMTP id
 d9443c01a7336-23e24c6e119mr315625ad.26.1752606409905; Tue, 15 Jul 2025
 12:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com> <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
In-Reply-To: <9bed2f6e-6251-4d0c-ad1e-f1b8625a0a10@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Jul 2025 12:06:36 -0700
X-Gm-Features: Ac12FXwyUUoU8xGdECWjpzai5Qr9bPwFw8HDcAUKWZbO5pnAVYeauYEt5y8_8Qs
Message-ID: <CAHS8izMYLw3JfonoQ7n4ZaWivdBVKqZejgyRiAku5j1rx7gBPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, akpm@linux-foundation.org, 
	andrew+netdev@lunn.ch, toke@redhat.com, david@redhat.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com, 
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com, 
	tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com, 
	horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org, 
	matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:36=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/14/25 20:37, Mina Almasry wrote:
> > On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul@sk.co=
m> wrote:
> ...>> +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *p=
age)
> >> +{
> >> +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> >> +
> >> +       /* XXX: How to extract netmem_desc from page must be changed,
> >> +        * once netmem_desc no longer overlays on page and will be
> >> +        * allocated through slab.
> >> +        */
> >> +       return (struct netmem_desc *)page;
> >> +}
> >> +
> >
> > Same thing. Do not create a generic looking pp_page_to_nmdesc helper
> > which does not check that the page is the correct type. The
> > DEBUG_NET... is not good enough.
> >
> > You don't need to add a generic helper here. There is only one call
> > site. Open code this in the callsite. The one callsite is marked as
> > unsafe, only called by code that knows that the netmem is specifically
> > a pp page. Open code this in the unsafe callsite, instead of creating
> > a generic looking unsafe helper and not even documenting it's unsafe.
> >
> >>   /**
> >>    * __netmem_get_pp - unsafely get pointer to the &page_pool backing =
@netmem
> >>    * @netmem: netmem reference to get the pointer from
> >> @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(n=
etmem_ref netmem)
> >>    */
> >>   static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> >>   {
> >> -       return __netmem_to_page(netmem)->pp;
> >> +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> >>   }
> >
> > This makes me very sad. Casting from netmem -> page -> nmdesc...
>
> The function is not used, and I don't think the series adds any
> new users? It can be killed then. It's a horrible function anyway,
> would be much better to have a variant taking struct page * if
> necessary.
>
> > Instead, we should be able to go from netmem directly to nmdesc. I
> > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
> > it return netmem_desc instead of net_iov. Then use it here.
>
> Glad you liked the diff I suggested :) In either case, seems
> like it's not strictly necessary for this iteration as
> __netmem_get_pp() should be killed, and the rest of patches work
> directly with pages.

Good catch, in that case lets just delete __netmem_get_pp and there is
no need to add a netmem_nmdesc unless we find some other call site
that needs it.

--=20
Thanks,
Mina

