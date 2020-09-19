Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BC270BD6
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgISI2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 19 Sep 2020 04:28:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISI2d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 04:28:33 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id D808BD0E9A3866F735B0;
        Sat, 19 Sep 2020 16:28:30 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 16:28:30 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 16:28:30 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 16:28:30 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 2/9] RDMA/hns: Add type check in get/set hw
 field
Thread-Topic: [PATCH v2 for-next 2/9] RDMA/hns: Add type check in get/set hw
 field
Thread-Index: AQHWhod1wXCo/VgBc0ajLEn27b75iQ==
Date:   Sat, 19 Sep 2020 08:28:30 +0000
Message-ID: <973281b807ef472b80b581bf0557ff7e@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-3-git-send-email-liweihang@huawei.com>
 <20200918134935.GA304147@nvidia.com>
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

On 2020/9/18 21:49, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 04:57:27PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> roce_get_field() and roce_set_field() are only used to set variables in
>> type of __le32, add checks for type to avoid inappropriate assignments.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_common.h | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> I'm skeptical this actually works. __le32 and u32 are the same thing
> unless using sparse, and sparse will already catch mis-uses as-is.
> 
> Jason
> 

Umm...You are right. I will drop this one.

Thank you
Weihang
