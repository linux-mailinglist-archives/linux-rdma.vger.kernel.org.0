Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC45547C0EF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhLUNnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhLUNnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 08:43:24 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75CC061574
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 05:43:24 -0800 (PST)
Message-ID: <bc714a05-4b44-2e0f-46ec-26c0969e2624@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640094202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKMTXeFUC4DPKZgN3iiWJ5FBYPLb1tFXlM3PBXc8sYI=;
        b=ZaYHOjevf+h8SrLTgLj0dDIk8HDmjlrSSH9mDVp3aNqF+7/W7AEw7icd2yWJgkw/GJJuJM
        mPOlDRcSG7PF4yGHkqQtLNh9Uc8D16Isyg0rwUHJS6ZSrznkrlsIHOvT04Vnwp0IaVuCbh
        vJRNZO85zCDYihNg9909+ZVO6/paXuc=
Date:   Tue, 21 Dec 2021 21:43:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Mark Zhang <markzhang@nvidia.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
 <d76dfbd5-5812-85b8-7d70-c93c3bce3fe1@nvidia.com>
 <d2de2fb5-d2f2-f47c-34de-1d519d021c2d@linux.dev>
 <e441cd2204474035aa040053b0dfcfcd@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <e441cd2204474035aa040053b0dfcfcd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/12/21 1:54, Saleem, Shiraz 写道:
>> Subject: Re: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
>>
>>
>> 在 2021/12/19 15:11, Mark Zhang 写道:
>>> On 12/19/2021 4:44 AM, yanjun.zhu@linux.dev wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> Based on the link
>>>> https://www.spinics.net/lists/linux-rdma/msg73735.html,
>>>> get the source udp port number for a QP based on the grh.flow_label
>>>> or lqpn/rqpn. This provides a better spread of traffic across NIC RX
>>>> queues.
>>>> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
>>>> source port when set path") is a standard way. So it is also adopted
>>>> in this commit.
>>>>
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>> V1->V2: Adopt a standard method to get udp source port.
>>>> ---
>>>>    drivers/infiniband/hw/irdma/verbs.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/hw/irdma/verbs.c
>>>> b/drivers/infiniband/hw/irdma/verbs.c
>>>> index 8cd5f9261692..9fe73d1db0d9 100644
>>>> --- a/drivers/infiniband/hw/irdma/verbs.c
>>>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>>>> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device
>>>> *ibdev, u32 port, u16 index,
>>>>           return 0;
>>>>    }
>>>>
>>>> +
>>>> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn) {
>>>> +       if (!fl)
>>>> +               fl = rdma_calc_flow_label(lqpn, rqpn);
>>>> +
>>>> +       return rdma_flow_label_to_udp_sport(fl); }
>>>> +
>>>>    /**
>>>>     * irdma_modify_qp_roce - modify qp request
>>>>     * @ibqp: qp's pointer for modify
>>>> @@ -1159,6 +1168,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp,
>>>> struct ib_qp_attr *attr,
>>>>
>>>>           ctx_info->roce_info->pd_id = iwpd->sc_pd.pd_id;
>>>>
>>>> +       udp_info->src_port =
>>>> +irdma_get_udp_sport(udp_info->flow_label,
>>>> + ibqp->qp_num,
>>>> + roce_info->dest_qp);
>>>> +
>>>
>>> FYI that in mlx5 driver the udp_sport is only set when address vector
>>> and dest qpn (IB_QP_AV and IB_QP_DEST_QPN) is provided.
>>
>> Sure. From my tests, when this function irdma_get_udp_sport is called, dest qpn
>> is ready.
>>
> 
> I think this needs to move to when we have IB_QP_AV in the mask and IB_AH_GRH in ah_flags.
> 
> So, in this block,
> https://elixir.bootlin.com/linux/v5.16-rc6/source/drivers/infiniband/hw/irdma/verbs.c#L1171

Thanks. The latest patch has been sent following your suggestions.

Zhu Yanjun

> 
> Shiraz

