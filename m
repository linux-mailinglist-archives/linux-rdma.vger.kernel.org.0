Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210D1D56A6
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOQwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 12:52:18 -0400
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:36714
        "EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgEOQwS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 May 2020 12:52:18 -0400
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id ZdZIj3dek3cFQZdZIjuv5y; Fri, 15 May 2020 09:52:17 -0700
X-CMAE-Analysis: v=2.3 cv=arjM9hRV c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=CbDCq_QkAAAA:8
 a=paghG1xD4p1AdRdQ23MA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=1qrBK16LubpBFNPVNq2M:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     santosh.shilimkar@oracle.com, Sagi Grimberg <sagi@grimberg.me>,
        Aron Silverton <aron.silverton@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
 <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <75f2cbe4-3a62-9b0e-93c7-fb076bf318bf@talpey.com>
Date:   Fri, 15 May 2020 12:52:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNf00vSZo4/+PdYUlB0Ci9dBmPYook8hWKLgn4gCN9QST2usN3kehialJ0Y3DULfk1xLPAtOOqI1wNLv9CL6eYL7DovuR14evHd7c0vGGfGD5Djfl3bt
 sEfYqAZvSXfqluA+i79t+T0WSUKB35lezquxfiQFXLiHmAop/eLLqhoUvfWXcKEpQhwOKn5kkvvARNCnwInmBh/vlPZBKeqqZFm5F5jRMcR2fjHnQ10OB9ms
 YWuZCddlzNDTteOeqi04E8y52HKXSziH3ZiwUvCmqASIhl0Wp/sLPGoSV4BIvnq9A04exCPBgBjDaVXKP9V1Qv6JzycBPgZtAeSWw/HHMpIQ/c6UtJ3sGs94
 W1EnbqbLKNP2Oy2vD3z9P+vcTFSZp7tLau3IuVcatSNzPm23/QGhWBJNsb54VdshiLqGvbpSkW3qqyrVkqToC883oaMXlgfbT1CC15dsUqNiQtlgmdeZDDmO
 b0Ugi7gM3sE7L0PH
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/2020 7:41 PM, santosh.shilimkar@oracle.com wrote:
> On 5/14/20 3:23 PM, Sagi Grimberg wrote:
>>
>>>> +Santosh
>>>>
>>>> You probably meant to copy the RDS maintainer? Not sure if this 
>>>> should have
>>>> also been sent to netdev@vger.kernel.org.
>>>>
>>> Thanks Aron.
>>>
>>>>
>>>>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>>>
>>>>> This series removes the support for FMR mode to register memory. 
>>>>> This ancient
>>>>> mode is unsafe and not maintained/tested in the last few years. It 
>>>>> also doesn't
>>>>> have any reasonable advantage over other memory registration 
>>>>> methods such as
>>>>> FRWR (that is implemented in all the recent RDMA adapters). This 
>>>>> series should
>>>>> be reviewed and approved by the maintainer of the effected drivers 
>>>>> and I
>>>>> suggest to test it as well.
>>>>>
>>> I know the security issue has been brought up before and this plan of 
>>> removal of FMR support was on the cards
>>
>> Actually, what is unsafe is not necessarily fmrs, but rather the
>> fmr_pool interface. So Max, you can keep fmr if rds wants it, but
>> we can get rid of fmr pools.
>>
> Good point. We aren't using the fmr_pools.

It's not only the fmr_pools. The FMR API operates on a page granularity,
so a sub-page registration, or a non-page-aligned one, ends up exposing
data outside the buffer. This is done silently, and is a significant
vulnerability for most upper layers.

Tom.

>>> but on RDS at least on CX3 we
>>> got more throughput with FMR vs FRWR. And the reasons are well
>>> understood as well why its the case.
>>
>> Looking at the rds code, it seems that rds doesn't do any fast
>> registration at all, rkeys are long lived and are only invalidated (or
>> unmaped) when need recycling or when a socket is torn down...
>>
>> So I'm not clear exactly about the model here, but seems to me
>> its almost like rds needs something like phys_mr, which is static for
>> all of its lifetime. It seems that fmrs just create a hassle for
>> rds, unless I'm missing something...
>>
>> Having said that, it surely isn't the most secure behavior...
>> At least its not the global dma rkey...
>>
> There are couple of layers but you can see the FRWR code inside,
> net/rds/ib_frmr.c. The MR allocation as well as free/invalidation
> is managed from user-land instead of ULP data path. There are
> couple of cases where some use_once semantics does MR invalidation
> within kernel but thats only because userland indicated that MR
> key can be invalidated after issued RDMA ops is complete.
> 
>>> Is it possible to keep core support still around so that HCA's which
>>> supports FMR, ULPs can still can leverage it if they want.
>>>  From RDS perspective, if the HCA like CX3 doesn't support both modes,
>>> code prefers FMR vs FRWR and hence the question.
>>
>> Max can start by removing fmr_pools, fmrs can stay as there is nothing
>> fundamentally wrong with them. And apparently there are still users.
> 
> That will surely help if its an option. RDS don't use fmr_pools so no
> issues there.
> 
> Regards,
> Santosh
> 
> 
> 
> 
