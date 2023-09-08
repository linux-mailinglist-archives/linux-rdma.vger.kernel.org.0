Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAD79807F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 04:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjIHCWA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Sep 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbjIHCV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Sep 2023 22:21:59 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D01BD9;
        Thu,  7 Sep 2023 19:21:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vraere9_1694139710;
Received: from 30.221.108.114(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vraere9_1694139710)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 10:21:51 +0800
Message-ID: <70a9dc1a-b8b7-a85b-61e0-a540e819fc61@linux.alibaba.com>
Date:   Fri, 8 Sep 2023 10:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] RDMA/erdma: Fix error code in erdma_create_scatter_mtt()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1eb400d5-d8a3-4a8e-b3da-c43c6c377f86@moroto.mountain>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <1eb400d5-d8a3-4a8e-b3da-c43c6c377f86@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/6/23 7:23 PM, Dan Carpenter wrote:
> The erdma_create_scatter_mtt() function is supposed to return error
> pointers.  Returning NULL will lead to an Oops.
> 
> Fixes: ed10435d3583 ("RDMA/erdma: Implement hierarchical MTT")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Cheng Xu <chengyou@linux.alibaba.com>

Thanks very much!

Cheng Xu
