Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AEE282AD7
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJDNOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgJDNOl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Oct 2020 09:14:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36CC0613CE
        for <linux-rdma@vger.kernel.org>; Sun,  4 Oct 2020 06:14:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p15so1435967wmi.4
        for <linux-rdma@vger.kernel.org>; Sun, 04 Oct 2020 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OwI7cT0Pcaoaw1u8cFl92hEafVIdLRkklNwHxhBvhXA=;
        b=h7mtTD5gPQ423e9XjkLJf6sa9FjEqm6P0Y/tbD5oSfRQEH4QxoBn5fkzqHwDGaiXOQ
         JgTzI5P6pFQdXwTOWr06l56CR9RFF4MesOGynRAWOQuZnjCnQnLqC+0Y49dcEY09BHRR
         1EJzDmDTd+tSrN0djqViwuAQ6KWqBwgGjCLty+ftIif7mUI2CV1rYewcPC2x88MooDuQ
         2154gXYucZ/SOWUKKgZ6667on+oYEeKxzQS/DfMu1f4Prv5fBzoqOfZDcB7+rXs/Uook
         2u7FUytXFUarcBzTS/oQ8Rl8izRXtp/hyxn8W59kE5fBwY5wrgD3CTLP1CdQxbheiiEd
         Y14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwI7cT0Pcaoaw1u8cFl92hEafVIdLRkklNwHxhBvhXA=;
        b=BN5uHFsb5dEtNLGTaMEXcpckLnYQGx2xI35scZ/OdnDGCjN2A08/UXcyVTY3y+xMFS
         lLBL/u43Y86ptLiVTApVyEqGDDTY8v7bvfjP8EGmLyKL5CDVA1z541e6UxmFQHrNdAdp
         6dvNr/zjdy4cctPlCdgpqDkLElxpaRJ07nAsCsnJOzR3RDkFeJonGeqEJT40MvoQMh1U
         Sd6OBmYymU6QdMuzLHKGBAP3FIQWFR1umkdpMgbzUFSPpebOifMMMG1F6/UKvE7ShVXV
         bJLlVujAcm4YpEqzXm+CqaF9OapQU4YILf6M+zfb84IdEQXlq9IWbvgX4wxQV+vCQ940
         NU7Q==
X-Gm-Message-State: AOAM532k5wjtwDqdIOnVSreJE+ATHDwfaqwh2AgUZpLML6eUmhiPu0ux
        Q6e0AkVu3Va0c13qmBkZVWbFR4LyWco=
X-Google-Smtp-Source: ABdhPJx0S1cbwkfTvI3IIl4bU9vAfwwHdfKZGhi/9Hyk+gCWgrYpQrN+0FZyn8MtNusrK97nrN5+gA==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr11351324wmh.184.1601817277812;
        Sun, 04 Oct 2020 06:14:37 -0700 (PDT)
Received: from kheib-workstation ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id c132sm5713310wmf.25.2020.10.04.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 06:14:37 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:14:34 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/ipoib: Set rtnl_link_ops for ipoib
 interfaces
Message-ID: <20201004131434.GA24784@kheib-workstation>
References: <20200930094013.156839-1-kamalheib1@gmail.com>
 <20201002120236.GA1327974@nvidia.com>
 <20201004125107.GA5480@kheib-workstation>
 <20201004130454.GS816047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004130454.GS816047@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 10:04:54AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 04, 2020 at 03:51:07PM +0300, Kamal Heib wrote:
> > On Fri, Oct 02, 2020 at 09:02:36AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 30, 2020 at 12:40:13PM +0300, Kamal Heib wrote:
> > > > To avoid inconsistent user experience for PKey interfaces that are
> > > > created via netlink vs PKey interfaces that are created via sysfs and the
> > > > base interface, make sure to set the rtnl_link_ops for all ipoib network
> > > > devices, so the ipoib attributes will be reported/modified via iproute2
> > > > for all ipoib interfaces regardless of how they are created.
> > > > 
> > > > Also, after setting the rtnl_link_ops for the base interface, implement
> > > > the dellink() callback to block users from trying to remove it.
> > > > 
> > > > Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > v2: Update commit message.
> > > >  drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
> > > >  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
> > > >  drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
> > > >  3 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > > > index ab75b7f745d4..96b6be5d507d 100644
> > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > > > @@ -2477,6 +2477,8 @@ static struct net_device *ipoib_add_port(const char *format,
> > > >  	/* call event handler to ensure pkey in sync */
> > > >  	queue_work(ipoib_workqueue, &priv->flush_heavy);
> > > >  
> > > > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > > > +
> > > >  	result = register_netdev(ndev);
> > > 
> > > Why do we need this one? I understand fixing the sysfs but not this part.
> > 
> > We need this one to report/modify the ipoib attributes for the parent
> > interface (please take a look at pkey, mode, and umcast after applying
> > this patch):
> > 
> > $ ip -d link show dev mlx5_ib0
> > 29: mlx5_ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc mq state UP mode DEFAULT group default qlen 256
> >     link/infiniband 00:00:1f:e4:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a3:19:64 brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65520
> >     ipoib pkey  0xffff mode  datagram umcast  0000 addrgenmode none numtxqueues 256 numrxqueues 32 gso_max_size 65536 gso_max_segs 65535
> 
> So this is what you mean by "base interface" ? Hmm OK. Highlight this
> a bit more in the commit message since this is something everyone
> will see
>

Yes, correct.
I'll update the commit message.

Thanks,
Kamal

> > > >  static size_t ipoib_get_size(const struct net_device *dev)
> > > >  {
> > > >  	return nla_total_size(2) +	/* IFLA_IPOIB_PKEY   */
> > > > @@ -158,6 +168,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
> > > >  	.priv_size	= sizeof(struct ipoib_dev_priv),
> > > >  	.setup		= ipoib_setup_common,
> > > >  	.newlink	= ipoib_new_child_link,
> > > > +	.dellink	= ipoib_del_child_link,
> > > >  	.changelink	= ipoib_changelink,
> > > >  	.get_size	= ipoib_get_size,
> > > >  	.fill_info	= ipoib_fill_info,
> > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > > > index 30865605e098..c60db9f3f5ac 100644
> > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
> > > > @@ -129,6 +129,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
> > > >  		goto out_early;
> > > >  	}
> > > >  
> > > > +	ndev->rtnl_link_ops = ipoib_get_link_ops();
> > > > +
> > > 
> > > If this is only for the sysfs case why isn't it in ipoib_vlan_add()
> > > which is the sysfs only flow?
> > >
> > 
> > Basically, I was making sure set the rtnl_link_ops before calling
> > register_netdevice(), but you are right this can be moved to the
> > ipoib_vlan_add() as the setting of the rtnl_link_ops for pkey that is
> > created via netlink is done before calling newlink callback, I'll send a
> > v3 that move it to ipoib_vlan_add().
> 
> Please
> 
> Jason
