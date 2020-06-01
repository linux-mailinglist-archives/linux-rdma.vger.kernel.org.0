Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114F1EA548
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFANtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 09:49:21 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:57503 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFANtU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 09:49:20 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 051Dkdt3031616;
        Mon, 1 Jun 2020 06:46:40 -0700
Date:   Mon, 1 Jun 2020 19:16:38 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: iSERT completions hung due to unavailable iscsit tag
Message-ID: <20200601134637.GA17657@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I observe, iscsit_allocate_cmd() process waiting indefinitely for
'iscsit tag' to become available.

Here is the scenario:
- at initiator, run "iozone -i 0 -I -+d -s 100000 -r 16384 -w" in an
  infinite loop.
- after few seconds, target fails to obtain 'tag' from
  sbitmap_queue_get(), while processing ISCSI_CTRL PDU via
isert_recv_done().
- then iscsit waits there for tag to become available, by calling
  schedule() in iscsit_wait_for_tag()
- and the process never scheduled back again, not sure why.

Due to this blockage the whole completion logic at iSER target went to
grinding halt, causing NOPOUT request timeouts at initator, and below
hung traces at target. Is this a known issue?

Target:
[May 7 20:30] iSCSI Login timeout on Network Portal 102.1.1.6:3260
[May 7 20:33] kworker/dying (2185) used greatest stack depth: 11672
bytes left
[  +2.640115] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[ +26.031050] INFO: task iscsi_np:8387 blocked for more than 122
seconds.
[  +0.000004]       Not tainted 5.7.0-rc2+ #2
[  +0.000001] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000001] iscsi_np        D14304  8387      2 0x80004084
[  +0.000005] Call Trace:
[  +0.000008]  ? __schedule+0x274/0x5e0
[  +0.000003]  ? stack_trace_save+0x46/0x70
[  +0.000002]  schedule+0x45/0xb0
[  +0.000002]  schedule_timeout+0x1d6/0x290
[  +0.000001]  wait_for_completion+0x82/0xe0
[  +0.000007]  iscsi_check_for_session_reinstatement+0x205/0x260
[iscsi_target_mod]
[  +0.000004]  iscsi_target_do_login+0xe3/0x5c0 [iscsi_target_mod]
[  +0.000004]  iscsi_target_start_negotiation+0x4c/0xa0
[iscsi_target_mod]
[  +0.000004]  iscsi_target_login_thread+0x86f/0x1000 [iscsi_target_mod]
[  +0.000003]  kthread+0xf3/0x130
[  +0.000004]  ? iscsi_target_login_sess_out+0x1f0/0x1f0
[iscsi_target_mod]
[  +0.000001]  ? kthread_bind+0x10/0x10
[  +0.000002]  ret_from_fork+0x35/0x40
[  +0.000003] INFO: task iscsi_ttx:8863 blocked for more than 122
seconds.
[  +0.000001]       Not tainted 5.7.0-rc2+ #2
[  +0.000000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000001] iscsi_ttx       D14384  8863      2 0x80004084
[  +0.000003] Call Trace:
[  +0.000002]  ? __schedule+0x274/0x5e0
[  +0.000004]  ? c4iw_ib_modify_qp+0xf3/0x160 [iw_cxgb4]
[  +0.000002]  schedule+0x45/0xb0
[  +0.000002]  schedule_timeout+0x1d6/0x290
[  +0.000001]  wait_for_completion+0x82/0xe0
[  +0.000003]  __ib_drain_sq+0x147/0x170
[  +0.000002]  ? ib_sg_to_pages+0x1a0/0x1a0
[  +0.000003]  ib_drain_sq+0x6e/0x80
[  +0.000002]  ib_drain_qp+0x9/0x20
[  +0.000002]  isert_wait_conn+0x51/0x2c0 [ib_isert]
[  +0.000004]  iscsit_close_connection+0x14c/0x840 [iscsi_target_mod]
[  +0.000002]  ? __schedule+0x27c/0x5e0
[  +0.000004]  iscsit_take_action_for_connection_exit+0x79/0x100
[iscsi_target_mod]
[  +0.000003]  iscsi_target_tx_thread+0x160/0x200 [iscsi_target_mod]
[  +0.000004]  ? wait_woken+0x80/0x80
[  +0.000002]  kthread+0xf3/0x130
[  +0.000003]  ? iscsit_thread_get_cpumask+0x80/0x80 [iscsi_target_mod]
[  +0.000001]  ? kthread_bind+0x10/0x10
[  +0.000001]  ret_from_fork+0x35/0x40
[  +0.000003] NMI backtrace for cpu 7
[  +0.000002] CPU: 7 PID: 493 Comm: khungtaskd Not tainted 5.7.0-rc2+ #2
[  +0.000001] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
10/24/2018
[  +0.000001] Call Trace:
[  +0.000003]  dump_stack+0x50/0x6b
[  +0.000002]  nmi_cpu_backtrace+0x9e/0xb0
[  +0.000003]  ? lapic_can_unplug_cpu+0x90/0x90
[  +0.000002]  nmi_trigger_cpumask_backtrace+0x9c/0xf0
[  +0.000003]  watchdog+0x310/0x4f0
[  +0.000002]  kthread+0xf3/0x130
[  +0.000002]  ? hungtask_pm_notify+0x40/0x40
[  +0.000001]  ? kthread_bind+0x10/0x10
[  +0.000001]  ret_from_fork+0x35/0x40
[  +0.000002] Sending NMI from CPU 7 to CPUs 0-6:
[  +0.000009] NMI backtrace for cpu 0 skipped: idling at
acpi_processor_ffh_cstate_enter+0x6f/0xc0
[  +0.000001] NMI backtrace for cpu 4 skipped: idling at
acpi_processor_ffh_cstate_enter+0x6f/0xc0
[  +0.000002] NMI backtrace for cpu 1 skipped: idling at
acpi_processor_ffh_cstate_enter+0x6f/0xc0
[  +0.000019] NMI backtrace for cpu 2 skipped: idling at
acpi_processor_ffh_cstate_enter+0x6f/0xc0
[  +0.000001] NMI backtrace for cpu 6 skipped: idling at
acpi_processor_ffh_cstate_enter+0x6f/0xc0
[  +0.000010] NMI backtrace for cpu 5
[  +0.000000] CPU: 5 PID: 4465 Comm: kworker/5:1H Not tainted 5.7.0-rc2+
#2
[  +0.000000] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
10/24/2018
[  +0.000001] Workqueue: ib-comp-wq ib_cq_poll_work
[  +0.000000] RIP: 0010:__free_pages+0xe/0x60


Initiator:
[ 2002.689250]  connection5:0: ping timeout of 5 secs expired, recv
timeout 5, last rx 4296659424, last ping 4296664448, now 4296669696
[ 2002.689275]  connection5:0: detected conn error (1022)



Thanks,
Krishna.
