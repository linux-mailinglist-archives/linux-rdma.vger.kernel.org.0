Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC47AE586
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjIZGJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjIZGJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 02:09:46 -0400
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7484FC
        for <linux-rdma@vger.kernel.org>; Mon, 25 Sep 2023 23:09:38 -0700 (PDT)
Message-ID: <02d61fa2-9222-a071-8442-ef43a3aa74a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695708576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXAnIIVFOKmek0NM+/AbujoVFfy65fiiOMDmpp4GEgA=;
        b=Caf5NQc2SKLVAA4/LH7hjRWfe6d8li66rftJuOBKP2qoBDPKpMwp/V5QdDXyYKJAJAgK/r
        LwEhixZfJL2yXFN7jqcT1bPt8A1VZw4nDgCDilLYwfjcySH/Y7VePvcuVDKCJgPdc0wmDs
        uf8ubZmp6JCLuYs/6umqMu/is5ucgNw=
Date:   Tue, 26 Sep 2023 14:09:28 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
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
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a940c460-af66-df45-f718-b669746880db@linux.dev>
 <OS7PR01MB11804B7BFCD8A3DF78E51DD5CE5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS7PR01MB11804B7BFCD8A3DF78E51DD5CE5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
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

在 2023/9/26 9:09, Daisuke Matsuda (Fujitsu) 写道:
> On Mon, Sep 25, 2023 11:31 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2023/9/25 12:47, Daisuke Matsuda (Fujitsu) 写道:
>>> On Sun, Sep 24, 2023 10:18 AM Rain River wrote:
>>>> On Sat, Sep 23, 2023 at 2:14 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>> On 9/21/23 10:10, Zhu Yanjun wrote:
>>>>>> 在 2023/9/21 22:39, Bob Pearson 写道:
>>>>>>> On 9/21/23 09:23, Rain River wrote:
>>>>>>>> On Thu, Sep 21, 2023 at 2:53 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>>>>> On 9/20/23 12:22, Bart Van Assche wrote:
>>>>>>>>>> On 9/20/23 10:18, Bob Pearson wrote:
>>>>>>>>>>> But I have also seen the same behavior in the siw driver which is
>>>>>>>>>>> completely independent.
>>>>>>>>>> Hmm ... I haven't seen any hangs yet with the siw driver.
>>>>>>>>> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
>>>>>>>>>>> As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75%
>> of
>>>> the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.
>>>>>>>>>> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
>>>>>>>>>> support for rxe tasks")?
>>>>>>>>> That change happened well before the failures went away. I was seeing failures at the same rate with tasklets
>>>>>>>>> and wqs. But after updating Ubuntu and the kernel at some point they all went away.
>>>>>>>> I made tests on the latest Ubuntu with the latest kernel without the
>>>>>>>> commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
>>>>>>>> The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>>>>>>>> workqueue support for rxe tasks") is reverted.
>>>>>>>> I made blktest tests for about 30 times, this problem does not occur.
>>>>>>>>
>>>>>>>> So I confirm that without this commit, this hang problem does not
>>>>>>>> occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>>>>>>>> workqueue support for rxe tasks").
>>>>>>>>
>>>>>>>> Nanthan
>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>> Bart.
>>>>>>> This commit is very important for several reasons. It is needed for the ODP implementation
>>>>>>> that is in the works from Daisuke Matsuda and also for QP scaling of performance. The work
>>>>>>> queue implementation scales well with increasing qp number while the tasklet implementation
>>>>>>> does not. This is critical for the drivers use in large scale storage applications. So, if
>>>>>>> there is a bug in the work queue implementation it needs to be fixed not reverted.
>>>>>>>
>>>>>>> I am still hoping that someone will diagnose what is causing the ULPs to hang in terms of
>>>>>>> something missing causing it to wait.
>>>>>> Hi, Bob
>>>>>>
>>>>>>
>>>>>> You submitted this commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
>>>>>>
>>>>>> You should be very familiar with this commit.
>>>>>>
>>>>>> And this commit causes regression.
>>>>>>
>>>>>> So you should delved into the source code to find the root cause, then fix it.
>>>>> Zhu,
>>>>>
>>>>> I have spent tons of time over the months trying to figure out what is happening with blktests.
>>>>> As I have mentioned several times I have seen the same exact failure in siw in the past although
>>>>> currently that doesn't seem to happen so I had been suspecting that the problem may be in the ULP.
>>>>> The challenge is that the blktests represents a huge stack of software much of which I am not
>>>>> familiar with. The bug is a hang in layers above the rxe driver and so far no one has been able to
>>>>> say with any specificity the rxe driver failed to do something needed to make progress or violated
>>>>> expected behavior. Without any clue as to where to look it has been hard to make progress.
>>>> Bob
>>>>
>>>> Work queue will sleep. If work queue sleep for long time, the packets
>>>> will not be sent to ULP. This is why this hang occurs.
>>> In general work queue can sleep, but the workload running in rxe driver
>>> should not sleep because it was originally running on tasklet and converted
>>> to use work queue. A task can sometime take longer because of IRQs, but
>>> the same thing can also happen with tasklet. If there is a difference between
>>> the two, I think it would be the overhead of scheduring the work queue.
>>>
>>>> Difficult to handle this sleep in work queue. It had better revert
>>>> this commit in RXE.
>>> I am objected to reverting the commit at this stage. As Bob wrote above,
>>> nobody has found any logical failure in rxe driver. It is quite possible
>>> that the patch is just revealing a latent bug in the higher layers.
>>
>> To now, on Debian and Fedora, all the tests with work queue will hang.
>> And after reverting this commit,
>>
>> no hang will occur.
>>
>> Before new test results, it is a reasonable suspect that this commit
>> will result in the hang.
> 
> If the hang *always* occurs, then I agree your opinion is correct,

About hang tests, please read through the whole discussion. Several 
engineers made tests on Debian, Fedora and Ubuntu to confirm these test 
results.

Zhu Yanjun

> but this one happens occasionally. It is also natural to think that
> the commit makes it easier to meet the condition of an existing bug.
> 
>>
>>>
>>>> Because work queue sleeps,  ULP can not wait for long time for the
>>>> packets. If packets can not reach ULPs for long time, many problems
>>>> will occur to ULPs.
>>> I wonder where in the rxe driver does it sleep. BTW, most packets are
>>> processed in NET_RX_IRQ context, and work queue is scheduled only
>>
>> Do you mean NET_RX_SOFTIRQ?
> 
> Yes. I am sorry for confusing you.
> 
> Thanks,
> Daisuke
> 
>>
>> Zhu Yanjun
>>
>>> when there is already a running context. If your speculation is to the point,
>>> the hang will occur more frequently if we change it to use work queue exclusively.
>>> My ODP patches include a change to do this.
>>> Cf.
>> https://lore.kernel.org/lkml/7699a90bc4af10c33c0a46ef6330ed4bb7e7ace6.1694153251.git.matsuda-daisuke@fujitsu.c
>> om/
>>>
>>> Thanks,
>>> Daisuke
>>>
>>>>> My main motivation is making Lustre run on rxe and it does and it's fast enough to meet our needs.
>>>>> Lustre is similar to srp as a ULP and in all of our testing we have never seen a similar hang. Other
>>>>> hangs to be sure but not this one. I believe that this bug will never get resolved until someone with
>>>>> a good understanding of the ulp drivers makes an effort to find out where and why the hang is occurring.
>>>>>   From there it should be straight forward to fix the problem. I am continuing to investigate and am learning
>>>>> the device-manager/multipath/srp/scsi stack but I have a long ways to go.
>>>>>
>>>>> Bob
>>>>>
>>>>>
>>>>>>
>>>>>> Jason && Leon, please comment on this.
>>>>>>
>>>>>>
>>>>>> Best Regards,
>>>>>>
>>>>>> Zhu Yanjun
>>>>>>
>>>>>>> Bob

