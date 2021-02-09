Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E863149D0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 08:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBIH5e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 9 Feb 2021 02:57:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4616 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBIH5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 02:57:32 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DZZvB0tv7zY782;
        Tue,  9 Feb 2021 15:55:34 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 9 Feb 2021 15:56:49 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 9 Feb 2021 15:56:49 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Tue, 9 Feb 2021 15:56:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 05/12] RDMA/hns: Adjust definition of FRMR fields
Thread-Topic: [PATCH for-next 05/12] RDMA/hns: Adjust definition of FRMR
 fields
Thread-Index: AQHW+6Pkhjju0EYvxk+CH6ulVXL1wQ==
Date:   Tue, 9 Feb 2021 07:56:48 +0000
Message-ID: <46d3f3d647744440aecb0b333975c7cb@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
 <1612517974-31867-6-git-send-email-liweihang@huawei.com>
 <20210209002327.GA1233507@nvidia.com>
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

On 2021/2/9 8:24, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 05:39:27PM +0800, Weihang Li wrote:
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index f29438c..1da980c 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -1255,15 +1255,15 @@ struct hns_roce_v2_rc_send_wqe {
>>  
>>  #define V2_RC_SEND_WQE_BYTE_4_INLINE_S 12
>>  
>> -#define V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S 19
>> +#define V2_RC_FRMR_WQE_BYTE_40_BIND_EN_S 10
>>  
>> -#define V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S 20
>> +#define V2_RC_FRMR_WQE_BYTE_40_ATOMIC_S 11
>>  
>> -#define V2_RC_FRMR_WQE_BYTE_4_RR_S 21
>> +#define V2_RC_FRMR_WQE_BYTE_40_RR_S 12
>>  
>> -#define V2_RC_FRMR_WQE_BYTE_4_RW_S 22
>> +#define V2_RC_FRMR_WQE_BYTE_40_RW_S 13
>>  
>> -#define V2_RC_FRMR_WQE_BYTE_4_LW_S 23
>> +#define V2_RC_FRMR_WQE_BYTE_40_LW_S 14
>>  
>>  #define V2_RC_SEND_WQE_BYTE_4_FLAG_S 31
>>  
>> @@ -1280,7 +1280,7 @@ struct hns_roce_v2_rc_send_wqe {
>>  
>>  struct hns_roce_wqe_frmr_seg {
>>  	__le32	pbl_size;
>> -	__le32	mode_buf_pg_sz;
>> +	__le32	byte_40;
>>  };
> 
> This stuff is HW API isn't it?
> 
> I didn't see anything to negotiate compatability with existing HW?
> What happens if the kernel is updated and run on old HW/FW?
> 
> If you tightly couple you still need to check and refuse to load the
> driver.
> 
> Jason
> 

Thank you, FRMR is not well-supported on HIP08, so we re-design it on
HIP09. I will add a check to avoid ULPs using FRMR on HIP08.

Weihang

