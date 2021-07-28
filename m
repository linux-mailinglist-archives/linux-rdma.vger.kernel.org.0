Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60373D87B6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhG1GNU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 02:13:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16011 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhG1GNU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 02:13:20 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZNY93wrfzZtmk;
        Wed, 28 Jul 2021 14:09:49 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:13:16 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 14:13:16 +0800
Subject: Re: [PATCH v3 for-next 12/12] RDMA/hns: Dump detailed driver-specific
 UCTX
To:     Leon Romanovsky <leon@kernel.org>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
 <1627356452-30564-13-git-send-email-liangwenpeng@huawei.com>
 <YP/0ksOdlErAT9lh@unreal>
CC:     <dledford@redhat.com>, <jgg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <d5427613-b9bc-f527-1a28-8f20c288394c@huawei.com>
Date:   Wed, 28 Jul 2021 14:13:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YP/0ksOdlErAT9lh@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/7/27 19:57, Leon Romanovsky wrote:
> On Tue, Jul 27, 2021 at 11:27:32AM +0800, Wenpeng Liang wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Dump DCA mem pool status in UCTX restrack.
>>
>> Sample output:
>> $ rdma res show ctx dev hns_0 -dd
>>  dev hns_0 ctxn 7 pid 1410 comm python3 drv_dca-loading 37.50 drv_dca-total 65536 drv_dca-free 40960
>>  dev hns_0 ctxn 8 pid 1410 comm python3 drv_dca-loading 0.00 drv_dca-total 0 drv_dca-free 0
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
>>  drivers/infiniband/hw/hns/hns_roce_restrack.c | 85 +++++++++++++++++++++++++++
>>  3 files changed, 88 insertions(+)
> <...>
> 
>> +static int hns_roce_fill_dca_uctx(struct hns_roce_dca_ctx *ctx,
>> +				  struct sk_buff *msg)
>> +{
>> +	char tmp_str[LOADING_PERCENT_CHARS];
>> +	unsigned long flags;
>> +	u64 total, free;
>> +	u64 percent;
>> +	u32 rem = 0;
>> +
>> +	spin_lock_irqsave(&ctx->pool_lock, flags);
>> +	total = ctx->total_size;
>> +	free = ctx->free_size;
>> +	spin_unlock_irqrestore(&ctx->pool_lock, flags);
>> +
>> +	percent = calc_dca_loading_percent(total, free, &rem);
>> +	scnprintf(tmp_str, sizeof(tmp_str), "%llu.%0*u\n", percent,
>> +		  LOADING_PERCENT_SHIFT, rem);
>> +
>> +	if (rdma_nl_put_driver_string(msg, "dca-loading", tmp_str))
>> +		goto err;
> Please no, users can calculate percentage by themselves. We don't need
> to complicate kernel for it.
> 
> Thanks
> 

The next version will remove "dca-loading".

Thanks

>> +
>> +	if (rdma_nl_put_driver_u64(msg, "dca-total", total))
>> +		goto err;
>> +
>> +	if (rdma_nl_put_driver_u64(msg, "dca-free", free))
>> +		goto err;
>> +
>> +	return 0;
>> +
>> +err:
>> +	return -EMSGSIZE;
>> +}
