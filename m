Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7E85E3A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfHHJ1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 05:27:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731788AbfHHJ1a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 05:27:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B901F7F8BF89E20C12DF;
        Thu,  8 Aug 2019 17:27:27 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 17:27:19 +0800
Subject: Re: [PATCH V3 for-next 00/13] Updates for 5.3-rc2
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1564821919-100676-1-git-send-email-oulijun@huawei.com>
 <c4af76063f6cd72b8dccf21d4256273a69fad309.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <a9c1bcb9-42f9-9419-0243-7d212b67638a@huawei.com>
Date:   Thu, 8 Aug 2019 17:27:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c4af76063f6cd72b8dccf21d4256273a69fad309.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/8/8 3:38, Doug Ledford 写道:
> On Sat, 2019-08-03 at 16:45 +0800, Lijun Ou wrote:
>> Here are some updates for hns driver based 5.3-rc2, mainly
>> include some codes optimization and comments style modification.
>>
>> Change from V2:
>> 1. Remove the unncessary memset opertion for the tenth patch
>>
>> Change from V1:
>> 1. Fix the checkpatch warning
>> 2. Use ibdev print interface instead of dev print interface in
>>    this patchset.
> I need you to separate the ibdev changes from other changes.  I have
> other comments on the patches that I'll make on the individual patches,
> but just in general, do one single patch to switch to using ibdev prints
> and have it cover the entire driver.  You can make it the first or last
> patch, I don't care.  But don't mix anything else in with the ibdev
> transition patch.  You shouldn't be mixing things like fixing an
> incorrect print with a switch to ibdev print in the same patch because
> it makes it very difficult on people that might be backporting these
> patches to take the fix if they haven't also taken the ibdev print
> patchset.
Thank your advice. I also started thinking about this problem before send V3.
I want to use a following patch separately to instead the dev print.  But the overall
replacement in the drvier is more troublesome and need to analysis. Because if
replace all dev print interfaces, may cause a null print infomation.  the ibdev is NULL before
the roce device registered sucessfully.

So my solution is to modify the dev print in the current patchset and later send a modified patch
for replacing all dev interface after the overall analysis is clear.
>> Lang Cheng (6):
>>   RDMA/hns: Clean up unnecessary initial assignment
>>   RDMA/hns: Update some comments style
>>   RDMA/hns: Handling the error return value of hem function
>>   RDMA/hns: Split bool statement and assign statement
>>   RDMA/hns: Refactor irq request code
>>   RDMA/hns: Remove unnecessary kzalloc
>>
>> Lijun Ou (2):
>>   RDMA/hns: Encapsulate some lines for setting sq size in user mode
>>   RDMA/hns: Optimize hns_roce_modify_qp function
>>
>> Weihang Li (2):
>>   RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
>>   RDMA/hns: Disable alw_lcl_lpbk of SSU
>>
>> Yangyang Li (1):
>>   RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
>>
>> Yixian Liu (2):
>>   RDMA/hns: Update the prompt message for creating and destroy qp
>>   RDMA/hns: Remove unnessary init for cmq reg
>>
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  65 +++++----
>>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 +-
>>  drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 211 ++++++++++++++-----
>> ---------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 -
>>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   1 -
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 178 ++++++++++++++-----
>> ----
>>  7 files changed, 260 insertions(+), 218 deletions(-)
>>


