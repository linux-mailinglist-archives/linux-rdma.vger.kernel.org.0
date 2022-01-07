Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBED94876C6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiAGLuG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 06:50:06 -0500
Received: from out0.migadu.com ([94.23.1.103]:23884 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347228AbiAGLuG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 06:50:06 -0500
Message-ID: <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641556204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5WThZnJQO5C+b08yYN6ANbZGBxI9tZquVifY6uQRgU=;
        b=fJR1Mgi3wqGAsCs5g19YfCq6KLTCiX6X/vNKQslJBUrc7uhlVuujRbIJB/yHd0dvyMR8Kj
        YDnyfj79E0JedzzcaVH/ayDe5Y3QFbqn/p4ZqNT1j+5nI4Ue5as30nUoHhQByCwZAqP4IB
        d4hzUhEM+u09tqE2jaWy/bIKxENaGmA=
Date:   Fri, 7 Jan 2022 19:49:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     Jason Gunthorpe <jgg@nvidia.com>, Xiao Yang <yangx.jy@fujitsu.com>,
        david.marchand@6wind.com
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220106004005.GA2913243@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/6 8:40, Jason Gunthorpe 写道:
> On Wed, Dec 29, 2021 at 11:44:38AM +0800, Xiao Yang wrote:
>> It's wrong to check the last packet by RXE_COMP_MASK because the flag
>> is to indicate if responder needs to generate a completion.
>>
>> Fixes: 9fcd67d1772c ("IB/rxe: increment msn only when completing a request")
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
> Bob/Zhu is this OK?

Add david.marchand@6wind.com.


 From the following from the commit log of 9fcd67d1772c ("IB/rxe: 
increment msn only when completing a request")

"

     Logically, the requester associates a sequential Send Sequence Number
     (SSN) with each WQE posted to the send queue. The SSN bears a one-
     to-one relationship to the MSN returned by the responder in each re-
     sponse packet. Therefore, when the requester receives a response, 
it in-
     terprets the MSN as representing the SSN of the most recent request
     completed by the responder to determine which send WQE(s) can be
     completed."

"

It seems that it does not mean to check the last packet. It means that 
it receives a MSN response.

Please David Marchand <david.marchand@6wind.com> to check this commit.

Thanks a lot.

Zhu Yanjun

>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index e8f435fa6e4d..380934e38923 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -814,6 +814,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>   			return RESPST_ERR_INVALIDATE_RKEY;
>>   	}
>>   
>> +	if (pkt->mask & RXE_END_MASK)
>> +		/* We successfully processed this new request. */
>> +		qp->resp.msn++;
>> +
>>   	/* next expected psn, read handles this separately */
>>   	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
>>   	qp->resp.ack_psn = qp->resp.psn;
>> @@ -821,11 +825,9 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>>   	qp->resp.opcode = pkt->opcode;
>>   	qp->resp.status = IB_WC_SUCCESS;
>>   
>> -	if (pkt->mask & RXE_COMP_MASK) {
>> -		/* We successfully processed this new request. */
>> -		qp->resp.msn++;
>> +	if (pkt->mask & RXE_COMP_MASK)
>>   		return RESPST_COMPLETE;
>> -	} else if (qp_type(qp) == IB_QPT_RC)
>> +	else if (qp_type(qp) == IB_QPT_RC)
>>   		return RESPST_ACKNOWLEDGE;
>>   	else
>>   		return RESPST_CLEANUP;
>> -- 
>> 2.25.1
>>
>>
>>
