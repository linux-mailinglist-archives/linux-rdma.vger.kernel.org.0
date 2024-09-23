Return-Path: <linux-rdma+bounces-5043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BE97E5EB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7624BB20A93
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEB8175A1;
	Mon, 23 Sep 2024 06:17:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBD12E5B;
	Mon, 23 Sep 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072271; cv=none; b=L9uF1DHbtI6XWnyeQwm+qndFi8a/TTAcR9wcM9xgY3RfRHIjrakF3HaR6qL0qZrcGZRfKeTaXlRe7HwE5rZOCcfrTCjvuFQLWv/zfdBlCe80kKrUZdL79+M5woUQrv9BmT0lCjGz38VYZ1gxMuX6HbxL/wwMRI+WLyYp79pIjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072271; c=relaxed/simple;
	bh=nKYYuNdYZHh5PzJJL/8N6Jf51FJaazjKABc2IWRYePw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/9vYStePv/MnP0v8cP50cdC+H4bL1byS/EyuQgiswH52XXIXSxbAE3WwrDx7FS7u8JfZ1wB41jY7+B3l6DcnqzaTNZ2JURTuX7LHJCnw7+CeT82PuVJNJKyHq2CFHntoPh/2qu9VVRCQCrgfGrScdYYIXEri8GT8ZVORDiWLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XBt3j6xjCz1HJvm;
	Mon, 23 Sep 2024 14:13:53 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 12EF61A0188;
	Mon, 23 Sep 2024 14:17:42 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Sep 2024 14:17:41 +0800
Message-ID: <24e9ec1c-8b63-f3e0-a465-80030ea6002d@hisilicon.com>
Date: Mon, 23 Sep 2024 14:17:40 +0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
 <20240916091323.GM4026@unreal>
 <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>
 <Zu1u/aiOAooVUeq2@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <Zu1u/aiOAooVUeq2@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/20 20:47, Jason Gunthorpe wrote:
> On Fri, Sep 20, 2024 at 05:18:14PM +0800, Junxian Huang wrote:
> 
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>>>> index 4cb0af733587..49315f39361d 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>>>> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>>>>  	pgprot_t prot;
>>>>  	int ret;
>>>>  
>>>> +	if (hr_dev->dis_db) {
>>>
>>> How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?
>>>
>>
>> Sorry for the late response, I just came back from vacation.
>>
>> After calling hns_roce_hw_v2_reset_notify_down(), we will call ib_unregister_device()
>> and destory all HW resources eventually, so there is no need to clear dis_db.
> 
> Why can't you do the unregister device sooner then and avoid all this
> special stuff?
> 

It's a limitation of HW. Resources such as QP/CQ/MR will be destoryed
during unregistering device. This is not allowed by HW until
hns_roce_hw_v2_reset_notify_uninit(), or it may lead to some HW errors.

> I assumed you'd bring the same device back after completing the reset??
> 

Yes

> Jason

