Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5A483F8E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiADKDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 05:03:18 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43902 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiADKDR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 05:03:17 -0500
Received: by mail-io1-f72.google.com with SMTP id j13-20020a0566022ccd00b005e9684c80c6so19560918iow.10
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jan 2022 02:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Q1E+t0oMoHaTGPrmwIqtIWewM2eKhWNWfmQTzKP2yFc=;
        b=2u2eyMKZZiFsoAfq/uBTy+DDE7qQQmoXVoQ/k+UqFEeGm3lM6hmYACFWNRVqBlplY6
         3AMYXRbFQ3vmIOSaXVHwvBloPuQpxj+Hrb+y6Ve5DQUjGwWO/Yd5RVhrCZhCVPC/gaQT
         dPZ/lHW5xKhtOKCc1TBJRazfup8Xsk59bzgOkZ2B9bSBCYWVdt5N2cezwPSocsovda2A
         xhI56rNo9viUJpKijI+PjaFfz7nfXotb6giXtX14Jg3J8P31fDtfXJXxhZpsIjkGU6Uq
         pBQ+cTHwtcw3Q7uFJckuGdmE4Oy6A0JJj464H0uOHCijJ2BS4lahSNSxvTt/pMT/YW/9
         AGfw==
X-Gm-Message-State: AOAM530uRNVtQokDrIIqlSoTC0TNLy8nTu8mYIv2GfW8DjgGxLcW13WN
        CaPkOQlQekmleUQ8FsaVXYvQqZ9qbWx8achJWLPi/GmuL/K6
X-Google-Smtp-Source: ABdhPJwb5D4MVQ/aRrEp1R7orXxh5xPAkBXZqP74ra9SMUH8iJP2+ItSyiT7sW8AADzyGmwSG8BX4nLUOpvXItwAbpIWNtHnafKM
MIME-Version: 1.0
X-Received: by 2002:a5d:9f4c:: with SMTP id u12mr22203049iot.22.1641290597348;
 Tue, 04 Jan 2022 02:03:17 -0800 (PST)
Date:   Tue, 04 Jan 2022 02:03:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000073ffa05d4bebff8@google.com>
Subject: [syzbot] KMSAN: kernel-infoleak in ucma_init_qp_attr
From:   syzbot <syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com>
To:     glider@google.com, jgg@ziepe.ca, leon@kernel.org,
        liangwenpeng@huawei.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, liweihang@huawei.com,
        syzkaller-bugs@googlegroups.com, tanxiaofei@huawei.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10c4260db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=6d532fa8f9463da290bc
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:209 [inline]
 ucma_init_qp_attr+0x8c7/0xb10 drivers/infiniband/core/ucma.c:1242
 ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x8ce/0x2030 fs/read_write.c:588
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable resp created at:
 ucma_init_qp_attr+0xa4/0xb10 drivers/infiniband/core/ucma.c:1214
 ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732

Bytes 40-59 of 144 are uninitialized
Memory access of size 144 starts at ffff888167523b00
Data copied to user address 0000000020000100

CPU: 1 PID: 25910 Comm: syz-executor.1 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
