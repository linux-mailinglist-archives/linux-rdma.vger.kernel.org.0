Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525FA54DDB5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiFPI6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiFPI5y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 04:57:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83AE0E0;
        Thu, 16 Jun 2022 01:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5C1B822B1;
        Thu, 16 Jun 2022 08:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D075C34114;
        Thu, 16 Jun 2022 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369870;
        bh=BG70O5g6GPMqkDhXt6qLtoTqT4aP8gbFdNpo9dDiBRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xv/dG+6awDZDxO50LVU2PjPXiXPSHFP5Z38YlytK5g1LkiCKNTxjplasjDjSF0GyQ
         okDUG/chPwLUflE7DRroHW0pwqUJTM0IzM0P4yAb5gFfV8n/LLnC3VwWEPbswmm07W
         440BhuA7bJv3+EeLp78C65CEHu3QOTqfWcDQGAaBxPsS60l+CU283rx5Gejb+JNDv8
         308AmGD+5wlnbM1Q9VIvuS3uxsPbSvnPBo6V4Yq6/mbIy88QDlqgBAcEkcwmRFAy8/
         46VdlzkMPLM5GkjZcFtL+MFT56Q+fMtZ1hUzNn9VXDbqT9PgomEVVVXkDoXRfKtx6J
         phgxX/XNpYP9w==
Date:   Thu, 16 Jun 2022 11:57:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Message-ID: <YqrwibTkaDig+QfI@unreal>
References: <20220609070656.1446121-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609070656.1446121-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 09, 2022 at 03:06:56PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Currently rxe_alloc checks ret to indicate error, but 1 is also a valid
> return and just indicates that the allocation succeeded with a wrap.
> 
> Fix this by modifying the check to be < 0.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I applied same fix to rxe_alloc() and added Fixes line.

Thanks, applied.

> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 1cc8e847ccff..e9f3bbd8d605 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  
>  	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>  			      &pool->next, GFP_KERNEL);
> -	if (err)
> +	if (err < 0)
>  		goto err_cnt;
>  
>  	return 0;
> -- 
> 2.25.1
> 
