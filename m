Return-Path: <linux-rdma+bounces-1724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F01B8949AC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 04:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BAA1F223A1
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 02:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542B14F64;
	Tue,  2 Apr 2024 02:55:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6131171A;
	Tue,  2 Apr 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026555; cv=none; b=Dx/CG7wouFZpjZqJd1/RxwO3Rpa13ZHUFsB49eu4ORsnft3SgtkZroMKxl09Cnccg7jGG1FVmVzi5l/2+xJoX1kuxCA2V+fb4jUyFoRC98VqzSToPHO5HI/bDAK1KcEPbQzGKWFiarjs+vfO3YCVrAB2072uREJbd1pgv7XAgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026555; c=relaxed/simple;
	bh=0EzUwmjHLXlEJyvY/QgsJrzv5lndfqtai08FctYwwJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ml51/aIJNct8Y6lZOALEksZ9LwCTHBlqC71pwtm0RBWd0OdNznGKd90k2I/cLxDWzjABFweTy2dDJX2F0RHsqYJdnotU8wTxEaaB83dEyZ8oo7OticWuslYFW6NYXFMebveiXZ8s0NhsdLSFhZBxABR0TymgkNJIORas6mDDw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V7sr82VT7zwR42;
	Tue,  2 Apr 2024 10:52:56 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BFD591402C6;
	Tue,  2 Apr 2024 10:55:42 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 10:55:42 +0800
Message-ID: <9bfc0185-dbd3-3511-23f2-983312c04f39@hisilicon.com>
Date: Tue, 2 Apr 2024 10:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next] RDMA/hns: Support DSCP
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
 <20240401114853.GA73174@unreal>
 <1f786e1b-e8ff-1d6f-7c4d-89724eda6712@hisilicon.com>
 <20240401181204.GC11187@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240401181204.GC11187@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/2 2:12, Leon Romanovsky wrote:
> On Mon, Apr 01, 2024 at 09:25:39PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/4/1 19:48, Leon Romanovsky wrote:
>>> On Fri, Mar 15, 2024 at 05:35:51PM +0800, Junxian Huang wrote:
>>>> Add support for DSCP configuration. For DSCP, get dscp-prio mapping
>>>> via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
>>>> UD or in QPC for RC) with the priority value. The prio-tc mapping is
>>>> configured to HW by hns3 nic driver. HW will select a corresponding
>>>> TC according to SL and the prio-tc mapping.
>>>>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 32 +++++---
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 86 ++++++++++++++++-----
>>>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 13 ++++
>>>>  include/uapi/rdma/hns-abi.h                 |  9 ++-
>>>>  5 files changed, 117 insertions(+), 29 deletions(-)
>>>
>>> 1. What is TC mode?
>>
>> TC mode indicates whether the HW is configured as DSCP mode or VLAN priority
>> mode currently.
>>
>>> 2. Did you post rdma-core PR?
>>
>> Not yet. I was meant to wait until this patch is applied. Should I post it
>> right now?
> 
> Yes, for any UAPI changes, we require to have rdma-core PR.
> 
> Thanks
> 

PR has been posted.

Thanks,
Junxian

>>
>> Junxian
>>
>>>
>>> Thanks

