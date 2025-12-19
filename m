Return-Path: <linux-rdma+bounces-15095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD991CCE4CD
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 03:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09C230329C0
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 02:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F228489E;
	Fri, 19 Dec 2025 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dJDJJNT7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8821FBCA7
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112737; cv=none; b=IaEvRWWHAWKx5dOu6AP1hFPIuL07eeDbZLsWnZdT2RJdTQuxYje/1udZ5QU+g+mXRvgQlD+ugjJeBXDe8uZykP8MxiT7418FO1FTzin9jNZ8KgitjaEHhNbKmHRhWeAobHMcSasL0cRv88ZPO+erqlZDZYA1wSv60805yrOEG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112737; c=relaxed/simple;
	bh=0I+sA9xJCTN2L054Pgb1s/lcniDWoI3sgmYy/CC8k78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRDtSj09V2qGy7cufbDzVnvz9kTngKG/nuU/1AVy2BW7jkMKTd3qB96SLzEgFWN7S/B+DHkikWoD7Bhhf7+7bLIz1B0XO2vzT7EWnnbKmEjxd1L5plGday1gvZiJ96oWDzsBV6NKkFxhqcU+ZJplMvZ1sqGmoIaLDMBjYTfSY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dJDJJNT7; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id WOddvcnHMv724WQb9v5piV; Fri, 19 Dec 2025 02:52:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WQb8vMkRth8QWWQb8vxsj5; Fri, 19 Dec 2025 02:52:06 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=6944bdd6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10
 a=HKdHTREC5gtVaepGcnEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pftdnqYmBFO8fpYNuNoFhFopub0at3BioFFN9R/pFMw=; b=dJDJJNT7dwW0DxPS5qaR1eF2BA
	LIvrXnURsPHudpbfrQ5wU1FEDdHFRcVx2dUZ1eZN2qPS3+0MhdcIGfk7pmWCzp34HlU3SymW20iAe
	Tky9iKrM0oYiaLzIRawPAOcHfYuD6jiEO3CNeznULxVIrsQJ8t9VSEwK/ORf1b/AVZP7BNN6LyJuZ
	6avv6S/Z94148qTdDII2Xb+WKM2rpRGeQ1kQT+qipB1JnXe7QDgYg9EdbzpSdZIenho54EHyfdQtq
	DSflsECoRDTYmgAsZ61/t3fPfPJKccgE4153zDtUQVw6N4fHSzlnfqat7BkSDQLL1rd+KN2LcYguE
	0j03D4oQ==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:63755 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWQb7-00000003b8z-3egD;
	Thu, 18 Dec 2025 20:52:06 -0600
Message-ID: <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
Date: Fri, 19 Dec 2025 11:51:54 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
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
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
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
X-Exim-ID: 1vWQb7-00000003b8z-3egD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:63755
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG2h6jaZPo01cy6oCFu5HuZgBC9z9RONJcBNcl9/yZlJLb88Q4hLvTn7OEXWI4IGyx8rJ3yCXzuzLdjmmPovaB14uhK/M7JRYBexF2NjLEmPrXPa8Sa6
 nFbggeS1wUpAtSkUslzDBcmCFPshRB3kZrRq51WQ3IDVyZR64Zi7HF6+dLBZmDbQuP9DSk0tO6799ZU/qagOHrqB7NQCQSIOub6rQwlCTn5qzn8baS7uZ3LB



On 12/19/25 04:22, Yanjun.Zhu wrote:
> 
> On 12/18/25 7:56 AM, Leon Romanovsky wrote:
>> On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
>>>
>>> 在 2025/12/5 20:41, Zhu Yanjun 写道:
>>>>
>>>> 在 2025/12/4 9:48, yanjun.zhu 写道:
>>>>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>>>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>>>>         unsigned int        res_head;
>>>>>>>>         unsigned int        res_tail;
>>>>>>>>         struct resp_res        *res;
>>>>>>>> +
>>>>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
>>>>>>> rxe_recv_wqe has
>>>>>>> no member named wqe
>>>>>>>     289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>>>>         |                                         ^
>>>>>> I didn't try to fix all the typos, you will need to do that.
>>>>> Exactly. I will fix this problem. This weekend, I will send out an
>>>>> official commit.
>>>> Hi, Jason
>>>>
>>>> The followings are based on your commits and Leon's commits. And it can
>>>> pass the rdma-core tests.
>>>>
>>>> I am not sure if this commit is good or not.
>>> Hi, Jason && Leon
>>>
>>> Any update? If this looks good to you, I will send out an official commit
>>> based on the following commit.
>> You are RXE maintainer, send the official patch.
> 
> Will do. I will send it out very soon.

I don't see how this addresses the flex-array in the middle issue that
originated this discussion.

-Gustavo

