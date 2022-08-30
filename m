Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824265A5EBD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiH3I5a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiH3I53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 04:57:29 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9F8D3FB;
        Tue, 30 Aug 2022 01:57:28 -0700 (PDT)
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661849846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQxo6TPZtM7+wn4cubDkrExDWQlUoanxo2ItsuH4c7E=;
        b=A/WBB//OX9rdoRw2wRD7ys5Eas1FvuOcEMWX7L5+eqbOM9CxgyTD/1JqPwMoTRc3g4b5D0
        qzkLDLGrR29TS907c1dzyK/79O3SEVr30cwpc0RhxQWTsCpZtVaeD+cf4qH4hlh74R6ej5
        LNf8ob/6ruG+5EhPCMFHIupSZQ+brHo=
To:     Leon Romanovsky <leon@kernel.org>,
        Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal> <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
 <CAMGffE=-Dsr=s1X=00+y1UcOhHC=FJ-9guQAWTDoHLTRBQ7Qaw@mail.gmail.com>
 <Yw3N0ALRz5xcBunA@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <a8774cb1-fa99-33cd-f681-527de1e079be@linux.dev>
Date:   Tue, 30 Aug 2022 16:57:19 +0800
MIME-Version: 1.0
In-Reply-To: <Yw3N0ALRz5xcBunA@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/30/22 4:44 PM, Leon Romanovsky wrote:
> On Mon, Aug 29, 2022 at 03:43:43PM +0200, Jinpu Wang wrote:
>> On Mon, Aug 29, 2022 at 3:33 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>>
>>>
>>> On 8/29/22 3:44 PM, Leon Romanovsky wrote:
>>>> On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
>>>>> Since all callers (process_{read,write}) set id->dir, no need to
>>>>> pass 'dir' again.
>>>>>
>>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>>> ---
>>>>>    drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
>>>>>    drivers/block/rnbd/rnbd-srv.h          | 1 +
>>>>>    drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>>>>>    drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
>>>>>    4 files changed, 8 insertions(+), 9 deletions(-)
>>>> I applied the patch and cleanup of rtrs-srv.h can be done later.
>>> Thanks! I suppose below
>>>
>>>> So decouple it from rtrs-srv.h and hide everything that not-needed to be
>>>> exported to separate header file.
>>> means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
>>> because both client and server include the header. Pls correct me if I
>>> am wrong.
>>>
>>> Since process_{read,write} prints direction info if ctx->ops.rdma_ev
>>> fails, how
>>> about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
>>> include rtrs-srv.h.
>>>
>>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
>>> index 431c6da19d3f..d07ff3ba560c 100644
>>> --- a/drivers/block/rnbd/rnbd-srv.c
>>> +++ b/drivers/block/rnbd/rnbd-srv.c
>>> @@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct
>>> rtrs_srv_op *id,
>>>                                               datalen);
>>>                   break;
>>>           default:
>>> -               pr_warn("Received unexpected message type %d with dir %d
>>> from session %s\n",
>>> -                       type, id->dir, srv_sess->sessname);
>>> +               pr_warn("Received unexpected message type %d from
>>> session %s\n",
>>> +                       type, srv_sess->sessname);
>>>                   return -EINVAL;
>>>           }
>>>
>>> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
>>> index 5a0ef6c2b5c7..081bceaf4ae9 100644
>>> --- a/drivers/block/rnbd/rnbd-srv.h
>>> +++ b/drivers/block/rnbd/rnbd-srv.h
>>> @@ -14,7 +14,6 @@
>>>    #include <linux/kref.h>
>>>
>>>    #include <rtrs.h>
>>> -#include <rtrs-srv.h>
>>>    #include "rnbd-proto.h"
>>>    #include "rnbd-log.h"
>>>
>>>
>>> Thoughts?
>> I like the idea. Please post a formal patch based on leon's
>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/leon-for-next
> I squashed this hunk into original patch.

Great, thank you!

If possible, to better reflect the change, please at your convenience to 
replace the original commit
message with below.

"Since process_{read,write} already prints direction info if 
ctx->ops.rdma_ev fails, no need to pass 'dir'"

Thanks,
Guoqing
