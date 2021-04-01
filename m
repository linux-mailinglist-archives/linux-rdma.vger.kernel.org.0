Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F359B351CFD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhDASXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237430AbhDASNC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:13:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7D9B608FE;
        Thu,  1 Apr 2021 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279280;
        bh=G4vQxAKi4iey6SHNBllxnNnCc7xSbDP1XqM7nR7fUKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA8rSTXyxtTvCkjo6UcqZx0xuMFV4Dz4V9N9wovUWEE8Yje4oImcOgq88LbIcpjTy
         sVZt7RwTHz6vxOve7S42GYYBdOhcKsBvUbdPvbrQw6w6EoRwGTmw/EpbqcRsWY940G
         JhnZQvuSVZ+KAR0dIiY883+x328OlD7rUb+R5P6k6ISS7C8uQoWBIQG3iezq01F/ov
         2b3xvN/AjndlV0ZyvXv/HgglFIrWU3DFvQPjnIGRthwzO9fDL5SE2r94fSns9Vm36W
         HRIQGn8tKuSw/l+5KtncqJmLX1IaWoDaNMJHwpMwkOBgp31+eNsFoSY8BSL6bQjBDw
         LeahLQuzeGuHQ==
Date:   Thu, 1 Apr 2021 15:14:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/uverbs: Fix -Wunused-function warning
Message-ID: <YGW5LDDlWAorP+8E@unreal>
References: <20210401021028.25720-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401021028.25720-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 10:10:28AM +0800, YueHaibing wrote:
> make W=1 warns this:
> 
> In file included from drivers/infiniband/sw/rdmavt/mmap.c:51:0:
> ./include/rdma/uverbs_ioctl.h:937:1:
>  warning: ‘_uverbs_get_const_unsigned’ defined but not used [-Wunused-function]
>  _uverbs_get_const_unsigned(u64 *to,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/rdma/uverbs_ioctl.h:930:1:
>  warning: ‘_uverbs_get_const_signed’ defined but not used [-Wunused-function]
>  _uverbs_get_const_signed(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
>  ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make these functions inline to fix this warnings.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/rdma/uverbs_ioctl.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
