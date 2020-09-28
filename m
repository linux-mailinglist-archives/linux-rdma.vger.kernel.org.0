Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A2527AE7F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1M6w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 28 Sep 2020 08:58:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgI1M6v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Sep 2020 08:58:51 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id CE8DF476691B312CF883;
        Mon, 28 Sep 2020 20:58:49 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 28 Sep 2020 20:58:48 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 28 Sep 2020 20:58:48 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Mon, 28 Sep 2020 20:58:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Remove unused variables and
 definitions
Thread-Topic: [PATCH for-next] RDMA/hns: Remove unused variables and
 definitions
Thread-Index: AQHWlLQdbOCmP0FTx0GazLYtS50Zjw==
Date:   Mon, 28 Sep 2020 12:58:48 +0000
Message-ID: <c92a2301818e4a178357c6c45168b646@huawei.com>
References: <1601200341-7924-1-git-send-email-liweihang@huawei.com>
 <20200928115547.GL9916@ziepe.ca>
 <191e848eff4840ef80d9fbb0eab064a8@huawei.com>
 <20200928125042.GO9916@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/28 20:50, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2020 at 12:27:56PM +0000, liweihang wrote:
>> On 2020/9/28 19:55, Jason Gunthorpe wrote:
>>> On Sun, Sep 27, 2020 at 05:52:21PM +0800, Weihang Li wrote:
>>>> From: Lang Cheng <chenglang@huawei.com>
>>>>
>>>> Some code was removed but the variables were still there, and some
>>>> parameters have been changed to be queried from firmware. So the
>>>> definitions of them are no longer needed.
>>>>
>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h | 8 --------
>>>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 2 --
>>>>  2 files changed, 10 deletions(-)
>>>
>>> Should have a fixes for the patch that removed the code
>>>
>>> Jason
>>>
>>
>> Hi Jason,
>>
>> Thanks for the comment. But I'm confused about when we should add
>> fixes tag.
>>
>> For example, The only purpose of this patch is to remove redundant
>> macro definitions, the macros to be removed belong to 4 different
>> former patches, so we have to add 4 lines of fixes. It seems difficult
>> to merge this one back to previous versions of kernel.
> 
> You can just list all four patches
> 
> Jason
> 

I see, thank you.

Weihang
