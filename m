Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379E250E2A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgHYBXr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 24 Aug 2020 21:23:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:39386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725648AbgHYBXq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 21:23:46 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id E1DE8E4C322771B15D0F;
        Tue, 25 Aug 2020 09:23:40 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 25 Aug 2020 09:23:40 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 25 Aug 2020 09:23:40 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Tue, 25 Aug 2020 09:23:40 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add a check for current state before
 modifying QP
Thread-Topic: [PATCH for-next] RDMA/hns: Add a check for current state before
 modifying QP
Thread-Index: AQHWdI34BIjTijBJPUOWiFY66sDh1g==
Date:   Tue, 25 Aug 2020 01:23:40 +0000
Message-ID: <137aa6a7349e475089ac32b060ace009@huawei.com>
References: <1597665532-48406-1-git-send-email-liweihang@huawei.com>
 <20200824171646.GA3214426@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/8/25 1:17, Jason Gunthorpe wrote:
> On Mon, Aug 17, 2020 at 07:58:52PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> It should be considered as an illegal operation if the ULP attempts to
>> modify a QP from another state to the current hardware state. Otherwise,
>> the ULP can modify some fields of QPC at any time. For example, for a QP in
>> state of RTS, modify it from RTR to RTS can change the PSN, which is always
>> not as expected.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_qp.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> This looks like it needs a fixes line?
> 
> Jason
> 

Thanks for your reminder, will add a fixes tag and send a new version.

Weihang
