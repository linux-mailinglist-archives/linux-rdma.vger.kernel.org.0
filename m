Return-Path: <linux-rdma+bounces-16117-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J8MgEDmWeWnAxgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16117-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 05:53:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E29D1A4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8057A3007F7C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389E330331;
	Wed, 28 Jan 2026 04:53:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDF26E709
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575988; cv=none; b=gy0OW6MwUXk3/zqYWO8f8873JLIlR+90zoqlqoJT2+MBkd0Z7l93ZDtby3PnZ8ZXG3Fg7T3iKqlbCldtB0sXjbaDtke3JS/qWxGcFnXsgIOo9ezyCQDvdVz8BruwQpkwFE0bKr7XwhAqmyw6OYJHJrrscJlU/TVinUAyl2LP6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575988; c=relaxed/simple;
	bh=F3o+/gt5qHXNGnQjSK1TGMaOzIKc3JA/lpE6UU3elB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjtXWfwIVy+wu5sUerxWkbkL7AHCzYynNUTwkK/fD9pcSDr+eKMMyWBwsaXVfzrlq2rVJe/oT7/5I7TBfIXBEqyNr70h7ztogxa16wadrbdQF8d0wOT7haphORswRlxKhKL5yHiCbIfM9zg71DuYWpto37exMmsQxbCgTxLshm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60S4qgMm056764;
	Wed, 28 Jan 2026 13:52:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60S4qfhV056761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 13:52:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 13:52:42 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com,
        maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com,
        markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16117-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: C22E29D1A4
X-Rspamd-Action: no action

On 2026/01/28 7:54, Yanjun.Zhu wrote:
> 
> On 1/27/26 2:16 PM, Tetsuo Handa wrote:
>> On 2026/01/28 6:17, Yanjun.Zhu wrote:
>>>> Can we feed it to syzkaller please and see if it does actually clear
>>>> it's repo? That particular bug already has 5 patches claiming to fix
>>>> it.
>>>
>>> #syz test: repository_link branch
>>>
>>> The above command will make syzkaller test your commit.
>>>
>>> BTW, your commit should be the topmost commit.
>> No, we can't ask syzbot to test this patch.
>>
>> All kinds of refcounting errors that appear as
>>
>>    unregister_netdevice: waiting for $dev to become free. Usage count = $count
>>
>> problem are reported there, but syzbot has not found a reproducer for
>> the bug this patch addresses.
>>
>> I can test this patch using linux-next tree via my tree if you like.
> 
> Thanks. Currently, syzbot does not have a reproducer to reproduce and verify this issue.

Correct. syzbot has a test environment but does not have a reproducer for this issue.

> 
> However, you have a test environment to reproduce the problem, and you can verify this commit.

Not correct. I have neither a test environment nor a reproducer.

What I have is a git tree that doesn't care about doing "git reset --hard" followed by
"git push -f". I'm currently carrying debug printk() patches that are intended to be
utilized by syzbot reports from linux-next tree, for CONFIG_NET_DEV_REFCNT_TRACKER is not
sufficient for debugging
"unregister_netdevice: waiting for $dev to become free. Usage count = $count" problems.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20260126&id=967b7e51aff00eae187d924c0097c0691d27421e

Before you make a permanent change in your git tree, we can try if syzbot still generates
reports like https://lkml.kernel.org/r/c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp
with Jiri's patch applied. I guess it would take about 2 weeks before we can make a judgement.

Two things I worry about Jiri's patch are that

  refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
  DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()

and

  I'm not convinced that it is safe/meaningful to keep DEVICE_GID_UPDATES notifications valid
  between wait_for_completion(&device->unreg_completion) in disable_device() and the beginning
  of ib_cache_cleanup_one() because I don't know whether DEVICE_GID_UPDATES notifications can
  make sense after device->refcount became 0

.


