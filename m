Return-Path: <linux-rdma+bounces-7888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1937A3D7C3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B65F3A49AA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07131F237A;
	Thu, 20 Feb 2025 11:05:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB61F0E4B
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049515; cv=none; b=Qp4Xtv8kwwhYCqUHjYzofac6HkOogao8pltvSQoeDU3Fapq00+AqWXtC3bXmh2m768QkUZRb3T0bvbFZ61o3zAiIBudbD5Pla+XQJgP2Q9MnrLlV+7fNy0mAQYSwaJuPjbqAIQrxS9HoSqCWnsFfiz7wPFF9UJHrrzn5AXl0h1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049515; c=relaxed/simple;
	bh=aldPkYM8PJY46s5t4OuDaZYg4F9uhDWZSRiyMyEBAnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GLaBC42HHPBTdqMvf/PqCg7MKecIB6H8ur4SMBCziXLeStx5pkO0FpLZ/5gyFmdh2+P682GicZxp94cwxhQ+EZ4QT0aqCbrCqPtLOV5xH6+qG2OV1VKf4ZciDggupAT4A2Yuqmb8XDnvnG6mp1tzgYqu6XGdBY66HMBPeZEiSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yz9Ld4mjRzLr66;
	Thu, 20 Feb 2025 19:01:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AE6D7140390;
	Thu, 20 Feb 2025 19:05:09 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 19:05:08 +0800
Message-ID: <542860d8-34a9-b109-2a85-794149df1fe3@hisilicon.com>
Date: Thu, 20 Feb 2025 19:05:06 +0800
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
 <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>
 <20250220090856.GO53094@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250220090856.GO53094@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/20 17:08, Leon Romanovsky wrote:
> On Thu, Feb 20, 2025 at 04:45:54PM +0800, Junxian Huang wrote:
>>
>>
>> On 2025/2/20 15:32, Leon Romanovsky wrote:
>>> On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
>>>>
>>>>
>>>> On 2025/2/19 22:35, Leon Romanovsky wrote:
>>>>> On Wed, Feb 19, 2025 at 09:07:36PM +0800, Junxian Huang wrote:
>>>>>>
>>>>>>
>>>>>> On 2025/2/19 20:14, Leon Romanovsky wrote:
>>>>>>> On Mon, Feb 17, 2025 at 03:01:19PM +0800, Junxian Huang wrote:
>>>>>>>> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
>>>>>>>> to notify HW about the destruction. In this case, driver will still
>>>>>>>> free the resources, while HW may still access them, thus leading to
>>>>>>>> a UAF.
>>>>>>>
>>>>>>>> This series introduces delay-destruction mechanism to fix such HW UAF,
>>>>>>>> including thw HW CTX and doorbells.
>>>>>>>
>>>>>>> And why can't you fix FW instead?
>>>>>>>
>>>>>>
>>>>>> The key is the failure of mailbox, and there are some cases that would
>>>>>> lead to it, which we don't really consider as FW bugs.
>>>>>>
>>>>>> For example, when some random fatal error like RAS error occurs in FW,
>>>>>> our FW will be reset. Driver's mailbox will fail during the FW reset.
>>>>>
>>>>> I don't understand this scenario. You said at the beginning that HW can
>>>>> access host memory and this triggers UAF. However now, you are presenting 
>>>>> case where driver tries to access mailbox.
>>>>>
>>>>
>>>> No, I'm saying that mailbox errors are the reason of HW UAF. Let me
>>>> explain this scenario in more detail.
>>>>
>>>> Driver notifies HW about the memory release with mailbox. The procedure
>>>> of a mailbox is:
>>>> 	a) driver posts the mailbox to FW
>>>> 	b) FW writes the mailbox data into HW
>>>>
>>>> In this scenario, step a) will fail due to the FW reset, HW won't get
>>>> notified and thus may lead to UAF.
>>>
>>> Exactly, FW performed reset and didn't prevent from HW to access it.
>>>
>>
>> Yes, but the problem is that our HW doesn't provide a method to prevent
>> the access. There's nothing FW can do in this scenario, so we can only
>> prevent UAF by adding these codes in driver.
> 
> Somehow HW doesn't access mailbox if destroy was successful, so why
> can't FW use same "method" to inform HW before reset?
> 

Mailbox carries information of the specific resource (QP/CQ/SRQ/MR)
that are being destroyed. It's impossible for FW to predict which
QP/CQ/SRQ/MR will be destroyed by driver during reset before the
reset starts.

Thanks,
Junxian

> Thanks

