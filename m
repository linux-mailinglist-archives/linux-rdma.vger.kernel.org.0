Return-Path: <linux-rdma+bounces-16094-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGpVAW05eWkZwAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16094-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 23:17:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88F9AF59
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 23:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75E53016ECD
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF13563CD;
	Tue, 27 Jan 2026 22:16:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F935E534
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552215; cv=none; b=pLeRHy4fCwWqduXuQUfAeBOntPbjIpPXDPqlNh5JqK51r5iAhhCnvquGXmMCFdZpVQJYUUFiLsnSP8+cf+Xs3Y+uwvzVB/Gv57H1xh+sl4RxtxHxUyqw9/kuAOuGL55FEY/IggRWIb2gRdc5ZtwmwNIHrORW2ikEHPFFtVcq1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552215; c=relaxed/simple;
	bh=QleFmmdWptoeEQMu3gZb68jNjf35rLf1KF3huaZgYCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=of22qXLsxJE+wahffm3mZJoShdgtmcj/EdvYtHZ/jaw0MQVrycFIpaNIYJX5GBhXfgJCSYnO059zSRdSXaikShlgAmNX8nWdrFSjfcSkNy1mZ4/K7plqwjMJxQFSKzsWLELgiw5svt26kXyaW0zvuKbWpHmcTnbY/2h0rvqYt3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60RMGIi2095292;
	Wed, 28 Jan 2026 07:16:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60RMGHrn095288
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 07:16:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 07:16:17 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org, leon@kernel.org,
        msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com,
        mbloch@nvidia.com, markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, wangliang74@huawei.com
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16094-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[I-love.SAKURA.ne.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA88F9AF59
X-Rspamd-Action: no action

On 2026/01/28 6:17, Yanjun.Zhu wrote:
>> Can we feed it to syzkaller please and see if it does actually clear
>> it's repo? That particular bug already has 5 patches claiming to fix
>> it.
> 
> 
> #syz test: repository_link branch
> 
> The above command will make syzkaller test your commit.
> 
> BTW, your commit should be the topmost commit.

No, we can't ask syzbot to test this patch.

All kinds of refcounting errors that appear as

  unregister_netdevice: waiting for $dev to become free. Usage count = $count

problem are reported there, but syzbot has not found a reproducer for
the bug this patch addresses.

I can test this patch using linux-next tree via my tree if you like.

> 
> 
> Thanks,
> 
> Zhu Yanjun
> 
>>
>> It has become some kind of catch all of all kinds of refcounting errors
>>
>> [  247.188486][ T6052] unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
>>
>> Does this actually change the refcounting around that could fix that?
>> Looked like no?
>>
>> Jason


