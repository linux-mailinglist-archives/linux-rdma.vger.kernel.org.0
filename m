Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF54215760
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgGFMgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgGFMgx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:36:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80E520715;
        Mon,  6 Jul 2020 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594039012;
        bh=EICLJ+4evpq2wndeUP6ZK6Uk4M3OhygibHb0XF/3m/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THv+YEni4qNzjhuiA0FaXH4/4LnpKPgGbJyWVoOYaQfJYSx7nsa2xbBVdTLjbW0x3
         KPSnCAK7MGSqauxsl5QqRnHYYuhkVoBNw3yYGAqIYFd8Ivo56+Im+Ghbh/6If3SMhi
         2nALSeZrb+lpt6AxoRTJvwm8VbO73JFnS4SC5O8o=
Date:   Mon, 6 Jul 2020 15:36:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next 3/3] RDMA: Remove the udata parameter from
 alloc_mr callback
Message-ID: <20200706123648.GH207186@unreal>
References: <20200706120343.10816-1-galpress@amazon.com>
 <20200706120343.10816-4-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706120343.10816-4-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 03:03:43PM +0300, Gal Pressman wrote:
> Allocating an MR flow can only be initiated by kernel users, and not
> from userspace so a udata parameter is redundant.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/verbs.c                 | 2 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c        | 2 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h        | 2 +-
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h          | 2 +-
>  drivers/infiniband/hw/cxgb4/mem.c               | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h     | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c         | 2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c       | 3 +--
>  drivers/infiniband/hw/mlx4/mlx4_ib.h            | 2 +-
>  drivers/infiniband/hw/mlx4/mr.c                 | 2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h            | 2 +-
>  drivers/infiniband/hw/mlx5/mr.c                 | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c              | 2 +-
>  drivers/infiniband/hw/qedr/verbs.h              | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h | 2 +-
>  drivers/infiniband/sw/rdmavt/mr.c               | 2 +-
>  drivers/infiniband/sw/rdmavt/mr.h               | 2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c           | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.c           | 2 +-
>  drivers/infiniband/sw/siw/siw_verbs.h           | 2 +-
>  include/rdma/ib_verbs.h                         | 2 +-
>  24 files changed, 24 insertions(+), 25 deletions(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
