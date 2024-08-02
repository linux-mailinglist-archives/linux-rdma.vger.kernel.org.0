Return-Path: <linux-rdma+bounces-4179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D085B94564B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 04:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF72286476
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB218EA8;
	Fri,  2 Aug 2024 02:28:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E071A702;
	Fri,  2 Aug 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565694; cv=none; b=HKbAnVejoxR4s3cj2MFLfng8VBXTjlRH0QhdpNvc+olTgBMYXNHlxyqsmNfcc939/1f42hta3j43q/SGO8kgh62t9hP1/FVzSqpKmQxpmjyLIBPk1ffYXIcrZ4ZmXwZ61ALNYRiOE7vWRQWSHhyOq0LeMTJ5C1d/D0423q8ivIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565694; c=relaxed/simple;
	bh=uu1Z6bxJRmFyQRtdMJvH5k/t5mvvOsBMA+2WTmMaNak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fPlE0NwXPOWU5aByCOZaGHkY6XEg5ZflnxDev78haDoBEzEt13e13ddPsuKD3gFTXYovnECsNznF/KQyrVNQSs/60b5xIr2pqz0DFVSXqWQ+jlcHj4vEQI4v+jC7BAt4kvnLtTrO7vqqaxvL1PpBQp0OBaaD0ossgbRI7EyM69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WZqQB5H2kzQnTs;
	Fri,  2 Aug 2024 10:23:46 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 845F5140132;
	Fri,  2 Aug 2024 10:28:07 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Aug 2024 10:28:06 +0800
Message-ID: <1ddde0db-c18e-7968-185e-1e792854d1b6@hisilicon.com>
Date: Fri, 2 Aug 2024 10:28:06 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<bvanassche@acm.org>, <nab@risingtidesystems.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>
References: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
 <02f7cfc8-0495-485d-9849-b5a9514f6110@linux.dev>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <02f7cfc8-0495-485d-9849-b5a9514f6110@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/8/2 5:55, Zhu Yanjun wrote:
> 在 2024/8/1 15:44, Junxian Huang 写道:
>> Currently cancel_work_sync() is not called when srpt_refresh_port()
>> failed in srpt_add_one(). There is a probability that sdev has been
>> freed while the previously initiated sport->work is still running,
>> leading to a UAF as the log below:
>>
>> [  T880] ib_srpt MAD registration failed for hns_1-1.
>> [  T880] ib_srpt srpt_add_one(hns_1) failed.
>> [  T376] Unable to handle kernel paging request at virtual address 0000000000010008
>> ...
>> [  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
>> ...
>> [  T376] Call trace:
>> [  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
>> [  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
>> [  T376]  process_one_work+0x1d8/0x4cc
>> [  T376]  worker_thread+0x158/0x410
>> [  T376]  kthread+0x108/0x13c
>> [  T376]  ret_from_fork+0x10/0x18
>>
>> Add cancel_work_sync() to the exception branch to fix this UAF.
> 
> Can you share the method to reproduce this problem?
> I am interested in this problem.
> 
> Thanks,
> Zhu Yanjun
> 

I was testing bonding in 5.10 kernel, doing
	ifenslave bond0 eth0 eth1; ifenslave -d bond0 eth0 eth1
and
	ethtool --reset eth0 dedicated; ethtool --reset eth1 dedicated
concurrently and infinitely.

But I think this problem has been fixed in latest mainline probably.
Please look into my reply to Bart in v2.

Junxian

>>
>> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 9632afbd727b..244e5c115bf7 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
>>   {
>>       struct srpt_device *sdev;
>>       struct srpt_port *sport;
>> +    u32 i, j;
>>       int ret;
>> -    u32 i;
>>         pr_debug("device = %p\n", device);
>>   @@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
>>           if (ret) {
>>               pr_err("MAD registration failed for %s-%d.\n",
>>                      dev_name(&sdev->device->dev), i);
>> -            i--;
>>               goto err_port;
>>           }
>>       }
>> @@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
>>       return 0;
>>     err_port:
>> +    for (j = i, i--; j > 0; j--)
>> +        cancel_work_sync(&sdev->port[j - 1].work);
>>       srpt_unregister_mad_agent(sdev, i);
>>   err_cm:
>>       if (sdev->cm_id)
> 

