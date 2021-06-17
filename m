Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42E3AAC6D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 08:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQGfg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 17 Jun 2021 02:35:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7341 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhFQGff (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 02:35:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5Bwl0LK8z6y72;
        Thu, 17 Jun 2021 14:29:27 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:33:27 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:33:26 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 17 Jun 2021 14:33:26 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, chenglang <chenglang@huawei.com>
Subject: Re: [PATCH RESEND v2 for-next 1/7] RDMA/hns: Fix potential compile
 warnings on hr_reg_write()
Thread-Topic: [PATCH RESEND v2 for-next 1/7] RDMA/hns: Fix potential compile
 warnings on hr_reg_write()
Thread-Index: AQHXV41p2Y+MFv52lk6tzTqvEuCI0g==
Date:   Thu, 17 Jun 2021 06:33:26 +0000
Message-ID: <59ca0489be9a44a082bd1bed130ea3ff@huawei.com>
References: <1622624265-44796-1-git-send-email-liweihang@huawei.com>
 <1622624265-44796-2-git-send-email-liweihang@huawei.com>
 <20210616194012.GA1844581@nvidia.com>
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

On 2021/6/17 3:40, Jason Gunthorpe wrote:
> On Wed, Jun 02, 2021 at 04:57:39PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> GCC may reports an running time assert error when a value calculated from
>> ib_mtu_enum_to_int() is using as 'val' in FIELD_PREDP:
>>
>> include/linux/compiler_types.h:328:38: error: call to
>> '__compiletime_assert_1524' declared with attribute error: FIELD_PREP:
>> value too large for the field
> 
> Huh? This warning looks reliable to me, you should not suppress it
> like this.
> 
>> But actually this error will still exists even if the driver can ensure
>> that ib_mtu_enum_to_int() returns a legal value. So add a mask in
>> hr_reg_write() to avoid above warning.
> 
> I think you need to have an if that ib_mtu_enum_to_int() is not
> negative, that should satisfy the CFA?
> 
> Jason
> 

I add a check for the integer mtu from ib_mtu_enum_to_int(), and gcc stop to
complain about that. I will add a patch to this series to fix it. Thank you.

Weihang
