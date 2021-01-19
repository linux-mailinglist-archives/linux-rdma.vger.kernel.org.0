Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520ED2FB24E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 08:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhASHC0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 19 Jan 2021 02:02:26 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2864 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbhASHCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 02:02:01 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DKffb2Jpqz5Hkt;
        Tue, 19 Jan 2021 14:59:51 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 19 Jan 2021 15:01:14 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 19 Jan 2021 15:01:14 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Tue, 19 Jan 2021 15:01:14 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [Linuxarm] Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD
 inline of userspace
Thread-Topic: [Linuxarm] Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for
 UD inline of userspace
Thread-Index: AQHW7idvPj71VFG9skyUr2jC02wJ6Q==
Date:   Tue, 19 Jan 2021 07:01:13 +0000
Message-ID: <aacc6653bd794f2d934ff85d5151d1af@huawei.com>
References: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
 <20210118200854.GA778611@nvidia.com>
 <180c1cd8489e430eaa99913885356e03@huawei.com> <20210119062705.GE21258@unreal>
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

On 2021/1/19 14:27, Leon Romanovsky wrote:
> On Tue, Jan 19, 2021 at 05:53:40AM +0000, liweihang wrote:
>> On 2021/1/19 4:09, Jason Gunthorpe wrote:
>>> On Tue, Jan 05, 2021 at 04:47:03PM +0800, Weihang Li wrote:
>>>> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
>>>> index 90b739d..79dba94 100644
>>>> +++ b/include/uapi/rdma/hns-abi.h
>>>> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
>>>>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
>>>>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
>>>>  	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
>>>> +	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,
>>>>  };
>>> Where are the rdma-core patches to support this bit? I don't see them
>>> on github?
>>>
>>> Jason
>> I thought we needed to send the userspace part after the kernel part
>> was merged. I sent the rdma-core patches just now:
>>
>> https://github.com/linux-rdma/rdma-core/pull/934
> After kernel part will be accessed, you will need to update the patch
> https://github.com/linux-rdma/rdma-core/pull/934/commits/2877713e1fed29305d04e39dd934ea81082e616e
> with the correct SHA-1.
> 
> Thanks
> 

OK, I will update it then.

Thanks
Weihang
