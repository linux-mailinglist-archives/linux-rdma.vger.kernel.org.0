Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C13017F11B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 08:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgCJHjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 03:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgCJHjk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 03:39:40 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0106024677;
        Tue, 10 Mar 2020 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583825979;
        bh=pDcTo3jGlaRUg4AJeQ3STqNwHMX3K2wiybrw6YdVmYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0pOXHhbimVqagJBxc5C9HtnA2BVus046mwHniCHutVE8XnmrnyBpBT8tLKiKGUXt
         0/exUDO0wgX2Ws/1l83Yx38lMila0T5pOQs3iWG+pnS/eyuZEDvjUh6km7jv4+Mh8Z
         lOXPdrjX8w7TSX+onXP4dR2NNi85LikjxmX3Lq24=
Date:   Tue, 10 Mar 2020 09:39:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com,
        syzkaller-bugs@googlegroups.com, yanjunz@mellanox.com
Subject: Re: KASAN: use-after-free Read in rxe_query_port
Message-ID: <20200310073936.GF172334@unreal>
References: <0000000000000c9e12059fc941ff@google.com>
 <20200309173451.GA15143@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309173451.GA15143@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 09, 2020 at 02:34:51PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f8788d86 Linux 5.6-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=132d3645e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e11efb687f5ab7f01f3d
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com
>
> Yanjun, do you have some idea what this could be?

See this fix in the net mailing list.
https://lore.kernel.org/netdev/20200306134518.84416-1-kgraul@linux.ibm.com

Thanks

>
> Thanks,
> Jason
