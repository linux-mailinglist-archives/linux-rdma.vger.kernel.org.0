Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6238A42
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfFGM2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbfFGM2O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 08:28:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3312133D;
        Fri,  7 Jun 2019 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559910493;
        bh=oJ0oXLdoaOadHkZ7PwrbAaEJNIkbJRpvQpGAOxVoZF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywlyviadc6IcULePF/emG5wwW+7dK43SVqiXo5maCTd18VzaLbUgLpr6R4y1tuYlW
         Bxv8YUZH/G090B0s3wL6yl1U1/mw4G+VILR5W6FN+XpYz7whNvytlkDVIEjYDMQXhO
         XF4VscBjQiLRmIa62E+359cjFb3R1IvXFZFXQP4I=
Date:   Fri, 7 Jun 2019 15:28:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 1/3] RDMA: Move driver_id into struct ib_device_ops
Message-ID: <20190607122807.GL5261@mtr-leonro.mtl.com>
References: <20190605173926.16995-1-jgg@ziepe.ca>
 <20190605173926.16995-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605173926.16995-2-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 02:39:24PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> No reason for every driver to emit code to set this, just make it part of
> the driver's existing static const ops structure.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/device.c               | 12 +++++++++---
>  drivers/infiniband/core/uverbs_uapi.c          |  2 +-
>  drivers/infiniband/hw/bnxt_re/main.c           |  3 ++-
>  drivers/infiniband/hw/cxgb3/iwch_provider.c    |  3 ++-
>  drivers/infiniband/hw/cxgb4/provider.c         |  3 ++-
>  drivers/infiniband/hw/efa/efa_main.c           |  3 ++-
>  drivers/infiniband/hw/hfi1/verbs.c             |  4 +++-
>  drivers/infiniband/hw/hns/hns_roce_main.c      |  3 ++-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  3 ++-
>  drivers/infiniband/hw/mlx4/main.c              |  3 ++-
>  drivers/infiniband/hw/mlx5/main.c              |  3 ++-
>  drivers/infiniband/hw/mthca/mthca_provider.c   |  3 ++-
>  drivers/infiniband/hw/nes/nes_verbs.c          |  3 ++-
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  3 ++-
>  drivers/infiniband/hw/qedr/main.c              |  3 ++-
>  drivers/infiniband/hw/qib/qib_verbs.c          |  4 +++-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  3 ++-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  3 ++-
>  drivers/infiniband/sw/rdmavt/vt.c              |  3 +--
>  drivers/infiniband/sw/rxe/rxe_verbs.c          |  3 ++-
>  include/rdma/ib_verbs.h                        |  3 ++-
>  include/rdma/rdma_vt.h                         |  2 +-
>  22 files changed, 50 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 29f7b15c81d946..021eb68230270e 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -375,7 +375,7 @@ struct ib_device *ib_device_get_by_name(const char *name,
>  	down_read(&devices_rwsem);
>  	device = __ib_device_get_by_name(name);
>  	if (device && driver_id != RDMA_DRIVER_UNKNOWN &&
> -	    device->driver_id != driver_id)
> +	    device->ops.driver_id != driver_id)
>  		device = NULL;
>
>  	if (device) {
> @@ -1479,7 +1479,7 @@ void ib_unregister_driver(enum rdma_driver_id driver_id)
>
>  	down_read(&devices_rwsem);
>  	xa_for_each (&devices, index, ib_dev) {
> -		if (ib_dev->driver_id != driver_id)
> +		if (ib_dev->ops.driver_id != driver_id)
>  			continue;
>
>  		get_device(&ib_dev->dev);
> @@ -2039,7 +2039,7 @@ struct ib_device *ib_device_get_by_netdev(struct net_device *ndev,
>  				    (uintptr_t)ndev) {
>  		if (rcu_access_pointer(cur->netdev) == ndev &&
>  		    (driver_id == RDMA_DRIVER_UNKNOWN ||
> -		     cur->ib_dev->driver_id == driver_id) &&
> +		     cur->ib_dev->ops.driver_id == driver_id) &&
>  		    ib_device_try_get(cur->ib_dev)) {
>  			res = cur->ib_dev;
>  			break;
> @@ -2344,6 +2344,12 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>
>  #define SET_OBJ_SIZE(ptr, name) SET_DEVICE_OP(ptr, size_##name)
>
> +	if (ops->driver_id != RDMA_DRIVER_UNKNOWN) {
> +		WARN_ON(dev_ops->driver_id != RDMA_DRIVER_UNKNOWN &&
> +			dev_ops->driver_id != ops->driver_id);
> +		dev_ops->driver_id = ops->driver_id;
> +	}

I prefer to see WARN() and now WARN_ON(), it allows more easily correlate
some randomly compiled code with upstream version.

Other than that,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
