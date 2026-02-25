Return-Path: <linux-rdma+bounces-17191-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJLbBaBkn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17191-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3419DA12
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8990C300FEED
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19BB2EBBA9;
	Wed, 25 Feb 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="msAkMAMN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230630FF1D
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053642; cv=none; b=KygDbKvynX/uhGk8mVCrhkPB2An62pqcb6Rcl54QMYNcnUAYC5alBzO2GlNyavwf/MtlzP54lVnllSlGhz6SUghzMfDnsHuT1xx33ZAmv41onQmEQv+88V3X/eesjmvIIItDzcHtGGM7UUmnsjvXnxIwq4O17xd2p9Ag0i5PIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053642; c=relaxed/simple;
	bh=4L5ylhVOgOSwljIX1MsYUSGTra4DKD+HXczgHtkk/8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPkrBv6rMZ/EwjpWB7Iokt0r+HCpBfR2H0dfjNdJ6smVoz/yNUQVdS0ENxLEeamm8fWoePHcAFvdy+YdAZPRPDfkO0On2IcNFZsMK5GhQai+51jA27CAcI//vTdZ57ARSFtvZcb4IKq5xHuI60l2fK1jRzSUsRn0p0XQ1UoC4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=msAkMAMN; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772053638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPPnMgByVNLq/T1u9PXTxu9YZLDxlKS4gtMtP/DdBzo=;
	b=msAkMAMNWFXI/yb8Dh6Ait43HfkWYvBt8uy0L4vtXIArk07q+bWhYBibY4fFmul9J6wYL9
	mVVIzYx/sn23JVtLMfXxbJJzt+0LMPvD7jf32L97peOqcRcr/mxrAH5B9jGkFZUDYF59Rz
	7Eh/M8kipf1VkBKfgHmBGINFsnVbVXs=
Date: Wed, 25 Feb 2026 13:07:12 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
To: David Ahern <dsahern@kernel.org>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17191-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,2600:3c15:e001:75::12fc:5321:server fail,91.218.175.171:server fail];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27D3419DA12
X-Rspamd-Action: no action

On 2/25/26 10:50 AM, David Ahern wrote:
> On 2/25/26 11:14 AM, yanjun.zhu wrote:
>> On 2/25/26 9:26 AM, David Ahern wrote:
>>> Allow rxe to work across network namespaces by making the sockets
>>> per namespace using net_generic. Defer socket initialization until
>>> a device is created in the namespace.
>>
>> https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace
>>
>> Do you make tests with the above link?
> 
> no. I had no knowledge of that branch until this moment. It is almost 12
> months old, so not sure the relevance if it is not being actively fixed
> on top of tree.
> 
>>
>> Compared with the net namespace in the above link, what is the
>> difference between this commit and the above link?
>>
> 
> no idea. This patch was in our tree at enfabrica dating back to 2021.
> Someone started looking into automated tests with rxe, so I pulled it
> from the tree, rebased to 7.0 and sent it out.
> 

https://patchwork.kernel.org/project/linux-rdma/cover/20230624073927.707915-1-yanjun.zhu@intel.com/

In the above link, there is some testcases for the link 
https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace.

I am wondering if this commit can pass all the testcases or not.

Thanks a lot.
Zhu Yanjun


