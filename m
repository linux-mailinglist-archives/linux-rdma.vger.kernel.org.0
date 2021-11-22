Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32D9458A78
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhKVI0T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 03:26:19 -0500
Received: from out0.migadu.com ([94.23.1.103]:20443 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhKVI0T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 03:26:19 -0500
Subject: Re: [PATCH] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637569389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM310Er7mKkSAbuzVmRMZZ3f2U9XAPXEmLcnEmNVRUo=;
        b=Ee83SsSc/A1AnNeAwqj6pLR+t8La07Zfi7WBhXGS1c2lnfiGxQv+PwSsr2ucgMOofIRKRZ
        7kuye48BvgoXdwtnmNTCGZ1+PMdVJJyE1kQ4qk0Vn0gy/8bnpuFEy4jSQQqzyausL/cTiV
        7kL4hOpQFSb23cYL9m1mTCNgDKxu2E8=
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20211121142223.22887-1-guoqing.jiang@linux.dev>
 <YZtKUpNhxAFS43yy@unreal>
 <CAMGffE=mPPChgd1tZkpKGCtMqxYx8B5wSTCZgkJKtJ+ajsGn-g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <f0cabcd1-d744-13fd-cfc9-4faf878341ba@linux.dev>
Date:   Mon, 22 Nov 2021 16:23:03 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffE=mPPChgd1tZkpKGCtMqxYx8B5wSTCZgkJKtJ+ajsGn-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/22/21 4:20 PM, Jinpu Wang wrote:
> On Mon, Nov 22, 2021 at 8:44 AM Leon Romanovsky <leon@kernel.org> wrote:
>> On Sun, Nov 21, 2021 at 10:22:23PM +0800, Guoqing Jiang wrote:
>>> With preemption enabled (CONFIG_DEBUG_PREEMPT=y), the following appeared
>>> when rnbd client tries to map remote block device.
>>>
>>> [ 2123.221071] BUG: using smp_processor_id() in preemptible [00000000] code: bash/1733
>>> [ 2123.221175] caller is debug_smp_processor_id+0x17/0x20
>>> [ 2123.221214] CPU: 0 PID: 1733 Comm: bash Not tainted 5.16.0-rc1 #5
>>> [ 2123.221218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>>> [ 2123.221229] Call Trace:
>>> [ 2123.221231]  <TASK>
>>> [ 2123.221235]  dump_stack_lvl+0x5d/0x78
>>> [ 2123.221252]  dump_stack+0x10/0x12
>>> [ 2123.221257]  check_preemption_disabled+0xe4/0xf0
>>> [ 2123.221266]  debug_smp_processor_id+0x17/0x20
>>> [ 2123.221271]  rtrs_clt_update_all_stats+0x3b/0x70 [rtrs_client]
>>> [ 2123.221285]  rtrs_clt_read_req+0xc3/0x380 [rtrs_client]
>>> [ 2123.221298]  ? rtrs_clt_init_req+0xe3/0x120 [rtrs_client]
>>> [ 2123.221321]  rtrs_clt_request+0x1a7/0x320 [rtrs_client]
>>> [ 2123.221340]  ? 0xffffffffc0ab1000
>>> [ 2123.221357]  send_usr_msg+0xbf/0x160 [rnbd_client]
>>> [ 2123.221370]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
>>> [ 2123.221377]  ? send_usr_msg+0x160/0x160 [rnbd_client]
>>> [ 2123.221386]  ? sg_alloc_table+0x27/0xb0
>>> [ 2123.221395]  ? sg_zero_buffer+0xd0/0xd0
>>> [ 2123.221407]  send_msg_sess_info+0xe9/0x180 [rnbd_client]
>>> [ 2123.221413]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
>>> [ 2123.221429]  ? blk_mq_alloc_tag_set+0x2ef/0x370
>>> [ 2123.221447]  rnbd_clt_map_device+0xba8/0xcd0 [rnbd_client]
>>> [ 2123.221462]  ? send_msg_open+0x200/0x200 [rnbd_client]
>>> [ 2123.221479]  rnbd_clt_map_device_store+0x3e5/0x620 [rnbd_client
>>>
>>> To supress the calltrace, let's call get_cpu_ptr/put_cpu_ptr pair in
>>> rtrs_clt_update_rdma_stats to disable preemption when accessing per-cpu
>>> variable.
>>>
>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>> ---
>>>   drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
>>> index f7e459fe68be..6ff72f2b1a3a 100644
>>> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
>>> @@ -169,9 +169,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
>>>   {
>>>        struct rtrs_clt_stats_pcpu *s;
>>>
>>> -     s = this_cpu_ptr(stats->pcpu_stats);
>>> +     s = get_cpu_ptr(stats->pcpu_stats);
>>>        s->rdma.dir[d].cnt++;
>>>        s->rdma.dir[d].size_total += size;
>>> +     put_cpu_ptr(stats->pcpu_stats);
>> I see that this_cpu_ptr() is used in many other places in rtrs-clt-stats.c,
>> why do we need to change only one place?
> Right, indeed. guoqing, mind to respin?

I just see this calltrace, probably other paths are not triggered since 
the connection can't be established.
Anyway, will send v2.

Thanks,
Guoqing
