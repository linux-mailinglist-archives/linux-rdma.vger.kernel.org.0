Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADC535551A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbhDFN31 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Apr 2021 09:29:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3331 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhDFN31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 09:29:27 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FF7ZM5dm6z14D5B;
        Tue,  6 Apr 2021 21:25:47 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 6 Apr 2021 21:29:15 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 21:29:15 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 6 Apr 2021 21:29:15 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Flush workqueue before destroy it
Thread-Topic: [PATCH for-next] RDMA/core: Flush workqueue before destroy it
Thread-Index: AQHXKsAgMoDr1XYHNUiyGdPyEI1T1Q==
Date:   Tue, 6 Apr 2021 13:29:15 +0000
Message-ID: <0efa41d4d17d42d3b43df895749376ff@huawei.com>
References: <1617698091-47439-1-git-send-email-liweihang@huawei.com>
 <YGwfqiCRi4dq2F8r@unreal>
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

On 2021/4/6 16:45, Leon Romanovsky wrote:
> On Tue, Apr 06, 2021 at 04:34:51PM +0800, Weihang Li wrote:
>> From: Yixian Liu <liuyixian@huawei.com>
>>
>> It is safer to flush the workqueue before destroying it.
> Sorry, safer for what?
> 
> destroy_workqueue() flushes workqueue internally. There is no need to do
> it twice.
> 
> Thanks
> 

My bad, thank you for reminding :)

Weihang
