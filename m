Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3DE4C6B74
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 13:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiB1MBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 07:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiB1MBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 07:01:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174DD66620
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 04:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FF661037
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 12:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8871CC340E7;
        Mon, 28 Feb 2022 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646049666;
        bh=GKSlVM2ekh66YNznR+bHT6sB0onI9jmbyXstQtaKtL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gN1pq+IG1eRmdCCKT4wV9bxtFMpmubNqacXXxFBxNA9nfZC3FX7SCKGwdX7IiDIgJ
         Bc//A8Scey1Aoq47lz6XG7VogbIQBuM0C+AVCNpyRS1QoKk+leaE07W629n+vJENvY
         utcY15IKOGST+vfVaH+l6DlA2vltQyK3IcoqXL/FMSleNWWbiHKJL5KlSKlV1KGgfA
         L5NqTPFa0eQgQFEqjbfMGIYdKVa0xgWmjQV1ta25G7SzqwBVu3kuBaV3AdzhJP9STH
         vyFsqbItGfJgD8PtUVuYorRNc3/QPHh7wbOwqFiQVThnS2FLfRAf40/3659Z5nVm1b
         Ubm34dVfoO5ww==
Date:   Mon, 28 Feb 2022 14:01:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Use the reserved loopback QPs to free
 MR before destroying MPT
Message-ID: <Yhy5fZrsp79HZKR+@unreal>
References: <20220225095654.24684-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225095654.24684-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 05:56:54PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
> write operation per SL). Completing these loopback IOs represents that
> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 334 +++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
>  4 files changed, 358 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 1e0bae136997..da0b4b310aab 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -624,6 +624,7 @@ struct hns_roce_qp {
>  	u32			next_sge;
>  	enum ib_mtu		path_mtu;
>  	u32			max_inline_data;
> +	u8			free_mr_en;
>  
>  	/* 0: flush needed, 1: unneeded */
>  	unsigned long		flush_flag;
> @@ -882,6 +883,7 @@ struct hns_roce_hw {
>  			 enum ib_qp_state new_state);
>  	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
>  			 struct hns_roce_qp *hr_qp);
> +	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
>  	int (*init_eq)(struct hns_roce_dev *hr_dev);
>  	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
>  	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index b33e948fd060..62ee9c0bba74 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2664,6 +2664,217 @@ static void free_dip_list(struct hns_roce_dev *hr_dev)
>  	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
>  }
>  
> +static int free_mr_alloc_pd(struct hns_roce_dev *hr_dev,
> +			    struct hns_roce_v2_free_mr *free_mr)
> +{

You chose very non-intuitive name "free_mr...", but I don't have anything
concrete to suggest.

> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct ib_pd *pd;
> +
> +	pd = ib_alloc_pd(ibdev, 0);
> +	if (IS_ERR(pd)) {
> +		ibdev_err(ibdev, "failed to create pd for free mr.\n");
> +		return PTR_ERR(pd);
> +	}
> +
> +	free_mr->rsv_pd = pd;
> +	return 0;
> +}
> +
> +static int free_mr_create_cq(struct hns_roce_dev *hr_dev,
> +			     struct hns_roce_v2_free_mr *free_mr)
> +{
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct ib_cq_init_attr cq_init_attr = {};
> +	struct ib_cq *cq;
> +
> +	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
> +
> +	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_init_attr);
> +	if (IS_ERR(cq)) {
> +		ibdev_err(ibdev, "failed to create cq for free mr.\n");
> +		return PTR_ERR(cq);
> +	}
> +
> +	free_mr->rsv_cq = cq;
> +	return 0;
> +}
> +
> +static int free_mr_create_loopback_qp(struct hns_roce_dev *hr_dev,
> +				      struct hns_roce_v2_free_mr *free_mr,
> +				      int sl_num)
> +{
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct ib_qp_init_attr init_attr = {};
> +	struct ib_pd *pd = free_mr->rsv_pd;
> +	struct ib_cq *cq = free_mr->rsv_cq;
> +	struct ib_qp *qp;
> +
> +	init_attr.qp_type		= IB_QPT_RC;
> +	init_attr.sq_sig_type		= IB_SIGNAL_ALL_WR;
> +	init_attr.send_cq		= cq;
> +	init_attr.recv_cq		= cq;
> +	init_attr.cap.max_send_wr	= HNS_ROCE_FREE_MR_USED_SQWQE_NUM;
> +	init_attr.cap.max_send_sge	= HNS_ROCE_FREE_MR_USED_SQSGE_NUM;
> +	init_attr.cap.max_recv_wr	= HNS_ROCE_FREE_MR_USED_RQWQE_NUM;
> +	init_attr.cap.max_recv_sge	= HNS_ROCE_FREE_MR_USED_RQSGE_NUM;

No vertical alignment in new code, please.

> +
> +	qp = ib_create_qp(pd, &init_attr);
> +	if (IS_ERR(qp)) {
> +		ibdev_err(ibdev, "failed to create qp for free mr.\n");
> +		return PTR_ERR(qp);
> +	}
> +
> +	free_mr->rsv_qp[sl_num] = qp;
> +	return 0;
> +}
> +
> +static int free_mr_create_qp(struct hns_roce_dev *hr_dev,
> +			     struct hns_roce_v2_free_mr *free_mr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++)
> +		if (free_mr_create_loopback_qp(hr_dev, free_mr, i))
> +			return -ENOMEM;

Please don't overwrite returned error code - in all places.

> +
> +	return 0;
> +}
> +
> +static void free_mr_init_qp_attr(struct ib_qp_attr *attr)
> +{
> +	rdma_ah_set_grh(&attr->ah_attr, NULL, 0, 0, 1, 0);
> +	rdma_ah_set_static_rate(&attr->ah_attr, 3);
> +	rdma_ah_set_port_num(&attr->ah_attr, 1);
> +}
> +
> +static int free_mr_modify_loopback_qp(struct hns_roce_dev *hr_dev,
> +				      struct ib_qp_attr *attr, int sl_num)
> +{
> +	struct hns_roce_v2_priv *priv = hr_dev->priv;
> +	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct hns_roce_qp *hr_qp;
> +	int loopback;
> +	int mask;
> +	int ret;
> +
> +	hr_qp = to_hr_qp(free_mr->rsv_qp[sl_num]);
> +	hr_qp->free_mr_en = 1;
> +
> +	mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_ACCESS_FLAGS;
> +	attr->qp_state		= IB_QPS_INIT;
> +	attr->port_num		= 1;
> +	attr->qp_access_flags	= IB_ACCESS_REMOTE_WRITE;
> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to modify qp to init, ret = %d.\n",
> +			  ret);
> +		return ret;
> +	}
> +
> +	loopback = hr_dev->loop_idc;
> +	/* Set qpc lbi = 1 incidate loopback IO */
> +	hr_dev->loop_idc = 1;
> +
> +	mask = IB_QP_STATE | IB_QP_AV | IB_QP_PATH_MTU | IB_QP_DEST_QPN |
> +	       IB_QP_RQ_PSN | IB_QP_MAX_DEST_RD_ATOMIC | IB_QP_MIN_RNR_TIMER;
> +	attr->qp_state		= IB_QPS_RTR;
> +	attr->ah_attr.type	= RDMA_AH_ATTR_TYPE_ROCE;
> +	attr->path_mtu		= IB_MTU_256;
> +	attr->dest_qp_num	= hr_qp->qpn;
> +	attr->rq_psn		= HNS_ROCE_FREE_MR_USED_PSN;
> +
> +	rdma_ah_set_sl(&attr->ah_attr, (u8)sl_num);
> +
> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
> +	hr_dev->loop_idc = loopback;
> +	if (ret) {
> +		ibdev_err(ibdev, "failed to modify qp to rtr, ret = %d.\n",
> +			  ret);
> +		return ret;
> +	}
> +
> +	mask = IB_QP_STATE | IB_QP_SQ_PSN | IB_QP_RETRY_CNT | IB_QP_TIMEOUT |
> +	       IB_QP_RNR_RETRY | IB_QP_MAX_QP_RD_ATOMIC;
> +	attr->qp_state		= IB_QPS_RTS;
> +	attr->sq_psn		= HNS_ROCE_FREE_MR_USED_PSN;
> +	attr->retry_cnt		= HNS_ROCE_FREE_MR_USED_QP_RETRY_CNT;
> +	attr->timeout		= HNS_ROCE_FREE_MR_USED_QP_TIMEOUT;
> +	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
> +	if (ret)
> +		ibdev_err(ibdev, "failed to modify qp to rts, ret = %d.\n",
> +			  ret);
> +
> +	return ret;
> +}
> +
> +static int free_mr_modify_qp(struct hns_roce_dev *hr_dev,
> +			     struct hns_roce_v2_free_mr *free_mr)
> +{
> +	struct ib_qp_attr attr = {};
> +	int ret;
> +	int i;
> +
> +	free_mr_init_qp_attr(&attr);
> +
> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
> +		ret = free_mr_modify_loopback_qp(hr_dev, &attr, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void free_mr_exit(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_v2_priv *priv = hr_dev->priv;
> +	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
> +		if (free_mr->rsv_qp[i]) {
> +			(void)ib_destroy_qp(free_mr->rsv_qp[i]);

Please don't cast. It is not kernel coding style.

Thanks
