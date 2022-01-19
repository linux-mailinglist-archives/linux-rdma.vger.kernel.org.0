Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD040493BBC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355049AbiASOKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 09:10:02 -0500
Received: from out2.migadu.com ([188.165.223.204]:45419 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355065AbiASOJW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 09:09:22 -0500
Message-ID: <4e1e7cf6-d41b-6926-68cf-e58ca79a4559@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642601359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibECacK/wyjKGTjXXJNuFuoTLliCl6+oUZXJXpQ0yLw=;
        b=EV4pMz8Z6zrXccmIm9Ji8LM84ccd2KtML4PrnReae/JBY18Q2KS/VnWqIZDRBpeWIAELyD
        S4GrKuqTAsOUW5+Etk+zBFKSknPPD8ly46JAgfWlLox61ohet+IMsHviezOvYe3rfNR1rx
        0/cGqOzPz9XqXxpuOiQNsjDAq6mZFPY=
Date:   Wed, 19 Jan 2022 22:08:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
 <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
 <61DE51D7.5050400@fujitsu.com>
 <468c411e-8f68-00da-5c44-a3de72bf0d9b@linux.dev>
 <61E623DF.5000007@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <61E623DF.5000007@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/1/18 10:20, yangx.jy@fujitsu.com 写道:
> On 2022/1/15 11:38, Yanjun Zhu wrote:
>> 在 2022/1/12 11:58, yangx.jy@fujitsu.com 写道:
>>> On 2022/1/12 9:19, Yanjun Zhu wrote:
>>>> 在 2022/1/11 23:16, Haakon Bugge 写道:
>>>>>> On 11 Jan 2022, at 15:42, Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>>>>>
>>>>>>
>>>>>> 在 2022/1/10 13:17, yangx.jy@fujitsu.com 写道:
>>>>>>> On 2022/1/7 19:49, Yanjun Zhu wrote:
>>>>>>>> It seems that it does not mean to check the last packet. It means
>>>>>>>> that
>>>>>>>> it receives a MSN response.
>>>>>>> Hi Yanjun,
>>>>>>>
>>>>>>> Checking the last packet is a way to indicate that responder has
>>>>>>> completed an entire request(including multiple packets) and then
>>>>>>> increases a msn.
>>>>>> Hi, Xiao
>>>>>>
>>>>>> What does the msn mean?
>>>>> Message Sequence Number.
>>>> Thanks, Haakon
>>>>
>>>> I am reading the following from the spec.
>>>>
>>>> "
>>>>
>>>> C9-148: An HCA responder using Reliable Connection service shall
>>>> initialize
>>>>
>>>> its MSN value to zero. The responder shall increment its MSN
>>>> whenever it has successfully completed processing a new, valid request
>>>> message. The MSN shall not be incremented for duplicate requests. The
>>>> incremented MSN shall be returned in the last or only packet of an RDMA
>>>> READ or Atomic response. For RDMA READ requests, the responder
>>>> may increment its MSN after it has completed validating the request and
>>>> before it has begun transmitting any of the requested data, and may
>>>> return
>>>> the incremented MSN in the AETH of the first response packet. The MSN
>>>> shall be incremented only once for any given request message.
>>>>
>>>> "
>>>>
>>>> It seems that the above describe how to handle MSN increment in
>>>> details.
>>> Hi Yanjun,
>>>
>>> Sorry for the late reply.
>>>
>>> Right, 9.7.7.1 GENERATING MSN VALUE section explains Message Sequence

"

...

Since the responder may choose to coalesce acknowledges, a single 
response packet may in fact acknowledge
several request messages. Thus, when it receives a new MSN, the 
requester begins evaluating WQEs on its send queue beginning with the
oldest outstanding WQE and progressing forward.

...

"

In the above, several request messages come. From the SPEC, msn should 
increase based on the number of request messages.

Can your commit handle the above case?


Zhu Yanjun

>> Does your commit take into account of duplicate requests?
> Hi Yanjun,
>
> Responder will check duplicate requests by check_psn() and process them
> by duplicate_request().
> According to the logic of duplicate_request(), responder doesn't
> increase msn for duplicate requests.
>
> Best Regards,
> Xiao Yang
>> Zhu Yanjun
>>
>>> Number(MSN).
>>>
>>> Best Regards,
>>> Xiao Yang
>>>> Zhu Yanjun
>>>>
>>>>> Thxs, Håkon
>>>>>
>>>>>> Thanks a lot.
>>>>>>
>>>>>> Zhu Yanjun
>>>>>>
>>>>>>> Best Regards,
>>>>>>> Xiao Yang
