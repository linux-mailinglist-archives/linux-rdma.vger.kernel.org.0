Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6904D4C3593
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 20:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiBXTQg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiBXTQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 14:16:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603722BE9B;
        Thu, 24 Feb 2022 11:16:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CB1615BB;
        Thu, 24 Feb 2022 19:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2104C340E9;
        Thu, 24 Feb 2022 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730163;
        bh=qB8qemRRRaLkFJrye31RKyup6LLCc2VuCT44GCj/z9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAsw1TyCXxh22Ra0Cdql/3p8erSOEF7S/8LQWLSGrlKxIqe7IMAV8lizj7wYi8lyN
         f38J9oG7VvLvRGs3IABZfYUbpYJEBt7PdbrAiC3pXtew4NvBFBJ8kFx9UPHMqM9hfE
         VJH+gGFHCK9K7VK6grS4czn3Be+Xiw9EJPUB2V6IifJQKs1QWGXbzGrrDjH42UHHua
         uUFRTOb6fzvCDjs8Ugolwfqd/BnIJ07YqiIjTDROZcMgccTCKmZOqlenLTqBE2XNKk
         za4gq+CRLzwojfbHdCEujcqp9h7onLST6jWOkkwqjmbdlkIZ2MKizwY5Ma5jdWOLPs
         JEXzsibVVqUZQ==
Date:   Thu, 24 Feb 2022 21:15:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Remove unnecessary statements
Message-ID: <YhfZbgaz1Hec8xNG@unreal>
References: <20220223074901.201506-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223074901.201506-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 03:49:01PM +0800, Yajun Deng wrote:
> The rdma_zalloc_drv_obj() in __ib_alloc_pd() would zero pd, it unnecessary
> add NULL to the object in struct pd.
> 
> The uverbs_free_pd() already return busy if pd->usecnt is true, there is
> no need to add a warning.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/infiniband/core/verbs.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index e821dc94a43e..03bc9d34c13d 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -268,8 +268,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
>  		return ERR_PTR(-ENOMEM);
>  
>  	pd->device = device;
> -	pd->uobject = NULL;
> -	pd->__internal_mr = NULL;
>  	atomic_set(&pd->usecnt, 0);
^^^^^^^^ this line should be removed too.

>  	pd->flags = flags;
>  
> @@ -341,11 +339,6 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
>  		pd->__internal_mr = NULL;
>  	}
>  
> -	/* uverbs manipulates usecnt with proper locking, while the kabi
> -	 * requires the caller to guarantee we can't race here.
> -	 */
> -	WARN_ON(atomic_read(&pd->usecnt));
> -

ib_dealloc_pd_user() is called not only in uverbs_free_pd(), but in ib_dealloc_pd() too.
So commit message is not really correct.

Of course, ib_dealloc_pd() is kernel verb and doesn't use ->usecnt at all.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
