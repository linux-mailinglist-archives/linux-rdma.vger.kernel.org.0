Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38817F216
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJIlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgCJIlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:41:19 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B53208E4;
        Tue, 10 Mar 2020 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583829678;
        bh=BiMJEpMfh1Tx92bdI8JmSifYzqdu39C/bCNM7vQZeAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZGmVB06eBgUI923NR/mmloT75tx2ZjUyBAb1T9R3UvBhnslzyauj918ceaynRwNo
         V9K7Q1zfcj1LSHLcl7iDKsbAWBay402z+V4Lc82iHRx227RezOGt6P7GbrGrSzdwyb
         RzUihZekc3tBn1pGaTCnaerRuh5u8ndYwD6qz3+Y=
Date:   Tue, 10 Mar 2020 10:41:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjunz@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in rxe_query_port
Message-ID: <20200310084115.GB242734@unreal>
References: <0000000000000c9e12059fc941ff@google.com>
 <20200309173451.GA15143@mellanox.com>
 <20200310073936.GF172334@unreal>
 <AM6PR05MB50143279152CCAB54786D930D8FF0@AM6PR05MB5014.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR05MB50143279152CCAB54786D930D8FF0@AM6PR05MB5014.eurprd05.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 08:21:29AM +0000, Yanjun Zhu wrote:
> Hi, Leon
>
> Thanks. From the patch https://lore.kernel.org/netdev/20200306134518.84416-1-kgraul@linux.ibm.com,
>
> @@ -240,6 +240,9 @@ static void smc_ib_port_event_work(struct work_struct *work)
>  		work, struct smc_ib_device, port_event_work);
>  	u8 port_idx;
>
> +	if (list_empty(&smcibdev->list))
> +		return;
> +
>  	for_each_set_bit(port_idx, &smcibdev->port_event_mask, SMC_MAX_PORTS) {
>  		smc_ib_remember_port_attr(smcibdev, port_idx + 1);
>  		clear_bit(port_idx, &smcibdev->port_event_mask);
>
> This block is try to check smcibdev->list to avoid ib_query_port after the NIC is down.
> But smcibdev->list is used by spinlock when add and del.
> "
> ...
> 549         spin_lock(&smc_ib_devices.lock);
> 550         list_add_tail(&smcibdev->list, &smc_ib_devices.list);
> 551         spin_unlock(&smc_ib_devices.lock);
> ...
>
> 579         spin_lock(&smc_ib_devices.lock);
> 580         list_del_init(&smcibdev->list); /* remove from smc_ib_devices */
> 581         spin_unlock(&smc_ib_devices.lock);
> ...
> "
> So in the above block, is it necessary to protect  smcibdev->list when it is accessed?
> Please comment on it.

It is worth to read whole thread and not first email only.
https://lore.kernel.org/netdev/20200308150107.GC11496@unreal/

Thanks

>
> Thanks a lot.
> Zhu Yanjun
>
> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, March 10, 2020 3:40 PM
> To: Jason Gunthorpe <jgg@mellanox.com>
> Cc: syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>; dledford@redhat.com; linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Moni Shoua <monis@mellanox.com>; syzkaller-bugs@googlegroups.com; Yanjun Zhu <yanjunz@mellanox.com>
> Subject: Re: KASAN: use-after-free Read in rxe_query_port
>
> On Mon, Mar 09, 2020 at 02:34:51PM -0300, Jason Gunthorpe wrote:
> > On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    f8788d86 Linux 5.6-rc3
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=132d3645e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e11efb687f5ab7f01f3d
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com
> >
> > Yanjun, do you have some idea what this could be?
>
> See this fix in the net mailing list.
> https://lore.kernel.org/netdev/20200306134518.84416-1-kgraul@linux.ibm.com
>
> Thanks
>
> >
> > Thanks,
> > Jason
