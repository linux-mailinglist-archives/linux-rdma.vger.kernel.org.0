Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8827226E583
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIQTy0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 15:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgIQQM3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 12:12:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377EF21D7F;
        Thu, 17 Sep 2020 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600359038;
        bh=+pZGwjzGn0R4Zltt6vq/zFFvVOaCNw6VNqg2LAnxxwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HljD6qmTOCaO2yeHv3RxbmT2KnA7zMAGFzBsv8/XPxbnlPNkZr2V+J4RSBh0JUHwO
         8m66T+cYFwE0ha49/SntA5ANgpny5sInRHh5BxAnRmhF6n5aJOSwqhj+luYH1z+Gjc
         Zn8QxF8zip3cfg90Aw4nQx6KmaaNF49Cud+7zvv0=
Date:   Thu, 17 Sep 2020 19:10:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v3] RDMA/mlx4: Provide port number for special
 QPs
Message-ID: <20200917161034.GE869610@unreal>
References: <20200914111857.344434-1-leon@kernel.org>
 <20200917150813.GN3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917150813.GN3699@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 12:08:13PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2020 at 02:18:57PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Special QPs created by mlx4 have same QP port borrowed from
> > the context, while they are expected to have different ones.
> >
> > Fix it by using HW physical port instead.
> >
> > It fixes the following error during driver init:
> > [   12.074150] mlx4_core 0000:05:00.0: mlx4_ib: initializing demux service for 128 qp1 clients
> > [   12.084036] <mlx4_ib> create_pv_sqp: Couldn't create special QP (-16)
> > [   12.085123] <mlx4_ib> create_pv_resources: Couldn't create  QP1 (-16)
> > [   12.088300] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Changelog:
> > v3: mlx4 devices create 2 special QPs in SRIOV mode, separate them by
> > port number and special bit. The mlx4 is limited to two ports and not
> > going to be extended, and the port_num is not forwarded to FW too, so
> > it is safe.
> > v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-4-leon@kernel.org/#r
> > ---
> >  drivers/infiniband/hw/mlx4/mad.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>
> I didn't understand why this was in the restrack series, and the
> commit doesn't say when the error can be hit

restrack changes revealed it when I added these special QPs to the DB.
It is not fix in traditional sense, so no Fixes line.

Thanks

>
> No fixes line?
>
> Jason
