Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112B72251F5
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGSN1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 09:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGSN1i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 09:27:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9058A20809;
        Sun, 19 Jul 2020 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595165258;
        bh=N3pMNaAx4FgnewMrkaTh/3cx6Iyoq0XIvt3bEcWUzMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShZNVnLN4/SfVdwel3iNluFEFMHAFGNW4/rLaQtJGdZRHCsLdwD1aeK+S4aZZQsXu
         cjO3qNnf5ruO6nm2riPuVa3k3hOwjJeLIQiC1vzJ3mrin/2tZoJksTui5k9tscaFb5
         ViD7NYDXJ3Qgm0O34p87jjwbwo63iVLycS6hriI8=
Date:   Sun, 19 Jul 2020 16:27:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
Message-ID: <20200719132733.GE127306@unreal>
References: <20200719060319.77603-1-leon@kernel.org>
 <20200719060319.77603-2-leon@kernel.org>
 <ea42d404-45eb-ec83-b42a-4a3acf659d26@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea42d404-45eb-ec83-b42a-4a3acf659d26@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 04:21:04PM +0300, Gal Pressman wrote:
> On 19/07/2020 9:03, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The kbuild reported the following warning, so clean whole uverbs_cmd.c file.
> >
> >    drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
> > is reassigned a value before the old one has
> > been used. [redundantAssignment]
> >     ret = uverbs_request(attrs, &cmd, sizeof(cmd));
> >         ^
> >    drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
> > reassigned a value before the old one has been
> > used.
> >     int    ret = -EINVAL;
> >    ^
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index a66fc3e37a74..7d2b4258f573 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
> >  	struct ib_uverbs_open_xrcd	cmd;
> >  	struct ib_uxrcd_object         *obj;
> >  	struct ib_xrcd                 *xrcd = NULL;
> > -	struct fd			f = {NULL, 0};
> > +	struct fd f = {};
> >  	struct inode                   *inode = NULL;
> > -	int				ret = 0;
> > +	int ret;
> >  	int				new_xrcd = 0;
> >  	struct ib_device *ib_dev;
>
> I don't mind removing the whitespace, but changing it for just some of the
> variables makes it harder to read the code IMO.

I wanted to remove for all variables in the same patch but was afraid to hear
opposition and waste my time on redoing it.

Once we decide that this should be done, we will change. It will take less than
ten seconds with clang-formatter.

Thanks
