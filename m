Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAC270A1E
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 04:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgISCoQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Sep 2020 22:44:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgISCoQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 22:44:16 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 22:44:16 EDT
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 1648FD54E2FB4E7C32D9;
        Sat, 19 Sep 2020 10:44:15 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 10:44:14 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 10:44:14 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 10:44:14 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 3/9] RDMA/hns: Add interception for resizing
 SRQs
Thread-Topic: [PATCH v2 for-next 3/9] RDMA/hns: Add interception for resizing
 SRQs
Thread-Index: AQHWhod1LVcLhlG62U6x/yzB7/vStQ==
Date:   Sat, 19 Sep 2020 02:44:14 +0000
Message-ID: <3fd98486f7c440bb92b67e15e65ddd07@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-4-git-send-email-liweihang@huawei.com>
 <20200918140609.GA305039@nvidia.com>
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

On 2020/9/18 22:06, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 04:57:28PM +0800, Weihang Li wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> HIP08 doesn't support modifying the maximum number of outstanding WR in an
>> SRQ. However, the driver does not return a failure message, and users may
>> mistakenly think that the resizing is executed successfully. So the driver
>> needs to intercept this operation.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Missing fixes line?
> 
> Jason
> 

I see. I thought the fixes tag was not required when we add a check like that
in this patch. I will add one, thank you.

Weihang
