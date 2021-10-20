Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7B434B95
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTMym (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 08:54:42 -0400
Received: from out0.migadu.com ([94.23.1.103]:40845 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhJTMym (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 08:54:42 -0400
Subject: Re: 10 more python test cases for rxe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634734345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krl87c+mNhLj+Y2hqcvfhbyPxcaccoPDR0HAUxkeOqA=;
        b=cX+ifavI7H6xjE85hvTlkH/atr4J7/uFsH1uV9eDrNeNp2JCFUnmeP9r2akhgdggTR6Rsh
        A0FTSliS8VBffbM7HjGtKX9T9K+XGmcwoLqf5Qp9RgJdkIXhHIYemQKwxdRIpNz00AWSI6
        /YOiXp4NDBH20RjF6pbwzVoD9Vzogao=
To:     Edward Srouji <edwards@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
 <20211013150045.GG2744544@nvidia.com>
 <CAD=hENcvfUbbhJ_fZ58A7KeyY74mGP2v4Q7D84nCnwJnBVmzBQ@mail.gmail.com>
 <DM4PR12MB5216785DF4827AF953E2AC04DABE9@DM4PR12MB5216.namprd12.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
Message-ID: <3c13fea1-31cd-e45c-b4bb-a75792b37c0f@linux.dev>
Date:   Wed, 20 Oct 2021 20:52:21 +0800
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB5216785DF4827AF953E2AC04DABE9@DM4PR12MB5216.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/10/20 18:27, Edward Srouji 写道:
>> On Wed, Oct 13, 2021 at 11:00 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>
>>> On Wed, Oct 13, 2021 at 09:43:28AM -0500, Bob Pearson wrote:
>>>> Zhu,
>>>>
>>>> There are about 10 test cases in the python suite that do not run
>>>> for rxe because
>>>>
>>>>        ... skipped "Device rxe0 doesn't have net interface"
>>>>
>>>> Clearly this is wrong and I don't know how to address the root cause
>>>> yet but the following hack where enp0s3 is the actual net device
>>>> that rxe0 is based on in my case enables these test cases to run and it
>> appears they all do.
>>>>
>>>> diff --git a/tests/base.py b/tests/base.py
>>>>
>>>> index 3460c546..d6fd29b8 100644
>>>>
>>>>
>>>> +++ b/tests/base.py
>>>>
>>>> @@ -240,10 +240,11 @@ class RDMATestCase(unittest.TestCase):
>>>>
>>>>               if self.gid_type is not None and
>>>> ctx.query_gid_type(port, idx) != \
>>>>
>>>>                       self.gid_type:
>>>>
>>>>                   continue
>>>>
>>>> -            if not
>> os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>>>
>>>> -                self.args.append([dev, port, idx, None, None])
>>>>
>>>> -                continue
>>>>
>>>> -            net_name = self.get_net_name(dev)
>>>>
>>>> +            #if not
>> os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>>
>>> The pytests code is wrong - it should be querying the netdev through
>>> the verbs APIs, not hacking in sysfs like this.
>>
>> Got it. Thanks
>>
>> Zhu Yanjun
>>
>>>
>>> Jason
> 
> I will modify the base test file to use verbs API instead of accessing the sysfs directly.
> I wanted to do that using ibv_query_gid_ex to get the netdev ifindex, but in case of IB (IPoIB) the netdex is just 0 and not updated accordingly.
> Not sure if it's a bug or by design (looks like a bug for me).
> I'll check that and update accordingly.

Hope all the test cases are ready.

Zhu Yanjun

> 
> Thanks,
> Edward.
> 

