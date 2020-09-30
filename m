Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F127DF99
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 06:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgI3Egy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 00:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI3Egy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 00:36:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2592075A;
        Wed, 30 Sep 2020 04:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601440613;
        bh=6kOXL6wf097wJpgMula9ZW8eLRDplk3s42UrDtgXHwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7rchzDr7boJCY+gmpFzTCFp3YMjTjJj/xG7EWMMFbaxAFToatYJPubrxp86okZmG
         9PBZncAxSl4CNiUJfpabxJ2OmQBSwXvMPnqCkuuCa7HfqCbkShMFa3ao2NaWT6GcT+
         w2OxYSHCm+tWMFYt84Lr7ByOr7xvvSPWziJhhC7E=
Date:   Wed, 30 Sep 2020 07:36:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Remove ucontext->closing
Message-ID: <20200930043649.GI3094@unreal>
References: <0-v1-df64ff042436+42-uctx_closing_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-df64ff042436+42-uctx_closing_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 01:09:07PM -0300, Jason Gunthorpe wrote:
> Nothing reads this any more, and the reason for its existance has passed
> due to the deferred fput() scheme.
>
> Fixes: 8ea1f989aa07 ("drivers/IB,usnic: reduce scope of mmap_sem")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 1 -
>  include/rdma/ib_verbs.h             | 6 ------
>  2 files changed, 7 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
