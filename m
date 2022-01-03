Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FFE482FAC
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiACJv1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiACJvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 04:51:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C4C061761;
        Mon,  3 Jan 2022 01:51:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 371E1B80E6C;
        Mon,  3 Jan 2022 09:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019CC36AE9;
        Mon,  3 Jan 2022 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641203475;
        bh=pdb78H/AJLh7R14LkQs6idCf3dD1ZFkcPdBmHKrgkP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXBBvdv5S/hxgy55Nsu2kfXKaDEwRTckPFY72JEDDiOlInXYRsDiS3WNwT5zTfiur
         Iy4apsqu6Mj9b4rCYBbTdIps9pty7WHAnYDi3IMUOt85IWBF8EnsAozZNZzNFxMuBD
         wrRa5vGOm1agSJckz5B0I5cRC2os4kxwUvHLAAcAAzGXz3PGn2Mnv/nMkuDLLJd30X
         wiO7daRVFFMXZdMSdonul6ReEzoIdpJzwgBE2t86sNI6azepUiMXqQMMnQ3rYbo4RX
         sOCwxEfCl5ZilIPQQVyjjB8QwJj1VW1aQv5Ae/Hkb3w5wwDS2BcfL5JSZq4XDOg3iy
         09kDWSsNEks3g==
Date:   Mon, 3 Jan 2022 11:51:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Tony Lu <tonylu@linux.alibaba.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix dereg mr flow for kernel MRs
Message-ID: <YdLHDzmNXlqSMj/A@unreal>
References: <f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com>
 <YcKSzszT/zw2ECjh@TonyMac-Alibaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcKSzszT/zw2ECjh@TonyMac-Alibaba>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 22, 2021 at 10:51:58AM +0800, Tony Lu wrote:
> On Tue, Dec 21, 2021 at 11:46:41AM +0200, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> > 
> > The cited commit moved umem into the union, hence
> > umem could be accessed only for user MRs. Add udata check
> > before access umem in the dereg flow.
> > 
> > Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> > Tested-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 +-
> >  drivers/infiniband/hw/mlx5/mr.c      | 4 ++--
> >  drivers/infiniband/hw/mlx5/odp.c     | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> 
> This patch was tested and works for me in our environment for SMC. It
> wouldn't panic when release link and call ib_dereg_mr.
> 
> Tested-by: Tony Lu <tonylu@linux.alibaba.com>

Thanks, unfortunately, this patch is incomplete.

> 
> Thanks,
> Tony Lu
