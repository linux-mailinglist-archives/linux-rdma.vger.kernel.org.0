Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31F12FF262
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbhAURta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389259AbhAURsc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 12:48:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA183207C5;
        Thu, 21 Jan 2021 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251271;
        bh=oMiI6DC0wqnDzsVHC7jO/akP9QPC83R9sCcZVqjCxp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UggbUS2Vn3Isnolv1iMfwv25UNGmLIIca8pcBkPhRNc5iKb0w1uML9/RDRMXMDq+L
         2izP0XmyHHd2ry2LNg7UiyVwgparv13fphGyD58cAp8Ush5xXIvbua1s0NuCXXvZWx
         kNVjXL0tvuCO61jvfT8PYuTI24iNdYxNBNSXjHI4AiJgbyrRCLYDWWJXpWQCcjjfQo
         uzbZTVTwFO5ouCJMd/zbqoIsdpJngkBgZrvuH3Cz6KV/9GrQtB+4luSfyxzukDZO5r
         muJJYhQ2DECKCRn8Jhy+bNO2+q0DQXMe7ACYccaDOj4bRVIGzTCPF+YwbxWyT6q0+R
         /WMV+AodVz46Q==
Date:   Thu, 21 Jan 2021 19:47:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 01/30] RDMA/hw/mlx5/odp: Fix formatting and add missing
 descriptions in 'pagefault_data_segments()'
Message-ID: <20210121174747.GF320304@unreal>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
 <20210121094519.2044049-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121094519.2044049-2-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:50AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'dev' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'pfault' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe_end' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'bytes_mapped' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'total_wqe_bytes' not described in 'pagefault_data_segments'
>  drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'receive_queue' not described in 'pagefault_data_segments'
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
