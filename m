Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE12400F14
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhIEKW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 06:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237710AbhIEKW1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 Sep 2021 06:22:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A291F60F90;
        Sun,  5 Sep 2021 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630837284;
        bh=DSnZOnbbRPZXkAH3bBqJTe+6I0DJq/mBnMcyWhgNpwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxATszSoiCR151yzRPWZ75xOLZ3nhchNxaCTFyQ3SbsYxC2TO3bgavGMnrV9rRxh/
         o7PqfPtdNhXrcmVLOQhAbtw/LsAQR1R5aukHjBlFQguSiSfzwRfVA0EwP02eP34u4V
         OxymL2gtXULgzXqzBO610L31vzKLseWRm/vhOYJ9EcuGyXOYw+JoRzBmPbeKJaKVXW
         NE4jxn9s4AXeGQTwzB6F5Q8wPAy9yT1C2vwmgXK5+DMpQTNKy0HiTUXGoPWGa8CIi6
         ZgGp3qcXrrTKN1EN64pucM1hM9jtw3gRTHjUUKO7rBantaGzuQMxh2ieLAO68DhFHF
         qjhR6OzkggVSg==
Date:   Sun, 5 Sep 2021 13:21:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Prefer kcalloc over open coded arithmetic
Message-ID: <YTSaIMAlelivBGEv@unreal>
References: <20210905081812.17113-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905081812.17113-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 05, 2021 at 10:18:12AM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic sizes: both sides of the
> multiplication are constant values. However it is best to refactor this
> anyway, just to keep the open-coded math idiom out of code.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Also, remove the unnecessary initialization of the sqp_tbl variable
> since it is set a few lines later.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
