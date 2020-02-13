Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A648315C9E2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgBMSEA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSD7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 13:03:59 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D049B217F4;
        Thu, 13 Feb 2020 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581617039;
        bh=RIhL3zsLAIZ5zP3Wo96HWL5tMetMRisfM3MVee1hCtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSKUgB/kn+hXYENPJ3jIAZooPzLF/5Viima3m8AAcE7RtxZb9cAhffDIkbgICgHHD
         QLmisrVdVPnJtojmgG4KCLZP4/R7yIjWj/gd0wLs8cjT08wI44u4tKfOqAk7//LQ/t
         nmpRK4qA1vBUmn+rNpyQqlBfueDSXjY5QXCCwfJA=
Date:   Thu, 13 Feb 2020 20:03:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 8/9] IB/umad: Fix kernel crash while unloading
 ib_umad
Message-ID: <20200213180355.GF679970@unreal>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-9-leon@kernel.org>
 <20200213142818.GA16120@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213142818.GA16120@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 10:28:18AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2020 at 09:26:34AM +0200, Leon Romanovsky wrote:
> > From: Yonatan Cohen <yonatanc@mellanox.com>
> >
> > When unloading ib_umad, remove ibdev sys file 1st before
> > port removal to prevent kernel oops.
> >
> > ib_mad's method ibdev_show() might access a umad port
> > whoes ibdev field has already been NULLed when rmmod ib_umad
> > was issued from another shell.
> >
> > Consider this scenario
> > 	         shell-1            	shell-2
> > 	        rmmod ib_mod    	cat /sys/devices/../ibdev
> > 	            |           		|
> > 	        ib_umad_kill_port()        ibdev_show()
> > 	     port->ib_dev = NULL	dev_name(port->ib_dev)
> >
> > kernel stack
> > PF: error_code(0x0000) - not-present page
> > Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> > RIP: 0010:ibdev_show+0x18/0x50 [ib_umad]
> > RSP: 0018:ffffc9000097fe40 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffffffffa0441120 RCX: ffff8881df514000
> > RDX: ffff8881df514000 RSI: ffffffffa0441120 RDI: ffff8881df1e8870
> > RBP: ffffffff81caf000 R08: ffff8881df1e8870 R09: 0000000000000000
> > R10: 0000000000001000 R11: 0000000000000003 R12: ffff88822f550b40
> > R13: 0000000000000001 R14: ffffc9000097ff08 R15: ffff8882238bad58
> > FS:  00007f1437ff3740(0000) GS:ffff888236940000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000004e8 CR3: 00000001e0dfc001 CR4: 00000000001606e0
> > Call Trace:
> >  dev_attr_show+0x15/0x50
> >  sysfs_kf_seq_show+0xb8/0x1a0
> >  seq_read+0x12d/0x350
> >  vfs_read+0x89/0x140
> >  ksys_read+0x55/0xd0
> >  do_syscall_64+0x55/0x1b0
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
> >
> > Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")
>
> This is the wrong fixes line, this ordering change was actually
> deliberately done:
>

Can you please fix the fixes line, so I will resend unaccepted patches only?

Thanks
