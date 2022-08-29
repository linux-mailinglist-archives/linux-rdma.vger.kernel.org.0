Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC635A42A0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiH2Fvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Fvr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 01:51:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B65474E9
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 22:51:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNY3d8U_1661752301;
Received: from 30.43.104.226(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNY3d8U_1661752301)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 13:51:42 +0800
Message-ID: <b8737a5f-a72e-8377-3fcd-b06a9d552689@linux.alibaba.com>
Date:   Mon, 29 Aug 2022 13:51:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/29/22 1:44 PM, Daisuke Matsuda wrote:
> An incoming Read request causes multiple Read responses. If a user MR to
> copy data from is unavailable or responder cannot send a reply, then the
> error messages can be printed for each response attempt, resulting in
> message overflow.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..4b3e8aec2fb8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  
>  	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>  			  payload, RXE_FROM_MR_OBJ);
> -	if (err)
> -		pr_err("Failed copying memory\n");

The err is set but not used. Below is better:

-  	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
-  			  payload, RXE_FROM_MR_OBJ);
+	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
+		    payload, RXE_FROM_MR_OBJ);

Thanks,
Cheng Xu

>  	if (mr)
>  		rxe_put(mr);
>  
> @@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  	}
>  
>  	err = rxe_xmit_packet(qp, &ack_pkt, skb);
> -	if (err) {
> -		pr_err("Failed sending RDMA reply.\n");
> +	if (err)
>  		return RESPST_ERR_RNR;
> -	}
>  
>  	res->read.va += payload;
>  	res->read.resid -= payload;
