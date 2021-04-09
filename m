Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C3359186
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 03:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDIBj0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 8 Apr 2021 21:39:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3938 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBj0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 21:39:26 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FGgj85dMMz5jmD;
        Fri,  9 Apr 2021 09:37:00 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 9 Apr 2021 09:39:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 9 Apr 2021 09:39:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Fri, 9 Apr 2021 09:39:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuyixing (A)" <liuyixing1@huawei.com>
Subject: Re: [PATCH for-next 8/9] RDMA/hns: Simplify the function config_eqc()
Thread-Topic: [PATCH for-next 8/9] RDMA/hns: Simplify the function
 config_eqc()
Thread-Index: AQHXJ5//ftXrBjSIxE+RENDv6jhhjA==
Date:   Fri, 9 Apr 2021 01:39:12 +0000
Message-ID: <defd6389a46149c1874d9f11a997e06f@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
 <1617354454-47840-9-git-send-email-liweihang@huawei.com>
 <20210408191334.GC692402@nvidia.com>
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

On 2021/4/9 3:13, Jason Gunthorpe wrote:
> On Fri, Apr 02, 2021 at 05:07:33PM +0800, Weihang Li wrote:
>> -	roce_set_field(eqc->byte_40, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
>> -		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eqe_ba[1] >> 12);
>> -
>> -	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
>> -		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eqe_ba[1] >> 44);
>> -
>> -	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_EQE_SIZE_M,
>> -		       HNS_ROCE_EQC_EQE_SIZE_S,
>> -		       eq->eqe_size == HNS_ROCE_V3_EQE_SIZE ? 1 : 0);
>> +	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
>> +	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
>> +	hr_reg_write(eqc, EQC_OVER_IGNORE, eq->over_ignore);
>> +	hr_reg_write(eqc, EQC_COALESCE, eq->coalesce);
> 
> This really is a lot better like this, isn't it?
> 
> Jason
> 

Yes, thank you for your previous advice :)

Weihang
