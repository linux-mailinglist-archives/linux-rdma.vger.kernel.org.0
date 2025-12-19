Return-Path: <linux-rdma+bounces-15098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5ECCE774
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 05:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E485303198A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CAB285C9D;
	Fri, 19 Dec 2025 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pooN/vMu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6E2253FC
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118919; cv=none; b=C7xfnnemfLEZaanI8Uipzvl4vdPeuuES5AD8bT2iiVRSfeSB+cCWBOZ3FVd8kfjwVHQrjWz0tVDFGjVyuwd3htRGQ3oZEY1SQyuVwHZzlYWMYqqnYWOxqi4Q9HZqwLfQtWID0G2pjcv1ORFWwXa2OZfAPcgQN45gINzlm31DQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118919; c=relaxed/simple;
	bh=SJgGbYN06P8nPryB9hSdEqeq3E+uRjWLHqV0vUyvotU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVHGtlFWZb1tmzLoo40AxCSlZ2dBpB3kWKbmt9ypMNHds6zZUyAoFfojT1pCI5rrWBjhyeBpASY/5jOEMTACeRZ27fZl3evRCVtFWVIm2fwCMLNDyWzmEl4tJzP9iT6Sm1pKZRWDF0Rf4r3KG+nmMC8NQcWef67X1mct8cZCdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=pooN/vMu; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id WJEJvFbKBipkCWSCzvOQnR; Fri, 19 Dec 2025 04:35:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WSCzvUz3eqfpWWSCzv0IGF; Fri, 19 Dec 2025 04:35:17 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=6944d605
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10
 a=27f3MHfiU8ZXzjLqhT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OTGuLz2/9a4Qw+b2OjzxKp8NDVhNdsocZWd8eug5bkE=; b=pooN/vMu/WUbx2zn5HTwQX4KWo
	pCGL0N2DX2JfLRY3LJ+jWomb0t6B/mKP5EACLpENBtFuVky1d66aX9I8CqLzWTBjc9WeQKHXzawOQ
	RzkkJ9Byblt7zWiZXld/lELtx4exdicbqA+zeoK8d8/uk69ckq3XACKxsImMl+FIVUQQMtUNiWNmW
	NzGuPGyuE5aG4W/nIBi2IF+45WtXh+aX64+6IHkkXFNf+hsJp+6MPd3yYQHgOTqX825fppnJHM3VW
	7pYm93QcQeNRzru/n0iIOUoteCoJC8F6sIo3JUCdJuyNlpNQvfm4B70Mw3+GF9UC44ts312/jvQlu
	muvR/meg==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:62262 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWSCy-00000000vMY-2A8o;
	Thu, 18 Dec 2025 22:35:16 -0600
Message-ID: <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
Date: Fri, 19 Dec 2025 13:35:06 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
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
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
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
X-Exim-ID: 1vWSCy-00000000vMY-2A8o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:62262
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG1q//DjcMVW1amzP6LCjTQYKMWk1EN++U78pfZzN96/5KHv/pRxREgprhwpnF3YwSdhRe6NaKsRymf7kvbR0KP41+k+dOwSZemihBkwfr0X2FfgHMcZ
 2wCr023Y3dt6gtlEv+zZ9B8vIeUdIz2Q1aFYJEUSi5kH9n7+IO1Ecna6OtmT5qfC3WlfReWyqN1CDHGGJRJnO3lYIGMZae5HkkLMkSC8Z0ORSoJHM6B4c50a



On 12/19/25 13:29, Zhu Yanjun wrote:
> 
> 在 2025/12/18 18:51, Gustavo A. R. Silva 写道:
>>
>>
>> On 12/19/25 04:22, Yanjun.Zhu wrote:
>>>
>>> On 12/18/25 7:56 AM, Leon Romanovsky wrote:
>>>> On Sun, Dec 14, 2025 at 09:00:51PM -0800, Zhu Yanjun wrote:
>>>>>
>>>>> 在 2025/12/5 20:41, Zhu Yanjun 写道:
>>>>>>
>>>>>> 在 2025/12/4 9:48, yanjun.zhu 写道:
>>>>>>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>>>>>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>>>>>>         unsigned int res_head;
>>>>>>>>>>         unsigned int        res_tail;
>>>>>>>>>>         struct resp_res        *res;
>>>>>>>>>> +
>>>>>>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>>>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>>>>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct
>>>>>>>>> rxe_recv_wqe has
>>>>>>>>> no member named wqe
>>>>>>>>>     289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>>>>>>         |                                         ^
>>>>>>>> I didn't try to fix all the typos, you will need to do that.
>>>>>>> Exactly. I will fix this problem. This weekend, I will send out an
>>>>>>> official commit.
>>>>>> Hi, Jason
>>>>>>
>>>>>> The followings are based on your commits and Leon's commits. And it can
>>>>>> pass the rdma-core tests.
>>>>>>
>>>>>> I am not sure if this commit is good or not.
>>>>> Hi, Jason && Leon
>>>>>
>>>>> Any update? If this looks good to you, I will send out an official commit
>>>>> based on the following commit.
>>>> You are RXE maintainer, send the official patch.
>>>
>>> Will do. I will send it out very soon.
>>
>> I don't see how this addresses the flex-array in the middle issue that
>> originated this discussion.
> 
> Could you please explain this in more detail?
> Also, if you have a better approach, would you mind sending a new commit for discussion?

This is exactly what my original patch is about. I've explained this a couple of times
in this thread already.

-Gustavo

