Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24E747E0E7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 10:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhLWJhE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 04:37:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51740 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhLWJhD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 04:37:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 371FDCE1F07;
        Thu, 23 Dec 2021 09:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87867C36AE9;
        Thu, 23 Dec 2021 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640252220;
        bh=LgIRriITvAFE1wFs+w18kPsTIhmpe2yKx7KloybrfO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9Wz0CRzcBHUtk33xEP66S7Ksap8klVqtS1M+xeGWVsSYnkW0iS2ClulOT10nbQkl
         3hgVYzg1IMRkZxYACZgFqm5DcU85oG1A3VsHz4pK2sSSLvK0eKNVFTTanSXDo8rJCB
         X0bS5KObaeWnz+Pj+CP4+pgy670svaaAw6ORx9TfJiaj3MtkESPeLhgZnwz4H/j6t8
         1y+bmy5HD9shlKcg0b6A2fc7otlRxSCtZCMZiMEcHFF1c/AK/46h5/jHUUVpXR+ORJ
         53s0+ytRqZTlbopAaDo0po8TT7V83V+7p9NCI7/Fkhdpx7DqAQSKXuKpIoHLpN3sy1
         EhzGu9X/9CMnQ==
Date:   Thu, 23 Dec 2021 11:36:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Maor Gottlieb <maorg@nvidia.com>
Cc:     jgg@nvidia.com, alaa@nvidia.com, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Message-ID: <YcRDN4oPufWLabdD@unreal>
References: <20211222101312.1358616-1-maorg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222101312.1358616-1-maorg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 22, 2021 at 12:13:12PM +0200, Maor Gottlieb wrote:
> This patch is not the full fix and still causes to call traces
> during mlx5_ib_dereg_mr().
> 
> This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.
> 
> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
>  drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
