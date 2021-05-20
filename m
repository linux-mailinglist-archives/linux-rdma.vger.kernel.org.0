Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CD38A038
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhETIwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 04:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETIwq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 04:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F44560234;
        Thu, 20 May 2021 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621500685;
        bh=bW+zGy1sqx3b3rqCQa231Lwwmjl64RwLBwhcCMzDIrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/BAJFQ3ye6bcD1+G50KQcvGRQ2kZ/hbzLB5YuaBKKoA/r1h5GXyqS9qKOYDSYQPS
         X30agMTA3zlFrueIGtIDTVS5BOSlgVZvpunSBgszbz3HQWGikZm4Cah4edT/CW19PZ
         zaWoeGmR/lAYRk6L2B7gmpQUytgI6NhHw/CUkJRAzfmyaN0wxwYgxSKHKOZfjJzabu
         i/oA5uLlVdOWe0Zz7AyMfWc+1X57TanfH6ObjdgzODBkTVC2h10XecAAxG3Ejz8P9A
         +wF81ZG9S9Zg5xVdSLD+3hmwQ0BhVmTNl/XlTly9j8ycGlqwyIdwzgIn7YOEpix0yn
         aWvmPvAIWKF1w==
Date:   Thu, 20 May 2021 11:51:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Refactor extend link table
 allocation
Message-ID: <YKYjCY7klacZmnn1@unreal>
References: <1621481751-27375-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621481751-27375-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 11:35:51AM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The timeout link table works in HIP08 ES version and the hns driver only
> support the CS version for HIP08, so delete the related code. Then simplify
> the buffer allocation for link table to make the code more readable.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> * Merge the first patch in the series into the second one.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620807370-9409-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 255 ++++++++++++----------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  72 +++-----
>  3 files changed, 124 insertions(+), 206 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
