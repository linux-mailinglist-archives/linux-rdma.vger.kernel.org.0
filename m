Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679D6489364
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 09:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiAJIbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 03:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiAJIaW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 03:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E5C06175D;
        Mon, 10 Jan 2022 00:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5116F611BB;
        Mon, 10 Jan 2022 08:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B64C36AE9;
        Mon, 10 Jan 2022 08:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641803419;
        bh=iUjRQpsqyEUrseIEwTvddCf+4ZhjPNNGNSm3vuVwUq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8HFeWrnPQwgtfpdg6xwCdEjrpYRdVfablMvHOSfcY1o1r70iIUGCKdV3nNAxoU3t
         NrIWjTNk9aMwO4idh27IJ+w2glMZIJYbhknh0DbYxKrt+GebVDn1Fqgv3FTSdqu9NE
         O5pk6vDmTUw06qFzI4h4v/N3W50CJw8OsYsk5yLejhQ5iBkJLwUC4SDGH7zXDQTLvt
         ecyZxoOW0Febw09wtiMBlwl64jAA+pXfZnPuE61870iMhgBtxyaG1PANyC59OF4CIP
         94ba5vTjG7VlVO7mqch80rfW3UV/sPSPdmN14ExJ9V0UotkB0WeJk4YBoxoOpRYeh8
         WlhjOu80kdw8w==
Date:   Mon, 10 Jan 2022 10:30:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ucma_destroy_private_ctx
Message-ID: <Ydvul2ghmIndtSPz@unreal>
References: <00000000000056c61c05d4b086d4@google.com>
 <20220105114521.1449-1-hdanton@sina.com>
 <20220108001033.GD6467@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108001033.GD6467@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 07, 2022 at 08:10:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 05, 2022 at 07:45:21PM +0800, Hillf Danton wrote:
> > On Mon, 3 Jan 2022 20:47:02 +0200 Leon Romanovsky wrote:
> > > On Mon, Jan 03, 2022 at 09:05:16AM -0800, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10cf5253b00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e3f96c43d19782dd14a7
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > 
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com
> > > > 
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
> > > > BUG: KASAN: use-after-free in ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
> > > > Read of size 8 at addr ffff88801bb74b00 by task syz-executor.1/25529
> > > 
> > > Jason,
> > > 
> > > Can it be race between ucma_process_join() and "if (refcount_read(&ctx->ref))"
> > > check in ucma_destroy_private_ctx()?
> > 
> > Given cmpxchg in both ucma_close() and ucma_destroy_id(),
> > ucma_destroy_private_ctx() can not run more than once, in addition to what
> > is more weird is that the ucma_fops.release either is running in parallel
> > to a writer or completes with a writer left behind. Light on if that weirdness
> > is down to anything other than syzbot is highly appreciated.
> 
> It is a stupid mistake, it is because
> 
> 	xa_for_each(&multicast_table, index, mc) {
> 		if (mc->ctx != ctx)
>                    ^^^^^^^
> 
> Nothing is locking mc here, this needed to hold the xa_lock to be
> correct.
> 
> It is caused by this:
> 
> commit 95fe51096b7adf1d1e7315c49c75e2f75f162584
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Tue Aug 18 15:05:17 2020 +0300
> 
>     RDMA/ucma: Remove mc_list and rely on xarray
>     
>     It is not really necessary to keep a linked list of mcs associated with
>     each context when we can just scan the xarray to find the right things.
>     
>     The removes another overloading of file->mut by relying on the xarray
>     locking for mc instead.
>     
>     Link: https://lore.kernel.org/r/20200818120526.702120-6-leon@kernel.org
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> 
> So it is solved either by putting the linked list back, but locking it
> using the xa_lock, or by holding the xa_lock when doing the
> xa_for_each()
> 
> A list is probably the better choice.

I'll submit the fix after internal review complete.

Thanks

> 
> Jason
