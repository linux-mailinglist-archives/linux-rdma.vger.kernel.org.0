Return-Path: <linux-rdma+bounces-9976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24CDAA9CA6
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C04A17E8D0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC523B1AB;
	Mon,  5 May 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olpnVWZm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A041C6FF6
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473441; cv=none; b=coCagxxv7e0o//V7EE7Bsw+kuAnFgjnIgQ+5eFD3EqRy6lPW0gzluVGcIxsdHZtfmWKSipunMImQul7RTaTF0cKT0c5c7a6uxq4ljlfdgvyrxUyTYpK0qEGyfrKri0Yl17Z8T6PmWDn6sejHRcMDQCkYHFZ2JpDoXrK3juKAy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473441; c=relaxed/simple;
	bh=+SnAutZJ+n9htkzJIBPjbKtiqjrNf18kfvTvxcdiINo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5FQJv1vL54oj65hqhqBD77v0+/3acY7nao4PUUEJ/iiAwYaUclD9LTyI5cSj9in1uixZhuW4Nr3QiMDtYOWED1BJlMgwHqENBdcmajEH3MCR5C8W6CUSQLP7UmSnb0g/IPi2ZWNF0oTcOghffz0U5Dq9IanwQl/Swy3m52KsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olpnVWZm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b39ba3b-4ba0-4d6b-a79f-c77218ac08ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746473436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8U9WHvuwJvp2q4iGFTgl6ut1HELLbE8j66xYY/f68Kc=;
	b=olpnVWZmZd51fZQ+pVTsNp40Uv5JTGnHr9ZXCKNyXrCsuigWTv3vVnXiL6XPaYDdiUw1Nk
	1GYjgQYSnOkpazOc09ev9OFa5MT46+YUbFf1uRXuo3N779+HWS6KAJ6ZcKD/gnTLvnk+aP
	PdQmfE48LYfIKIRRgdtlil+zPLQg82Y=
Date: Mon, 5 May 2025 21:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/core: Fix "KASAN: slab-use-after-free Read in
 ib_register_device" problem
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
References: <20250501103602.3479963-1-yanjun.zhu@linux.dev>
 <20250505173152.GM5848@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250505173152.GM5848@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/5/5 19:31, Leon Romanovsky 写道:
> On Thu, May 01, 2025 at 12:36:02PM +0200, Zhu Yanjun wrote:
>> Call Trace:
>>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:408 [inline]
>>   print_report+0xc3/0x670 mm/kasan/report.c:521
>>   kasan_report+0xe0/0x110 mm/kasan/report.c:634
>>   strlen+0x93/0xa0 lib/string.c:420
>>   __fortify_strlen include/linux/fortify-string.h:268 [inline]
>>   get_kobj_path_length lib/kobject.c:118 [inline]
>>   kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
>>   kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
>>   ib_register_device drivers/infiniband/core/device.c:1472 [inline]
>>   ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
>>   rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
>>   rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
>>   rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
>>   nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
>>   rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
>>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>>   netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
>>   netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
>>   sock_sendmsg_nosec net/socket.c:712 [inline]
>>   __sock_sendmsg net/socket.c:727 [inline]
>>   ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
>>   ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
>>   __sys_sendmsg+0x16d/0x220 net/socket.c:2652
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> This problem is similar to the problem that the commit
>> 1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
>> fixes.
>>
>> The root cause is: the function ib_device_rename renames the name with
>> lock. But in the function kobject_uevent, this name is accessed without
>> lock protection at the same time.
>>
>> The solution is to add the lock protection when this name is accessed in
>> the function kobject_uevent.
>>
>> Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
>> Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/core/device.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index b4e3e4beb7f4..59d84829dd66 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1468,8 +1468,12 @@ int ib_register_device(struct ib_device *device, const char *name,
>>   		return ret;
>>   	}
>>   	dev_set_uevent_suppress(&device->dev, false);
>> +
>> +	/* device->dev.kobj->name should be protected by devices_rwsem */
>> +	down_read(&devices_rwsem);
>>   	/* Mark for userspace that device is ready */
>>   	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
>> +	up_read(&devices_rwsem);
>>   
>>   	ib_device_notify_register(device);
> The change looks right to me, but I would ask you to put
> kobject_uevent() into ib_device_notify_register() instead of adding
> rwsem. It will ensure that both uevent and netlink will get same name.

Got it. Will do.

I will send out the latest very soon.

Zhu Yanjun

>
> Thanks
>
>>   	ib_device_put(device);
>> -- 
>> 2.34.1
>>
>>
-- 
Best Regards,
Yanjun.Zhu


