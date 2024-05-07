Return-Path: <linux-rdma+bounces-2318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96D8BE5DA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD8BB2582E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056716C454;
	Tue,  7 May 2024 14:21:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB516C42C;
	Tue,  7 May 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091675; cv=none; b=KCo/NYnSb3FdNRzVaQRqvJ4dBAlk59CR+mKWhx48/o2nvXqiiPX1Bh8c/+ZEztM3xBN4voLmGeELoAvelIhol02cr+fOfKR8459xPe21F+zUMhCaXm5fs/xVODxnc9YJ+B5T/fuHbaBUpNVmNxnWbtx0XAt+vfXgsUFWllpJ7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091675; c=relaxed/simple;
	bh=0U/Vfm/yvxpigNc8T6MOlV5eg/rpc7P11b5fh/7/Dg4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b15ocH2/gOlIahNrcFYL0zMC3jGRy8X5NAnKdlK74Tbo2BufQSvv8fQra4SE+avp+TOeAWX850OQjdmpunLi1VLw4rWXXvLJDTQvGJ3WRvdiiEdX6cze+IBNk8aXNx0jI41O+NStIGABe/TjYi3uS1UvqidfDP7asfrCWXeFFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYgN857cPztT3W;
	Tue,  7 May 2024 22:17:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id DDE1F14022D;
	Tue,  7 May 2024 22:21:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 22:21:09 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 22:21:09 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
 <20240430134113.GU231144@ziepe.ca>
 <fac4927b-16ed-d801-fb47-182f2aca355c@huawei.com>
 <20240506151112.GE901876@ziepe.ca>
CC: Junxian Huang <huangjunxian6@hisilicon.com>, <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <90d51f0f-724f-fbba-9519-1c022c65c5e2@huawei.com>
Date: Tue, 7 May 2024 22:21:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506151112.GE901876@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/5/6 23:11, Jason Gunthorpe wrote:
> On Mon, May 06, 2024 at 02:47:01PM +0800, Chengchang Tang wrote:
>>
>>
>> On 2024/4/30 21:41, Jason Gunthorpe wrote:
>>> On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
>>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>>
>>>> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
>>>> and results in HW reading WQE with a granularity of 4K even in a 64K
>>>> system. HW has to switch pages every 4K, leading to a loss of performance.
>>>
>>>> In order to improve performance, add support for userspace to allocate
>>>> flexible WQE buffer page size between 4K to system PAGESIZE.
>>>> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
>>>>  	__u8    log_sq_bb_count;
>>>>  	__u8    log_sq_stride;
>>>>  	__u8    sq_no_prefetch;
>>>> -	__u8    reserved[5];
>>>> +	__u8    pageshift;
>>>> +	__u8    reserved[4];
>>>
>>> It doesn't make any sense to pass in a pageshift from userspace.
>>>
>>> Kernel should detect whatever underlying physical contiguity userspace
>>> has been able to create and configure the hardware optimally. The umem
>>> already has all the tools to do this trivially.
>>>
>>> Why would you need to specify anything?
>>>
>>
>> For hns roce, QPs requires three wqe buffers, namely SQ wqe buffer, RQ wqe
>> buffer and EXT_SGE buffer.  Due to HW constraints, they need to be configured
>> with the same page size. The memory of these three buffers is allocated by
>> the user-mode driver now. The user-mode driver will calculate the size of
>> each region and align them to the page size. Finally, the driver will merge
>> the memories of these three regions together, apply for a memory with
>> continuous virtual addresses, and send the address to the kernel-mode driver
>> (during this process, the user-mode driver and the kernel-mode driver only
>> exchange addresses, but not the the sizes of these three areas or other
>> information).
> 
> So you get a umem and the driver is slicing it up. What is the
> problem? The kernel has the umem and the kernel knows the uniform page
> size of that umem.

Currently, because the user-mode driver and the kernel-mode driver only
exchange addresses, from the perspective of the kernel-mode driver, if the
page size is not negotiated, it cannot even calculate the size of each region,
and thus cannot complete ib_umem_get().

Of course, we can add some information to be passed to the kernel mode driver,
such as size and offset of each region, but is there any essential difference
between this and directly passing page shift?
> 
> 
>> Since the three regions share one umem, through umem's tools, such as
>> ib_umem_find_best_pgsz(), they will eventually calculate the best page size
>> of the entire umem, not each region. 
> 
> That is what you want, you said? Each region has to have the same page
> size. So the global page size of the umem is the correct one?

No, the global page size may be bigger than the page size of each region.
If we use the global page size, the hardware may have out-of-bounds access.
> 
>> For this reason, coupled with the fact
>> that currently only the address is passed when the kernel mode driver interacts
>> with the user mode driver, and no other information is passed, it makes it more
>> difficult to calculate the page size used by the user mode driver from the
>> kernel mode driver. 
> 
> Even if it is difficult, this has to be done like this. You can't pass
> a page size in from userspace, there is no good way for userspace to
> do this correctly in all cases.

Userspace may indeed go wrong, but in the current scenario, the page size is
only set within the allowed range [4k, 64k], and its errors only affects the
current QP. Is this acceptable?

Chengchang

