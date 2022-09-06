Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695E5AE64A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Sep 2022 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiIFLNW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiIFLNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 07:13:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3579A50
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 04:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A618B81694
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 11:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BCC433D7;
        Tue,  6 Sep 2022 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662462786;
        bh=G8Jq9uUzvPyXOQ42nTh+IEOFO1vhsNdrCONXaenJOwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IC/qubAAGC4K4D2tUJXZ4aW4KZNw/KIV7UTjRUk6RwoNEgdQ5S0r3FQZok0Vz6azG
         TTYVYXYCKK/1FDmkw4e/5s0ua9AQ0KAti/fW/tDrMshgArknzLxXlFoTrscBl1ibQI
         WlQotAYhNBLjP1wpVySv6iGiULioBQMzDXr8ayn1oI5wnzx1vO9a/h9WjyA+QQHPQw
         QUFkVOZWgZExS7jR6tLxw7gW5hKvzFp0CSBmccD2Ez9Y8ev9rWauEzS2msBC9EY02F
         Nh3bIs1QmFkSEmqlZJpIlUCxkrt1wLpSNBN8u9L/AXREjZpsVQ1d7IfqAnwbwu0Zq1
         Lop8pY198+bXA==
Date:   Tue, 6 Sep 2022 14:13:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] misc changes for rtrs
Message-ID: <YxcrPY7LGcna1+eM@unreal>
References: <20220902101922.26273-1-guoqing.jiang@linux.dev>
 <YxXrf1WKVwlDYgzm@unreal>
 <0a170dcd-3665-43d2-8467-7566333d0307@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a170dcd-3665-43d2-8467-7566333d0307@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 06, 2022 at 03:04:50PM +0800, Guoqing Jiang wrote:
> Hi Leon,
> 
> On 9/5/22 8:28 PM, Leon Romanovsky wrote:
> > On Fri, Sep 02, 2022 at 06:19:19PM +0800, Guoqing Jiang wrote:
> > > Hi,
> > > 
> > > Pls review the three patches.
> > > 
> > > Thanks,
> > > Guoqing
> > > 
> > > Guoqing Jiang (3):
> > >    RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
> > >    RDMA/rtrs-clt: Break the loop once one path is connected
> > >    RDMA/rtrs-clt: Kill xchg_paths
> > > 
> > >   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++-------------
> > >   drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
> > >   2 files changed, 8 insertions(+), 17 deletions(-)
> > The third patch still generates warnings.
> 
> Sorry, I didn't run sparse check, 😅.
> 
> > ➜  kernel git:(wip/leon-for-next) mkt ci
> > ^[[A^[[A^[[Ad9b137e23d31 (HEAD -> build) RDMA/rtrs-clt: Kill xchg_paths
> > WARNING: line length of 81 exceeds 80 columns
> > #43: FILE: drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:
> > +		if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, &clt_path, next))
> > 
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21: warning: incorrect type in initializer (different address spaces)
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    expected struct rtrs_clt_path [noderef] __rcu *__new
> > drivers/infiniband/ulp/rtrs/rtrs-clt.c:2297:21:    got struct rtrs_clt_path *[assigned] next
> 
> Before send new version, could you help to check whether the incremental
> change works or not? Otherwise let's drop the third one.

Thanks, it worked.

> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 0661a4e69fc9..bc3e1722e00d 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2294,7 +2294,8 @@ static void rtrs_clt_remove_path_from_arr(struct
> rtrs_clt_path *clt_path)
>                  * We race with IO code path, which also changes pointer,
>                  * thus we have to be careful not to overwrite it.
>                  */
> -               if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, clt_path,
> next))
> +               if (try_cmpxchg((struct rtrs_clt_path **)ppcpu_path,
> +                               clt_path, next))
>                         /*
>                          * @ppcpu_path was successfully replaced with @next,
>                          * that means that someone could also pick up the
> 
> Thanks,
> Guoqing
