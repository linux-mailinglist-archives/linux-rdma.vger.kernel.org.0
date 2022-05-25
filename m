Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0461A533B37
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiEYLBn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiEYLBh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 07:01:37 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA27CFD
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 04:01:07 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id p19so3792978wmg.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 04:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f7RS0gBSsRQnUMJsl5VPApKLqGDBZajmEpSTB4wAjYg=;
        b=11Rx8JUx4ZqG2+vTSsn5dqaExl4qvb1f7R13shb1lJMcax40y0nc0Q/4LT+OYdXZiz
         rZ3fizAoBo8mhdpvlAKFAzqXCeFm9NgAaecGqEkByvYXnAkeZHM30LB3Gvx3l3R1lBig
         G3AAOObl+PBz1STEupxme8/WvAGyVE9LKv5o13yLhB0izk8ieKjHl/T4tGC1/cKx/jJh
         CvAwRqAK99mQu0Sm65Yx6NkhAoaICtGgMppbBQ4c02vHxeviq+c6gK20uDVZl38dCTGZ
         kK1IptDQ3aB4r125Fn+H3si4yxJ7tNBW/ndSd4AarB7tHouSjPD+60gma+qdsk3x0q7X
         fq5Q==
X-Gm-Message-State: AOAM532zf2mVBS0dyppX7+vSBK9VHqovkR+9nR9wy95w9NTwLgSTAez3
        JZaw2tUaqWgZqr9s5ujEqic=
X-Google-Smtp-Source: ABdhPJwG8dNCXVCFAxe7V/IznJS9iXj014quDKKguNryuNNo5doAkYQgo7Z9zWnzTKfLZfWfxjV5jw==
X-Received: by 2002:a05:600c:4311:b0:397:4c1f:9f54 with SMTP id p17-20020a05600c431100b003974c1f9f54mr7573234wme.32.1653476465359;
        Wed, 25 May 2022 04:01:05 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d55c7000000b0020c5253d8d3sm1784402wrw.31.2022.05.25.04.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 04:01:04 -0700 (PDT)
Message-ID: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
Date:   Wed, 25 May 2022 14:01:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hello
> Below WARNING triggered by blktests nvmeof-mp/002, it can be
> reproduced with the latest 5.16.0-rc3 and also exists on 5.12, pls
> check it.

iirc this was reported before, based on my analysis lockdep is giving
a false alarm here. The reason is that the id_priv->handler_mutex cannot
be the same for both cm_id that is handling the connect and the cm_id
that is handling the rdma_destroy_id because rdma_destroy_id call
is always called on a already disconnected cm_id, so this deadlock
lockdep is complaining about cannot happen.

I'm not sure how to settle this.

> 
> # use_siw=1 ./check nvmeof-mp/002
> nvmeof-mp/002 (File I/O on top of multipath concurrently with logout
> and login (mq)) [passed]
>      runtime  41.767s  ...  36.877s
> # ./check nvmeof-mp/002
> nvmeof-mp/002 (File I/O on top of multipath concurrently with logout
> and login (mq)) [passed]
>      runtime    ...  41.277s
> 
> [  609.166100] run blktests nvmeof-mp/002 at 2021-12-03 21:27:52
> [  609.977883] null_blk: module loaded
> [  610.538697] rdma_rxe: loaded
> [  610.602763] infiniband eno1_rxe: set active
> [  610.602782] infiniband eno1_rxe: added eno1
> [  610.639520] eno2 speed is unknown, defaulting to 1000
> [  610.644946] eno2 speed is unknown, defaulting to 1000
> [  610.650318] eno2 speed is unknown, defaulting to 1000
> [  610.690546] infiniband eno2_rxe: set down
> [  610.690553] infiniband eno2_rxe: added eno2
> [  610.691112] eno2 speed is unknown, defaulting to 1000
> [  610.714293] eno2 speed is unknown, defaulting to 1000
> [  610.729535] eno3 speed is unknown, defaulting to 1000
> [  610.734666] eno3 speed is unknown, defaulting to 1000
> [  610.740026] eno3 speed is unknown, defaulting to 1000
> [  610.781372] infiniband eno3_rxe: set down
> [  610.781379] infiniband eno3_rxe: added eno3
> [  610.781906] eno3 speed is unknown, defaulting to 1000
> [  610.806211] eno2 speed is unknown, defaulting to 1000
> [  610.811508] eno3 speed is unknown, defaulting to 1000
> [  610.826655] eno4 speed is unknown, defaulting to 1000
> [  610.831810] eno4 speed is unknown, defaulting to 1000
> [  610.837176] eno4 speed is unknown, defaulting to 1000
> [  610.885844] infiniband eno4_rxe: set down
> [  610.885850] infiniband eno4_rxe: added eno4
> [  610.886426] eno4 speed is unknown, defaulting to 1000
> [  611.266756] Loading iSCSI transport class v2.0-870.
> [  611.335358] iscsi: registered transport (iser)
> [  611.387969] nvmet: adding nsid 1 to subsystem nvme-test
> [  611.403878] eno2 speed is unknown, defaulting to 1000
> [  611.409276] eno3 speed is unknown, defaulting to 1000
> [  611.414522] eno4 speed is unknown, defaulting to 1000
> [  611.468712] Rounding down aligned max_sectors from 4294967295 to 4294967288
> [  611.469203] db_root: cannot open: /etc/target
> [  611.515816] nvmet_rdma: enabling port 1 (10.16.221.116:7777)
> [  611.622158] eno2 speed is unknown, defaulting to 1000
> [  611.628243] eno3 speed is unknown, defaulting to 1000
> [  611.633422] eno4 speed is unknown, defaulting to 1000
> [  611.703648] eno2 speed is unknown, defaulting to 1000
> [  611.708949] eno3 speed is unknown, defaulting to 1000
> [  611.714267] eno4 speed is unknown, defaulting to 1000
> [  611.754520] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 00000000d0d64a6d
> [  611.765454] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 00000000d0d64a6d
> [  611.767778] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 000000007ccc375a
> [  611.767935] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added eno1_rxe.
> [  611.777083] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 289
> cm_id= 000000007ccc375a
> --snip--
> [  612.132317] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 00000000cede4b76
> [  612.132452] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [  612.132537] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 0000000070c2f22c
> [  612.157849] nvmet:nvmet_execute_io_connect: nvmet: adding queue 1 to ctrl 1.
> [  612.158194] nvmet:nvmet_execute_io_connect: nvmet: adding queue 2 to ctrl 1.
> [  612.158548] nvmet:nvmet_execute_io_connect: nvmet: adding queue 3 to ctrl 1.
> [  612.158854] nvmet:nvmet_execute_io_connect: nvmet: adding queue 4 to ctrl 1.
> [  612.159173] nvmet:nvmet_execute_io_connect: nvmet: adding queue 5 to ctrl 1.
> [  612.159510] nvmet:nvmet_execute_io_connect: nvmet: adding queue 6 to ctrl 1.
> [  612.159853] nvmet:nvmet_execute_io_connect: nvmet: adding queue 7 to ctrl 1.
> [  612.160225] nvmet:nvmet_execute_io_connect: nvmet: adding queue 8 to ctrl 1.
> [  612.160572] nvmet:nvmet_execute_io_connect: nvmet: adding queue 9 to ctrl 1.
> [  612.160885] nvmet:nvmet_execute_io_connect: nvmet: adding queue 10 to ctrl 1.
> [  612.161216] nvmet:nvmet_execute_io_connect: nvmet: adding queue 11 to ctrl 1.
> [  612.161759] nvmet:nvmet_execute_io_connect: nvmet: adding queue 12 to ctrl 1.
> [  612.162123] nvmet:nvmet_execute_io_connect: nvmet: adding queue 13 to ctrl 1.
> [  612.162473] nvmet:nvmet_execute_io_connect: nvmet: adding queue 14 to ctrl 1.
> [  612.162793] nvmet:nvmet_execute_io_connect: nvmet: adding queue 15 to ctrl 1.
> [  612.163135] nvmet:nvmet_execute_io_connect: nvmet: adding queue 16 to ctrl 1.
> [  612.163458] nvmet:nvmet_execute_io_connect: nvmet: adding queue 17 to ctrl 1.
> [  612.163776] nvmet:nvmet_execute_io_connect: nvmet: adding queue 18 to ctrl 1.
> [  612.164103] nvmet:nvmet_execute_io_connect: nvmet: adding queue 19 to ctrl 1.
> [  612.164417] nvmet:nvmet_execute_io_connect: nvmet: adding queue 20 to ctrl 1.
> [  612.164700] nvmet:nvmet_execute_io_connect: nvmet: adding queue 21 to ctrl 1.
> [  612.164971] nvmet:nvmet_execute_io_connect: nvmet: adding queue 22 to ctrl 1.
> [  612.165275] nvmet:nvmet_execute_io_connect: nvmet: adding queue 23 to ctrl 1.
> [  612.165689] nvmet:nvmet_execute_io_connect: nvmet: adding queue 24 to ctrl 1.
> [  612.166082] nvmet:nvmet_execute_io_connect: nvmet: adding queue 25 to ctrl 1.
> [  612.166383] nvmet:nvmet_execute_io_connect: nvmet: adding queue 26 to ctrl 1.
> [  612.166663] nvmet:nvmet_execute_io_connect: nvmet: adding queue 27 to ctrl 1.
> [  612.166963] nvmet:nvmet_execute_io_connect: nvmet: adding queue 28 to ctrl 1.
> [  612.167273] nvmet:nvmet_execute_io_connect: nvmet: adding queue 29 to ctrl 1.
> [  612.167529] nvmet:nvmet_execute_io_connect: nvmet: adding queue 30 to ctrl 1.
> [  612.167804] nvmet:nvmet_execute_io_connect: nvmet: adding queue 31 to ctrl 1.
> [  612.168114] nvmet:nvmet_execute_io_connect: nvmet: adding queue 32 to ctrl 1.
> [  612.168523] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.16.221.116:7777
> [  612.293734] device-mapper: multipath service-time: version 0.3.0 loaded
> [  612.296099] device-mapper: table: 253:3: multipath: error getting
> device (-EBUSY)
> [  612.303676] device-mapper: ioctl: error adding target to table
> [  612.501014] device-mapper: table: 253:3: multipath: error getting
> device (-EBUSY)
> [  612.508751] device-mapper: ioctl: error adding target to table
> [  612.514717] device-mapper: table: 253:3: multipath: error getting
> device (-EBUSY)
> [  612.522632] device-mapper: ioctl: error adding target to table
> [  612.950887] device-mapper: table: 253:3: multipath: error getting
> device (-EBUSY)
> [  612.958616] device-mapper: ioctl: error adding target to table
> [  613.869348] EXT4-fs (dm-3): mounted filesystem without journal.
> Opts: (null). Quota mode: none.
> [  613.869619] ext4 filesystem being mounted at
> /root/kernel-tests/storage/blktests/nvme/nvmeof-mp/blktests/results/tmpdir.nvmeof-mp.002.ZYO/mnt0
> supports timestamps until 2038 (0x7fffffff)
> [  617.144570] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  617.272414] nvmet:nvmet_execute_keep_alive: nvmet: ctrl 1 update
> keep-alive timer for 5 secs
> [  622.775724] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  627.895810] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  633.015369] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  638.138209] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  643.254966] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  644.822178] eno2 speed is unknown, defaulting to 1000
> [  644.827494] eno3 speed is unknown, defaulting to 1000
> [  644.832797] eno4 speed is unknown, defaulting to 1000
> [  648.377790] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  651.364570] nvme nvme0: Removing ctrl: NQN "nvme-test"
> [  651.430891] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 000000009ae8bc67
> [  651.430914] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 000000009ae8bc67 queue->state= 1
> [  651.430983] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 0000000078827089
> [  651.430994] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 0000000078827089 queue->state= 1
> --snip--
> [  651.438145] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 00000000cede4b76
> [  651.438150] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> 
> [  651.448883] ======================================================
> [  651.455061] WARNING: possible circular locking dependency detected
> [  651.461242] 5.16.0-rc3+ #2 Tainted: G S        I
> [  651.466380] ------------------------------------------------------
> [  651.472559] kworker/14:4/4839 is trying to acquire lock:
> [  651.477873] ffff8884c0e353e0 (&id_priv->handler_mutex){+.+.}-{3:3},
> at: rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.487623]
>                 but task is already holding lock:
> [  651.493453] ffff8883cc21fe00
> ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
> process_one_work+0x888/0x1740
> [  651.504062]
>                 which lock already depends on the new lock.
> 
> [  651.512233]
>                 the existing dependency chain (in reverse order) is:
> [  651.519715]
>                 -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
> [  651.527894]        lock_acquire+0x1d2/0x5a0
> [  651.532079]        process_one_work+0x8da/0x1740
> [  651.536700]        worker_thread+0x87/0xbf0
> [  651.540886]        kthread+0x3aa/0x490
> [  651.544637]        ret_from_fork+0x1f/0x30
> [  651.548737]
>                 -> #2 ((wq_completion)events){+.+.}-{0:0}:
> [  651.555349]        lock_acquire+0x1d2/0x5a0
> [  651.559535]        flush_workqueue+0x109/0x15f0
> [  651.564067]        nvmet_rdma_queue_connect+0x1c79/0x2610 [nvmet_rdma]
> [  651.570594]        cma_cm_event_handler+0xef/0x530 [rdma_cm]
> [  651.576261]        cma_ib_req_handler+0x1a76/0x4a50 [rdma_cm]
> [  651.582016]        cm_process_work+0x44/0x190 [ib_cm]
> [  651.587077]        cm_req_handler+0x2218/0x7040 [ib_cm]
> [  651.592312]        cm_work_handler+0x1acf/0x4a30 [ib_cm]
> [  651.597633]        process_one_work+0x978/0x1740
> [  651.602253]        worker_thread+0x87/0xbf0
> [  651.606437]        kthread+0x3aa/0x490
> [  651.610190]        ret_from_fork+0x1f/0x30
> [  651.614290]
>                 -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
> [  651.621249]        lock_acquire+0x1d2/0x5a0
> [  651.625435]        __mutex_lock+0x155/0x15f0
> [  651.629708]        cma_ib_req_handler+0x1709/0x4a50 [rdma_cm]
> [  651.635462]        cm_process_work+0x44/0x190 [ib_cm]
> [  651.640521]        cm_req_handler+0x2218/0x7040 [ib_cm]
> [  651.645749]        cm_work_handler+0x1acf/0x4a30 [ib_cm]
> [  651.651071]        process_one_work+0x978/0x1740
> [  651.655689]        worker_thread+0x87/0xbf0
> [  651.659874]        kthread+0x3aa/0x490
> [  651.663628]        ret_from_fork+0x1f/0x30
> [  651.667726]
>                 -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
> [  651.674511]        check_prevs_add+0x3fd/0x2480
> [  651.679045]        __lock_acquire+0x23f7/0x2f80
> [  651.683577]        lock_acquire+0x1d2/0x5a0
> [  651.687762]        __mutex_lock+0x155/0x15f0
> [  651.692036]        rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.697184]        nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
> [  651.703189]        nvmet_rdma_release_queue_work+0x3b/0x90 [nvmet_rdma]
> [  651.709802]        process_one_work+0x978/0x1740
> [  651.714422]        worker_thread+0x87/0xbf0
> [  651.718608]        kthread+0x3aa/0x490
> [  651.722358]        ret_from_fork+0x1f/0x30
> [  651.726459]
>                 other info that might help us debug this:
> 
> [  651.734457] Chain exists of:
>                   &id_priv->handler_mutex --> (wq_completion)events -->
> (work_completion)(&queue->release_work)
> 
> [  651.748531]  Possible unsafe locking scenario:
> 
> [  651.754451]        CPU0                    CPU1
> [  651.758984]        ----                    ----
> [  651.763515]   lock((work_completion)(&queue->release_work));
> [  651.769174]                                lock((wq_completion)events);
> [  651.775786]
> lock((work_completion)(&queue->release_work));
> [  651.783959]   lock(&id_priv->handler_mutex);
> [  651.788233]
>                  *** DEADLOCK ***
> 
> [  651.794153] 2 locks held by kworker/14:4/4839:
> [  651.798596]  #0: ffff88810005b948
> ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x854/0x1740
> [  651.808078]  #1: ffff8883cc21fe00
> ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
> process_one_work+0x888/0x1740
> [  651.819121]
>                 stack backtrace:
> [  651.823478] CPU: 14 PID: 4839 Comm: kworker/14:4 Tainted: G S
>   I       5.16.0-rc3+ #2
> [  651.831824] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
> 2.11.2 004/21/2021
> [  651.839476] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
> [  651.846175] Call Trace:
> [  651.848628]  <TASK>
> [  651.850735]  dump_stack_lvl+0x44/0x57
> [  651.854401]  check_noncircular+0x280/0x320
> [  651.858501]  ? print_circular_bug.isra.47+0x430/0x430
> [  651.863553]  ? lock_chain_count+0x20/0x20
> [  651.867566]  ? wait_for_completion+0x1e0/0x270
> [  651.872010]  ? mark_lock.part.52+0xf7/0x1050
> [  651.876283]  ? sched_clock_cpu+0x15/0x200
> [  651.880295]  ? find_held_lock+0x3a/0x1c0
> [  651.884223]  check_prevs_add+0x3fd/0x2480
> [  651.888238]  ? mark_held_locks+0xb7/0x120
> [  651.892248]  ? check_irq_usage+0xb50/0xb50
> [  651.896346]  ? lockdep_lock+0xcb/0x1c0
> [  651.900100]  ? static_obj+0xc0/0xc0
> [  651.903591]  ? sched_clock_cpu+0x15/0x200
> [  651.907606]  __lock_acquire+0x23f7/0x2f80
> [  651.911620]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  651.916063]  lock_acquire+0x1d2/0x5a0
> [  651.919729]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.924529]  ? rcu_read_unlock+0x50/0x50
> [  651.928456]  ? lock_is_held_type+0xd9/0x130
> [  651.932644]  __mutex_lock+0x155/0x15f0
> [  651.936393]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.941194]  ? kasan_quarantine_put+0xa4/0x180
> [  651.945641]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.950442]  ? mutex_lock_io_nested+0x1460/0x1460
> [  651.955146]  ? lock_is_held_type+0xd9/0x130
> [  651.959334]  ? rcu_read_lock_sched_held+0xaf/0xe0
> [  651.964039]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [  651.968487]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.973287]  rdma_destroy_id+0x17/0x20 [rdma_cm]
> [  651.977915]  nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
> [  651.983401]  nvmet_rdma_release_queue_work+0x3b/0x90 [nvmet_rdma]
> [  651.989493]  process_one_work+0x978/0x1740
> [  651.993595]  ? pwq_dec_nr_in_flight+0x270/0x270
> [  651.998126]  worker_thread+0x87/0xbf0
> [  652.001790]  ? __kthread_parkme+0xc3/0x1d0
> [  652.005890]  ? process_one_work+0x1740/0x1740
> [  652.010248]  kthread+0x3aa/0x490
> [  652.013480]  ? set_kthread_struct+0x100/0x100
> [  652.017841]  ret_from_fork+0x1f/0x30
> [  652.021424]  </TASK>
> [  652.050739] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 000000007ccc375a
> [  652.060318] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 000000007ccc375a queue->state= 1
> [  652.069937] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 0
> [  652.082650] nvmet:nvmet_stop_keep_alive_timer: nvmet: ctrl 1 stop keep-alive
> [  652.488476] eno2 speed is unknown, defaulting to 1000
> [  652.493657] eno3 speed is unknown, defaulting to 1000
> [  652.498847] eno4 speed is unknown, defaulting to 1000
> [  652.558751] rdma_rxe: rxe-ah pool destroyed with unfree'd elem
> [  652.678415] rdma_rxe: unloaded
> 
