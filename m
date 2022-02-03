Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2D4A8B9A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Feb 2022 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiBCS0W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Feb 2022 13:26:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48146 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiBCS0W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Feb 2022 13:26:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A3761908
        for <linux-rdma@vger.kernel.org>; Thu,  3 Feb 2022 18:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C2C340E8;
        Thu,  3 Feb 2022 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643912781;
        bh=VFMWVUW08c2XRiL5TuJLCDQfaraZ2uwvNCy938fm1fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRN7dxZOptfBdAp3Rknu+7YirWpHSM5lhAdUo2xbJNgpiZqC7L0DS+SZ/QYeEnStG
         R32ZUBatqy1srIjeHzvSEQ9y49u78wwcfHrh8xQVlNjylRreuB5hL3vSi6Js5bxpQm
         Expz+/cU5EuHErjnHXX7ReMJPq9JKBUihdNusZyy0fUBC1ZE2Wv9LrsmQM5OJ8f3bA
         xz6jBpSvEDItrr1Ma8HmnaK7lKXBE9TrLipdDOYyrdxhMXoApzdfGd/EaMoEJz+oNj
         LFh/hRT9dQraoo6xOSEzVL5J8CcO+qOusCA8FRZ7ak3vKq+jAXF0lc3mjg0XVvcMTS
         wJ7do9WuAEBvw==
Date:   Thu, 3 Feb 2022 20:26:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
        linux-rdma@vger.kernel.org, security@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RDMA/ucma: fix a kernel-infoleak in ucma_init_qp_attr()
Message-ID: <YfweSEOubl1O2VXD@unreal>
References: <20220203180936.GA28699@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203180936.GA28699@kili>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 03, 2022 at 09:14:47PM +0300, Dan Carpenter wrote:
> From: Haimin Zhang <tcs.kernel@gmail.com>
> 
> The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
> the "resp.is_global" flag is set.  Unfortunately, this data is copied to
> the user and copying uninitialized stack data to the user is an
> information leak.  Zero out the whole struct to be safe.
> 
> Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Resending through the regular lists.
> 
> I added parentheses around the sizeof to make checkpatch happy.
> s/sizeof resp/sizeof(resp)/.
> 
>  drivers/infiniband/core/ucma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The change is ok, but I prefer to initialize to zero as early as possible.

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 2b72c4fa9550..6d801ed2e46b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1211,9 +1211,9 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
                                 int in_len, int out_len)
 {
        struct rdma_ucm_init_qp_attr cmd;
-       struct ib_uverbs_qp_attr resp;
+       struct ib_uverbs_qp_attr resp = {};
        struct ucma_context *ctx;
-       struct ib_qp_attr qp_attr;
+       struct ib_qp_attr qp_attr = {};
        int ret;

        if (out_len < sizeof(resp))
@@ -1229,8 +1229,6 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
        if (IS_ERR(ctx))
                return PTR_ERR(ctx);

-       resp.qp_attr_mask = 0;
-       memset(&qp_attr, 0, sizeof qp_attr);
        qp_attr.qp_state = cmd.qp_state;
        mutex_lock(&ctx->mutex);
        ret = rdma_init_qp_attr(ctx->cm_id, &qp_attr, &resp.qp_attr_mask);


> 
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 9d6ac9dff39a..91485f13d842 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1232,7 +1232,7 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *file,
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
> -	resp.qp_attr_mask = 0;
> +	memset(&resp, 0, sizeof(resp));
>  	memset(&qp_attr, 0, sizeof qp_attr);
>  	qp_attr.qp_state = cmd.qp_state;
>  	mutex_lock(&ctx->mutex);
> -- 
> 2.20.1
> 
