Return-Path: <linux-rdma+bounces-17260-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIt4KvnfoGk4nwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17260-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:06:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A191B11FA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AC930488E3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAE19F135;
	Fri, 27 Feb 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5PtqJVm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228919DF4F
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150769; cv=none; b=MjNwYdHIxyB2/UF4kvXfYqr+wKlocb+qSy425Qa4a9XiNFlX/ZulY7rClbn24obQXGr1o0Pgo6kEn4z0B/Rw5Zcz219y9T+XJpoEDyhrCtJ4IDQF50NVT7SJ6/fBB5JFh9bD8xnlM86pb6kWXCzGWjDuNAzgg+7qe5aMJEc016k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150769; c=relaxed/simple;
	bh=JOCyhNM2dy+R0wuiPlgjErmmNfNjqBRx7kHoDDyhui0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUOQh7QSHM3zQjJtyv574O21qawh6DCwXa168MTuJFWV5hXKMWH0B64Dm31LUeT80Ziqa9y+KwhhCkw55X9aHR9brFVYfO7BF6l4/eEUoiwSqBnDJgV8LTiT3vvuioJ4kYfEOaX5De5nbQtqkZn3f2caKohFZIeG2FKG3FFiNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5PtqJVm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8098445a-c778-4b11-be88-6243aba98268@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772150765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8A1xEq8Fxp2J6ncLujVbWR5bTzFfSfO521RgjNbBEI=;
	b=M5PtqJVmoKPLvr2WLPx2eb4YdPRrjPWbasa99aIeJAGyz0Fqc3nDwEOjNGKK3fnbB3s35R
	oXGDzDkZreovGYSAIBE3kO4+OD997YZIT5ZhRWmiqOSO2Qm+PpTwSF2jHh8ogLs3RDTL+C
	mySROwpG1si5yaFRHYSK5odlzimlOMM=
Date: Thu, 26 Feb 2026 16:06:01 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
To: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260225172622.7589-1-dsahern@kernel.org>
 <e87e7871-d35e-4b91-a00f-1491ac5b6dab@linux.dev>
 <18ecbd06-baac-43ee-a455-6b34c716fdfe@kernel.org>
 <88b82e8b-40da-46cf-bb41-2c346bd28c70@linux.dev>
 <20260226064755.GA12611@unreal>
 <cfad2c5c-23a9-4034-ad71-2c1ea21ff597@linux.dev>
 <8ed32ed9-3931-4b2b-8f44-0023aa998b5c@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <8ed32ed9-3931-4b2b-8f44-0023aa998b5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17260-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 23A191B11FA
X-Rspamd-Action: no action

On 2/26/26 8:06 AM, David Ahern wrote:
> On 2/26/26 8:51 AM, Zhu Yanjun wrote:
>> Thanks a lot for your reply.  I’ve already submitted a similar patch
>> earlier.
> 
> In Jan 2021, rxe had no network namespace support. We fixed that and
> carried a patch (in stealth mode at the time).
> 
> In Feb 2026, rxe in Linus' master and rdma-next do not have network
> namespace support. I sent our well tested solution that works out of the
> box with behavior similar to how init_net works.
> 
> If you are interested in your design approach getting merged, then make
> it happen for 7.0-next. If you do not have the time to commit to it now,
> then step back and let this patch move forward. That is how Linux works
> - post ready-to-merge patches, not intentions.

Hi, David

Thank you for your feedback and for pushing this forward.

I completely agree that "ready-to-merge patches" are what drive the 
kernel forward. To that end, I have just finished rebasing and updating 
my implementation from 6.14 to the current 6.19-rc (and it’s ready for 
7.0-next).

I have full respect for your long-standing work on this. Since we both 
have functional solutions now, I suggest we quickly compare the design.

My goal is the same as yours: to finally get netns support into rxe for 
7.0. I will post my updated patch set shortly so the maintainers can 
evaluate both.

The patch link is: https://github.com/zhuyj/linux/tree/6.19-net-namespace

Please code review.

Best regards,
Zhu Yanjun

> 


