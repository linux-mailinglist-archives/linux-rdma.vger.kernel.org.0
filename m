Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7B46CF7E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 09:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhLHIz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 03:55:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55308 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLHIz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 03:55:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9B82CE2035;
        Wed,  8 Dec 2021 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A9C00446;
        Wed,  8 Dec 2021 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638953513;
        bh=k0/iRYw9sAEphki+MpMMu8A7CabxSrg6Rqnu0nbmdt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB/HDc8fTf7RkQu6ldFbUIE3p1+623xFX+fhldnqRWPltg+CaiaAf8b8ZfHcrl7bn
         6g8nHPvNJ6y/Q4EWGRtR/bfBJSwJ+gwYBwhifLXs2cg2Yz/lL+g7DdLFgpOA7osn9+
         MN46Oe0u68KxU+Hw11uXP51eoiVZKzqi7qK7QQ4Efmld3rG+WFRpNRlAJAQ8quTDb5
         Xx3kg8RHerDE4K6/53v5jwgtFJL4phm73JUBZUBlxJvBYXYYBeC5guiKSDAwiEYiTI
         4esAg9fthDFDApKLrfuN4jR29oAVeqg6/6j/DwkS94mg3sJ0cT+n1Uq7ULUflzILtu
         sqnfrtEyOW+Ng==
Date:   Wed, 8 Dec 2021 10:51:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/mlx5: Use memset_after() to zero struct
 mlx5_ib_mr
Message-ID: <YbByJSkBgLRp5S8V@unreal>
References: <20211207212022.364703-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207212022.364703-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 01:20:22PM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Use memset_after() to zero the end of struct mlx5_ib_mr that should
> be initialized.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: rebased, umem moved into the union and is expected to be wiped
>     https://lore.kernel.org/lkml/20211207194525.GL6385@nvidia.com
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
