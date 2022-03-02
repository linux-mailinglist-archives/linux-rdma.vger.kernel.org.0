Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6566B4CA519
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiCBMpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 07:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiCBMpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 07:45:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3AA82D1A
        for <linux-rdma@vger.kernel.org>; Wed,  2 Mar 2022 04:44:50 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7v1H6jtRzdZqM;
        Wed,  2 Mar 2022 20:43:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 20:44:48 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Mar
 2022 20:44:48 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Use the reserved loopback QPs to free
 MR before destroying MPT
To:     Leon Romanovsky <leon@kernel.org>
References: <20220225095654.24684-1-liangwenpeng@huawei.com>
 <Yhy5fZrsp79HZKR+@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <0c14fac1-9448-7920-52fd-f353a8e7590f@huawei.com>
Date:   Wed, 2 Mar 2022 20:44:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Yhy5fZrsp79HZKR+@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/2/28 20:01, Leon Romanovsky wrote:
> On Fri, Feb 25, 2022 at 05:56:54PM +0800, Wenpeng Liang wrote:
>> From: Yixing Liu <liuyixing1@huawei.com>
>>
>> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
>> write operation per SL). Completing these loopback IOs represents that
>> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
>>
>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 334 +++++++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
>>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
>>  4 files changed, 358 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 1e0bae136997..da0b4b310aab 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -624,6 +624,7 @@ struct hns_roce_qp {
>>  	u32			next_sge;
>>  	enum ib_mtu		path_mtu;
>>  	u32			max_inline_data;
>> +	u8			free_mr_en;
>>  
>>  	/* 0: flush needed, 1: unneeded */
>>  	unsigned long		flush_flag;
>> @@ -882,6 +883,7 @@ struct hns_roce_hw {
>>  			 enum ib_qp_state new_state);
>>  	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
>>  			 struct hns_roce_qp *hr_qp);
>> +	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
>>  	int (*init_eq)(struct hns_roce_dev *hr_dev);
>>  	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
>>  	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index b33e948fd060..62ee9c0bba74 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -2664,6 +2664,217 @@ static void free_dip_list(struct hns_roce_dev *hr_dev)
>>  	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
>>  }
>>  
>> +static int free_mr_alloc_pd(struct hns_roce_dev *hr_dev,
>> +			    struct hns_roce_v2_free_mr *free_mr)
>> +{
> 
> You chose very non-intuitive name "free_mr...", but I don't have anything
> concrete to suggest.
> 

Thank you for your advice. There are two alternative names for this event,
which are DRAIN_RESIDUAL_WR or DRAIN_WR. It is hard to decide which one is
better. Could you give me some suggestions for the naming?

Thanks,
Wenpeng

>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct ib_pd *pd;
>> +
>> +	pd = ib_alloc_pd(ibdev, 0);
>> +	if (IS_ERR(pd)) {
>> +		ibdev_err(ibdev, "failed to create pd for free mr.\n");
>> +		return PTR_ERR(pd);
>> +	}
>> +
>> +	free_mr->rsv_pd = pd;
>> +	return 0;
>> +}
>> +
>> +static int free_mr_create_cq(struct hns_roce_dev *hr_dev,
>> +			     struct hns_roce_v2_free_mr *free_mr)
>> +{
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct ib_cq_init_attr cq_init_attr = {};
>> +	struct ib_cq *cq;
>> +
>> +	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
>> +
>> +	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_init_attr);
>> +	if (IS_ERR(cq)) {
>> +		ibdev_err(ibdev, "failed to create cq for free mr.\n");
>> +		return PTR_ERR(cq);
>> +	}
>> +
>> +	free_mr->rsv_cq = cq;
>> +	return 0;
>> +}
>> +
>> +static int free_mr_create_loopback_qp(struct hns_roce_dev *hr_dev,
>> +				      struct hns_roce_v2_free_mr *free_mr,
>> +				      int sl_num)
>> +{
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct ib_qp_init_attr init_attr = {};
>> +	struct ib_pd *pd = free_mr->rsv_pd;
>> +	struct ib_cq *cq = free_mr->rsv_cq;
>> +	struct ib_qp *qp;
>> +
>> +	init_attr.qp_type		= IB_QPT_RC;
>> +	init_attr.sq_sig_type		= IB_SIGNAL_ALL_WR;
>> +	init_attr.send_cq		= cq;
>> +	init_attr.recv_cq		= cq;
>> +	init_attr.cap.max_send_wr	= HNS_ROCE_FREE_MR_USED_SQWQE_NUM;
>> +	init_attr.cap.max_send_sge	= HNS_ROCE_FREE_MR_USED_SQSGE_NUM;
>> +	init_attr.cap.max_recv_wr	= HNS_ROCE_FREE_MR_USED_RQWQE_NUM;
>> +	init_attr.cap.max_recv_sge	= HNS_ROCE_FREE_MR_USED_RQSGE_NUM;
> 
> No vertical alignment in new code, please.
> 

Fix it in v2.

>> +
>> +	qp = ib_create_qp(pd, &init_attr);
>> +	if (IS_ERR(qp)) {
>> +		ibdev_err(ibdev, "failed to create qp for free mr.\n");
>> +		return PTR_ERR(qp);
>> +	}
>> +
>> +	free_mr->rsv_qp[sl_num] = qp;
>> +	return 0;
>> +}
>> +
>> +static int free_mr_create_qp(struct hns_roce_dev *hr_dev,
>> +			     struct hns_roce_v2_free_mr *free_mr)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++)
>> +		if (free_mr_create_loopback_qp(hr_dev, free_mr, i))
>> +			return -ENOMEM;
> 
> Please don't overwrite returned error code - in all places.
> 

The next version will be revised to the following form:

	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
		ret = free_mr_create_loopback_qp(hr_dev, free_mr, i);
		if (ret)
			return ret;
	}

>> +
>> +	return 0;
>> +}
>> +
>> +static void free_mr_init_qp_attr(struct ib_qp_attr *attr)
>> +{
>> +	rdma_ah_set_grh(&attr->ah_attr, NULL, 0, 0, 1, 0);
>> +	rdma_ah_set_static_rate(&attr->ah_attr, 3);
>> +	rdma_ah_set_port_num(&attr->ah_attr, 1);
>> +}
>> +
>> +static int free_mr_modify_loopback_qp(struct hns_roce_dev *hr_dev,
>> +				      struct ib_qp_attr *attr, int sl_num)
>> +{
>> +	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> +	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct hns_roce_qp *hr_qp;
>> +	int loopback;
>> +	int mask;
>> +	int ret;
>> +
>> +	hr_qp = to_hr_qp(free_mr->rsv_qp[sl_num]);
>> +	hr_qp->free_mr_en = 1;
>> +
>> +	mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_ACCESS_FLAGS;
>> +	attr->qp_state		= IB_QPS_INIT;
>> +	attr->port_num		= 1;
>> +	attr->qp_access_flags	= IB_ACCESS_REMOTE_WRITE;
>> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
>> +	if (ret) {
>> +		ibdev_err(ibdev, "failed to modify qp to init, ret = %d.\n",
>> +			  ret);
>> +		return ret;
>> +	}
>> +
>> +	loopback = hr_dev->loop_idc;
>> +	/* Set qpc lbi = 1 incidate loopback IO */
>> +	hr_dev->loop_idc = 1;
>> +
>> +	mask = IB_QP_STATE | IB_QP_AV | IB_QP_PATH_MTU | IB_QP_DEST_QPN |
>> +	       IB_QP_RQ_PSN | IB_QP_MAX_DEST_RD_ATOMIC | IB_QP_MIN_RNR_TIMER;
>> +	attr->qp_state		= IB_QPS_RTR;
>> +	attr->ah_attr.type	= RDMA_AH_ATTR_TYPE_ROCE;
>> +	attr->path_mtu		= IB_MTU_256;
>> +	attr->dest_qp_num	= hr_qp->qpn;
>> +	attr->rq_psn		= HNS_ROCE_FREE_MR_USED_PSN;
>> +
>> +	rdma_ah_set_sl(&attr->ah_attr, (u8)sl_num);
>> +
>> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
>> +	hr_dev->loop_idc = loopback;
>> +	if (ret) {
>> +		ibdev_err(ibdev, "failed to modify qp to rtr, ret = %d.\n",
>> +			  ret);
>> +		return ret;
>> +	}
>> +
>> +	mask = IB_QP_STATE | IB_QP_SQ_PSN | IB_QP_RETRY_CNT | IB_QP_TIMEOUT |
>> +	       IB_QP_RNR_RETRY | IB_QP_MAX_QP_RD_ATOMIC;
>> +	attr->qp_state		= IB_QPS_RTS;
>> +	attr->sq_psn		= HNS_ROCE_FREE_MR_USED_PSN;
>> +	attr->retry_cnt		= HNS_ROCE_FREE_MR_USED_QP_RETRY_CNT;
>> +	attr->timeout		= HNS_ROCE_FREE_MR_USED_QP_TIMEOUT;
>> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
>> +	if (ret)
>> +		ibdev_err(ibdev, "failed to modify qp to rts, ret = %d.\n",
>> +			  ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int free_mr_modify_qp(struct hns_roce_dev *hr_dev,
>> +			     struct hns_roce_v2_free_mr *free_mr)
>> +{
>> +	struct ib_qp_attr attr = {};
>> +	int ret;
>> +	int i;
>> +
>> +	free_mr_init_qp_attr(&attr);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
>> +		ret = free_mr_modify_loopback_qp(hr_dev, &attr, i);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void free_mr_exit(struct hns_roce_dev *hr_dev)
>> +{
>> +	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> +	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
>> +		if (free_mr->rsv_qp[i]) {
>> +			(void)ib_destroy_qp(free_mr->rsv_qp[i]);
> 
> Please don't cast. It is not kernel coding style.
> 

The next version will be revised to the following form

	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
		if (free_mr->rsv_qp[i]) {
			ret = ib_destroy_qp(free_mr->rsv_qp[i]);
			if (ret)
				ibdev_err(&hr_dev->ib_dev,
					  "failed to destroy qp in free mr.\n");

			free_mr->rsv_qp[i] = NULL;
		}
	}

Thanks,
Wenpeng

> Thanks
> .
> 
