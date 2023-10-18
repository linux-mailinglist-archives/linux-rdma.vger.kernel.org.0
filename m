Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F57CD6AE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjJRIes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbjJRIer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 04:34:47 -0400
Received: from out-193.mta1.migadu.com (out-193.mta1.migadu.com [IPv6:2001:41d0:203:375::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E7B6
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 01:34:44 -0700 (PDT)
Message-ID: <12bc6723-6048-4aa6-ba3e-ad6ff2403196@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697618082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5vnWj75Nr/9+G6RunE3aeZ1c5zit+rA7ylI2oO6A0k=;
        b=pCAhTYcbm58pknEgEQHxG67AX1vuIXHti/ckdAT3hLYyqxZ60B7bzEMWxmJx8MkE9YLK+Z
        JngyAItnDse1HeuQh8rwzTad/PVr2zfwvi4ak1YJXBPPwNEHz21mSVEftu2ZAJZAck2hZy
        Q51u6uKwt6G3isLkUfzJnGmlmMyZ6Uw=
Date:   Wed, 18 Oct 2023 16:34:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <6f155aa3-8e75-40c5-9686-cad9f9ac0d81@linux.dev>
 <OS3PR01MB986557755D5DE20BB7BD60ECE5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <CAJr_XRD+3Hk66OSoS_HfGe4Z7B1oVK6JbXj1qb5h4vXg1ah5Qg@mail.gmail.com>
 <OS3PR01MB9865A90A3FD2B9D3096E6E2CE5D7A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB9865A90A3FD2B9D3096E6E2CE5D7A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/16 14:07, Daisuke Matsuda (Fujitsu) 写道:
> On Fri, Oct 13, 2023 10:44 PM Rain River <rain.1986.08.12@gmail.com> wrote:
>>> On Friday, October 13, 2023 9:29 PM Zhu Yanjun:
>>>> 在 2023/10/13 20:01, Daisuke Matsuda (Fujitsu) 写道:
>>>>> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
>>>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>>>
>>>>>> The page_size of mr is set in infiniband core originally. In the commit
>>>>>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
>>>>>> page_size is also set. Sometime this will cause conflict.
>>>>>
>>>>> I appreciate your prompt action, but I do not think this commit deals with
>>>>> the root cause. I agree that the problem lies in rxe driver, but what is wrong
>>>>> with assigning actual page size to ibmr.page_size?
>>>>
>>>> Please check the source code. ibmr.page_size is assigned in
>>>> infiniband/core. And then it is assigned in rxe.
>>>> When the 2 are different, the problem will occur.
>>>
>>> In the first place, the two must always be equal.
>>> Is there any situation there are two different page sizes for a MR?
>>> I think I have explained the value assigned in the core layer is wrong
>>> when the PAGE_SIZE is bigger than 4k, and that is why they are inconsistent.
>>>
>>> As I have no environment to test the kernel panic, it remains speculative,
>>> but I have provided enough information for everyone to rebut my argument.
>>> It is possible I am wrong. I hope someone will tell me specifically where
>>> my guess is wrong, or Yi would kindly take the trouble to verify it.
>>
>> I made a quick test.
>>
>> With Zhu's patch, the problem fixed.
>> With your patch, this problem exists. And other problems occur. I do
>> not know why.
>> Will continue to make tests.
> 
> Thank you for your time and work.
> I will try to find out why there were two different page sizes from
> different perspectives. This may take a while because I am busy
> with other projects now. If anybody need the driver without the crash
> issue right now, I do not object to partially undoing "RDMA/rxe: Cleanup
> page variables in rxe_mr.c" as Zhu suggests, but that should be interim
> and not a final solution.

Sorry, it is late to reply.

This is a difficult and complicated problem because it involves rdma and 
block/blktests. This commit is based on the fact that the commit 
325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c") causes 
this problem.

So I delved into this commit. In this commit, the core part is to change 
the size of ibmr.page_size.
 From this, I checked the source code. I found that this page_size is 
also set in infiniband/core. So I try to remove the change of 
ibmr.page_size.

I will continue to delve into this problem and the source code to find 
the root cause that you also agree with.

Zhu Yanjun
> 
> Thanks,
> Daisuke
> 
>>
>>>
>>> Thanks,
>>> Daisuke Matsuda
>>>
>>>> Please add logs to infiniband/core and rxe to check them.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>>
>>>>> IMO, the problem comes from the device attribute of rxe driver, which is used
>>>>> in ulp/srp layer to calculate the page_size.
>>>>> =====
>>>>> static int srp_add_one(struct ib_device *device)
>>>>> {
>>>>>           struct srp_device *srp_dev;
>>>>>           struct ib_device_attr *attr = &device->attrs;
>>>>> <...>
>>>>>           /*
>>>>>            * Use the smallest page size supported by the HCA, down to a
>>>>>            * minimum of 4096 bytes. We're unlikely to build large sglists
>>>>>            * out of smaller entries.
>>>>>            */
>>>>>           mr_page_shift           = max(12, ffs(attr->page_size_cap) - 1);
>>>>>           srp_dev->mr_page_size   = 1 << mr_page_shift;
>>>>> =====
>>>>> On initialization of srp driver, mr_page_size is calculated here.
>>>>> Note that the device attribute is used to calculate the value of page shift
>>>>> when the device is trying to use a page size larger than 4096. Since Yi specified
>>>>> CONFIG_ARM64_64K_PAGES, the system naturally met the condition.
>>>>>
>>>>> =====
>>>>> static int srp_map_finish_fr(struct srp_map_state *state,
>>>>>                                struct srp_request *req,
>>>>>                                struct srp_rdma_ch *ch, int sg_nents,
>>>>>                                unsigned int *sg_offset_p)
>>>>> {
>>>>>           struct srp_target_port *target = ch->target;
>>>>>           struct srp_device *dev = target->srp_host->srp_dev;
>>>>> <...>
>>>>>           n = ib_map_mr_sg(desc->mr, state->sg, sg_nents, sg_offset_p,
>>>>>                            dev->mr_page_size);
>>>>> =====
>>>>> After that, mr_page_size is presumably passed to ib_core layer.
>>>>>
>>>>> =====
>>>>> int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
>>>>>                    unsigned int *sg_offset, unsigned int page_size)
>>>>> {
>>>>>           if (unlikely(!mr->device->ops.map_mr_sg))
>>>>>                   return -EOPNOTSUPP;
>>>>>
>>>>>           mr->page_size = page_size;
>>>>>
>>>>>           return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset);
>>>>> }
>>>>> EXPORT_SYMBOL(ib_map_mr_sg);
>>>>> =====
>>>>> Consequently, the page size calculated in srp driver is set to ibmr.page_size.
>>>>>
>>>>> Coming back to rxe, the device attribute is set here:
>>>>> =====
>>>>> rxe.c
>>>>> <...>
>>>>> /* initialize rxe device parameters */
>>>>> static void rxe_init_device_param(struct rxe_dev *rxe)
>>>>> {
>>>>>           rxe->max_inline_data                    = RXE_MAX_INLINE_DATA;
>>>>>
>>>>>           rxe->attr.vendor_id                     = RXE_VENDOR_ID;
>>>>>           rxe->attr.max_mr_size                   = RXE_MAX_MR_SIZE;
>>>>>           rxe->attr.page_size_cap                 = RXE_PAGE_SIZE_CAP;
>>>>>           rxe->attr.max_qp                        = RXE_MAX_QP;
>>>>> ---
>>>>> rxe_param.h
>>>>> <...>
>>>>> /* default/initial rxe device parameter settings */
>>>>> enum rxe_device_param {
>>>>>           RXE_MAX_MR_SIZE                 = -1ull,
>>>>>           RXE_PAGE_SIZE_CAP               = 0xfffff000,
>>>>>           RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>>>>> =====
>>>>> rxe_init_device_param() sets the attributes to rxe_dev->attr, and it is later copied
>>>>> to ib_device->attrs in setup_device()@core/device.c.
>>>>> See that the page size cap is hardcoded to 4096 bytes. I suspect this led to
>>>>> incorrect page_size being set to ibmr.page_size, resulting in the kernel crash.
>>>>>
>>>>> I think rxe driver is made to be able to handle arbitrary page sizes.
>>>>> Probably, we can just modify RXE_PAGE_SIZE_CAP to fix the issue.
>>>>> What do you guys think?
>>>>>
>>>>> Thanks,
>>>>> Daisuke Matsuda
>>>>>
>>>

