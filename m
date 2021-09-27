Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532DF41942B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhI0M0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhI0M0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 08:26:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B46C061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 05:24:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 72so36326709qkk.7
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Zj0otyMvKPuWIj4cYb8aNuQqHHpYsakizMA/9+0Cl0=;
        b=dPw0HxzUGKQ1056EZ+YP1HkcXmLIrxK6M5u8IRwaicDnvcpJklfcqZQkCYhXgWpgtK
         3GHTqApfKQnd/PKTWUdvARPFcTTQYMmtlQmmkqbzhadVOtehkLNmYSHLnMfGiNYKxjq6
         91jXtvDM4MRI2/S/3f5Srmr/0JMdaKGuCMAYJGRbso/1Ao1mTFc/cAFcrqGHAGCAZ2YW
         HuLbgcwyGOuowWncBF/ENLGryRtd5wHBTL1rpl5dMcw7SjIwoUZ1YI70Hnj5rBnTVKxg
         CTZkWBLWGCCRJAaBBnCcluyn4qrcD1zljhNDAnyrMOlEU7sOng8trUOwO0G1cG7V05d+
         XDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Zj0otyMvKPuWIj4cYb8aNuQqHHpYsakizMA/9+0Cl0=;
        b=DBFOHe3XkP9M4lx4+DGM+X0is5OabiX6iAA5OPAthTX5SRtEWXEo2sbNHh2yPeNtuC
         rZyP267WDpW76CK7K1MMo1sn5I8ZGpEpXq+inGo9WKc/KWCJWJ0lODLA2JzigqOOjQ48
         DSpALQEZTM/4JgqVf51E5Fz3r+6xggAonP0uR5SlQkaVeH5ATcz8PghTzBOVu7HianWc
         oFc/uyzpTS4/kposFhRdMiqleK9yKoV/S4hLZngfdJ7CBFSehf76OCn9hsMC6RyDKC6i
         eupWG6r7ytqRrkt3chuazhxp4Qa+wmX8ajHUdAuGHo0w7FK8eueHDKHfcnY/gcvCNC2S
         tRIQ==
X-Gm-Message-State: AOAM533mOMFk+Rq9RaN6ElX4lAD9sgh49YbEbBiE/d36R3V94nKGE1Pt
        Scy512CbFRVa+yoA5Finmn2s0P51kkJ3pQ==
X-Google-Smtp-Source: ABdhPJzMxFwHhaOe9a0kx9lmaGKwdkiS3yOR6vvGB9ApTQHkcVj5OcaC5QqRs1Ksoniy7aPkO/Ff7g==
X-Received: by 2002:a37:8a02:: with SMTP id m2mr23473022qkd.29.1632745466134;
        Mon, 27 Sep 2021 05:24:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h14sm9080495qtx.69.2021.09.27.05.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:24:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mUpgH-006JeB-7I; Mon, 27 Sep 2021 09:24:25 -0300
Date:   Mon, 27 Sep 2021 09:24:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Message-ID: <20210927122425.GC3544071@ziepe.ca>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal>
 <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVG0iI3dSdP/6/1J@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 03:09:44PM +0300, Leon Romanovsky wrote:
> On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
> > Hi Leon-
> > 
> > Thanks for the suggestion! More below.
> > 
> > > On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > > 
> > > On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=214523
> > >> 
> > >>            Bug ID: 214523
> > >>           Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
> > >>                    updates during a reconnect
> > >>           Product: Drivers
> > >>           Version: 2.5
> > >>    Kernel Version: 5.14
> > >>          Hardware: All
> > >>                OS: Linux
> > >>              Tree: Mainline
> > >>            Status: NEW
> > >>          Severity: normal
> > >>          Priority: P1
> > >>         Component: Infiniband/RDMA
> > >>          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
> > >>          Reporter: kolga@netapp.com
> > >>        Regression: No
> > >> 
> > >> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
> > >> the setup the code uses hard coded timeout/retry values. These values are used
> > >> for when Connect Request is not being answered to to re-try the request. During
> > >> the re-try attempts the ARP updates of the destination server are ignored.
> > >> Current timeout values lead to 4+minutes long attempt at connecting to a server
> > >> that no longer owns the IP since the ARP update happens. 
> > >> 
> > >> The ask is to make the timeout/retry values configurable via procfs or sysfs.
> > >> This will allow for environments that use RoCE to reduce the timeouts to a more
> > >> reasonable values and be able to react to the ARP updates faster. Other CMA
> > >> users (eg IB or others) can continue to use existing values.
> > 
> > I would rather not add a user-facing tunable. The fabric should
> > be better at detecting addressing changes within a reasonable
> > time. It would be helpful to provide a history of why the ARP
> > timeout is so lax -- do certain ULPs rely on it being long?
> 
> I don't know about ULPs and ARPs, but how to calculate TimeWait is
> described in the spec.
> 
> Regarding tunable, I agree. Because it needs to be per-connection, most
> likely not many people in the world will success to configure it properly.

Maybe we should be disconnecting the cm_id if a gratituous ARP changes
the MAC address? The cm_id is surely broken after that event right?

Jason
