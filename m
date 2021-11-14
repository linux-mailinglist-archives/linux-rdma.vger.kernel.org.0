Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E544F702
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Nov 2021 07:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKNGPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Nov 2021 01:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhKNGPt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Nov 2021 01:15:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2DDC61057;
        Sun, 14 Nov 2021 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636870376;
        bh=BtijAaolLcypRtYydUpK+anNEyF0BxN77mW8ft8RDqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJGJZvUMisU0TBjQOtimSdUT94T6mZNjMC22S0P95sSJLgiAV4zhiSjunppxmWcn5
         ocG0aVcVTw2BMLsfhXQcNfYGleciyDdWXn3EQCIkJ6BX3NYajp5EuBbfEBkAb0vewE
         DdNjgR7aNhNcWOD+hJUVpBsW5Lbu9EJOzdQwP6OIsWR4DW4FIwUgWkSwbh5tvaVRLS
         W9P8d9u0ABHP0jOwl7sErZ0Y27ppEkXsvMgrat6riiEe6gNd7Wx4bkZV2sEuLuZgw2
         zwU6xDZq5GkuyvA4vu3JG6nGPre8axvx2AgVtxdjCKJeDplGendOJDIrh3gZrbcngk
         KZ4fiEQ+FCiAA==
Date:   Sun, 14 Nov 2021 08:12:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: Task hung while using RTRS with rxe and using "ip" utility to
 down the interface
Message-ID: <YZCo5BwbTgKtbImi@unreal>
References: <CAJpMwyjTggq-q8YQd7iPyp_TA29z5mWcEFAKe_Zg0=Z3a843qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyjTggq-q8YQd7iPyp_TA29z5mWcEFAKe_Zg0=Z3a843qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 05:25:11PM +0100, Haris Iqbal wrote:
> Hi,
> 
> We are experiencing a hang while using RTRS with softROCE and
> transitioning the network interface down using ifdown command.
> 
> Steps.
> 1) Map an RNBD/RTRS device through softROCE port.
> 2) Once mapped, transition the eth interface to down (on which the
> softROCE interface was created) using command "ifconfig <ethx> down",
> or "ip link set <ethx> down".
> 3) The device errors out, and one can see RTRS connection errors in
> dmesg. So far so good.
> 4) After a while, we see task hung traces in dmesg.
> 
> [  550.866462] INFO: task kworker/1:2:170 blocked for more than 184 seconds.
> [  550.868820]       Tainted: G           O      5.10.42-pserver+ #84
> [  550.869337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  550.869963] task:kworker/1:2     state:D stack:    0 pid:  170
> ppid:     2 flags:0x00004000
> [  550.870619] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
> [  550.871134] Call Trace:
> [  550.871375]  __schedule+0x421/0x810
> [  550.871683]  schedule+0x46/0xb0
> [  550.871964]  schedule_timeout+0x20e/0x2a0
> [  550.872300]  ? internal_add_timer+0x44/0x70
> [  550.872650]  wait_for_completion+0x86/0xe0
> [  550.872994]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
> [  550.873357]  ? _cond_resched+0x15/0x30
> [  550.873680]  ? wait_for_completion+0x33/0xe0
> [  550.874036]  _destroy_id+0x57/0x210 [rdma_cm]
> [  550.874395]  rtrs_srv_close_work+0xcc/0x250 [rtrs_server]
> [  550.874819]  process_one_work+0x1d4/0x370
> [  550.875156]  worker_thread+0x4a/0x3b0
> [  550.875471]  ? process_one_work+0x370/0x370
> [  550.875817]  kthread+0xfe/0x140
> [  550.876098]  ? kthread_park+0x90/0x90
> [  550.876453]  ret_from_fork+0x1f/0x30
> 
> 
> Our observations till now.
> 
> 1) Does not occur if we use "ifdown <ethx>" instead. There is a
> difference between the commands, but we are not sure if the above one
> should lead to a task hang.
> https://access.redhat.com/solutions/27166
> 2) We have verified v5.10 and v.15.1 kernels, and both have this issue.
> 3) We tried the same test with NvmeOf target and host over softROCE.
> We get the same task hang after doing "ifconfig .. down".
> 
> [Tue Nov  9 14:28:51 2021] INFO: task kworker/1:1:34 blocked for more
> than 184 seconds.
> [Tue Nov  9 14:28:51 2021]       Tainted: G           O
> 5.10.42-pserver+ #84
> [Tue Nov  9 14:28:51 2021] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Tue Nov  9 14:28:51 2021] task:kworker/1:1     state:D stack:    0
> pid:   34 ppid:     2 flags:0x00004000
> [Tue Nov  9 14:28:51 2021] Workqueue: events
> nvmet_rdma_release_queue_work [nvmet_rdma]
> [Tue Nov  9 14:28:51 2021] Call Trace:
> [Tue Nov  9 14:28:51 2021]  __schedule+0x421/0x810
> [Tue Nov  9 14:28:51 2021]  schedule+0x46/0xb0
> [Tue Nov  9 14:28:51 2021]  schedule_timeout+0x20e/0x2a0
> [Tue Nov  9 14:28:51 2021]  ? internal_add_timer+0x44/0x70
> [Tue Nov  9 14:28:51 2021]  wait_for_completion+0x86/0xe0
> [Tue Nov  9 14:28:51 2021]  cm_destroy_id+0x18c/0x5a0 [ib_cm]
> [Tue Nov  9 14:28:51 2021]  ? _cond_resched+0x15/0x30
> [Tue Nov  9 14:28:51 2021]  ? wait_for_completion+0x33/0xe0
> [Tue Nov  9 14:28:51 2021]  _destroy_id+0x57/0x210 [rdma_cm]
> [Tue Nov  9 14:28:51 2021]  nvmet_rdma_free_queue+0x2e/0xc0 [nvmet_rdma]
> [Tue Nov  9 14:28:51 2021]  nvmet_rdma_release_queue_work+0x19/0x50 [nvmet_rdma]
> [Tue Nov  9 14:28:51 2021]  process_one_work+0x1d4/0x370
> [Tue Nov  9 14:28:51 2021]  worker_thread+0x4a/0x3b0
> [Tue Nov  9 14:28:51 2021]  ? process_one_work+0x370/0x370
> [Tue Nov  9 14:28:51 2021]  kthread+0xfe/0x140
> [Tue Nov  9 14:28:51 2021]  ? kthread_park+0x90/0x90
> [Tue Nov  9 14:28:51 2021]  ret_from_fork+0x1f/0x30
> 
> Is this an known issue with ifconfig or the rxe driver? Thoughts?

It doesn't look related to RXE and if to judge by the call trace the
issue is one of two: missing call to cm_deref_id() or extra call
to refcount_inc(&cm_id_priv->refcount). Both can be related to the
callers of rdma-cm interface. For example by not releasing cm_id
properly.

Thanks

> 
> Regards
> -Haris
