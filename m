Return-Path: <linux-rdma+bounces-476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E869581D2D5
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Dec 2023 08:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F7BB2378E
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Dec 2023 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9816ABF;
	Sat, 23 Dec 2023 07:15:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1C6AA0
	for <linux-rdma@vger.kernel.org>; Sat, 23 Dec 2023 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vz0eCs3_1703315696;
Received: from 172.10.16.80(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vz0eCs3_1703315696)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 15:14:57 +0800
Message-ID: <d9fb3779-8208-43c3-5fd2-a084f12c4f1e@linux.alibaba.com>
Date: Sat, 23 Dec 2023 15:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From: Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next 1/2] RDMA/erdma: Introduce dma pool for hardware
 responses of CMDQ requests
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20231220085424.97407-1-chengyou@linux.alibaba.com>
 <20231220085424.97407-2-chengyou@linux.alibaba.com>
 <20231220101243.GD136797@unreal>
Content-Language: en-US
In-Reply-To: <20231220101243.GD136797@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/23 6:12 PM, Leon Romanovsky wrote:
> On Wed, Dec 20, 2023 at 04:54:23PM +0800, Cheng Xu wrote:
>> Hardware response, such as the result of query statistics, may be too
>> long to be directly accommodated within the CQE structure. To address
>> this, we introduce a DMA pool to hold the hardware's responses of CMDQ
>> requests.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>  drivers/infiniband/hw/erdma/erdma.h      |  2 ++
>>  drivers/infiniband/hw/erdma/erdma_main.c | 38 ++++++++++++++++++++++--
>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>

<...>

>> +static int erdma_dma_pools_init(struct erdma_dev *dev)
>> +{
>> +	dev->resp_pool = dma_pool_create("erdma_resp_pool", &dev->pdev->dev,
>> +					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
>> +					 0);
>> +	if (!dev->resp_pool)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static void erdma_dma_pools_destroy(struct erdma_dev *dev)
>> +{
>> +	dma_pool_destroy(dev->resp_pool);
>> +}
> 
> Please don't add extra layer of functions which will be called in same
> file anyway. Call directly to dma_pool_destroy(), same goes for dma_pool_create().

Get it.

Will fix in v2.

Thanks,
Cheng Xu

 
> Thanks

