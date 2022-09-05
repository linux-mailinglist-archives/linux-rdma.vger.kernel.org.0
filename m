Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1E5AD247
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiIEMWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiIEMWR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E44B0FE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B5E6124E
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 12:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42933C433D6;
        Mon,  5 Sep 2022 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662380535;
        bh=F/yyGB/eHIGHjXSQBp8R2F7QVH9cuPFSn/tGIi0HwLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oexk4IyqFme5JU80J281t3oFZY24n+OiNph0Xkgp0zDrqryg830xTrJE30jUdt3QA
         YRG25XX5bWDcOP5twd4DLnLGuOzNxynpXMP0TNOTcJuo+pcl0AfZm0RwrGZ0mhVVCF
         /m2/duLZQPZU1YPjO1e0Tvk2l3yO6ZNWAsDHtRXyBLjNdnsgkSfK3g8Yoq5AIr7lxL
         /15CqsvX7VMft4YfefBJfP8g+o6faFvxFgXdIFJRgndOs0lDUSFTVlYqI6slzXZYO1
         9KiYXZWlkOUqvIulUmWeOJOqdwW9EemYGJtNErnZXJfi1gKQIgO/pJulXqyarozKLs
         KDOnO+U+IuC2A==
Date:   Mon, 5 Sep 2022 15:22:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v6] RDMA/rxe: Fix pd ref counting in rxe mr verbs.
Message-ID: <YxXp881mL206z43P@unreal>
References: <20220901200426.3236-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901200426.3236-1-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 03:04:27PM -0500, Bob Pearson wrote:
> Move referencing pd in mr objects ahead of any possible errors
> so that it will always be set in rxe_mr_complete() to avoid
> seg faults when rxe_put(mr_pd(mr)) is called. Adjust the reference
> counts so that each call to rxe_mr_init_xxx() takes one reference.
> This reference count is dropped in rxe_mr_cleanup() in error paths
> in the reg mr verbs and the dereg mr verb. Minor white space cleanups.
> 
> These errors have been seen in rxe_mr_init_user() when there isn't
> enough memory to create the mr maps. Previously the error return
> path didn't reach setting ibpd in mr->ibmr which caused a seg fault.
> 
> Fixes: 364e282c4fe7e ("RDMA/rxe: Split MEM into MR and MW")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v6:
>   Separated from other patch in original series and resubmitted
>   rebased to current for-rc.
>   Renamed from "RDMA/rxe: Set pd early in mr alloc routines" to
>   "RDMA/rxe: Fix pd ref counting in rxe mr verbs"
>   Added more text to describe the change.
>   Added fixes line.
>   Simplified the patch by leaving pd code in rxe_mr.c instead of
>   moving it up to rxe_verbs.c
> v5:
>   Dropped cleanup code from patch per Li Zhijian.
>   Split up into two small patches.
> v4:
>   Added set mr->ibmr.pd back to avoid an -ENOMEM error causing
>   rxe_put(mr_pd(mr)); to seg fault in rxe_mr_cleanup() since pd
>   is not getting set in the error path.
> v3:
>   Rebased to apply to current for-next after
>   	Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
> v2:
>   Moved setting mr->umem until after checks to avoid sending
>   an ERR_PTR to ib_umem_release().
>   Cleaned up umem and map sets if errors occur in alloc mr calls.
>   Rebased to current for-next.
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 24 ++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 27 +++++++--------------------
>  2 files changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 850b80f5ad8b..5f4daffccb40 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -107,7 +107,9 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>  {
>  	rxe_mr_init(access, mr);
>  
> +	rxe_get(pd);

rxe_get() can fail, why don't you check for failure here and in all
places?

Thanks
