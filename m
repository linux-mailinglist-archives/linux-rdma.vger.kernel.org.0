Return-Path: <linux-rdma+bounces-10680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C891AC336F
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152AA3B4102
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C61BC099;
	Sun, 25 May 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVzAJGwy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974D42AA5;
	Sun, 25 May 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165702; cv=none; b=h/R+8W3jzZcug2BtiqielqiAxX2bjfVozLiCkZdxvpN/4baKtplv4v5gHYR2J3YkrsAzUiwLIbHbxZohCznzXe7BGud0TWsuJpLO1pmZsmVESTn1kTsp0pQ5dm1Y9LqwHaGnQHMKE7oM2rd7iSp9e7jBWroQ5UZuWDtTsQkj+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165702; c=relaxed/simple;
	bh=8KZ3EzKndP+p07qjA94uXuZpqmA2RfO0k0CNOpEd5tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j53M/f1yTjNygSpR7SAHwz0ttjosn4+4O3MOi8bLD2p8XO31Drpf03xr6yvWldixJDiWEfXYRQKwqHQHFbAao5JBf3UdM/oEbQZEJ1urwrnIlDIONla1uaBIJ3Ill4It6tURdtBhl43DPlP162kLaAfaYEQVnVkfKrdxr3+qbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVzAJGwy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso978767b3a.2;
        Sun, 25 May 2025 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748165700; x=1748770500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4baxS9nkwzK5vGKFdmUDvTqYJ7GDzaNoPiha3aT5tqA=;
        b=AVzAJGwy908PFfTNV6YsuSNuMEKAYAfxceAD0jalaxuKL7VmwLgQ8qjDr4CKlQL44N
         YQOVVMe/044QKSKMtHmuJCjXrNxCB2p+ecZIleWviVGFgroAYyX1H1aARD5eUcuzJeE7
         hwo528qyQVy0qCyHBI0Qe7RK8+53k5TAFGk4Pm29SwZHCL/w/xIHyK1hHoywuNCUE53S
         bpKmjHzTOWZdtJ/+YfFk7r81J7pKhkyhSAuLiPNtYMHZoJK+/z0s7gK9SkXcFUcLFIGz
         VFE4mfwhILhTq1qJkKAy0cJ8VBEgMRmsMIDXfUK0r//+dfEwJrivBtbkbTT3c05L0eo4
         WP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748165700; x=1748770500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4baxS9nkwzK5vGKFdmUDvTqYJ7GDzaNoPiha3aT5tqA=;
        b=ZLk/hBrsOWXt1Mqdl6LAcKzPWvbUn1w6pWIjMNVEXJMCCz7+X+ZZ/vBkP6t9JVyx3l
         fbW9yeetp9LYhXrtZFuy2zE+bKetyd7anL/a5T5KMJ029CYFUVg8GNkT98XFXMg+HhUx
         CdQLnCg9MZvNcuw3KLGFTgnDBcKz9sGhJSnAPYHf2bxKPSeV9kmDn6H9W6uPbP5GH+Lj
         23T6JCdwOfO2dZod7cL0niekqKso2Xl0efy7dUcHQsS+SvIdWpjMjcMh3gqWK0tOUhxq
         pTmlhytY9wqmJn4UdwzfJUEHynnRIX30JpBIFsoB6dCRUzTSwa1Kh2+zOP+rJhH9fl8h
         Y4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVqujOlkooSClFDIfRwO/TLX8xjuEOT7TOUKE9V+ubzkQepiO6LGmvItDzGPgDhwsVOAnoTg0t+nZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhUNlWU1BnE7soFI1U1mfTXzddmOYGtyvnKsTNoJxiavrel6g
	14rC5Tlxtbat6j1yUvc1bytWE/1W1JaDJ9ScEEEAmHcrofgG409k4L7qVnoLh32p
X-Gm-Gg: ASbGncspkCKA3fXmMX8kX3HAnaAUMBXmFpvaewjVgr+N9i9RPkiVkFhjAcOFDW8/yes
	2IdSNQiU5YldrNvhxG6/G7DfOqVsIweXxpvhmgonhNT2BdqxdvzCPYtumdvZt0R4VGDbmNlFCup
	i3KavHsRIZbpr8VZrH86rBlCW6Ms9adFzWBymXCxRQ4nUGTr9vQPuVHYcqYxzgbT02Zg99b4UNW
	BqNWYUJdJoUm7npw1X9jffbX0ND1PsKmGmbj/dyXHeOpvtgUa3oZtJl2WEfD84td6XILZqrWeBv
	AkVe88j1dWKprhdYsreTa8HrDaQ+bDiRdHMdwMiz+2Zi1g4DCI8AwuSEx0ahi+DOkRoB5dB7Uak
	4JU/asoRAS02JGweJzjvaBNN8LQI=
X-Google-Smtp-Source: AGHT+IHdVnZChkIciAxlH6V/m7Kx+EUXLo9Fl2H6HAMwo8seD4/RjA0wdWikDkA0hl2g6QrlhCbOmA==
X-Received: by 2002:a05:6a00:3a04:b0:739:4a93:a5db with SMTP id d2e1a72fcca58-745fe03ceeemr7206455b3a.22.1748165700021;
        Sun, 25 May 2025 02:35:00 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084980sm15329198a12.58.2025.05.25.02.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 02:34:59 -0700 (PDT)
Message-ID: <77ba8709-9b59-4c83-8898-6f0c699992c3@gmail.com>
Date: Sun, 25 May 2025 18:34:56 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com, hch@infradead.org
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <20250525070806.GW7435@unreal>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20250525070806.GW7435@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon,

Thank you for amending the patch.
I've run the test and confirmed that the bug has been resolved.

We still have two build errors. Please see my reply below.

On 2025/05/25 16:08, Leon Romanovsky wrote:
> On Sat, May 24, 2025 at 02:43:28PM +0000, Daisuke Matsuda wrote:
<...>
>>   drivers/infiniband/core/device.c   | 17 +++++++++++++++++
>>   drivers/infiniband/core/umem_odp.c | 11 ++++++++---
>>   include/rdma/ib_verbs.h            |  4 ++++
>>   3 files changed, 29 insertions(+), 3 deletions(-)
> 
> Please include changelogs when you submit vX patches next time.

Oh, sorry. I will be careful from next time.

> 
> I ended with the following patch:
> 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 51d518989914e..cf16549919e02 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -60,9 +60,11 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>   {
>   	struct ib_device *dev = umem_odp->umem.ibdev;
>   	size_t page_size = 1UL << umem_odp->page_shift;
> +	struct hmm_dma_map *map;
>   	unsigned long start;
>   	unsigned long end;
> -	int ret;
> +	size_t nr_entries;
> +	int ret = 0;
>   
>   	umem_odp->umem.is_odp = 1;
>   	mutex_init(&umem_odp->umem_mutex);
> @@ -75,9 +77,20 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>   	if (unlikely(end < page_size))
>   		return -EOVERFLOW;
>   
> -	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
> -				(end - start) >> PAGE_SHIFT,
> -				1 << umem_odp->page_shift);
> +	nr_entries = (end - start) >> PAGE_SHIFT;
> +	if (!(nr_entries * PAGE_SIZE / page_size))
> +		return -EINVAL;
> +
> +	nap = &umem_odp->map;

BUILD ERROR: 'nap' should be 'map'

> +	if (ib_uses_virt_dma(dev)) {
> +		map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
> +					 GFP_KERNEL | __GFP_NOWARN);
> +		if (!map->pfn_list)
> +			ret = -ENOMEM;
> +	} else
> +		ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,

OPTIONAL: Perhaps we can just pass 'map' for the 2nd arg?

> +					(end - start) >> PAGE_SHIFT,
> +					1 << umem_odp->page_shift);
>   	if (ret)
>   		return ret;
>   
> @@ -90,7 +103,10 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>   	return 0;
>   
>   out_free_map:
> -	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
> +	if (ib_uses_virt_dma(dev))
> +		kfree(map->pfn_list);
> +	else
> +		hmm_dma_map_free(dev->dma_device, &umem_odp->map);

OPTIONAL: Here too.

>   	return ret;
>   }
>   
> @@ -259,7 +275,10 @@ static void ib_umem_odp_free(struct ib_umem_odp *umem_odp)
>   				    ib_umem_end(umem_odp));
>   	mutex_unlock(&umem_odp->umem_mutex);
>   	mmu_interval_notifier_remove(&umem_odp->notifier);
> -	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
> +	if (ib_uses_virt_dma(dev))
> +		kfree(umem_odp->map->pfn_list);

BUILD ERROR:     'umem_odp->map.pfn_list' is correct.

Thanks again,
Daisuke



