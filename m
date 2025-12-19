Return-Path: <linux-rdma+bounces-15104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE32CCF3BC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA92303BE0B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419032EBB8A;
	Fri, 19 Dec 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MSrDkswr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127A2BE7B6
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138115; cv=none; b=FHWSKC+N3zCkrpNvuUNCN7P35CV+8GPHmtn1Y9CrOfVD7Lbff5+gZ42WsJRTRR2I47QDQyAaxdC0zvSHX3FZotocPKR0X5WGd9ShnPdEqXkQdcFv+XuP3J3mORqQiva92+YXLlY1pyoaW+0JJzT2k4yKrIhdvt8/tNzRWZP/wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138115; c=relaxed/simple;
	bh=LfPMAZQwG2CDhO0livSrqtZCmM4kbIyrEnve/M5Z09o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4aueAcXHmpn+5eGtYa7M3Cq+BnnPKokdBHwxX91S+JnUJrC4AlV+xCp7H1bIXfeI/YF1ZYpb8/OmVPtaAyYhp8cHoI3OhhDAZUyCb5jpMgMJMTRyLzAOcLokg04ZTQmKkKMW82fHrcmn+GBl+MyDxjrhXw8NmqE/5Zry+osQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MSrDkswr; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id WOqhv43OsVCBNWXCavde4F; Fri, 19 Dec 2025 09:55:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WXCZvwD2bjAxuWXCav1XJh; Fri, 19 Dec 2025 09:55:12 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=69452100
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=qPglhVzjI8gqfWa7ntcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zi+7Rw0hPdq+BgnCCkLlPOiKXJVsrPVfrI28uMIfdY8=; b=MSrDkswrK7HG4GXVjaaIekbFup
	AVjqjEZeYE/yrPBzXTIMyFMQ0uwgFeomKsBWPsaSLb+U9o4TuUWtemkFp+QJyql192ixI+A1ZQABb
	ugQkUZFIZyqbEqnDswVxMf6D0NlexK/cM4slZCXxKzjOtmDEeOlkg4pMeQm5UfViW8duUlkeTMKPr
	c1R1sX2trPe/Nia5Er2j/vzQvjRALS8M83QR1eu+7ywv8pHTPbuPN4VdV9LBJp9HItv5h1WA8RZ+O
	x8FLyTKP5qXQjcP9oT2/7jhtwDaaC0U8weuxRTVzUpdNWMLcALF7bRJOoXiQ6U5vuTouMJZM/PgIl
	4LRx0rfw==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:61112 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWXCZ-00000002Zn5-0tMF;
	Fri, 19 Dec 2025 03:55:11 -0600
Message-ID: <ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com>
Date: Fri, 19 Dec 2025 18:55:01 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <mounter625@163.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Leon Romanovsky <leon@kernel.org>
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
 <1bef81ba-be81-49df-9d86-3cc0cc4bf864@163.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <1bef81ba-be81-49df-9d86-3cc0cc4bf864@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vWXCZ-00000002Zn5-0tMF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:61112
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOpV+6LQR1FXQaCGG7BSbWH2RStDJYOykU0GApmbKBmkxT6vj7DIbQcVNZmVFw2ffB+fHC1VVeeUXfX9tXGZKo1wSMzzeo5alcCqTRUQcuvUGw5nbPgq
 e+G2Ixeg6Y1KAvUXF6AgkBmwkmfFnFGtLVonh7ro5J198EQeIS1GrApNB/8YEBpyvPXNjH6jLa47CR9FzuTrQTlALe4FWQ/v3jV7z31weQWSRufTDvGjuZbC



On 12/19/25 15:59, Zhu Yanjun wrote:
> 
> 在 2025/12/18 21:48, Gustavo A. R. Silva 写道:
>>
>>> The struct rxe_recv_wqe is as below.
>>>
>>> struct rxe_recv_wqe {
>>>      __aligned_u64       wr_id;
>>>      __u32           reserved;
>>>      __u32           padding;
>>>      struct rxe_dma_info dma;
>>
>> Expand struct rxe_dma_info here.
> 
> Thanks. In struct rxe_dma_info, the struct is
> 
> struct rxe_sge {
>         __aligned_u64 addr;
>         __u32   length;
>         __u32   lkey;
> };
> 
> But in your commit, struct ib_sge is used.
> 
> struct ib_sge {
>      u64 addr;
>      u32 length;
>      u32 lkey;
> };
> __aligned_u64 is a 64-bit integer with a guaranteed 8-byte alignment,
> 
> used to preserve ABI correctness across architectures and between
> 
> userspace and kernel, while u64 has architecture-dependent alignment.
> 
> I am not sure if we can treate "struct rxe_sge" as the same with "struct ib_sge".

Just notice that the original code is the one actually doing that.
See my response in this same thread:

https://lore.kernel.org/linux-hardening/d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com/

So, if that code is fine, this is fine. If the original code is wrong,
then that code should be fixed first.

-Gustavo

> 
> 
> Leon and Jason, please comment on it.
> 
> 
> Yanjun.Zhu
> 
>>
>>> };
>>>
>>> But I can not find dma.sge in the above struct. Can you explain it?
>>>
>>> To be honest, I read your original commit for several times, but I can not get it.  Can you explain the MACRO TRAILING_OVERLAP? And how can it replace the 
>>> following struct?
>>
>> This is clearly explained in the changelog text. I think what you're
>> missing will be clear once you understand how nested structures
>> work. See my comment above.
>>
>> -Gustavo
> 


