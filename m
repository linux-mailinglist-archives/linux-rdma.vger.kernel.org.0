Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEA1B53F0
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 07:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWFHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 01:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWFHU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 01:07:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A592075A;
        Thu, 23 Apr 2020 05:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587618439;
        bh=K0rQQFh+thR6I6Bhp8uT/KKkT1Ox9hTEYP5OQJrQN08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0EBrvFOINwnsObGV1Is/esNXENQzVExjdZLCX5/MQ6gFW9Rrb/r0jCXCQyQ/4hVC
         LOkiloMsx2MQpZ+TiKlRWBOgINe3JlrtqfWfqAh7ry33yQet9ooZiLwVS1HWh1hP6S
         nBtGHAInxZDYGbenZ4u1qs7uqDlGlYb7kS4tydDc=
Date:   Thu, 23 Apr 2020 08:07:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        Don Hiatt <don.hiatt@intel.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Set GRH fields in query QP on RoCE
Message-ID: <20200423050714.GA511705@unreal>
References: <20200413132028.930109-1-leon@kernel.org>
 <20200422184445.GA12730@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422184445.GA12730@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 22, 2020 at 03:44:45PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 04:20:28PM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@mellanox.com>
> >
> > GRH fields such as sgid_index, hop limit and etc. are set in the
> > QP context when QP is created/modified.
> >
> > Currently, when query QP is performed, we fill the GRH fields only
> > if the GRH bit is set in the QP context, but this bit is not set
> > for RoCE. Adjust the check so we will set all relevant data for
> > the RoCE too.
> >
> > Fixes: d8966fcd4c25 ("IB/core: Use rdma_ah_attr accessor functions")
> > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/mlx5/qp.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> > index 1456db4b6295..a4f8e7c7ed24 100644
> > --- a/drivers/infiniband/hw/mlx5/qp.c
> > +++ b/drivers/infiniband/hw/mlx5/qp.c
> > @@ -5558,13 +5558,13 @@ static void to_rdma_ah_attr(struct mlx5_ib_dev *ibdev,
> >  	rdma_ah_set_path_bits(ah_attr, path->grh_mlid & 0x7f);
> >  	rdma_ah_set_static_rate(ah_attr,
> >  				path->static_rate ? path->static_rate - 5 : 0);
> > -	if (path->grh_mlid & (1 << 7)) {
> > +
> > +	if (path->grh_mlid & (1 << 7) ||
> > +	    ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
> >  		u32 tc_fl = be32_to_cpu(path->tclass_flowlabel);
> >
> > -		rdma_ah_set_grh(ah_attr, NULL,
> > -				tc_fl & 0xfffff,
> > -				path->mgid_index,
> > -				path->hop_limit,
> > +		rdma_ah_set_grh(ah_attr, NULL, tc_fl & 0xfffff,
> > +				path->mgid_index, path->hop_limit,
>
> Why is whitespace reformatting in a -rc patch? I dropped this.

I'm running clang formatter before posting patches.

Thanks

>
> Applied to for-rc
>
> Jason
