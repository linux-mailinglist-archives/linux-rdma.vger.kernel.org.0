Return-Path: <linux-rdma+bounces-15178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79109CD849B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 07:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB07B30274FF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC31FE44A;
	Tue, 23 Dec 2025 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XLRZSthk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45023E355
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472414; cv=none; b=jzSbl6YjTOI30iKzxzHxPasgfKHEnq3OKQMIGSU8Nnu7p4YaoM/XCjGX2Gt3P2PrSrcA4fJusW1WF6a1Otb47IXwDWct/SUu/SpQ8M+DsAcqDAGdQQ/R79S35fRKHf1npsHA30ICUwbqoob6BBw7WqBrSLOXe3UMMcipIY8lI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472414; c=relaxed/simple;
	bh=SPHyWl39ZDdojV3skGlX6PjWTErGXez/LzveK9bTIP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bj0Aipi5vO7i6oECzVX3meLp/w2SNm/KwQAhNj9I1WT2L6hWLHX8qzg269ypzIehhoMpYsjpvD/UG4nfZ2MnrXWaHKuExy2rBmrNPS0mqgGHYZl/BDH9AosBQDCqODmFvDS4EUTr2UYtM0puFTeJ078X16qy5hGjlP5rfz5xEbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XLRZSthk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <061c81dd-c582-414e-999c-7256a98ced42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766472399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGXxjCbwqFnoQbQ7VX6tfZlhS9rrq51K5OeFz/BwmmY=;
	b=XLRZSthkDuPzEBirx1kcMAaLkgtpmlV+bUBuCd5n56tSPa0Uelr3I85pyoV53eBfPwyUyM
	4c/RBeoUWiWhX/GQnlRPlVJi+YjUmylyLjhJakGtRNkYk8L99RO4vEDRMxCZFGNeAIhFPW
	VN+FmA1qkdsm1aR78gt9QP5a7/dxYsg=
Date: Mon, 22 Dec 2025 22:46:33 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <256da54b-519f-461d-9586-10b26ef7568e@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/22 21:54, Gustavo A. R. Silva 写道:
>
>
> On 12/23/25 14:44, Zhu Yanjun wrote:
>>
>> 在 2025/12/22 21:34, Gustavo A. R. Silva 写道:
>>>
>>>>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>>>>
>>>>>>> What are you doing?
>>>>>>
>>>>>> Because struct rxe_sge differs from struct ib_sge, I aligned it 
>>>>>> to use the same structure.
>>>>>
>>>>> Listen, this is not how things are done upstream. Read what I 
>>>>> previously commented:
>>>>>
>>>>>>> You're making a mess of this whole thing. Please, don't make 
>>>>>>> changes
>>>>>>> to my patches on your own.
>>>>>
>>>>> and please, learn how to properly submit patch series.
>>>>>
>>>>> Lastly, do the changes that you want/need to implement in your 
>>>>> code, and don't
>>>>> submit my patch as part of those changes again.
>>>>
>>>> You can correct this patch by yourself.
>>>
>>> https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com/ 
>>>
>>
>> You need to do some changes in your commit.
>
> This is what you haven't understood yet. If the original code is wrong 
> (e.g. is
> currently using struct ib_sge instead of struct rxe_sge or the other 
> way around),
> then _that_ code should be fixed _first_, regardless of any other 
> patch that might
> be applied on top of it.

Your commit should align the 2 structs.

Thanks,

Yanjun.Zhu

>
> -Gustavo
>
-- 
Best Regards,
Yanjun.Zhu


