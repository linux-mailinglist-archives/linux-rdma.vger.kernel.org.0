Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F71E52C3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgE1BPU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 27 May 2020 21:15:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgE1BPU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 21:15:20 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6D20D4090A0C77B59FB0;
        Thu, 28 May 2020 09:15:16 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.141]) by
 DGGEML404-HUB.china.huawei.com ([fe80::b177:a243:7a69:5ab8%31]) with mapi id
 14.03.0487.000; Thu, 28 May 2020 09:15:07 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Thread-Topic: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Thread-Index: AQHWLq4Z5aJwt2CsLEKPOa4qXyCpkg==
Date:   Thu, 28 May 2020 01:15:06 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0238DD0A@DGGEML522-MBX.china.huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <1589982799-28728-3-git-send-email-liweihang@huawei.com>
 <20200525170647.GA16200@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02387A2A@DGGEML522-MBX.china.huawei.com>
 <20200526120816.GL744@ziepe.ca>
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

On 2020/5/26 20:08, Jason Gunthorpe wrote:
> On Tue, May 26, 2020 at 02:57:39AM +0000, liweihang wrote:
>>> Also, if someone wants a project, all this endless stuff should be
>>> using genmask and field_prep instead of this home grown stuff.
>>>
>> I took a look at this macro, FILED_PREP() can indeed simplify lots of
>> similar codes in the hns driver. I will take a try and maybe prepare a
>> patch/series to use it in v5.9.
> 
> If you look in the git history you can find some Coccinelle spatch
> stuff that makes work like this not too hard
> 
> eg 91b60a7128d96244794beb9b324eb39273872da2 did something similar for
> the IBA CM MADs
> 
> Jason
> 

I see, thanks for the commit-id.

Weihang
