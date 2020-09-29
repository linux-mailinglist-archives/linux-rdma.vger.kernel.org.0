Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1927CDF6
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbgI2MsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 08:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2Mrf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 08:47:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B94F208FE;
        Tue, 29 Sep 2020 12:47:34 +0000 (UTC)
Date:   Tue, 29 Sep 2020 15:47:31 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 06/10] RDMA/mlx4: Prepare QP allocation to
 remove from the driver
Message-ID: <20200929124731.GH3094@unreal>
References: <20200926102450.2966017-1-leon@kernel.org>
 <20200926102450.2966017-7-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926102450.2966017-7-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 26, 2020 at 01:24:46PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Since all mlx4 QP have same storage type, move the QP allocation to be
> in one place. This change is preparation to removal of such allocation
> from the driver.
>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 156 +++++++++++++-------------------
>  1 file changed, 63 insertions(+), 93 deletions(-)

Unfortunately, this patch needs small fixup.

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index ef52dd21acd9..c32af16e2564 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1354,7 +1354,6 @@ static void destroy_qp_rss(struct mlx4_ib_dev *dev, struct mlx4_ib_qp *qp)
 	mlx4_qp_free(dev->dev, &qp->mqp);
 	mlx4_qp_release_range(dev->dev, qp->mqp.qpn, 1);
 	del_gid_entries(qp);
-	kfree(qp->rss_ctx);
 }

 static void destroy_qp_common(struct mlx4_ib_dev *dev, struct mlx4_ib_qp *qp,
--
2.26.2

