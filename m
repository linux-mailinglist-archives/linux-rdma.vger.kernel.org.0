Return-Path: <linux-rdma+bounces-2286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C368BC7C9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 08:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7C8B20E94
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DB4D9EC;
	Mon,  6 May 2024 06:47:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558345948;
	Mon,  6 May 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978033; cv=none; b=jvrGNTDzKrtbmz+frnIK6P2VRqzSCkr46VAem3Sc2+aEIyX1MIY0zzJMwykb1jsN9g2ntP7MW5Ct0E3AOwdGrsj5utOYJl9gpk3sKm1vc8IocJz9ORPqoU7sZFcUd7aZGJ/elDCoccrWPolr6U7CkNhbjfVDERn8h8dwirtprhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978033; c=relaxed/simple;
	bh=3uxiYTb5Bc5ndnoMLNXIS4HY6afVwSDNr9pFRdfYbps=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kpjXEVEQokC5RjvBh719omvC7etO5kEmqX7A5eE4nmCpHKRWZOPbsnO8lNhBI9Mz2vCnvFKkNkg+H9Epl5T8BnWBIprdxulUicGH5fcYKCs/fuORffnHtzi1+AvmAM2Eyt+GwyspTMoWY+hB/DQoSLjviiM0p2n/Xv7gTq8l+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VXsLf1GSKztSyS;
	Mon,  6 May 2024 14:43:38 +0800 (CST)
Received: from dggpemm100017.china.huawei.com (unknown [7.185.36.220])
	by mail.maildlp.com (Postfix) with ESMTPS id E360814040D;
	Mon,  6 May 2024 14:47:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 14:47:01 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 14:47:01 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
To: Jason Gunthorpe <jgg@ziepe.ca>, Junxian Huang
	<huangjunxian6@hisilicon.com>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
 <20240430134113.GU231144@ziepe.ca>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <fac4927b-16ed-d801-fb47-182f2aca355c@huawei.com>
Date: Mon, 6 May 2024 14:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240430134113.GU231144@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/4/30 21:41, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
>> and results in HW reading WQE with a granularity of 4K even in a 64K
>> system. HW has to switch pages every 4K, leading to a loss of performance.
> 
>> In order to improve performance, add support for userspace to allocate
>> flexible WQE buffer page size between 4K to system PAGESIZE.
>> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
>>  	__u8    log_sq_bb_count;
>>  	__u8    log_sq_stride;
>>  	__u8    sq_no_prefetch;
>> -	__u8    reserved[5];
>> +	__u8    pageshift;
>> +	__u8    reserved[4];
> 
> It doesn't make any sense to pass in a pageshift from userspace.
> 
> Kernel should detect whatever underlying physical contiguity userspace
> has been able to create and configure the hardware optimally. The umem
> already has all the tools to do this trivially.
> 
> Why would you need to specify anything?
> 
> Jason
> 

For hns roce, QPs requires three wqe buffers, namely SQ wqe buffer, RQ wqe
buffer and EXT_SGE buffer.  Due to HW constraints, they need to be configured
with the same page size. The memory of these three buffers is allocated by
the user-mode driver now. The user-mode driver will calculate the size of
each region and align them to the page size. Finally, the driver will merge
the memories of these three regions together, apply for a memory with
continuous virtual addresses, and send the address to the kernel-mode driver
(during this process, the user-mode driver and the kernel-mode driver only
exchange addresses, but not the the sizes of these three areas or other
information).

Since the three regions share one umem, through umem's tools, such as
ib_umem_find_best_pgsz(), they will eventually calculate the best page size
of the entire umem, not each region. For this reason, coupled with the fact
that currently only the address is passed when the kernel mode driver interacts
with the user mode driver, and no other information is passed, it makes it more
difficult to calculate the page size used by the user mode driver from the
kernel mode driver. In this case, it is a relatively simpler method to let user
mode directly tell kernel mode which pageshift it uses, and it is also easier
in terms of forward and backward compatibility.

Chengchang

