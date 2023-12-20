Return-Path: <linux-rdma+bounces-472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A14819C86
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 11:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1477C1C22526
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38711F93E;
	Wed, 20 Dec 2023 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u75wSu7f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E421109
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 10:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5861FC433C7;
	Wed, 20 Dec 2023 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703067403;
	bh=hGUNpieualqz2G5A8VTMnhn7q3WGChRTrsG53gRwLfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u75wSu7frx6atvI/OFM6wKfLOeyWM9HTmX9wim2WLgJfnPwrrsVrk+vodOPj3WBJX
	 fXKFivFh6kQ0XiAKdBXmGspuNwS/bOsygX1SRsU0l1lPxESHmgxx5VW97NfA+A0p/W
	 oJYgpQL2KBAY1IyzV7LE3qSTWuI5VEfH97Q/ZL3OeUjgL7gZH5NOwSEmsb/eyCeuqR
	 FyqJUqoJY5P9LneEWgza8zNc9sD42mfv/nqKndpOlKQVS0Rc469uFztvUzDbhUERbN
	 qNyUqNVzv4XtQbjW7Eq1RRZ6d1udAhiDdDZRb+y+QjvNK33pCulkYpRmnCMlO8KqAv
	 qzGPWOVm+G/Wg==
Date: Wed, 20 Dec 2023 12:16:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 2/2] RDMA/erdma: Add hardware statistics support
Message-ID: <20231220101639.GE136797@unreal>
References: <20231220085424.97407-1-chengyou@linux.alibaba.com>
 <20231220085424.97407-3-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220085424.97407-3-chengyou@linux.alibaba.com>

On Wed, Dec 20, 2023 at 04:54:24PM +0800, Cheng Xu wrote:
> First, we add a new command to query hardware statistics, and then
> implement two functions: ib_device_ops.alloc_hw_port_stats and
> ib_device_ops.get_hw_stats to allow rdma tool can get the statistics
> of erdma device.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  40 +++++++++
>  drivers/infiniband/hw/erdma/erdma_main.c  |   2 +
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 100 +++++++++++++++++++++-
>  drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +
>  4 files changed, 142 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
> index 9d316fdc6f9a..2c030f254ff7 100644
> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
> @@ -146,6 +146,7 @@ enum CMDQ_COMMON_OPCODE {
>  	CMDQ_OPCODE_DESTROY_EQ = 1,
>  	CMDQ_OPCODE_QUERY_FW_INFO = 2,
>  	CMDQ_OPCODE_CONF_MTU = 3,
> +	CMDQ_OPCODE_GET_STATS = 4,
>  	CMDQ_OPCODE_CONF_DEVICE = 5,
>  	CMDQ_OPCODE_ALLOC_DB = 8,
>  	CMDQ_OPCODE_FREE_DB = 9,
> @@ -357,6 +358,45 @@ struct erdma_cmdq_reflush_req {
>  	u32 rq_pi;
>  };
>  
> +/* Response Definitions for Query Command Category */
> +#define ERDMA_HW_RESP_SIZE 256
> +
> +struct erdma_cmdq_query_req {
> +	u64 hdr;
> +	u32 rsvd;
> +	u32 index;
> +
> +	u64 target_addr;
> +	u32 target_length;
> +};
> +
> +#define ERDMA_HW_RESP_MAGIC 0x5566
> +
> +struct erdma_cmdq_query_resp_hdr {
> +	u16 magic;
> +	u8 ver;
> +	u8 length;
> +
> +	u32 index;
> +	u32 rsvd[2];
> +};
> +
> +struct erdma_cmdq_query_stats_resp {
> +	struct erdma_cmdq_query_resp_hdr hdr;
> +
> +	u64 tx_req_cnt;
> +	u64 tx_packets_cnt;
> +	u64 tx_bytes_cnt;
> +	u64 tx_drop_packets_cnt;
> +	u64 tx_bps_meter_drop_packets_cnt;
> +	u64 tx_pps_meter_drop_packets_cnt;
> +	u64 rx_packets_cnt;
> +	u64 rx_bytes_cnt;
> +	u64 rx_drop_packets_cnt;
> +	u64 rx_bps_meter_drop_packets_cnt;
> +	u64 rx_pps_meter_drop_packets_cnt;
> +};
> +
>  /* cap qword 0 definition */
>  #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
>  #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 541e77aea494..0c35f7e464c8 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -482,6 +482,7 @@ static const struct ib_device_ops erdma_device_ops = {
>  	.driver_id = RDMA_DRIVER_ERDMA,
>  	.uverbs_abi_ver = ERDMA_ABI_VERSION,
>  
> +	.alloc_hw_port_stats = erdma_alloc_hw_port_stats,
>  	.alloc_mr = erdma_ib_alloc_mr,
>  	.alloc_pd = erdma_alloc_pd,
>  	.alloc_ucontext = erdma_alloc_ucontext,
> @@ -493,6 +494,7 @@ static const struct ib_device_ops erdma_device_ops = {
>  	.destroy_cq = erdma_destroy_cq,
>  	.destroy_qp = erdma_destroy_qp,
>  	.get_dma_mr = erdma_get_dma_mr,
> +	.get_hw_stats = erdma_get_hw_stats,
>  	.get_port_immutable = erdma_get_port_immutable,
>  	.iw_accept = erdma_accept,
>  	.iw_add_ref = erdma_qp_get_ref,
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index c317947563fb..2c67e7f48336 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -1599,10 +1599,9 @@ static int erdma_init_kernel_cq(struct erdma_cq *cq)
>  {
>  	struct erdma_dev *dev = to_edev(cq->ibcq.device);
>  
> -	cq->kern_cq.qbuf =
> -		dma_alloc_coherent(&dev->pdev->dev,
> -				   WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
> -				   &cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);
> +	cq->kern_cq.qbuf = dma_alloc_coherent(
> +		&dev->pdev->dev, WARPPED_BUFSIZE(cq->depth << CQE_SHIFT),
> +		&cq->kern_cq.qbuf_dma_addr, GFP_KERNEL);

It looks like unrelated change.

>  	if (!cq->kern_cq.qbuf)
>  		return -ENOMEM;
>  
> @@ -1708,3 +1707,96 @@ void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason)
>  
>  	ib_dispatch_event(&event);
>  }
> +
> +enum counters {
> +	ERDMA_STATS_TX_REQS_CNT,
> +	ERDMA_STATS_TX_PACKETS_CNT,
> +	ERDMA_STATS_TX_BYTES_CNT,
> +	ERDMA_STATS_TX_DISABLE_DROP_CNT,
> +	ERDMA_STATS_TX_BPS_METER_DROP_CNT,
> +	ERDMA_STATS_TX_PPS_METER_DROP_CNT,
> +
> +	ERDMA_STATS_RX_PACKETS_CNT,
> +	ERDMA_STATS_RX_BYTES_CNT,
> +	ERDMA_STATS_RX_DISABLE_DROP_CNT,
> +	ERDMA_STATS_RX_BPS_METER_DROP_CNT,
> +	ERDMA_STATS_RX_PPS_METER_DROP_CNT,
> +
> +	ERDMA_STATS_MAX
> +};
> +
> +static const struct rdma_stat_desc erdma_descs[] = {
> +	[ERDMA_STATS_TX_REQS_CNT].name = "hw_tx_reqs_cnt",
> +	[ERDMA_STATS_TX_PACKETS_CNT].name = "hw_tx_packets_cnt",
> +	[ERDMA_STATS_TX_BYTES_CNT].name = "hw_tx_bytes_cnt",
> +	[ERDMA_STATS_TX_DISABLE_DROP_CNT].name = "hw_disable_drop_cnt",
> +	[ERDMA_STATS_TX_BPS_METER_DROP_CNT].name = "hw_bps_limit_drop_cnt",
> +	[ERDMA_STATS_TX_PPS_METER_DROP_CNT].name = "hw_pps_limit_drop_cnt",
> +	[ERDMA_STATS_RX_PACKETS_CNT].name = "hw_rx_packets_cnt",
> +	[ERDMA_STATS_RX_BYTES_CNT].name = "hw_rx_bytes_cnt",
> +	[ERDMA_STATS_RX_DISABLE_DROP_CNT].name = "hw_rx_disable_drop_cnt",
> +	[ERDMA_STATS_RX_BPS_METER_DROP_CNT].name = "hw_rx_bps_limit_drop_cnt",
> +	[ERDMA_STATS_RX_PPS_METER_DROP_CNT].name = "hw_rx_pps_limit_drop_cnt",
> +};

There is no need in "hw_" prefix, the counters will be in hw_counters
folder anyway.

> +
> +struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
> +						u32 port_num)
> +{
> +	return rdma_alloc_hw_stats_struct(erdma_descs, ERDMA_STATS_MAX,
> +					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
> +}
> +
> +int erdma_query_hw_stats(struct erdma_dev *dev, struct rdma_hw_stats *stats)
> +{
> +	struct erdma_cmdq_query_stats_resp *resp;
> +	struct erdma_cmdq_query_req req;
> +	dma_addr_t dma_addr;
> +	int err;
> +
> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
> +				CMDQ_OPCODE_GET_STATS);
> +
> +	resp = dma_pool_alloc(dev->resp_pool, GFP_KERNEL | __GFP_ZERO,
> +			      &dma_addr);

dma_pool_zalloc()

> +	if (!resp)
> +		return -ENOMEM;
> +
> +	req.target_addr = dma_addr;
> +	req.target_length = ERDMA_HW_RESP_SIZE;
> +
> +	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
> +	if (err)
> +		goto out;
> +
> +	if (resp->hdr.magic != ERDMA_HW_RESP_MAGIC) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	memcpy(&stats->value[0], &resp->tx_req_cnt,
> +	       sizeof(u64) * stats->num_counters);
> +
> +out:
> +	dma_pool_free(dev->resp_pool, resp, dma_addr);
> +
> +	return err;
> +}
> +
> +int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
> +		       u32 port, int index)
> +{
> +	struct erdma_dev *dev = to_edev(ibdev);
> +	int ret;
> +
> +	if (port == 0)
> +		return 0;
> +
> +	if (port > 1)

Is it possible?

> +		return -EINVAL;
> +
> +	ret = erdma_query_hw_stats(dev, stats);
> +	if (ret)
> +		return ret;
> +
> +	return stats->num_counters;
> +}
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
> index eb9c0f92fb6f..db6018529ccc 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
> @@ -361,5 +361,9 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  		    unsigned int *sg_offset);
>  void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason);
>  void erdma_set_mtu(struct erdma_dev *dev, u32 mtu);
> +struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
> +						u32 port_num);
> +int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
> +		       u32 port, int index);
>  
>  #endif
> -- 
> 2.31.1
> 
> 

