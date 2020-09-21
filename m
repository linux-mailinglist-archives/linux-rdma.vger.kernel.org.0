Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C7273077
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgIURFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 13:05:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12537 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbgIUREt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 13:04:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68dd020003>; Mon, 21 Sep 2020 10:04:02 -0700
Received: from [172.27.13.124] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 17:04:46 +0000
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/mlx5: Sync device with CPU pages
 upon ODP MR registration
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvida.com>,
        "Christoph Hellwig" <hch@infradead.org>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-5-leon@kernel.org> <20200921142543.GU3699@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <cf4516e4-f5f3-295f-d4ef-f0411765c9e8@nvidia.com>
Date:   Mon, 21 Sep 2020 20:04:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921142543.GU3699@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL109.nvidia.com (172.20.187.15) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600707842; bh=fvygQ7BbaIhKtExmYQ54LSzltnyZO0NL4d7pJFJFVGc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=BEQSsxCAqMA6qC2t0IZNgeMVL4Pj8gLXxUrQKrRNUmk9VXujlFuylCPWAhJCxfXtd
         F/uwkt741EOXxtp2x02zG0x94tYaYAlgWs4EimHh4pHzj8BimmpIxVow8GyTepBKaz
         0Y1hKyzSGCAJw0ppvn0VyLVuMTBPtr82wPoUDfusN6sfB1o+V6+aZb+4c6gr9VAjfB
         w7gxX/zalIqMKOWYY5cMQePs0OTlPRn8S3SgdSE+arIvaW9+0AQ65JuPLPmvU0nmZk
         HHDV3efDdNRHL161p+C3YRFoUqpI2lzB0Wgg/NKiLNHvMrda3VihFFxC0ZOaEw4ORI
         9J8DYFMeU0dqA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/2020 5:25 PM, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2020 at 02:21:52PM +0300, Leon Romanovsky wrote:
>
>> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
>> index dea65e511a3e..234a5d25a072 100644
>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>> @@ -1431,7 +1431,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>>   	mr->umem = umem;
>>   	set_mr_fields(dev, mr, npages, length, access_flags);
>>
>> -	if (xlt_with_umr) {
>> +	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
>>   		/*
>>   		 * If the MR was created with reg_create then it will be
>>   		 * configured properly but left disabled. It is safe to go ahead
>> @@ -1439,9 +1439,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>>   		 */
>>   		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
>>
>> -		if (access_flags & IB_ACCESS_ON_DEMAND)
>> -			update_xlt_flags |= MLX5_IB_UPD_XLT_ZAP;
>> -
>>   		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
>>   					 update_xlt_flags);
>>   		if (err) {
>> @@ -1467,6 +1464,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>>   			dereg_mr(dev, mr);
>>   			return ERR_PTR(err);
>>   		}
>> +
>> +		err = mlx5_ib_init_odp_mr(mr, start, length, xlt_with_umr);
> No reason to pass start/length, that is already in the mr
>
> Jason

The start / iova is set on 'ib_mr' in the uverbs layer post returning 
from reg_user_mr for all drivers [1], so the function just got both.
Makes sense ?

[1] 
https://elixir.bootlin.com/linux/v5.9-rc6/source/drivers/infiniband/core/uverbs_cmd.c#L746

Yishai

