Return-Path: <linux-rdma+bounces-14278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0AC3A789
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 12:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5893A317A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87783308F32;
	Thu,  6 Nov 2025 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFsaGLaa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4212DC346
	for <linux-rdma@vger.kernel.org>; Thu,  6 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427284; cv=none; b=n55KOMP/MCRxWNFKxAB8J9myEqIkyNlGrnJTNJ4lsVYgsBdwA40E16u0SViYbwFI3yJi2Deg+G3ovOYqIHXpsEFQupL3KWw2M28uyC943QDS+3BbKliMbXp298m5ZXMCfjMlpV3Jew4ySiy6cyUJzMXb7XXv2/u9g/SPw4v1VbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427284; c=relaxed/simple;
	bh=iflFF8uGA+JQqg5PeOnkh0xBZA/LPV6uIzaa7UsyVRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZ9th474xonib5rk8SzGaYnVD4HJ46/01bF+eSNZ0JZH4y9PA0pmjV/WMflFDlOYpB3TxJ3gPFinIb/NJP+l3v8OcH1pXrDRluGdPn5/E6Qozs1uIZacpiHqk2a+AiWPhqFmYDCulAH6YeEwEpv1KEA7xRFI6Y+mYv1GkkOPF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFsaGLaa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298b865f84so418271f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Nov 2025 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427281; x=1763032081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=lFsaGLaav2Wzq+kdJsJU1Wb4wW+hsZE5/nqsyi2eb0dBlUw0xGSjTlzzn4Sa1cJnLz
         qOyyIeD4YWjmrVzmwvu8aLSvJiCrNWiWtPu3V2gOXZd2hOq/2CFDkuqVKsyHc8xWaV+2
         UnIEinVpCzCm1HQ4R8dAMK+BQyH5QFyCxuMW0Wu90+6fKHiCDqa85zysgdJoHRrOgGTY
         4TuJETudPaQ70g6dro3pDcNu6mNd5AGjgpMzdSEf+ANdVpng/0xQwNfcTBWXI4fgmKma
         Gx1wfD/x+CU3EW9C3Q90NaljRbG7J9kS+1tSE2oTZqfxywlZzb1JbKbJFTSXG8MyWUxe
         SNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427281; x=1763032081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=Skd3LBwFrSjsr4Oz0ow4ZczfA9JpEUMogwXyJ2ZqZ7v77ywf6/ZfkoNCorv5L771Go
         MWi/T3TeFfXIx6Cho8o4T6iacFX5tH/Du1OabOLwTfwdrpbZdaUSsiLJjq4j0MjRgYPr
         Z/3kunUC9arwMhI0rov/EK0mRbVWLzoFSqaRie5flD8PWvnDyVHl+NOJFZ6SsA6+zVfj
         4cl6BKs85r+omwPvYc8ISQM6oTPcIb/KCrJz/qOhrSKUNn/dou+j2ruM4XQWr3CqqE09
         g2KVngrdAUtBsjBLGH5a4eG9yZHy/+GgCpNNo4VkSQUhBpWNeDz9XYbBz7LBi1aCpNlF
         ar2g==
X-Forwarded-Encrypted: i=1; AJvYcCWl+jpP9+OAyLISz8jM2wXHjUFSxfUhU/QtzKK3B8WGVStEmH9MtdGk9b+Ko7+Rq8E65gCyzmZbVMDo@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8c0XVE8AdAzVrYdtiu7ox8shXLSnRGu52Yy5CPQLuEUDT9Uc
	reyIaLA4Bf76nXk1v5EHb/NHvkD79lvz2u2hCRnxh008J6I2BAy1DlCK
X-Gm-Gg: ASbGncuGZs4D3qBhSMwdxsCVNSU8kgXhbzbRyyFSQw/ilHQbGgEjJ2rrbQqOvHfmbQX
	HGV7f7x3kl4+7CGizKGU96POUyokNCIZT+bM0oXDVztJ0QPI519YFocwvOX/QUwAmMCrV3Z+hSN
	l/rV+In8zEJ42vkssne5ciBIL+D20vx1f2qUk6BA05PNFdULRYizxz8oLuUSdnKdVHj/jVoVI9M
	mhgLzkaFJ5IgpyCjb4hgtX/wNimyvo6P59XawyhKbH5wq9zExUhYZuqif4EqaD8Lm27ICaZvKMW
	ww3tYOOqjgXMooSl+8/+n7Xl2MrbsMncAP33URC4syt1m00uTxmePO5TqhoXhEkCFkLxz01FygE
	ulast4u3F/Fj1UD9owbg5FyS5qrmyC34MInNdRNL12ZBDc5oebQ4E359hVYRoY/7tbL9qBKdUrY
	4A0SKCT22AnB4pTDnn3tCJqYOTmH1LGDbJT0kA00Ik540Mo9f8sBI=
X-Google-Smtp-Source: AGHT+IG/WPvgkkz5ima282cKyz2di1ByWQE6/QNBfZEdI+atynO653MZ5MMOXdVnpoH97C2BXp1trA==
X-Received: by 2002:a05:6000:250a:b0:426:ee44:6d9 with SMTP id ffacd0b85a97d-429e32e3595mr5318368f8f.21.1762427280858;
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm4648357f8f.1.2025.11.06.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Message-ID: <785c9d27-23e7-4ecf-ad2e-202ba506f2e0@gmail.com>
Date: Thu, 6 Nov 2025 11:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
> 
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
> 
> For net_iov not page-backed, initialize it using nmdesc->pp = NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


