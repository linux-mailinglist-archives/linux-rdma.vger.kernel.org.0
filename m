Return-Path: <linux-rdma+bounces-6503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB099F080B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 10:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B205B188BF0D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 09:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0B1B3925;
	Fri, 13 Dec 2024 09:38:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696841B3922;
	Fri, 13 Dec 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082685; cv=none; b=lNLmBDNS6EdTMJRaBc4LhNR+zE6lwaJnDhoFeUE05GE4W99KMBIJOUqu+2wEVDMeHl9V83AvT4fC8Cnk9D2PlftYG4oks22NdIdnhzwlzFUman2mc4I+LjYL7pvxerxwv/m0G+uk4yFVVOe6ftlWosjtGnkWmL/es8bs9f+fL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082685; c=relaxed/simple;
	bh=HITZSZpjru9RSOjYBpX/AlEUY8rBdvdHz3Y6Yqg8P0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q0AlnDHMSEKUc4xxgrisMAGe/exnB/RAO5FZDMouBRIqqyuty3pnbJLsBqZRPfK/QWmbGA/vEcBQgkVfINcoUYBzv/1mDVHYLW3wFfao/KhcmOzujuraqfC+QEc0DPnkGEo3un3dSQTYweJbKAqMnGRW/Oq6jlgem3h/HdHsmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y8klV1K3Zz1JFDP;
	Fri, 13 Dec 2024 17:37:42 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B6CA140123;
	Fri, 13 Dec 2024 17:37:59 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Dec 2024 17:37:58 +0800
Message-ID: <92d90a3b-40e5-b47a-e570-ca63e4e58126@hisilicon.com>
Date: Fri, 13 Dec 2024 17:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
 <20241209190125.GA2367762@nvidia.com>
 <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
 <20241210134827.GG2347147@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20241210134827.GG2347147@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/12/10 21:48, Jason Gunthorpe wrote:
> On Tue, Dec 10, 2024 at 02:24:16PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/12/10 3:01, Jason Gunthorpe wrote:
>>> On Mon, Oct 14, 2024 at 09:07:31PM +0800, Junxian Huang wrote:
>>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>>
>>>> Mmap reset state to notify userspace about HW reset. The mmaped flag
>>>> hw_ready will be initiated to a non-zero value. When HW is reset,
>>>> the mmap page will be zapped and userspace will get a zero value of
>>>> hw_ready.
>>>
>>> This needs alot more explanation about *why* does userspace need this
>>> information and why is hns unique here.
>>>
>>
>> Our HW cannot flush WQEs by itself unless the driver posts a modify-qp-to-err
>> mailbox. But when the HW is reset, it'll stop handling mailbox too, so the HW
>> becomes unable to produce any more CQEs for the existing WQEs. This will break
>> some users' expectation that they should be able to poll CQEs as many as the
>> number of the posted WQEs in any cases.
> 
> But your reset flow partially disassociates the device, when the
> userspace goes back to sleep, or rearms the CQ, it should get a hard
> fail and do a full cleanup without relying on flushing.
> 

Not sure if I got your point, when you said "the userspace goes back to sleep",
did you mean the ibv_get_async_event() api? Are you suggesting that userspace
should call ibv_get_async_event() to monitor async events, and when it gets a
fatal event, it should stop polling CQs and clean up everything instead of
still waiting for the remaining CQEs?

Thanks,
Junxian

>> We try to notify the reset state to userspace so that we can generate software
>> WCs for the existing WQEs in userspace instead of HW in reset state, which is
>> what this rdma-core PR does:
> 
> That doesn't sound right at all. Device disassociation is a hard fail,
> we don't try to elegantly do things like generate completions. The
> device is dead, the queues are gone.
> 
> Jason
> 

