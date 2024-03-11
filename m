Return-Path: <linux-rdma+bounces-1371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181108779B5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 03:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B17B20F9B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 02:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A6A47;
	Mon, 11 Mar 2024 02:01:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D4801;
	Mon, 11 Mar 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122468; cv=none; b=OuAuKuRbW0ukEpwI34yUCGWk4FUuBChZQmmSoUMa4yDaH+WkoNZqmHrjO1Ddb0iEJ6wWp3iY9NT1ujJ039/wzxbYSv0543ju7+q38zQYQKw5t781pD2qh/5IoQkXgio7Xizkvo2arc8WRg/gKVJ5U8KvnYczgwV/6omsBRKK0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122468; c=relaxed/simple;
	bh=wiQLkBh8niMqqh6Ln393H6ASZbM8ndGA41bmCEBbZZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oLOQNq1HUwK2XWlqWtGkzF0aK1SgPfFL8ZDWs1gV8VTUwzCLUUBULsLZfBHVM233cYaESi9Of3u+XOraMYl//G6CSCZ8jUtx/qpovVNIShPXEhwZojguiI7Mvo50GTyCS6v8vBF/iNXo7SpUF9izh/0YKrwEglGd2eSANUTwcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TtKgS0NWfz1h1rd;
	Mon, 11 Mar 2024 09:58:28 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C5F61402E1;
	Mon, 11 Mar 2024 10:00:53 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 10:00:52 +0800
Message-ID: <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>
Date: Mon, 11 Mar 2024 10:00:51 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
 <20240310100027.GC12921@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240310100027.GC12921@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/3/10 18:00, Leon Romanovsky wrote:
> On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> hns RoCE supports 4 congestion control algorithms. Each algorihm
>> involves multiple parameters. Add port sysfs directory for each
>> algorithm to allow modifying their parameters.
> 
> Unless Jason changed his position after this rewrite [1], we don't allow
> any custom driver sysfs code.
> 
> [1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> 

I didn't quite get the reason from [1], could you please explain it?

And it would be helpful if you could give us a hint about any other
proper ways to do the algorithm parameter configuration.

Thanks,
Junxian

>>
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  20 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  59 ++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 132 ++++++++
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_sysfs.c  | 346 ++++++++++++++++++++
>>  6 files changed, 561 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_sysfs.c
> 
> Thanks

