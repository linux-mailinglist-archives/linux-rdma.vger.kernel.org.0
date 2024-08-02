Return-Path: <linux-rdma+bounces-4184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8D945ACE
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 11:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C4F282BC4
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA41DAC61;
	Fri,  2 Aug 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnVFX79O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A41DAC56
	for <linux-rdma@vger.kernel.org>; Fri,  2 Aug 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590351; cv=none; b=MZ5F8K1BrZcyS69B/hbS54+IOUkzzLgYLeARoe3BBbwiYfBOT9QJ8tM4YrL60+9gcB7NenIlfWD4lxRm1v2MpkgN9wV+5tx9OwQD11pUu8OeD4BCojj21bS7SS5wU+topxoz8zQZVp0vC4sdXf8TdBol4dfXKI3GowNQhVpSYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590351; c=relaxed/simple;
	bh=X5oFp9VCl4XeB0aXPbq/h47uASXOek4IptUxVH5jC7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lco2lHwnueaMewl9rdONQ+NSKVAUNsSoM6/ElQM4Fz7GDkpSgb4xMHWRWWt3c8DQ6yt204vSSbLe0jan+OrI+skex+lCwv0UO27J9h9hQ7A7SAYvLjILr9N4W41+jgjmee4RmD4vD9FZseWWm1WdbUxPDOm2X5T78++uNekjqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnVFX79O; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d92cdbe5-b5df-4580-9038-cdc69d667742@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722590345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEhbkuTV4BPdEO+PTgIuN/V8VoZo3H5ZfC271gpJXTc=;
	b=WnVFX79OtSZM3ikK7vYuFmhNFQC+H+dwhpGpfGIAtD8AYZxv8IdtNcyiiQ/12rvZPgJP5s
	37FmPii4fYm9+D5u4cXEPkawIbxwzSUS0ETI6OgOVEEWvCn2IeoIx4JpuXVhfANkZtCJze
	UdidzA/ypcu8liGv4bM7ffjR38EnPS4=
Date: Fri, 2 Aug 2024 17:18:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
 leon@kernel.org, bvanassche@acm.org, nab@risingtidesystems.com
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
References: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
 <02f7cfc8-0495-485d-9849-b5a9514f6110@linux.dev>
 <1ddde0db-c18e-7968-185e-1e792854d1b6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1ddde0db-c18e-7968-185e-1e792854d1b6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/2 10:28, Junxian Huang 写道:
> 
> 
> On 2024/8/2 5:55, Zhu Yanjun wrote:
>> 在 2024/8/1 15:44, Junxian Huang 写道:
>>> Currently cancel_work_sync() is not called when srpt_refresh_port()
>>> failed in srpt_add_one(). There is a probability that sdev has been
>>> freed while the previously initiated sport->work is still running,
>>> leading to a UAF as the log below:
>>>
>>> [  T880] ib_srpt MAD registration failed for hns_1-1.
>>> [  T880] ib_srpt srpt_add_one(hns_1) failed.
>>> [  T376] Unable to handle kernel paging request at virtual address 0000000000010008
>>> ...
>>> [  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
>>> ...
>>> [  T376] Call trace:
>>> [  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
>>> [  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
>>> [  T376]  process_one_work+0x1d8/0x4cc
>>> [  T376]  worker_thread+0x158/0x410
>>> [  T376]  kthread+0x108/0x13c
>>> [  T376]  ret_from_fork+0x10/0x18
>>>
>>> Add cancel_work_sync() to the exception branch to fix this UAF.
>>
>> Can you share the method to reproduce this problem?
>> I am interested in this problem.
>>
>> Thanks,
>> Zhu Yanjun
>>
> 
> I was testing bonding in 5.10 kernel, doing
> 	ifenslave bond0 eth0 eth1; ifenslave -d bond0 eth0 eth1
> and
> 	ethtool --reset eth0 dedicated; ethtool --reset eth1 dedicated
> concurrently and infinitely.
> 
> But I think this problem has been fixed in latest mainline probably.
> Please look into my reply to Bart in v2.

Thanks a lot. I am working on srq. Because ib_srpt also supports srq, I 
just want to confirm if srq of ib_srpt can also work well on RoCEv2 and 
IB with this commit.

Zhu Yanjun

> 
> Junxian
> 
>>>
>>> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>> ---
>>>    drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> index 9632afbd727b..244e5c115bf7 100644
>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> @@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
>>>    {
>>>        struct srpt_device *sdev;
>>>        struct srpt_port *sport;
>>> +    u32 i, j;
>>>        int ret;
>>> -    u32 i;
>>>          pr_debug("device = %p\n", device);
>>>    @@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
>>>            if (ret) {
>>>                pr_err("MAD registration failed for %s-%d.\n",
>>>                       dev_name(&sdev->device->dev), i);
>>> -            i--;
>>>                goto err_port;
>>>            }
>>>        }
>>> @@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
>>>        return 0;
>>>      err_port:
>>> +    for (j = i, i--; j > 0; j--)
>>> +        cancel_work_sync(&sdev->port[j - 1].work);
>>>        srpt_unregister_mad_agent(sdev, i);
>>>    err_cm:
>>>        if (sdev->cm_id)
>>


