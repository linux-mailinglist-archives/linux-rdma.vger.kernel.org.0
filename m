Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2478B7661D4
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjG1Cgt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 22:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjG1Cgs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 22:36:48 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 19:36:47 PDT
Received: from out-79.mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFD30E0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 19:36:47 -0700 (PDT)
Message-ID: <684f6b40-8d02-a273-2192-9c2499bd555a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690511361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXSFAB3LJjyFnkYIzkRXQX0y29O+429H486x9B7fNW0=;
        b=GXclPGxFmvJ4KKDfPoSIgfcDD9jf9ymsHY6L6JX3bcKlFrIu1sxxWmK1cCQ85oi/qx9htf
        7O8SMbGd+DTpUptyTLGhLch8+D2gDcJQKMv8yJMf2WfIljHZiiwni5vvz4L3xKOsr4I0EE
        KWG0CQ1+RrnWHipu8tujBbBZewDruO4=
Date:   Fri, 28 Jul 2023 10:29:16 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 0/5] Fix potential issues for siw
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
 <ZMKpcQsJ3FBvxYHo@ziepe.ca> <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
Content-Language: en-US
In-Reply-To: <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/23 09:16, Guoqing Jiang wrote:
>
>
> On 7/28/23 01:29, Jason Gunthorpe wrote:
>> On Thu, Jul 27, 2023 at 05:17:40PM +0000, Bernard Metzler wrote:
>>>
>>>> -----Original Message-----
>>>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> Sent: Thursday, 27 July 2023 16:04
>>>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; 
>>>> leon@kernel.org
>>>> Cc: linux-rdma@vger.kernel.org
>>>> Subject: [EXTERNAL] [PATCH 0/5] Fix potential issues for siw
>>>>
>>>> Hi,
>>>>
>>>> Several issues appeared if we rmmod siw module after failed to insert
>>>> the module (with manual change like below).
>>>>
>>>> --- a/drivers/infiniband/sw/siw/siw_main.c
>>>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>>>> @@ -577,6 +577,7 @@ static __init int siw_init_module(void)
>>>>          if (rv)
>>>>                  goto out_error;
>>>>
>>>> +       goto out_error;
>>>>          rdma_link_register(&siw_link_ops);
>>>>
>>>> Basically, these issues are double free, use before initalization or
>>>> null pointer dereference. For more details, pls review the individual
>>>> patch.
>>>>
>>>> Thanks,
>>>> Guoqing
>>> Hi Guoqing,
>>>
>>> very good catch, thank you. I was under the wrong assumption a
>>> module is not loaded if the init_module() returns a value.
>> I think that is actually true, isn't it? I'm confused?
>
> Yes, you are right. Since rv is still 0, so the module appears in the 
> kernel. Not sure if some tool could inject err like this. Feel free to 
> ignore this.

The below trace happened if I run a stress test with load siw module and 
unload siw in a loop, which should be fixed by patch 5,  so I think we 
need to apply it, what do you think?

[  414.537961] BUG: spinlock bad magic on CPU#0, modprobe/3722
[  414.537965]  lock: 0xffff9d847bc380e8, .magic: 00000000, .owner: 
<none>/-1, .owner_cpu: 0
[  414.537969] CPU: 0 PID: 3722 Comm: modprobe Tainted: G OE      
6.5.0-rc3+ #16
[  414.537971] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[  414.537973] Call Trace:
[  414.537973]  <TASK>
[  414.537975]  dump_stack_lvl+0x77/0xd0
[  414.537979]  dump_stack+0x10/0x20
[  414.537981]  spin_bug+0xa5/0xd0
[  414.537984]  do_raw_spin_lock+0x90/0xd0
[  414.537985]  _raw_spin_lock_irqsave+0x56/0x80
[  414.537988]  ? __wake_up_common_lock+0x63/0xd0
[  414.537990]  __wake_up_common_lock+0x63/0xd0
[  414.537992]  __wake_up+0x13/0x30
[  414.537994]  siw_stop_tx_thread+0x49/0x70 [siw]
[  414.538000]  siw_exit_module+0x30/0x620 [siw]
[  414.538006]  __do_sys_delete_module.constprop.0+0x18f/0x300
[  414.538008]  ? syscall_enter_from_user_mode+0x21/0x70
[  414.538010]  ? __this_cpu_preempt_check+0x13/0x20
[  414.538012]  ? lockdep_hardirqs_on+0x86/0x120
[  414.538014]  __x64_sys_delete_module+0x12/0x20
[  414.538016]  do_syscall_64+0x5c/0x90
[  414.538019]  ? do_syscall_64+0x69/0x90
[  414.538020]  ? __this_cpu_preempt_check+0x13/0x20
[  414.538022]  ? lockdep_hardirqs_on+0x86/0x120
[  414.538024]  ? syscall_exit_to_user_mode+0x37/0x50
[  414.538025]  ? do_syscall_64+0x69/0x90
[  414.538026]  ? syscall_exit_to_user_mode+0x37/0x50
[  414.538027]  ? do_syscall_64+0x69/0x90
[  414.538029]  ? syscall_exit_to_user_mode+0x37/0x50
[  414.538030]  ? do_syscall_64+0x69/0x90
[  414.538032]  ? irqentry_exit_to_user_mode+0x25/0x30
[  414.538033]  ? irqentry_exit+0x77/0xb0
[  414.538034]  ? exc_page_fault+0xae/0x240
[  414.538036]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  414.538038] RIP: 0033:0x7f177eb26c9b

Thanks,
Guoqing
