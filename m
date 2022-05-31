Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0D539839
	for <lists+linux-rdma@lfdr.de>; Tue, 31 May 2022 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbiEaUqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbiEaUqp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 16:46:45 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BECF111C
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 13:46:43 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so4030696pju.1
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 13:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=p4Bwj/hJ7vb+uW9nV8bZYCwbdBeemcduOwRxRY0OEUY=;
        b=zur7npY5GtQlAIbf9gCcNonTSN8ErObNmV69TQLq3ZyqkujM3EXn0PQ6Gc9Ekqv7F7
         83tQHUa98TMxKCiu4zMoz78FoPWWSJfZ4NVIYdgHKn6XKNz/gXiENEGhcwQPbXGpQ5HE
         I2WDYaDPOdQKU+GtAcpG220TwlreZqtYPPmX0BZKxKjQl7pLYBKx609qFI/D9/8LinbI
         gudXWeA6cAD3u0sSNcT5XdgcziwxeT9zHmhOyRqXEf5V+3C5rUluIqCKzfDowPgp8CAG
         ji/MkR2KsfRJb2rlV+kkyORQLT8QTaGKld0t61w2ujHCoBSIGI5rKqS31xN/WcOlfgAv
         qDsw==
X-Gm-Message-State: AOAM5334QN/dd3792p+Od4Vjz8EsOXcmLMEGliGNgDWYICWs2YqvDz2O
        mwHuFhJyscksUV5Sc68di20nURDJfIHh/Q==
X-Google-Smtp-Source: ABdhPJz9JXvVFrwPb5eSt5JAPw06lWO/SRXPc0j1pFtzdAEab3SMH0WKra0HiUiQrfdyp66X9QyF/Q==
X-Received: by 2002:a17:902:d54b:b0:164:bf9:3e1e with SMTP id z11-20020a170902d54b00b001640bf93e1emr3913715plf.58.1654030003138;
        Tue, 31 May 2022 13:46:43 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902b11100b0015e8d4eb297sm11549024plr.225.2022.05.31.13.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:46:42 -0700 (PDT)
Message-ID: <24ed4fac-0519-be62-6817-b4a73050e805@acm.org>
Date:   Tue, 31 May 2022 13:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: rdma-for-next, rdma_rxe: inconsistent lock state
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

With the rdma-for-next branch (commit 9c477178a0a1 ("RDMA/rtrs-clt: Fix one
kernel-doc comment")) I see the following:

================================
WARNING: inconsistent lock state
5.18.0-dbg #4 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/2/25 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff888116f0d350 (&xa->xa_lock#12){+.?.}-{2:2}, at: rxe_pool_get_index+0x73/0x170 [rdma_rxe]
{SOFTIRQ-ON-W} state was registered at:
   __lock_acquire+0x45b/0xce0
   lock_acquire+0x18a/0x450
   _raw_spin_lock+0x34/0x50
   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
   __ib_alloc_pd+0xa3/0x270 [ib_core]
   ib_mad_port_open+0x44a/0x790 [ib_core]
   ib_mad_init_device+0x8e/0x110 [ib_core]
   add_client_context+0x26a/0x330 [ib_core]
   enable_device_and_get+0x169/0x2b0 [ib_core]
   ib_register_device+0x26f/0x330 [ib_core]
   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
   rxe_add+0x8c/0xc0 [rdma_rxe]
   rxe_net_add+0x5b/0x90 [rdma_rxe]
   rxe_newlink+0x71/0x80 [rdma_rxe]
   nldev_newlink+0x21e/0x370 [ib_core]
   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
   rdma_nl_rcv+0x140/0x220 [ib_core]
   netlink_unicast+0x307/0x460
   netlink_sendmsg+0x422/0x750
   __sys_sendto+0x1c2/0x250
   __x64_sys_sendto+0x7f/0x90
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 71543
hardirqs last  enabled at (71542): [<ffffffff810cdc28>] __local_bh_enable_ip+0x88/0xf0
hardirqs last disabled at (71543): [<ffffffff81e9d67d>] _raw_spin_lock_irqsave+0x5d/0x60
softirqs last  enabled at (71532): [<ffffffff82200467>] __do_softirq+0x467/0x6e1
softirqs last disabled at (71537): [<ffffffff810cda47>] run_ksoftirqd+0x37/0x60

other info that might help us debug this:
  Possible unsafe locking scenario:
        CPU0
        ----
   lock(&xa->xa_lock#12);
   <Interrupt>
     lock(&xa->xa_lock#12);

  *** DEADLOCK ***
no locks held by ksoftirqd/2/25.

stack backtrace:
CPU: 2 PID: 25 Comm: ksoftirqd/2 Not tainted 5.18.0-dbg #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
Call Trace:
  <TASK>
  show_stack+0x52/0x58
  dump_stack_lvl+0x5b/0x82
  dump_stack+0x10/0x12
  print_usage_bug.part.0+0x29c/0x2ab
  mark_lock_irq.cold+0x54/0xbf
  mark_lock.part.0+0x3f5/0xa70
  mark_usage+0x74/0x1a0
  __lock_acquire+0x45b/0xce0
  lock_acquire+0x18a/0x450
  _raw_spin_lock_irqsave+0x43/0x60
  rxe_pool_get_index+0x73/0x170 [rdma_rxe]
  rxe_get_av+0xcc/0x140 [rdma_rxe]
  rxe_requester+0x34c/0xe60 [rdma_rxe]
  rxe_do_task+0xcc/0x140 [rdma_rxe]
  tasklet_action_common.constprop.0+0x168/0x1b0
  tasklet_action+0x42/0x60
  __do_softirq+0x1d8/0x6e1
  run_ksoftirqd+0x37/0x60
  smpboot_thread_fn+0x302/0x410
  kthread+0x183/0x1c0
  ret_from_fork+0x1f/0x30
  </TASK>

Is this perhaps the same issue as what I reported on May 6
(https://lore.kernel.org/all/cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org/)?

Thanks,

Bart.
