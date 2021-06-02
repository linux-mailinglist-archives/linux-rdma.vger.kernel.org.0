Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201913983FC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhFBIVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 04:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhFBIVm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 04:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D540613C1;
        Wed,  2 Jun 2021 08:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622622000;
        bh=uOICQFyuTW1fDMnFlP4AIf5ElcaKnmpesLxSuT2IWcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIzubGdyD2JbnrmHZxJskmPYPI+GxlQ5NspWPeT0rQDaqeRMeHkeqKlAICTjoiDAJ
         wpEED2aWdeNUsHjmT9woLQG/r8uKH4E23+lF0CBc9nbWK1wNIZ7PrCowzxyEAOYgkD
         lo8BbRsLRPuA7R8I18ptriL0RoZKGoq42rXZr5X5QecmnM7eGLCL89LOOZ/NcsENI4
         LkHWGKXnNp7q0qY8HYyJ8u2JT4lSQ5atOehaZGJWvq8qcAvrncpxjIFfNo3o/k9dJm
         f+UAV1U3xG2TTTN2qdjNUAjkyix/RQ4fPgZbAg71DEywvaC1PAcPHKwVZFaOpJPtcC
         xXOAzdfDUT3PA==
Date:   Wed, 2 Jun 2021 11:19:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Sanitize WQ state received from
 the userspace
Message-ID: <YLc/KwUKErsDGM3f@unreal>
References: <ac41ad6a81b095b1a8ad453dcf62cf8d3c5da779.1621413310.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac41ad6a81b095b1a8ad453dcf62cf8d3c5da779.1621413310.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 11:37:31AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mlx4 and mlx5 implemented differently the WQ input checks.
> Instead of duplicating mlx4 logic in the mlx5, let's prepare
> the input in the central place.
> 
> The mlx5 implementation didn't check for validity of state input.
> It is not real bug because our FW checked that, but still worth to fix.
> 
> Fixes: f213c0527210 ("IB/uverbs: Add WQ support")
> Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Extended commit message
> v1: https://lore.kernel.org/lkml/0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com
>  * Removed IB_WQS_RESET state checks because it is zero and wq states
>    declared as u32, so can't be less than IB_WQS_RESET.
> v0: https://lore.kernel.org/lkml/932f87b48c07278730c3c760b3a707d6a984b524.1621332736.git.leonro@nvidia.com
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 21 +++++++++++++++++++--
>  drivers/infiniband/hw/mlx4/qp.c      |  9 ++-------
>  drivers/infiniband/hw/mlx5/qp.c      |  6 ++----
>  3 files changed, 23 insertions(+), 13 deletions(-)

Any reason for not merging it?

Thanks
