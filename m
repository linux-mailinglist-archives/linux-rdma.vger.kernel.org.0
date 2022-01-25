Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9E49AE07
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiAYIau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:30:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48848 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359160AbiAYI2t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:28:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD1561315
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jan 2022 08:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80CDC340E0;
        Tue, 25 Jan 2022 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643099327;
        bh=qt8E5DnDi97faJcwtVNJtwgpQD49T6dKNA5QEzr01ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WT+z/XuNbDqm1tMhv/y8UxoPhcacrPO20fPxWRlzftK/TtFVJ/AKeEp7KZOxpmB80
         tS3zQQSEVmRGbkG81LNGeKKCDaeDUjHA9UQfrfhQYe0rLVVzJc6eAsT9bGGSjUlZis
         5/tAk5GC/iguYHV9TFVJMLZf2EfFdAq2Hr+EoFch+ujXFW9o+kWNvMcAfmKzWy1CyD
         nqz3KMvgnx5mCe9EDm6o2rFpFZyB7xCgYwZ8m9gz81KEWvMtbxZGSLwZfBX90iIR9x
         EvxJ2WpQIGYeoEEndcVlbGusHGVdFPjKii7WLJGmpBf4EPT/3JuVWJz07DjHRVXmJ5
         0zwVfiH2i0M4g==
Date:   Tue, 25 Jan 2022 10:28:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/4] RDMA/hns: Add support for QP's restrack
 attributes
Message-ID: <Ye+0u54z7EBNJWJl@unreal>
References: <20220124124624.55352-1-liangwenpeng@huawei.com>
 <20220124124624.55352-4-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124124624.55352-4-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 08:46:23PM +0800, Wenpeng Liang wrote:
> The restrack attributes of QP come from the QPC and the queue information
> maintained by the software code.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h   |   2 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  16 +--
>  drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
>  drivers/infiniband/hw/hns/hns_roce_restrack.c | 116 ++++++++++++++++++
>  4 files changed, 128 insertions(+), 7 deletions(-)

<...>

> +	if (ret) {
> +		dev_err(hr_dev->dev, "QUERY qpc cmd process error.\n");

ibdev_err(...) in all places.

>  		goto out;
> +	}

<...>

> +static int hns_roce_fill_qp(struct hns_roce_qp *hr_qp,
> +			    struct sk_buff *msg,
> +			    struct hns_roce_v2_qp_context *context)
> +{
> +	static struct {
> +		char *name;
> +		u32 mask;
> +		u32 l;
> +	} reg[] = {
> +		{ "tst", HR_REG_CFG(QPC_TST) },
> +		{ "qp_st", HR_REG_CFG(QPC_QP_ST) },
> +		{ "chk_flg", HR_REG_CFG(QPC_CHECK_FLG) },
> +		{ "err_type", HR_REG_CFG(QPC_ERR_TYPE) },
> +		{ "srq_en", HR_REG_CFG(QPC_SRQ_EN) },
> +		{ "srqn", HR_REG_CFG(QPC_SRQN) },
> +		{ "qkey_xrcd", HR_REG_CFG(QPC_QKEY_XRCD) },
> +		{ "tx_cqn", HR_REG_CFG(QPC_TX_CQN) },
> +		{ "rx_cqn", HR_REG_CFG(QPC_RX_CQN) },
> +		{ "sq_pi", HR_REG_CFG(QPC_SQ_PRODUCER_IDX) },
> +		{ "sq_ci", HR_REG_CFG(QPC_SQ_CONSUMER_IDX) },
> +		{ "rq_pi", HR_REG_CFG(QPC_RQ_PRODUCER_IDX) },
> +		{ "rq_ci", HR_REG_CFG(QPC_RQ_CONSUMER_IDX) },
> +		{ "sq_shift", HR_REG_CFG(QPC_SQ_SHIFT) },
> +		{ "rqws", HR_REG_CFG(QPC_RQWS) },
> +		{ "rq_shift", HR_REG_CFG(QPC_RQ_SHIFT) },
> +		{ "sge_shift", HR_REG_CFG(QPC_SGE_SHIFT) },
> +		{ "max_ird", HR_REG_CFG(QPC_SR_MAX) },
> +		{ "max_ord", HR_REG_CFG(QPC_RR_MAX) },
> +		{ "gmv_idx", HR_REG_CFG(QPC_GMV_IDX) },
> +		{ "sq_vlan_en", HR_REG_CFG(QPC_SQ_VLAN_EN) },
> +		{ "rq_vlan_en", HR_REG_CFG(QPC_RQ_VLAN_EN) },
> +		{ "vlan_id", HR_REG_CFG(QPC_VLAN_ID) },
> +		{ "mtu", HR_REG_CFG(QPC_MTU) },
> +		{ "hop_limit", HR_REG_CFG(QPC_HOPLIMIT) },
> +		{ "tc", HR_REG_CFG(QPC_TC) },
> +		{ "fl", HR_REG_CFG(QPC_FL) },
> +		{ "sl", HR_REG_CFG(QPC_SL) },
> +		{ "rre", HR_REG_CFG(QPC_RRE) },
> +		{ "rwe", HR_REG_CFG(QPC_RWE) },
> +		{ "ate", HR_REG_CFG(QPC_ATE) },
> +		{ "ext_ate", HR_REG_CFG(QPC_EXT_ATE) },
> +		{ "fre", HR_REG_CFG(QPC_FRE) },
> +		{ "rmt_e2e", HR_REG_CFG(QPC_RMT_E2E) },
> +		{ "retry_num_init", HR_REG_CFG(QPC_RETRY_NUM_INIT) },
> +		{ "retry_cnt", HR_REG_CFG(QPC_RETRY_CNT) },
> +		{ "flush_idx", HR_REG_CFG(QPC_SQ_FLUSH_IDX) },
> +		{ "sq_max_idx", HR_REG_CFG(QPC_SQ_MAX_IDX) },
> +		{ "sq_tx_err", HR_REG_CFG(QPC_SQ_TX_ERR) },
> +		{ "sq_rx_err", HR_REG_CFG(QPC_SQ_RX_ERR) },
> +		{ "rq_rx_err", HR_REG_CFG(QPC_RQ_RX_ERR) },
> +		{ "rq_tx_err", HR_REG_CFG(QPC_RQ_TX_ERR) },
> +		{ "rq_cqeidx", HR_REG_CFG(QPC_RQ_CQE_IDX) },
> +		{ "rq_rty_tx_err", HR_REG_CFG(QPC_RQ_RTY_TX_ERR) },
> +	};

I have a feeling that this is abuse of our vendor specific attributes.
Why don't you use RDMA_NLDEV_ATTR_RES_RAW for such huge dumps?

Thanks
