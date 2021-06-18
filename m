Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B33AC73E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhFRJTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Jun 2021 05:19:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11063 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhFRJTx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 05:19:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5tY111wfzZfsT;
        Fri, 18 Jun 2021 17:14:45 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 17:17:42 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 17:17:41 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 18 Jun 2021 17:17:41 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, chenglang <chenglang@huawei.com>
Subject: Re: [PATCH v3 for-next 1/8] RDMA/hns: Use temporary variables to fix
 warning about hr_reg_write()
Thread-Topic: [PATCH v3 for-next 1/8] RDMA/hns: Use temporary variables to fix
 warning about hr_reg_write()
Thread-Index: AQHXY0royWnjr0kOt0ufbx14sYWfVw==
Date:   Fri, 18 Jun 2021 09:17:41 +0000
Message-ID: <f3ff5a5b41af4fddb7072d550f95d196@huawei.com>
References: <1623915111-43630-1-git-send-email-liweihang@huawei.com>
 <1623915111-43630-2-git-send-email-liweihang@huawei.com>
 <20210617224142.GU1002214@nvidia.com>
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

On 2021/6/18 6:41, Jason Gunthorpe wrote:
> On Thu, Jun 17, 2021 at 03:31:44PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Fix complains from sparse about "dubious: x & !y" when calling
>> hr_reg_write(ctx, field, !!val).
> 
> Where is this from?
> 
> I'm not convinced you should have the temporary here given how much
> magics are involved in this stuff that rely on builtin_constant_p
> 
> Jason
> 

The warning comes from:

#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
		...

		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
				 _pfx "value too large for the field"); \

I will change 'hr_reg_write(ctx, field, !!val)' to 'hr_reg_write(ctx, field, val
? 1 : 0)'. The latter is not as succinct as the former, but can avoid the sparse
warning.

Thanks
Weihang
