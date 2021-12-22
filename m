Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68247CB6F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 03:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhLVCwE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 21:52:04 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43234 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241974AbhLVCwC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 21:52:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.O7seW_1640141519;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V.O7seW_1640141519)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 10:52:00 +0800
Date:   Wed, 22 Dec 2021 10:51:58 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Message-ID: <YcKSzszT/zw2ECjh@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 21, 2021 at 11:46:41AM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> The cited commit moved umem into the union, hence
> umem could be accessed only for user MRs. Add udata check
> before access umem in the dereg flow.
> 
> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
>  drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
>  drivers/infiniband/hw/mlx5/odp.c     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h

This patch was tested and works for me in our environment for SMC. It
wouldn't panic when release link and call ib_dereg_mr.

Tested-by: Tony Lu <tonylu@linux.alibaba.com>

Thanks,
Tony Lu
