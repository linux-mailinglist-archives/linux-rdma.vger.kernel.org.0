Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE932A816
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbhCBRHl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378825AbhCBJcB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 04:32:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B202C061756
        for <linux-rdma@vger.kernel.org>; Tue,  2 Mar 2021 01:31:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so1924065wmq.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Mar 2021 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=duqySNS7K2RXV+A+no11hnCWpUd9p0lgrM9odevZ3Ko=;
        b=KybiIHEHfVSg3YhOS1sOgCd+YntEv3ioQBT6wh7u/BT45PH7GWuqA/X23Y58kK9uqv
         6In53BefBhjfG5PWhh+8ykxb+dkd2NB96/fqfr5bsCa3F56syAj2XgWXR1U+riEuZIBK
         XLg20tRKCRtnlIkXl+yyesmt3HuYnd2N/SRHFpWm/k7aFk68CONLlnhXXMSa5T9aDpKy
         5jSWLHwp+w67XhmEtTS0iUnmBst6SHL6vQEfshvOeauqCwfLeWrGRkF2hhdEBd0jC8H4
         Kz7nfImcRvgBNavSpFSs8Jz63S025faWMvwgTRrcBvTtVfN0h45L9XyCascOfBa479rK
         LAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=duqySNS7K2RXV+A+no11hnCWpUd9p0lgrM9odevZ3Ko=;
        b=gTDpfwAmT+pFNeSgeDbtbxcpD0TX9Z5Toontj2TC3inuJcXLyDuk1NAT0h+LWp8HBv
         y3URqgJI+Xizh17JVluTgR4IuNXnfSXMH2Gf+iBxFkwuIGLiFIdO2QbXeD8UeapyeeEy
         OoYXhznPNSrS6PELL8iIzGxvBBLQAEeBxCRbPd35+La43qJHkE31M3gO1PCBjZ3xNhfs
         58mG5soHzmM1HNTu4u4salhTna6urhxy4pcycwOnLAb4shsiJhV+XMsEl5g+HMiPchPA
         CMwTo1Ut9i6L4jpGbrTYKrMuIDZXX+/lbJDpUcb9hpeUGHpaEwYavoIZ/8nlcyUYkL/H
         T4mQ==
X-Gm-Message-State: AOAM531cWaAv5WuqkjBKPbZCWRANKy4KfwNPsNJPs7R7rYoC+LIDb2aB
        DjQW8P9S4mZybVqLp5z6dzbVYA==
X-Google-Smtp-Source: ABdhPJxIml2cSRQmyrAOS0vFHxqQG8C+95GOs0WSZY9gEUVuk5drR143w/v2r/4g0i7bWLO+GtoX+g==
X-Received: by 2002:a05:600c:49aa:: with SMTP id h42mr3132506wmp.49.1614677472184;
        Tue, 02 Mar 2021 01:31:12 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a6sm2557430wmm.0.2021.03.02.01.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:31:11 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:31:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 1/2] RDMA/mlx5: Set correct kernel-doc identifier
Message-ID: <20210302093109.GA2690909@dell>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302074214.1054299-2-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 02 Mar 2021, Leon Romanovsky wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The W=1 allmodconfig build produces the following warning:
> drivers/infiniband/hw/mlx5/odp.c:1086: warning: wrong kernel-doc identifier on line:
>   * Parse a series of data segments for page fault handling.
> 
> Fix it by changing /** to be /* as it is written in kernel-doc documentation.
> 
> Fixes: 5e769e444d26 ("RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index 374698186662..b103555b1f5d 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -1082,7 +1082,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
>  	return ret ? ret : npages;
>  }
> 
> -/**
> +/*

This is not the correct fix.

Kernel-doc is asking for the function name.

>   * Parse a series of data segments for page fault handling.
>   *
>   * @dev:  Pointer to mlx5 IB device

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
