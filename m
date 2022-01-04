Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE92748410D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 12:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiADLlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 06:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiADLlv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 06:41:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A5C061761;
        Tue,  4 Jan 2022 03:41:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A604B811B6;
        Tue,  4 Jan 2022 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A9CC36AE9;
        Tue,  4 Jan 2022 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641296507;
        bh=gmLzXCk+XCUIqYLhhlOH0oln3V/fnTwUQmNPvhxe3IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mm4vYpTGc65y345NH4JhQa7Gu3jZ/HTukDcgFTV3xPKqvPd+wooRImu9C32S95/MY
         Iy6F1O1+rkeji4qjXa8/ONdEO6Lw7wKgOK2tyT3KA76BgVGFXGDKVJw3HEjEaPkgRn
         S8aDDDr5KBO0lIrHib3ZpNRgo+6YcGpAKfaANHMZNa7Nd1xWo8/sH9/t4DxZ+pq6Mr
         g/cI5hbUcjmBAyi56KcIrvwPu0/rXhTFLEIkwJWg2Ox7C1R43V7rYHUTqrdF9Z90kd
         JARIkfp5enfecLoj7orSdJTsMGJO/9Ux8e3+mnfmjjVnmEUtNw8XEzu6RZZMQ66iBi
         pW4UCMSJ9oVuw==
Date:   Tue, 4 Jan 2022 13:41:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     syzbot <syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com>
Cc:     glider@google.com, jgg@ziepe.ca, liangwenpeng@huawei.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        liweihang@huawei.com, syzkaller-bugs@googlegroups.com,
        tanxiaofei@huawei.com, yuehaibing@huawei.com
Subject: Re: [syzbot] KMSAN: kernel-infoleak in ucma_init_qp_attr
Message-ID: <YdQydxgthE47Xhab@unreal>
References: <000000000000073ffa05d4bebff8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000073ffa05d4bebff8@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 04, 2022 at 02:03:17AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c4260db00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d532fa8f9463da290bc
> compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
>  instrument_copy_to_user include/linux/instrumented.h:121 [inline]
>  _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
>  copy_to_user include/linux/uaccess.h:209 [inline]
>  ucma_init_qp_attr+0x8c7/0xb10 drivers/infiniband/core/ucma.c:1242
>  ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
>  vfs_write+0x8ce/0x2030 fs/read_write.c:588
>  ksys_write+0x28b/0x510 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
>  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
>  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
>  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Local variable resp created at:
>  ucma_init_qp_attr+0xa4/0xb10 drivers/infiniband/core/ucma.c:1214
>  ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
> 
> Bytes 40-59 of 144 are uninitialized
> Memory access of size 144 starts at ffff888167523b00
> Data copied to user address 0000000020000100
> 
> CPU: 1 PID: 25910 Comm: syz-executor.1 Not tainted 5.16.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> =====================================================

We are not clearing GRH fields in ib_copy_ah_attr_to_user() if dst->is_global is not set.
I'm testing the fix now and will post the patch after it will pass CI.

Thanks

> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
