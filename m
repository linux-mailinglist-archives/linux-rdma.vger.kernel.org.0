Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F391E19C0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 05:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgEZDNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 25 May 2020 23:13:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388460AbgEZDNV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 23:13:21 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D2105C72F4864F35E07A;
        Tue, 26 May 2020 11:13:19 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.141]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0487.000; Tue, 26 May 2020 11:13:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanups for 5.8
Thread-Topic: [PATCH for-next 0/9] RDMA/hns: Cleanups for 5.8
Thread-Index: AQHWLq4YCR55PTTkwEWdJhoyOPciBg==
Date:   Tue, 26 May 2020 03:13:12 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02389A70@DGGEML522-MBX.china.huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <20200525171116.GA17025@ziepe.ca> <20200525173604.GG10591@unreal>
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

On 2020/5/26 1:36, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 02:11:16PM -0300, Jason Gunthorpe wrote:
>> On Wed, May 20, 2020 at 09:53:10PM +0800, Weihang Li wrote:
>>> These are some cleanups, include removing dead code, modifying
>>> varibles/fields types, and optimizing some functions.
>>>
>>> Lang Cheng (3):
>>>   RDMA/hns: Let software PI/CI grow naturally
>>>   RDMA/hns: Add CQ flag instead of independent enable flag
>>>   RDMA/hns: Optimize post and poll process
>>>
>>> Weihang Li (2):
>>>   RDMA/hns: Change all page_shift to unsigned
>>>   RDMA/hns: Change variables representing quantity to unsigned
>>>
>>> Xi Wang (3):
>>>   RDMA/hns: Rename QP buffer related function
>>>   RDMA/hns: Refactor the QP context filling process related to WQE
>>>     buffer configure
>>>   RDMA/hns: Optimize the usage of MTR
>>>
>>> Yangyang Li (1):
>>>   RDMA/hns: Remove unused code about assert
>>
>> I'm going to take these anyhow, the field macros could be improved
>> someday if someone wanted. Applied to for-next
>>
>> I have to say the patches coming lately from hns have been following
>> the kernel style and protocols much better. I'm also having a much
>> easier time understanding the commit message and what the patch is
>> trying to do. Keep it up!
> 
> +1, I have same feeling.
> 
> Thanks
> 
>>
>> Thanks,
>> Jason
> 

Thanks for the encouragement and all your helpful suggestions.
We will do our best to make it better :)

Weihang
