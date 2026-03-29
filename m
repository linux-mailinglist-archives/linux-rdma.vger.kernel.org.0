Return-Path: <linux-rdma+bounces-18760-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIB0HAKxyGm6owUAu9opvQ
	(envelope-from <linux-rdma+bounces-18760-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 06:56:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA9350C0F
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B50B3005323
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99B22F77B;
	Sun, 29 Mar 2026 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQDMjPmF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37E26B2CE
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774760188; cv=none; b=tkkRFMaGBuwk/rnxHoqkAPYhes/Fh4OCSGO1AcAfNOP+QArRMsEy7baZ9UQaMu6jeSzkUFDLUk1zAnlLMzC03rTQPMaslHDLlpDD572f/F7jfEPJ/CnJ+eeLkmw25qpzLXCynHyUuT2rEDGZ9+ZqDJhpPf0IptUrhbI0yCVDBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774760188; c=relaxed/simple;
	bh=oU/a3RCot96VV4uM6XU9A8NLYqLpK7UszhxF4L5pzgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbTi3WMjjalymR/q4k4Z/tas+XEiRbAA0dmP/gl5URm7P4wwvb4VQ7ra6jZrzNtteaeuynracKoTghzV9fSfJOVK6RfYrRfDxCi6I1u4iS4p4Vy0Z/7V7Pzx60Cs6nvBFwu9CHfDBFXpJGSJb7PiOOn9Mqn98ykDEJFgXWyJHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQDMjPmF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cb474cf-4610-4dc6-b87f-83a9d26122ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774760184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7pKeZZ5u0do+GeuidQwFc8oBGmigXH9HGGSIgG0Y2A=;
	b=CQDMjPmFf7AWGI5+3/SdBdCYmYiix6yFp32b00Zz9H40/58g2kaxz5Adrkft73p6J6KQwq
	/W4bWA7Q7RP5zZWOWnarNw9O1ldlYRAs4ULOdzBK6xpm9eWmxyWETUaG3ZgFU52wRZNBcK
	6voq9dXqyx8Y0htZ118kdiKPYohnM1w=
Date: Sat, 28 Mar 2026 21:56:19 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] RDMA/rxe: use rxe_counter_get
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260329025552.122946-1-zhenwei.pi@linux.dev>
 <20260329025552.122946-5-zhenwei.pi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260329025552.122946-5-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	TAGGED_FROM(0.00)[bounces-18760-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5DFA9350C0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/3/28 19:55, zhenwei pi 写道:
> There is *rxe_counter_get* helper in RXE, use it instead of raw
> atomic64_read.

This commit can be merged with the commit "[PATCH v2 3/4] RDMA/rxe: 
support perf mgmt GET method"

Zhu Yanjun

> 
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> index 17edaa9a9b9b..a612e96f7a88 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> @@ -37,7 +37,7 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
>   		return -EINVAL;
>   
>   	for (cnt = 0; cnt < ARRAY_SIZE(rxe_counter_descs); cnt++)
> -		stats->value[cnt] = atomic64_read(&dev->stats_counters[cnt]);
> +		stats->value[cnt] = rxe_counter_get(dev, cnt);
>   
>   	return ARRAY_SIZE(rxe_counter_descs);
>   }


