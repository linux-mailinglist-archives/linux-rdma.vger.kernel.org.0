Return-Path: <linux-rdma+bounces-20456-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAIIBRegAmpivAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20456-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 05:35:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183251956E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 05:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA0C3027319
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188227E1DC;
	Tue, 12 May 2026 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nh0rXcPE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235B191F91
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556946; cv=none; b=aEtKMzD+cjb6A499REsXnXiRlhxrTmY4O52jjajUYCaI/+Wl/HbEcRrABfcC4opPYIUMTMy0hIM9zRxscJEKcElspwnE+BTPVVpCuAUwMRKgPA6I6lWfKq88Rc4C23p7fVLmAgW7s9Us0hvUNrIAlPUroOCKC4yROsbIpLrCGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556946; c=relaxed/simple;
	bh=hrvpMzWv+L9jBR4yQaKBFSn2oD8yHBLeml8I2BQPBjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjGv434Q6Ixfvqk/SovMO5sRMEB2JhLWluI2rGFcog6JMo+jCLUnwCT4GrigKj889fONh5KweJ6dY3c9fvx2iFeTsl2IjAS29Zc5Cg6IHCVbsnetItNsiK//cQBP8cwLnWzbjqnlQIwz6Hw1f0jG3IRC2s6BNcGCYHH75iOO9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nh0rXcPE; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <558fe8e4-2283-4921-bae0-6b68d9a9d65d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778556942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IpVf2OhJaundnWBSHbPL1U/rEUI71ep4K62Mi8ngw0=;
	b=Nh0rXcPEoMEdn0MCRDqTcewin/I5xBemPdjahW+V+CRYKgGwwNudOJZ0hBHv5Ia/ZkX6Ne
	eEl3JgN45n1Ycl35Bb10OjzJlOfjfK9NnWnbfoypDb649EewXbNb9c/UwKPtlL6OIcov8e
	nJ7/MpRTU3y7n4oAd4iEPyUYPr+FwcY=
Date: Mon, 11 May 2026 20:35:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace
 cleanup
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260424043522.22901-1-yanjun.zhu@linux.dev>
 <20260427123503.GI440345@unreal>
 <805dcebc-39c6-4140-b07f-f76b7594c9d8@linux.dev>
 <20260428142653.GQ440345@unreal>
 <3bc69e75-1b4b-4bb9-87c4-7db863acc3d2@linux.dev>
 <8b7650f8-2957-4318-841a-473738a605ef@linux.dev>
 <20260511123701.GI15586@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260511123701.GI15586@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8183251956E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20456-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On 5/11/26 5:37 AM, Leon Romanovsky wrote:
> On Wed, Apr 29, 2026 at 04:31:48PM -0700, yanjun.zhu wrote:
>> Hi, Leon
>>
>> I have performed further tests to verify the execution order and the
>> necessity of the cleanup code in rxe_ns_exit().
>>
>> My findings show that a double-free race condition is unlikely because of
>> how the kernel manages namespace references:
>>
>> Reference Dependency: The RXE RDMA link holds a reference to the network
>> namespace.
>>
>> Order of Execution: When a namespace is deleted while an RDMA link exists,
>> rxe_ns_exit() is not invoked immediately. It is deferred until the RDMA link
>> itself is deleted (e.g., via rdma link del), which drops the final reference
>> count of the namespace.
> 
> AFAIC, we've seen syzkaller reports where "rdma link del" was never invoked,
> yet RXE was removed regardless. Is it possible?

Hi Leon,

Thanks for your feedback.

Regarding the case where "rdma link del" is not invoked, I’d like to 
share my observations on the namespace cleanup flow for RXE:

In my tests, when a network namespace is deleted (e.g., ip netns del), 
the RXE device (and its underlying net_device) is typically moved back 
to the init_net rather than being destroyed immediately. This is why the 
RDMA links still show up in init_net and the namespace reference count 
remains held.

As long as the device exists (even if moved), the resource cleanup is 
managed by the device's lifecycle. The rxe_ns_exit() only gets called 
when the last reference to that netns is dropped, which usually happens 
after the RXE device itself is finally deleted.

I haven't personally encountered the syzkaller reports where this logic 
fails or leads to a leak/crash. If possible, could you please share the 
specific syzkaller logs or the link to the report? It would be very 
helpful for me to understand if there is a specific corner case (e.g., 
driver unloading or abnormal netns teardown) where the per-net cleanup 
acts as a necessary "safety net."

If such a race exists, I will reconsider whether to keep the cleanup 
code or move it to a more robust location.

Best regards,
Yanjun Zhu

> 
> Thanks


