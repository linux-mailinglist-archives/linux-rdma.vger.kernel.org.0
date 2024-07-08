Return-Path: <linux-rdma+bounces-3698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D811929AC5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 04:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC20B1F212F8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 02:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D03C0C;
	Mon,  8 Jul 2024 02:30:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F306FB6;
	Mon,  8 Jul 2024 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405800; cv=none; b=syd0BTtlEMW67CQvwYxC8o/fWWUpXQBQvHcqPfdbFczzVmlvptg1u2NoRbGA6JyMa70QgzbK/tl/U9CJbpGo4QckuHy25p+eIGU+BKdA6o46wqszPMTXtYxyZ7o9c7jMTnBKfOktnKy/Xo/2D4kphmBP4JlXKx4y677yT1pc3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405800; c=relaxed/simple;
	bh=4WHGI4UCsInQKdsW8Ye+PxO+z7igpdu3L52WENNCy4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u7ip7rO7uVS+WULOY9ZYZM1odQjMRuHCm778hLZJU3IM1COkNd8JgpXtZZR8zeizjlsUsvtA9vv37lgktTUgJF9FDSq8ggTYY9GqS3pYnxRsJv4gtQdwhU7F/ws3Pcpz0L35/aYh+SMSkws2TPa9VvyQ1ynmGfbSZlQNyMLRlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHSdR6QPYzwWJB;
	Mon,  8 Jul 2024 10:25:15 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CDDB1403D2;
	Mon,  8 Jul 2024 10:29:55 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 10:29:54 +0800
Message-ID: <42e9f7dd-05bd-176f-c5c0-02e200b3f58c@hisilicon.com>
Date: Mon, 8 Jul 2024 10:29:54 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 2/9] RDMA/hns: Fix a long wait for cmdq event
 during reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-3-huangjunxian6@hisilicon.com>
 <20240707083007.GE6695@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240707083007.GE6695@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/7/7 16:30, Leon Romanovsky wrote:
> On Fri, Jul 05, 2024 at 04:59:30PM +0800, Junxian Huang wrote:
>> From: wenglianfa <wenglianfa@huawei.com>
>>
>> During reset, cmdq events won't be reported, leading to a long and
>> unnecessary wait. Notify all the cmdqs to stop waiting at the beginning
>> of reset.
>>
>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index a5d746a5cc68..ff135df1a761 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -6977,6 +6977,21 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>>  
>>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>>  }
>> +
>> +static void hns_roce_v2_reset_notify_cmd(struct hns_roce_dev *hr_dev)
>> +{
>> +	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
>> +	int i;
>> +
>> +	if (!hr_dev->cmd_mod)
> 
> What prevents cmd_mod from being changed?
> 

It's set when the device is being initialized, and won't be changed after that.

Junxian

>> +		return;
>> +
>> +	for (i = 0; i < hr_cmd->max_cmds; i++) {
>> +		hr_cmd->context[i].result = -EBUSY;
>> +		complete(&hr_cmd->context[i].done);
>> +	}
>> +}
>> +
>>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>  {
>>  	struct hns_roce_dev *hr_dev;
>> @@ -6997,6 +7012,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>  	hr_dev->dis_db = true;
>>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>>  
>> +	/* Complete the CMDQ event in advance during the reset. */
>> +	hns_roce_v2_reset_notify_cmd(hr_dev);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.33.0
>>

