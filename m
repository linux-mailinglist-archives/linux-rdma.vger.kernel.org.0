Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634267A5A8E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjISHJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjISHJw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:09:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9603102
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 00:09:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092AEC433C7;
        Tue, 19 Sep 2023 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695107385;
        bh=lhbjxi25R8whwqcTrfh+GNi7zYB312ueNu55MvDJdGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdcX8I3WEsMOO67TgWl5P9tJbuRLVR6lrxgasHQTUk4X3UjhwphWPVEMPCwNNzyaS
         UQH2C0ELe8pq7hTiILI1Xg+yuLaNoGK/IPeOGXQxUMxgurIrnDw4JenwkgAJSXEJkZ
         s6RHWT1HspfKdhypfamhzr2pguy5N4CIyBrDFuE8+rNZe+v0e6XeiT7NXDZBUvM1lz
         R6O0GNQN0+abDIh4UsarC3EvELSv+sWZ9u7otHOvopy3n6036DFF17A46Ec7RBNdq0
         IC8rLnDQJcES+HRoVF3A1SflSSb4MHTVhRAGeRRLe8DRQLdEgcknnidwMkvMublzGK
         wQFjHNOduKsRQ==
Date:   Tue, 19 Sep 2023 10:09:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
Message-ID: <20230919070941.GA4494@unreal>
References: <20230918153646.338878-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918153646.338878-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 11:36:46PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> No functional change. The function get_next_path_rr needs to hold
> rcu_read_lock. As such, if no rcu read lock, warnings will pop out.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index b6ee801fd0ff..bc4b70318bf4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -775,7 +775,7 @@ rtrs_clt_get_next_path_or_null(struct list_head *head, struct rtrs_clt_path *clt
>   * Related to @MP_POLICY_RR
>   *
>   * Locks:
> - *    rcu_read_lock() must be hold.
> + *    rcu_read_lock() must be held.
>   */
>  static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
>  {
> @@ -783,6 +783,11 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
>  	struct rtrs_clt_path *path;
>  	struct rtrs_clt_sess *clt;
>  
> +	/*
> +	 * Assert that rcu lock must be held
> +	 */
> +	WARN_ON_ONCE(!rcu_read_lock_held());

Let's use RCU_LOCKDEP_WARN(..) macro.

Thanks

> +
>  	clt = it->clt;
>  
>  	/*
> -- 
> 2.40.1
> 
