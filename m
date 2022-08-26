Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7375A26F6
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbiHZLiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbiHZLit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 07:38:49 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF19DB7FA;
        Fri, 26 Aug 2022 04:38:48 -0700 (PDT)
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661513926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJ83ru0xPN3HQ3yZ2UAUZdgSAa0RtA4gNphxbcOfp5U=;
        b=NpmUuHuiPJa5Ll2Gj2NOdhC060Pm8G3Wj+mNdO2hZ1smBGOdyKgqiIOm4BUifdwjKjLrQ0
        uDeV54V6Bfn3L8/lYXFebtlH5PfYqHGNFXFnv2eVVgTQcKDYbkXusuwWUSEthZtQQOTvGn
        /JAM9pB3DAVCwqGkB+Ai06bam4xxKp0=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
 <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev>
 <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <c4fb6007-91f9-6d2c-4888-d49a08dd297e@linux.dev>
Date:   Fri, 26 Aug 2022 19:38:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/26/22 7:29 PM, Jinpu Wang wrote:
> On Fri, Aug 26, 2022 at 1:26 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>
>>
>> On 8/26/22 6:48 PM, Jinpu Wang wrote:
>>> On Fri, Aug 26, 2022 at 10:11 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>>> Since all callers (process_{read,write}) set id->dir, no need to
>>>> pass 'dir' again.
>>>>
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> ---
>>>>    drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
>>>>    drivers/block/rnbd/rnbd-srv.h          | 1 +
>>>>    drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>>>>    drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
>>>>    4 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
>>>> index 3f6c268e04ef..9600715f1029 100644
>>>> --- a/drivers/block/rnbd/rnbd-srv.c
>>>> +++ b/drivers/block/rnbd/rnbd-srv.c
>>>> @@ -368,10 +368,9 @@ static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
>>>>                                    const void *msg, size_t len,
>>>>                                    void *data, size_t datalen);
>>>>
>>>> -static int rnbd_srv_rdma_ev(void *priv,
>>>> -                           struct rtrs_srv_op *id, int dir,
>>>> -                           void *data, size_t datalen, const void *usr,
>>>> -                           size_t usrlen)
>>>> +static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
>>>> +                           void *data, size_t datalen,
>>>> +                           const void *usr, size_t usrlen)
>>>>    {
>>>>           struct rnbd_srv_session *srv_sess = priv;
>>>>           const struct rnbd_msg_hdr *hdr = usr;
>>>> @@ -398,7 +397,7 @@ static int rnbd_srv_rdma_ev(void *priv,
>>>>                   break;
>>>>           default:
>>>>                   pr_warn("Received unexpected message type %d with dir %d from session %s\n",
>>>> -                       type, dir, srv_sess->sessname);
>>>> +                       type, id->dir, srv_sess->sessname);
>>>>                   return -EINVAL;
>>>>           }
>>>>
>>>> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
>>>> index 081bceaf4ae9..5a0ef6c2b5c7 100644
>>>> --- a/drivers/block/rnbd/rnbd-srv.h
>>>> +++ b/drivers/block/rnbd/rnbd-srv.h
>>>> @@ -14,6 +14,7 @@
>>>>    #include <linux/kref.h>
>>>>
>>>>    #include <rtrs.h>
>>>> +#include <rtrs-srv.h>
>>> why do we need this?
>> Otherwise, compiler complains
>>
>> drivers/block/rnbd/rnbd-srv.c: In function ‘rnbd_srv_rdma_ev’:
>> drivers/block/rnbd/rnbd-srv.c:400:33: error: invalid use of undefined
>> type ‘struct rtrs_srv_op’
>>     400 |                         type, id->dir, srv_sess->sessname);
>>
>> Thanks,
>> Guoqing
> ah, okay, this reminds me, why we have dir there, we don't want to
> export too much detail regarding the rtrs_srv_op to
> rnbd-server, it is supposed to be transparent  to rnbd-srv.

What is the issue with more details are exported from rtrs-srv? Both of 
the modules
are run in the same machine.

And I guess we can just pass parameters with register after remove an 
argument,
otherwise need to push/pop stack with more than six parameters for x64.

Thanks,
Guoqing
