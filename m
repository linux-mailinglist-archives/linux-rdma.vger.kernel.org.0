Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5425DAB0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfGCBXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 21:23:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCBXv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 21:23:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x631NhV8023496;
        Wed, 3 Jul 2019 01:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7Nm9CSI5HR0hTGAjfQ61L0EQBsXNDp/GCS1+kHAU9io=;
 b=cG4HLmv5YpJ1GUANn4oCbrR1kZGewIFTjfm4QsKyFi8Mq1XJqbeBVTkxkjbyIpinynCv
 U0S8mXjmAu6bM+Ks7Dc6+A5Pz8LE0cu0ibgi5uWZ5xK9IwHwSg+CMm/IAa67XWidLiRN
 Iv+lnEcW5DRDUZ8Yln4NotoU5dqm9oSvAoCBHNi67+c+0l8DuDVuC3JpGBsB8iu8Q4u+
 wNYbEf1Y1FXJJntixnuhHL/9kHrtGoR8jEUOY0epE1HvCcOEG7ItH0F8xr232/54laff
 wucwBdV8fWy9pE3UH5nZOaJtAnsDz9mecMZ9+VMuBSxuAQTusykQ2tMac6IxvNZlH/mw NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbpn3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 01:23:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x631NGvM178318;
        Wed, 3 Jul 2019 01:23:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tebqgtx65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 01:23:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x631NdvE021882;
        Wed, 3 Jul 2019 01:23:39 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 18:23:39 -0700
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
To:     Konstantin Taranov <konstantin.taranov@inf.ethz.ch>,
        monis@mellanox.com
Cc:     linux-rdma@vger.kernel.org
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
Date:   Wed, 3 Jul 2019 09:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030017
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/6/27 22:06, Konstantin Taranov wrote:
> Make softRoce to calculate correct byte_len on receiving side when work completion
> is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
>
> According to documentation byte_len must indicate the number of written
> bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.

With roce NIC, what is the byte_len? Thanks a lot.

Zhu Yanjun

>
> The patch proposes to remember the length of an RDMA request from the RETH header, and use it
> as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
>
> Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index aca9f60f9b21..1cbfbd98eb22 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   			qp->resp.va = reth_va(pkt);
>   			qp->resp.rkey = reth_rkey(pkt);
>   			qp->resp.resid = reth_len(pkt);
> +			qp->resp.length = reth_len(pkt);
>   		}
>   		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
>   						     : IB_ACCESS_REMOTE_WRITE;
> @@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>   				pkt->mask & RXE_WRITE_MASK) ?
>   					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
>   		wc->vendor_err = 0;
> -		wc->byte_len = wqe->dma.length - wqe->dma.resid;
> +		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
> +				pkt->mask & RXE_WRITE_MASK) ?
> +					qp->resp.length : wqe->dma.length - wqe->dma.resid;
>   
>   		/* fields after byte_len are different between kernel and user
>   		 * space
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index e8be7f44e3be..28bfb3ece104 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -213,6 +213,7 @@ struct rxe_resp_info {
>   	struct rxe_mem		*mr;
>   	u32			resid;
>   	u32			rkey;
> +	u32			length;
>   	u64			atomic_orig;
>   
>   	/* SRQ only */
