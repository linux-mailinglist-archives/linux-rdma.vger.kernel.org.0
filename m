Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267C564A015
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiLLNTu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiLLNT1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 08:19:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ABD2DDF
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 05:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CBA2B80B78
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 13:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E212C433D2;
        Mon, 12 Dec 2022 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670851128;
        bh=A1l1eoEBdlYvXWoxVgbw8G6QxU8bf10dci7e/pg6p4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaLsYfKF3dHIjA9ksQYJLG+psosxHzlbb7gDUtU9BC26e80MHcgQq4BUjirKcLtnu
         R/J/pe9XhTVidR3xfgcZ4sqMQDrzUmvZcngaBA/NkaZe8NswXx04eoqRFHtvVxpirL
         gi8ttOEfpjRuZiVFD34Psdcd46sit8Tif2oaMD1cWBUNRW+w7+/aV3Y8XH9A/wILLE
         GWQi0ws3QEWPYpzvbnSOoeUTUXwMcOESwo1leivKsc57ER64e04oO/yqDuS3gSXxSG
         pI+uD/eqRcz5vpd3NTTufTeDE2JjrAltW5Ff/nYJ45N62CypY7WxU6grATlHwUehwk
         +ZGfEnUIANDcw==
Date:   Mon, 12 Dec 2022 15:18:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [for-rc] RDMA/core: Make sure the netdev is not already
 associated
Message-ID: <Y5cqNHNl5hWkpeZC@unreal>
References: <20221212092240.21694-1-kheib@redhat.com>
 <Y5cjx/YI/Cxbh/z0@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cjx/YI/Cxbh/z0@ziepe.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 08:51:19AM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 12, 2022 at 11:22:40AM +0200, Kamal Heib wrote:
> > Make sure that the requested net_device is not already associated with
> > an ib_device before trying to create a new ib_device that will be
> > associated with the same net_device, this is needed to avoid creating
> > siw and rxe devices that will be associated with the same net_device.
> > 
> > Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
> > Signed-off-by: Kamal Heib <kheib@redhat.com>
> > ---
> >  drivers/infiniband/core/nldev.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index a981ac2f0975..376c9e158556 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -1696,6 +1696,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	const struct rdma_link_ops *ops;
> >  	char ndev_name[IFNAMSIZ];
> >  	struct net_device *ndev;
> > +	struct ib_device *ibdev;
> >  	char type[IFNAMSIZ];
> >  	int err;
> >  
> > @@ -1718,6 +1719,12 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	if (!ndev)
> >  		return -ENODEV;
> >  
> > +	ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
> > +	if (ibdev) {
> > +		ib_device_put(ibdev);
> > +		return -EINVAL;
> > +	}
> 
> This is racy

It can be seen as best effort.

> 
> What is wrong with creating two IB devices on top of the same net device?

Any place where we need to convert from ndev to ib will return random answer.

> 
> Jason
