Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A87ABBA2
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Sep 2023 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjIVWGL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWGK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 18:06:10 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31AA7;
        Fri, 22 Sep 2023 15:06:04 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso2650624b3a.2;
        Fri, 22 Sep 2023 15:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420363; x=1696025163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeSI4FuW/JEJqSQ3D2213fHIhE5KqbX7tUIxeY040R4=;
        b=WFmwDdNeVbZPwrvFmvbNrvh3SWIm/g1TYkCWrcwbgXGpb+ljw+PM+lfehm6ZkA1Mm1
         seUgKBvmmYp4CrUuJAXEabjEX7+J5JNbrsrvr1PQQQEecI1wcf1ai3JbK8fONE0pFWwM
         ze6c/9FvC8+2IfzvBlmE/pbEBxz9zgwbN3p3A1Ecj1aVayA7s5R7dunPvjRtQZsf4ljN
         9/G0B6+PEwYB9b/8Pt7obJqrSxCQSh2k8X0hiucXOBPnrR8PEYBAc4kp73qCwbau2d/w
         wSdXLK2YYE6KFchhdgrAdg/YAUPoD6pzakxTLt1xJyRSUoNY6Mr3rqnbF5ekTBDn9wNY
         LiwA==
X-Gm-Message-State: AOJu0YwG7B327FlJn7evdtRqYVQhyqe8FzQlFH3/c+IinK9k5IxXzFpI
        xxkQgy39xR5l3NM63cgZXeM=
X-Google-Smtp-Source: AGHT+IF82Jyjh/03J1aLKi3okOQ1Obr3g531E6OLf9xyGzDEEiogwL6mTSme2FpANDFv3wsEK3t44Q==
X-Received: by 2002:a05:6a20:8f1c:b0:15d:721e:44d5 with SMTP id b28-20020a056a208f1c00b0015d721e44d5mr840903pzk.49.1695420363285;
        Fri, 22 Sep 2023 15:06:03 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268b439a0cbsm4086866pji.23.2023.09.22.15.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 15:06:02 -0700 (PDT)
Message-ID: <8ee2869b-3f51-4195-9883-015cd30b4241@acm.org>
Date:   Fri, 22 Sep 2023 15:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
Content-Language: en-US
In-Reply-To: <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/23 11:14, Bob Pearson wrote:
> I have spent tons of time over the months trying to figure out what 
> is happening with blktests. As I have mentioned several times I have 
> seen the same exact failure in siw in the past although currently 
> that doesn't seem to happen so I had been suspecting that the
> problem may be in the ULP. The challenge is that the blktests
> represents a huge stack of software much of which I am not familiar
> with. The bug is a hang in layers above the rxe driver and so far no
> one has been able to say with any specificity the rxe driver failed
> to do something needed to make progress or violated expected
> behavior. Without any clue as to where to look it has been hard to
> make progress.
> 
> My main motivation is making Lustre run on rxe and it does and it's 
> fast enough to meet our needs. Lustre is similar to srp as a ULP and 
> in all of our testing we have never seen a similar hang. Other hangs 
> to be sure but not this one. I believe that this bug will never get 
> resolved until someone with a good understanding of the ulp drivers 
> makes an effort to find out where and why the hang is occurring.
> From there it should be straight forward to fix the problem. I am 
> continuing to investigate and am learning the 
> device-manager/multipath/srp/scsi stack but I have a long ways to 
> go.

Why would knowledge of device-manager/multipath/srp/scsi be required to
make progress?

Please start with fixing the KASAN complaint shown below. I think the
root cause of this complaint is in the RDMA/rxe driver. This issue can
be reproduced as follows:
* Build and install Linus' master branch with KASAN enabled (commit
   8018e02a8703 ("Merge tag 'thermal-6.6-rc3' of
   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")).
* Install the latest version of blktests and run the following shell
   command:

     export use_rxe=1; while (cd ~bart/software/blktests && ./check -q srp/002); do :; done

   The KASAN complaint should appear during the first run of test
   srp/002.

Thanks,

Bart.

BUG: KASAN: slab-use-after-free in rxe_comp_queue_pkt+0x3d/0x80 [rdma_rxe]
Read of size 8 at addr ffff888111865928 by task kworker/u18:5/3502

CPU: 1 PID: 3502 Comm: kworker/u18:5 Tainted: G        W          6.6.0-rc2-dbg #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
Workqueue: rxe_wq do_work [rdma_rxe]
Call Trace:
  <TASK>
  dump_stack_lvl+0x5c/0xc0
  print_address_description.constprop.0+0x33/0x400
  ? preempt_count_sub+0x18/0xc0
  print_report+0xb6/0x260
  ? kasan_complete_mode_report_info+0x5c/0x190
  kasan_report+0xc6/0x100
  ? rxe_comp_queue_pkt+0x3d/0x80 [rdma_rxe]
  ? rxe_comp_queue_pkt+0x3d/0x80 [rdma_rxe]
  __asan_load8+0x69/0x90
  rxe_comp_queue_pkt+0x3d/0x80 [rdma_rxe]
  rxe_rcv+0x3db/0x400 [rdma_rxe]
  ? rxe_rcv_mcast_pkt+0x500/0x500 [rdma_rxe]
  rxe_xmit_packet+0x224/0x3f0 [rdma_rxe]
  ? rxe_prepare+0x110/0x110 [rdma_rxe]
  ? prepare_ack_packet+0x1cd/0x340 [rdma_rxe]
  send_common_ack.isra.0+0xac/0x140 [rdma_rxe]
  ? prepare_ack_packet+0x340/0x340 [rdma_rxe]
  ? __this_cpu_preempt_check+0x13/0x20
  ? rxe_resp_check_length+0x148/0x2d0 [rdma_rxe]
  rxe_responder+0xe0b/0x1610 [rdma_rxe]
  ? __this_cpu_preempt_check+0x13/0x20
  ? rxe_resp_queue_pkt+0x70/0x70 [rdma_rxe]
  do_task+0xd2/0x350 [rdma_rxe]
  ? lockdep_hardirqs_on+0x7e/0x100
  rxe_run_task+0x8a/0xa0 [rdma_rxe]
  rxe_resp_queue_pkt+0x62/0x70 [rdma_rxe]
  rxe_rcv+0x327/0x400 [rdma_rxe]
  ? rxe_rcv_mcast_pkt+0x500/0x500 [rdma_rxe]
  rxe_xmit_packet+0x224/0x3f0 [rdma_rxe]
  ? rxe_prepare+0x110/0x110 [rdma_rxe]
  rxe_requester+0x6bb/0x13a0 [rdma_rxe]
  ? check_prev_add+0x12c0/0x12c0
  ? rnr_nak_timer+0xd0/0xd0 [rdma_rxe]
  ? __lock_acquire+0x88c/0xf30
  ? __kasan_check_read+0x11/0x20
  ? mark_lock+0xeb/0xa80
  ? mark_lock_irq+0xcd0/0xcd0
  ? __lock_release.isra.0+0x14c/0x280
  ? do_task+0x9f/0x350 [rdma_rxe]
  ? reacquire_held_locks+0x270/0x270
  ? _raw_spin_unlock_irqrestore+0x56/0x80
  ? __this_cpu_preempt_check+0x13/0x20
  ? lockdep_hardirqs_on+0x7e/0x100
  ? rnr_nak_timer+0xd0/0xd0 [rdma_rxe]
  do_task+0xd2/0x350 [rdma_rxe]
  ? __this_cpu_preempt_check+0x13/0x20
  do_work+0xe/0x10 [rdma_rxe]
  process_one_work+0x4af/0x9a0
  ? init_worker_pool+0x350/0x350
  ? assign_work+0xe2/0x120
  worker_thread+0x385/0x680
  ? preempt_count_sub+0x18/0xc0
  ? process_one_work+0x9a0/0x9a0
  kthread+0x1b9/0x200
  ? kthread+0xfd/0x200
  ? kthread_complete_and_exit+0x30/0x30
  ret_from_fork+0x36/0x60
  ? kthread_complete_and_exit+0x30/0x30
  ret_from_fork_asm+0x11/0x20
  </TASK>

Allocated by task 3502:
  kasan_save_stack+0x26/0x50
  kasan_set_track+0x25/0x30
  kasan_save_alloc_info+0x1e/0x30
  __kasan_slab_alloc+0x6a/0x70
  kmem_cache_alloc_node+0x16a/0x3d0
  __alloc_skb+0x1d8/0x250
  rxe_init_packet+0x11a/0x3b0 [rdma_rxe]
  prepare_ack_packet+0x9c/0x340 [rdma_rxe]
  send_common_ack.isra.0+0x95/0x140 [rdma_rxe]
  rxe_responder+0xe0b/0x1610 [rdma_rxe]
  do_task+0xd2/0x350 [rdma_rxe]
  rxe_run_task+0x8a/0xa0 [rdma_rxe]
  rxe_resp_queue_pkt+0x62/0x70 [rdma_rxe]
  rxe_rcv+0x327/0x400 [rdma_rxe]
  rxe_xmit_packet+0x224/0x3f0 [rdma_rxe]
  rxe_requester+0x6bb/0x13a0 [rdma_rxe]
  do_task+0xd2/0x350 [rdma_rxe]
  do_work+0xe/0x10 [rdma_rxe]
  process_one_work+0x4af/0x9a0
  worker_thread+0x385/0x680
  kthread+0x1b9/0x200
  ret_from_fork+0x36/0x60
  ret_from_fork_asm+0x11/0x20

Freed by task 56:
  kasan_save_stack+0x26/0x50
  kasan_set_track+0x25/0x30
  kasan_save_free_info+0x2b/0x40
  ____kasan_slab_free+0x14c/0x1b0
  __kasan_slab_free+0x12/0x20
  kmem_cache_free+0x20a/0x4b0
  kfree_skbmem+0xaa/0xc0
  kfree_skb_reason+0x8e/0xe0
  rxe_completer+0x205/0xfe0 [rdma_rxe]
  do_task+0xd2/0x350 [rdma_rxe]
  do_work+0xe/0x10 [rdma_rxe]
  process_one_work+0x4af/0x9a0
  worker_thread+0x385/0x680
  kthread+0x1b9/0x200
  ret_from_fork+0x36/0x60
  ret_from_fork_asm+0x11/0x20

The buggy address belongs to the object at ffff888111865900
  which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 40 bytes inside of
  freed 224-byte region [ffff888111865900, ffff8881118659e0)

The buggy address belongs to the physical page:
page:00000000c6a967c7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x111864
head:00000000c6a967c7 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x2000000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 2000000000000840 ffff888100274c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080190019 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888111865800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888111865880: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff888111865900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff888111865980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  ffff888111865a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
