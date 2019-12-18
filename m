Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F80123F2F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfLRFgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 00:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfLRFgs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 00:36:48 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231F420733;
        Wed, 18 Dec 2019 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576647407;
        bh=9tjJWmUPcN12JKFZ2Xk1gQCorxUOjz7hsrZklpWU9MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCoAUyrIQjjRgAdWjrlm/rsSjo2iSxIrG6aJs5jl4FRiUWpY2ndhH55hpi4GctSQ+
         6buZS8J4rokn7Gq239lbobWEPcIuMaXa6DYyaiTP/mFTC5jep+tF/lmA3mxnRxJXe1
         eI8wQG3hxRJYOt4RiQNQX+gQ1OsHr/kLqYLoFChw=
Date:   Wed, 18 Dec 2019 07:36:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] Proposed trace points for RDMA/core
Message-ID: <20191218053644.GJ66555@unreal>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
 <20191218002214.GL16762@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218002214.GL16762@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 18, 2019 at 12:22:19AM +0000, Jason Gunthorpe wrote:
> On Mon, Dec 16, 2019 at 10:53:43AM -0500, Chuck Lever wrote:
> > Hey y'all-
> >
> > Refresh of the RDMA/core trace point patches. Anything else needed
> > before these are acceptable?
>
> Can Leon compile and run it yet?

Nope, it is enough to apply first patch to see compilation error.

_  kernel git:(rdma-next) _ git am --continue
Applying: RDMA/cma: Add trace points in RDMA Connection Manager
_  kernel git:(rdma-next) mkt build
Start kernel compilation in silent mode
In file included from drivers/infiniband/core/cma_trace.h:391,
                 from drivers/infiniband/core/cma_trace.c:16:
./include/trace/define_trace.h:95:42: fatal error: ./cma_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.
make[3]: *** [scripts/Makefile.build:266: drivers/infiniband/core/cma_trace.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:503: drivers/infiniband/core] Error 2
make[1]: *** [scripts/Makefile.build:503: drivers/infiniband] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1692: drivers] Error 2

>
> Jason
