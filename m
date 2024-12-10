Return-Path: <linux-rdma+bounces-6371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678B9EA8BD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 07:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC571888919
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1109A22B8C5;
	Tue, 10 Dec 2024 06:24:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CE22616F;
	Tue, 10 Dec 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811870; cv=none; b=r4OuxYDwhI1A99G+h2PCpUMuKkEiKLBYtjVNFU7OlON98uE4qTRmIYJVI6JQEhvs4osjmO250irwSLb/shG7IYsLJo9b3Ay+0ccb1AF2BPCe0AatYFcoZei0zU4TohIhaJF5QH2Uymkt4ZO5Jn2dw96vR8G4UUuUJVk5oJ+ehD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811870; c=relaxed/simple;
	bh=elgQcUu4giLbY/22LpwrD3iFr839bc6DYgVWOvMLRDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gc6sLL8z9JongmwBEE9/fH8hZ5qU11M501eMY8YZxmNZySEZDMSExvjaRwx7m/lzUE+7W05NTdjmzCAMbHkalypQvDcC1IHlNo2Dr0kMLWW7/SUHkrrzDKPXVbjxnIG72Vzze598JT3COSiJV08K0fVO2d/22igT5epx4AddDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y6pXB2ZPmz11MD1;
	Tue, 10 Dec 2024 14:21:14 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id B437B1402E2;
	Tue, 10 Dec 2024 14:24:18 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 14:24:17 +0800
Message-ID: <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
Date: Tue, 10 Dec 2024 14:24:16 +0800
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
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20241209190125.GA2367762@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/12/10 3:01, Jason Gunthorpe wrote:
> On Mon, Oct 14, 2024 at 09:07:31PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Mmap reset state to notify userspace about HW reset. The mmaped flag
>> hw_ready will be initiated to a non-zero value. When HW is reset,
>> the mmap page will be zapped and userspace will get a zero value of
>> hw_ready.
> 
> This needs alot more explanation about *why* does userspace need this
> information and why is hns unique here.
> 

Our HW cannot flush WQEs by itself unless the driver posts a modify-qp-to-err
mailbox. But when the HW is reset, it'll stop handling mailbox too, so the HW
becomes unable to produce any more CQEs for the existing WQEs. This will break
some users' expectation that they should be able to poll CQEs as many as the
number of the posted WQEs in any cases.

We try to notify the reset state to userspace so that we can generate software
WCs for the existing WQEs in userspace instead of HW in reset state, which is
what this rdma-core PR does:

https://github.com/linux-rdma/rdma-core/pull/1504

Junxian

> Usually when the HW is reset there are enough existing system calls
> that will start failing that a driver should not need to do something
> like this.
> 
> Jason

