Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4259B630D47
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiKSI0G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Nov 2022 03:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKSI0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Nov 2022 03:26:05 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3EACEA8;
        Sat, 19 Nov 2022 00:26:03 -0800 (PST)
Message-ID: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668846361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfn1N8MLZTcJX22BXGXP9eTQh7aXYUOkE4nO8D9F2+U=;
        b=w701wdjyKQhkOLcG8+obDqjtM+rgbf9kPAXpkBOfaqJ5NYt12Bo81idGEOa9ykQuYnyWUD
        5kewtMlfuAkScbD2CMHuQiY3Hh65ukbR+x/RNsxuxaQsWV/d/fyqFhTEVUcFlsuJI10Pxe
        TY2z91jGIiruYG31ow23QeEmYlKRq14=
Date:   Sat, 19 Nov 2022 16:25:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
 <Y3ggL8RJw6mDaWxT@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y3ggL8RJw6mDaWxT@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/11/19 8:15, Jason Gunthorpe 写道:
> On Sun, Oct 30, 2022 at 03:04:33AM +0000, Li Zhijian wrote:
>> rxe_mr_cleanup() which tries to free mr->map again will be called
>> when rxe_mr_init_user() fails.
>>
>> [43895.939883] CPU: 0 PID: 4917 Comm: rdma_flush_serv Kdump: loaded Not tainted 6.1.0-rc1-roce-flush+ #25
>> [43895.942341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> [43895.945208] Call Trace:
>> [43895.946130]  <TASK>
>> [43895.946931]  dump_stack_lvl+0x45/0x5d
>> [43895.948049]  panic+0x19e/0x349
>> [43895.949010]  ? panic_print_sys_info.part.0+0x77/0x77
>> [43895.950356]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>> [43895.952589]  ? preempt_count_sub+0x14/0xc0
>> [43895.953809]  end_report.part.0+0x54/0x7c
>> [43895.954993]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
>> [43895.956406]  kasan_report.cold+0xa/0xf
>> [43895.957668]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
>> [43895.959090]  rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
>> [43895.960502]  __rxe_cleanup+0x10a/0x1e0 [rdma_rxe]
>> [43895.961983]  rxe_reg_user_mr+0xb7/0xd0 [rdma_rxe]
>> [43895.963456]  ib_uverbs_reg_mr+0x26a/0x480 [ib_uverbs]
>> [43895.964921]  ? __lock_acquire+0x876/0x31e0
>> [43895.966182]  ? ib_uverbs_ex_create_wq+0x630/0x630 [ib_uverbs]
>> [43895.967739]  ? uverbs_fill_udata+0x1c6/0x330 [ib_uverbs]
>> [43895.969204]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x1a2/0x250 [ib_uverbs]
>> [43895.971126]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
>> [43895.973094]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
>> [43895.975096]  ? uverbs_fill_udata+0x25f/0x330 [ib_uverbs]
>> [43895.976466]  ib_uverbs_cmd_verbs+0x1397/0x15a0 [ib_uverbs]
>> [43895.977930]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
>> [43895.979937]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]
> 
> Please dont include timestamps in commit messages
> 
>> @@ -163,9 +163,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>   				pr_warn("%s: Unable to get virtual address\n",
>>   						__func__);
>>   				err = -ENOMEM;
>> -				goto err_cleanup_map;
>> +				goto err_release_umem;
>>   			}
>> -
> 
> page_address() fails if this is a highmem system and the page hasn't
> been kmap'd yet. So the right thing to do is to use kmap..

Sure.

sgt_append.sgt is allocated in this function ib_umem_get. And the 
function sg_alloc_append_table_from_pages is called to allocate memory.

147 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long 
addr,
148                             size_t size, int access)
149 {
...
230                 ret = sg_alloc_append_table_from_pages(
231                         &umem->sgt_append, page_list, pinned, 0,
232                         pinned << PAGE_SHIFT, 
ib_dma_max_seg_size(device),
233                         npages, GFP_KERNEL);
...

And it seems that it is not highmem.

So page_address will not be NULL?

As such, it is not necessary to test the return vaue of page_address?

If so, can we add a new commit to avoid testing of the return value of 
page_address?

Zhu Yanjun

> 
> But this looks right, so applied to for-next
> 
> Thanks,
> Jason

