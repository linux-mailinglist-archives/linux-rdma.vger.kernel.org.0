Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC849D779
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 02:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiA0B3l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jan 2022 20:29:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17816 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiA0B3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jan 2022 20:29:41 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jkjdt5NNxz9sXD;
        Thu, 27 Jan 2022 09:28:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 09:29:39 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 09:29:38 +0800
Subject: Re: [PATCH for-next 3/4] RDMA/hns: Add support for QP's restrack
 attributes
To:     Leon Romanovsky <leon@kernel.org>
References: <20220124124624.55352-1-liangwenpeng@huawei.com>
 <20220124124624.55352-4-liangwenpeng@huawei.com> <Ye+0u54z7EBNJWJl@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <517f5e47-362c-ac88-dc78-3119ac46b0b8@huawei.com>
Date:   Thu, 27 Jan 2022 09:29:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Ye+0u54z7EBNJWJl@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/1/25 16:28, Leon Romanovsky wrote:
> On Mon, Jan 24, 2022 at 08:46:23PM +0800, Wenpeng Liang wrote:
>> The restrack attributes of QP come from the QPC and the queue information
>> maintained by the software code.
>>

I forgot to add the output of rdmatool in the commit message,
it will be added in the next version.

>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h   |   2 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  16 +--
>>  drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
>>  drivers/infiniband/hw/hns/hns_roce_restrack.c | 116 ++++++++++++++++++
>>  4 files changed, 128 insertions(+), 7 deletions(-)
> 
> <...>
> 
>> +	if (ret) {
>> +		dev_err(hr_dev->dev, "QUERY qpc cmd process error.\n");
> 
> ibdev_err(...) in all places.
> 

Thanks, I will fix this in v2.

>>  		goto out;
>> +	}
> 
> <...>
> 
>> +static int hns_roce_fill_qp(struct hns_roce_qp *hr_qp,
>> +			    struct sk_buff *msg,
>> +			    struct hns_roce_v2_qp_context *context)
>> +{
>> +	static struct {
>> +		char *name;
>> +		u32 mask;
>> +		u32 l;
>> +	} reg[] = {
>> +		{ "tst", HR_REG_CFG(QPC_TST) },
>> +		{ "qp_st", HR_REG_CFG(QPC_QP_ST) },
>> +		{ "chk_flg", HR_REG_CFG(QPC_CHECK_FLG) },
>> +		{ "err_type", HR_REG_CFG(QPC_ERR_TYPE) },
>> +		{ "srq_en", HR_REG_CFG(QPC_SRQ_EN) },
>> +		{ "srqn", HR_REG_CFG(QPC_SRQN) },
>> +		{ "qkey_xrcd", HR_REG_CFG(QPC_QKEY_XRCD) },
>> +		{ "tx_cqn", HR_REG_CFG(QPC_TX_CQN) },
>> +		{ "rx_cqn", HR_REG_CFG(QPC_RX_CQN) },
>> +		{ "sq_pi", HR_REG_CFG(QPC_SQ_PRODUCER_IDX) },
>> +		{ "sq_ci", HR_REG_CFG(QPC_SQ_CONSUMER_IDX) },
>> +		{ "rq_pi", HR_REG_CFG(QPC_RQ_PRODUCER_IDX) },
>> +		{ "rq_ci", HR_REG_CFG(QPC_RQ_CONSUMER_IDX) },
>> +		{ "sq_shift", HR_REG_CFG(QPC_SQ_SHIFT) },
>> +		{ "rqws", HR_REG_CFG(QPC_RQWS) },
>> +		{ "rq_shift", HR_REG_CFG(QPC_RQ_SHIFT) },
>> +		{ "sge_shift", HR_REG_CFG(QPC_SGE_SHIFT) },
>> +		{ "max_ird", HR_REG_CFG(QPC_SR_MAX) },
>> +		{ "max_ord", HR_REG_CFG(QPC_RR_MAX) },
>> +		{ "gmv_idx", HR_REG_CFG(QPC_GMV_IDX) },
>> +		{ "sq_vlan_en", HR_REG_CFG(QPC_SQ_VLAN_EN) },
>> +		{ "rq_vlan_en", HR_REG_CFG(QPC_RQ_VLAN_EN) },
>> +		{ "vlan_id", HR_REG_CFG(QPC_VLAN_ID) },
>> +		{ "mtu", HR_REG_CFG(QPC_MTU) },
>> +		{ "hop_limit", HR_REG_CFG(QPC_HOPLIMIT) },
>> +		{ "tc", HR_REG_CFG(QPC_TC) },
>> +		{ "fl", HR_REG_CFG(QPC_FL) },
>> +		{ "sl", HR_REG_CFG(QPC_SL) },
>> +		{ "rre", HR_REG_CFG(QPC_RRE) },
>> +		{ "rwe", HR_REG_CFG(QPC_RWE) },
>> +		{ "ate", HR_REG_CFG(QPC_ATE) },
>> +		{ "ext_ate", HR_REG_CFG(QPC_EXT_ATE) },
>> +		{ "fre", HR_REG_CFG(QPC_FRE) },
>> +		{ "rmt_e2e", HR_REG_CFG(QPC_RMT_E2E) },
>> +		{ "retry_num_init", HR_REG_CFG(QPC_RETRY_NUM_INIT) },
>> +		{ "retry_cnt", HR_REG_CFG(QPC_RETRY_CNT) },
>> +		{ "flush_idx", HR_REG_CFG(QPC_SQ_FLUSH_IDX) },
>> +		{ "sq_max_idx", HR_REG_CFG(QPC_SQ_MAX_IDX) },
>> +		{ "sq_tx_err", HR_REG_CFG(QPC_SQ_TX_ERR) },
>> +		{ "sq_rx_err", HR_REG_CFG(QPC_SQ_RX_ERR) },
>> +		{ "rq_rx_err", HR_REG_CFG(QPC_RQ_RX_ERR) },
>> +		{ "rq_tx_err", HR_REG_CFG(QPC_RQ_TX_ERR) },
>> +		{ "rq_cqeidx", HR_REG_CFG(QPC_RQ_CQE_IDX) },
>> +		{ "rq_rty_tx_err", HR_REG_CFG(QPC_RQ_RTY_TX_ERR) },
>> +	};
> 
> I have a feeling that this is abuse of our vendor specific attributes.
> Why don't you use RDMA_NLDEV_ATTR_RES_RAW for such huge dumps?
> 

I will reconsider the attributes that should be dumped. I will use
RDMA_NLDEV_ATTR_RES for key attributes and RDMA_NLDEV_ATTR_RES_RAW
for huge dumps.

Thanks
Wenpeng

> Thanks
> .
> 
