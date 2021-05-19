Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2891D388C03
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbhESKvJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245243AbhESKvI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B620610A8;
        Wed, 19 May 2021 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421389;
        bh=4ulo1/oPBkHsAHqIJuom61tmLxAMYt1F703vdwXrfIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1/DGcksRttMhSbL7B9GR2lk9OTktijW08DQpE56B24w0ABiAJmQizfK5gIbtaHLt
         DdOLYwaJ5b0u7uhqKLKgl4C5MYENjqf/2vWEcN3MOPHgBZkd77b6mF2HVHLZTfzCFM
         T/xJRWix3mGxY4Ss02c1aEMlHuZhJfzNZLud28+LlsCdDohFBnnMClGt7R+1sSBVsD
         A7vjsCg7xuqXhvkfWFsvVLEbp/tuiRBS4vUZI0xM6UflZmb29/7+Zi9Nbr3BeHdAcd
         q6Ww+ifToR9Gg65F94qHXqYT8dfAfD6dAdzc+QGk5pNzXuqRU1/o7bIIbY6PQV7SS6
         FmnJF3LNUG+rw==
Date:   Wed, 19 May 2021 13:49:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH for-next 2/4] RDMA/mlx4: Remove unused parameter udata
Message-ID: <YKTtSX2lmPQSuYoD@unreal>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
 <1620807142-39157-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807142-39157-3-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:12:20PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The old version of ib_umem_get() need these udata as a parameter but now
> they are unnecessary.
> 
> Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/mlx4/cq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
