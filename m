Return-Path: <linux-rdma+bounces-15177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5959CD839E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AAF3014AD9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF02F1FC3;
	Tue, 23 Dec 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bzHmbdlJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97412DFA32
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469288; cv=none; b=JhEEQ9yZCFVIKwxIi1tUB+mEoweLGbYFL8UAfR6N5AuXSLRromdwrXBpxFL6z9TMzYcmfewe6dzok4U6o0c8a9p6Z9q61yVFFDbNQiCIpylaUHI10GoWV81P2GwAVyDKm5/5cMO0Y9keuXd3NNgXj/T6XF4qVelwbxeVxfrhekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469288; c=relaxed/simple;
	bh=M4GL+WA4/xTc66CpadyONKAdoU0ng8bpk6HClP0Ms/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPbNsRlyulxB7+qEWIOPc8oKDVt6SXFyfNfNbTzwT0dZPl/35+ReM/r0i3oVKXsOBMJMQQTiil5HsaphmzxeLogssit8GHKpElTR40Wk7iERScx2Sm8S5npTLJtuUpRTqeXAZOa53ZMdgcN8f2Tq8NEluq48Xd7rr5ihKx9wS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=bzHmbdlJ; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id XtIhvNVuJVCBNXvM6vFbLH; Tue, 23 Dec 2025 05:54:46 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XvM5vJW7ZK8vzXvM5vW8tb; Tue, 23 Dec 2025 05:54:46 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=694a2ea6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=EwVepkG6xEaV1dHHZfIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U8ntNxmqguTZi5DzO1BxoqINhrh3zo75kD3aKyyf9Zg=; b=bzHmbdlJymINoHZwkQj4lXn7V9
	EiD57xjAzzDrN9ZsNFLxhaHYdIj21BYBECOkgHCqT6TsB0kZIwN8BhG+NS5tN5+VKgQWBZojVOC77
	fSw51XhfcdRA0BydGlAFrb1rQs2BPZ8dGg9yDqkAY2WyQCCyYfalOzZXeVU3owmypdqO7ceSkwqB5
	6CevC3Ff7ZbTdCJJgwTzr2BtUAWMsH2cXWkGWMusheKsMxWuUhsErrq9dTVQEx1qbXKJM5WmZ88f3
	IZH+CZNnx8+y/QeY/pw0xP0m7wGoAhE9LPw3qzyI0lv/Y35gbr5o2WmDelgkNr2WSExwONrN+UP6z
	Jp6Emdow==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:64091 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXvM4-00000004FSf-2o4X;
	Mon, 22 Dec 2025 23:54:45 -0600
Message-ID: <256da54b-519f-461d-9586-10b26ef7568e@embeddedor.com>
Date: Tue, 23 Dec 2025 14:54:36 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
 <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
 <7de9609c-afa2-4536-a65c-67e623885870@linux.dev>
 <77f7670a-db1f-41a2-afe8-58397e888118@embeddedor.com>
 <24901de5-f7dc-4070-8745-df114ce1ff75@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <24901de5-f7dc-4070-8745-df114ce1ff75@linux.dev>
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
X-Exim-ID: 1vXvM4-00000004FSf-2o4X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:64091
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfONptIseF905VGbA96hvQcG2OXLPYh0MDfv0VYAG5sLzcC5CFkOuHiY7yGuOvYa7gYLz8mlxFn2qHXa/oNsxr6TYSA57U5unP0Gf9VyP1ijLHG0MldoA
 Mvk0JL3uStyFhzfeuNqdDPSIx3nPgKITq3YMz7iVderReRZQnbOgua9QGiQyrmDT1NKsDDEnoKjB7CbC9u8orM4RHP67riehcgEHfWXXmkzcYgXTIRMDhbPi



On 12/23/25 14:44, Zhu Yanjun wrote:
> 
> 在 2025/12/22 21:34, Gustavo A. R. Silva 写道:
>>
>>>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>>>
>>>>>> What are you doing?
>>>>>
>>>>> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the same structure.
>>>>
>>>> Listen, this is not how things are done upstream. Read what I previously commented:
>>>>
>>>>>> You're making a mess of this whole thing. Please, don't make changes
>>>>>> to my patches on your own.
>>>>
>>>> and please, learn how to properly submit patch series.
>>>>
>>>> Lastly, do the changes that you want/need to implement in your code, and don't
>>>> submit my patch as part of those changes again.
>>>
>>> You can correct this patch by yourself.
>>
>> https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com/
> 
> You need to do some changes in your commit.

This is what you haven't understood yet. If the original code is wrong (e.g. is
currently using struct ib_sge instead of struct rxe_sge or the other way around),
then _that_ code should be fixed _first_, regardless of any other patch that might
be applied on top of it.

-Gustavo


