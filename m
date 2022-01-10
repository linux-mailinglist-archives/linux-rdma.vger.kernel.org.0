Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFC4898E1
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 13:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiAJMyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 07:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiAJMyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 07:54:10 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B0C06173F
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 04:54:09 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 69so14659875qkd.6
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jan 2022 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F32Xja/Amuv/bQx2xJ4NHWax/nnQgbEuNcbbmtxxQq0=;
        b=alRqB2fiXk4vv94uvbMF+BNd5ZgmxV7ZojLpQ/AMig9guzuZPZSij6Jy6Q2HnLtE0m
         kmxwdgUKsmdbVavXZDj67fJi3RE3ibi5KFPRXGfNyYddH43eRm4n3gAUd8RWwyk5QXN8
         tRQcQHOU0edKOyz+1c6NTwZOxBynkqwjGB1SQbo2NPYuV3oE5w+Voi+X5PilN3d8RB7z
         JCg81o88GmNtGTMIHDyH7NAthgmFvhJjawydMqWfegCdqTxw0WkWIVSyZ5TFK5vWOIfB
         6OeSe7BG2qoSyCQxcspXC5AUTuXURZ6o5przmHphiekWvPph5lVmy3QW8KbadB1HUXJF
         BBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F32Xja/Amuv/bQx2xJ4NHWax/nnQgbEuNcbbmtxxQq0=;
        b=qHRRX04SYX8F3b+/GH4HVbrJm20VoENl+9t2hCoP//R0qauXj9UZ96gm0UAVhPiC8Z
         uFdXnhVq5Ect2PI0sq6sbegWZYT5hlyLHVsH7qbk4GmierNXHTCsVwRG3M+a1B2RkOkd
         Rfu0unhsAv0/X8e20axE0Kr3/L/3afSB0HOGh5JS6iDPZLQQnCGj1QzHuhw1+d3R2RIM
         kpbcWz4A/ZBJqSlLRiNr/Mkdgkw8UuQIctVHmujHZmfs6iQBOkdyCkWffFenOUsJS691
         NUu5g626JubY921tRqaBmz6rk1SiyLXeYUKbtUv/rQhqIFh8qg22deNbaHLxcW/kmTfY
         anQQ==
X-Gm-Message-State: AOAM532z6A+URyAJshBMFFRtg4WPBFHQj11bG3Xk0BCQbSh7y0o8fR2D
        kFlDCxTfjYMPLW6KnLbJheZlWg==
X-Google-Smtp-Source: ABdhPJzArdsxkBKMw5PF4EvjzPmao3rfDZATm3eaObMMaQwNHPRn+ZT50t0yPajowqYXyXTXCfeilA==
X-Received: by 2002:a37:a54a:: with SMTP id o71mr12693867qke.693.1641819248526;
        Mon, 10 Jan 2022 04:54:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h20sm4330101qka.126.2022.01.10.04.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:54:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n6uBb-00DmNz-8J; Mon, 10 Jan 2022 08:54:07 -0400
Date:   Mon, 10 Jan 2022 08:54:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Message-ID: <20220110125407.GE6467@ziepe.ca>
References: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
 <YdstJ/u/HF5e6s0y@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdstJ/u/HF5e6s0y@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 09, 2022 at 08:44:55PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 10, 2022 at 02:37:33AM -0500, yanjun.zhu@linux.dev wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > The type of the function i40iw_remove is void. So remove
> > the unnecessary return.
> > 
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >  drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
> > index d219f64b2c3d..43e962b97d6a 100644
> > +++ b/drivers/infiniband/hw/irdma/i40iw_if.c
> > @@ -198,7 +198,7 @@ static void i40iw_remove(struct auxiliary_device *aux_dev)
> >  							       aux_dev);
> >  	struct i40e_info *cdev_info = i40e_adev->ldev;
> >  
> > -	return i40e_client_device_unregister(cdev_info);
> > +	i40e_client_device_unregister(cdev_info);
> 
> I'm surprised that compiler didn't warn about extra parameter to return.

It is odd, but valid, C to return void like this..

Jason
