Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30835537E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbhDFMTZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Apr 2021 08:19:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3070 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbhDFMTN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:19:13 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FF61M5lTvzWTbK;
        Tue,  6 Apr 2021 20:15:35 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 6 Apr 2021 20:19:03 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 20:19:03 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 6 Apr 2021 20:19:03 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/6] RDMA/core: Remove redundant spaces
Thread-Topic: [PATCH for-next 4/6] RDMA/core: Remove redundant spaces
Thread-Index: AQJmWj7fykGLfs8fpqJfS4UF45jw7w==
Date:   Tue, 6 Apr 2021 12:19:03 +0000
Message-ID: <6a873083a6d24735b907e9069d14f875@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
 <1617697184-48683-5-git-send-email-liweihang@huawei.com>
 <YGwfP0qEDMybR4iZ@unreal>
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

On 2021/4/6 16:43, Leon Romanovsky wrote:
> On Tue, Apr 06, 2021 at 04:19:42PM +0800, Weihang Li wrote:
>> From: Wenpeng Liang <liangwenpeng@huawei.com>
>>
>> Space is not required between function name and '(', after '(', before ')',
>> before ',' and between '*' and symbol name of a definition.
>>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/cache.c       | 10 +++---
>>  drivers/infiniband/core/cm.c          | 31 ++++++++---------
>>  drivers/infiniband/core/cma.c         | 10 +++---
>>  drivers/infiniband/core/device.c      | 64 +++++++++++++++++------------------
>>  drivers/infiniband/core/mad.c         | 20 +++++------
>>  drivers/infiniband/core/mad_rmpp.c    | 10 +++---
>>  drivers/infiniband/core/nldev.c       |  2 +-
>>  drivers/infiniband/core/security.c    | 12 +++----
>>  drivers/infiniband/core/sysfs.c       |  8 ++---
>>  drivers/infiniband/core/user_mad.c    |  6 ++--
>>  drivers/infiniband/core/uverbs_cmd.c  | 20 +++++------
>>  drivers/infiniband/core/uverbs_main.c |  3 +-
>>  drivers/infiniband/core/uverbs_uapi.c | 16 ++++-----
>>  13 files changed, 105 insertions(+), 107 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index d779590..0b8c410 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -886,7 +886,7 @@ static void gid_table_release_one(struct ib_device *ib_dev)
>>  {
>>  	u32 p;
>>  
>> -	rdma_for_each_port (ib_dev, p) {
>> +	rdma_for_each_port(ib_dev, p) {
> 
> This space is an outcome of clang formatter. I would say that we are
> fine that submitted patches will be with and without space.
> 
> Thanks
> 

I see, I will drop unnecessary changes about xx_for_each() and maybe something else.

Thank you
Weihang
