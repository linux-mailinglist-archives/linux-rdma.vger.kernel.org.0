Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9391E86A4
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2S3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2S3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:29:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775CC03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:29:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so3108231qkn.8
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R57B7A37GdpEsPHqIBvwGelqnsxRNAsMwjVLbSGtiXU=;
        b=RSuyrT3jqYgCEI73D3NLqSZoQLPm+/nxE0FlXiPa18bnlnuEPMxWFRjbb48T2bsihk
         L0eHrLbPLg/+4tnG7ATIEST3lCbdhHb+Vlvg7tuaCNDbtyeCOly87bKWBIt4ds/gMmrk
         vqxheBxKQCw4AD0ca86iQ0fk34KxMgVLZwGsGc1a918k9IkROHVVF138ge4f38pL6eQC
         4ECWzIMoAjORKNUiVKGlw5/mMELBikOAOUAoSeVKmUhsQtqNIDmYJXGb0fIvA2qHyLJH
         CzzVNcWFImL6jVKy+ts7MC994O+DSR0qHU04IuT5/EuwnUKYBqrzJutp7Hzab3w2tcgA
         fTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R57B7A37GdpEsPHqIBvwGelqnsxRNAsMwjVLbSGtiXU=;
        b=n96Z0zCMKQaenVLR/azS5yS+CEYoUsHVlTmpRPGWBFF0wgFgg3Vwftyn3tmKglfp28
         yj+Uq7U48Zts3BjMvB70UqaCZg7Dx9iYIDawmpkXggIwdgQo/s8AMkZu193yFyaq+Xgd
         TcQNmnbtbWMY2GNqKLMGSkUKIeLdxky880/yefh+AoQ7s8+W5jx6IfzmiG2md6tVXL3l
         mSRQyf5K7ScXGhBcFyvWWS5zrsppLiNhzRdPLR/lVBWp+YHSqtD7aXc1blVK55nyrByu
         826HQrmUjZsS8L5aAXUM7jP9+lbspMdPvaYp5WZ8noq3RBlditHQjDVJsnyfzFAQrIBS
         /ZFw==
X-Gm-Message-State: AOAM532k0o7koPsDOgGrXgwQa0MLRPC9G2TyaVTuPK6zam5GFDs5Ws9y
        jMjzGJCzmhD3eq/IvJxOb8s7HZXN+Ic=
X-Google-Smtp-Source: ABdhPJxw9dx5cUXxz5eCvOpJAPdailcJq8dKYueyYWassS0OevuzLU9Zbaq+9WhgnLSwVbZJfsMy1w==
X-Received: by 2002:a37:c20a:: with SMTP id i10mr8917986qkm.29.1590776956189;
        Fri, 29 May 2020 11:29:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r14sm7627529qke.62.2020.05.29.11.29.15
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:29:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejkp-0004pv-BZ
        for linux-rdma@vger.kernel.org; Fri, 29 May 2020 15:29:15 -0300
Date:   Fri, 29 May 2020 15:29:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Use offsetofend() instead of open coding
Message-ID: <20200529182915.GA18558@ziepe.ca>
References: <0-v1-0bc346e08476+585-drop_offsetofend_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-0bc346e08476+585-drop_offsetofend_jgg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 02:18:45PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> No reason to open code this.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/rdma/uverbs_ioctl.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
