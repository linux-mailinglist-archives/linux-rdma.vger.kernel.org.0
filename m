Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49F0479FE2
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 09:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhLSIUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Dec 2021 03:20:51 -0500
Received: from out0.migadu.com ([94.23.1.103]:62861 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhLSIUu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Dec 2021 03:20:50 -0500
Message-ID: <d2de2fb5-d2f2-f47c-34de-1d519d021c2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639902049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxKLxeeIJma8nRvgaxDmY4ZHu9JEVGadhI9dKFD530Y=;
        b=AOHUoEaEcQ9AAdRsA5drApP5JXKPu3iJ+5B+0NED9CLAOXSvLcKj4ZPXX3qReAAIcsZcLB
        O4pua1G1BrK58hdEhwoXCBbQyCZOCx0NSahDVMtukHfmc6+aS6B1tS63KD/HI2XlmwaVRN
        xjnhHKRYx1rlnsZrvxBsWYTYc+a3Aps=
Date:   Sun, 19 Dec 2021 16:20:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
To:     Mark Zhang <markzhang@nvidia.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
 <d76dfbd5-5812-85b8-7d70-c93c3bce3fe1@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <d76dfbd5-5812-85b8-7d70-c93c3bce3fe1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2021/12/19 15:11, Mark Zhang 写道:
> On 12/19/2021 4:44 AM, yanjun.zhu@linux.dev wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Based on the link 
>> https://www.spinics.net/lists/linux-rdma/msg73735.html,
>> get the source udp port number for a QP based on the grh.flow_label or
>> lqpn/rqpn. This provides a better spread of traffic across NIC RX 
>> queues.
>> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
>> source port when set path") is a standard way. So it is also adopted in
>> this commit.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V1->V2: Adopt a standard method to get udp source port.
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c 
>> b/drivers/infiniband/hw/irdma/verbs.c
>> index 8cd5f9261692..9fe73d1db0d9 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device 
>> *ibdev, u32 port, u16 index,
>>          return 0;
>>   }
>>
>> +
>> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
>> +{
>> +       if (!fl)
>> +               fl = rdma_calc_flow_label(lqpn, rqpn);
>> +
>> +       return rdma_flow_label_to_udp_sport(fl);
>> +}
>> +
>>   /**
>>    * irdma_modify_qp_roce - modify qp request
>>    * @ibqp: qp's pointer for modify
>> @@ -1159,6 +1168,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, 
>> struct ib_qp_attr *attr,
>>
>>          ctx_info->roce_info->pd_id = iwpd->sc_pd.pd_id;
>>
>> +       udp_info->src_port = irdma_get_udp_sport(udp_info->flow_label,
>> + ibqp->qp_num,
>> + roce_info->dest_qp);
>> +
>
> FYI that in mlx5 driver the udp_sport is only set when address vector
> and dest qpn (IB_QP_AV and IB_QP_DEST_QPN) is provided.

Sure. From my tests, when this function irdma_get_udp_sport is called,  
dest qpn is ready.

Zhu Yanjun

>
>>          if (attr_mask & IB_QP_AV) {
>>                  struct irdma_av *av = &iwqp->roce_ah.av;
>>                  const struct ib_gid_attr *sgid_attr;
>> -- 
>> 2.27.0
>>
>
