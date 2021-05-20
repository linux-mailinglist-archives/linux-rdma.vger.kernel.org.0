Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C965389B7C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 04:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETCqG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 19 May 2021 22:46:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3609 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhETCqG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 22:46:06 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlvCk64GqzmWfM;
        Thu, 20 May 2021 10:42:26 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:44:43 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 10:44:43 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 20 May 2021 10:44:42 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, chenglang <chenglang@huawei.com>
Subject: Re: [PATCH for-next 2/3] RDMA/hns: Remove Receive Queue of CMDQ
Thread-Topic: [PATCH for-next 2/3] RDMA/hns: Remove Receive Queue of CMDQ
Thread-Index: AQHXR+lqlzeyVuXBnEaTsdzW509eXA==
Date:   Thu, 20 May 2021 02:44:42 +0000
Message-ID: <80267485a26a4bb7b340636fcbf44b93@huawei.com>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
 <1620904578-29829-3-git-send-email-liweihang@huawei.com>
 <YKTuLmsS3wOsdwWW@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/5/19 18:53, Leon Romanovsky wrote:
> On Thu, May 13, 2021 at 07:16:17PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> The CRQ of CMDQ is unused, so remove code about it.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 95 ++++++++----------------------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 -
>>  2 files changed, 25 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index b58d65f..a9b9fca 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1228,44 +1228,32 @@ static void hns_roce_free_cmq_desc(struct hns_roce_dev *hr_dev,
>>  	kfree(ring->desc);
>>  }
>>  
>> -static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
>> +static int init_csq(struct hns_roce_dev *hr_dev,
>> +		    struct hns_roce_v2_cmq_ring *csq)
>>  {
>> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> -	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
>> -					    &priv->cmq.csq : &priv->cmq.crq;
>> +	dma_addr_t dma;
>> +	int ret;
>>  
>> -	ring->flag = ring_type;
>> -	ring->head = 0;
>> +	csq->desc_num = CMD_CSQ_DESC_NUM;
>> +	spin_lock_init(&csq->lock);
>> +	csq->flag = TYPE_CSQ;
>> +	csq->head = 0;
>>  
>> -	return hns_roce_alloc_cmq_desc(hr_dev, ring);
>> -}
>> +	ret = hns_roce_alloc_cmq_desc(hr_dev, csq);
>> +	if (ret)
>> +		return ret;
>>  
>> -static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
>> -{
>> -	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> -	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
>> -					    &priv->cmq.csq : &priv->cmq.crq;
>> -	dma_addr_t dma = ring->desc_dma_addr;
>> -
>> -	if (ring_type == TYPE_CSQ) {
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, (u32)dma);
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
>> -			   upper_32_bits(dma));
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
>> -			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
>> -
>> -		/* Make sure to write tail first and then head */
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
>> -	} else {
>> -		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
>> -		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
>> -			   upper_32_bits(dma));
>> -		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
>> -			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
>> -		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
>> -		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
>> -	}
>> +	dma = csq->desc_dma_addr;
>> +	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, lower_32_bits(dma));
>> +	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG, upper_32_bits(dma));
>> +	roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
>> +		   (u32)csq->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
>> +
>> +	/* Make sure to write CI first and then PI */
>> +	roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
>> +	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
>> +
>> +	return 0;
>>  }
>>  
>>  static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
>> @@ -1273,43 +1261,11 @@ static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
>>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>>  	int ret;
>>  
>> -	/* Setup the queue entries for command queue */
>> -	priv->cmq.csq.desc_num = CMD_CSQ_DESC_NUM;
>> -	priv->cmq.crq.desc_num = CMD_CRQ_DESC_NUM;
>> -
>> -	/* Setup the lock for command queue */
>> -	spin_lock_init(&priv->cmq.csq.lock);
>> -	spin_lock_init(&priv->cmq.crq.lock);
>> -
>> -	/* Setup Tx write back timeout */
>>  	priv->cmq.tx_timeout = HNS_ROCE_CMQ_TX_TIMEOUT;
>>  
>> -	/* Init CSQ */
>> -	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CSQ);
>> -	if (ret) {
>> -		dev_err_ratelimited(hr_dev->dev,
>> -				    "failed to init CSQ, ret = %d.\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	/* Init CRQ */
>> -	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CRQ);
>> -	if (ret) {
>> -		dev_err_ratelimited(hr_dev->dev,
>> -				    "failed to init CRQ, ret = %d.\n", ret);
>> -		goto err_crq;
>> -	}
>> -
>> -	/* Init CSQ REG */
>> -	hns_roce_cmq_init_regs(hr_dev, TYPE_CSQ);
>> -
>> -	/* Init CRQ REG */
>> -	hns_roce_cmq_init_regs(hr_dev, TYPE_CRQ);
>> -
>> -	return 0;
>> -
>> -err_crq:
>> -	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
>> +	ret = init_csq(hr_dev, &priv->cmq.csq);
>> +	if (ret)
>> +		dev_err(hr_dev->dev, "failed to init CSQ, ret = %d.\n", ret);
> 
> This print can be seen if hns_roce_alloc_cmq_desc fails, which can be
> due too OOM or dma error and in both cases, you will print message.
> 
> Thanks
> 

Thanks for the reminder, I will remove the print in hns_roce_alloc_cmq_desc().

Weihang

>>  
>>  	return ret;
>>  }
>> @@ -1319,7 +1275,6 @@ static void hns_roce_v2_cmq_exit(struct hns_roce_dev *hr_dev)
>>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>>  
>>  	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
>> -	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.crq);
>>  }
>>  
>>  static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index a2100a6..d168314 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -1731,7 +1731,6 @@ struct hns_roce_v2_cmq_ring {
>>  
>>  struct hns_roce_v2_cmq {
>>  	struct hns_roce_v2_cmq_ring csq;
>> -	struct hns_roce_v2_cmq_ring crq;
>>  	u16 tx_timeout;
>>  };
>>  
>> -- 
>> 2.7.4
>>
> 

