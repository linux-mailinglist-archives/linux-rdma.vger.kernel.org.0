Return-Path: <linux-rdma+bounces-11205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC310AD5A14
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412BC1E371B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF11E835D;
	Wed, 11 Jun 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlt1KK01"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321D1E47C5
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654767; cv=none; b=mzGInYs0HMLnD0MwLXwaMeeXzl9mX+x8KYq7z+x43erJ7aUsp5gEUgPbodXZlZMmG810Z+wOtrOrY84vLMn3Q+PfGVmzPADqpIFmw3n1hUzsldeDNdsjHy2AgkySfbEhAJ0w73Yq2nQ6pyO0udVtRZTcttV9kF5I0ODykj5Izhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654767; c=relaxed/simple;
	bh=UiGf0/paT8J/PGxt72ywXwOPlAojUSGsdDvbJCCGcYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D83KzzKpNEsH88hmTV+flhgvi6SOpFGnMlJ01HTkr7qwPEmInevuYYVLIwH1XZ7YDT8Ex/K0QJ95gd3bxTvKGr2M0EBCeL4AqaVfy3kE9weIjCRKe4KJ2B1LLLfCLM/HwjixEXELOIsma69ApGyhyKBGHtcHAFx2aOlNd9ZXShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlt1KK01; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo27547325ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749654765; x=1750259565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6WMcoQ6Gtb1F+D1bxferHuBStlLHTLjDOwq5/Sz5ME=;
        b=Dlt1KK01rH9HrII4d/uRqv/sBVvepfoGpxv6NisDDgOOdIQuMs5obSVP4rYBj+uSzG
         c/nxk39ZIh4chkT1eea9DZNuivK8fRoK/Pe9ZDS1MuNJQ7FIec6FmtwUmlVJfbY2E+bX
         uxzLG3aXYr1YQfF38u6ojH+SSdU+tkxQFOL+ZJJZsWktZyT/wBsuB6GAmgtQJm8qIX04
         9lfsnSHqbYwCk2NWtUZucrJDRY7/QUQc03KkNGvrRyISjq2ctyhcI6Tn/ZRzQCFhAOHg
         SRIToaSHAfmXGwGD6hZVJw1yo6v/nQOAzW5BEOAnKPHsENy5/f/cA4z1ifEM7UdBmVl6
         k6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654765; x=1750259565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6WMcoQ6Gtb1F+D1bxferHuBStlLHTLjDOwq5/Sz5ME=;
        b=TaHq8/dUez65g6YzaJpnVN5aEhoIUBSK9cecU7xy19lusP60M2kWM5UbO6YUcz5nzI
         Yztf744QfEdFJb7T2Fz8bGHpj3UU1FXnrvIoCq83KOrz3BdMcxl4qAF6trAsWZgf20yT
         A4v4HdhispmHY5v4l00Q5A3uDoRwlfvg8g3zcocumRx8LIJ/cFVwArh0jNb1joZMCJjp
         3tNwjj9gpGY38G9SlH/H0bGQIZObfpgmEGK/0nIAu8/+BLBTXsE9zs/8zJ4LanQOf4Hd
         dMbwjgF5KzFNEL/oUKw/Yom8A18Y8/Xkhgn7KOSgvhlgBG7OFheU0VBesmJYFx2iC7Tv
         8hXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp2FpJjXBSelAmTfwcZZGA74M2mXktRWQ7OQntCkGapUkXYJCv6LVOkc3900ChSYUwQGLVhgqaGQCj@vger.kernel.org
X-Gm-Message-State: AOJu0YwjW+KnbGjkeNTtXppZiUxdZA/p/BWW/jaYh1IQHo8HWkDSxKcG
	qkRZhD3mFORHSvzR/xelXp6LewGw0bPBdg0aYa+7Ls8wvvOYcjK+45RO
X-Gm-Gg: ASbGncvFKRXvLHtQfb3vRS+7iKAkkNi2H7gXtxJwPHfuxRkYgD0KAeZzl46yPnFCCUZ
	f4u8W3IlMmI+VCZAbzpOWFaaNMft8ptj3CXrQEqunRMGRK5KY2g9ZgtOTnWw3nQlZ4WuZ0UlD1m
	YE8IBsbzjTroQ3GCDy1yx0qJJmkf/S+J9MW1vSlsNPJpSDBVx00ooMa/VaiUF0ZsQaSCJkw2kGa
	NgJSP66Ahvsh3mDSL6A2PtR7egxDWdG6dEII3hJ4DFjHucYgY793WxRNN7iaWaM3w/7M+hH5uMq
	DVW6ojL6vgU4QF2pJPdKuL8fETRojCNA9WKdPoPQcdOGeY1uHKBS8nDaoyv3INCKXpMrW/pMymm
	jPtLWcUSL58JGSMjvwVTHy6M8H+kNesRjd8RP0A==
X-Google-Smtp-Source: AGHT+IEf9lf/nBfwvSe68olFSWVmaesDlxkGRgWjhutrHxydKPNpSJyjTFVGjpeyy59beGNrvn2yKQ==
X-Received: by 2002:a17:903:2984:b0:235:ecf2:393 with SMTP id d9443c01a7336-236426d679bmr42654955ad.53.1749654764890;
        Wed, 11 Jun 2025 08:12:44 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc747sm88821415ad.121.2025.06.11.08.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:12:44 -0700 (PDT)
Message-ID: <cfb31dfc-723c-4faf-9b71-9aa32be2f173@gmail.com>
Date: Thu, 12 Jun 2025 00:12:41 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove redundant page presence
 check
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20250608095916.6313-1-dskmtsd@gmail.com>
 <c63d3202-8a5d-448d-b802-f8a7e0275265@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <c63d3202-8a5d-448d-b802-f8a7e0275265@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/08 20:23, Zhu Yanjun wrote:
> 在 2025/6/8 11:59, Daisuke Matsuda 写道:
>> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
>> should return an error in case the target pages cannot be mapped until
>> timeout, so these checks can safely be removed.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> ---

<...>

> 
>> -    if (!page)
>> -        return RESPST_ERR_RKEY_VIOLATION;
>>       if (unlikely(page_offset & 0x7)) {
> 
> Normally page_offset error handler should be after this line "page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);"
> 
> Why is this error handler after hmm_pfn_to_page?
> 
>>           rxe_dbg_mr(mr, "iova not aligned\n");
>> @@ -352,10 +348,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>>           page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>>           page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
>> -        if (!page) {
>> -            mutex_unlock(&umem_odp->umem_mutex);
>> -            return -EFAULT;
>> -        }
>>           bytes = min_t(unsigned int, length,
>>                     mr_page_size(mr) - page_offset);
>> @@ -398,10 +390,7 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>>       page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>>       index = rxe_odp_iova_to_index(umem_odp, iova);
>>       page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
>> -    if (!page) {
>> -        mutex_unlock(&umem_odp->umem_mutex);
>> -        return RESPST_ERR_RKEY_VIOLATION;
>> -    }
>> +
>>       /* See IBA A19.4.2 */
>>       if (unlikely(page_offset & 0x7)) {
> 
> Ditto, page_offset error handler is not after the line "page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);" ?

That is a sensible question.
I will submit v3 patch to move the error checks.

Thank you,
Daisuke


