Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17E4193DD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhI0MLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 08:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MLZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 08:11:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B9A60EE4;
        Mon, 27 Sep 2021 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744587;
        bh=ErIZ8Axc9GqmNhB8HKZeTgH+OERimfVzi0i1IUlAV8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLuTeLQvd+eAO4vxGTGnnKP9gQngnTCaAvo/PG2PwBxT4/IC1DqyhI9Bgn54ewvI0
         9KafCAHDqMIr0GrbHTxnvH8oytAa6lN91dUBtPnSLEiWyGTAoyc9kNbkNgrvk0+lYb
         oxuUZplRbXa8lKLyiiJq+0w+cDIBKl/+ww4fnXh9canqg40jcQO0oj7ZwTFO4ExaeG
         j/foy786xP6AgXktflKnsNoIr7RTCnzybKLANrVBXC5HhUFfpuHNRmVcVaBgdhDvMe
         ibt6GmrIgYeqC6dX5H8L1+eisGfrJMAqabCVQEsRS6G2tSFo50aqJBCx+GwCgPmXYG
         NnT/lBhGXOceg==
Date:   Mon, 27 Sep 2021 15:09:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Message-ID: <YVG0iI3dSdP/6/1J@unreal>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal>
 <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
> Hi Leon-
> 
> Thanks for the suggestion! More below.
> 
> > On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=214523
> >> 
> >>            Bug ID: 214523
> >>           Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
> >>                    updates during a reconnect
> >>           Product: Drivers
> >>           Version: 2.5
> >>    Kernel Version: 5.14
> >>          Hardware: All
> >>                OS: Linux
> >>              Tree: Mainline
> >>            Status: NEW
> >>          Severity: normal
> >>          Priority: P1
> >>         Component: Infiniband/RDMA
> >>          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
> >>          Reporter: kolga@netapp.com
> >>        Regression: No
> >> 
> >> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
> >> the setup the code uses hard coded timeout/retry values. These values are used
> >> for when Connect Request is not being answered to to re-try the request. During
> >> the re-try attempts the ARP updates of the destination server are ignored.
> >> Current timeout values lead to 4+minutes long attempt at connecting to a server
> >> that no longer owns the IP since the ARP update happens. 
> >> 
> >> The ask is to make the timeout/retry values configurable via procfs or sysfs.
> >> This will allow for environments that use RoCE to reduce the timeouts to a more
> >> reasonable values and be able to react to the ARP updates faster. Other CMA
> >> users (eg IB or others) can continue to use existing values.
> 
> I would rather not add a user-facing tunable. The fabric should
> be better at detecting addressing changes within a reasonable
> time. It would be helpful to provide a history of why the ARP
> timeout is so lax -- do certain ULPs rely on it being long?

I don't know about ULPs and ARPs, but how to calculate TimeWait is
described in the spec.

Regarding tunable, I agree. Because it needs to be per-connection, most
likely not many people in the world will success to configure it properly.

> 
> 
> >> The problem exist in all kernel versions but bugzilla is filed for 5.14 kernel.
> >> 
> >> The use case is (RoCE-based) NFSoRDMA where a server went down and another
> >> server was brought up in its place. RDMA layer introduces 4+ minutes in being
> >> able to re-establish an RDMA connection and let IO resume, due to inability to
> >> react to the ARP update.
> > 
> > RDMA-CM has many different timeouts, so I hope that my answer is for the
> > right timeout.
> > 
> > We probably need to extend rdma_connect() to receive remote_cm_response_timeout
> > value, so NFSoRDMA will set it to whatever value its appropriate.
> > 
> > The timewait will be calculated based it in ib_send_cm_req().
> 
> I hope a mechanism can be found that behaves the same or nearly the
> same way for all RDMA fabrics.

It depends on the fabric itself, in every network
remote_cm_response_timeout can be different.

> 
> For those who are not NFS-savvy:
> 
> Simple NFS server failover is typically implemented with a heartbeat
> between two similar platforms that both access the same backend
> storage. When one platform fails, the other detects it and takes over
> the failing platform's IP address. Clients detect connection loss
> with the failing platform, and upon reconnection to that IP address
> are transparently directed to the other platform.
> 
> NFS server vendors have tried to extend this behavior to RDMA fabrics,
> with varying degrees of success.
> 
> In addition to enforcing availability SLAs, the time it takes to
> re-establish a working connection is critical for NFSv4 because each
> client maintains a lease to prevent the server from purging open and
> lock state. If the reconnect takes too long, the client's lease is
> jeopardized because other clients can then access files that client
> might still have locked or open.
> 
> 
> --
> Chuck Lever
> 
> 
> 
