Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D12CEBD3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLDKFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 05:05:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8653 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDKFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 05:05:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnSwn269Kz15Xq7;
        Fri,  4 Dec 2020 18:04:25 +0800 (CST)
Received: from [10.40.203.251] (10.40.203.251) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 18:03:59 +0800
Subject: Re: [PATCH for-next 03/11] RDMA/hns: Do shift on traffic class of UD
 SQ WQE
To:     Weihang Li <liweihang@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
 <1606899553-54592-4-git-send-email-liweihang@huawei.com>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <13aca8fb-8171-b5ca-ec58-540bb36a8512@huawei.com>
Date:   Fri, 4 Dec 2020 18:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1606899553-54592-4-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/12/2 16:59, Weihang Li wrote:
> The high 6 bits of traffic class in GRH is DSCP (Differentiated Services
> Codepoint), the driver should shift it before the hardware gets it. In
> addition, there is no need to check whether it's RoCEv2 when filling TC
> into QPC because the DSCP field is meaningless for RoCEv1.

I think the high 6 bits of DSCP are valid for ROCEv2, and the entire 8 
bits are valid for ROCEv1.

> 
> Fixes: 606bf89e98ef ("RDMA/hns: Refactor for hns_roce_v2_modify_qp function")
> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++--------
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index a5c6bb0..1981501 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -119,6 +119,8 @@
>   
>   #define HNS_ROCE_QP_BANK_NUM 8
>   
> +#define DSCP_SHIFT 2
> +
>   /* The chip implementation of the consumer index is calculated
>    * according to twice the actual EQ depth
>    */
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 8d37067..13c8a2c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -430,7 +430,8 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
>   	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
>   		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
>   	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
> -		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
> +		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S,
> +		       ah->av.tclass >> DSCP_SHIFT);
>   	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
>   		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
>   	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
> @@ -4596,15 +4597,11 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
>   	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
>   		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
>   
> -	if (is_udp)
> -		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
> -			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
> -	else
> -		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
> -			       V2_QPC_BYTE_24_TC_S, grh->traffic_class);
> -
> +	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
> +		       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> DSCP_SHIFT);
>   	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
>   		       V2_QPC_BYTE_24_TC_S, 0);
> +
>   	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
>   		       V2_QPC_BYTE_28_FL_S, grh->flow_label);
>   	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
> 
