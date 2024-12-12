Return-Path: <linux-rdma+bounces-6475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4349EE79D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 14:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A5718886A8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC611214236;
	Thu, 12 Dec 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdSmLcYl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF88460
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009960; cv=none; b=FwjDkthBIx16P1n4xcEu0nuTlPuqv//ZAazPZ7BARGbVlG5TIaeQt/KheVXpWd0Hx+SaK68UzqSD7KBSPfLNJfS63P2wdG2UW2NG0GtOGrLvMeWqNPLFnidOF3jtDvFlBOhYZsTEFm9NfzPuJRhO+ykTzPdCzMganEV8W7AKeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009960; c=relaxed/simple;
	bh=225jp5tn1kUfbSLduLi8PTnhl7P47LGGh01wpXTahM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/cGildIj2Cj+szbOYDZL3wr//KE+9fb6LfIeiy42WXcBrljbRW4Ndq0QaF5gGiR29hotrUrh8rZHXtwxSMUEhLXTYVg52OSjoQEPExzMpETwSnCm5XGINWdXi5dp43PLop5T82dnkFCZcdVNes7ED+3Kez11OeCcbPGoQ2JQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdSmLcYl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e49a984-62f4-4870-894c-d10a8aac8e86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734009953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVJVZWOKHflOPWbm+2aKTBmBQNX3sn8kPbuN07JRIBo=;
	b=tdSmLcYlN1U2pbnpSQMRc8Cjc81jEwUgmbO69VH++SGI6lkX+fsLMG1rXymWKLpFq47MRm
	7nMsE7cAMwkjLDGV9/siGEaZQWOfvHuiJUDnvh2avXqt7TQ+CgAxL2VYxvtNob9jYRbHHP
	Q+gHwcR52Iz6pG7NgHA5/Z66Eeus9CU=
Date: Thu, 12 Dec 2024 14:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
To: Bernard Metzler <BMT@zurich.ibm.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20241210191303.GF1245331@unreal>
 <BN8PR15MB2513A5425BB295C9A08C44EF993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <BN8PR15MB2513A5425BB295C9A08C44EF993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/12 11:20, Bernard Metzler 写道:
> 
> 
>> -----Original Message-----
>> From: Leon Romanovsky <leon@kernel.org>
>> Sent: Tuesday, December 10, 2024 8:13 PM
>> To: Bernard Metzler <BMT@zurich.ibm.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to net_device
>>
>> On Tue, Dec 10, 2024 at 05:08:51PM +0000, Bernard Metzler wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Sent: Tuesday, December 10, 2024 3:56 PM
>>>> To: Bernard Metzler <BMT@zurich.ibm.com>
>>>> Cc: linux-rdma@vger.kernel.org; leon@kernel.org; linux-
>>>> kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
>>>> bugs@googlegroups.com; zyjzyj2000@gmail.com;
>>>> syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
>>>> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
>> net_device
>>>>
>>>> On Tue, Dec 10, 2024 at 02:03:51PM +0100, Bernard Metzler wrote:
>>>>> diff --git a/drivers/infiniband/sw/siw/siw.h
>>>> b/drivers/infiniband/sw/siw/siw.h
>>>>> index 86d4d6a2170e..c8f75527b513 100644
>>>>> --- a/drivers/infiniband/sw/siw/siw.h
>>>>> +++ b/drivers/infiniband/sw/siw/siw.h
>>>>> @@ -69,16 +69,19 @@ struct siw_pd {
>>>>>
>>>>>   struct siw_device {
>>>>>   	struct ib_device base_dev;
>>>>> -	struct net_device *netdev;
>>>>>   	struct siw_dev_cap attrs;
>>>>>
>>>>>   	u32 vendor_part_id;
>>>>> +	struct {
>>>>> +		int ifindex;
>>>>
>>>> ifindex is only stable so long as you are holding a reference on the
>>>> netdev..
>>>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>>>> @@ -287,7 +287,6 @@ static struct siw_device
>> *siw_device_create(struct
>>>> net_device *netdev)
>>>>>   		return NULL;
>>>>>
>>>>>   	base_dev = &sdev->base_dev;
>>>>> -	sdev->netdev = netdev;
>>>>
>>>> Like here needed to grab a reference before storing the pointer in the
>>>> sdev struct.
>>>>
>>>
>>> This patch was supposed to remove siw's link to netdev. So no
>>> reference to netdev would be needed. I did it under the
>>> assumption siw can locally keep all needed information up to
>>> date via netdev_event().
>>> But it seems the netdev itself can change during the lifetime of
>>> a siw device? With that ifindex would become wrong.
>>>
>>> If the netdev can change without the siw driver being informed,
>>> holding a netdev pointer or reference seems useless.
>>>
>>> So it would be best to always use ib_device_get_netdev() to get
>>> a valid netdev pointer, if current netdev info is needed by the
>>> driver?
>>
>> Or call to dev_hold(netdev) in siw_device_create(). It will make sure
>> that netdev is stable.
>>
>> Thanks
>>
>> BTW, Need to check, maybe IB/core layer already called to dev_hold.
>>
> 
> Yes, drivers are calling ib_device_set_netdev(ibdev, netdev, port)
> during newlink(), which assigns the netdev to the ib_device's port
> info. The ibdev takes a hold on the ports netdev and handles the
> pointer assignment, clearing etc. appropriately. Unlinking is done
> via ib_device_set_netdev(, NULL, ), or ib_unregister_device()
> which unlinks and puts netdevs as well.
> 
> Given we have an instance taking care of the netdev, it is
> probably best to remove all direct netdev references from the
> driver - just to avoid replicating all its complex handling.
> So siw will use ib_device_get_netdev() whenever netdev info
> is required. It comes with some extra overhead, but its's more
> consistent.
> 
> BTW: The rdma_link interface is asymmetric, lacking an unlink()
> call. For using software only drivers it might be beneficial to
> allow explicit unlinking a driver from a device. Any thoughts
> on that?

I agree with you. In the following link, I add del_link call. If you all 
agree, I can separate this patch from the patchset 
https://patchwork.kernel.org/project/linux-rdma/cover/20230624073927.707915-1-yanjun.zhu@intel.com/.

This is the link to add unlink call.

https://patchwork.kernel.org/project/linux-rdma/patch/20230624073927.707915-4-yanjun.zhu@intel.com/

Zhu Yanjun

> 
> Best,
> Bernard.
>>>
>>> I just wanted to avoid the costly ib_device_get_netdev() call
>>> during query_qp(), query_port() and listen().
>>>
>>> Thank you!
>>> Bernard.
>>>


