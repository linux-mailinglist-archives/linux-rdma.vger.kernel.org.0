Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9271796F3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 18:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgCDRpg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 12:45:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35474 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgCDRpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 12:45:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id v15so2026485qto.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 09:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KBj/QJiDI1iRxhSij6yvAToTc0lPb8hrcnwFkY6CwtQ=;
        b=IOE1H2Sf2ezouthaBmvL2+0/6Gjvxw95LmuTW0c56i1u9ojWEL4OGX1ui0ZEz2B5Rs
         /E1gpFZBEReOM1TtGBSdt71QdoBE6PSLaGwc3PG05lMu3kpR8+vKAi6eXkDKVvjPcCfz
         hWsqdGvm2lphiDczkH2VcONHKKThUq3LJT+mYiPhbpQ3C8+zRhXQYizxcw7TmYnvl8ry
         eREBvujBh7Yan6vgnQBSa/080bjyTEYSRs+Ex2MiQbdeQKgvr6fXUPb1u8c9onF570K3
         zOCh3500Azq76AcuHelI1VFxgkHi7P2eYNCm3PYdqDxUQzVU1kITMQsqBcjP4AfC9a2S
         BtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBj/QJiDI1iRxhSij6yvAToTc0lPb8hrcnwFkY6CwtQ=;
        b=BYkzQSFev+Fk/NnIOGFmZufY9pJJ+rFI2x9oYzgnsBpmabJL+58DR+U9QtXV8Kgqjl
         NPBfQ2XD0zF2CezVSS/EqOAyu0ph8BpEkVQsgl1z9aCETSZZ/DGlSqF1BsxAshb05jtt
         vY8ZnQWfLgMZ2tQaOWEqfLcVnIoLp5ZCJ7UL/y04va8eTXyBBlic5ECWuMIXatBeDT/t
         yr0tHw8NUf3WxyrDBMhWFqBXlecM+xi4yss2OSGzY24o9TYnYmajUc+EBwKafPGdzKHa
         fkVAwJ64/l1mvc1FW070JaW63NYWjT4+iFjcMSeVVE9cV8MFOsbYPwIP4StqqyFclEP4
         Oa1A==
X-Gm-Message-State: ANhLgQ07vvQrdQ9td+mzRBpNxdcz03ciHEmKPutYhIFqIZIyDjr/i3sp
        uuCwGF1Goh73wkUe/UUEw1//4w==
X-Google-Smtp-Source: ADFU+vtcoqgLb0gl1MUwbfsdEppuv9Wbvhq9wlTR7rOhf4HtBI85u+kPJ0OBjRLP2cTEvHzkroZUSA==
X-Received: by 2002:ac8:4788:: with SMTP id k8mr3535054qtq.357.1583343934969;
        Wed, 04 Mar 2020 09:45:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c12sm1149885qtk.41.2020.03.04.09.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 09:45:34 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Y5O-0002hV-3I; Wed, 04 Mar 2020 13:45:34 -0400
Date:   Wed, 4 Mar 2020 13:45:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] RDMA/core: Fix protection fault in
 ib_mr_pool_destroy
Message-ID: <20200304174534.GA10351@ziepe.ca>
References: <20200227112708.93023-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227112708.93023-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 01:27:08PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Fix NULL pointer dereference in the error flow of ib_create_qp_user
> when accessing to uninitialized list pointers - rdma_mrs and sig_mrs.
> The following crash from syzkaller revealed it.
> 
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 1 PID: 23167 Comm: syz-executor.1 Not tainted 5.5.0-rc5 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ib_mr_pool_destroy+0x81/0x1f0
> Code: 00 00 fc ff df 49 c1 ec 03 4d 01 fc e8 a8 ea 72 fe 41 80 3c 24 00
> 0f 85 62 01 00 00 48 8b 13 48 89 d6 4c 8d 6a c8 48 c1 ee 03 <42> 80 3c
> 3e 00 0f 85 34 01 00 00 48 8d 7a 08 4c 8b 02 48 89 fe 48
> RSP: 0018:ffffc9000951f8b0 EFLAGS: 00010046
> RAX: 0000000000040000 RBX: ffff88810f268038 RCX: ffffffff82c41628
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000951f850
> RBP: ffff88810f268020 R08: 0000000000000004 R09: fffff520012a3f0a
> R10: 0000000000000001 R11: fffff520012a3f0a R12: ffffed1021e4d007
> R13: ffffffffffffffc8 R14: 0000000000000246 R15: dffffc0000000000
> FS:  00007f54bc788700(0000) GS:ffff88811b100000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000116920002 CR4: 0000000000360ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  rdma_rw_cleanup_mrs+0x15/0x30
>  ib_destroy_qp_user+0x674/0x7d0
>  ib_create_qp_user+0xb01/0x11c0
>  create_qp+0x1517/0x2130
>  ib_uverbs_create_qp+0x13e/0x190
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  vfs_write+0x168/0x4a0
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x465b49
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f54bc787c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
> RDX: 0000000000000040 RSI: 0000000020000540 RDI: 0000000000000003
> RBP: 00007f54bc787c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f54bc7886bc
> R13: 00000000004ca2ec R14: 000000000070ded0 R15: 0000000000000005
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 54a28a9b6f83c561 ]---
> 
> Fixes: a060b5629ab06 ("IB/core: generic RDMA READ/WRITE API")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog:
>  v1: Rewrote as Jason requested in v0
>  v0: https://patchwork.kernel.org/patch/11377845/
> ---
>  drivers/infiniband/core/core_priv.h  | 14 ++++++++++++++
>  drivers/infiniband/core/uverbs_cmd.c |  9 ---------
>  drivers/infiniband/core/verbs.c      | 10 ----------
>  3 files changed, 14 insertions(+), 19 deletions(-)

Applied to for-rc, thanks

Jason
