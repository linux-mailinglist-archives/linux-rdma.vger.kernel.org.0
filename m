Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA92351109
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhDAIm4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 04:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhDAImr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 04:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E6BE610A0;
        Thu,  1 Apr 2021 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617266566;
        bh=d6bPen0/230L/AeLRabDytw2IrB/pFzIg03g+mM/KB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeMiOyn0dlDDzwyNlSDhXLKr+oBnMQ8NFKKhhqVbCs9p3GTUd9Gq1ll3MMuZBt1UZ
         4PINs7o55gCy/GwN42zgj6vgr/eeQC7AlIkG1dNuIQw//DegpfAs6V+IWz8F81HsO2
         TTr4PGxJqCxfuT3tVblw/pxoYTDWckNOSixqM/7zymc6w1Ltxnyx4+4so/xZXXIoBk
         Nlkg4ECzplASFXHz9rpjqKkx8CqwuqGEuRR9Baegjq8a1p0UvSJfM7yN+JUyBwVbf2
         FcKOYdx/NOAWuv37IFsLug6EbNx3Qwx6f6BRXeg+D2tyAvy8pTxStgpGL15pRhkwUW
         GXgTUiR8llbtw==
Date:   Thu, 1 Apr 2021 11:42:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Message-ID: <YGWHga9RMan2uioD@unreal>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 09:54:12AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> This is a follow on patch to add a phys_mtu field to the
> ib_port_attr structure to indicate the maximum physical MTU
> the underlying device supports.
> 
> Extends the following:
> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> 
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>  drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>  drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>  drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>  drivers/infiniband/hw/mlx4/main.c               |  1 +
>  drivers/infiniband/hw/mlx5/mad.c                |  1 +
>  drivers/infiniband/hw/mlx5/main.c               |  2 ++
>  drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>  drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>  drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>  drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>  include/rdma/ib_verbs.h                         | 17 -----------------
>  16 files changed, 16 insertions(+), 18 deletions(-)

But why? What will it give us that almost all drivers have same 
props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?

Thanks
