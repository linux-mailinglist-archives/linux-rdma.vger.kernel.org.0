Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B15562D39
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiGAH6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiGAH6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 03:58:37 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FC1EEF4
        for <linux-rdma@vger.kernel.org>; Fri,  1 Jul 2022 00:58:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VI-kdn8_1656662308;
Received: from 30.15.205.111(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VI-kdn8_1656662308)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 15:58:29 +0800
Message-ID: <92e2fb9c-d0a0-79de-1788-7e15d3a5390f@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 15:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/3] RDMA/rxe: Generate error completion for error
 requester QP state
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <20220701061731.1582399-1-lizhijian@fujitsu.com>
 <20220701061731.1582399-3-lizhijian@fujitsu.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220701061731.1582399-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/1/22 2:10 PM, lizhijian@fujitsu.com wrote:
> As per IBTA specification, all subsequent WQEs while QP is in error
> state should be completed with a flush error.
> 
> Here we check QP_STATE_ERROR after req_next_wqe() so that rxe_completer()
> has chance to be called where it will set CQ state to FLUSH ERROR and the
> completion can associate with its WQE.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4: check QP ERROR before QP RESET # Bob
> V3: unlikely() optimization # Cheng Xu <chengyou@linux.alibaba.com>
>      update commit log # Haakon Bugge <haakon.bugge@oracle.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_req.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 4ffc4ebd6e28..7fdc8e6bf738 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -610,9 +610,22 @@ int rxe_requester(void *arg)
>   		return -EAGAIN;
>   
>   next_wqe:
> -	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
> +	if (unlikely(!qp->valid))
>   		goto exit;
>   
> +	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
> +		wqe = req_next_wqe(qp);
> +		if (wqe)
> +			/*
> +			 * Generate an error completion so that user space
> +			 * is able to poll this completion.
> +			 */
> +			goto err;
> +		else {
> +			goto exit;
> +		}
                ~~~
If I read it right, a single statement should not use parentheses.

Thanks,
Cheng Xu

> +	}
> +
>   	if (unlikely(qp->req.state == QP_STATE_RESET)) {
>   		qp->req.wqe_index = queue_get_consumer(q,
>   						QUEUE_TYPE_FROM_CLIENT);
