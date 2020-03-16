Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771F5186957
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 11:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgCPKql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 16 Mar 2020 06:46:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3477 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730478AbgCPKql (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 06:46:41 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id E21F030DF97121E05AED;
        Mon, 16 Mar 2020 18:46:37 +0800 (CST)
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.252]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0487.000; Mon, 16 Mar 2020 18:46:25 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Andrew Boyer <aboyer@pensando.io>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Topic: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Index: AQHV+ENGNL7jbDp/V0iDqULaY56J2A==
Date:   Mon, 16 Mar 2020 10:46:25 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0229ED02@DGGEML502-MBS.china.huawei.com>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal> <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
 <20200314180724.GH67638@unreal>
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

On 2020/3/15 2:07, Leon Romanovsky wrote:
> On Sat, Mar 14, 2020 at 03:44:49AM +0000, liweihang wrote:
>> On 2020/3/13 20:18, Jason Gunthorpe wrote:
>>> On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
>>>> On 2020/3/13 1:27, Jason Gunthorpe wrote:
>>>>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
>>>>>>    What would you say to a per-process env variable to disable locking in
>>>>>>    a userspace provider?
>>>>>
>>>>> That is also a no. verbs now has 'thread domain' who's purpose is to
>>>>> allow data plane locks to be skipped.
>>>>>
>>>>> Generally new env vars in verbs are going to face opposition from
>>>>> me.
>>>>>
>>>>> Jason
>>>>
>>>> Thanks for your comments. Do you have some suggestions on how to
>>>> achieve lockless flows in kernel? Are there any similar interfaces
>>>> in kernel like the thread domain in userspace?
>>>
>>> It has never come up before
>>>
>>> Jason
>>>
>>
>> Thank you, Jason. Could you please explain why it's not encouraged to
>> use module parameters in kernel?
>>
>> What about the reason why we shouldn't add new environment variables
>> in userspace? Do they have the same reason?
> 
> I don't know why my previous answer didn't appear in the ML, hope that
> this will arrive.
> 
> The technical reasons to avoid environmental variables and kernel module
> parameters are not the same, but very similar.
> 
> Environmental variables are not thread safe (in POSIX), inherited with
> fork() and behaves differently in scripts. All this together makes them
> as very bad user visible configuration interface.
> 
> Kernel module parameters are not welcomed due to their global nature,
> difference between various drivers which makes hard for users to change
> HW/scripts, almost impossible to deprecate e.t.c.
> 
> Thanks
> 

I have received both of your responses :)
Thanks for your detailed and clear explanation.

Weihang
