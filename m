Return-Path: <linux-rdma+bounces-8161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FBA462B4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42C03B43F2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B44221D90;
	Wed, 26 Feb 2025 14:25:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6CC21171A
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579953; cv=none; b=XZIY/RU/0VwMUGGaPH8LTB73gGIzdbYWMFq+ct+MOp9F1Wmm1rKjBPS7wnQyw70wSuevTbbXDZ1K3NDGMpF3DHAAgSmlBhPvOWBbmerkFEPfG72LKunJLDIww+1tn3qhoOcE8K+kLlAT+UnJ1fuPkjuEgeMnUJ3YLTggSuRy+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579953; c=relaxed/simple;
	bh=hkVsTRlB90tqq54kiRwv2vwookU6FywTH7D3uFiQlao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qF/69Ew9Yh5mAlD0zku6ZmtYwryDmr3y1ishEv3/L+fnndduFwje4y2zFticSdbPilPTv0hyYnuyYFqExhBEQeVV7w5FdmL4z7HTLkXMncTGzlVcKkhP5x/3/YuhQ3Mt2dPSuDKzQdzHPldyjkm+DLNNFrGSDzSW3pCfG1LZKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z2xWj4bv9z21m08;
	Wed, 26 Feb 2025 22:22:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 543651400D4;
	Wed, 26 Feb 2025 22:25:46 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 22:25:44 +0800
Message-ID: <99297865-04a8-4561-7a06-3c3af2f9ae9d@hisilicon.com>
Date: Wed, 26 Feb 2025 22:25:43 +0800
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
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <tangchengchang@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220141059.GV3696814@ziepe.ca>
 <f5e1b589-d9a6-04c4-dffd-9aa3d2e77ab1@hisilicon.com>
 <20250226124732.GJ53094@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250226124732.GJ53094@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/2/26 20:47, Leon Romanovsky wrote:
> On Wed, Feb 26, 2025 at 05:46:12PM +0800, Junxian Huang wrote:
>>
>>
>> On 2025/2/20 22:10, Jason Gunthorpe wrote:
>>> On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:
>>>
>>>> Driver notifies HW about the memory release with mailbox. The procedure
>>>> of a mailbox is:
>>>> 	a) driver posts the mailbox to FW
>>>> 	b) FW writes the mailbox data into HW
>>>>
>>>> In this scenario, step a) will fail due to the FW reset, HW won't get
>>>> notified and thus may lead to UAF.
>>>
>>> That's just wrong, a FW reset must fully stop and sanitize the HW as
>>> well. You can't have HW running rouge with no way for FW to control it
>>> anymore.
>>>
>>
>> I agree, but there is a small time gap between the start of FW reset
>> and the stop of HW. Please see my earlier reply today.
> 
> So stop HW before continuing FW reset.

FW reset is a passive behavior, not triggered by FW itself and cannot
be predicted by FW either. If the FW is being reset, usually it is
already crashed and can't function normally due to some fatal errors.
When FW starts to reset, there are some necessary initialization
before it can take control of HW again. So there's always a time gap.

Thanks,
Junxian

> 
> Thanks
> 
>>
>> Thanks,
>> Junxian
>>
>>> Jason
> 

