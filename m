Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8E374915
	for <lists+linux-rdma@lfdr.de>; Wed,  5 May 2021 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhEEUJw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 May 2021 16:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhEEUJw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 May 2021 16:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E18D60241;
        Wed,  5 May 2021 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620245335;
        bh=C9PR3tmwVlH9qW2D6M7x6fJzbZRnZYZX8R2df7n/xWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aVnWcmhemwCrgP5BTCssC6opOMk1FgRSN/6CPh8ucAItTtA7V+qG/oC+oYP14fNkM
         9Wau1Ne7HgSSB7xpmePexVRAf+U6RJ5n7LwSb8hEpY3UeMFFY2QiFT9ibKPO4VNady
         tFovIAHE6+oPB++XRh2ttTCNXVLrmONcs5NKS3w1Smnoqm2gWZrYQB7KvgGX3gS5KG
         wBqXLk3wJsOVgZpC/bnBGcbvbJUk/GacJO+VA3wrSaBWTGgy4GmzI96OsNobKufBqY
         JuJ8L7QKf7f0vvwM1WW4SFmrzDJ1pONsSa8G0SR5FBxEBMMaRcO7xSeqcy5uFp3Kqa
         XFTcrtyVSvWlw==
Date:   Wed, 5 May 2021 13:08:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: CFI violation in drivers/infiniband/core/sysfs.c
Message-ID: <YJL7UoSr42JfMCq1@archlinux-ax161>
References: <20210402195241.gahc5w25gezluw7p@archlinux-ax161>
 <202104021555.08B883C7@keescook>
 <20210403065559.5vebyyx2p5uej5nw@archlinux-ax161>
 <20210504202222.GB2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504202222.GB2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 04, 2021 at 05:22:22PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 02, 2021 at 11:55:59PM -0700, Nathan Chancellor wrote:
> > > So, I think, the solution is below. This hasn't been runtime tested. It
> > > basically removes the ib_port callback prototype and leaves everything
> > > as kobject/attr. The callbacks then do their own container_of() calls.
> > 
> > Well that appear to be okay from a runtime perspective.
> 
> This giant thing should fix it, and some of the other stuff Greg observed:
> 
> https://github.com/jgunthorpe/linux/commits/rmda_sysfs_cleanup
> 
> It needs some testing before it gets posted
> 
> Jason

I have verified that my original test case of running LTP's read_all
test case passes with CFI enabled in enforcing mode with your series and
I still get values when running cat on them. If you have any other
suggestions for test cases, please let me know :)

Thanks for the quick fix!

Cheers,
Nathan
