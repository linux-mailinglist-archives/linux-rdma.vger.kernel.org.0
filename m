Return-Path: <linux-rdma+bounces-9183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825DA7DEBA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E771B175C54
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC7253B6A;
	Mon,  7 Apr 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsfL50OM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A724BCF9
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031651; cv=none; b=ezUN09y4NtAadMR0+YDIE+VYrsERcIh3yZ0AYi7GhPv4wHsYbEV95t8wvcOyGbWpKF9qWJ2z69le5Qmu+eQ5kOJcspCwoA2hhK8NbcOmu/fRx0PsZzqDAhqbzzwKiynvEwqboZ61wVFaQzj2Io+cbbFrT3+Kghkwafz7M45wa30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031651; c=relaxed/simple;
	bh=MptCtTBgjqA4wG6+vocwrF37pI9/bDP9Ih0yctlcMbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TlfGyjNPhbWSiOg/n280jrlBfDRd2HOQevhQvZFl80+OOoYAl3SwuTTA8yprPG9fb0YJevLVUOka2fnymmDzHupWnzxmJzjKNSBXIt6eZND3IAq5Wvp5i65mjNv5Ps5w2nnmNKILzdL3cdxzXk4T7Ako3ECsnbbRa4+l7SKp71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsfL50OM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OllSiN0eUkcOVIrXz329Q1Mf/3+77Twh9+vlNXCNGXM=;
	b=bsfL50OMunujyjFhNfnQ9XnG/+/nSwJuFmil4J9sP361TzjRsmLP8CxWf9Lxdb36Gb8Byu
	oRpcX4UnK3xgjm8TbCWqIJfMQR1sZTFcUR+x+ZKWTjeN+rCKMRB2QUKEN9MVFgsK7eAAA1
	JmsRJWfrBNuNASH/FOpxpJTodS7y0oY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-J9ujclCuN9Koy6N1021c0A-1; Mon, 07 Apr 2025 09:14:07 -0400
X-MC-Unique: J9ujclCuN9Koy6N1021c0A-1
X-Mimecast-MFC-AGG-ID: J9ujclCuN9Koy6N1021c0A_1744031646
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso428047166b.2
        for <linux-rdma@vger.kernel.org>; Mon, 07 Apr 2025 06:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744031646; x=1744636446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OllSiN0eUkcOVIrXz329Q1Mf/3+77Twh9+vlNXCNGXM=;
        b=oNPXShNOEKy4uT7meIgn0calm6R0AStR6GjVw7BJZhfLgPK9+53FYXsj5xeAcRDO61
         xksPuwNItazX9uxTVauk71GZe0tqNNxciJxFzhZbouS/Uli/a8aQfzA7BAjVdThbSMY0
         H4WNparx8lJzk7KqfpWd8H4FICZ4rH0wozEz/LBbuECSlW5ijPscCfybUxwH4wwJvOGU
         5Z1GRf1eBb7UPJJeKKDVmtlLKONCE3RYfrX9OluhSKP8jcLi3MQwfYshNWzATPs1BsQy
         3flHb5OXEk1GW6OCPSv2WwTgA4V+25xO6PWPq/Tz+yyO0dDhOyWyJpbXPxhfBvYypA8g
         +4lA==
X-Forwarded-Encrypted: i=1; AJvYcCW2k369aivJWrRKk12AxeofLMXF7vVfKFSv2aExXmMMGWJyQe6X2zNyyFeNAb1R7GQ6T5e6l9hNtsa+@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVwdt9DWxvKGS9nGgjvScUm3YRdXC21KkeYijvANY1GGbUqsw
	loiEFqH4igzUO7BFg40YorSEHaoWbILjcuKeYDxmWRd4W/Ip2M+LF00t1ML48O2IbSxh+d2LMbf
	TOYReJCkBCzCUZGVi1EI72lMwXHNNCgsbUVzoccC3m9U4LciwyUX95v/cA8R0Ilm4fK8=
X-Gm-Gg: ASbGnctYbQWoeVlH0rHeDRHGXslN5bnR+U6EvHfH0UttatdbAWuAsp2TxQFKjCc6SC2
	RfRDb0Zgw5MG69OEyn8ablQYBFx/nU45qBRsuc6vUbTfsU0jhJRz4Oru3osOOmeBnsN7fj9gneH
	WcggJmatALkHlBFpSJP7kRaG0zxo88+1naRCYnpwAZaRytxIrUT4PQ3HwKnu3Gh+/0ffLiz8bbV
	ahr5TmRAtH1Rbhjvq+kNJlOzC47BYp6WLdEfGXR0agqQK5VTJxSix457tCPms46YjPiVVKrJX4I
	+q3hA6wTQReQ
X-Received: by 2002:a05:6402:42cb:b0:5ec:922f:7a02 with SMTP id 4fb4d7f45d1cf-5f0db81b649mr6165656a12.10.1744031645900;
        Mon, 07 Apr 2025 06:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGavQJlmmghtqSg9iLbaBJHfh2I8uG3HzWNkv49MzKEgM7vcl9P3RYd3+0DSM+pvZQMRNiEeA==
X-Received: by 2002:a05:6402:42cb:b0:5ec:922f:7a02 with SMTP id 4fb4d7f45d1cf-5f0db81b649mr6165640a12.10.1744031645440;
        Mon, 07 Apr 2025 06:14:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087f0a9c9sm6969011a12.41.2025.04.07.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:14:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C40FC19918A1; Mon, 07 Apr 2025 15:14:03 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 15:14:03 +0200
Message-ID: <87v7rgw1us.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zi Yan <ziy@nvidia.com> writes:

> Resend to fix my signature.
>
> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> "Zi Yan" <ziy@nvidia.com> writes:
>>
>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
>>>> Since we are about to stash some more information into the pp_magic
>>>> field, let's move the magic signature checks into a pair of helper
>>>> functions so it can be changed in one place.
>>>>
>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> ---
>>>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>  include/net/page_pool/types.h                    | 18 +++++++++++++++=
+++
>>>>  mm/page_alloc.c                                  |  9 +++------
>>>>  net/core/netmem_priv.h                           |  5 +++++
>>>>  net/core/skbuff.c                                | 16 ++--------------
>>>>  net/core/xdp.c                                   |  4 ++--
>>>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>>>
>>>
>>> <snip>
>>>
>>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/typ=
es.h
>>>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb=
26173135ff37951ef8 100644
>>>> --- a/include/net/page_pool/types.h
>>>> +++ b/include/net/page_pool/types.h
>>>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>>>  };
>>>>
>>>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_m=
agic is
>>>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve =
bit 0 for
>>>> + * the head page of compound page and bit 1 for pfmemalloc page.
>>>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid=
 recycling
>>>> + * the pfmemalloc page.
>>>> + */
>>>> +#define PP_MAGIC_MASK ~0x3UL
>>>> +
>>>>  /**
>>>>   * struct page_pool_params - page pool parameters
>>>>   * @fast:	params accessed frequently on hotpath
>>>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)=
(void *),
>>>>  			   const struct xdp_mem_info *mem);
>>>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>>>> +
>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>> +{
>>>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>> +}
>>>>  #else
>>>>  static inline void page_pool_destroy(struct page_pool *pool)
>>>>  {
>>>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct p=
age_pool *pool,
>>>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 co=
unt)
>>>>  {
>>>>  }
>>>> +
>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>> +{
>>>> +	return false;
>>>> +}
>>>>  #endif
>>>>
>>>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref =
netmem,
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e=
0d198947be7c503526 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -55,6 +55,7 @@
>>>>  #include <linux/delayacct.h>
>>>>  #include <linux/cacheinfo.h>
>>>>  #include <linux/pgalloc_tag.h>
>>>> +#include <net/page_pool/types.h>
>>>>  #include <asm/div64.h>
>>>>  #include "internal.h"
>>>>  #include "shuffle.h"
>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page=
 *page,
>>>>  #ifdef CONFIG_MEMCG
>>>>  			page->memcg_data |
>>>>  #endif
>>>> -#ifdef CONFIG_PAGE_POOL
>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>> -#endif
>>>> +			page_pool_page_is_pp(page) |
>>>>  			(page->flags & check_flags)))
>>>>  		return false;
>>>>
>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *p=
age, unsigned long flags)
>>>>  	if (unlikely(page->memcg_data))
>>>>  		bad_reason =3D "page still charged to cgroup";
>>>>  #endif
>>>> -#ifdef CONFIG_PAGE_POOL
>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>  		bad_reason =3D "page_pool leak";
>>>> -#endif
>>>>  	return bad_reason;
>>>>  }
>>>>
>>>
>>> I wonder if it is OK to make page allocation depend on page_pool from
>>> net/page_pool.
>>
>> Why? It's not really a dependency, just a header include with a static
>> inline function...
>
> The function is checking, not even modifying, an core mm data structure,
> struct page, which is also used by almost all subsystems. I do not get
> why the function is in net subsystem.

Well, because it's using details of the PP definitions, so keeping it
there nicely encapsulates things. I mean, that's the whole point of
defining a wrapper function - encapsulating the logic :)

>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>
>> That would require moving all the definitions introduced in patch 2,
>> which I don't think is appropriate.
>
> Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywhere
> in patch 2.

Look again. Patch 2 redefines PP_MAGIC_MASK in terms of all the other
definitions.

-Toke


