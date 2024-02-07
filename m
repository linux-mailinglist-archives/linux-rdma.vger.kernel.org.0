Return-Path: <linux-rdma+bounces-947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FDC84C6C9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 10:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C18287788
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E4208D7;
	Wed,  7 Feb 2024 09:00:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3934208CB;
	Wed,  7 Feb 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296409; cv=none; b=pp5CY3SS67ZzmVHa/Xple9nYmkm6s6/sq/1SUr0GSKMd5iBZFjKUZSv3qPp47cGc8fLNt4dWa317EYxvMQ40TkxrdjyX2+j+83hNjJAviXA0uvetKg/ndm5wGpzO/TFFMwlEiL8H/heMHw/yR11FTMb3Dx8TahdfAsbjjVyuZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296409; c=relaxed/simple;
	bh=GjNksb9mM9ltZpf6qfnQ4VHDgN179hjO+k8p85WPtjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y6kUKT/+54WZAm0YVORgCcwKhXcL3FlG5pC0khWgoQstHNFfbjnHGh+sZhrksXWymmxxQ8aSoQ6bsS5adzQaCYDRqOs5liPlENFTFuUV0jcwKdLF+8dBzHeS9kyzZj8cpePXvogIr5eLTMn+8bssHBpKfE10VmSaUJqexCSm1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TVDYS3RktzsWtR;
	Wed,  7 Feb 2024 16:58:36 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 97103140153;
	Wed,  7 Feb 2024 16:59:57 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 16:59:57 +0800
Message-ID: <322ab57d-05d8-72b9-9580-0579b5d8b468@hisilicon.com>
Date: Wed, 7 Feb 2024 16:59:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Support configuring congestion
 control algorithm with QP granularity
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
 <20240207083338.GB56027@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240207083338.GB56027@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/2/7 16:33, Leon Romanovsky wrote:
> On Wed, Feb 07, 2024 at 11:29:08AM +0800, Junxian Huang wrote:
>> Patch #1 reverts a previous bugfix that was intended to add restriction
>> to congestion control algorithm for UD but mistakenly introduced other
>> problem.
> 
> First patch shouldn't be revert but a fix to "add a restriction that only DCQCN
> is supported for UD." and second patch should be a new feature.
> 
> Thanks
> 

OK, but I have two questions here:

1. Of course we can not only revert but also completely fix the bug in patch #1.
   But since we are adding a new feature that can also fix this bug in patch #2,
   the fix in patch #1 will be immediately removed in patch #2. Is this acceptable?

2. Should I still put these two patches into one patchset in the next version, or
   seperate them into two individual patchset?

Thanks,
Junxian

>>
>> Patch #2 adds support for configuring congestion control algorithm with
>> QP granularity. The algorithm restriction for UD is added in this patch.
>>
>> Junxian Huang (1):
>>   RDMA/hns: Support configuring congestion control algorithm with QP
>>     granularity
>>
>> Luoyouming (1):
>>   Revert "RDMA/hns: The UD mode can only be configured with DCQCN"
>>
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 ++----
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
>>  include/uapi/rdma/hns-abi.h                 | 17 +++++
>>  6 files changed, 118 insertions(+), 20 deletions(-)
>>
>> --
>> 2.30.0
>>
> 

