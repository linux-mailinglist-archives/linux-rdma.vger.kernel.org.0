Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C448B663DDD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAJKS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 05:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjAJKM2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 05:12:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AECFAD0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 02:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D8B061554
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AD9C433D2;
        Tue, 10 Jan 2023 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673345536;
        bh=2kWocEXV6hEs1ApjW+j1sLS5l72+f8qtZfqezD7KwSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYTBX05wGKvqYqfMyn/zX8rcpENkxff/aq5xGWn1WBdbYUsN1cR8qpDbUvHRwXAUO
         t/m1t4Z7sj6uAK4HYWXo4XeC7hd2TN4CRweLChVBMbBTnuExTxOZiB89fYAzQD0sEY
         iI1v8/MOrDSZBPbNl2/55vkyRGX8NTOH/kWqYW9tNJbXfk54xYGnJy6bMzcBMUDInI
         RcW/5vxXtbUNZvX7RlXR1XdJM9CWdMuhY3oNdUMtzV/0geROGesZQGtISm+PoaIUIx
         QKROt1UIujiyKN889QXxLuFncme+KQadIRuhsgf7LQJexkg6f8MbAUZu9e4dYn7iP7
         sD/WADeQ9oTmA==
Date:   Tue, 10 Jan 2023 12:12:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 1/6] IB/hfi1: Restore allocated resources on
 failed copyout
Message-ID: <Y705/CVFALoW1j3X@unreal>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328546603.1472310.17312024395730671459.stgit@awfm-02.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167328546603.1472310.17312024395730671459.stgit@awfm-02.cornelisnetworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 12:31:06PM -0500, Dennis Dalessandro wrote:
> From: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> Fix a resource leak if an error occurs.
> 
> Fixes: f404ca4c7ea8 ("IB/hfi1: Refactor hfi_user_exp_rcv_setup() IOCTL")
> Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/file_ops.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> index f5f9269fdc16..c9fc913db00c 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@ -1318,12 +1318,15 @@ static int user_exp_rcv_setup(struct hfi1_filedata *fd, unsigned long arg,
>  		addr = arg + offsetof(struct hfi1_tid_info, tidcnt);
>  		if (copy_to_user((void __user *)addr, &tinfo.tidcnt,
>  				 sizeof(tinfo.tidcnt)))
> -			return -EFAULT;
> +			ret = -EFAULT;

I don't think that it is right to continue to next copy_to_user() if
first one failed.

Thanks

>  
>  		addr = arg + offsetof(struct hfi1_tid_info, length);
>  		if (copy_to_user((void __user *)addr, &tinfo.length,
>  				 sizeof(tinfo.length)))
>  			ret = -EFAULT;
> +
> +		if (ret)
> +			hfi1_user_exp_rcv_invalid(fd, &tinfo);
>  	}
>  
>  	return ret;
> 
> 
