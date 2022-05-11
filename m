Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD46D522A81
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 05:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiEKDoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 23:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEKDoN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 23:44:13 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8499B183;
        Tue, 10 May 2022 20:44:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCu1bA1_1652240648;
Received: from 30.43.105.194(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VCu1bA1_1652240648)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 11:44:09 +0800
Message-ID: <b37c53a7-86df-0283-1a77-c31af108d39f@linux.alibaba.com>
Date:   Wed, 11 May 2022 11:44:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error
 requester state
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220511023030.229212-1-lizhijian@fujitsu.com>
 <20220511023030.229212-3-lizhijian@fujitsu.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220511023030.229212-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/11/22 10:30 AM, Li Zhijian wrote:
> SoftRoCE always returns success when user space is posting a new wqe where
> it usually just enqueues a wqe.
> 
> Once the requester state becomes QP_STATE_ERROR, we should generate error
> completion for all subsequent wqe. So the user is able to poll the
> completion event to check if the former wqe is handled correctly.
> 
> Here we check QP_STATE_ERROR after req_next_wqe() so that the completion
> can associate with its wqe.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 8bdd0b6b578f..ed6a486c4343 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -624,7 +624,7 @@ int rxe_requester(void *arg)
>   	rxe_get(qp);
>   
>   next_wqe:
> -	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
> +	if (unlikely(!qp->valid))
>   		goto exit;
>   
>   	if (unlikely(qp->req.state == QP_STATE_RESET)) {
> @@ -646,6 +646,14 @@ int rxe_requester(void *arg)
>   	if (unlikely(!wqe))
>   		goto exit;
>   
> +	if (qp->req.state == QP_STATE_ERROR) {
> +		/*
> +		 * Generate an error completion so that user space is able to
> +		 * poll this completion.
> +		 */
> +		goto err;
> +	}
> +

Should this still use unlikely(...) ? Because the original judgement has
a unlikely surrounded.

Cheng Xu

>   	if (wqe->mask & WR_LOCAL_OP_MASK) {
>   		ret = rxe_do_local_ops(qp, wqe);
>   		if (unlikely(ret))
