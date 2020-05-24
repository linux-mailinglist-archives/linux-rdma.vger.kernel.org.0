Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0A1DFC34
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2020 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgEXB1y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 21:27:54 -0400
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:41711
        "EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbgEXB1y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 May 2020 21:27:54 -0400
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id cfQcjZA3RwSzlcfQcjhtVl; Sat, 23 May 2020 18:27:51 -0700
X-CMAE-Analysis: v=2.3 cv=PMNxBsiC c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=IkcTkHD0fZMA:10 a=BCZ4t0ovHPUC9Q3tnhUA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, sagi@grimberg.me,
        israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
 <20200518181035.GM24561@mellanox.com>
 <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
 <20200519135352.GV24561@mellanox.com> <20200519141927.GR188135@unreal>
 <774b4d00-ab2e-6f1a-eaa6-a7afadc3c44d@intel.com>
 <20200519143030.GA23839@mellanox.com>
 <5563b8da-faf3-1af5-33d0-fe5a6d7291a1@intel.com>
 <20200523220821.GB744@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <94aca558-442a-c37e-f0c4-e000813721cb@talpey.com>
Date:   Sat, 23 May 2020 21:27:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523220821.GB744@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHsAAia/Ot3DGQij5OEoDvum4illJf2qpmI7BP/9o+wUNPda26hR65MjZaMBLn5/h5S4K+w3l3nBjjn40KXnBGkU7lsGxEtY/M/+HSkdAGYFe5vbpZGk
 1ofhIh45jnOOh+HM9bB9YM7K/1/KWFg9sSqX+5R1YX8HOUBes+RcdsQaKkW+rtZi4gAKiKKDjWXehnIT98GeJW6sNCxG1DqlbwFLaZG3QYnbKbbmx2T0hqdY
 RRZlIDqyJYL7YVu4mUD4v+TfKhmblnr1ztD40CJeI12JAgiC+NaDCnFHY2FL0aXjZ5oBWefnWV9SFP3vH8NEtwN1S4xE46HlLALYqgP1vgdH4Ry0Dp86Ye4v
 MlkeQMZGGTAJmmH6z30Ug/OiPv8WJSjX6DulvrM5b0JsgBhIkBOZflzixDhbsFcZDUFr02+6U23mf7g6tnYFYDOIDLuSJhY1BTtCbx9f0RyZZpQrHtMgEpbh
 ePpN1Vh6B8kFyhxU
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/23/2020 6:08 PM, Jason Gunthorpe wrote:
> On Tue, May 19, 2020 at 10:37:07AM -0400, Dennis Dalessandro wrote:
>> On 5/19/2020 10:30 AM, Jason Gunthorpe wrote:
>>> On Tue, May 19, 2020 at 10:26:37AM -0400, Dennis Dalessandro wrote:
>>>> On 5/19/2020 10:19 AM, Leon Romanovsky wrote:
>>>>> On Tue, May 19, 2020 at 10:53:52AM -0300, Jason Gunthorpe wrote:
>>>>>> On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
>>>>>>> On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
>>>>>>>> On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
>>>>>>>>> On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
>>>>>>>>>> This series removes the support for FMR mode to register memory. This ancient
>>>>>>>>>> mode is unsafe and not maintained/tested in the last few years. It also doesn't
>>>>>>>>>> have any reasonable advantage over other memory registration methods such as
>>>>>>>>>> FRWR (that is implemented in all the recent RDMA adapters). This series should
>>>>>>>>>> be reviewed and approved by the maintainer of the effected drivers and I
>>>>>>>>>> suggest to test it as well.
>>>>>>>>>>
>>>>>>>>>> The tests that I made for this series (fio benchmarks and fio verify data):
>>>>>>>>>> 1. iSER initiator on ConnectX-4
>>>>>>>>>> 2. iSER initiator on ConnectX-3
>>>>>>>>>> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
>>>>>>>>>> 4. SRP initiator on ConnectX-3
>>>>>>>>>>
>>>>>>>>>> Not tested:
>>>>>>>>>> 1. RDS
>>>>>>>>>> 2. mthca
>>>>>>>>>> 3. rdmavt
>>>>>>>>>
>>>>>>>>> This will effectively kill qib which uses rdmavt. It's gonna have to be a
>>>>>>>>> NAK from me.
>>>>>>>>
>>>>>>>> Are you objecting the SRP and iSER changes too?
>>>>>>>
>>>>>>> No, just want to keep basic verbs support at least. NFS already dropped,
>>>>>>> similarly we are ok with dropping it from SRP/iSER as a next step.
>>>>>>
>>>>>> So you see a major user in RDS for qib?
>>>>>
>>>>> Didn't we agree to drop it from RDS too?
>>>>>
>>>>
>>>> Just basic verbs application support is enough for qib I think. I don't see
>>>> any major use of RDS.
>>>
>>> Well, once the in-kernel users of an API are gone that API will be
>>> purged. This is standard kernel policy.
>>>
>>> So you can't NAK this series on the grounds you want to keep an API
>>> without users, presumably for out of tree modules...
>>>
>>
>> Maybe I need to look at this again. I thought it would kill off user access
>> as well. We don't need any kernel ULPs.
> 
> Did you make a conclusion? Seems like everyone else is in agreement
> here, if Max resends a v2 I'm inclined to take it unless RDS objects.
> 
> I did not think FMR or FRWR were available from userspace at all.

I certainly hope they're not available from userspace, as they both take
physaddrs to reference memory!

Tom.
