Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006154194DA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhI0NMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhI0NMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 09:12:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E9C061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 06:10:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t2so9994748qtx.8
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMKwFTt0Qb+UwsQCgUfrKX/nNEOLBHUEVy/GL0HO3aw=;
        b=Lc5hBf8Ov39XpmLpsLmkyVVWmUd/C/+94Ekbzvum2Mh7OG3Ti7EycE97d8YrQw4wPX
         hUZZALv5SPl8lMUtMcQ6mBDfEjeEBVWT8KMqybMf5XtIneymY2ugAs1S5gbSIRE4GINB
         pQl2GqWyV6mzMwgHmja5Kf8+5aRk+p6zeGu6RcE7gVkSKsMhhxIQG4hgK5ZhZZjouo2p
         QXEyBLbkus28kQg/b20Ky2zl/9vhoKULIoqxIRbUWiTzc0sd0KglaWkB+RSdbkLr+5VL
         dgpACxNDDC+ZHflWn6Zub3nLn2F+ZpTRf9Hu+LGg2OGzIpolWNZ/iPgZXl7neTwFi0Fx
         WpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMKwFTt0Qb+UwsQCgUfrKX/nNEOLBHUEVy/GL0HO3aw=;
        b=nwBNX3a+3NF5+w1qVsPhaLmNtJVFOgVppSrImkqNKZRBKP2YESVsp+JyBke6TPA4Qj
         b9jRLAq8nAz0VUxY1LRrFAVbTvzzDB4ygA1Uvk98tptHcBopIbp7pYOfda4G9xG9srAx
         o9aZaBhX6LxGbBiEEa3feg/ESwZ3MLrRgB+/3d1bM+xxal3+1kIA4FehBoqqjsQ+Lp14
         wwyC/G75O+uH8hwa3+ST2qdlHzRxqlADd1Co7d5DUFRDqt+qVXK6603nD5pZ1/6EhcNe
         xzIcFoq2J3rT3NeGWf7wB6fGmKFA1NjrrtSsDbJm3w4tN/vEchgDAirbcMeHgzzQUYwJ
         uNWA==
X-Gm-Message-State: AOAM533gq+py8xrWUm3bI7fE3lsI/XlwTX69Azn4DmBdxucosudWR/R9
        ThnKn/jsvQI8To2qKozB6qy4RASJkBM2qA==
X-Google-Smtp-Source: ABdhPJyJhJ9s7lWRccxhg/0pycZockwY+m918EbHBSuSvDmuKD5QNjfFO/4TpCILdq0rFA/L8AzPhA==
X-Received: by 2002:ac8:138b:: with SMTP id h11mr18629727qtj.163.1632748243283;
        Mon, 27 Sep 2021 06:10:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j15sm6622391qth.3.2021.09.27.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:10:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mUqP3-006KzP-Ly; Mon, 27 Sep 2021 10:10:41 -0300
Date:   Mon, 27 Sep 2021 10:10:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Message-ID: <20210927131041.GD3544071@ziepe.ca>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal>
 <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal>
 <20210927122425.GC3544071@ziepe.ca>
 <c7954876-8f32-c513-d190-c1822ee6d590@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7954876-8f32-c513-d190-c1822ee6d590@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 08:55:19PM +0800, Mark Zhang wrote:
> On 9/27/2021 8:24 PM, Jason Gunthorpe wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Sep 27, 2021 at 03:09:44PM +0300, Leon Romanovsky wrote:
> > > On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
> > > > Hi Leon-
> > > > 
> > > > Thanks for the suggestion! More below.
> > > > 
> > > > > On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > > > > 
> > > > > On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=214523
> > > > > > 
> > > > > >             Bug ID: 214523
> > > > > >            Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
> > > > > >                     updates during a reconnect
> > > > > >            Product: Drivers
> > > > > >            Version: 2.5
> > > > > >     Kernel Version: 5.14
> > > > > >           Hardware: All
> > > > > >                 OS: Linux
> > > > > >               Tree: Mainline
> > > > > >             Status: NEW
> > > > > >           Severity: normal
> > > > > >           Priority: P1
> > > > > >          Component: Infiniband/RDMA
> > > > > >           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
> > > > > >           Reporter: kolga@netapp.com
> > > > > >         Regression: No
> > > > > > 
> > > > > > RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
> > > > > > the setup the code uses hard coded timeout/retry values. These values are used
> > > > > > for when Connect Request is not being answered to to re-try the request. During
> > > > > > the re-try attempts the ARP updates of the destination server are ignored.
> > > > > > Current timeout values lead to 4+minutes long attempt at connecting to a server
> > > > > > that no longer owns the IP since the ARP update happens.
> > > > > > 
> > > > > > The ask is to make the timeout/retry values configurable via procfs or sysfs.
> > > > > > This will allow for environments that use RoCE to reduce the timeouts to a more
> > > > > > reasonable values and be able to react to the ARP updates faster. Other CMA
> > > > > > users (eg IB or others) can continue to use existing values.
> > > > 
> > > > I would rather not add a user-facing tunable. The fabric should
> > > > be better at detecting addressing changes within a reasonable
> > > > time. It would be helpful to provide a history of why the ARP
> > > > timeout is so lax -- do certain ULPs rely on it being long?
> > > 
> > > I don't know about ULPs and ARPs, but how to calculate TimeWait is
> > > described in the spec.
> > > 
> > > Regarding tunable, I agree. Because it needs to be per-connection, most
> > > likely not many people in the world will success to configure it properly.
> > 
> > Maybe we should be disconnecting the cm_id if a gratituous ARP changes
> > the MAC address? The cm_id is surely broken after that event right?
> 
> Is there an event on gratuitous ARP? And we also need to notify user-space
> application, right?

I think there is a net notifier for this?

Userspace will see it via the CM event we'll need to trigger.

Jason
