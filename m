Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE361538D9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBETQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:16:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42911 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgBETQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 14:16:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so2445368qtq.9
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1B3KI8w3FQ32BkgCh0fyhacclIB9e0qhsFw/3/LkhMU=;
        b=TNeaZWJKqwsAZDpKiKp/Qr8vYtGibkRkPvtBnndeII9jxzHhT+TrxT3oMH2FMvTqjM
         e6fxaTgqRNhBJ36rvLN1RP3idWKB9feECMQQ6/I5qOuZPHcvGFTKbt6Qm7B7NDf0tFMM
         Mx9IxLiFIh8AbsBnwWNMSfTLr89rWrtKf4OZrhEuUjgULgXtr9zug0FSCBfscxMR4XL+
         CujT6SJ7Qdz1fAbgefR7Rxn9d8AHWDXkv87HVTKoSO9Ghmo/iOEFpAu0QfLQevxGMRTQ
         IAZQD3pcD286JkNL4d/ayQtCUYng47MYMsIC+Xs7NnD29biQhwOJtduB0jzWUm5R4pGR
         ZjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1B3KI8w3FQ32BkgCh0fyhacclIB9e0qhsFw/3/LkhMU=;
        b=XZzn6hNb4QRZM5Tjaup0abIx0KxUq4qLQqBPwxMBjBLLL3ntvvuiq8FXHUpCkM6vIa
         lhZkPSWFkkWsDM4Q/AlmSWcOZgVNsMyjRAvGDi0U5a7BNxhzge8O8aTTFPQ2aTSMtB8X
         2giNvKyET/8rX3aBNe9SQ5mdfYsdeKnjyVhPzXWUoB4yYkt/GN99iDa1V8IZ58KuvleL
         YcvuXxFXOXjRskidtxu08S8WatcfBA4qEYx8XKg3S8ZCukcIl1pf7DOwIPzJL39VFaI8
         w22B4DiWpbaHcUnFseyjdswMYFo+blDwBnHwHdgX6aoBzUBnTUall/4ageQ6ydWE9XRP
         f2lg==
X-Gm-Message-State: APjAAAXc+dBKEBH3aokV2vw/DQYfbhtaTadWPQAkQOmphfCVQWyLDnrM
        88DVYDHZv1xVeMMyjCeBTCr9aw==
X-Google-Smtp-Source: APXvYqw2wGJ00l2HOgcRg2QlQIkHx3ZqMZ+tnzHvs+/3Kzdvu6FNc3w6epikxKCHxFyGNQAizwFZwA==
X-Received: by 2002:ac8:48d0:: with SMTP id l16mr34892775qtr.376.1580930183434;
        Wed, 05 Feb 2020 11:16:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r3sm365697qtc.85.2020.02.05.11.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 11:16:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izQ9u-0004eB-HH; Wed, 05 Feb 2020 15:16:22 -0400
Date:   Wed, 5 Feb 2020 15:16:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Message-ID: <20200205191622.GF28298@ziepe.ca>
References: <20200126171553.4916-1-leon@kernel.org>
 <20200202093308.GJ414821@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202093308.GJ414821@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 02, 2020 at 11:33:08AM +0200, Leon Romanovsky wrote:
> On Sun, Jan 26, 2020 at 07:15:53PM +0200, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > We don't need to set pkey as valid in case that user set only one
> > of pkey index or port number, otherwise it will be resulted in NULL
> > pointer dereference while accessing to uninitialized pkey list.
> >
> > The following crash from syzkaller revealed it.
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN PTI
> > CPU: 1 PID: 14753 Comm: syz-executor.2 Not tainted 5.5.0-rc5 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:get_pkey_idx_qp_list+0x161/0x2d0
> > Code: 01 00 00 49 8b 5e 20 4c 39 e3 0f 84 b9 00 00 00 e8 e4 42 6e fe 48
> > 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04
> > 02 84 c0 74 08 3c 01 0f 8e d0 00 00 00 48 8d 7d 04 48 b8
> > RSP: 0018:ffffc9000bc6f950 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82c8bdec
> > RDX: 0000000000000002 RSI: ffffc900030a8000 RDI: 0000000000000010
> > RBP: ffff888112c8ce80 R08: 0000000000000004 R09: fffff5200178df1f
> > R10: 0000000000000001 R11: fffff5200178df1f R12: ffff888115dc4430
> > R13: ffff888115da8498 R14: ffff888115dc4410 R15: ffff888115da8000
> > FS:  00007f20777de700(0000) GS:ffff88811b100000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2f721000 CR3: 00000001173ca002 CR4: 0000000000360ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  port_pkey_list_insert+0xd7/0x7c0
> >  ib_security_modify_qp+0x6fa/0xfc0
> >  _ib_modify_qp+0x8c4/0xbf0
> >  modify_qp+0x10da/0x16d0
> >  ib_uverbs_modify_qp+0x9a/0x100
> >  ib_uverbs_write+0xaa5/0xdf0
> >  __vfs_write+0x7c/0x100
> >  vfs_write+0x168/0x4a0
> >  ksys_write+0xc8/0x200
> >  do_syscall_64+0x9c/0x390
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Fixes: d291f1a652329 ("IB/core: Enforce PKey security on QPs")
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/security.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> 
> As Maor explained below, the code is correct, so what is the resolution here?

Attributes should still not be accessed without their masks set, I
don't see how that is correct just because in some tricky way the
2nd copy isn't read

Jason
