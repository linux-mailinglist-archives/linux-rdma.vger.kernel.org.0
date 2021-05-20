Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6729C389F1C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETHv5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 03:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETHv5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 03:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4795611BD;
        Thu, 20 May 2021 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621497036;
        bh=VKPgjtg5Gbzyh5hWy4PQWagpv3gICsyq/k8AZLY+KP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fw7vLqlBnEq3l1DMreaeaIG3jRDNIU3DzGICM9YSEUMAX6LCMwKwTmsOAKayrbxom
         aonwZzTqB9EdFyK+hEgAETD+CLj8MUhIfEQQjV6UlYCBMVL7Gfg02IpFL3JloG3uGx
         HGHTSg7wr20jI0eePVu1oVwxqySzEk/wuN+o6STm73UDCR23i6hlFF+Cgdynmo02k4
         sZHCGlQ4mJ5VDKqhjZ9vmLZHZkMmhHgtOUvr7sgM+PVgCOwvoAYVdG6+RSS9sTPfQm
         NQTGOP3yH26TMyWSBoD7PmIirFVOoz1DycVv8gRSVMva9B5wNY12RmXl6+oD/HgHHO
         bv0LaAWEQ7VtQ==
Date:   Thu, 20 May 2021 10:50:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [for-next 1/2] RDMA/bnxt_re: Enable global atomic ops if
 platform supports
Message-ID: <YKYUyPOfeER2FVGD@unreal>
References: <20210517132522.774762-1-devesh.sharma@broadcom.com>
 <20210517132522.774762-2-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517132522.774762-2-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 06:55:21PM +0530, Devesh Sharma wrote:
> Enabling Atomic operations for Gen P5 devices if the underlying
> platform supports global atomic ops.
> 
> Fixes:7ff662b76167 ("Disable atomic capability on bnxt_re adapters")
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
>  drivers/infiniband/hw/bnxt_re/main.c      |  4 ++++
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 15 +++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
>  6 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 2efaa80bfbd2..8194ac52a484 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -163,6 +163,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
>  	ib_attr->max_qp_init_rd_atom = dev_attr->max_qp_init_rd_atom;
>  	ib_attr->atomic_cap = IB_ATOMIC_NONE;
>  	ib_attr->masked_atomic_cap = IB_ATOMIC_NONE;
> +	if (dev_attr->is_atomic) {
> +		ib_attr->atomic_cap = IB_ATOMIC_GLOB;
> +		ib_attr->masked_atomic_cap = IB_ATOMIC_GLOB;
> +	}
>  
>  	ib_attr->max_ee_rd_atom = 0;
>  	ib_attr->max_res_rd_atom = 0;
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 8bfbf0231a9e..e91e987b7861 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -128,6 +128,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
>  	rdev->rcfw.res = &rdev->qplib_res;
>  
>  	bnxt_re_set_drv_mode(rdev, wqe_mode);
> +	if (bnxt_qplib_enable_atomic_ops_to_root(en_dev->pdev))
> +		ibdev_info(&rdev->ibdev,
> +			   "platform doesn't support global atomics.");
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index 3ca47004b752..d2efb295e0f6 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -959,3 +959,18 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
>  	bnxt_qplib_free_res(res);
>  	return rc;
>  }
> +
> +bool bnxt_qplib_enable_atomic_ops_to_root(struct pci_dev *dev)

Why do you need open-coded variant of pci_enable_atomic_ops_to_root()?

Thanks
