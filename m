Return-Path: <linux-rdma+bounces-18013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHXrBQK+sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:09:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D626913B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF894315AD97
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4173358CF;
	Wed, 11 Mar 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ft13rTG/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82F3112BD
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256121; cv=none; b=uFshHKtVI3rRu/AnvaAHKoLv3sR5heJlTJWN8kIwQ2Iob2t79iK77iHgOhYmalZ4+yU0V74OGRG7dIu4CXz+MrLhWqgAv4k+A4hyAHqgeUY/pWsgZ6Lugt36jaPTGvbCSeBYjoTmpydEMmpufoIkBBUakkOpqbzhMAEfTbO5lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256121; c=relaxed/simple;
	bh=7+3/2NPdvKij0w5HAXrVpW+FkPx0tCYsr2lkYsD6yV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1mOJq+oz9alafcroyttaSXBR20k6znDGiwtzegBA0WujyBoAG/B1ECe3iVTt4jzCAn4ZsaB0l3ja2qgcQX/jdXW24Vjv2aq33Hab3QvVgB2cO2y8HQcZtfjJePPmsSiNcTJbhS3CTfHrZU24/NfpdDZsqFImwMrjrWC1jPMfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ft13rTG/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a658ac9c-c25f-4235-9c7c-e3fed35b4a8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773256114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJOiG4fotX9XX9rru93M+rAuocfwhkAomq2GSVrwsL4=;
	b=ft13rTG/4sTVsno6cGstB5Cf1sOky+lRq1gX5ssjlX63JReMCf4Qkbasg5a0LzfKJHuh5X
	IQYKpwYbERb4nbunZscs56gSu2X8dYDXLjfF1OWjtpfwRHLf38/vB/Hw5jHW7tu1gnfifC
	ks/gjq+NhioA+BZI41jKLbtbgMZuVbA=
Date: Wed, 11 Mar 2026 12:08:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-4-yanjun.zhu@linux.dev>
 <20260310185744.GK12611@unreal>
 <eaf37917-76aa-4869-a37b-5a1acb4ba7ae@linux.dev>
 <20260311084523.GU12611@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260311084523.GU12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18013-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D7D626913B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/11/26 1:45 AM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 01:32:30PM -0700, Yanjun.Zhu wrote:
>> On 3/10/26 11:57 AM, Leon Romanovsky wrote:
>>> On Tue, Mar 10, 2026 at 03:05:17AM +0100, Zhu Yanjun wrote:
>>>> After introducing dellink handling and per-net namespace management
>>>> for IPv4 and IPv6 sockets, extend rxe to create and destroy RDMA links
>>>> within each network namespace.
>>>>
>>>> With this change, RDMA links can be instantiated both in init_net and
>>>> in other network namespaces. The lifecycle of the RDMA link is now tied
>>>> to the corresponding namespace and is properly cleaned up when the
>>>> namespace or link is removed.
>>>>
>>>> This ensures rxe behaves correctly in multi-namespace environments and
>>>> keeps socket and RDMA link resources consistent across namespace
>>>> creation and teardown.
>>>>
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe.c     |  38 +++++++-
>>>>    drivers/infiniband/sw/rxe/rxe_net.c | 145 +++++++++++++++++++++-------
>>>>    drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>>>>    3 files changed, 146 insertions(+), 46 deletions(-)
>>> <...>
>>>
>>>> +#define SK_REF_FOR_TUNNEL	2
>>> <...>
>>>
>>>> +#undef SK_REF_FOR_TUNNEL
>>> We typically place defines at the beginning of a file and avoid undefining
>>> them. The undef directive is mainly used when a macro is defined inside a
>>> function.
>> Defining macros locally helps clarify the intent behind specific values.
>>
>> By pairing the #define with a trailing #undef, we gain the descriptive
>>
>> benefits of the macro while maintaining strict control over its visibility.
> Zhu,
>
> Tell your AI that, in the context of Linux kernel code, its response
> is incorrect.

Got it. I will place this define at the beginning of a file and avoid 
undefining it.

The latest commit will be sent out very soon.

Zhu Yanjun

>
> Thanks
>
>> I will put the definition of the MACRO in the function, following your
>> advice.
>>
>> Thanks.
>>
>> Zhu Yanjun
>>
>>> Thanks

