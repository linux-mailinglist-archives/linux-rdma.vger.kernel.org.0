Return-Path: <linux-rdma+bounces-15101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E970CCEB71
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 08:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEBC73012748
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505882E11B9;
	Fri, 19 Dec 2025 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UWyL/zZj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD412DA771;
	Fri, 19 Dec 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766127627; cv=none; b=Vz2Ljk2jvPLxZ9UB5JeUTwZwT95PRrG1RWNe/ucAt8IouKLxmZ5STmViLwnqnT7erDCq+DOsH8b1FCmoxNv3tklLg5FfAT0gG0eK0qCds94cwfuabsx14Hv5R8QnvlQ66TyagA/IVTlGexQdUQtsnBvfj1tPW9ofWVvuvMwzS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766127627; c=relaxed/simple;
	bh=BqFV1uI6FsLvLgqnP877yYtUztnhNNPPWWFqb21oGTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctllz8BumyP7EaOr14vUdO+WqE5573GegbJlrhbI6Ay8XJRs7Gc/nUM/awzNoYVXBFZrfZZZhpGtBHjuu94Bb+2lKiwLnHOvzKWo/Ts5IldYxrBSIB2+wdynfr46DMlasbx2CSwIeXSNWQK1En9vkSC5jOX4Slnz2AbnIglwyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UWyL/zZj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=FVKwEsHD4rrzoxkjd/L0TrE6XvcIxn//KqQMMsaWQMU=;
	b=UWyL/zZjlv9pJAGBaD3qTpArakeN79rhjLLd5xHMST5rbJ+6udFv1xfREpHAH4
	j9uxlM66Md+FrgVIctPrBeNNUyE6uoyfgt6+0pxFaykda2VzXldl/XU5tZKU/Azk
	fIrkiwmMkAXYN1af+qdEaGy171SbuHppbUyzZu3415ILA=
Received: from [IPV6:2601:647:6300:a030:413e:5806:c79e:2e5b] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnh0jD90RpufjJIA--.160S2;
	Fri, 19 Dec 2025 14:59:21 +0800 (CST)
Message-ID: <1bef81ba-be81-49df-9d86-3cc0cc4bf864@163.com>
Date: Thu, 18 Dec 2025 22:59:13 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
 <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
 <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
 <01b419f6-264e-4faa-b4df-480fdf952d14@linux.dev>
 <8470c362-8c41-4b99-8c05-0903285c1b6c@embeddedor.com>
From: Zhu Yanjun <mounter625@163.com>
In-Reply-To: <8470c362-8c41-4b99-8c05-0903285c1b6c@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnh0jD90RpufjJIA--.160S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrur13Xw17KF4DXF45AFy7ZFb_yoW8JryUpa
	93tan8Zw4UXwn8uw12yw42vrs3K34fJw1UXFZ8Wa4Skr1j9F4xKF4xXr4YkFWrWF4xu3W2
	qa47tr95Zr4YkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwL0rUUUUU=
X-CM-SenderInfo: hprx03thuwjki6rwjhhfrp/xtbC7wqb02lE98p7RAAA3C


在 2025/12/18 21:48, Gustavo A. R. Silva 写道:
>
>> The struct rxe_recv_wqe is as below.
>>
>> struct rxe_recv_wqe {
>>      __aligned_u64       wr_id;
>>      __u32           reserved;
>>      __u32           padding;
>>      struct rxe_dma_info dma;
>
> Expand struct rxe_dma_info here.

Thanks. In struct rxe_dma_info, the struct is

struct rxe_sge {
        __aligned_u64 addr;
        __u32   length;
        __u32   lkey;
};

But in your commit, struct ib_sge is used.

struct ib_sge {
     u64 addr;
     u32 length;
     u32 lkey;
};
__aligned_u64 is a 64-bit integer with a guaranteed 8-byte alignment,

used to preserve ABI correctness across architectures and between

userspace and kernel, while u64 has architecture-dependent alignment.

I am not sure if we can treate "struct rxe_sge" as the same with "struct 
ib_sge".


Leon and Jason, please comment on it.


Yanjun.Zhu

>
>> };
>>
>> But I can not find dma.sge in the above struct. Can you explain it?
>>
>> To be honest, I read your original commit for several times, but I 
>> can not get it.  Can you explain the MACRO TRAILING_OVERLAP? And how 
>> can it replace the following struct?
>
> This is clearly explained in the changelog text. I think what you're
> missing will be clear once you understand how nested structures
> work. See my comment above.
>
> -Gustavo


