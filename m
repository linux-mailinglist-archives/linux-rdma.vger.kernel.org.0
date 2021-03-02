Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF99532A818
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442164AbhCBRHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378981AbhCBJdH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 04:33:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11DC06178B
        for <linux-rdma@vger.kernel.org>; Tue,  2 Mar 2021 01:32:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o16so1941286wmh.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Mar 2021 01:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rB2YZeVlRiIlBiMUFP2Kr4sxgf0LrsKz3i54nx6Ay6o=;
        b=RMsllFuLz6x37Cff5WrzhbX/UZNE/mdFnlhIDxWKC+EfX0FLaZDDGw9F4qTMOkQ6jK
         41tu8QoyQFQKFYeLaq5EPXHss9T7DCnl+XYnykFgdc1JfT7JRiUzM0nfQFtjtJbi3DFt
         hhcYy6seW+ALaBscWWdn1HIHX7IEE6RzfMn0k0D8JuODPId7Go1xos47xC6ZBfPFHfMe
         IxM27JQrI99tVe/oMHMKq/xVP4RX+cXz101Y1zT4VfXoxwPxfjTeyMYDJsGxaMSw5bDC
         CQG45KlbyvldLIEFZdF3hZT0baSLCSNNVYQxs/IrrygVWGuVT/UMb0a5/u1jRe00i5L6
         qTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rB2YZeVlRiIlBiMUFP2Kr4sxgf0LrsKz3i54nx6Ay6o=;
        b=lqOckuZT41Sz1guBeyfu+ft/pBOqjLzh7zjJweZLJdXxeJ+/7r9OVP1x/wzflghkqy
         grSP6rJ7d3ptilr9ZAFu6BL9B3qNVNaCMDxNtx/ug86WgY6qYvNWhXk2DksrhZCd1Ctr
         UAxppu60EhPB1T+YTbqrl9oN3hkCBaNTj5tq3Q36W1ryMXBDuDWVk7yvrWx/ejH+aDg6
         kD/+89H14Cq3wySGQFZIVDmWLDgWniW84VIgZGtzNReyngFjJGN72auPsY19v/Cknj15
         pX0Kfz3ZfBLBuByYFERWAI/ePVLglq+IbX3O7/lVx5b9v1pgfOacl2J34lF2ATq4wD2D
         BdUA==
X-Gm-Message-State: AOAM532AbD8pzjcC25yU7+qf8gGmNXzbMN2jdN9fUjce80CGGtlvY5lr
        VCOjWh3wsnQnH36O6dfSRoI9AQ==
X-Google-Smtp-Source: ABdhPJwG80JoyvyxkHTYyAHhEKLJZ6ht7ktKkW1BHHvyT/PCYlyYaYE0GAo+Do5MTN8APjQxzhVAIQ==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr1922350wmq.60.1614677545697;
        Tue, 02 Mar 2021 01:32:25 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id m10sm1971133wmh.13.2021.03.02.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:32:25 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:32:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 2/2] RDMA/uverbs: Fix kernel-doc warning of
 _uverbs_alloc
Message-ID: <20210302093223.GB2690909@dell>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302074214.1054299-3-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 02 Mar 2021, Leon Romanovsky wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Fix the following W=1 compilation warning:
> drivers/infiniband/core/uverbs_ioctl.c:108: warning: expecting prototype for uverbs_alloc(). Prototype was for _uverbs_alloc() instead
> 
> Fixes: 461bb2eee4e1 ("IB/uverbs: Add a simple allocator to uverbs_attr_bundle")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
> index e47c5949013f..3871049a48f7 100644
> --- a/drivers/infiniband/core/uverbs_ioctl.c
> +++ b/drivers/infiniband/core/uverbs_ioctl.c
> @@ -90,8 +90,8 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
>  	WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
>  }
> 
> -/**
> - * uverbs_alloc() - Quickly allocate memory for use with a bundle
> +/*

Why are you also demoting the header?

It looks fine to me.  Just correct the function name.

> + * _uverbs_alloc() - Quickly allocate memory for use with a bundle
>   * @bundle: The bundle
>   * @size: Number of bytes to allocate
>   * @flags: Allocator flags

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
