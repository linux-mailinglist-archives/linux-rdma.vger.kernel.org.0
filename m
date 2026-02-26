Return-Path: <linux-rdma+bounces-17235-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBdJEnlsoGk3jgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17235-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:53:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E21A9274
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC9543004617
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A165425CFF;
	Thu, 26 Feb 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IfnB3Ngu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F32425CFA
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121126; cv=none; b=i+CBAxA09VwICLVFyC9hLncDg2s+CDerAWPKO4PReO8evnNZ/dx0b04VPrPS5KLZtE7kq532qvc76eWlGacQGujQPLBdxmFA/MIwMm59e9jI+8ApBusHW9q82nJhccASUPW2gyt9t9k3ummOMEStzefLIf3NcxhXJou9/IS4Oh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121126; c=relaxed/simple;
	bh=R84YBs/88lp0kVPJJ9kqA5v8MSzJ0Ele+RpwsPgmvYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIWDIEIrCRZsbD0eQYhcWYPknMrGa3IhAmMQsWg515cGcHpKCn5gnuGBk7q+bqDfbEqbJ61FrcxpuiIv+O1Rqn/JdTj07Be34DediBcz8WggN5dsgJzQhH1ZByLIf8HAXaaD8XlxY4QTZMMi3mbGrlKpKXYaf9Y7oxd/ML6zRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IfnB3Ngu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772121117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHxV2Yc6utcozHeIuP3/z9zoypRkXaaC+elu2iU2bqM=;
	b=IfnB3NgurvV2C1V8M2Y6OSvRLrzdNdxKT/QheGMOTzUBIvSinUSHtXjEtYI0GPDgSBX7nn
	LX9qVo4lgl/ZL0JAe3H5IaCG4eBzgiCQtGqFNOxnf346sll/KgNhEjA+r/N31dHLoQw0eH
	Jyksj57xaKsNKrGiCeSQLSsNI70i41o=
Date: Thu, 26 Feb 2026 07:51:52 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
 <20260226064755.GA12611@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260226064755.GA12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17235-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF3E21A9274
X-Rspamd-Action: no action


在 2026/2/25 22:47, Leon Romanovsky 写道:
> On Wed, Feb 25, 2026 at 01:07:12PM -0800, yanjun.zhu wrote:
>> On 2/25/26 10:50 AM, David Ahern wrote:
>>> On 2/25/26 11:14 AM, yanjun.zhu wrote:
>>>> On 2/25/26 9:26 AM, David Ahern wrote:
>>>>> Allow rxe to work across network namespaces by making the sockets
>>>>> per namespace using net_generic. Defer socket initialization until
>>>>> a device is created in the namespace.
>>>> https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace
>>>>
>>>> Do you make tests with the above link?
>>> no. I had no knowledge of that branch until this moment. It is almost 12
>>> months old, so not sure the relevance if it is not being actively fixed
>>> on top of tree.
>>>
>>>> Compared with the net namespace in the above link, what is the
>>>> difference between this commit and the above link?
>>>>
>>> no idea. This patch was in our tree at enfabrica dating back to 2021.
>>> Someone started looking into automated tests with rxe, so I pulled it
>>> from the tree, rebased to 7.0 and sent it out.
>>>
>> https://patchwork.kernel.org/project/linux-rdma/cover/20230624073927.707915-1-yanjun.zhu@intel.com/
>>
>> In the above link, there is some testcases for the link
>> https://github.com/zhuyj/linux/tree/upstream/6.14-net-namespace.
>>
>> I am wondering if this commit can pass all the testcases or not.
> Zhu,
>
> It is a bit unreasonable to expect a random RXE contributor to compare
> against something that lives out‑of‑tree. Please feel free to pick up that
> patch and run it through your tests.

Hi, Leaon

Thanks a lot for your reply.  I’ve already submitted a similar patch 
earlier.

About this commit, after running it through my test cases, I found that 
some

of them do not pass. I’ve replied on the thread to let the developer to 
check it.


At the moment, I’m working on addressing a few related problems and 
re-validating

the behavior. Once things are in a better shape and if time permits, I 
plan to resend

my version of the patch for further review and testing.

Thanks for your understanding.

Zhu Yanjun

>
> Thanks
>
>> Thanks a lot.
>> Zhu Yanjun
>>
>>
-- 
Best Regards,
Yanjun.Zhu


