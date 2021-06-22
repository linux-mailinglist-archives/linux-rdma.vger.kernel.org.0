Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C43AFE26
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 09:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFVHpu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 22 Jun 2021 03:45:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7501 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFVHpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 03:45:50 -0400
Received: from dggeme707-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G8JGT2ylszZl9x;
        Tue, 22 Jun 2021 15:40:33 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 22 Jun 2021 15:43:33 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 22 Jun 2021 15:43:33 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        zhangjiaran <zhangjiaran@huawei.com>,
        chenglang <chenglang@huawei.com>
Subject: Re: [PATCH RESEND for-next] RDMA/hns: Solve the problem that dma_pool
 is used during the reset
Thread-Topic: [PATCH RESEND for-next] RDMA/hns: Solve the problem that
 dma_pool is used during the reset
Thread-Index: AQHXXqU6SHyhWNAGeECZzIdBLVcbbw==
Date:   Tue, 22 Jun 2021 07:43:33 +0000
Message-ID: <6aec1e625e3845cb85e2c987eb2f1f12@huawei.com>
References: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
 <20210621232459.GA2356494@nvidia.com>
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

On 2021/6/22 7:25, Jason Gunthorpe wrote:
> On Fri, Jun 11, 2021 at 05:35:56PM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> During the reset, the driver calls dma_pool_destroy() to release the
>> dma_pool resources. If the dma_pool_free interface is called during the
>> modify_qp operation, an exception will occur. The completion
>> synchronization mechanism is used to ensure that dma_pool_destroy() is
>> executed after the dma_pool_free operation is complete.
> 
> This should probably be a simple rwsem instead of faking one up with a
> refcount and completion.
> 
> The only time you need this pattern is if the code is returning to
> userspace, which didn't look like was happening here.
> 
> Jason
> 

Thank you, we'll think about how to use rwsem to fix this.

Weihang
