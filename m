Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31223535DB4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiE0J6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 May 2022 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350723AbiE0J6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 May 2022 05:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FC5E36B79
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653645480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g70eeQab0Dc/APhWo7A5wxlMInbPG1Rn3g7zC/mVZsg=;
        b=CPgr3RNSdH1hZM9XPKslEbP6nDyj5rYHhU7tlQNWANQlTWN25/IT/UX9sgyAFEiElCjmbG
        AyVztofccpN/CgULXzXcJvaohRnolMJ6+MwtVWWNupWlF5gviT6HB8Jv8P7jFAgVWmMf7C
        /9GSNsfMnNogUw/sfvAntr8PDdhNPkA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-4f9NXIa7NfCf9z4YGM0pqw-1; Fri, 27 May 2022 05:57:55 -0400
X-MC-Unique: 4f9NXIa7NfCf9z4YGM0pqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCDF3803907;
        Fri, 27 May 2022 09:57:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2DBF2026D64;
        Fri, 27 May 2022 09:57:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Steve French <smfrench@gmail.com>
cc:     dhowells@redhat.com, willy@infradead.org,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Lockdep splat in RXE (softRoCE) driver in xarray accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3301351.1653645472.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 27 May 2022 10:57:52 +0100
Message-ID: <3301352.1653645472@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Zhu, Bob, Steve,

There seems to be a locking bug in the softRoCE driver when mounting a cif=
s
share.  See attached trace.  I'm guessing the problem is that a softirq
handler is accessing the xarray, but other accesses to the xarray aren't
guarded by _bh or _irq markers on the lock primitives.

I wonder if rxe_pool_get_index() should just rely on the RCU read lock and=
 not
take the spinlock.

Alternatively, __rxe_add_to_pool() should be using xa_alloc_cyclic_bh() or
xa_alloc_cyclic_irq().

I used the following commands:

   rdma link add rxe0 type rxe netdev enp6s0 # andromeda, softRoCE
   mount //192.168.6.1/scratch /xfstest.scratch -o user=3Dshares,rdma,pass=
=3D...

talking to ksmbd on the other side.

Kernel is v5.18-rc6.

David
---
infiniband rxe0: set active
infiniband rxe0: added enp6s0
RDS/IB: rxe0: added
CIFS: No dialect specified on mount. Default has changed to a more secure =
dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIFS (SMB1). To use the les=
s secure SMB1 dialect to access old servers which do not support SMB3.1.1 =
(or even SMB3 or SMB2.1) specify vers=3D1.0 on mount.
CIFS: Attempting to mount \\192.168.6.1\scratch

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
WARNING: inconsistent lock state
5.18.0-rc6-build2+ #465 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/1/20 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff888134d11310 (&xa->xa_lock#12){+.?.}-{2:2}, at: rxe_pool_get_index+0x1=
9/0x69
{SOFTIRQ-ON-W} state was registered at:
  mark_usage+0x169/0x17b
  __lock_acquire+0x50c/0x96a
  lock_acquire+0x2f4/0x37b
  _raw_spin_lock+0x2f/0x39
  xa_alloc_cyclic.constprop.0+0x20/0x55
  __rxe_add_to_pool+0xe3/0xf2
  __ib_alloc_pd+0xa2/0x26b
  ib_mad_port_open+0x1ac/0x4a1
  ib_mad_init_device+0x9b/0x1b9
  add_client_context+0x133/0x1b3
  enable_device_and_get+0x129/0x248
  ib_register_device+0x256/0x2fd
  rxe_register_device+0x18e/0x1b7
  rxe_net_add+0x57/0x71
  rxe_newlink+0x71/0x8e
  nldev_newlink+0x200/0x26a
  rdma_nl_rcv_msg+0x260/0x2ab
  rdma_nl_rcv+0x108/0x1a7
  netlink_unicast+0x1fc/0x2b3
  netlink_sendmsg+0x4ce/0x51b
  sock_sendmsg_nosec+0x41/0x4f
  __sys_sendto+0x157/0x1cc
  __x64_sys_sendto+0x76/0x82
  do_syscall_64+0x39/0x46
  entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 194111
hardirqs last  enabled at (194110): [<ffffffff81094eb2>] __local_bh_enable=
_ip+0xb8/0xcc
hardirqs last disabled at (194111): [<ffffffff82040077>] _raw_spin_lock_ir=
qsave+0x1b/0x51
softirqs last  enabled at (194100): [<ffffffff8240043a>] __do_softirq+0x43=
a/0x489
softirqs last disabled at (194105): [<ffffffff81094d30>] run_ksoftirqd+0x3=
1/0x56

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&xa->xa_lock#12);
  <Interrupt>
    lock(&xa->xa_lock#12);

 *** DEADLOCK ***

no locks held by ksoftirqd/1/20.

stack backtrace:
CPU: 1 PID: 20 Comm: ksoftirqd/1 Not tainted 5.18.0-rc6-build2+ #465
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 valid_state+0x56/0x61
 mark_lock_irq+0x9b/0x2ec
 ? ret_from_fork+0x1f/0x30
 ? valid_state+0x61/0x61
 ? stack_trace_save+0x8f/0xbe
 ? filter_irq_stacks+0x58/0x58
 ? jhash.constprop.0+0x1ad/0x202
 ? save_trace+0x17c/0x196
 mark_lock.part.0+0x10c/0x164
 mark_usage+0xe6/0x17b
 __lock_acquire+0x50c/0x96a
 lock_acquire+0x2f4/0x37b
 ? rxe_pool_get_index+0x19/0x69
 ? rcu_read_unlock+0x52/0x52
 ? jhash.constprop.0+0x1ad/0x202
 ? lockdep_unlock+0xde/0xe6
 ? validate_chain+0x44a/0x4a8
 ? req_next_wqe+0x312/0x363
 _raw_spin_lock_irqsave+0x41/0x51
 ? rxe_pool_get_index+0x19/0x69
 rxe_pool_get_index+0x19/0x69
 rxe_get_av+0xbe/0x14b
 rxe_requester+0x6b5/0xbb0
 ? rnr_nak_timer+0x16/0x16
 ? lock_downgrade+0xad/0xad
 ? rcu_read_lock_bh_held+0xab/0xab
 ? __wake_up+0xf/0xf
 ? mark_held_locks+0x1f/0x78
 ? __local_bh_enable_ip+0xb8/0xcc
 ? rnr_nak_timer+0x16/0x16
 rxe_do_task+0xb5/0x13d
 ? rxe_detach_mcast+0x1d6/0x1d6
 tasklet_action_common.constprop.0+0xda/0x145
 __do_softirq+0x202/0x489
 ? __irq_exit_rcu+0x108/0x108
 ? _local_bh_enable+0x1c/0x1c
 run_ksoftirqd+0x31/0x56
 smpboot_thread_fn+0x35c/0x376
 ? sort_range+0x1c/0x1c
 kthread+0x164/0x173
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>
CIFS: VFS: RDMA transport established

