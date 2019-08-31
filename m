Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A115A4316
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2019 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfHaHbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Aug 2019 03:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfHaHbD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Aug 2019 03:31:03 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A66823429;
        Sat, 31 Aug 2019 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567236663;
        bh=T9QXqjkxtLqp8qyqjBAekzrqEGKVmX1IYd+sbY3xafk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSuq7OMN0CsF6Uu7NzGmHYmT396DWBa8fACkylDIxbf1YSP5UIFW10W7iWAoChJ7O
         OTIhHB9FaOcDAHLB1GGjRnPjf//Gis1ZNrNGaAcnsqAGQDL/1L73eG9UqV11aP6yXW
         Y4hvk+/9Tt+V/kXJ+FKNbKDCCwQrjucfCWjjCpYY=
Date:   Sat, 31 Aug 2019 10:30:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: qedr memory leak report
Message-ID: <20190831073048.GH12611@unreal>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
 <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Doug,

I think that it can be counted as good example why allowing memory leaks
in drivers (HNS) is not so great idea.

Thanks

On Fri, Aug 30, 2019 at 02:27:49PM -0400, Chuck Lever wrote:
>
> > On Aug 30, 2019, at 2:03 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > Hi Michal-
> >
> > In the middle of some other testing, I got this kmemleak report
> > while testing with FastLinq cards in iWARP mode:
> >
> > unreferenced object 0xffff888458923340 (size 32):
> >  comm "mount.nfs", pid 2294, jiffies 4298338848 (age 1144.337s)
> >  hex dump (first 32 bytes):
> >    20 1d 69 63 88 88 ff ff 20 1d 69 63 88 88 ff ff   .ic.... .ic....
> >    00 60 7a 69 84 88 ff ff 00 60 82 f9 00 00 00 00  .`zi.....`......
> >  backtrace:
> >    [<000000000df5bfed>] __kmalloc+0x128/0x176
> >    [<0000000020724641>] qedr_alloc_pbl_tbl.constprop.44+0x3c/0x121 [qedr]
> >    [<00000000a361c591>] init_mr_info.constprop.41+0xaf/0x21f [qedr]
> >    [<00000000e8049714>] qedr_alloc_mr+0x95/0x2c1 [qedr]
> >    [<000000000e6102bc>] ib_alloc_mr_user+0x31/0x96 [ib_core]
> >    [<00000000d254a9fb>] frwr_init_mr+0x23/0x121 [rpcrdma]
> >    [<00000000a0364e35>] rpcrdma_mrs_create+0x45/0xea [rpcrdma]
> >    [<00000000fd6bf282>] rpcrdma_buffer_create+0x9e/0x1c9 [rpcrdma]
> >    [<00000000be3a1eba>] xprt_setup_rdma+0x109/0x279 [rpcrdma]
> >    [<00000000b736b88f>] xprt_create_transport+0x39/0x19a [sunrpc]
> >    [<000000001024e4dc>] rpc_create+0x118/0x1ab [sunrpc]
> >    [<00000000cca43a49>] nfs_create_rpc_client+0xf8/0x15f [nfs]
> >    [<00000000073c962c>] nfs_init_client+0x1a/0x3b [nfs]
> >    [<00000000b03964c4>] nfs_init_server+0xc1/0x212 [nfs]
> >    [<000000001c71f609>] nfs_create_server+0x74/0x1a4 [nfs]
> >    [<000000004dc919a1>] nfs3_create_server+0xb/0x25 [nfsv3]
> >
> > It's repeated many times.
> >
> > The workload was an unremarkable software build and regression test
> > suite on an NFSv3 mount with RDMA.
>
> Also seeing one of these per NFS mount:
>
> unreferenced object 0xffff888869f39b40 (size 64):
>   comm "kworker/u28:0", pid 17569, jiffies 4299267916 (age 1592.907s)
>   hex dump (first 32 bytes):
>     00 80 53 6d 88 88 ff ff 00 00 00 00 00 00 00 00  ..Sm............
>     00 48 e2 66 84 88 ff ff 00 00 00 00 00 00 00 00  .H.f............
>   backtrace:
>     [<0000000063e652dd>] kmem_cache_alloc_trace+0xed/0x133
>     [<0000000083b1e912>] qedr_iw_connect+0xf9/0x3c8 [qedr]
>     [<00000000553be951>] iw_cm_connect+0xd0/0x157 [iw_cm]
>     [<00000000b086730c>] rdma_connect+0x54e/0x5b0 [rdma_cm]
>     [<00000000d8af3cf2>] rpcrdma_ep_connect+0x22b/0x360 [rpcrdma]
>     [<000000006a413c8d>] xprt_rdma_connect_worker+0x24/0x88 [rpcrdma]
>     [<000000001c5b049a>] process_one_work+0x196/0x2c6
>     [<000000007e3403ba>] worker_thread+0x1ad/0x261
>     [<000000001daaa973>] kthread+0xf4/0xf9
>     [<0000000014987b31>] ret_from_fork+0x24/0x30
>
> Looks like this one is not being freed:
>
> 514         ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> 515         if (!ep)
> 516                 return -ENOMEM;
>
>
> --
> Chuck Lever
>
>
>
