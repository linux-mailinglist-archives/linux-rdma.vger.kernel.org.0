Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7706D151071
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 20:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBCToe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 14:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgBCToe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 14:44:34 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C732051A;
        Mon,  3 Feb 2020 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580759073;
        bh=q9HLJaIVVPy5zmORHTL2gvKWVCjp4Hwib2Rk69/xiKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhUCnu27tbkeB1h5sjoEF0qOk5Ad8j6Nx7u4bGj0O3V4kIdc/J1q/NllmdI2QLVsi
         stcNOmSIDpMxf7g6DGlx2jUo+O3teeJ+uMSeCHKXhqp6xqGv3bbp4uKF4ZHG7EtSEX
         vTwv9TZohw3ixh17zmZbIg80teDuwUzClf7xAMOI=
Date:   Mon, 3 Feb 2020 21:44:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200203194428.GS414821@unreal>
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
 <b9fc34ae-6da8-0d12-e069-cdbf9dc06e25@amazon.com>
 <CANjDDBimureiVPqd6Pis46=FiELQHWWjuAm85ZoPYEekBWVs7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBimureiVPqd6Pis46=FiELQHWWjuAm85ZoPYEekBWVs7A@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 11:53:47PM +0530, Devesh Sharma wrote:
> On Mon, Feb 3, 2020 at 11:48 PM Gal Pressman <galpress@amazon.com> wrote:
> >
> > On 03/02/2020 17:56, Devesh Sharma wrote:
> > > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > > index a0e6f89..fc0699d 100644
> > > --- a/libibverbs/driver.h
> > > +++ b/libibverbs/driver.h
> > > @@ -84,6 +84,7 @@ enum verbs_qp_mask {
> > >  enum ibv_gid_type {
> > >       IBV_GID_TYPE_IB_ROCE_V1,
> > >       IBV_GID_TYPE_ROCE_V2,
> > > +     IBV_GID_TYPE_INVALID
> > >  };
> >
> > I don't think that's right.
> > You're adding a new enum value to libibverbs, but it's not really
> > used/implemented there.
> > If devinfo needs an invalid GID value, make it local to that program.
>
> the enum can be used by other applications too, if those are yet to be
> coded in future. I thought its a good practice to put things at one
> place once for all.

Yes, as long as IBV_GID_TYPE_INVALID can be returned by ibv_query_gid_type(),
but it doesn't.

Thanks
