Return-Path: <linux-rdma+bounces-15193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA48CDA18C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA635301986C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64F344040;
	Tue, 23 Dec 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="op1mCuoQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C503081A4
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510807; cv=none; b=oKwgcbwUlc33X+fBMJeTrnNFpKRTJ57teihK142O4lqTpQhx5qzYF0HNZdWl1vv8YWVASdDk8xwYsFwagYT1YZKHayggFT0smhc7xl0uaJzE4VzfGwxEzH6ggWs0O9QvIXpqbkaWqYlD3X244Vcvct+4EEKg0pNZUVBsy4sTtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510807; c=relaxed/simple;
	bh=XSJ3t4H9M1TMfnzN7PD9gX5FxnIN765e9eHeJ49crCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/C9unQCU9wI4rdbLsOqkxjwPZhBXVTEtEN+Dn6bjWGyYhpOLjHljzaeC0+8A2UlhhT2na+1ILpobm3mikWyZ8gEKLS9zZYoxGKNOkfXpmweSIQUz3QLGdKuHwSIAYXja/cD2kZbMkpIUGMZdt/Qz7K0Zy38PD87ezQR/lEjWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=op1mCuoQ; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id XyNqvUvLmKjfoY69jv6x9P; Tue, 23 Dec 2025 17:26:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Y69jvsTD0N3K1Y69jvbQKY; Tue, 23 Dec 2025 17:26:43 +0000
X-Authority-Analysis: v=2.4 cv=UdRRSLSN c=1 sm=1 tr=0 ts=694ad0d3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=VwQbUJbxAAAA:8 a=YmdrnEFYGWStXPIrsUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/Jg/tNk1DtHtQi2YwDuRF07lJtJQzeCyZZH5QP628sE=; b=op1mCuoQID2G2HO6UV1iY4uDSu
	FT/eO0+8M+OgwXxNTKqKfQ140Vajy8e8sg3U6wM24KIc7sWoXHThEazRuIy87ul9ds9P72U/tfkE5
	zdroncZRohWy9gHfNbifA42hj3OlKxsH6rTl9ujUbFaVYn2Peud5K48FbzLRwsaaL2Do/rdrve8zY
	OqdpWUL7dscTkXdemo9LSnvmvailKzUakmCwnBgEZytptsUjrPqWnh9q3kDwDk3pRTF5Qw4Yo9HJ9
	x/G6yKkhL+SGVFqeWlNF+BogblxQqs1BauYP+sfCDxoIaMQKQ+JgJEtSohfrMS5UW18izCNuHElE1
	Ou+y2RmA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:60306 helo=[10.242.145.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vY69i-00000002Rpr-0GJK;
	Tue, 23 Dec 2025 11:26:42 -0600
Message-ID: <911ba345-7da6-4d05-955a-d33dd4b1e8c8@embeddedor.com>
Date: Wed, 24 Dec 2025 02:26:22 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Greg Sword <gregsword0@gmail.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
 <CAEz=LcvVgX8VA4M3TJM38NXrhyx-QohBdSoZOG=p3X9pbTY4pA@mail.gmail.com>
 <d4f60741-b0af-4a51-a1dc-cded1f34f309@embeddedor.com>
 <CAEz=LcsLXuAiQ0Rv0Z7E9mV35Qd92xxGsoSdDFBT8F1AdfZcoA@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAEz=LcsLXuAiQ0Rv0Z7E9mV35Qd92xxGsoSdDFBT8F1AdfZcoA@mail.gmail.com>
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
X-Exim-ID: 1vY69i-00000002Rpr-0GJK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.242.145.44]) [118.18.233.1]:60306
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEwjmY7OoI/jDEOl0DOfK0yuxUuxP5nuathyp0xoqkV5z4XUHlk3IgoFYbWO7RX9rd9SB8lvjWPJKJlNK6oX3FLW/DE5gOWXRo0pSoyX7qRiLZvteKza
 I2l/WOxRADUKlNlOQqt57qIkfmNnm+wGTgbK/cPd9P89k8121Mnxn+sQ6vBlCz5AAmVwo8gePKvWIfH8zXxqo6pjfDmzWWR4/XoJQ7M9G8ctx4Qzczqen2Dp



On 12/24/25 02:19, Greg Sword wrote:
> On Wed, Dec 24, 2025 at 12:59 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>>
>>
>> On 12/24/25 01:38, Greg Sword wrote:
>>> On Tue, Dec 23, 2025 at 5:35 PM Gustavo A. R. Silva
>>> <gustavo@embeddedor.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/23/25 13:41, Zhu Yanjun wrote:
>>>>> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>>>>>
>>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>>>> getting ready to enable it, globally.
>>>>>
>>>>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>>>>
>>>>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>>
>>>>> This helper creates a union between a flexible-array member (FAM) and a
>>>>> set of MEMBERS that would otherwise follow it.
>>>>>
>>>>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>>>>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>>>>> start of MEMBER aligned.
>>>>>
>>>>> The static_assert() ensures this alignment remains, and it's
>>>>> intentionally placed inmediately after the related structure --no
>>>>> blank line in between.
>>>>>
>>>>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>>>>> to the end of the corresponding structure.
>>>>>
>>>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>
>>>> NACK.
>>>
>>> Just a small reminder about community conventions: reviewers can NACK
>>> a patch, but authors generally should not NACK their own patches.
>>
>> It's obvious that you don't understand what's going on here.
> 
> I’ve read through the full discussion and understand how this evolved.
> Based on that, I believe there may be a misunderstanding on your side.

Okay, thanks for your contribution then.

-Gustavo

> 
>>
>>>> I didn't write this patch.
>>
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This line should've given you a clue.
>>
>> -Gustavo
>>
>>>>
>>>> Please, don't ever submit modified patches on my behalf.
>>>>
>>>>> ---
>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>
>>>> Patch granularity is a fundamental thing. Changes addressing different
>>>> issues should not be mixed together. Previously existing issues (if any)
>>>> must be addressed in separate patches.
>>>>
>>>> -Gustavo
>>>>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>>>>>     1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> index fd48075810dd..3ffd7be8e7b1 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>>>>         u32                     rkey;
>>>>>         u32                     length;
>>>>>
>>>>> -     /* SRQ only */
>>>>> -     struct {
>>>>> -             struct rxe_recv_wqe     wqe;
>>>>> -             struct ib_sge           sge[RXE_MAX_SGE];
>>>>> -     } srq_wqe;
>>>>> -
>>>>>         /* Responder resources. It's a circular list where the oldest
>>>>>          * resource is dropped first.
>>>>>          */
>>>>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>>>>>         unsigned int            res_head;
>>>>>         unsigned int            res_tail;
>>>>>         struct resp_res         *res;
>>>>> +
>>>>> +     /* SRQ only */
>>>>> +     /* Must be last as it ends in a flexible-array member. */
>>>>> +     TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
>>>>> +             struct rxe_sge          sge[RXE_MAX_SGE];
>>>>> +     ) srq_wqe;
>>>>>     };
>>>>> +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) ==
>>>>> +           offsetof(struct rxe_resp_info, srq_wqe.sge));
>>>>>
>>>>>     struct rxe_qp {
>>>>>         struct ib_qp            ibqp;
>>>>> @@ -269,7 +271,6 @@ struct rxe_qp {
>>>>>
>>>>>         struct rxe_req_info     req;
>>>>>         struct rxe_comp_info    comp;
>>>>> -     struct rxe_resp_info    resp;
>>>>>
>>>>>         atomic_t                ssn;
>>>>>         atomic_t                skb_out;
>>>>> @@ -289,6 +290,9 @@ struct rxe_qp {
>>>>>         spinlock_t              state_lock; /* guard requester and completer */
>>>>>
>>>>>         struct execute_work     cleanup_work;
>>>>> +
>>>>> +     /* Must be last as it ends in a flexible-array member. */
>>>>> +     struct rxe_resp_info    resp;
>>>>>     };
>>>>>
>>>>>     enum {
>>>>
>>>>
>>


