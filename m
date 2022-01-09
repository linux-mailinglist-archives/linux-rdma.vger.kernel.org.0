Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE6488BBC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jan 2022 19:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiAISpH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jan 2022 13:45:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47852 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiAISpE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jan 2022 13:45:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00619B80DC1
        for <linux-rdma@vger.kernel.org>; Sun,  9 Jan 2022 18:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA92C36AE5;
        Sun,  9 Jan 2022 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641753901;
        bh=XsQfxZxJ6ncRmJZRUOx5K9YryOpQ7d0CkgIyhtVDxxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTmiczzBTofhWUcU5lehPbBBj7fvDb5NvPulO+LJ4Lkhf/xepLikzw2LelTEliHWw
         l2zDRQKPZjhUVuCGKu0Sb5M9ndS2S/LEi7c7UerSkYw2gYX9JDI4pIqXBVPS2DDLfE
         UuKL4/MfYP+bTv90B8DTtQ2s72yXqNyQ1P3HwAUaCJtPZ4J7/ZgQY+Nah28+pXqt2o
         kEd9Lm4+RJkLlx7psEg7PUT3he4iozEGjKiZ/JeWxJ9X8zM5o7dO01DdY6hkAtsy5c
         AZs1pvVtB97I7eJbv25BnMlsURSElqRn+Z9dDWAlQI70IXO5YzjRiVeyrq1n83l2x7
         1kxnQHwmfsuzA==
Date:   Sun, 9 Jan 2022 20:44:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Message-ID: <YdstJ/u/HF5e6s0y@unreal>
References: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 02:37:33AM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The type of the function i40iw_remove is void. So remove
> the unnecessary return.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
> index d219f64b2c3d..43e962b97d6a 100644
> --- a/drivers/infiniband/hw/irdma/i40iw_if.c
> +++ b/drivers/infiniband/hw/irdma/i40iw_if.c
> @@ -198,7 +198,7 @@ static void i40iw_remove(struct auxiliary_device *aux_dev)
>  							       aux_dev);
>  	struct i40e_info *cdev_info = i40e_adev->ldev;
>  
> -	return i40e_client_device_unregister(cdev_info);
> +	i40e_client_device_unregister(cdev_info);

I'm surprised that compiler didn't warn about extra parameter to return.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
