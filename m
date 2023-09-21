Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC87A966A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIURHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIURGe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:06:34 -0400
Received: from out-227.mta0.migadu.com (out-227.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202C4495
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:04:06 -0700 (PDT)
Message-ID: <c20343e9-44d2-1fbc-4191-7ef19f71fbb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695308920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9/SAz1EzoxnJVrN89NE7Xu5/5CKesHUXGlRvXE1pb4=;
        b=UwCyKM274bp3lyCTckhxDcmosWuCzvGAQi2vbX80FfVhWUdnEpXvsXnQFrr38Xo/jo514Z
        bpo+sIUDyw6gKP/Vimh9X0ublgA8Yh/tNfEzgqflmOYsi51FWy4X/fe3nRDpsNOFUqrs90
        m9OIGW5AS1cYBjhA7jAdUlNyGayTmhU=
Date:   Thu, 21 Sep 2023 23:08:32 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Rain River <rain.1986.08.12@gmail.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/21 22:39, Bob Pearson 写道:
> On 9/21/23 09:23, Rain River wrote:
>> On Thu, Sep 21, 2023 at 2:53 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>> On 9/20/23 12:22, Bart Van Assche wrote:
>>>> On 9/20/23 10:18, Bob Pearson wrote:
>>>>> But I have also seen the same behavior in the siw driver which is
>>>>> completely independent.
>>>> Hmm ... I haven't seen any hangs yet with the siw driver.
>>> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
>>>>> As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75% of the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.
>>>> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
>>>> support for rxe tasks")?
>>> That change happened well before the failures went away. I was seeing failures at the same rate with tasklets
>>> and wqs. But after updating Ubuntu and the kernel at some point they all went away.
>> I made tests on the latest Ubuntu with the latest kernel without the
>> commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
>> The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>> workqueue support for rxe tasks") is reverted.
>> I made blktest tests for about 30 times, this problem does not occur.
>>
>> So I confirm that without this commit, this hang problem does not
>> occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>> workqueue support for rxe tasks").
>>
>> Nanthan
>>
>>>> Thanks,
>>>>
>>>> Bart.
>>>
> This commit is very important for several reasons. It is needed for the ODP implementation
> that is in the works from Daisuke Matsuda and also for QP scaling of performance. The work
> queue implementation scales well with increasing qp number while the tasklet implementation
> does not. This is critical for the drivers use in large scale storage applications. So, if
> there is a bug in the work queue implementation it needs to be fixed not reverted.
>
> I am still hoping that someone will diagnose what is causing the ULPs to hang in terms of
> something missing causing it to wait.

Hi, Bob


You submitted this commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support 
for rxe tasks").

You should be very familiar with this commit.

And this commit causes regression.

So you should delved into the source code to find the root cause, then 
fix it.


Jason && Leon, please comment on this.


Best Regards,

Zhu Yanjun

>
> Bob
