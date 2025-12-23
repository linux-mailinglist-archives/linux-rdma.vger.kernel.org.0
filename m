Return-Path: <linux-rdma+bounces-15188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F929CD9E37
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AD0300F332
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987025C809;
	Tue, 23 Dec 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhvZcaWb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD127472
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505744; cv=none; b=Cpui5Y9z/m/Z+f0IduLY0ZAunDNQcFltyz5OWy24+D4tLc7zALqfVC42KXFifxZ7vDyauvfoDR+0tBe6KUP/zGWRkzzUthyE9Z54CoRf0ICFoWCk6dJ90LysoNDaibjXsVzFIsjwidGYxcA3cw8VW0t216quzCFdrCysowlyDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505744; c=relaxed/simple;
	bh=Wgw4lUnhbAK2SuJREsC/TLvjP8fweiX3DpQoJ132GsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cznMkOm3gofZqKeakzTEwxO/YoTjA/FKUrYo80bpB1dH7C+7mLEHHzbw9oWH1bmDr//cDumy/U5Xe+/3orExAwkXfRfSMnKaLzcNj1N3bGFuaVAmLxHB4uIb7ZDyVwlmzz3FS8+zjl3o2I0cRoTl+MWn7CQdwnkjwa9PgXSE33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhvZcaWb; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6650ddc-7d9c-47ad-b24d-d6806f958648@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766505729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qno5Lv3o0et1YFZD/NDGPUTfKtUpErsqjsFbBj2QXc=;
	b=nhvZcaWbCkPRdE86r1kgT0agSrWwo6rlvqVYLuoQhkSt8ygvvx4rNsMSfSoP0fwdvTrWw7
	HPpMlFz2EyMqIdFj3rDJvdXyBb2qK3blUQPLfJJnLpnelJitBpekyCwHQEzj/JXbYlt6AG
	RbtYaK4uIlFjLT9Cyv3rhoNUz3CYXT4=
Date: Tue, 23 Dec 2025 08:02:01 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
 <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
 <7de9609c-afa2-4536-a65c-67e623885870@linux.dev>
 <77f7670a-db1f-41a2-afe8-58397e888118@embeddedor.com>
 <24901de5-f7dc-4070-8745-df114ce1ff75@linux.dev>
 <256da54b-519f-461d-9586-10b26ef7568e@embeddedor.com>
 <061c81dd-c582-414e-999c-7256a98ced42@linux.dev>
 <aedbed72-c080-406b-b9a9-391a413ced92@embeddedor.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <aedbed72-c080-406b-b9a9-391a413ced92@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/23 1:28, Gustavo A. R. Silva 写道:
> 
> 
> On 12/23/25 15:46, Zhu Yanjun wrote:
>>
>> 在 2025/12/22 21:54, Gustavo A. R. Silva 写道:
>>>
>>>
>>> On 12/23/25 14:44, Zhu Yanjun wrote:
>>>>
>>>> 在 2025/12/22 21:34, Gustavo A. R. Silva 写道:
>>>>>
>>>>>>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>>>>>>
>>>>>>>>> What are you doing?
>>>>>>>>
>>>>>>>> Because struct rxe_sge differs from struct ib_sge, I aligned it 
>>>>>>>> to use the same structure.
>>>>>>>
>>>>>>> Listen, this is not how things are done upstream. Read what I 
>>>>>>> previously commented:
>>>>>>>
>>>>>>>>> You're making a mess of this whole thing. Please, don't make 
>>>>>>>>> changes
>>>>>>>>> to my patches on your own.
>>>>>>>
>>>>>>> and please, learn how to properly submit patch series.
>>>>>>>
>>>>>>> Lastly, do the changes that you want/need to implement in your 
>>>>>>> code, and don't
>>>>>>> submit my patch as part of those changes again.
>>>>>>
>>>>>> You can correct this patch by yourself.
>>>>>
>>>>> https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af- 
>>>>> a1d2-5055749011c0@embeddedor.com/
>>>>
>>>> You need to do some changes in your commit.
>>>
>>> This is what you haven't understood yet. If the original code is 
>>> wrong (e.g. is
>>> currently using struct ib_sge instead of struct rxe_sge or the other 
>>> way around),
>>> then _that_ code should be fixed _first_, regardless of any other 
>>> patch that might
>>> be applied on top of it.
>>
>> Your commit should align the 2 structs.
> 
> No. It should not. To understand why, read my previous responses.

There is something wrong in your commit. Please correct it. I have 
already pointed it out.

Yanjun.Zhu
> 
> -Gustavo
> 


