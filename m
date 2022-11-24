Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4A6377E4
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 12:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKXLr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 06:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKXLrw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 06:47:52 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3CE6141
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 03:47:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVb4xBQ_1669290467;
Received: from 30.221.97.241(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VVb4xBQ_1669290467)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 19:47:48 +0800
Message-ID: <454a1ab7-6963-d03d-e548-cd9debc49f5d@linux.alibaba.com>
Date:   Thu, 24 Nov 2022 19:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH for-rc] RDMA/erdma: Fix a typo in annotation
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20221124033016.64181-1-chengyou@linux.alibaba.com>
In-Reply-To: <20221124033016.64181-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please ignore this patch, because it has a mistake: 
UTF-8 -> ASCII. I will send v2.

On 11/24/22 11:30 AM, Cheng Xu wrote:
> A non-UTF-8 character was wrongly put in annotation, which should be
> removed.
> 
> Fixes: bee85e0e31ec ("RDMA/erdma: Add main include file")
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index bb23d897c710..35726f25a989 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -219,7 +219,7 @@ struct erdma_dev {
>  	DECLARE_BITMAP(sdb_page, ERDMA_DWQE_TYPE0_CNT);
>  	/*
>  	 * We provide max 496 uContexts that each has one SQ normal Db,
> -	 * and one directWQE db。
> +	 * and one directWQE db.
>  	 */
>  	DECLARE_BITMAP(sdb_entry, ERDMA_DWQE_TYPE1_CNT);
>  
