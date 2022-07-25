Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48E57F837
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiGYCQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jul 2022 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGYCQg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Jul 2022 22:16:36 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB6CE08
        for <linux-rdma@vger.kernel.org>; Sun, 24 Jul 2022 19:16:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658715392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQU8X5E0IuUQzyNfRYRYdjagOEBVVkcBbTzScHaHal8=;
        b=A7+L+B7AFRWvz/qg4f+/4DXigjeKl2mNQUXKRcz7WcsDnGPzz+BiRQ17Pjt3AWed0+kA2j
        3SYP8nCpu1NiDguxgla7dg6Iy0aiQHz30Q0l+huxAahsUTDWH4Rw+kQH6nwu/e/awARvSA
        LLXw/1X81wLhfJSljcBF5JjjIyjnQlo=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
 <2b9261f7-8ade-1892-5f71-5e4de13927a4@fujitsu.com>
Message-ID: <34344e02-fb6f-4ddf-547b-bcbfe81c8e84@linux.dev>
Date:   Mon, 25 Jul 2022 10:16:32 +0800
MIME-Version: 1.0
In-Reply-To: <2b9261f7-8ade-1892-5f71-5e4de13927a4@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/25/22 9:13 AM, lizhijian@fujitsu.com wrote:
> On 22/07/2022 06:19, Bob Pearson wrote:
>> On 7/20/22 05:50, Haris Iqbal wrote:
>>> On Wed, Jul 20, 2022 at 12:22 PM Li Zhijian<lizhijian@fujitsu.com>   wrote:
>>>> Below 2 commits will be reverted:
>>>>        8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>>>>        647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
>>>>
>>>> The community has a few bug reports which pointed this commit at last.
>>>> Some proposals are raised up in the meantime but all of them have no
>>>> follow-up operation.
>>>>
>>>> The previous commit led the map_set of FMR to be not avaliable any more if
>>>> the MR is registered again after invalidating. Although the mentioned
>>>> patch try to fix a potential race in building/accessing the same table
>>>> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
>>>> be worse, revert this patch.
>>>>
>>>> With previous commit, it's observed that a same MR in rnbd server will
>>>> trigger below code path:
>>> Looks Good. I tested the patch against rdma for-next and it solves the
>>> problem mentioned in the commit.
>>> One small nitpick. It should be rtrs, and not rnbd in the commit message.
>>>
>>> Feel free to add my,
>>>
>>> Tested-by: Md Haris Iqbal<haris.iqbal@ionos.com>
>>>
>>>>    -> rxe_mr_init_fast()
>>>>    |-> alloc map_set() # map_set is uninitialized
>>>>    |...-> rxe_map_mr_sg() # build the map_set
>>>>        |-> rxe_mr_set_page()
>>>>    |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>>>>                             # we can access host memory(such rxe_mr_copy)
>>>>    |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>>>>    |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>>>>                             # but map_set was not built again
>>>>    |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>>>>                         # that lookup from the map_set
>>>>
>> Where is the use case for this? All the FMR examples I am aware of call rxe_map_mr_sg()
>> between each reg_fast_mr/invalidate_mr() sequence. I am not familiar with rtrs.
>> What is it?
> it would happen when we are creating a rnbd connection.

To be accurate, it is rtrs connection.

> modprobe rnbd_server
> modprobe rnbd_client
>
> echo "sessname=foo path=ip:<server-ip> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
>
>
> I have tested blktests and above rnbd case, they works fine.
> Further more, your "[PATCH RFC] RDMA/rxe: Allow re-registration of FMRs" does'n fix the above rnbd use case.

Thanks for the effort! I believe rnbd/rtrs over rxe had been broken for 
a while, can we agree
the problem need to be fixed?

Thanks,
Guoqing
