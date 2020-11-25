Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003C2C394B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 07:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgKYGsh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 01:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgKYGsh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 01:48:37 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D828206E0;
        Wed, 25 Nov 2020 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606286916;
        bh=pEiSQmMQ0GaCu/Y7btsFGzvEp45SV3sdBf9/orHbTzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVOlYGaAJdNUwtJY2DVCTzKP+vZ5oqjLoLZWAfKmpOMGANvKnk+aPSRmmwP6YXH1E
         eBHdcWbbSFcmR4IBDgZ6gzAdWZPSzQ41MvuwQ9/H3GCvNdyuB2GqjHLMYCPRsOZfTz
         W3Gj/GpkW3OGMWA7fU8smNPoNjk0AQo32MDD2bFQ=
Date:   Wed, 25 Nov 2020 08:48:32 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com>,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in _destroy_id
Message-ID: <20201125064832.GB3223@unreal>
References: <0000000000004129c705b45fa8f2@google.com>
 <20201118133756.GK244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118133756.GK244516@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 09:37:56AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 18, 2020 at 03:10:21AM -0800, syzbot wrote:
>
> > HEAD commit:    20529233 Add linux-next specific files for 20201118
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13093cf2500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1bc48bf7f78253f664a9
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> Oh? Is this because the error injection is too random?
>
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com
> >
> > iwpm_register_pid: Unable to send a nlmsg (client = 2)
> > infiniband syz1: RDMA CMA: cma_listen_on_dev, error -98
> > ============================================
> > WARNING: possible recursive locking detected
> > 5.10.0-rc4-next-20201118-syzkaller #0 Not tainted
> > syz-executor.5/12844 is trying to acquire lock:
> > ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_release_dev drivers/infiniband/core/cma.c:476 [inline]
> > ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: _destroy_id+0x299/0xa00 drivers/infiniband/core/cma.c:1852
> >
> > but task is already holding lock:
> > ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902
>
> Leon, this is caused by
>
> commit c80a0c52d85c49a910d0dc0e342e8d8898677dc0
> Author: Leon Romanovsky <leon@kernel.org>
> Date:   Wed Nov 4 16:40:07 2020 +0200
>
>     RDMA/cma: Add missing error handling of listen_id
>
>     Don't silently continue if rdma_listen() fails but destroy previously
>     created CM_ID and return an error to the caller.
>
> rdma_destroy_id() can't be called while holding the global lock
>
> This is quite hard to fix. I came up with this ugly thing:
>
> From 8e6568f99fbe4bf734cc4e5dcda987e4ae118bdd Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Wed, 18 Nov 2020 09:33:23 -0400
> Subject: [PATCH] RDMA/cma: Fix deadlock on &lock in rdma_cma_listen_on_all()
>  error unwind
>
> rdma_detroy_id() cannot be called under &lock - we must instead keep the
> error'd ID around until &lock can be released, then destory it.
>
> This is complicated by the usual way listen IDs are destroyed through
> cma_process_remove() which can run at any time and will asynchronously
> destroy the same ID.
>
> Remove the ID from visiblity of cma_process_remove() before going down the
> destroy path outside the locking.
>
> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
