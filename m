Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A964560B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLGJIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 04:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGJIO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 04:08:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31421A4;
        Wed,  7 Dec 2022 01:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3717860C50;
        Wed,  7 Dec 2022 09:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13573C433C1;
        Wed,  7 Dec 2022 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670404092;
        bh=g80eSHM5OybWQt7Qs3iEfH+1E1QGLIaYfStYnkM8LwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ll1rKFSwCk3ZF0q4k4zX0xI6WU0QMZOLSWeTUF8jbO1FTtTngB/Pw2l8HkOvDkLl2
         YYbP+PajU/Bs/advzeRHbzWKNa9Qdm9HNVKOwCMQ4M8tfY7qQmg4SBDDLMJmzVrfRY
         3hbBk/3pvCgCuaYqhPyMfE7gN1BCDunRAqRqvH/cXeyNpGFr+ANPBG+y6xmFRoxaEs
         cC5ZfD0ei2+OYAn4tUjsgqbzN1JfAv2Z3f9EoCjQlPKKqe2Dvmx2rqXkLpAvr8617c
         Up1qZ6slW+DLpKKQULCqon3p5h3Wu6sHGad79HqQDVltb4IBv1fbLf/WIJWmR2e5HN
         yJ4uqpxije/vQ==
Date:   Wed, 7 Dec 2022 11:08:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     ye.xingchen@zte.com.cn, dennis.dalessandro@cornelisnetworks.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: use sysfs_emit() to instead of scnprintf()
Message-ID: <Y5BX+Argjn7XqhSw@unreal>
References: <202212071632188074249@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212071632188074249@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 04:32:18PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/infiniband/hw/hfi1/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
> index 8e71bef9d982..bcc6bc0540f0 100644
> --- a/drivers/infiniband/hw/hfi1/driver.c
> +++ b/drivers/infiniband/hw/hfi1/driver.c
> @@ -112,7 +112,7 @@ static int hfi1_caps_get(char *buffer, const struct kernel_param *kp)
>  	cap_mask &= ~HFI1_CAP_LOCKED_SMASK;
>  	cap_mask |= ((cap_mask & HFI1_CAP_K2U) << HFI1_CAP_USER_SHIFT);
> 
> -	return scnprintf(buffer, PAGE_SIZE, "0x%lx", cap_mask);
> +	return sysfs_emit(buffer, "0x%lx\n", cap_mask);

Dennis,

Please pay attention what "\n" doesn't exist in original line.
I applied the patch as I think it is the same, but if you see that it
is not, please say so, so we will drop/adapt it before merge window.

Thanks

>  }
> 
>  struct pci_dev *get_pci_dev(struct rvt_dev_info *rdi)
> -- 
> 2.25.1
