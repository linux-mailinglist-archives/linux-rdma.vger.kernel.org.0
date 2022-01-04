Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD34844BA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiADPfF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 10:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiADPfF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 10:35:05 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB82C061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 07:35:05 -0800 (PST)
Message-ID: <e247c581-edd3-59b6-9e6f-a0301a84ec1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641310501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESkd+ffiQxGU91V7wPC2nVOlJH11PP1LTXt0jpx6mgI=;
        b=XieReC1eory4qr3xmuNsq/O1cQB2QGe3s9XBi3BFDDj1LqYgKx3wa+1QNj/5EmOLTxUblY
        wYMHWvyyq88sEQto9TXYzUIYjCvtMgMrf8szj/xBMqOygsXwhJsMCDVWWutPpllowBaE9E
        857Oo53hV5vHSITSdjiaAgsb3l49pH4=
Date:   Tue, 4 Jan 2022 23:34:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
 <06ce030593a4480694ee3d6d9be0ceda@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <06ce030593a4480694ee3d6d9be0ceda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/4 23:07, Saleem, Shiraz 写道:
>> Subject: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
>> get the source udp port number for a QP based on the grh.flow_label or
>> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues.
>> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
>> source port when set path") is a standard way. So it is also adopted in this
>> commit.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V2->V3: Move to the block of IB_QP_AV in the mask and IB_AH_GRH in
>> V2->ah_flags
>> V1->V2: Adopt a standard method to get udp source port.
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 8cd5f9261692..31039b295206 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device *ibdev,
>> u32 port, u16 index,
>>   	return 0;
>>   }
>>
>> +
>> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn) {
>> +	if (!fl)
>> +		fl = rdma_calc_flow_label(lqpn, rqpn);
>> +
>> +	return rdma_flow_label_to_udp_sport(fl); }
>> +
>>   /**
>>    * irdma_modify_qp_roce - modify qp request
>>    * @ibqp: qp's pointer for modify
>> @@ -1167,6 +1176,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct
>> ib_qp_attr *attr,
>>
>>   		memset(&iwqp->roce_ah, 0, sizeof(iwqp->roce_ah));
>>   		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
>> +			u32 fl = udp_info->flow_label;
>> +			u32 lqp = ibqp->qp_num;
>> +			u32 rqp = roce_info->dest_qp;
>> +
>> +			udp_info->src_port = irdma_get_udp_sport(fl, lqp, rqp);
> The flow label used in function is not right as udp_info->flow_label is only set a few lines below. Kindly fold this fix into your next revision.

Thanks.  " attr->ah_attr.grh.flow_label " should be OK.

Zhu Yanjun

>
>>   			udp_info->ttl = attr->ah_attr.grh.hop_limit;
>>   			udp_info->flow_label = attr->ah_attr.grh.flow_label;
>>   			udp_info->tos = attr->ah_attr.grh.traffic_class;
>> --
>> 2.27.0
