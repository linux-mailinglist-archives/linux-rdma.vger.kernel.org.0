Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4661871
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 01:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGGXfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 19:35:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGGXfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Jul 2019 19:35:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67NZ4LY032113;
        Sun, 7 Jul 2019 23:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Wb4/6DSCFrm4XFmnm5qi4jUDnV9GdwYE5Y6xHx6zSN0=;
 b=JR6fpA9nzo/5nTb1gN0brtG1cLcKekog/S579wBiH2RuBwGy226MzHLge9veSwOUqlv3
 r2CDJQCaUj9tFZyPSTCOg4eWCsCT7HEdUuAKjDvQ1DVtp7HRem1zkYF9sXqJahpGD0dL
 I4I1lsERjHRhdNwNx8eSWDWirpisQibWJMIU7dkDgHdCC0f0EznasCnj9gotFnflAccS
 12gTXTFWhTe+Yav00P6ymdmkVLL/4FW5PuMcK37alva0b8RJBd50wlf9nZJwJlXX7Ymj
 poJlQvlYZKZ4pyb7KZiXnO6MLMEIxNau/WpUzelIATqs/bSjqgI/F7uKXsfIHtgKz06e fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tjkkpbeht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 23:35:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67NXfMY188256;
        Sun, 7 Jul 2019 23:35:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tjkf1xe45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Jul 2019 23:35:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x67NZOOd005775;
        Sun, 7 Jul 2019 23:35:29 GMT
Received: from [192.168.1.8] (/221.221.53.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jul 2019 16:35:24 -0700
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
To:     Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
Cc:     monis@mellanox.com, linux-rdma@vger.kernel.org
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
 <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
 <20190707231126.774bdd6e@ktaranov-laptop>
From:   Zhu Yanjun <yanjun.zhu@oracle.com>
Message-ID: <a58291a3-8b04-49bf-6c10-202b8ba426ac@oracle.com>
Date:   Mon, 8 Jul 2019 07:35:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707231126.774bdd6e@ktaranov-laptop>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907070330
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907070331
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


ÔÚ 2019/7/8 5:23, Konstantin Taranov Ð´µÀ:
> On Wed, 3 Jul 2019 09:24:54 +0800
> Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
>
>> On 2019/6/27 22:06, Konstantin Taranov wrote:
>>> Make softRoce to calculate correct byte_len on receiving side when work completion
>>> is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
>>>
>>> According to documentation byte_len must indicate the number of written
>>> bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.
>> With roce NIC, what is the byte_len? Thanks a lot.
> byte_len is a field of a work completion (struct ib_uverbs_wc or struct ibv_wc). It is defined in verbs and stores
> the number of written bytes to the destination memory. In case of IB_WC_RECV_RDMA_WITH_IMM
> completion event, the field byte_len must store the number of written bytes for incoming
> RDMA_WRITE_WITH_IMM request.

Cool. Thanks for your explanations.

The above is the test result of physical RoCE NIC?

Thanks.

Zhu Yanjun

>
>> Zhu Yanjun
>>
>>> The patch proposes to remember the length of an RDMA request from the RETH header, and use it
>>> as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
>>>
>>> Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> index aca9f60f9b21..1cbfbd98eb22 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> @@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>>>    			qp->resp.va = reth_va(pkt);
>>>    			qp->resp.rkey = reth_rkey(pkt);
>>>    			qp->resp.resid = reth_len(pkt);
>>> +			qp->resp.length = reth_len(pkt);
>>>    		}
>>>    		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
>>>    						     : IB_ACCESS_REMOTE_WRITE;
>>> @@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>>>    				pkt->mask & RXE_WRITE_MASK) ?
>>>    					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
>>>    		wc->vendor_err = 0;
>>> -		wc->byte_len = wqe->dma.length - wqe->dma.resid;
>>> +		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
>>> +				pkt->mask & RXE_WRITE_MASK) ?
>>> +					qp->resp.length : wqe->dma.length - wqe->dma.resid;
>>>    
>>>    		/* fields after byte_len are different between kernel and user
>>>    		 * space
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index e8be7f44e3be..28bfb3ece104 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -213,6 +213,7 @@ struct rxe_resp_info {
>>>    	struct rxe_mem		*mr;
>>>    	u32			resid;
>>>    	u32			rkey;
>>> +	u32			length;
>>>    	u64			atomic_orig;
>>>    
>>>    	/* SRQ only */
