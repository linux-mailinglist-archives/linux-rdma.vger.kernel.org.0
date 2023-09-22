Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F47AB8EB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjIVSOP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIVSOP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 14:14:15 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F69F;
        Fri, 22 Sep 2023 11:14:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c0d6fef60cso1525035a34.1;
        Fri, 22 Sep 2023 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695406448; x=1696011248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lZCZONWwJtY8CIrPX1J7RTlYuqMPAtDTIWjR4/v6hU=;
        b=LTxKu0TSplBj+1acLVx/HbyVBEcpwwcQK02ZZTiLc8rB3qvJs9gVMz3kwJ/uOebVYy
         kZ5uyo2r0nMwN6b0z9ENfJ+nYWFoqlZOnjBQoim06C8v/Yho3ntj+yIG6deRaH6QaldC
         8HtwMV14vSEARkuCC41Ndl7i7Cg0eXui+rwDqM/u9a+0NKGoeKGFiGno38aIih9MY7gW
         IMziCiCjuJEJn5gCIkPFELO85jADJluIz9W+Al8EsmjxY1V2ZeihAxh0O/Dx5agxe0Qe
         EkVDEDfEpZjbtoOqUIhdQ7VQRkkj37P+bCpy/i+jISRtyKhkJtUE+2vHVHsjsKn5a8Fh
         x63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406448; x=1696011248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lZCZONWwJtY8CIrPX1J7RTlYuqMPAtDTIWjR4/v6hU=;
        b=HZnRvxd2SAyp2D459Sgjj3VsKbzeIZ1uVO/OmeWg5uyr6EkgDKZWF/NkMJx8WKgcxA
         K+jm7dHH9wD87zcWUGiecnttgsl9g4aQctReK1s6/kJL3F09dT5Oeq9MWR7QgU1GNK11
         Qlz12QBhCsapy3gI9zEOFh0lzyTOBAatINBfmHq1L3XXkQOo8Sr5Qt84HcmnlaVXmurD
         AZ76ciOE+UmxyLJ5ThdRfwlNF2EsmG+CTLXiVAxvwb7BmFepNj97zfxToRXlZ/eKwQFd
         ZysHqfUtt/iOac+y7CaH8yk8K843g93ceJ4LjEA4Eldxe7SQ7bkZPWIxSHb93YtfT/i1
         ljOw==
X-Gm-Message-State: AOJu0YzjALAnFHzxRiDBbYgs4nK9YB+IAynXBUEN4rp4ZbE4KJTJF8Go
        jIf7gKKDXbH8Q1rTp6spdJQ=
X-Google-Smtp-Source: AGHT+IEIXpwBR7K8/nunP75X6ifYAZMsmYFDNphalBrwPipMIArMBY9pSY1JDRvIbO9GVXzWuFl0og==
X-Received: by 2002:a05:6830:124c:b0:6bd:cf64:d105 with SMTP id s12-20020a056830124c00b006bdcf64d105mr521878otp.12.1695406448231;
        Fri, 22 Sep 2023 11:14:08 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:10c2:687c:3123:14d1? (2603-8081-1405-679b-10c2-687c-3123-14d1.res6.spectrum.com. [2603:8081:1405:679b:10c2:687c:3123:14d1])
        by smtp.gmail.com with ESMTPSA id q19-20020a9d6653000000b006b753685cc5sm852523otm.79.2023.09.22.11.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 11:14:07 -0700 (PDT)
Message-ID: <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
Date:   Fri, 22 Sep 2023 13:14:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
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
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/23 10:10, Zhu Yanjun wrote:
> 
> 在 2023/9/21 22:39, Bob Pearson 写道:
>> On 9/21/23 09:23, Rain River wrote:
>>> On Thu, Sep 21, 2023 at 2:53 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>> On 9/20/23 12:22, Bart Van Assche wrote:
>>>>> On 9/20/23 10:18, Bob Pearson wrote:
>>>>>> But I have also seen the same behavior in the siw driver which is
>>>>>> completely independent.
>>>>> Hmm ... I haven't seen any hangs yet with the siw driver.
>>>> I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
>>>>>> As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75% of the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.
>>>>> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
>>>>> support for rxe tasks")?
>>>> That change happened well before the failures went away. I was seeing failures at the same rate with tasklets
>>>> and wqs. But after updating Ubuntu and the kernel at some point they all went away.
>>> I made tests on the latest Ubuntu with the latest kernel without the
>>> commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
>>> The latest kernel is v6.6-rc2, the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>>> workqueue support for rxe tasks") is reverted.
>>> I made blktest tests for about 30 times, this problem does not occur.
>>>
>>> So I confirm that without this commit, this hang problem does not
>>> occur on Ubuntu without the commit 9b4b7c1f9f54 ("RDMA/rxe: Add
>>> workqueue support for rxe tasks").
>>>
>>> Nanthan
>>>
>>>>> Thanks,
>>>>>
>>>>> Bart.
>>>>
>> This commit is very important for several reasons. It is needed for the ODP implementation
>> that is in the works from Daisuke Matsuda and also for QP scaling of performance. The work
>> queue implementation scales well with increasing qp number while the tasklet implementation
>> does not. This is critical for the drivers use in large scale storage applications. So, if
>> there is a bug in the work queue implementation it needs to be fixed not reverted.
>>
>> I am still hoping that someone will diagnose what is causing the ULPs to hang in terms of
>> something missing causing it to wait.
> 
> Hi, Bob
> 
> 
> You submitted this commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks").
> 
> You should be very familiar with this commit.
> 
> And this commit causes regression.
> 
> So you should delved into the source code to find the root cause, then fix it.

Zhu,

I have spent tons of time over the months trying to figure out what is happening with blktests.
As I have mentioned several times I have seen the same exact failure in siw in the past although
currently that doesn't seem to happen so I had been suspecting that the problem may be in the ULP.
The challenge is that the blktests represents a huge stack of software much of which I am not
familiar with. The bug is a hang in layers above the rxe driver and so far no one has been able to
say with any specificity the rxe driver failed to do something needed to make progress or violated
expected behavior. Without any clue as to where to look it has been hard to make progress.

My main motivation is making Lustre run on rxe and it does and it's fast enough to meet our needs.
Lustre is similar to srp as a ULP and in all of our testing we have never seen a similar hang. Other
hangs to be sure but not this one. I believe that this bug will never get resolved until someone with
a good understanding of the ulp drivers makes an effort to find out where and why the hang is occurring.
From there it should be straight forward to fix the problem. I am continuing to investigate and am learning
the device-manager/multipath/srp/scsi stack but I have a long ways to go.

Bob


> 
> 
> Jason && Leon, please comment on this.
> 
> 
> Best Regards,
> 
> Zhu Yanjun
> 
>>
>> Bob

