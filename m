Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66934B390
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhC0BlD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 26 Mar 2021 21:41:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3388 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhC0Bkt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 21:40:49 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F6hLZ15W8z5ggC;
        Sat, 27 Mar 2021 09:38:14 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 27 Mar 2021 09:40:47 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 27 Mar 2021 09:40:47 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Sat, 27 Mar 2021 09:40:47 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 0/5] RDMA/hns: Refactor and reorganization
Thread-Topic: [PATCH for-next 0/5] RDMA/hns: Refactor and reorganization
Thread-Index: AQHXGw274uV4421JFEqzSdafmIcBNA==
Date:   Sat, 27 Mar 2021 01:40:47 +0000
Message-ID: <d95ba34ad6ec40cdb5188b13780bf54c@huawei.com>
References: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
 <20210326144726.GA845659@nvidia.com>
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

On 2021/3/26 22:47, Jason Gunthorpe wrote:
> On Wed, Mar 17, 2021 at 05:09:38PM +0800, Weihang Li wrote:
>> Refactor the process of polling CQ and several control paths in the hns
>> driver.
>>
>> Weihang Li (1):
>>   RDMA/hns: Refactor hns_roce_v2_poll_one()
>>
>> Xi Wang (3):
>>   RDMA/hns: Refactor reset state checking flow
>>   RDMA/hns: Reorganize process of setting HEM
>>   RDMA/hns: Simplify command fields for HEM base address configuration
>>
>> Yixing Liu (1):
>>   RDMA/hns: Reorganize hns_roce_create_cq()
> 
> This series doesn't apply, please resend it
> 
> Jason
> 

Sorry for that, I will do a rebase.

Thank you
Weihang
