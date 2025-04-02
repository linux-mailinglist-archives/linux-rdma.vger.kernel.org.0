Return-Path: <linux-rdma+bounces-9116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8960A78CE2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D57161AF8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8761023716F;
	Wed,  2 Apr 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+xMUFUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3720EB
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592232; cv=none; b=DpSnAR2TGRgKD6NLK6FABuJAOmcKvOkRhWLI/1yadLA5OGSKXVrokQxWNU/EsCUiqDyuPyL/TSBqUNxE/rECypXexwg8BjZ8pnyRE40xLDnLP7mdTPkrgAWGJQVSn8SkgTZzQcOYg1YtQXgEoI1BfEXdPQ3JMzRhYqmIAy4VuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592232; c=relaxed/simple;
	bh=hBrVpZMco2DdJlsI3HCswUOJgJewh0D2UlNqIOeFlMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUOq//QjWJg5TZ+7zllTbTh0RvKhmdxxMCue51I4Qn7IsC9ASvqvDy3kriiiJ4gbStNBFFbYJEoHTmU0qmBWDlvxVr6Iq88w3Fect/GueeSm3GnhOh6PMR5D1a+nKXwLHF/J9X77vm8ItV1Xye26hDatkaIIHLmRQjN1iljfa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+xMUFUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743592229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vWh3ZSkArty4GE704JEhJE0l6rYapz0ZdylM6ZVJFg=;
	b=d+xMUFUpttrF/URB302CXOPzHPd0v81I8bufKeTvPVSMCWsOghq+Q3aMfwLvMTZPNwbkHO
	SH3u52qJQmWItk2HJUUBwqMqlQo1RX3QFZjN5RVtPa6514/ArgJtTKWAeFX+lsXoYXB2SR
	6j1ySNORWuwogt4jdYB/Z6DJGqiMDhc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-25zMmkcCOy-mTjVQdeufuw-1; Wed, 02 Apr 2025 07:10:28 -0400
X-MC-Unique: 25zMmkcCOy-mTjVQdeufuw-1
X-Mimecast-MFC-AGG-ID: 25zMmkcCOy-mTjVQdeufuw_1743592227
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab39f65dc10so613495766b.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Apr 2025 04:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743592227; x=1744197027;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vWh3ZSkArty4GE704JEhJE0l6rYapz0ZdylM6ZVJFg=;
        b=fihwkHYgetO+Pir3F2KPWcEaQVF8Mo4Ta0IyMhbLqTXQWZQInpWNS/6/gPc1/gZ7fW
         58y8PjhxINajvMBXBmmP6VNB52L6B6SITawg60vl8EXdGMZkSXnHgKQRs46ledN7QUG8
         v3zNgE7Ei1qjXO9VRprTCGghaxEnchBKgl3IqJEDz1fKNXpVoEQZNM6TQ8LhOsO3yX6e
         omnQ0kGGZv91psLpvnRCKwwBHf2/np+MdtbBMqf7X99wiaZcsavkR0sC+4uRC5Ke5v8p
         IDCSldJWkpAxNUTTJOjMvaUD0jXo/Q2aEaka2/9dJYTaSUmpW8aZ0Kn6Q9rnR3kzX5hg
         vi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvt3firlYNEgcLZ9cA/jGsNZGstnHqv8eoUVDbqL3JXalfO+OijshHG3EiTZj9sKreWwneOJq1rGjP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00Oq2vdz7ApeQJW/+fOmgv2bpVfpDgZE562A+0ui4vKZ/zV4y
	27mH7A65ROuKMh5s45JDcPBedsBcU8s1mD7jyakjLZlFwHEkngtQg+VOW2dPfWtXcj3iK/cXelX
	YzTHy1XEW2ANvIkNoraxRlpbTTzIG4rsQskap8wRTdoyIEB1FjWH5JAj8zxc=
X-Gm-Gg: ASbGncta4OMh4qPNf+UCFfj1GrVv5vmYnbskWG0BXM6cFrZgITlSgMduboeFTtwvG3y
	yfPXXzS+3mw7mCaaPEnXSTEDKbCRzoJVNqs2JtiPL8mDX21h7lldow9oue2PxMCgTqj4K7DhVBc
	7F0nT/ZGIJJGizyox/xaW2spyjj45BZPIGTjf7h2a1Wm/Kwm+f/Gy2MvL3JSD4XZHofwY9iw7YW
	U+31C5m1hp8Rb043H+7nT/1M+SSOJnvv7RrNs7bx1w0XsTRR6LkuGsS3T/C+/nNtmhI8k7sBKHZ
	Xcd+oObxcMEA
X-Received: by 2002:a17:907:3f26:b0:ac3:154e:1391 with SMTP id a640c23a62f3a-ac73897af75mr1468889966b.10.1743592227087;
        Wed, 02 Apr 2025 04:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgMJBQJGMVcHMqaXRV768YtbruiOfUMHIbIN54f/Fgpq3xvdwdRNsKIiLjNa/scM2YmTFJ4Q==
X-Received: by 2002:a17:907:3f26:b0:ac3:154e:1391 with SMTP id a640c23a62f3a-ac73897af75mr1468885666b.10.1743592226596;
        Wed, 02 Apr 2025 04:10:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71962177fsm891693366b.115.2025.04.02.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:10:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8AE018FD3A9; Wed, 02 Apr 2025 13:10:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Apr 2025 13:10:24 +0200
Message-ID: <87jz82n7j3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pavel Begunkov <asml.silence@gmail.com> writes:

> On 4/1/25 10:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> ...
>> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
>> Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@h=
uawei.com
>> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
>> Suggested-by: Mina Almasry <almasrymina@google.com>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Tested-by: Qiuling Ren <qren@redhat.com>
>> Tested-by: Yuying Ma <yuma@redhat.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I haven't looked into the bit carving, but the rest looks
> good to me. A few nits below,
>
> ...
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 7745ad924ae2d801580a6760eba9393e1cf67b01..52b5ddab7ecb405066fd55b8=
d61abfd4186b9dcf 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -227,6 +227,8 @@ static int page_pool_init(struct page_pool *pool,
>>   			return -EINVAL;
>>=20=20=20
>>   		pool->dma_map =3D true;
>> +
>> +		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
>
> nit: might be better to init/destroy unconditionally, it doesn't
> allocate any memory.

Hmm, yeah, suppose both could work; I do think this makes it clearer
that it's tied to DMA mapping, but I won't insist. Not sure it's worth
respinning just for this, though (see below).

>>   	}
>>=20=20=20
>>   	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
>> @@ -276,9 +278,6 @@ static int page_pool_init(struct page_pool *pool,
>>   	/* Driver calling page_pool_create() also call page_pool_destroy() */
>>   	refcount_set(&pool->user_cnt, 1);
>>=20=20=20
>> -	if (pool->dma_map)
>> -		get_device(pool->p.dev);
>> -
>>   	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>>   		netdev_assert_locked(pool->slow.netdev);
>>   		rxq =3D __netif_get_rx_queue(pool->slow.netdev,
>> @@ -322,7 +321,7 @@ static void page_pool_uninit(struct page_pool *pool)
>>   	ptr_ring_cleanup(&pool->ring, NULL);
>>=20=20=20
>>   	if (pool->dma_map)
>> -		put_device(pool->p.dev);
>> +		xa_destroy(&pool->dma_mapped);
>>=20=20=20
>>   #ifdef CONFIG_PAGE_POOL_STATS
>>   	if (!pool->system)
>> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_po=
ol *pool,
>>   			      netmem_ref netmem,
>>   			      u32 dma_sync_size)
>>   {
>> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>> +	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev)) {
>> +		rcu_read_lock();
>> +		/* re-check under rcu_read_lock() to sync with page_pool_scrub() */
>> +		if (READ_ONCE(pool->dma_sync))
>> +			__page_pool_dma_sync_for_device(pool, netmem,
>> +							dma_sync_size);
>> +		rcu_read_unlock();
>> +	}
>>   }
>>=20=20=20
>> -static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>> +static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem=
, gfp_t gfp)
>>   {
>>   	dma_addr_t dma;
>> +	int err;
>> +	u32 id;
>>=20=20=20
>>   	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
>>   	 * since dma_addr_t can be either 32 or 64 bits and does not always f=
it
>> @@ -483,15 +490,28 @@ static bool page_pool_dma_map(struct page_pool *po=
ol, netmem_ref netmem)
>>   	if (dma_mapping_error(pool->p.dev, dma))
>>   		return false;
>>=20=20=20
>> -	if (page_pool_set_dma_addr_netmem(netmem, dma))
>> +	if (in_softirq())
>> +		err =3D xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
>> +			       PP_DMA_INDEX_LIMIT, gfp);
>> +	else
>> +		err =3D xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
>> +				  PP_DMA_INDEX_LIMIT, gfp);
>
> Is it an optimisation? bh disable should be reentrable and could
> just be xa_alloc_bh().

Yeah, it's an optimisation. We do the same thing in
page_pool_recycle_in_ring(), so I just kept the same pattern.

> KERN_{NOTICE,INFO} Maybe?

Erm? Was this supposed to be part of the comment below?

>> +	if (err) {
>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>
> That can happen with enough memory pressure, I don't think
> it should be a warning. Maybe some pr_info?

So my reasoning here was that this code is only called in the alloc
path, so if we're under memory pressure, the page allocation itself
should fail before the xarray alloc does. And if it doesn't (i.e., if
the use of xarray itself causes allocation failures), we really want to
know about it so we can change things. Hence the loud warning.


@maintainers, given the comments above I'm not going to respin for this
unless you tell me to, but let me know! :)

-Toke


