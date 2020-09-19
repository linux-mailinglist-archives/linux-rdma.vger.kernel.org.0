Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB37270A20
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 04:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgISCpP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Sep 2020 22:45:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3525 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgISCpO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 22:45:14 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id DAB6E7BB00F397D5F64B;
        Sat, 19 Sep 2020 10:45:13 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 10:45:13 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 10:45:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 10:45:13 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 5/9] RDMA/hns: Add check for the validity of
 sl configuration
Thread-Topic: [PATCH v2 for-next 5/9] RDMA/hns: Add check for the validity of
 sl configuration
Thread-Index: AQHWhod4TujFtlAsHUuBXejsJlnqYQ==
Date:   Sat, 19 Sep 2020 02:45:13 +0000
Message-ID: <a668d188b42d47a0a57c84b94ca1aba0@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-6-git-send-email-liweihang@huawei.com>
 <20200918141126.GC305257@nvidia.com>
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
> On Wed, Sep 09, 2020 at 04:57:30PM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> According to the RoCE v1 specification, the sl (service level) 0-7 are
>> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
>> driver should verify whether the the value of sl is larger than 7, if so,
>> an exception should be returned.
>>
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++++--
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> Missing fixes line
> 
> Jason
> 

I will add one. Thank you :)

Weihang
