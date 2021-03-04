Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE432CA09
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 02:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhCDBbT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 3 Mar 2021 20:31:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3036 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhCDBbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Mar 2021 20:31:18 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DrYDX3PMnzRLWw;
        Thu,  4 Mar 2021 09:29:00 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 4 Mar 2021 09:30:33 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 4 Mar 2021 09:30:32 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Thu, 4 Mar 2021 09:30:33 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next] RDMA/hns: Add support for XRC on HIP09
Thread-Topic: [PATCH for-next] RDMA/hns: Add support for XRC on HIP09
Thread-Index: AQHXD5TGiODtbEVve064q5zq0+33Lw==
Date:   Thu, 4 Mar 2021 01:30:33 +0000
Message-ID: <52e3f774ee8f4a6e973aad39f2fe0f41@huawei.com>
References: <1614689298-13601-1-git-send-email-liweihang@huawei.com>
 <YD+D4zjc1GzHL0bb@unreal>
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

On 2021/3/3 20:41, Leon Romanovsky wrote:
> On Tue, Mar 02, 2021 at 08:48:18PM +0800, Weihang Li wrote:
>> From: Wenpeng Liang <liangwenpeng@huawei.com>
>>
>> The HIP09 supports XRC transport service, it greatly saves the number of
>> QPs required to connect all processes in a large cluster.
>>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  25 +++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 147 +++++++++++++++++++---------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  32 +++++-
>>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  51 ++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  63 ++++++++----
>>  drivers/infiniband/hw/hns/hns_roce_srq.c    |   3 +
>>  include/uapi/rdma/hns-abi.h                 |   2 +
>>  9 files changed, 258 insertions(+), 70 deletions(-)
> 
> <...>
> 
>> +	u32			xrcdn;
> 
> <...>
> 
>> +	unsigned long		xrcdn;
> 
> Can you use the same type (u32) in all structs, please?
> 
> Thanks
> 

Thank you, I will fix it.

Weihang
