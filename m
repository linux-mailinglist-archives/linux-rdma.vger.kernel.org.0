Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC44B5948
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 19:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiBNSBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 13:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbiBNSBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 13:01:49 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06319C25
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 10:01:40 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id p10so9917525pfo.12
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 10:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=ZkRIbmzw4H0UBc1StEto2fVv7CD6TuWBJYrpqiXYbbA=;
        b=NVk57aQB1lyiljshIIUqcK6dU14K0+XpDK84IsipHKhfT7MJEhssIQwuDB3PSg6zqP
         Y2VHzgaLNKD4G/c1tBfilfBh0jg8isGE1yfQND9IMZwFzKqdOlr5L3wdWKTrDdh4WyYl
         ZL3Ul1O+WgRRNncfBjIzB8AB2fDqYRTQq4j1HcM0maYHOSthA1nLgxciiN/jClqE6VWd
         MlCd7M9i5agq2PrIz3jcvtTtplHZIW/50+Jola8Uq6IL0cz9J81ph7hQt5d2fy5M2U5p
         C1U2jcY+PkDw41fNH4CSmBSpF6i9Jsviz09olz0uRVrJ3cjoKnenPBgJ+05ZQrx2UGuP
         XuIA==
X-Gm-Message-State: AOAM533LhCq3D6AGGzGi1SpzN3GQlC5Bge4GRl1/zZdxTx1gkvLeOwgp
        +A27ZyPVOczhrRXl1nemvfA=
X-Google-Smtp-Source: ABdhPJx7UZJmkTs8Txqd5fwPOKu8vmWsyrQrrC5AYijTlzd52zuhGAQmH5Ik9XTlouxpJoEu7dvsVg==
X-Received: by 2002:a63:c106:: with SMTP id w6mr147456pgf.313.1644861699574;
        Mon, 14 Feb 2022 10:01:39 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id pc18sm3881266pjb.9.2022.02.14.10.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:01:38 -0800 (PST)
Message-ID: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
Date:   Mon, 14 Feb 2022 10:01:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Inconsistent lock state warning for rxe_poll_cq()
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

If I run the SRP tests against Jason's rdma/for-next branch then these
tests pass if I use the siw driver but not if I use the rdma_rxe driver.
Can you please take a look at the output triggered by running blktests?
If I run blktests as follows: ./check -q srp, the following output
appears:

WARNING: CPU: 1 PID: 1052 at kernel/softirq.c:363 __local_bh_enable_ip+0xa4/0xf0
  _raw_write_unlock_bh+0x31/0x40
  __rxe_add_index+0x38/0x50 [rdma_rxe]
  rxe_create_ah+0xce/0x1b0 [rdma_rxe]
  _rdma_create_ah+0x2c8/0x2f0 [ib_core]
  rdma_create_ah+0xfd/0x1c0 [ib_core]
  cm_alloc_msg+0xbc/0x280 [ib_cm]
  cm_alloc_priv_msg+0x2d/0x70 [ib_cm]
  ib_send_cm_req+0x4fe/0x830 [ib_cm]
  cma_connect_ib+0x3c4/0x600 [rdma_cm]
  rdma_connect_locked+0x145/0x490 [rdma_cm]
  rdma_connect+0x31/0x50 [rdma_cm]
  srp_send_req+0x58a/0x830 [ib_srp]
  srp_connect_ch+0x9f/0x1d0 [ib_srp]
  add_target_store+0xa6b/0xf20 [ib_srp]
  dev_attr_store+0x3e/0x60
  sysfs_kf_write+0x87/0xa0
  kernfs_fop_write_iter+0x1c7/0x270
  new_sync_write+0x296/0x3c0
  vfs_write+0x43c/0x580
  ksys_write+0xd9/0x180
  __x64_sys_write+0x42/0x50
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

[ ... ]

raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 1052 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x2f/0x50
Call Trace:
  <TASK>
  _raw_spin_unlock_irqrestore+0x6c/0x70
  ib_send_mad+0x4ca/0xa40 [ib_core]
  ib_post_send_mad+0x244/0x4b0 [ib_core]
  ib_send_cm_req+0x61b/0x830 [ib_cm]
  cma_connect_ib+0x3c4/0x600 [rdma_cm]
  rdma_connect_locked+0x145/0x490 [rdma_cm]
  rdma_connect+0x31/0x50 [rdma_cm]
  srp_send_req+0x58a/0x830 [ib_srp]
  srp_connect_ch+0x9f/0x1d0 [ib_srp]
  add_target_store+0xa6b/0xf20 [ib_srp]
  dev_attr_store+0x3e/0x60
  sysfs_kf_write+0x87/0xa0
  kernfs_fop_write_iter+0x1c7/0x270
  new_sync_write+0x296/0x3c0
  vfs_write+0x43c/0x580
  ksys_write+0xd9/0x180
  __x64_sys_write+0x42/0x50
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

[ ... ]

================================
WARNING: inconsistent lock state
5.17.0-rc1-dbg+ #3 Tainted: G        W
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/1/19 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff88811a85a228 (&ch->lock){+.?.}-{2:2}, at: srp_process_rsp+0x175/0x400 [ib_srp]
{SOFTIRQ-ON-W} state was registered at:
   lockdep_hardirqs_on_prepare.part.0+0x11b/0x1f0
   lockdep_hardirqs_on_prepare+0x43/0x50
   trace_hardirqs_on+0x22/0x120
   __local_bh_enable_ip+0x88/0xf0
   _raw_spin_unlock_bh+0x31/0x40
   rxe_poll_cq+0x164/0x180 [rdma_rxe]
   __ib_process_cq+0xab/0x3c0 [ib_core]
   ib_process_cq_direct+0x8c/0xc0 [ib_core]
   __srp_get_tx_iu+0x5d/0x160 [ib_srp]
   srp_queuecommand+0xf5/0x40c [ib_srp]
   scsi_dispatch_cmd+0x16a/0x530
   scsi_queue_rq+0x383/0x780
   blk_mq_dispatch_rq_list+0x344/0xc00
   __blk_mq_sched_dispatch_requests+0x19b/0x280
   blk_mq_sched_dispatch_requests+0x8a/0xc0
   __blk_mq_run_hw_queue+0x99/0x220
   __blk_mq_delay_run_hw_queue+0x372/0x3a0
   blk_mq_run_hw_queue+0x1d6/0x2b0
   blk_mq_sched_insert_request+0x208/0x290
   blk_execute_rq_nowait+0x9c/0xb0
   blk_execute_rq+0xcf/0x200
   __scsi_execute+0x220/0x340
   scsi_probe_lun.constprop.0+0x17c/0x670
   scsi_probe_and_add_lun+0x178/0x710
   __scsi_scan_target+0x17c/0x300
   scsi_scan_target+0xf1/0x110
   srp_add_target+0x2a5/0x490 [ib_srp]
   add_target_store+0xe30/0xf20 [ib_srp]
   dev_attr_store+0x3e/0x60
   sysfs_kf_write+0x87/0xa0
   kernfs_fop_write_iter+0x1c7/0x270
   new_sync_write+0x296/0x3c0
   vfs_write+0x43c/0x580
   ksys_write+0xd9/0x180
   __x64_sys_write+0x42/0x50
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 76629
hardirqs last  enabled at (76628): [<ffffffff810ce588>] __local_bh_enable_ip+0x88/0xf0
hardirqs last disabled at (76629): [<ffffffff81e669bd>] _raw_spin_lock_irqsave+0x5d/0x60
softirqs last  enabled at (76618): [<ffffffff82200467>] __do_softirq+0x467/0x6e1
softirqs last disabled at (76623): [<ffffffff810ce3a7>] run_ksoftirqd+0x37/0x60

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&ch->lock);
   <Interrupt>
     lock(&ch->lock);

  *** DEADLOCK ***

no locks held by ksoftirqd/1/19.

stack backtrace:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Tainted: G        W         5.17.0-rc1-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
Call Trace:
  <TASK>
  show_stack+0x52/0x58
  dump_stack_lvl+0x5b/0x82
  dump_stack+0x10/0x12
  print_usage_bug.part.0+0x29c/0x2ab
  mark_lock_irq.cold+0x54/0xbf
  ? lock_chain_count+0x20/0x20
  ? stack_trace_save+0x94/0xc0
  ? filter_irq_stacks+0x70/0x70
  ? __asan_loadN+0xf/0x20
  ? jhash.constprop.0+0x1bc/0x220
  ? save_trace+0x174/0x2d0
  mark_lock+0x414/0xac0
  ? mark_lock_irq+0xf70/0xf70
  mark_usage+0x74/0x1a0
  __lock_acquire+0x45b/0xce0
  lock_acquire.part.0+0x126/0x2f0
  ? srp_process_rsp+0x175/0x400 [ib_srp]
  ? rcu_read_unlock+0x50/0x50
  ? __this_cpu_preempt_check+0x13/0x20
  lock_acquire+0x9b/0x1a0
  ? srp_process_rsp+0x175/0x400 [ib_srp]
  _raw_spin_lock_irqsave+0x43/0x60
  ? srp_process_rsp+0x175/0x400 [ib_srp]
  srp_process_rsp+0x175/0x400 [ib_srp]
  srp_recv_done+0x184/0x360 [ib_srp]
  ? rxe_poll_cq+0x164/0x180 [rdma_rxe]
  ? srp_process_rsp+0x400/0x400 [ib_srp]
  ? __this_cpu_preempt_check+0x13/0x20
  __ib_process_cq+0x11b/0x3c0 [ib_core]
  ib_poll_handler+0x47/0x1f0 [ib_core]
  irq_poll_softirq+0x12f/0x2e0
  __do_softirq+0x1d8/0x6e1
  run_ksoftirqd+0x37/0x60
  smpboot_thread_fn+0x302/0x410
  ? __irq_exit_rcu+0x140/0x140
  ? __smpboot_create_thread.part.0+0x1c0/0x1c0
  kthread+0x15f/0x190
  ? kthread_complete_and_exit+0x30/0x30
  ret_from_fork+0x1f/0x30
  </TASK>
