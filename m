Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17E270A4E
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgISDEM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Sep 2020 23:04:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISDEM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 23:04:12 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id BB5FF26108C76F598DCA;
        Sat, 19 Sep 2020 11:04:10 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 11:04:10 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 11:04:10 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 11:04:10 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 6/9] RDMA/hns: Solve the overflow of the
 calc_pg_sz()
Thread-Topic: [PATCH v2 for-next 6/9] RDMA/hns: Solve the overflow of the
 calc_pg_sz()
Thread-Index: AQHWhod59r88oWoIUkGOsmdeFhKcTA==
Date:   Sat, 19 Sep 2020 03:04:10 +0000
Message-ID: <06b3caf217744f33a47655dec697400a@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-7-git-send-email-liweihang@huawei.com>
 <20200918141054.GB305257@nvidia.com>
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

On 2020/9/18 22:11, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 04:57:31PM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> calc_pg_sz() may gets a data calculation overflow if the PAGE_SIZE is 64 KB
>> and hop_num is 2. It is because that all variables involved in calculation
>> are defined in type of int. So change the type of bt_chunk_size,
>> buf_chunk_size and obj_per_chunk_default to u64.
>>
>> Fixes: ba6bb7e97421 ("RDMA/hns: Add interfaces to get pf capabilities from firmware")
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 01aabb7..af2dea1 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1804,9 +1804,9 @@ static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
>>  		       int *buf_page_size, int *bt_page_size, u32 hem_type)
>>  {
>>  	u64 obj_per_chunk;
>> -	int bt_chunk_size = 1 << PAGE_SHIFT;
>> -	int buf_chunk_size = 1 << PAGE_SHIFT;
>> -	int obj_per_chunk_default = buf_chunk_size / obj_size;
>> +	u64 bt_chunk_size = 1 << PAGE_SHIFT;
>> +	u64 buf_chunk_size = 1 << PAGE_SHIFT;
> 
> This is PAGE_SIZE
> 
> Jason
> 

Thanks for your reminder, I fill fix it.

Weihang
