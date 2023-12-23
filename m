Return-Path: <linux-rdma+bounces-477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2281D2E4
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Dec 2023 08:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F8D1F23044
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Dec 2023 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E96ABF;
	Sat, 23 Dec 2023 07:26:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980966AA0
	for <linux-rdma@vger.kernel.org>; Sat, 23 Dec 2023 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vz0k1m3_1703316373;
Received: from 30.120.186.46(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vz0k1m3_1703316373)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 15:26:14 +0800
Message-ID: <ecd87dae-7a49-94ef-226c-2d5ebc202bc7@linux.alibaba.com>
Date: Sat, 23 Dec 2023 15:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 2/2] RDMA/erdma: Add hardware statistics support
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20231220085424.97407-1-chengyou@linux.alibaba.com>
 <20231220085424.97407-3-chengyou@linux.alibaba.com>
 <20231220101639.GE136797@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20231220101639.GE136797@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/23 6:16 PM, Leon Romanovsky wrote:
> On Wed, Dec 20, 2023 at 04:54:24PM +0800, Cheng Xu wrote:
>> First, we add a new command to query hardware statistics, and then
>> implement two functions: ib_device_ops.alloc_hw_port_stats and
>> ib_device_ops.get_hw_stats to allow rdma tool can get the statistics
>> of erdma device.
>>

<...>

>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
>> index c317947563fb..2c67e7f48336 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>> @@ -1599,10 +1599,9 @@ static int erdma_init_kernel_cq(struct erdma_cq *cq)
>>  {
>>  	struct erdma_dev *dev = to_edev(cq->ibcq.device);
>>  
>> -	cq->kern_cq.qbuf =
>> -		dma_alloc_coherent(&dev->pdev->dev,
>> -				   WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
>> -				   &cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
>> +	cq->kern_cq.qbuf = dma_alloc_coherent(
>> +		&dev->pdev->dev, WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
>> +		&cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
> 
> It looks like unrelated change.
>

Oh, this is changed by clang-format, and I forgot to remove it.

Will remove it in v2.

>>  	if (!cq->kern_cq.qbuf)
>>  		return -ENOMEM;
>>

  
<...>

>> +
>> +static const struct rdma_stat_desc erdma_descs[] = {
>> +	[ERDMA_STATS_TX_REQS_CNT].name = "hw_tx_reqs_cnt",
>> +	[ERDMA_STATS_TX_PACKETS_CNT].name = "hw_tx_packets_cnt",
>> +	[ERDMA_STATS_TX_BYTES_CNT].name = "hw_tx_bytes_cnt",
>> +	[ERDMA_STATS_TX_DISABLE_DROP_CNT].name = "hw_disable_drop_cnt",
>> +	[ERDMA_STATS_TX_BPS_METER_DROP_CNT].name = "hw_bps_limit_drop_cnt",
>> +	[ERDMA_STATS_TX_PPS_METER_DROP_CNT].name = "hw_pps_limit_drop_cnt",
>> +	[ERDMA_STATS_RX_PACKETS_CNT].name = "hw_rx_packets_cnt",
>> +	[ERDMA_STATS_RX_BYTES_CNT].name = "hw_rx_bytes_cnt",
>> +	[ERDMA_STATS_RX_DISABLE_DROP_CNT].name = "hw_rx_disable_drop_cnt",
>> +	[ERDMA_STATS_RX_BPS_METER_DROP_CNT].name = "hw_rx_bps_limit_drop_cnt",
>> +	[ERDMA_STATS_RX_PPS_METER_DROP_CNT].name = "hw_rx_pps_limit_drop_cnt",
>> +};
> 
> There is no need in "hw_" prefix, the counters will be in hw_counters
> folder anyway.
>

Will fix in v2.

>> +
>> +struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
>> +						u32 port_num)
>> +{
>> +	return rdma_alloc_hw_stats_struct(erdma_descs, ERDMA_STATS_MAX,
>> +					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
>> +}
>> +
>> +int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
>> +{
>> +	struct erdma_cmdq_query_stats_resp *resp;
>> +	struct erdma_cmdq_query_req req;
>> +	dma_addr_t dma_addr;
>> +	int err;
>> +
>> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>> +				CMDQ_OPCODE_GET_STATS);
>> +
>> +	resp = dma_pool_alloc(dev->resp_pool, GFP_KERNEL | __GFP_ZERO,
>> +			      &dma_addr);
> 
> dma_pool_zalloc()
> 

Thanks, it's better, Will fix in v2.

>> +	if (!resp)
>> +		return -ENOMEM;
>> +
>> +	req.target_addr = dma_addr;
>> +	req.target_length = ERDMA_HW_RESP_SIZE;
>> +
>> +	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
>> +	if (err)
>> +		goto out;
>> +
>> +	if (resp->hdr.magic != ERDMA_HW_RESP_MAGIC) {
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	memcpy(&stats->value[0], &resp->tx_req_cnt,
>> +	       sizeof(u64) * stats->num_counters);
>> +
>> +out:
>> +	dma_pool_free(dev->resp_pool, resp, dma_addr);
>> +
>> +	return err;
>> +}
>> +
>> +int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
>> +		       u32 port, int index)
>> +{
>> +	struct erdma_dev *dev = to_edev(ibdev);
>> +	int ret;
>> +
>> +	if (port == 0)
>> +		return 0;
>> +
>> +	if (port > 1)
> 
> Is it possible?
>
Thanks, I checked the core code, and core code will make sure that the port index
is valid. Will remove this check in v2.


Cheng Xu

