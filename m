Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0928CF5CF4
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2019 03:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKICSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 21:18:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfKICSb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 Nov 2019 21:18:31 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9E4F293805FCD8D51633;
        Sat,  9 Nov 2019 10:18:29 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 10:18:19 +0800
Subject: Re: [PATCH v2 for-next 0/9] RDMA/hns: Cleanups for hip08
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
 <20191108204512.GA28649@ziepe.ca>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <fb0ab6c4-c0db-b331-fe27-bfb191c1428e@hisilicon.com>
Date:   Sat, 9 Nov 2019 10:18:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108204512.GA28649@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/9 4:45, Jason Gunthorpe wrote:
> On Tue, Nov 05, 2019 at 07:07:53PM +0800, Weihang Li wrote:
>> These series just make cleanups without changing code logic.
>>
>> [patch 1/9 ~ 3/9] remove unused variables and structures.
>> [patch 4/9 ~ 5/9] modify field and function names.
>> [patch 6/9 ~ 7/9] remove dead codes to simplify functions.
>> [patch 8/9] replaces non-standard return value with linux error codes.
>> [patch 9/9] does some fixes on printings.
>>
>> Changelog
>> v1->v2: Remove "{topost}" in titles.
>>
>> Lang Cheng (3):
>>   RDMA/hns: Remove unnecessary structure hns_roce_sqp
>>   RDMA/hns: Simplify doorbell initialization code
>>   RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code
>>
>> Wenpeng Liang (1):
>>   RDMA/hns: Modify appropriate printings
>>
>> Yixian Liu (4):
>>   RDMA/hns: Delete unnecessary variable max_post
>>   RDMA/hns: Delete unnecessary uar from hns_roce_cq
>>   RDMA/hns: Modify fields of struct hns_roce_srq
>>   RDMA/hns: Fix non-standard error codes
>>
>> Yixing Liu (1):
>>   RDMA/hns: Replace not intuitive function/macro names
> 
> Something should probably be done about that custom bitmap stuff Leon
> noted, but that isn't related to these patches, so applied to for-next
> 

Thank you, Jason. We will continue to pay attention to this bitmap stuff
and discuss further with Leon.

Weihang

> Thanks,
> Jason
> 
> 

