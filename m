Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3032A12F472
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 06:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgACF5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 00:57:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgACF5h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Jan 2020 00:57:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9DF84F6A078BBD502FF;
        Fri,  3 Jan 2020 13:57:31 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 13:57:23 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Weihang Li <liweihang@hisilicon.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
 <20200102210351.GA398@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <2b8eb4ac-ef0c-7c7f-270f-8d3768f7c2a7@huawei.com>
Date:   Fri, 3 Jan 2020 13:57:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200102210351.GA398@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/3 5:03, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2019 at 09:39:26AM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> Support extended atomic operations including cmp & swap and fetch & add
>> of 8 bytes, 16 bytes, 32 bytes, 64 bytes on hip08.
>>
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 100 ++++++++++++++++++++++++-----
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   8 +++
>>  2 files changed, 93 insertions(+), 15 deletions(-)
> 
> How is this related to the userspace patch:
> 
> https://github.com/linux-rdma/rdma-core/pull/640
> 
> ?
> 
> Under what conditions would the kernel part be needed?
> 
> Confused because we have no kernel users of extended atomic.
> 
> Jason
> 
> 

Hi Jason,

This patch has no relationship with the userspace one you pointed out.
But I have pushed a userspace patch that support extended atomic on hip08,
maybe you were asking about the following one:

https://github.com/linux-rdma/rdma-core/pull/638

The kernel part is not needed by the userspace part, they are independent
of each other.

We made this patch because we noticed that some other providers has also
support this feature in kernel, maybe there will be some kernel users in
future. I would be grateful if you could give me more suggestions.

Thank you
Weihang


