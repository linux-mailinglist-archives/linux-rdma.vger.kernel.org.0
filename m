Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874A8663F22
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjAJLQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAJLPd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 06:15:33 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773AF3F47F;
        Tue, 10 Jan 2023 03:15:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VZJ71lT_1673349316;
Received: from 30.221.98.170(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VZJ71lT_1673349316)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 19:15:17 +0800
Message-ID: <98478125-cdd7-69f2-69b6-74a7f1dd7783@linux.alibaba.com>
Date:   Tue, 10 Jan 2023 19:15:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH][next] RDMA/erdma: Replace zero-length arrays with
 flexible-array members
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <Y7zCBqwC1LtabRJ9@work>
Content-Language: en-US
In-Reply-To: <Y7zCBqwC1LtabRJ9@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/10/23 9:40 AM, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays, in a couple of structures, with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Cheng Xu <chengyou@linux.alibaba.com>

Thanks very much,
Cheng Xu


> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
> index ab371fec610c..4c38d99c73f1 100644
> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
> @@ -397,7 +397,7 @@ struct erdma_write_sqe {
>  
>  	__le32 rsvd;
>  
> -	struct erdma_sge sgl[0];
> +	struct erdma_sge sgl[];
>  };
>  
>  struct erdma_send_sqe {
> @@ -408,7 +408,7 @@ struct erdma_send_sqe {
>  	};
>  
>  	__le32 length;
> -	struct erdma_sge sgl[0];
> +	struct erdma_sge sgl[];
>  };
>  
>  struct erdma_readreq_sqe {
