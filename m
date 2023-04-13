Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C76E07DB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDMHf7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDMHf6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 03:35:58 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BA7DA5
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 00:35:53 -0700 (PDT)
Message-ID: <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681371350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI6QhWn9NAr1xs8EweUV7+KExkmqXDhQD5YkG+4nQcg=;
        b=kQ8ZYL3fUiLTJK7YWXKjg9Lkt5H9pg32my0hVtXGmmh/Sjw98N9X6Hd1eTwOXjWxkVnSfX
        VRv9TbGP79yZ7ULTCSeBDfhCJzKp/yFe8EGJM18zKjdv3yl2XdHR60ibHcvZx9yBoKkheE
        QRmxIG4ex9tMjduiUCIo/cpRUikc7CI=
Date:   Thu, 13 Apr 2023 15:35:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I take a closer look today.

On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
>
> On 11/04/2023 20:26, Leon Romanovsky wrote:
>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
>>>
>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
>>>>
>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
>>>>>> The warning occurs when destroying PD whose reference count is not zero.
>>>>>>
>>>>>> Precodition: clt_path->s.con_num is 2.
>>>>>> So 2 cm connection will be created as below:
>>>>>> CPU0                                              CPU1
>>>>>> init_conns {                              |
>>>>>>      create_cm() // a. con[0] created        |
>>>>>>                                              |  a'. rtrs_clt_rdma_cm_handler() {
>>>>>>                                              |    rtrs_rdma_addr_resolved()
>>>>>>                                              |      create_con_cq_qp(con); << con[0]
>>>>>>                                              |  }
>>>>>>                                              | in this moment, refcnt of PD was increased to 2+

What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.

>>>>>>                                              |
>>>>>>      create_cm() // b. cid = 1, failed       |
>>>>>>        destroy_con_cq_qp()                   |
>>>>>>          rtrs_ib_dev_put()                   |
>>>>>>            dev_free()                        |
>>>>>>              ib_dealloc_pd(dev->ib_pd) << PD |
>>>>>>               is destroyed, but refcnt is    |
>>>>>>               still greater than 0           |

Assuming you mean "pd->usecnt". We only allocate pd in con[0] by 
rtrs_ib_dev_find_or_add,
if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> 
atomic_inc(&pd->usecnt)
can't be triggered. Is there other places could increase the refcnt?

>>>>>> }
>>>>>>
>>>>>> Simply, Here we can avoid this warning by introducing conn own flag to
>>>>>> track if its cleanup should drop the PD.
>>>>>>
>>>>>> -----------------------------------------------
>>>>>>     rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
>>>>>>     ------------[ cut here ]------------
>>>>>>     WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
>>>>>>     Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
>>>>>> vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
>>>>>>     CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
>>>>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>>>>>     RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
>>>>>>     Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
>>>>>>     RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
>>>>>>     RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
>>>>>>     RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
>>>>>>     RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
>>>>>>     R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
>>>>>>     R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
>>>>>>     FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
>>>>>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>     CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
>>>>>>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>     Call Trace:
>>>>>>      <TASK>
>>>>>>      rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
>>>>>>      ib_dealloc_pd_user+0x4b/0x80 [ib_core]
>>>>>>      rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
>>>>>>      destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
>>>>>>      init_path+0x1e7/0x9a0 [rtrs_client]
>>>>>>      ? __pfx_autoremove_wake_function+0x10/0x10
>>>>>>      ? lock_is_held_type+0xd7/0x130
>>>>>>      ? rcu_read_lock_sched_held+0x43/0x80
>>>>>>      ? pcpu_alloc+0x3dd/0x7d0
>>>>>>      ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
>>>>>>      rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
>>>>>>      ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
>>>>>>      rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]
>>>>>>
>>>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>>>> ---
>>>>>>     drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++++
>>>>>>     drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 +
>>>>>>     2 files changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>>>> index c2065fc33a56..4c8f42e46e2f 100644
>>>>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
>>>>>> @@ -1664,6 +1664,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>>>>>>                 return -ENOMEM;
>>>>>>             }
>>>>>>             clt_path->s.dev_ref = 1;
>>>>>> +        con->has_dev = true;
>>>>>>             query_fast_reg_mode(clt_path);
>>>>>>             wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
>>>>>>             /*
>>>>>> @@ -1690,6 +1691,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>>>>>>             wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
>>>>>>             /* Shared between connections */
>>>>>>             clt_path->s.dev_ref++;
>>>>> Without looking in the code, I would expect dev_ref from the line above
>>>>> to perform PD protection.
>>>> Agreed.
>>> Sorry, i didn't get your point. Do you mean something like this:
>>>
>>> +		con->has_dev = true;
>>>     		clt_path->s.dev_ref++;
>> No, my point was that clt_path->s.dev_ref > 0 means that has_dev is
>> equal to true, and dev_ref is supposed to protect from early PD
>> destruction.
>>
>
>> +       if (!con->has_dev)
>> +               return;
> We have already done such protection VVVV
>
>>          if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {  <<< each cleanup will decrease clt_path->s.dev_ref
>>                  rtrs_ib_dev_put(clt_path->s.dev);             <<< when it becomes to 0, PD will be destructed.
>>                  clt_path->s.dev = NULL;
>
> But they are not equal, clt_path->s.dev_ref could be shared by multiple connections.
> So in the case con[0] successed and con[1] failed(clt_path->s.dev_ref is 1),
> the con[1]'s cleanup path(destroy_con_cq_qp) will destroy PD while conn[0] still associates this PD.

Then what is the appropriate time to call destroy_con_cq_qp for this 
scenario?
Otherwise there could be memory leak.

Thanks,
Guoqing
