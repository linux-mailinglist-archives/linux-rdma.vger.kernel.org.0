Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF16418741
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhIZIEN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 04:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhIZIEM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 04:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14BB60F45;
        Sun, 26 Sep 2021 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632643356;
        bh=R0UAhiOjX2xdqfs4+6SI95QfEZV2fFxZqVXmTCQ+l1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctRb4ee4kpkTVLFcmy/g9NCCgOfpwDiIK8XzmcZDkpeQDgQyPb7boEoK1rWwK5LmB
         105MBnDHR5dreWHIIR4ZNfXxz0HSnx+Pv7qJ1Gxx+O5luN6mbgtXsHuXk/P+HnLETz
         40fe2NWmQ6klipwsBWd35jaC2hyknXcHuOtxl08aVn+9KTlN5sKa+OwAN4wtOV5G1j
         1kzlI7HiERo9oxgKcr/q4ctBh9UjGwVnSZTRBVeDYXHj6yI8qZ7jRz5bV9rQnUspUy
         paxVwMl6H3cQabr+j66NI3Za/3Uoxi9GxOYoHXCLszQTe+7twRjC8h4Pvj6S3knPVo
         eavnEWn3n/eYw==
Date:   Sun, 26 Sep 2021 11:02:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Message-ID: <YVApGIbSLsU2Ap0k@unreal>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-214523-11804@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214523
> 
>             Bug ID: 214523
>            Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
>                     updates during a reconnect
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.14
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Infiniband/RDMA
>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>           Reporter: kolga@netapp.com
>         Regression: No
> 
> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. During
> the setup the code uses hard coded timeout/retry values. These values are used
> for when Connect Request is not being answered to to re-try the request. During
> the re-try attempts the ARP updates of the destination server are ignored.
> Current timeout values lead to 4+minutes long attempt at connecting to a server
> that no longer owns the IP since the ARP update happens. 
> 
> The ask is to make the timeout/retry values configurable via procfs or sysfs.
> This will allow for environments that use RoCE to reduce the timeouts to a more
> reasonable values and be able to react to the ARP updates faster. Other CMA
> users (eg IB or others) can continue to use existing values.
> 
> The problem exist in all kernel versions but bugzilla is filed for 5.14 kernel.
> 
> The use case is (RoCE-based) NFSoRDMA where a server went down and another
> server was brought up in its place. RDMA layer introduces 4+ minutes in being
> able to re-establish an RDMA connection and let IO resume, due to inability to
> react to the ARP update.

RDMA-CM has many different timeouts, so I hope that my answer is for the
right timeout.

We probably need to extend rdma_connect() to receive remote_cm_response_timeout
value, so NFSoRDMA will set it to whatever value its appropriate.

The timewait will be calculated based it in ib_send_cm_req().

Thanks

> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.
