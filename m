Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0629F37530C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhEFLdG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 07:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhEFLdG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 May 2021 07:33:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D6F9613D9;
        Thu,  6 May 2021 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620300727;
        bh=IFnFYKDkDaVRIdqWKKiKINUs4W6CScJJBZQMfv7J0hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCuhHrvuVM9xyINHg7Q+NhXsf24qyF88GmDe4KfpUKMhks5B1u7Axo9JV9nhiwWGW
         3ZeCjUQ3FIefjeqm3Xddf8a/ZZllZuK1OPUqvBjIaEp6Cv2aYzS+95wzOI3QVcI5nc
         xp3wNrIyipc3qJu3DFofHicQIVxjuzS22sWgezsb2XsTFq9D9BeI10U3RWiDdNTUKi
         iRqyoqbFRrNPRZ1IS35huvHzdNAkqe4nzhC8NabCcodWLXFFPngN1/Ir+nVW9G4t2g
         zXMq4Xqbq6wq1bhcq6uamyMEQiHYtrtXItrr+v5x4XGBrzTRh/H/WgZBR+BZ8S1DxC
         +4Z5SaXIY/TQQ==
Date:   Thu, 6 May 2021 14:32:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/mlx5: Remove redundant assignment to ret
Message-ID: <YJPTs9Znjz/XBxae@unreal>
References: <1620296001-120406-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620296001-120406-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 06:13:21PM +0800, Yang Li wrote:
> Variable 'ret' is set to the rerurn value of function
> mlx5_mr_cache_alloc() but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/infiniband/hw/mlx5/odp.c:421:2: warning: Value stored to 'ret'
> is never read [clang-analyzer-deadcode.DeadStores]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
