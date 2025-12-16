Return-Path: <linux-rdma+bounces-15028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75950CC3483
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB7E301A187
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45972387B04;
	Tue, 16 Dec 2025 13:30:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA467382BE0
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891810; cv=none; b=Ra1VHYub9bewyJXuHulF7wMQOmikNMhMYkCSimNzmrtC+k89XoCDutugTPABV2CPObcR0su6qVVKtuKqa2KstLXpe+2EIFPPQLY53eCR5ihB/uC3k8yot8ielQR43wimAVcLOdSlN8nt1IPvr9F/Df/J7jOJ8EC+tSQ9VgXPpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891810; c=relaxed/simple;
	bh=in3/Wa8/eQ0/QfvpZ1mBL2cZawtzRBLNfu1zkC4upGg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ncM3vuVzRaiujDNK1uPhyFpxribQvOUz1l83p+sa5J6woNuLRTMk9CcAZ2d4pnzncRHJMdpVXl5zVg2vna9zgzNoIXfflqDbIU2Oda4+IN9jrJpjuFQf511UC05LdJy+LpV4MyZd1IdYfxLvzYzI+emI33A/+Ii0VCXhnpXVojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BGDTUPL048726;
	Tue, 16 Dec 2025 22:29:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BGDTT6K048721
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 16 Dec 2025 22:29:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
Date: Tue, 16 Dec 2025 22:29:29 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [not-yet-signed PATCH] RDMA/core: flush gid_cache_wq WQ from
 disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Yuval Shaia <yshaia@marvell.com>, Matan Barak <matanb@mellanox.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp
X-Virus-Status: clean

Hmm, I misinterpreted that commit. Since ib_register_device() was doing

	down_write(&lists_rwsem);
	list_add_tail(&device->core_list, &device_list);
	up_write(&lists_rwsem);

, it was

	down_write(&lists_rwsem);
	list_del(&device->core_list);

in ib_unregister_device() that makes ib_enum_all_roce_netdevs() no longer
call ib_enum_roce_netdev().

Then, calling ib_enum_all_roce_netdevs() asynchronously was always racy
since commit 03db3a2d81e6 ("IB/core: Add RoCE GID table management") was added?

On 2025/12/16 20:28, Tetsuo Handa wrote:
> Hello, Jason Gunthorpe.
> 
> Commit 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> says
> 
>     Since xarray can store 'going_down' using a mark just entirely eliminate
>     the struct ib_client_data and directly store the client_data value in the
>     xarray. However this does require a special iterator as we must still
>     iterate over any NULL client_data values.
> 
> and started using DEVICE_REGISTERED mark. But It seems to me that that commit
> has missed that ib_enum_roce_netdev() from ib_enum_all_roce_netdevs() is called
> asynchronously from WQ context. Due to that commit, ib_enum_roce_netdev() became
> no longer being called as soon as DEVICE_REGISTERED is cleared in
> ib_unregister_device(); I guess that that commit needed to wait for pending
> work items in gid_cache_wq WQ to complete. What do you think?
> 
> On 2025/12/15 23:09, Tetsuo Handa wrote:
>> On 2025/12/11 22:24, Tetsuo Handa wrote:
>>> Since a reproducer for this bug is not available, I haven't verified
>>> whether this is a bug syzbot is currently reporting in
>>> https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 .
>>> But I'd like to add Reported-by: syzbot if netdevice_event_work_handler()
>>> is supposed to be called for releasing GID entry upon NETDEV_UNREGISTER
>>> event. Thus, please review this change.
>>
>> I can observe using simple atomic_t counters that there are sometimes pending
>> netdevice_event() works as of immediately before clearing DEVICE_REGISTERED flag.
>> That is, clearing DEVICE_REGISTERED flag without flushing pending netdevice_event()
>> works results in failing to process some of netdev events.
>>
>> I considered resolving DEVICE_REGISTERED flag inside netdevice_event() and then
>> flush pending netdevice_event() works after clearing DEVICE_REGISTERED flag (diff
>> is shown below). But I immediately got circular locking dependency problem by just
>> executing "rdma link add siw0 type siw netdev lo" command line. Therefore, I guess
>> that the reason RDMA code defers netdevice_event() handling to WQ context is to
>> avoid circular locking dependency problem. But I guess that due to lack of reliable
>> flushing mechanism when clearing DEVICE_REGISTERED flag, sometimes operations for
>> deleting GID entry are not invoked, and syzbot is reporting refcount leak...


