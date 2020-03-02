Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AB176378
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCBTJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 14:09:16 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43476 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgCBTJQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 14:09:16 -0500
Received: by mail-il1-f198.google.com with SMTP id o13so445935ilf.10
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 11:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7npg9knZWi2ugFm6fusxk5+E+5/cR+9pt+PLR8BrWY8=;
        b=hsqMFNZlQVkvyttpLBdD0T3+HPfTNzVEM1W1FG7x+brwIDCftTAIG7ht+JeHLRLxVj
         9oaEBbX6xM9ffv0TBZtsV81JCH+qvq9q5Y9brpT3a6ie3kU2C6/sd+m8lZL5Azv6vFHg
         4yM2PkTylkQfezzDOsPzGGQZokPmvJlpmij3GDAQ/NtFr2mFI1XkiinVaWRJoWlOMCeP
         gZLclXC8ZM8GiacwkStc17nbocFsxwARIxDiIFa5G9BKCEjdXYKmLSbccAIare0Xvdsb
         RfMaZwqrFqa0Ai9t/hPubzjcR1K0hQZCn/ZiWwqbX8lQaFgYfh/Ao7JkF0aTW39Oi1tN
         h5uA==
X-Gm-Message-State: ANhLgQ0bBkON9KAWcy66+jGU2zhSJCuQmuJkHZWNDjtUVfXfggt54dpk
        wsN6Xa2XE2SJEH2KYWcC+fUrkTDPkG2OvQkUUEg/wj6p+wCq
X-Google-Smtp-Source: ADFU+vtqfJorUl9RSyFXcBA9L34wwi7PU6/k7E3cw5PwiysS/ospyxs+EuwJrBrwvF+B5jkzYEtYcQfYUfBKFdm1aijSRvyk8w5D
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cce:: with SMTP id j14mr843248iow.23.1583176155259;
 Mon, 02 Mar 2020 11:09:15 -0800 (PST)
Date:   Mon, 02 Mar 2020 11:09:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059e701059fe3ec2f@google.com>
Subject: INFO: task hung in rdma_destroy_id
From:   syzbot <syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160452c3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=0abbad99bee187cf63d4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com

INFO: task syz-executor.5:27890 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28072 27890  11077 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3380 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4080
 schedule+0xdc/0x2b0 kernel/sched/core.c:4154
 schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
 do_wait_for_common kernel/sched/completion.c:83 [inline]
 __wait_for_common kernel/sched/completion.c:104 [inline]
 wait_for_common kernel/sched/completion.c:115 [inline]
 wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
 rdma_destroy_id+0x680/0xdd0 drivers/infiniband/core/cma.c:1850
 ucma_close+0x115/0x310 drivers/infiniband/core/ucma.c:1762
 __fput+0x2ff/0x890 fs/file_table.c:280
 ____fput+0x16/0x20 fs/file_table.c:313
 task_work_run+0x145/0x1c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x416011
Code: 49 89 fc 48 83 e7 0f 48 81 cf f0 00 00 00 49 8d 43 04 4c 39 d0 0f 83 ec 00 00 00 41 88 38 90 49 c1 ec 04 48 39 d6 74 5d 49 83 <f9> 08 73 48 0f b6 02 48 89 cf 4c 89 c9 48 d3 e0 49 09 c4 90 48 8d
RSP: 002b:00007ffe941054c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000416011
RDX: 0000001b2fe20000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00000000b9fbf2f5 R09: 00000000b9fbf2f9
R10: 00007ffe941055a0 R11: 0000000000000293 R12: 000000000076c920
R13: 000000000076c920 R14: 0000000000264fc6 R15: 000000000076bfcc

Showing all locks held in the system:
2 locks held by kworker/u4:2/99:
 #0: ffff8880ae937558 (&rq->lock){-.-.}, at: newidle_balance+0xa28/0xe80 kernel/sched/fair.c:10219
 #1: ffffc90001217dc0 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}, at: process_one_work+0x917/0x17a0 kernel/workqueue.c:2239
1 lock held by khungtaskd/1135:
 #0: ffffffff89bac340 (rcu_read_lock){....}, at: debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5333
2 locks held by rsyslogd/10884:
 #0: ffff88809b6e6ba0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110 fs/file.c:821
 #1: ffffffff89ba13f8 (logbuf_lock){-.-.}, at: is_bpf_image_address+0x0/0x290 kernel/bpf/trampoline.c:86
2 locks held by getty/11006:
 #0: ffff888094516090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000184b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11007:
 #0: ffff888094714090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000185b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11008:
 #0: ffff8880906b4090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000186b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11009:
 #0: ffff888092b2c090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000187b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11010:
 #0: ffff88807bf93090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900017e72e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11011:
 #0: ffff88808599f090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000188b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/11012:
 #0: ffff8880a2abd090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900017db2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1135 Comm: khungtaskd Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
 arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xb11/0x10c0 kernel/hung_task.c:289
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 99 Comm: kworker/u4:2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs+0x7a/0xb0 kernel/rcu/tree.c:301
Code: ec e8 51 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 17 <8b> 83 d8 00 00 00 48 83 c4 08 5b 41 5c 5d d1 e8 83 f0 01 83 e0 01
RSP: 0018:ffffc90001217c98 EFLAGS: 00000246
RAX: 0000000000000003 RBX: ffff8880ae938300 RCX: ffffffff816226d4
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880ae9383d8
RBP: ffffc90001217cb0 R08: 1ffff11015d2707b R09: ffffed1015d2707c
R10: ffffed1015d2707b R11: ffff8880ae9383db R12: ffff8880ae9383d8
R13: 0000000000000363 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000009b725000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rcu_is_watching+0x10/0x30 kernel/rcu/tree.c:919
 rcu_read_unlock include/linux/rcupdate.h:651 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:411 [inline]
 batadv_nc_worker+0x480/0x760 net/batman-adv/network-coding.c:718
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
