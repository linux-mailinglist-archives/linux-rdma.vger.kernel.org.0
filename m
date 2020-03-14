Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C16185465
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2020 04:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCNDpN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 13 Mar 2020 23:45:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbgCNDpH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 23:45:07 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7356D86548049B061DED;
        Sat, 14 Mar 2020 11:44:59 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 14 Mar 2020 11:44:58 +0800
Received: from DGGEML502-MBS.china.huawei.com ([169.254.3.244]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0439.000;
 Sat, 14 Mar 2020 11:44:50 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrew Boyer <aboyer@pensando.io>,
        Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Topic: [PATCH for-next] RDMA/hns: Add interface to support lock free
Thread-Index: AQHV+ENGNL7jbDp/V0iDqULaY56J2A==
Date:   Sat, 14 Mar 2020 03:44:49 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal> <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
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

On 2020/3/13 20:18, Jason Gunthorpe wrote:
> On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
>> On 2020/3/13 1:27, Jason Gunthorpe wrote:
>>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
>>>>    What would you say to a per-process env variable to disable locking in
>>>>    a userspace provider?
>>>
>>> That is also a no. verbs now has 'thread domain' who's purpose is to
>>> allow data plane locks to be skipped.
>>>
>>> Generally new env vars in verbs are going to face opposition from
>>> me.
>>>
>>> Jason
>>
>> Thanks for your comments. Do you have some suggestions on how to
>> achieve lockless flows in kernel? Are there any similar interfaces
>> in kernel like the thread domain in userspace?
> 
> It has never come up before
> 
> Jason
> 

Thank you, Jason. Could you please explain why it's not encouraged to
use module parameters in kernel?

What about the reason why we shouldn't add new environment variables
in userspace? Do they have the same reason?

Weihang
