Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E14A8BAE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 19:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiBCSbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 13:31:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49444 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353508AbiBCSbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 13:31:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D06C1B8354A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Feb 2022 18:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B30C340E8;
        Thu,  3 Feb 2022 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643913060;
        bh=g8vx8z3RUVYut8h2G60SBOFs+GdB6QwqPaTWYT17Kx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ774HZlz6yHU6uflkDpKkgCXgzRhalrt49StmC6cuv01HvKbhKqLMLbwQuBFEYu6
         EtUUG1TYoi15VYmewGFygprbyMBcI+JbKTkf71ME2JYwEuY4W9HRJT6Zb1dhJJlEUw
         eATdEcPY0GSLh5aF9QVDT8+PtRezP/djc4/u2hEU=
Date:   Thu, 3 Feb 2022 19:30:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haimin Zhang <tcs.kernel@gmail.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        linux-rdma@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] RDMA/ucma: fix a kernel-infoleak in ucma_init_qp_attr()
Message-ID: <YfwfYfogp69yg1rF@kroah.com>
References: <20220203180936.GA28699@kili>
 <YfweSEOubl1O2VXD@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfweSEOubl1O2VXD@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 03, 2022 at 08:26:16PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 03, 2022 at 09:14:47PM +0300, Dan Carpenter wrote:
> > From: Haimin Zhang <tcs.kernel@gmail.com>
> > 
> > The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
> > the "resp.is_global" flag is set.  Unfortunately, this data is copied to
> > the user and copying uninitialized stack data to the user is an
> > information leak.  Zero out the whole struct to be safe.
> > 
> > Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
> > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Resending through the regular lists.
> > 
> > I added parentheses around the sizeof to make checkpatch happy.
> > s/sizeof resp/sizeof(resp)/.
> > 
> >  drivers/infiniband/core/ucma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The change is ok, but I prefer to initialize to zero as early as possible.
> 
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 2b72c4fa9550..6d801ed2e46b 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1211,9 +1211,9 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
>                                  int in_len, int out_len)
>  {
>         struct rdma_ucm_init_qp_attr cmd;
> -       struct ib_uverbs_qp_attr resp;
> +       struct ib_uverbs_qp_attr resp = {};
>         struct ucma_context *ctx;
> -       struct ib_qp_attr qp_attr;
> +       struct ib_qp_attr qp_attr = {};

Will that catch all of the padding in the structure?  This seems to come
up a lot and I never remember...

thanks,

greg k-h
