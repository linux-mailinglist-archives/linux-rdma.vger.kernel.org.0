Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF1186C0A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgCPN3f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 16 Mar 2020 09:29:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3421 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730970AbgCPN3f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 09:29:35 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 1B7E6F814B525BE3FF0A;
        Mon, 16 Mar 2020 21:29:24 +0800 (CST)
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.252]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Mon, 16 Mar 2020 21:29:16 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrew Boyer <aboyer@pensando.io>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Topic: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Index: AQHV+ENGNL7jbDp/V0iDqULaY56J2A==
Date:   Mon, 16 Mar 2020 13:29:16 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022A14BD@DGGEML502-MBS.china.huawei.com>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal> <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
 <20200316121231.GB20941@ziepe.ca> <20200316130425.GA42537@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/16 21:04, Leon Romanovsky wrote:
> On Mon, Mar 16, 2020 at 09:12:31AM -0300, Jason Gunthorpe wrote:
>> On Sat, Mar 14, 2020 at 03:44:49AM +0000, liweihang wrote:
>>> On 2020/3/13 20:18, Jason Gunthorpe wrote:
>>>> On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
>>>>> On 2020/3/13 1:27, Jason Gunthorpe wrote:
>>>>>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
>>>>>>>    What would you say to a per-process env variable to disable locking in
>>>>>>>    a userspace provider?
>>>>>>
>>>>>> That is also a no. verbs now has 'thread domain' who's purpose is to
>>>>>> allow data plane locks to be skipped.
>>>>>>
>>>>>> Generally new env vars in verbs are going to face opposition from
>>>>>> me.
>>>>>>
>>>>>> Jason
>>>>>
>>>>> Thanks for your comments. Do you have some suggestions on how to
>>>>> achieve lockless flows in kernel? Are there any similar interfaces
>>>>> in kernel like the thread domain in userspace?
>>>>
>>>> It has never come up before
>>>>
>>>> Jason
>>>>
>>>
>>> Thank you, Jason. Could you please explain why it's not encouraged to
>>> use module parameters in kernel?
>>
>> Behavior that effects the operation of a ULP should never be
>> configured globally. The ULP must self-select this behavior
>> pragmatically, only when it is safe.
> 
> Indeed, very good point.
> 
> I just want to add that for ULP it is very rare that module
> parameters are the right choice either, because usually those parameters
> change ULP behavior be suitable for specific workload.
> 
> Thanks
> 
>>
>> Jason
> 

I see, thanks again for your detailed explanation, it's very helpful for us.

Weihang
