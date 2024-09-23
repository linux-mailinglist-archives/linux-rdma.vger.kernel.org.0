Return-Path: <linux-rdma+bounces-5050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59897ECE7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 16:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D254281E69
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE02197554;
	Mon, 23 Sep 2024 14:15:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDA81749;
	Mon, 23 Sep 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100919; cv=none; b=f+z35u5jTWk9oxudwR+JjhQJoz0sD0xFMYNMAJq95GQWwkcyvk/DG8nIdEuhlH5WyEryDQW/UAaLS1ha5h/UaChHTurbr4EsljBsj8Mbp5bguCMuf0eSWbaM13urkcTEwPt93nWKjvjERTM5Vj664uyVknUovTckTcrwNGtencw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100919; c=relaxed/simple;
	bh=/XwMJGacKB3Q9tSQpF+xZkiuk45oC0eTI8prctv9ZfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NlOodwsgx1EbBqZlxEmAxrlZ4DN2yW/jrWqUwLFnO5NiKfk1OTF4r2c/3xXakPMkrNKMwpL1bI5lHsoxCx+MwQBssseKwGJAElhBJIxv08jgCf6SOyZ+NakxDmocupzjvl+5XCVmUq1dp56AJyBPY6z/jBFwNwZdVQPsr6RHXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XC4hk2gWKzpW3d;
	Mon, 23 Sep 2024 22:13:10 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D23A1401F2;
	Mon, 23 Sep 2024 22:15:13 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Sep 2024 22:15:12 +0800
Message-ID: <18db929f-1d01-1d51-1600-dc4985646ed3@hisilicon.com>
Date: Mon, 23 Sep 2024 22:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for all
 uctx when HW is being reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
 <20240916091323.GM4026@unreal>
 <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>
 <Zu1u/aiOAooVUeq2@ziepe.ca>
 <24e9ec1c-8b63-f3e0-a465-80030ea6002d@hisilicon.com>
 <20240923090226.GI11337@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240923090226.GI11337@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/23 17:02, Leon Romanovsky wrote:
> On Mon, Sep 23, 2024 at 02:17:40PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/9/20 20:47, Jason Gunthorpe wrote:
>>> On Fri, Sep 20, 2024 at 05:18:14PM +0800, Junxian Huang wrote:
>>>
>>>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>>>>>> index 4cb0af733587..49315f39361d 100644
>>>>>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>>>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>>>>>> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>>>>>>  	pgprot_t prot;
>>>>>>  	int ret;
>>>>>>  
>>>>>> +	if (hr_dev->dis_db) {
>>>>>
>>>>> How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?
>>>>>
>>>>
>>>> Sorry for the late response, I just came back from vacation.
>>>>
>>>> After calling hns_roce_hw_v2_reset_notify_down(), we will call ib_unregister_device()
>>>> and destory all HW resources eventually, so there is no need to clear dis_db.
>>>
>>> Why can't you do the unregister device sooner then and avoid all this
>>> special stuff?
>>>
>>
>> It's a limitation of HW. Resources such as QP/CQ/MR will be destoryed
>> during unregistering device. This is not allowed by HW until
>> hns_roce_hw_v2_reset_notify_uninit(), or it may lead to some HW errors.
> 
> It is interested claim given the fact that you are changing original
> code from 2016.
> 

Well, this isn't a new issue. We once sent a patch to try to address it
in 2019 [1], but that solution wasn't the right way since it relied on
userspace. We haven't come up with any new solutions since then, until
this series recently.

[1] https://lore.kernel.org/linux-rdma/20190812055220.GA8440@mtr-leonro.mtl.com/

Junxian

> Thanks
> 
>>
>>> I assumed you'd bring the same device back after completing the reset??
>>>
>>
>> Yes
>>
>>> Jason
>>

