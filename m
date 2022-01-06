Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E5486425
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiAFMLB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 07:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiAFMLB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 07:11:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42DC061245;
        Thu,  6 Jan 2022 04:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9650BB820CD;
        Thu,  6 Jan 2022 12:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113C1C36AE3;
        Thu,  6 Jan 2022 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641471058;
        bh=li3M9YsIPAz7FCmvakrOL6sEbJoZ6SsWXwORcygJ8BY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GljovJwohLaIAwt3KpqmZsNjFRBdHcUzElUiYXYGvyq27u2CLWu+8pbuePZJIkf+T
         LmwTCIga0q2P4DlryjbR4QbdA015Q5AjykYDsCr6H8Lar0lZx4Rlzwzdbjw2Ulz/ci
         DP1LufA7fA16lX0GM8mzMiaULT5xx6RQn3UESUln00llyHrlziNNjMgqVFxpTW/bmZ
         dKRN5yr9/hTJndlcFSVsRbCre59E86DL+E3PGBD6oCz6UdUw+s3HJABRoMtzekJtpY
         +sUYd17sCmNu04GB47MsosCn7tOLbms6O90GfaEJvkT0wnSxofwqwNowgnZvwoJ5Lr
         rqWkYsLd9FhhQ==
Date:   Thu, 6 Jan 2022 14:10:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ucma_destroy_private_ctx
Message-ID: <YdbcSnIC22e7Rgyp@unreal>
References: <00000000000056c61c05d4b086d4@google.com>
 <20220105114521.1449-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105114521.1449-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 07:45:21PM +0800, Hillf Danton wrote:
> On Mon, 3 Jan 2022 20:47:02 +0200 Leon Romanovsky wrote:
> > On Mon, Jan 03, 2022 at 09:05:16AM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10cf5253b00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e3f96c43d19782dd14a7
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KASAN: use-after-free in ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
> > > BUG: KASAN: use-after-free in ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
> > > Read of size 8 at addr ffff88801bb74b00 by task syz-executor.1/25529
> > 
> > Jason,
> > 
> > Can it be race between ucma_process_join() and "if (refcount_read(&ctx->ref))"
> > check in ucma_destroy_private_ctx()?
> 
> Given cmpxchg in both ucma_close() and ucma_destroy_id(),
> ucma_destroy_private_ctx() can not run more than once, in addition to what
> is more weird is that the ucma_fops.release either is running in parallel
> to a writer or completes with a writer left behind. Light on if that weirdness
> is down to anything other than syzbot is highly appreciated.

Unless someone can shed the light, the repro will help here/

> 
> 	Hillf
> > 
> > The ucma_process_join() grabbed ctx, but released it in error path,
> > while ucma_destroy_private_ctx() was called without holding any locks?
> > 
> > Thanks
> > 
