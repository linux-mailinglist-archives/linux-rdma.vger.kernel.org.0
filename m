Return-Path: <linux-rdma+bounces-12159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0882B047F5
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F2A16284E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1F922AE5D;
	Mon, 14 Jul 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1M90BpX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2C1D5146
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521883; cv=none; b=rt4wwMjgz80/QjJeFi+Y2AhgtkeE+F9IzPIHDkKYYLodeTjosBnCmXJPebt0BHSP6rC/0Wb2zCfrcV6jYor9EZgqkLoAQ6K0hv24FWjHq1VCUdeVW8flej/3qotwO8Kgvoe6w4pFGEpCDxea0TchVTKDwv6gzJyh5F/3y5sZ1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521883; c=relaxed/simple;
	bh=RuizpW+k5+vTtumJYCWKYy5gPaN3AKaoyO7UTkvu0eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFp2Z5sV6d0OldXmgaLy7Zr++8HWqg2wEJYtIqnWl27jpZilBjjwOzLgZIfltMLXJRPR2dqJSJKm+7c3uhadcrCoLFYGsWs0y9wmSYLOO7FMem3NK+nhNAtKGi0G2jyma1hcGVZGVleUqd93rOrZuKEmV1XdwYdO0Ehs97OHIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1M90BpX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2357c61cda7so2585ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752521882; x=1753126682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yry2upj+ByeYrrNjZKRJ8sVD88C6f2FVJf/Y5Atdgbc=;
        b=s1M90BpXsGLpl7h1jNPGwF99iWdqLOP44cMc+P4qOhNiLiJQDx8ZA2bApdgIUTObql
         p7pzNea60VvmMJWXIxG58iS5+ZMx3AUKgFf0jmN6nxlivl0DoCvNh7VQzMMog9d3G2U2
         QA3WYAGxjUImrefZsIFaBQLVVr0O/x3NzxD2UOi52+g+qjwnC8MGHUlCMvg/JTMdnhI+
         iHjSmiZXnofDqRnQ6D5vvcSxH0SMnSGvlWkTJ6rGk4kDy+sMAE7p1GU7awEJkOig4hg0
         KHLZ1v+MZqEoHZHGTn2DcEkHYk0j3fHla4CXdn3ssf+VLS1fWKlc231p7yOxtHyROakL
         xgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521882; x=1753126682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yry2upj+ByeYrrNjZKRJ8sVD88C6f2FVJf/Y5Atdgbc=;
        b=XSMGXN1n3TcihU3iRlnRKsjUomiJcqsoW2nhIfvBWKPxIxneqn4MDMlWjq8K+GTCDa
         ngbHHjE2t2b2EpxX548qoiwM/f9s/K+SrwL/rnbUcIGKt9yFo4AbqsxQn4knsuM9mqfl
         0nasP6cFAIOlXKu69y8HQcaS3f1l/wlV/y843RaqDrMcIAFZULTiKvf4SUbYyyht5jBl
         P+g3jhU9j8yFCxKve0850wOxQGPiivsjYEtqmhbPgZTwQP2PQxvJrsgkfZxfnQaLsZhF
         ErQmsVMcBtSBWFo0xZ2lLVYRmUUZL2RmccyyYUFE3LyPq+3kcl8TI/EDggnJ0mVveHJs
         1+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW45CdMNrqBgyM9oH1HOqOu+s/YZUClc/gcDltLMZmEiPKblF9h1c6rGi7KOeRgl49B/yKvwPBwVUR+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XFywjnzZeT1JM6cB8eX4VVboWHvHPx4+64yeZiRvNycaYDMB
	FlxDz3Siuz/z/pPIC3MyUG57ThYf8SFbCQVBcpWGYrGFEHuFbFVcXuyh3FoEdHwlMRm2W5zHxOD
	cHO5H2dUOwXeX5gC36IU2gKXv1YXqIQZaRb82oLt6
X-Gm-Gg: ASbGncvJUgchFv4iTSW7bNZF0YdSkyVgBZX0V85rCvkk8AunYhBbWJ+ca6wdBh+mQFD
	eZTgVqzHl9nRNqWN6wg0gz8HejQceTrKmeGzi6RL0gW8QcyZuT7s70pfgcbiXSmnZWX5/JT00OY
	hchPxUP+97ROFKb6U/HcDwKRVwY2XVYRiLlPS/0qQj/cE1ZX7ifw4+80d63aMYpXFo8fFlJyly8
	8Q4HNLeWl8jJRIUXDAcLUmnkuuUWDseemqK1w==
X-Google-Smtp-Source: AGHT+IHZoWQ8pLUOjiCQlGlcYIPNmYT9TX3giO0kqF0O3T+xtLnHFh+M02Pq+s3+TLFDvQ9elFBdwtzpJc9HYJVxyEM=
X-Received: by 2002:a17:903:2484:b0:234:b2bf:e67e with SMTP id
 d9443c01a7336-23e1ac4613fmr298445ad.13.1752521881303; Mon, 14 Jul 2025
 12:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
In-Reply-To: <20250714120047.35901-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Jul 2025 12:37:48 -0700
X-Gm-Features: Ac12FXwrdXtLbiJlmPY9vk8GjB7CqgoZsH_hsU8OuZVjZ5CbRybhtkUh-Kkp2jg
Message-ID: <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, ilias.apalodimas@linaro.org, 
	harry.yoo@oracle.com, akpm@linux-foundation.org, andrew+netdev@lunn.ch, 
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com, 
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

On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, __netmem_get_pp() still accesses ->pp via struct page.  So
> change it to use struct netmem_desc instead, since ->pp no longer will
> be available in struct page.
>
> While at it, add a helper, pp_page_to_nmdesc(), that can be used to
> extract netmem_desc from page only if it's pp page.  For now that
> netmem_desc overlays on page, it can be achieved by just casting.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 535cf17b9134..2b8a7b51ac99 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_clear_lsb(net=
mem_ref netmem)
>         return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
>  }
>
> +static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
> +{
> +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> +
> +       /* XXX: How to extract netmem_desc from page must be changed,
> +        * once netmem_desc no longer overlays on page and will be
> +        * allocated through slab.
> +        */
> +       return (struct netmem_desc *)page;
> +}
> +

Same thing. Do not create a generic looking pp_page_to_nmdesc helper
which does not check that the page is the correct type. The
DEBUG_NET... is not good enough.

You don't need to add a generic helper here. There is only one call
site. Open code this in the callsite. The one callsite is marked as
unsafe, only called by code that knows that the netmem is specifically
a pp page. Open code this in the unsafe callsite, instead of creating
a generic looking unsafe helper and not even documenting it's unsafe.

>  /**
>   * __netmem_get_pp - unsafely get pointer to the &page_pool backing @net=
mem
>   * @netmem: netmem reference to get the pointer from
> @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clear_lsb(netm=
em_ref netmem)
>   */
>  static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  {
> -       return __netmem_to_page(netmem)->pp;
> +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
>  }

This makes me very sad. Casting from netmem -> page -> nmdesc...

Instead, we should be able to go from netmem directly to nmdesc. I
would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and have
it return netmem_desc instead of net_iov. Then use it here.

We could have an unsafe version of netmem_to_nmdesc which converts the
netmem to netmem_desc without clearing the lsb and mark it unsafe.

--=20
Thanks,
Mina

