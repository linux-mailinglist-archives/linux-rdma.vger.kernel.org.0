Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CF315CE4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 03:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhBJCIP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 9 Feb 2021 21:08:15 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2896 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhBJCHv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 21:07:51 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Db34f2hR7z5QLT;
        Wed, 10 Feb 2021 10:05:22 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 10 Feb 2021 10:07:07 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 10:07:07 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Wed, 10 Feb 2021 10:07:07 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Adjust definition of FRMR fields
Thread-Topic: [PATCH v2 for-next] RDMA/hns: Adjust definition of FRMR fields
Thread-Index: AQHW/r+mtV53E2fMdk6Q7+w4PMwPRw==
Date:   Wed, 10 Feb 2021 02:07:07 +0000
Message-ID: <4e7852507f9c499e87f861b42fe6c8c8@huawei.com>
References: <1612859923-44041-1-git-send-email-liweihang@huawei.com>
 <20210209171247.GP4247@nvidia.com>
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

On 2021/2/10 1:13, Jason Gunthorpe wrote:
> On Tue, Feb 09, 2021 at 04:38:43PM +0800, Weihang Li wrote:
>> @@ -545,7 +545,10 @@ static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>>  		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
>>  		break;
>>  	case IB_WR_REG_MR:
>> -		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
>> +		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
>> +			set_frmr_seg(rc_sq_wqe, reg_wr(wr));
>> +		else
>> +			ret = -EOPNOTSUPP;
> 
> The driver must also clear IB_DEVICE_MEM_MGT_EXTENSIONS if it won't
> support IB_WR_REG_MR
> 
> Jason
> 

Thanks for the reminder, I will fix it.

Weihang
