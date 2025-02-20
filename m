Return-Path: <linux-rdma+bounces-7884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3704A3D38E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 09:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42846172CF8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB11E9B1D;
	Thu, 20 Feb 2025 08:46:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19C1B4247
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041161; cv=none; b=bcLgXDjtNte4DGtD62cb7L+Tbm9klB5ed8A5oSbD5PTgSyXTQwMvGGCQ6aQf/sGb57Ef81Kb1XDd3nczvyktb7rfsjDwd5YFSO+3rF3BIq5s/tQsOESp9OhsFiRiTIu9P8eMJmBTelSgaE5MU0iGIZ2S3FFw2Y+j/pOi90kjwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041161; c=relaxed/simple;
	bh=nCCSeLiBtedbcNtsBnLQ2iV0lnvBgMmQs1Dc1Z01JlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=as4wc+8pqc5WK1JGupT/qT79vEqoU8nH3QH0Dr40Gvz8L+4CMG9AvwMMKv7r+ecJsrzhD4+Y5OmDPUoUvdVRW79QmAniPa1tpXrykS83NCvXY8Np9wTRAmC7BoYVHpnqhz7Pv5gb38/jgqUJ2/5ZeQyWSZ6FrlftHTMAEyKv2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yz6FM48nwz1wn8V;
	Thu, 20 Feb 2025 16:41:59 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FF62140391;
	Thu, 20 Feb 2025 16:45:56 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 16:45:55 +0800
Message-ID: <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>
Date: Thu, 20 Feb 2025 16:45:54 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220073217.GM53094@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250220073217.GM53094@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/20 15:32, Leon Romanovsky wrote:
> On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
>>
>>
>> On 2025/2/19 22:35, Leon Romanovsky wrote:
>>> On Wed, Feb 19, 2025 at 09:07:36PM +0800, Junxian Huang wrote:
>>>>
>>>>
>>>> On 2025/2/19 20:14, Leon Romanovsky wrote:
>>>>> On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
>>>>>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
>>>>>> to notify HW about the destruction. In this case, driver will still
>>>>>> free the resources, while HW may still access them, thus leading to
>>>>>> a UAF.
>>>>>
>>>>>> This series introduces delay-destruction mechanism to fix such HW UAF,
>>>>>> including thw HW CTX and doorbells.
>>>>>
>>>>> And why can't you fix FW instead?
>>>>>
>>>>
>>>> The key is the failure of mailbox, and there are some cases that would
>>>> lead to it, which we don't really consider as FW bugs.
>>>>
>>>> For example, when some random fatal error like RAS error occurs in FW,
>>>> our FW will be reset. Driver's mailbox will fail during the FW reset.
>>>
>>> I don't understand this scenario. You said at the beginning that HW can
>>> access host memory and this triggers UAF. However now, you are presenting 
>>> case where driver tries to access mailbox.
>>>
>>
>> No, I'm saying that mailbox errors are the reason of HW UAF. Let me
>> explain this scenario in more detail.
>>
>> Driver notifies HW about the memory release with mailbox. The procedure
>> of a mailbox is:
>> 	a) driver posts the mailbox to FW
>> 	b) FW writes the mailbox data into HW
>>
>> In this scenario, step a) will fail due to the FW reset, HW won't get
>> notified and thus may lead to UAF.
> 
> Exactly, FW performed reset and didn't prevent from HW to access it.
> 

Yes, but the problem is that our HW doesn't provide a method to prevent
the access. There's nothing FW can do in this scenario, so we can only
prevent UAF by adding these codes in driver.

Thanks,
Junxian

> Thanks
> 
>>
>> Junxian
>>
>>>>
>>>> Another case is the mailbox timeout when FW is under heavy load, as it is
>>>> shared by multi-functions.
>>>
>>> It is not different from any other mailbox errors. FW needs to handle
>>> these cases.
>>>
>>> Thanks
>>>
>>>>
>>>> Thanks,
>>>> Junxian
>>>>
>>>>> Thanks

