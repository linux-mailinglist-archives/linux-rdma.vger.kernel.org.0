Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D64DB375
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356738AbiCPOkx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiCPOku (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 10:40:50 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64D5576C;
        Wed, 16 Mar 2022 07:39:35 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r10so3300074wrp.3;
        Wed, 16 Mar 2022 07:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TnWOzZ+LAk4WVT8ZM9SiVhWa5wWnfmFp/aOVUe/7BHU=;
        b=m3AOCPirpRlVOj3b8DLGRD84lzhioxU+QoIgV6uYXw7u9ADz+yBkUZG3jng6wvTaGU
         fEfpxbzWBSsFBxKddIPAcR/oOm13x1E58T5cYtSWpzG8E8StMfjUHjS9TMpTxJQi4nhs
         9doV9fTmBOVvvQ4r4nl/X9wMXeb2nSX68uuOPNbgBfGY2U/rzFdgbjyFrva05m9NiqVB
         IeDqZ5q3/BQvRlAjDnNnxE3LMCCD5OI189FIJv5713iFqVK3OskuTtnHZCKg1TqIslWP
         G5GrnUIBjcIeRUnhHc9QB8iqI4LInpmxLULO6LWB7rgcQExJKgTyqYyPilFBdYKckETg
         HRuA==
X-Gm-Message-State: AOAM533ibPWiS2n1hG7Z4Q5T0BmXfcwifsiZXGry3YiEB+c7j0yvPqtn
        wDdA8uwnT4RmbkKV0m4PrXz3r7qqWPU=
X-Google-Smtp-Source: ABdhPJx2I3QjVg8gWX/auPynrD8sNn554lDPuxsmrwE+8zfMJBEYrui571VhLzeXP8S9KUkH/hpPFA==
X-Received: by 2002:a05:6000:15c2:b0:203:8348:8cbf with SMTP id y2-20020a05600015c200b0020383488cbfmr193422wry.309.1647441573552;
        Wed, 16 Mar 2022 07:39:33 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600015cf00b00203e324347bsm1102876wry.102.2022.03.16.07.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 07:39:33 -0700 (PDT)
Message-ID: <165698e9-9ccd-c840-b926-48f2ee7c6dcb@grimberg.me>
Date:   Wed, 16 Mar 2022 16:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
Content-Language: en-US
To:     Laurence Oberman <loberman@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
References: <20220311175713.2344960-1-djeffery@redhat.com>
 <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
 <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
 <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
 <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
 <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
 <a1cc6842-1429-eea5-aa0d-47b3f2bab843@nvidia.com>
 <720ebd1f98ab3c709443176011f51d6e3ed37272.camel@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <720ebd1f98ab3c709443176011f51d6e3ed37272.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>>>>>> Hi David,
>>>>>>>
>>>>>>> thanks for the report.
>>>>>>>
>>>>>>> Please check how we fixed that in NVMf in Sagi's commit:
>>>>>>>
>>>>>>> nvmet-rdma: fix possible bogus dereference under heavy load
>>>>>>> (commit:
>>>>>>> 8407879c4e0d77)
>>>>>>>
>>>>>>> Maybe this can be done in isert and will solve this problem
>>>>>>> in
>>>>>>> a simpler
>>>>>>> way.
>>>>>>>
>>>>>>> is it necessary to change max_cmd_sn ?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Sure, there are alternative methods which could fix this
>>>>>> immediate
>>>>>> issue. e.g. We could make the command structs for scsi
>>>>>> commands
>>>>>> get
>>>>>> allocated from a mempool. Is there a particular reason you
>>>>>> don't
>>>>>> want
>>>>>> to do anything to modify max_cmd_sn behavior?
>>>>>
>>>>> according to the description the command was parsed successful
>>>>> and
>>>>> sent
>>>>> to the initiator.
>>>>>
>>>>
>>>> Yes.
>>>>
>>>>> Why do we need to change the window ? it's just a race of
>>>>> putting
>>>>> the
>>>>> context back to the pool.
>>>>>
>>>>> And this race is rare.
>>>>>
>>>>
>>>> Sure, it's going to be rare. Systems using isert targets with
>>>> infiniband are going to be naturally rare. It's part of why I
>>>> left
>>>> the
>>>> max_cmd_sn behavior untouched for non-isert iscsit since they
>>>> seem to
>>>> be fine as is. But it's easily and regularly triggered by some
>>>> systems
>>>> which use isert, so worth fixing.
>>>>
>>>>>> I didn't do something like this as it seems to me to go
>>>>>> against
>>>>>> the
>>>>>> intent of the design. It makes the iscsi window mostly
>>>>>> meaningless in
>>>>>> some conditions and complicates any allocation path since it
>>>>>> now
>>>>>> must
>>>>>> gracefully and sanely handle an iscsi_cmd/isert_cmd not
>>>>>> existing.
>>>>>> I
>>>>>> assume special commands like task-management, logouts, and
>>>>>> pings
>>>>>> would
>>>>>> need a separate allocation source to keep from being dropped
>>>>>> under
>>>>>> memory load.
>>>>>
>>>>> it won't be dropped. It would be allocated dynamically and
>>>>> freed
>>>>> (instead of putting it back to the pool).
>>>>>
>>>>
>>>> If it waits indefinitely for an allocation it ends up with a
>>>> variation
>>>> of the original problem under memory pressure. If it waits for
>>>> allocation on isert receive, then receive stalls under memory
>>>> pressure
>>>> and won't process the completions which would have released the
>>>> other
>>>> iscsi_cmd structs just needing final acknowledgement.
>>
>> If your system is under such memory pressure can you can't allocate
>> few
>> bytes for isert response, the silent drop
>>
>> of the command is your smallest problem. You need to keep the system
>> from crashing. And we do that in my suggestion.
>>
>>>>
>>>> David Jeffery
>>>>
>>>
>>> Folks this is a pending issue stopping a customer from making
>>> progress.
>>> They run Oracle and very high workloads on EDR 100 so David fixed
>>> this
>>> fosusing on the needs of the isert target changes etc.
>>>
>>> Are you able to give us technical reasons why David's patch is not
>>> suitable and why we he would have to start from scratch.
>>
>> You shouldn't start from scratch. You did all the investigation and
>> the
>> debugging already.
>>
>> Coding a solution is the small part after you understand the root
>> cause.
>>
>>>
>>> We literally spent weeks on this and built another special lab for
>>> fully testing EDR 100.
>>> This issue was pending in a BZ for some time and Mellnox had eyes
>>> on it
>>> then but this latest suggestion was never put forward in that BZ to
>>> us.
>>
>> Mellanox maintainers saw this issue few days before you sent it
>> upstream. I suggested sending it upstream and have a discussion here
>> since it has nothing to do with Mellanox adapters and Mellanox SW
>> stack
>> MLNX_OFED.
>>
>> Our job as maintainers and reviewers in the community is to see the
>> big
>> picture and suggest solutions that not always same as posted in the
>> mailing list.
>>
>>>
>>> Sincerely
>>> Laurence
>>>
>>
>>
> 
> Hi Max

Hey,

> The issue was reported with the OFED stack at the customer, so its why
> we opened the BZ to get the Mallnox partners engineers engaged.
> We had them then see if it also existed with the inbox stack which it
> did.
> Sergey worked a little bit on the issue but did not have the same
> suggestion you provivided and asked David for help.

I think you can move the corporate discussions offline.

> We will be happy to take the fix you propose doing it your way. May I
> that the engineewrs to work on this the most and understand the code
> best propose a fix your way.

I tend to agree with Max, I looked into the patch and I can't say that
we know for a fact that incrementing the cmdsn after releasing the
iscsi cmd will not introduce anything else (although looks fine at
a high-level).

Is there any measure-able performance implication?

Max, doing dynamic allocation is also a valid fix.
