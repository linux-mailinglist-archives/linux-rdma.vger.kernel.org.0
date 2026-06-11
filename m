Return-Path: <linux-rdma+bounces-22095-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CNsiMOJNKmrBmgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22095-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 07:55:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4866ED43
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 07:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=dOe2gby3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22095-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22095-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9D731D643A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE726CE1E;
	Thu, 11 Jun 2026 05:51:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4712F6577
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 05:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157096; cv=none; b=pFsmmjx+1iH40WlMQPnKPuhjK75sXuk4ZwnhGRuyB2nI1N2GJi8q59f1HB8DsH0OPWZBDcBJIQWjtIFAjL6wgG8YeufnGDZOs+AJ8sU4z4fRlUcu3ba7gm0IY24I3cKFSc4xhN1GOeDxLWtUUptNTSDB0F/spNxiSTH0pyFtsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157096; c=relaxed/simple;
	bh=dGisnZqmPAZFfL8kjYgWW0e4YwjGgwiS6m+zIV43eP8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OhhpOtXOxk8XqIESuqmezeOyW+wZDBWaqcteBAAMtlciwVqJMEiIZ/D4DF0GZvIdXq9nagmddkz+678go+qIg7EejcS5wHpGle2WX6w2g7EG/oWOpm8acKNl7Tz5VOk8VvhzWmAIRWo42HNPKRmUCmBSMQg+2nFFByk4v6vWGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dOe2gby3; arc=none smtp.client-ip=95.215.58.187
Message-ID: <a05c2a15-f463-4d11-80a5-4e3721457c2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781157091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC/KYVOV6TRlIKlHxRxiiag6mj+5H/o1jkelZcT40dw=;
	b=dOe2gby3v154PihuESdG+wv8xUn7+rCgAqYxb2XldCN0EKpsHAP4V4cLb5oHEwSGoch2WQ
	+LbomiNoWeljBN/5Vlmrh09IaGcqsdirAGFYO6kQjPxmjYSGxwHDLozzHwEyIVEqhF+/4F
	0DERlJDl73G5+MEGZoL+9VJHWYx8ou8=
Date: Thu, 11 Jun 2026 13:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix FRMR handle leak on
 push_handle_to_queue_locked failure
To: Michael Gur <michaelgur@nvidia.com>, leon@kernel.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org
References: <20260608045657.2715472-1-cui.tao@linux.dev>
 <d791de9c-c100-49d2-ba69-7f79751556ef@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <d791de9c-c100-49d2-ba69-7f79751556ef@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:cuitao@kylinos.cn,m:michaelgur@nvidia.com,m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22095-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A4866ED43

Hi Michael,

Thanks for the review and the pointer to your series.

You're right — the i < needed_handles check is redundant since ret != 0 already implies we broke out of the loop before completion. Your approach of using break instead of goto end is also cleaner.

Thanks,
--
Tao

在 2026/6/10 20:25, Michael Gur 写道:
> 
> On 6/8/2026 7:56 AM, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> In ib_frmr_pools_set_pinned(), after create_frmrs() successfully
>> allocates handles, the push loop may fail partway through due to
>> -ENOMEM from kzalloc in push_handle_to_queue_locked(). The remaining
>> created-but-unpushed handles are silently leaked as they are never
>> destroyed.
>>
>> Call destroy_frmrs() for the remaining unpushed handles before returning
>> the error.
>>
>> Fixes: ce5df0b891ed ("IB/core: Introduce FRMR pools")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   drivers/infiniband/core/frmr_pools.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
>> index 5e992ff3d7cf..d7906fab033f 100644
>> --- a/drivers/infiniband/core/frmr_pools.c
>> +++ b/drivers/infiniband/core/frmr_pools.c
>> @@ -443,6 +443,9 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
>>     end:
>>       spin_unlock(&pool->lock);
>> +    if (ret && i < needed_handles)
>> +        pools->pool_ops->destroy_frmrs(device, &handles[i],
>> +                           needed_handles - i);
> 
> The second condition is redundant, only failure to reach this point is push() failure.
> 
> I've sent a similar fix in a series of fixes for frmr pools. Please take a look.
> https://lore.kernel.org/linux-rdma/20260610000145.820592-1-michaelgur@nvidia.com/T/#m34f6910f8b8e998b079fcf5f468cb3c5056f78b9
> 
> Michael
> 
>>       kfree(handles);
>>     schedule_aging:


