Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA338A56
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfFGMa6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfFGMa5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 08:30:57 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ED9212F5;
        Fri,  7 Jun 2019 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559910657;
        bh=MLbdWeoeask8GZDrurNqlH7mO0lfIj1FwFqRK8Ks6dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2H6QbNWd8qZ0Wl/hqackddePIOLrwzEGuWmMGeYIGpSbvVoV617QvHkoaH5/nV86
         GoqWKOGxGF91CcYGOnQMhavOW2JK/w/pWGyg0AGHGh/OT7weE38oXM0d/+ybQz3DQB
         gHmke4R1JPJqU6UImfYuXjGOg1ikvKfJslmf9xRM=
Date:   Fri, 7 Jun 2019 15:30:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3/3] RDMA: Move owner into struct ib_device_ops
Message-ID: <20190607123051.GN5261@mtr-leonro.mtl.com>
References: <20190605173926.16995-1-jgg@ziepe.ca>
 <20190605173926.16995-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605173926.16995-4-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 02:39:26PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> This more closely follows how other subsytems work, with owner being a
> member of the structure containing the function pointers.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/device.c               | 4 ++++
>  drivers/infiniband/core/uverbs_main.c          | 6 +++---
>  drivers/infiniband/hw/bnxt_re/main.c           | 2 +-
>  drivers/infiniband/hw/cxgb3/iwch_provider.c    | 2 +-
>  drivers/infiniband/hw/cxgb4/provider.c         | 2 +-
>  drivers/infiniband/hw/efa/efa_main.c           | 2 +-
>  drivers/infiniband/hw/hfi1/verbs.c             | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c      | 2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c      | 2 +-
>  drivers/infiniband/hw/mlx4/main.c              | 2 +-
>  drivers/infiniband/hw/mlx5/main.c              | 2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c   | 3 +--
>  drivers/infiniband/hw/nes/nes_verbs.c          | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c     | 2 +-
>  drivers/infiniband/hw/qedr/main.c              | 2 +-
>  drivers/infiniband/hw/qib/qib_verbs.c          | 2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c    | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c          | 2 +-
>  include/rdma/ib_verbs.h                        | 2 +-
>  20 files changed, 25 insertions(+), 22 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
