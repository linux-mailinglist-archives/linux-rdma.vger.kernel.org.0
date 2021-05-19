Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C814388C1C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhESKy6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhESKy5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:54:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A0176135B;
        Wed, 19 May 2021 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421618;
        bh=mmNPzgawg93JrrkqNx7IW9SYtd5+DEG6TUzuUtyK/Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+lOZOH7s2dPooE41hW3Ci7k3QWndrNZsdB5v8Jj4/mm+hB4qBHLpVSKi3E9N8KyE
         Ps/O8l0u2fRUx5vr5WritPg9341MJXFPQ9BPEMs2yJd4g5WcFunCp0HHKZXtlvdjr7
         VKmNX+ojCHy7Hv/9Cwj1m29p+incwdlsqeauxKSe2ztDxQnX+3Ex/xG6RWmq+vbiMq
         mXS2ai46AFq0Oc74wJ/moWF8HygnhCRAEIog0zIlUOaE0ecIY4+COpAgvhH1vRhjQ9
         uWTsdOrEJOYTgD0kSvYUL7Lggt37A5AvXnpFmb3XdOZqkp5rClenppKY5d5Qt51Bp/
         ZKBkkauO45hyA==
Date:   Wed, 19 May 2021 13:53:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Remove Receive Queue of CMDQ
Message-ID: <YKTuLmsS3wOsdwWW@unreal>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
 <1620904578-29829-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620904578-29829-3-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 13, 2021 at 07:16:17PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The CRQ of CMDQ is unused, so remove code about it.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 95 ++++++++----------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 -
>  2 files changed, 25 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index b58d65f..a9b9fca 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1228,44 +1228,32 @@ static void hns_roce_free_cmq_desc(struct hns_roce_dev *hr_dev,
>  	kfree(ring->desc);
>  }
>  
> -static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
> +static int init_csq(struct hns_roce_dev *hr_dev,
> +		    struct hns_roce_v2_cmq_ring *csq)
>  {
> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
> -	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
> -					    &priv->cmq.csq : &priv->cmq.crq;
> +	dma_addr_t dma;
> +	int ret;
>  
> -	ring->flag = ring_type;
> -	ring->head = 0;
> +	csq->desc_num = CMD_CSQ_DESC_NUM;
> +	spin_lock_init(&csq->lock);
> +	csq->flag = TYPE_CSQ;
> +	csq->head = 0;
>  
> -	return hns_roce_alloc_cmq_desc(hr_dev, ring);
> -}
> +	ret = hns_roce_alloc_cmq_desc(hr_dev, csq);
> +	if (ret)
> +		return ret;
>  
> -static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
> -{
> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
> -	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
> -					    &priv->cmq.csq : &priv->cmq.crq;
> -	dma_addr_t dma = ring->desc_dma_addr;
> -
> -	if (ring_type == TYPE_CSQ) {
> -		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, (u32)dma);
> -		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
> -			   upper_32_bits(dma));
> -		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
> -			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
> -
> -		/* Make sure to write tail first and then head */
> -		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
> -		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
> -	} else {
> -		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
> -		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
> -			   upper_32_bits(dma));
> -		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
> -			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
> -		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
> -		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
> -	}
> +	dma = csq->desc_dma_addr;
> +	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, lower_32_bits(dma));
> +	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG, upper_32_bits(dma));
> +	roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
> +		   (u32)csq->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
> +
> +	/* Make sure to write CI first and then PI */
> +	roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
> +	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
> +
> +	return 0;
>  }
>  
>  static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
> @@ -1273,43 +1261,11 @@ static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>  	int ret;
>  
> -	/* Setup the queue entries for command queue */
> -	priv->cmq.csq.desc_num = CMD_CSQ_DESC_NUM;
> -	priv->cmq.crq.desc_num = CMD_CRQ_DESC_NUM;
> -
> -	/* Setup the lock for command queue */
> -	spin_lock_init(&priv->cmq.csq.lock);
> -	spin_lock_init(&priv->cmq.crq.lock);
> -
> -	/* Setup Tx write back timeout */
>  	priv->cmq.tx_timeout = HNS_ROCE_CMQ_TX_TIMEOUT;
>  
> -	/* Init CSQ */
> -	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CSQ);
> -	if (ret) {
> -		dev_err_ratelimited(hr_dev->dev,
> -				    "failed to init CSQ, ret = %d.\n", ret);
> -		return ret;
> -	}
> -
> -	/* Init CRQ */
> -	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CRQ);
> -	if (ret) {
> -		dev_err_ratelimited(hr_dev->dev,
> -				    "failed to init CRQ, ret = %d.\n", ret);
> -		goto err_crq;
> -	}
> -
> -	/* Init CSQ REG */
> -	hns_roce_cmq_init_regs(hr_dev, TYPE_CSQ);
> -
> -	/* Init CRQ REG */
> -	hns_roce_cmq_init_regs(hr_dev, TYPE_CRQ);
> -
> -	return 0;
> -
> -err_crq:
> -	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
> +	ret = init_csq(hr_dev, &priv->cmq.csq);
> +	if (ret)
> +		dev_err(hr_dev->dev, "failed to init CSQ, ret = %d.\n", ret);

This print can be seen if hns_roce_alloc_cmq_desc fails, which can be
due too OOM or dma error and in both cases, you will print message.

Thanks

>  
>  	return ret;
>  }
> @@ -1319,7 +1275,6 @@ static void hns_roce_v2_cmq_exit(struct hns_roce_dev *hr_dev)
>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>  
>  	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
> -	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.crq);
>  }
>  
>  static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index a2100a6..d168314 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -1731,7 +1731,6 @@ struct hns_roce_v2_cmq_ring {
>  
>  struct hns_roce_v2_cmq {
>  	struct hns_roce_v2_cmq_ring csq;
> -	struct hns_roce_v2_cmq_ring crq;
>  	u16 tx_timeout;
>  };
>  
> -- 
> 2.7.4
> 
