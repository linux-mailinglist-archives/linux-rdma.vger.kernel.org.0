Return-Path: <linux-rdma+bounces-9167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7869A7C921
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32F716B76E
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEBD1E5B74;
	Sat,  5 Apr 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abJzU5Xo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793C1DE886
	for <linux-rdma@vger.kernel.org>; Sat,  5 Apr 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743857409; cv=none; b=PM98LilFE9jfxMpQ85EQnJyNKzH9z3XiltcyLC78emaozxFy4D+QlpypP28Jm0BSQLgPEZkhV3l8J5p99QqLd6tnqO8G2iWTzypVs/FHJPCfa5q5u4Av5ycImr/PfZ9N7Goe9BtlpMtkiVfp5vmYvdxQnvGFVvdilnk79i4P/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743857409; c=relaxed/simple;
	bh=OqPlxZ84MvDuvuYdDMJebOtv4kfa7e9q+LZcfQb1DD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgL5erkFCgL2V8SsRPjRruA+3BqYVLY3z6h+MHcF8pYOI6C2N8SqOb71sAPehRThzaxzJMb+bTgDiyXrHhB6ps0IC4UwUTDS0l4yaxPq2lUCl/8TyWjMBMKKl9qsoUiedd+NCgzFf7+hZfC5fb6BjrNxNASbZfNcYj5NNSnB/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abJzU5Xo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743857406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
	b=abJzU5Xo+mtT07M3/io/UTekwKNqGsM6SOUU/vuYLbuFHQArKlqcwUZ0UEQNKN7WHy4yf7
	eq+A/UE9DKrcBGzkA0nmFVbn1g0fqFIQHilgFAjTY3ra5Q8UG0EsqDcFKAIRgiI5a2HoMT
	T6Q8FvJQGdG7no8qQUmzQxawtEpogYM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-hdwsJj-nOGeo-jN9Ir8bzQ-1; Sat, 05 Apr 2025 08:50:04 -0400
X-MC-Unique: hdwsJj-nOGeo-jN9Ir8bzQ-1
X-Mimecast-MFC-AGG-ID: hdwsJj-nOGeo-jN9Ir8bzQ_1743857403
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30d8de3f91eso17104581fa.3
        for <linux-rdma@vger.kernel.org>; Sat, 05 Apr 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743857403; x=1744462203;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
        b=d+aa3bYa+qbwrQW143Gp2x6eNxH8/mGyKk+6kKPT7S+jiIr7I3hTcgaLLMtuROl5Uc
         WbS7CyYvkXsiQajJCsNMqj7Wtq32SoDoKScKQiNqHn9RyL6vWoKnbUYBAksIxJ7Dfj+e
         S8wkCyGi6vq0vzbnK57C9++rtvJcQogHYK0u/bWi7q0r6qFz8Z5ViiF9TWucrM2HCtsC
         lBfmko9yM2D/NM6xwHkUyb2XiFwzJXxaUr+Uc4QC+5N6AYCw9EvY50pWqGX/4hBQTpe8
         n36t41yuXNWgdsTUWEzqp1/I4bE5AJJhWxOGzLjiQkRj91EBiUDb4W7fYsYb5oiMonZS
         9lUg==
X-Forwarded-Encrypted: i=1; AJvYcCXqRj90e4FzHxjo1STczqVfiCgxs1s5mGIE28QpTE6TOE9vcXi6akhl5juOf4CWVr73G5V2+m0yzbex@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQ9izgNHAjPEbGNthOQOHolXkG9sCr1/F4CYvKuaezUJw9beR
	Ra28Wewq3uLSJDkyZdlEGyaV2Za8z+8Z89yJmZA53jThD2eCJh0Caeo8d4xC/2/JBCul6+AL9Jg
	Ip+GekI+6VnITmC+l5GbjqgCCV5OY0Zto3lkP975vaUdLn2sWhA2pORzwjYY=
X-Gm-Gg: ASbGnct3agjTTfgTRiUMaE2dRPd/UkXmZhR8qLSDOFOQzwsx3Et06njcGhQ8zO982OT
	Ff3B7N09wKS02S6AUs+u1Rbx03nKjd/TqWTQV+pJMJqGwx2s1ALkq8T2Mcfy2ih2Z8KF6tOqCtC
	lCfeo4KGJl5hp1Db2DekhYMn6n2xCW2divwX5A09YpXCCSAoGDTEtu2QLNdnxDNFDYv5KeNys4Y
	30c6ZRKd6BtK8bBlgg2cbuNhWjqtFKV3NIKijXGo5i5dn+/84HjTc8lxZtHaZNJx0iG1FNUjnEx
	dYVAeS/WKutExXoN0i5GRKWDCWUVcIpxJmYpINOq
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764691fa.33.1743857402905;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB21V3mnevjJOBuKtDbkjuEQHYW7vTlUl/JuKqTWWRK9nD5+it91BDmAxcHGGPPFWJPz3EEg==
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764381fa.33.1743857402525;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031ce793sm8871321fa.107.2025.04.05.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 05:50:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D0AC618FD793; Sat, 05 Apr 2025 14:50:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 05 Apr 2025 14:50:00 +0200
Message-ID: <87jz7yhix3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 4 Apr 2025 17:55:43 +0200
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>=20
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes resource leaks and/or
>>> crashes when there are pages still outstanding while the device is torn
>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>> device on the subsequent page return.
>>=20
>> [...]
>>=20
>>> -#define PP_MAGIC_MASK ~0x3UL
>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>=20=20
>>>  /**
>>>   * struct page_pool_params - page pool parameters
>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>  	int cpuid;
>>>  	u32 pages_state_hold_cnt;
>>>=20=20
>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>=20
>> Yunsheng said this change to a full bool is redundant in the v6 thread
>> =C2=AF\_(=E3=83=84)_/=C2=AF

AFAIU, the comment was that the second READ_ONCE() when reading the
field was redundant, because of the rcu_read_lock(). Which may be the
case, but I think keeping it makes the intent of the code clearer. And
in any case, it has nothing to do with changing the type of the field...

-Toke


