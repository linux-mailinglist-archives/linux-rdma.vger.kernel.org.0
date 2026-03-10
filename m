Return-Path: <linux-rdma+bounces-17910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLWrCRqAsGmwjwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:33:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4014257E68
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5FC3301027C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 20:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D101636897A;
	Tue, 10 Mar 2026 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XRV93kWk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811A366824
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174761; cv=none; b=eNZiyD+UXd/3UZ9kpM+fk778sI7CtkSuVmIEDYH6d/9qfR9xQ4TmhFglzRQvUYkvKCsEcbLBIRCUglqM+3zy3WprpcBO5dYCIMnBurwbB/MnLJun3Mw8JDKJF6EFU6EPKlcWxT7w4IH1b0kl5iBi69A3FQuFrz2HlUT4SHbOXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174761; c=relaxed/simple;
	bh=K/Fm97Y4AEzSGBZcKtx4usftaviZNF5VHyoiYD98CVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttKmRsSH0eKqSjXzD2Vy4REVXQYTc4BnfF7T+a+rDL5N9rN1lqEVN905/KYtGKS7WTSIKYOasgEH0VqwcK8Qv9EgsL3W22lYg6dPnll6yhyCDwSoc8dQUnqyvwXsLztO37vRCaTGsrIDoKOg6uj8MYuDfj6ALNnBgcxCcaQysQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XRV93kWk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eaf37917-76aa-4869-a37b-5a1acb4ba7ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773174757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+/Im1WgOzXUxOrElOu4QyfUNde2pMiNwqi2Z33FQB0=;
	b=XRV93kWkfdVWMR87tVopXUVt/HZLI3gIqLERfYbOqZKLZlzZF592lt5u0t7dRHNk6GduC2
	6YpmVabQy66YRdwky+2DDzcZJ/frxg+JGfvMpoIGI6/jkB1W5dFSg+uSxhIRNrfTf+fmg6
	GjqOspG0OWjm1vzuVREjaso8riXUsLc=
Date: Tue, 10 Mar 2026 13:32:30 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260310185744.GK12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B4014257E68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17910-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action


On 3/10/26 11:57 AM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 03:05:17AM +0100, Zhu Yanjun wrote:
>> After introducing dellink handling and per-net namespace management
>> for IPv4 and IPv6 sockets, extend rxe to create and destroy RDMA links
>> within each network namespace.
>>
>> With this change, RDMA links can be instantiated both in init_net and
>> in other network namespaces. The lifecycle of the RDMA link is now tied
>> to the corresponding namespace and is properly cleaned up when the
>> namespace or link is removed.
>>
>> This ensures rxe behaves correctly in multi-namespace environments and
>> keeps socket and RDMA link resources consistent across namespace
>> creation and teardown.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c     |  38 +++++++-
>>   drivers/infiniband/sw/rxe/rxe_net.c | 145 +++++++++++++++++++++-------
>>   drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>>   3 files changed, 146 insertions(+), 46 deletions(-)
> <...>
>
>> +#define SK_REF_FOR_TUNNEL	2
> <...>
>
>> +#undef SK_REF_FOR_TUNNEL
> We typically place defines at the beginning of a file and avoid undefining
> them. The undef directive is mainly used when a macro is defined inside a
> function.

Defining macros locally helps clarify the intent behind specific values.

By pairing the #define with a trailing #undef, we gain the descriptive

benefits of the macro while maintaining strict control over its visibility.

I will put the definition of the MACRO in the function, following your 
advice.

Thanks.

Zhu Yanjun

>
> Thanks

