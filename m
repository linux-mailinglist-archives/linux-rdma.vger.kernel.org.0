Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35581226C87
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGTQ5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 12:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgGTQ5q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 12:57:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597A6207DF;
        Mon, 20 Jul 2020 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595264266;
        bh=2Zos79OckloQzpyvB31kgA54T0QskE8tueuX6VPNPJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNK4lpudv0s3+8nzLAmKi90jpmf+jMoEu9duThZ5FMwxJR5LHxRcoeLiPmrcxIo7A
         0ChtPBfAKfD9z2ZsneVysdOVVXvg8MYPHxDlZ0jixUkfjHBw7Wl+3Uoaa2rNUxXZOb
         Jz8C8AGx3CQJ28A1pAmnnIGzOwO7Jze7cGRQmS4Y=
Date:   Mon, 20 Jul 2020 19:57:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
Message-ID: <20200720165741.GE1080481@unreal>
References: <20200719060319.77603-1-leon@kernel.org>
 <20200719060319.77603-2-leon@kernel.org>
 <ea42d404-45eb-ec83-b42a-4a3acf659d26@amazon.com>
 <20200719132733.GE127306@unreal>
 <20200720142755.GL2021248@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720142755.GL2021248@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 20, 2020 at 11:27:55AM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 19, 2020 at 04:27:33PM +0300, Leon Romanovsky wrote:
> > On Sun, Jul 19, 2020 at 04:21:04PM +0300, Gal Pressman wrote:
> > > On 19/07/2020 9:03, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > The kbuild reported the following warning, so clean whole uverbs_cmd.c file.
> > > >
> > > >    drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
> > > > is reassigned a value before the old one has
> > > > been used. [redundantAssignment]
> > > >     ret = uverbs_request(attrs, &cmd, sizeof(cmd));
> > > >         ^
> > > >    drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
> > > > reassigned a value before the old one has been
> > > > used.
> > > >     int    ret = -EINVAL;
> > > >    ^
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >  drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > > index a66fc3e37a74..7d2b4258f573 100644
> > > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > > @@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
> > > >  	struct ib_uverbs_open_xrcd	cmd;
> > > >  	struct ib_uxrcd_object         *obj;
> > > >  	struct ib_xrcd                 *xrcd = NULL;
> > > > -	struct fd			f = {NULL, 0};
> > > > +	struct fd f = {};
> > > >  	struct inode                   *inode = NULL;
> > > > -	int				ret = 0;
> > > > +	int ret;
> > > >  	int				new_xrcd = 0;
> > > >  	struct ib_device *ib_dev;
> > >
> > > I don't mind removing the whitespace, but changing it for just some of the
> > > variables makes it harder to read the code IMO.
> >
> > I wanted to remove for all variables in the same patch but was afraid to hear
> > opposition and waste my time on redoing it.
> >
> > Once we decide that this should be done, we will change. It will take less than
> > ten seconds with clang-formatter.
>
> It has been something that is going on slowly, I'm not sure a big
> reformatting is a good idea, it really messes up backporting
>
> Maybe these changes could be moved to the end so it is more readable?

Nice, I'll do it.

>
> Jason
