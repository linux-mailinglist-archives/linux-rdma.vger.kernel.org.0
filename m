Return-Path: <linux-rdma+bounces-16179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c2PsDgn5emkwAQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 07:07:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF668AC222
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 07:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0E7300A3A7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458DF369970;
	Thu, 29 Jan 2026 06:07:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A7125A9
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666820; cv=none; b=WlHGq2NAD3R5eFpnY1xGtZ6L5t9XJrwXR8fhA2jEaitlspz/qQegt39x5nWIZCu3atJJ2oPXZBe7v4hd8Xv2smQlMJQ2A0JWpMr7iBBs+H9CnNo6DNPOu/mBdG9/MpWY8PAl/UWKdKbEdJVdPvXMPmA7GMt8GFo3nKJEZYK0/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666820; c=relaxed/simple;
	bh=XsKxWGsq7MG9thjZFkqD71eVWMAz6EGBmfp7duBmEOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evH21RZ8nzCX/jigoGkKv9oakQBcHubgzzFIMUutEdrK5AOhuAr3xz7BfHxic7Mbde2RXXElM2JWJ7giwD9/bQZUDTf48qIGCP+KqoYUbfnlRcG1oJgzPHMjgZP0Up8OslDdSpChABbBfyUbLtc8a4C+wqZ/qi7ktMejUUp3UUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60T66VvB007947;
	Thu, 29 Jan 2026 15:06:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60T66Vbx007944
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 29 Jan 2026 15:06:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
Date: Thu, 29 Jan 2026 15:06:31 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com,
        maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com,
        markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16179-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: CF668AC222
X-Rspamd-Action: no action

On 2026/01/28 22:40, Jiri Pirko wrote:
> Wed, Jan 28, 2026 at 09:26:52AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>> On 2026/01/28 13:52, Tetsuo Handa wrote:
>>> Two things I worry about Jiri's patch are that
>>>
>>>   refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
>>>   DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()
>>
>> Well, since siw_netdev_event() is calling ib_device_put()
>> ( https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/sw/siw/siw_main.c#L403 ),
>> calling refcount_set() immediately before setting
>> xa_set_mark(&devices, device->index, DEVICE_REGISTERED) is no longer safe.
> 
> I may be missing something. How exactly is the notifier in siw_main
> related to this patch? I don't see it depends on DEVICE_GID_UPDATES
> mark.

I don't have an accurate and complete list of notifier callback functions that are called by
DEVICE_GID_UPDATES notifications. But in general, I think that there is a pattern that an IB
notifier callback function tries to grab a reference to "struct ib_device" before doing
something, and releases that reference after doing something.

If you can prove that none of callback functions that are called by DEVICE_GID_UPDATES
notifications follows this pattern, it will be fine for now. But that might change in future.
Enabling callback before initializing refcount is a source of refcount imbalance troubles.
I expect your proposal to include

 struct ib_device {
 	(...snipped...)
+	bool device_was_fully_initialized;
 }

 static inline bool ib_device_try_get(struct ib_device *dev)
 {
+	BUG_ON(!device_was_fully_initialized);
 	return refcount_inc_not_zero(&dev->refcount);
 }

 void ib_device_put(struct ib_device *device)
 {
+	BUG_ON(!dev->device_was_fully_initialized);
 	if (refcount_dec_and_test(&device->refcount))
 		complete(&device->unreg_completion);
 }

 static int enable_device_and_get(struct ib_device *device)
 {
 	(...snipped...)
 	refcount_set(&device->refcount, 2);
+	device->device_was_fully_initialized = true;
 	down_write(&devices_rwsem);
 	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
 	(...snipped...)
 }

for proving that there is no race.

Also, I don't know whether we even need to introduce DEVICE_GID_UPDATES.
Your patch description sounds to me that calling rdma_roce_rescan_device()
generates GIDs with current MAC. Then, why not call rdma_roce_rescan_device()
once again after xa_set_mark(&devices, device->index, DEVICE_REGISTERED) ?


