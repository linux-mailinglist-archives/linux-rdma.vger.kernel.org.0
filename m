Return-Path: <linux-rdma+bounces-15176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4ACCD8361
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEEFA3011F95
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADD21FF5F;
	Tue, 23 Dec 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TqA7CTW4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19E2F49E3
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468698; cv=none; b=nz0BFfZjrVE/QrHh3ydbWqjIyy/Pr3kfjrecxBWePtOEm0EONy6A4x2eqKFYqGmdElZZgki2IKMK12yQy/rEF0Z2U648bB3x5y2UCcfg4PwBbi8FBmDHTWfdJym5cXIzQALZF/I3HSLWPNTS2t16JwnPdy7RJbGHt4cauJn2tJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468698; c=relaxed/simple;
	bh=BoaTMFDJuZCU0GGcNUjZSkfY7jQZ3CSonKJAXs+IBRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfQ6FlJ2dpqVrzBCl2hwQRPTsYyoQoFRe0BZjWUoMWi0gEmDz7SnYxwkkOBT+h2SpfeSHTnKN9UuiHDSfn8U57au0i78ArldboInk9A45KsVcKehbn4nxDJ9XEeP3Tg76+qk4lQ2Ve/ABuRgQ7M+XkEnA03dyGkznofnR4B0K0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TqA7CTW4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24901de5-f7dc-4070-8745-df114ce1ff75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766468683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mx6ScWRie2gcaLB9ZYodJYiBC5KUTrVq6ktVruhyAHw=;
	b=TqA7CTW4tMeHrANr9ExPe0aGT0fhQXdvMEBZi67LAydOQ2QO1d1hQojHCcDM8brq9fcRuo
	DMm123U40fq50EV/OhRsEj045auwrgXx79Ym2xSgzW4frzTMajoyqJ6/QseSmDkVKiqvxz
	tcPWZAeOn+YEq1DbKoXJvzzctk7ABMY=
Date: Mon, 22 Dec 2025 21:44:36 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <77f7670a-db1f-41a2-afe8-58397e888118@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/22 21:34, Gustavo A. R. Silva 写道:
>
>>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>>
>>>>> What are you doing?
>>>>
>>>> Because struct rxe_sge differs from struct ib_sge, I aligned it to 
>>>> use the same structure.
>>>
>>> Listen, this is not how things are done upstream. Read what I 
>>> previously commented:
>>>
>>>>> You're making a mess of this whole thing. Please, don't make changes
>>>>> to my patches on your own.
>>>
>>> and please, learn how to properly submit patch series.
>>>
>>> Lastly, do the changes that you want/need to implement in your code, 
>>> and don't
>>> submit my patch as part of those changes again.
>>
>> You can correct this patch by yourself.
>
> https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com/ 
>

You need to do some changes in your commit.

Yanjun.Zhu

-- 
Best Regards,
Yanjun.Zhu


