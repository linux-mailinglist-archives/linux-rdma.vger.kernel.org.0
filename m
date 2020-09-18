Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09026FBD9
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIRL4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 07:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRL4L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 07:56:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD0E20DD4;
        Fri, 18 Sep 2020 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430170;
        bh=aQzR/1lujS7ewQIIdMoJzyFPhGFv2g9VohqzclE/DrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvVliJ9kUgw46S9xYcA1iMfDV93wmmN3GEtYhU34iOEnJNtQnoXyxeYpokSAbPwXi
         FTSD5b324sKjjWtfkdWJiiHStfPaqxlQYHBbpU/v6jodE3JJAFsinuCD0xD+RPsOgV
         OUFh3Ypi/hzCDJYCDJpjtwMCYpJY7F5Rd1ctp04A=
Date:   Fri, 18 Sep 2020 14:56:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v3] RDMA/mlx4: Provide port number for special
 QPs
Message-ID: <20200918115605.GS869610@unreal>
References: <20200914111857.344434-1-leon@kernel.org>
 <20200917150813.GN3699@nvidia.com>
 <20200917161034.GE869610@unreal>
 <20200918084613.GQ869610@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918084613.GQ869610@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 11:46:13AM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 07:10:34PM +0300, Leon Romanovsky wrote:
> > On Thu, Sep 17, 2020 at 12:08:13PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 14, 2020 at 02:18:57PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > >
> > > > Special QPs created by mlx4 have same QP port borrowed from
> > > > the context, while they are expected to have different ones.
> > > >
> > > > Fix it by using HW physical port instead.
> > > >
> > > > It fixes the following error during driver init:
> > > > [   12.074150] mlx4_core 0000:05:00.0: mlx4_ib: initializing demux service for 128 qp1 clients
> > > > [   12.084036] <mlx4_ib> create_pv_sqp: Couldn't create special QP (-16)
> > > > [   12.085123] <mlx4_ib> create_pv_resources: Couldn't create  QP1 (-16)
> > > > [   12.088300] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0
> > > >
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  Changelog:
> > > > v3: mlx4 devices create 2 special QPs in SRIOV mode, separate them by
> > > > port number and special bit. The mlx4 is limited to two ports and not
> > > > going to be extended, and the port_num is not forwarded to FW too, so
> > > > it is safe.
> > > > v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-4-leon@kernel.org/#r
> > > > ---
> > > >  drivers/infiniband/hw/mlx4/mad.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > I didn't understand why this was in the restrack series, and the
> > > commit doesn't say when the error can be hit
> >
> > restrack changes revealed it when I added these special QPs to the DB.
> > It is not fix in traditional sense, so no Fixes line.
>
> Anyway, please wait with this patch, it makes troubles in some mlx4
> SRIOV tests.

The end result that this patch is going to be replaced by this fixup
to "RDMA/core: Allow drivers to disable restrack DB" patch.

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 7f0290112db7..e306d2aab510 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1562,6 +1562,11 @@ static int _mlx4_ib_create_qp(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 		if (err)
 			return err;

+		if (init_attr->create_flags &
+		    (MLX4_IB_SRIOV_SQP | MLX4_IB_SRIOV_TUNNEL_QP))
+			/* Internal QP created with ib_create_qp */
+			rdma_restrack_no_track(&qp->ibqp.res);
+
 		qp->port	= init_attr->port_num;
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 :
 			init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI ? sqpn : 1;

>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > No fixes line?
> > >
> > > Jason
