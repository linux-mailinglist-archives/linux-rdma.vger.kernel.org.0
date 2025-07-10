Return-Path: <linux-rdma+bounces-12040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC01B00B28
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0531C20D30
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE232FC3DC;
	Thu, 10 Jul 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4TOwDzQO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A42741BC
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171126; cv=none; b=Ro10s879cTk6sypMYhPjbd+AxF3khlanSgeehByO5cHYGmCYb8RhTvIO3XVPToOp5m2uv9HA2drOVFw1osuuX8tTMqEZfJ671nKk4g4fxqBWcJt2UB+FQzCXAL5ttDSJ/WW+Qnysbcl8Dn33xD+mmfHTOOK+jZyTJHfmEFeXWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171126; c=relaxed/simple;
	bh=NsIibMpgdUN/yNMbmmDbm0dvimOJR7mqvk074U7Gs8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMPdeFnUJVs2W7RvpDm2LfNMuy/RfJRMxqOJmJqPqJmjGYhd4nz/qychGZwooZFcCEtis12GNXs+oWqFt/hzsrfBu3Ud/XJSXzSt/m5jSeQOMJTd/ZKQhK5SAhW4bNbN7MF52+677lG84gKVzijVT1y205FiQSp8ZSsiECBQ6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4TOwDzQO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2357c61cda7so20945ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171124; x=1752775924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V19aqiboGpdwFSVORlEjus6nArpZ/d5eCyXiiM9x078=;
        b=4TOwDzQOq1VFdnRRMcAzz6wv6QmBIJ69gWAcJoEJXPx94BIcF5gLWHNAbxkxVhg6MI
         4PDL/6srqbJJGP5zxVAsKiCzHbhtPmTrkECmVpcm6gddpQ2/6SKivbIAamiS9Gn3UYQG
         j949T5OmuYoAD4ut4lkw8BgTWfTJHefaimbn3sE1QXDhULsGGCzVpgHAAc5HheIS/tYh
         oRi4mqFnRycbx8/jzaOhX1N0M9OcSFDsexJB4eQAW9ZrCDLTD4sraEiZ+Yv3dYEuNXL0
         IkPnbCh7fMyS2ZcNCUZ8th4x/lAuHJui0dGdikPaBKw0Rw7DI9tihBEM60UUGyJRPiAA
         1TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171124; x=1752775924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V19aqiboGpdwFSVORlEjus6nArpZ/d5eCyXiiM9x078=;
        b=gB1wMHE8HoLgA+26GcHE7ymi0QOr3AQKxDjBiJjsuraX/IKDhMadc8Dewc7l1znlcF
         CFp8eBJIUZc3HWDUZpwAEETOyhmgCgk2TLQDgaRNbXtb68ytVPgLvjfQ52t/VSMiwmHZ
         ANO5wAdqHJnqaCWyS72RT+lPcLI+qSalgdL02CTNY/T5HYuyGZiANtGO3bSA758ZkZQv
         k6JAiUQudYWP24tSsUEsz35j+6HQfzcdgNPs7mElj77Dcz3RdklMjzl9DSk6LF4HboH2
         5WEcORNn6oCrxdxA6u90ga9ZXz2nPgKctsqEWCd6vNSR3K8wz+4aTyr3DRbPZATXlhUl
         xoNA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdAPbfXdhFHkKNp56j434tmzNvBHNYakCjhXFRcGJJADNq7pM502ZC+/H6kZGDsYM75rbqDCDO0B0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/khUesDGOzQgENnHknn2gjs1ve6ZUdPruK4j1PjqPsduFgGcF
	eUPct0RVPzVlFrRV98a9HQs5834HbqA31Wonx26Iw7mX0PqD9yRjIFjb7V5XJu/76vyfRQXpoZ7
	95GbsB0Vbk/pWzSbIn4dMxuIk9ZphnqPqUrzQqFbi
X-Gm-Gg: ASbGnctJRpeCTVAzwGrAJaknSFYHh4l9iAkgwHRHtVIPGHQB9RSdevtFyx+JnPsocyM
	6G9uZERTvoEy6MKgLQ8WK60Tnu/pYCQ5cBWN8XujUPsYtG+JYBTx8IP5Bg1z87GsL7MeDB1icl5
	/tEbP3ibSvJHayZ81jpksp3nYpW3UP06wCCezVlftpwkKKCR3tx/1CBxa+Y+gRMwQZvW99G2g=
X-Google-Smtp-Source: AGHT+IG5ZbAwY31DrTqPKHnuAy3Jprfz+D7kIoMw6GvkmY8szHlEwG6tCQR4HIE6AdRqx8Df7hZn3pf+KBbD+xSG9cQ=
X-Received: by 2002:a17:902:ce84:b0:234:a469:62ef with SMTP id
 d9443c01a7336-23dee4c2b01mr119975ad.3.1752171123623; Thu, 10 Jul 2025
 11:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-3-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:11:51 -0700
X-Gm-Features: Ac12FXwouZPPpjT9QSjhfrgvcsGvhkuRBlZmuIVXl9fEL0h9kvK2OFLOD8o7JwM
Message-ID: <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
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
> To eliminate the use of the page pool fields in struct page, the page
> pool code should use netmem descriptor and APIs instead.
>
> However, some code e.g. __netmem_to_page() is still used to access the
> page pool fields e.g. ->pp via struct page, which should be changed so
> as to access them via netmem descriptor, struct netmem_desc instead,
> since the fields no longer will be available in struct page.
>
> Introduce utility APIs to make them easy to use struct netmem_desc as
> descriptor.  The APIs are:
>
>    1. __netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
>       but unsafely without checking if it's net_iov or system memory.
>
>    2. netmem_to_nmdesc(), to convert netmem_ref to struct netmem_desc,
>       safely with checking if it's net_iov or system memory.
>
>    3. nmdesc_to_page(), to convert struct netmem_desc to struct page,
>       assuming struct netmem_desc overlays on struct page.
>
>    4. page_to_nmdesc(), to convert struct page to struct netmem_desc,
>       assuming struct netmem_desc overlays on struct page, allowing only
>       head page to be converted.
>
>    5. nmdesc_adress(), to get its virtual address corresponding to the
>       struct netmem_desc.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 535cf17b9134..ad9444be229a 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -198,6 +198,32 @@ static inline struct page *netmem_to_page(netmem_ref=
 netmem)
>         return __netmem_to_page(netmem);
>  }
>
> +/**
> + * __netmem_to_nmdesc - unsafely get pointer to the &netmem_desc backing
> + * @netmem
> + * @netmem: netmem reference to convert
> + *
> + * Unsafe version of netmem_to_nmdesc(). When @netmem is always backed
> + * by system memory, performs faster and generates smaller object code
> + * (no check for the LSB, no WARN). When @netmem points to IOV, provokes
> + * undefined behaviour.
> + *
> + * Return: pointer to the &netmem_desc (garbage if @netmem is not backed
> + * by system memory).
> + */
> +static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
> +{
> +       return (__force struct netmem_desc *)netmem;
> +}
> +

Does a netmem_desc represent the pp fields shared between struct page
and struct net_iov, or does netmem_desc represent paged kernel memory?
If the former, I don't think we need a safe and unsafe version of this
helper, since netmem_ref always has netmem_desc fields underneath. If
the latter, then this helper should not exist at all. We should not
allow casting netmem_ref to a netmem_desc without first checking if
it's a net_iov.

To be honest the cover letter should come up with a detailed
explanation of (a) what are the current types (b) what are the new
types (c) what are the relationships between the types, so these
questions stop coming up.

> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
> +{
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return NULL;
> +
> +       return __netmem_to_nmdesc(netmem);
> +}
> +
>  static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
>  {
>         if (netmem_is_net_iov(netmem))
> @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem=
_ref netmem)
>         return page_to_netmem(compound_head(netmem_to_page(netmem)));
>  }
>
> +#define nmdesc_to_page(nmdesc)         (_Generic((nmdesc),             \
> +       const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> +       struct netmem_desc * :          (struct page *)(nmdesc)))
> +
> +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> +{
> +       VM_BUG_ON_PAGE(PageTail(page), page);
> +       return (struct netmem_desc *)page;
> +}
> +

It's not safe to cast a page to netmem_desc, without first checking if
it's a pp page or not, otherwise you may be casting random non-pp
pages to netmem_desc...

> +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> +{
> +       return page_address(nmdesc_to_page(nmdesc));
> +}
> +
>  /**

Introduce helpers in the same patch that uses them please. Having to
cross reference your series to see if there are any callers to this
(and the callers are correct) is an unnecessary burden to the
reviewers.

--=20
Thanks,
Mina

