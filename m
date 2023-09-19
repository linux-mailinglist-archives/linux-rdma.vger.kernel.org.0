Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238077A5C45
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjISIRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISIRX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 04:17:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C05102
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 01:17:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FCC433C9;
        Tue, 19 Sep 2023 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695111437;
        bh=mquyO41z5omb8+t4pPt4kt1PMw66nZpQyHLYDdSeXO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5X8UhfZ/5AC2ImBXR8m31fbiBl6O8wqGGe6exICDasbyYBSuQ3bxoF0V5nHTBxms
         yh2ROAqrhbWrpz+4A3aZAbkcEWLHFIUAEeAoO7AYZHo1tJ53kzdoafpUJ/c5Gq9S2L
         TdQWWa824v58tzxNe0t/YZCHsY0Vn3vJ0PHkFAC9CHe0Jym5MCKA09XyD6xhFeLDdp
         IY8gFUqVeBlXv+PygnhdtqM6ZiMTqQeikvugADsB4V3qdooIE3WyWaRKK0ozpbS6dL
         zJg7teSiq3SVbD0u/heoB7F0TJ/dSUbgQ1dpjcqTnTYr48VhOZQ/3uabRyoU8DhB+o
         LEfdHqNyrtsJw==
Date:   Tue, 19 Sep 2023 11:17:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Message-ID: <20230919081712.GD4494@unreal>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919020806.534183-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 19, 2023 at 10:08:06AM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> No functionality change. The variable which is not initialized fully
> will introduce potential risks.

Are you sure about not being initialized?

Thanks

> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index 3696f367ff51..d80edfffd2e4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
>  static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
>  		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
>  {
> -	struct ib_qp_init_attr init_attr = {NULL};
> +	struct ib_qp_init_attr init_attr = {};
>  	struct rdma_cm_id *cm_id = con->cm_id;
>  	int ret;
>  
> -- 
> 2.40.1
> 
