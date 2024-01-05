Return-Path: <linux-rdma+bounces-542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6949824E4D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 06:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC01F231A8
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jan 2024 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874F5662;
	Fri,  5 Jan 2024 05:55:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E9610E;
	Fri,  5 Jan 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T5t2L57llz1Q6vN;
	Fri,  5 Jan 2024 13:54:34 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FE8218006F;
	Fri,  5 Jan 2024 13:55:12 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 13:55:11 +0800
Message-ID: <3d4cdc2e-0053-f486-7323-72127027886f@hisilicon.com>
Date: Fri, 5 Jan 2024 13:55:11 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
 <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
 <20231226085202.GA13350@unreal>
 <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>
 <20240104202902.GD50608@ziepe.ca>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240104202902.GD50608@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/1/5 4:29, Jason Gunthorpe wrote:
> On Tue, Dec 26, 2023 at 05:16:33PM +0800, Junxian Huang wrote:
>>
>>
>> On 2023/12/26 16:52, Leon Romanovsky wrote:
>>> On Mon, Dec 25, 2023 at 03:53:28PM +0800, Junxian Huang wrote:
>>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>>
>>>> In the current implementation, a fixed page size is used to
>>>> configure the PBL, which is not flexible enough and is not
>>>> conducive to the performance of the HW.
>>>>
>>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
>>>>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
>>>>  3 files changed, 139 insertions(+), 44 deletions(-)
>>>
>>> I'm wonder if the ib_umem_find_best_pgsz() API should be used instead.
>>> What is missing there?
>>>
>>> Thanks
>>
>> Actually this API is used for umem.
>> For kmem, we add hns_roce_find_buf_best_pgsz() to do a similar job.
> 
> But why do you need to do something like this for kmem? It looked to
> me like kmem knows its allocation size when it was allocated, how come
> you need to iterate over all of it again?
> 
> Jason
> 

kmem was split into multiple small pages for allocation to prevent allocation
failure due to memory fragmentation.

And now we add this function to confirm whether these small pages have contiguous
address. If so, they can be combined into one huge page for use, which is more
likely when iommu/smmu is enabled.

Junxian

