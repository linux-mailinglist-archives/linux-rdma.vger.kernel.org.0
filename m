Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331AA2FF259
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbhAURsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389134AbhAURr5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 12:47:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2009922A85;
        Thu, 21 Jan 2021 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251235;
        bh=wvF6/oyY42DTafa50mNhJl0dCeLb2khYI9iippvL+Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWdwYBtAipcmPmXFKNl3OVjTucnz1DJk8+7pb09MDSy/USjVP6orAettMgPyE6oE3
         ertFmwjgyizr7hxtpA5ZikR3yZZXa5WBaEit3dApV5LQYodeqYbgHD0MrXgoEc5wGB
         L36DpaHFUwv8eGWF3U2cgEymzjaq/ytz3nr12GEBZmnskaLSqIYCNVvkUdplgKa+ej
         xOsnHrb56HtWp26/UbrLWylU7wW+umGDX1tQAa1phASfC//P6kl7mIJ/8ntxpOnA5x
         kvAUQwRHU6lmTN9b74gUODs9MYBuYHUwp+UwlNzFNPvKuiiyAGaIbTC6KMuTokQ0qD
         QjTpsDrRGEi9A==
Date:   Thu, 21 Jan 2021 19:47:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 02/30] RDMA/hw/mlx5/qp: Demote non-conformant kernel-doc
 header
Message-ID: <20210121174712.GE320304@unreal>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
 <20210121094519.2044049-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121094519.2044049-3-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:51AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/infiniband/hw/mlx5/qp.c:5384: warning: Function parameter or member 'qp' not described in 'mlx5_ib_qp_set_counter'
>  drivers/infiniband/hw/mlx5/qp.c:5384: warning: Function parameter or member 'counter' not described in 'mlx5_ib_qp_set_counter'
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK, closing kernel-doc is also solution.

Like Gal, I would prefer to see "RDMA/mlx5: ..." as title, but it is
not important.

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
