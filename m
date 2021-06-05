Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9953939C567
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Jun 2021 05:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFEDNo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 4 Jun 2021 23:13:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4478 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEDNn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 23:13:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fxl371FdszZcB3;
        Sat,  5 Jun 2021 11:09:07 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 11:11:53 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 11:11:53 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Sat, 5 Jun 2021 11:11:53 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 0/6] libhns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH rdma-core 0/6] libhns: Add support for Dynamic Context
 Attachment
Thread-Index: AQHXRaAnooD/sz04oUmdzKgMSSsQRA==
Date:   Sat, 5 Jun 2021 03:11:53 +0000
Message-ID: <4363ab5d78c84e8f9a9de3299a0262e8@huawei.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
 <20210604143958.GA404564@nvidia.com>
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

On 2021/6/4 22:40, Jason Gunthorpe wrote:
> On Mon, May 10, 2021 at 09:12:58PM +0800, Weihang Li wrote:
>> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
>> enables DCA feature, the WQE's buffer will not be allocated when creating
>> but when the users start to post WRs. This will reduce the memory
>> consumption when there are too many QPs are inactive.
>>
>> For more detailed information, please refer to the man pages provided by
>> the last patch of this series.
>>
>> This series is associated with the kernel one "RDMA/hns: Add support for
>> Dynamic Context Attachment", and two RFC versions of this series has been
>> sent before.
>>
>> No changes since RFC v2.
>> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1614847759-33139-1-git-send-email-liweihang@huawei.com/
>>
>> Changes since RFC v1:
>> * Add direct verbs to set the parameters about size that used to
>>   configuring DCA. 
>> * Add man pages to explain what is DCA, how does it works and how to use
>>   it.
>> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/
>>
>> Weihang Li (1):
>>   Update kernel headers
>>
>> Xi Wang (5):
>>   libhns: Introduce DCA for RC QP
>>   libhns: Add support for shrinking DCA memory pool
>>   libhns: Add support for attaching QP's WQE buffer
>>   libhns: Add direct verbs support to config DCA
>>   libhns: Add man pages to introduce DCA feature
> 
> This should be sent on GitHub
> 
> Jason
> 

The implementation needs some modification, so I haven't sent it to github yet.
The next version will be sent to github at the same time, thank you.

Weihang
