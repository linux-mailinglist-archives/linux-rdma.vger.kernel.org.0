Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108570B33E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 04:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEVCeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 May 2023 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVCeU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 May 2023 22:34:20 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FBBF
        for <linux-rdma@vger.kernel.org>; Sun, 21 May 2023 19:34:18 -0700 (PDT)
Message-ID: <bf9718c1-521b-ef4f-5ba4-7c1e79a570d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684722854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVag2zVVhZiaBOuRqmP5ABCLpzTgxXMIynA4AtVEidM=;
        b=uyvny7f0XpamceWpquuAxnB2laqL42z+rDV3V9fYWdK3+Vg78l4/JAw4aJQIWvvhd36m5f
        Gbxiu2301oQ1TQMIjvd9kMYiI4/+BWzuQfr9I2JpmlvzDXDn+6zDFGOdyBM7jXKsY9U4X7
        G81qo1ZIUWoTxD5TbK3r8uLDDkfL330=
Date:   Mon, 22 May 2023 10:34:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/core: Call dev_put after query_port in
 iw_query_port
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "pchelkin@ispras.ru" <pchelkin@ispras.ru>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        bmt@zurich.ibm.com
References: <20230519031119.30103-1-guoqing.jiang@linux.dev>
 <ZGeBrhW2S5ukL6PS@ziepe.ca> <3B612246-D6B1-4977-B254-B2AC437BDC1A@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <3B612246-D6B1-4977-B254-B2AC437BDC1A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/19/23 22:05, Chuck Lever III wrote:
>
>> On May 19, 2023, at 10:03 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Fri, May 19, 2023 at 11:11:19AM +0800, Guoqing Jiang wrote:
>>> There is a UAF report by syzbot.
>>>
>>> BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
>>> Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211
>>>
>>> CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
>>> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
>>> Workqueue: infiniband ib_cache_event_task
>>> Call Trace:
>>> <TASK>
>>> __dump_stack lib/dump_stack.c:88 [inline]
>>> dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>>> print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>>> print_report mm/kasan/report.c:462 [inline]
>>> kasan_report+0x11c/0x130 mm/kasan/report.c:572
>>> siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
>>> iw_query_port drivers/infiniband/core/device.c:2049 [inline]
>>> ib_query_port drivers/infiniband/core/device.c:2090 [inline]
>>> ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
>>> ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
>>> ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
>>> ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
>>> process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>>> worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>>> kthread+0x344/0x440 kernel/kthread.c:379
>>> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>>> </TASK>
>>>
>>> It happened because netdev could be freed if the last reference
>>> is released, but drivers still dereference netdev in query_port.
>>> So let's guard query_port with dev_hold and dev_put.
>>>
>>> Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/lkml/0000000000001f992805fb79ce97@google.com/
>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>> ---
>>> I guess another option could be call ib_device_get_netdev to get
>>> netdev in siw_query_port instead of dereference netdev directly.
>>> If so, then other drivers (irdma_query_port and ocrdma_query_port)
>>> may need to make relevant change as well.
>> Something is wrong in siw if it is UAF'ing it's own memory:
>>
>> attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
>>
>> It needs to protect sedv->netdev somehow on its own.
> Note that netdev is actually the underlying device. An siw device
> doesn't have its own. But maybe it should.

I go through siw code a bit, and can't find relevant protection in siw.
Let me cc Bernard.

Thanks,
Guoqing
