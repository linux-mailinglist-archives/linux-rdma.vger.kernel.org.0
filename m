Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C691D9A14
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgESOhL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 10:37:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:37858 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgESOhL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 10:37:11 -0400
IronPort-SDR: 0V41OJM9M1tsauGFr0T4TusK6B2cNx3vfnYKtX5FQk4/oZKkSybI+kzrL01FmtmdDOLX14WSRD
 fNJz6tnV7XDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 07:37:10 -0700
IronPort-SDR: RrRTJEdE2FjVyn+seHOff44d002V32+V0sqFjRjzLbMrC+aWAwqtaZl9f1+f5UkC/YgUi8l5dv
 +CIWg/1xl/Lw==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="267904692"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.253]) ([10.254.202.253])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 07:37:08 -0700
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Jason Gunthorpe <jgg@mellanox.com>
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
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5563b8da-faf3-1af5-33d0-fe5a6d7291a1@intel.com>
Date:   Tue, 19 May 2020 10:37:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519143030.GA23839@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/2020 10:30 AM, Jason Gunthorpe wrote:
> On Tue, May 19, 2020 at 10:26:37AM -0400, Dennis Dalessandro wrote:
>> On 5/19/2020 10:19 AM, Leon Romanovsky wrote:
>>> On Tue, May 19, 2020 at 10:53:52AM -0300, Jason Gunthorpe wrote:
>>>> On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
>>>>> On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
>>>>>> On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
>>>>>>> On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
>>>>>>>> This series removes the support for FMR mode to register memory. This ancient
>>>>>>>> mode is unsafe and not maintained/tested in the last few years. It also doesn't
>>>>>>>> have any reasonable advantage over other memory registration methods such as
>>>>>>>> FRWR (that is implemented in all the recent RDMA adapters). This series should
>>>>>>>> be reviewed and approved by the maintainer of the effected drivers and I
>>>>>>>> suggest to test it as well.
>>>>>>>>
>>>>>>>> The tests that I made for this series (fio benchmarks and fio verify data):
>>>>>>>> 1. iSER initiator on ConnectX-4
>>>>>>>> 2. iSER initiator on ConnectX-3
>>>>>>>> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
>>>>>>>> 4. SRP initiator on ConnectX-3
>>>>>>>>
>>>>>>>> Not tested:
>>>>>>>> 1. RDS
>>>>>>>> 2. mthca
>>>>>>>> 3. rdmavt
>>>>>>>
>>>>>>> This will effectively kill qib which uses rdmavt. It's gonna have to be a
>>>>>>> NAK from me.
>>>>>>
>>>>>> Are you objecting the SRP and iSER changes too?
>>>>>
>>>>> No, just want to keep basic verbs support at least. NFS already dropped,
>>>>> similarly we are ok with dropping it from SRP/iSER as a next step.
>>>>
>>>> So you see a major user in RDS for qib?
>>>
>>> Didn't we agree to drop it from RDS too?
>>>
>>
>> Just basic verbs application support is enough for qib I think. I don't see
>> any major use of RDS.
> 
> Well, once the in-kernel users of an API are gone that API will be
> purged. This is standard kernel policy.
> 
> So you can't NAK this series on the grounds you want to keep an API
> without users, presumably for out of tree modules...
> 

Maybe I need to look at this again. I thought it would kill off user 
access as well. We don't need any kernel ULPs.

-Denny

