Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97FF6190B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGHB4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 21:56:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40302 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfGHB4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Jul 2019 21:56:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x681t9bl115921;
        Mon, 8 Jul 2019 01:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=m3qd6oEHUwG6qOic4yZ/JimABNvPi3n/CxRS7BWd6JQ=;
 b=Erkv6ElLNsOhNSu10C4mg+bA+VFlBCQ6gOq0nqt75EhUJjUHVEOgq6vSrYnLBNzhxR1D
 L9P2aoFhQYZf8wQRFs/tUKSMlCuzRISwYxue1IfXTwyzJtgWlgY/igdAb8szgwIM4RMF
 1d3SceVAIwCWYmdtaxfu5WxA3R0IMFOODwLXxlz9vmqu0ph60faoOFTtGwHQy6XGCoOA
 1Jx0zFUmJV1nMbtlOv1eESPYQ5LciH44D5//pNEHQ7k8za7lxX8EdLx/fo7bGFfv5onn
 PvIjhS56ityTyDBuGF3+IRIX53bkvIj2v5wc2jXXvZ0mfbjOMUjbXHubYPFXRiK2TZ3D Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkpbnh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 01:56:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x681rDtQ190844;
        Mon, 8 Jul 2019 01:56:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tjjyjyp2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 01:56:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x681u6dw001262;
        Mon, 8 Jul 2019 01:56:07 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jul 2019 18:56:06 -0700
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
To:     Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
Cc:     monis@mellanox.com, linux-rdma@vger.kernel.org
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
 <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
 <20190707231126.774bdd6e@ktaranov-laptop>
 <a58291a3-8b04-49bf-6c10-202b8ba426ac@oracle.com>
 <20190708034621.101b25dc@ktaranov-laptop>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <2850a772-1a91-07dd-eb01-8e6e4d8aa690@oracle.com>
Date:   Mon, 8 Jul 2019 09:57:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708034621.101b25dc@ktaranov-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080023
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/7/8 9:46, Konstantin Taranov wrote:
> On Mon, 8 Jul 2019 07:35:24 +0800
> Zhu Yanjun <yanjun.zhu@oracle.com> wrote:
>
>> 在 2019/7/8 5:23, Konstantin Taranov 写道:
>>> On Wed, 3 Jul 2019 09:24:54 +0800
>>> Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
>>>   
>>>> On 2019/6/27 22:06, Konstantin Taranov wrote:
>>>>> Make softRoce to calculate correct byte_len on receiving side when work completion
>>>>> is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
>>>>>
>>>>> According to documentation byte_len must indicate the number of written
>>>>> bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.
>>>> With roce NIC, what is the byte_len? Thanks a lot.
>>> byte_len is a field of a work completion (struct ib_uverbs_wc or struct ibv_wc). It is defined in verbs and stores
>>> the number of written bytes to the destination memory. In case of IB_WC_RECV_RDMA_WITH_IMM
>>> completion event, the field byte_len must store the number of written bytes for incoming
>>> RDMA_WRITE_WITH_IMM request.
>> Cool. Thanks for your explanations.
>>
>> The above is the test result of physical RoCE NIC?
>>
> Yes. When I use physical nics, the byte_len indicates the number of received bytes.
> It is also fully complies with what is written in https://www.rdmamojo.com/2013/02/15/ibv_poll_cq/ about the byte_len field.

Nice. I am fine with this patch.

Thanks a lot.

Zhu Yanjun

>   
>
>
>> Thanks.
>>
>> Zhu Yanjun
>>
>>>   
>>>> Zhu Yanjun
>>>>   
>>>>> The patch proposes to remember the length of an RDMA request from the RETH header, and use it
>>>>> as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
>>>>>
>>>>> Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
>>>>>     drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> index aca9f60f9b21..1cbfbd98eb22 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> @@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>>>     			qp->resp.va = reth_va(pkt);
>>>>>     			qp->resp.rkey = reth_rkey(pkt);
>>>>>     			qp->resp.resid = reth_len(pkt);
>>>>> +			qp->resp.length = reth_len(pkt);
>>>>>     		}
>>>>>     		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
>>>>>     						     : IB_ACCESS_REMOTE_WRITE;
>>>>> @@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>>>>>     				pkt->mask & RXE_WRITE_MASK) ?
>>>>>     					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
>>>>>     		wc->vendor_err = 0;
>>>>> -		wc->byte_len = wqe->dma.length - wqe->dma.resid;
>>>>> +		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
>>>>> +				pkt->mask & RXE_WRITE_MASK) ?
>>>>> +					qp->resp.length : wqe->dma.length - wqe->dma.resid;
>>>>>     
>>>>>     		/* fields after byte_len are different between kernel and user
>>>>>     		 * space
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> index e8be7f44e3be..28bfb3ece104 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> @@ -213,6 +213,7 @@ struct rxe_resp_info {
>>>>>     	struct rxe_mem		*mr;
>>>>>     	u32			resid;
>>>>>     	u32			rkey;
>>>>> +	u32			length;
>>>>>     	u64			atomic_orig;
>>>>>     
>>>>>     	/* SRQ only */
