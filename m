Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8880F487FDB
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jan 2022 01:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiAHAKg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 19:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiAHAKf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 19:10:35 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CEFC06173E
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jan 2022 16:10:35 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kc16so7051473qvb.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jan 2022 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xz3IbyY/PapIw3TdCgLTH2d0tf58OPn41PP0UNp1OZY=;
        b=OC/jr7/trHXjOf2SEvvOTnav50HFX5pLymOsdR4vKgIvcmgD0FQu6FD7xmV17tDn7u
         jSFYJ0BwNRaeYak0erPt7fKVYH4vrMk7OCJCVg8jr8Ll/HDX85HNGwB8G0hr+W7M2aeF
         Mv2F7WxBZfSzWNbYZxiN0UZ2v2Bvnr4ipZofBmNu7Aihb0UdHohrhqkM3GymMSnHw6Bu
         Xu5tif1gCDKeTtilOXY0uTV3ZkwV3IHuZeVWIW2kEPdg69eY5ZJyS4ynXliqRiI1SsEd
         4BzV6twYB/YkFraUXluP5LX/eFGmPHmYPzXbuZ/UARt+/CeMfCEuKK2SwF9nU7X+IH6P
         0Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xz3IbyY/PapIw3TdCgLTH2d0tf58OPn41PP0UNp1OZY=;
        b=ctXtcpEizGgoS/QV7J9b/caRIAnjun+dj741F3z5/bL9+9ABLvZvMN7cBMvALqVHB+
         n7AtrHl76gnKA+THJi+yCAwCIKWGLAjLyeD2uaucBXeN4rB35qbnIbS7LTDILJgiHpjP
         MrxbvZSQM7NCoavv8OUp+2jVXFQse7Yzk1zZTwpr/zZZNl86kpXrXCtOAIsugheH913s
         slCR6bwg+7nhkHj8/lI8NUk0yOQJweeElMN4iV1EaEvflt+QkfSIrjawDFvekiwgoBzO
         Hd+ilmoDVX4IZ/BqtOoYI0Oa8kMnMo8YQ9qO7qbxHyIPW69VQcPVuY9L0502ybDwDsFo
         Hu5Q==
X-Gm-Message-State: AOAM533jQWTuECUtypFjoMdMGkdKa9FLYQgsyensBTjfziL7+CcUAPkl
        1X+agEKiQx4oJg8W0yAimaXCIg==
X-Google-Smtp-Source: ABdhPJyN10mQsXfe6r1/Kgo5WnEtq2gtdd1si7kX82clgeVIxT4MtVU9xrtlSkTU9EgZccnK9G9Gkg==
X-Received: by 2002:a05:6214:21a8:: with SMTP id t8mr59895348qvc.30.1641600634611;
        Fri, 07 Jan 2022 16:10:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a15sm48619qtb.5.2022.01.07.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:10:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5zJZ-00D95n-Eq; Fri, 07 Jan 2022 20:10:33 -0400
Date:   Fri, 7 Jan 2022 20:10:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ucma_destroy_private_ctx
Message-ID: <20220108001033.GD6467@ziepe.ca>
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

It is a stupid mistake, it is because

	xa_for_each(&multicast_table, index, mc) {
		if (mc->ctx != ctx)
                   ^^^^^^^

Nothing is locking mc here, this needed to hold the xa_lock to be
correct.

It is caused by this:

commit 95fe51096b7adf1d1e7315c49c75e2f75f162584
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Aug 18 15:05:17 2020 +0300

    RDMA/ucma: Remove mc_list and rely on xarray
    
    It is not really necessary to keep a linked list of mcs associated with
    each context when we can just scan the xarray to find the right things.
    
    The removes another overloading of file->mut by relying on the xarray
    locking for mc instead.
    
    Link: https://lore.kernel.org/r/20200818120526.702120-6-leon@kernel.org
    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


So it is solved either by putting the linked list back, but locking it
using the xa_lock, or by holding the xa_lock when doing the
xa_for_each()

A list is probably the better choice.

Jason
