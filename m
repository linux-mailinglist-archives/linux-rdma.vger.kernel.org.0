Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431FA3FFB40
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhICHqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 03:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhICHqF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Sep 2021 03:46:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D5C061575;
        Fri,  3 Sep 2021 00:45:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id r13so3658272pff.7;
        Fri, 03 Sep 2021 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yGOCVEApc5uiEkEu3FJgjhpn9SMZGFsk3YICsg2bDAc=;
        b=A67nIpejPhVNfqvdhHKrrHCPK5RPBGNCv0/AZ9xE5yls5rGjII91LPLVAW4iayT89L
         hb8NSvJKt4ui3duZfKsRPwhIvP15FTsgPvKGZLv12tGE+sf2NwnJ9UvB8obYfdzImhYj
         ozUhRenw+NlM3WOx8meFqEWru8TUfVyzzhD7oLA7SDBb7OsVWBW3VVldbnIv8Di9yiLD
         0xWiS+Kuu7sCyp0veENVqDtyRw5yBH95y7VkCbXljmJ9NYgjXdq4lSQEfZNQzaIDMS88
         VPeEt+YL9lvRX1IgXvl+NJVqwvuN2iV/EDinrE07ECC62AeNWRLvL3x/PPCeCWnNQjT7
         vfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yGOCVEApc5uiEkEu3FJgjhpn9SMZGFsk3YICsg2bDAc=;
        b=NMs7iD+Xu6pW+Dx3LMs+afF6SB9Rxksg8GXLNFyuM14OzRu/ueg1dZr8+ddVggGnH6
         y6Sf92n99uPZpA64kWW0ioniWl80dUu0JtDRNlaL9oWAg94DS82v5ctqn6EYm4HQvXTc
         h2mdu8og+1gKImg9RDKfQNs4s4nZQZDq8ueBZ5hHq8ppierYA4W2OHigslHk9wym+QD5
         ZUIn7Ihv2KllnnyPOA2xqRyoJGf9qv68m7fQOzHKHW8pwUn0LhburKpVfHIDlbB2K2DV
         bACvr4aMBsgh/ReSEW319M6h7JBD1+xew/p0z0zrHwSyOkSxvom6IeRjqSC3ajWzQkMA
         L/hg==
X-Gm-Message-State: AOAM5302A0Ai1Caq+m5J109c/IwyTpJO1GKWpi3B0UNQEN5ydTHk4PfI
        LY+SbLuVHAMnuqmV+OATZBJLaKC0lJtcTs9PDw==
X-Google-Smtp-Source: ABdhPJzNrjQozvpeZZaDe3NIlZu5o8UH+hN2VINqQ0a/iNJZUShXQWIQ0tVaIPLD/OBFakfLEOhkSDbYV00kn7xQnrc=
X-Received: by 2002:a05:6a00:c81:b029:30e:21bf:4c15 with SMTP id
 a1-20020a056a000c81b029030e21bf4c15mr2052074pfv.70.1630655105826; Fri, 03 Sep
 2021 00:45:05 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 3 Sep 2021 15:44:54 +0800
Message-ID: <CACkBjsYvt46E2WqeJwEuemUr7pST_uk3=wvEBmdtdiAPmG40vQ@mail.gmail.com>
Subject: INFO: task hung in _destroy_id
To:     dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 9e9fb7655ed58-Merge tag 'net-next-5.15'
git tree: upstream
console output:
https://drive.google.com/file/d/19ZvzEBJnFYlQJIn-TklSjE9ZWsxoEF7X/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zgxbwaYkrM26KEmJ-5sUZX57gfXtRrwA/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:24041 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #12
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:14376 pid:24041 ppid: 23568 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 schedule_timeout+0x189/0x430 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0xb4/0x110 kernel/sched/completion.c:138
 _destroy_id+0x1a9/0x2b0 drivers/infiniband/core/cma.c:1870
 ucma_close_id+0x2e/0x40 drivers/infiniband/core/ucma.c:185
 ucma_destroy_private_ctx+0x379/0x390 drivers/infiniband/core/ucma.c:576
 ucma_close+0x8c/0xc0 drivers/infiniband/core/ucma.c:1797
 __fput+0xdf/0x380 fs/file_table.c:280
 task_work_run+0x86/0xd0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x418cd7
RSP: 002b:00007ffefd2964b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000418cd7
RDX: 0000000000000000 RSI: ffffffff84232888 RDI: 0000000000000003
RBP: 0000000000000004 R08: 000000000184cd11 R09: 0000000000000d11
R10: 000000000184cd15 R11: 0000000000000293 R12: 000000000071f980
R13: 00000000007903e0 R14: 00000000007903e8 R15: 0000000000284b14
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 1501 Comm: khungtaskd Not tainted 5.14.0+ #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:105
 nmi_cpu_backtrace+0x100/0x120 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x129/0x190 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x990 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 27236 Comm: syz-executor Not tainted 5.14.0+ #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 65 48 8b 14 25 40 70 01 00 81 e1 00 01 00 00 a9 00 01 ff 00 74
0e 85 c9 74 35 8b 82 34 15 00 00 85 c0 74 2b 8b 82 10 15 00 00 <83> f8
02 75 20 48 8b 8a 18 15 00 00 8b 92 14 15 00 00 48 8b 01 48
RSP: 0018:ffffc9000691f7f8 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88803f344690 RCX: 0000000000000000
RDX: ffff88804bf04480 RSI: ffffffff81742797 RDI: ffff88802c3e9620
RBP: ffff88802c3e9620 R08: ffff88803f344690 R09: 0000000000000000
R10: ffffc9000691f888 R11: 000000000004f358 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff84868a80 R15: 0000000000001412
FS:  00007f7b50cb0700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b50c85db8 CR3: 000000004bf2b000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 is_handle_aborted include/linux/jbd2.h:1700 [inline]
 __ext4_handle_dirty_metadata+0xf7/0x290 fs/ext4/ext4_jbd2.c:331
 ext4_do_update_inode fs/ext4/inode.c:5138 [inline]
 ext4_mark_iloc_dirty+0x5e0/0x1010 fs/ext4/inode.c:5723
 __ext4_mark_inode_dirty+0x122/0x3a0 fs/ext4/inode.c:5917
 ext4_dirty_inode+0x5b/0x80 fs/ext4/inode.c:5946
 __mark_inode_dirty+0x2dd/0x810 fs/fs-writeback.c:2398
 mark_inode_dirty include/linux/fs.h:2447 [inline]
 generic_write_end+0xf2/0x190 fs/buffer.c:2198
 ext4_da_write_end+0x183/0x510 fs/ext4/inode.c:3110
 generic_perform_write+0x11f/0x220 mm/filemap.c:3784
 ext4_buffered_write_iter+0xd6/0x190 fs/ext4/file.c:269
 ext4_file_write_iter+0x80/0x940 fs/ext4/file.c:680
 call_write_iter include/linux/fs.h:2158 [inline]
 do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
 do_iter_write+0xaf/0x250 fs/read_write.c:855
 vfs_iter_write+0x38/0x60 fs/read_write.c:896
 iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x4a/0x80 fs/splice.c:936
 splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
 do_splice_direct+0xc3/0x110 fs/splice.c:979
 do_sendfile+0x338/0x740 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46a9a9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b50cafc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046a9a9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000004
RBP: 00000000004e4042 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffb R11: 0000000000000246 R12: 000000000078c0a0
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffce4002c90
----------------
Code disassembly (best guess):
   0: 65 48 8b 14 25 40 70 mov    %gs:0x17040,%rdx
   7: 01 00
   9: 81 e1 00 01 00 00    and    $0x100,%ecx
   f: a9 00 01 ff 00        test   $0xff0100,%eax
  14: 74 0e                je     0x24
  16: 85 c9                test   %ecx,%ecx
  18: 74 35                je     0x4f
  1a: 8b 82 34 15 00 00    mov    0x1534(%rdx),%eax
  20: 85 c0                test   %eax,%eax
  22: 74 2b                je     0x4f
  24: 8b 82 10 15 00 00    mov    0x1510(%rdx),%eax
* 2a: 83 f8 02              cmp    $0x2,%eax <-- trapping instruction
  2d: 75 20                jne    0x4f
  2f: 48 8b 8a 18 15 00 00 mov    0x1518(%rdx),%rcx
  36: 8b 92 14 15 00 00    mov    0x1514(%rdx),%edx
  3c: 48 8b 01              mov    (%rcx),%rax
  3f: 48                    rex.W
