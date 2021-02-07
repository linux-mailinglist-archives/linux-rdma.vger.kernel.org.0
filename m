Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2931212E
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBGDe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 6 Feb 2021 22:34:58 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4610 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGDe5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:34:57 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DYF981hk9zY6WM;
        Sun,  7 Feb 2021 11:33:00 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sun, 7 Feb 2021 11:34:13 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sun, 7 Feb 2021 11:34:13 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Sun, 7 Feb 2021 11:34:13 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 RFC 0/7] RDMA/hns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH v2 RFC 0/7] RDMA/hns: Add support for Dynamic Context
 Attachment
Thread-Index: AQHW8Wy31xOeEU8gmUOPaLZDcNid3A==
Date:   Sun, 7 Feb 2021 03:34:13 +0000
Message-ID: <b637b0048f1c4f97aee3b136772270b1@huawei.com>
References: <1611394994-50363-1-git-send-email-liweihang@huawei.com>
 <20210205180315.GA969245@nvidia.com>
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

On 2021/2/6 2:03, Jason Gunthorpe wrote:
> On Sat, Jan 23, 2021 at 05:43:07PM +0800, Weihang Li wrote:
>> The hip09 introduces the DCA(Dynamic Context Attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
>> enables DCA feature, the WQE's buffer will not be allocated when creating
>> but when the users start to post WRs. This will reduce the memory
>> consumption when there are too many QPs are inactive.
>>
>> Changes since v1:
>> * Replace all GFP_ATOMIC with GFP_NOWAIT, because the former may use
>>   emergency pool if no regular memory can be found.
>> * Change size of cap_flags of alloc_ucontext_resp from 32 to 64 to avoid
>>   a potential problem when pass it back to the userspace.
>> * Move definition of HNS_ROCE_CAP_FLAG_DCA_MODE to hns-abi.h.
>> * Rename free_mem_states() to free_dca_states() in #1.
>> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1610706138-4219-1-git-send-email-liweihang@huawei.com/
>>
>> Xi Wang (7):
>>   RDMA/hns: Introduce DCA for RC QP
>>   RDMA/hns: Add method for shrinking DCA memory pool
>>   RDMA/hns: Configure DCA mode for the userspace QP
>>   RDMA/hns: Add method for attaching WQE buffer
>>   RDMA/hns: Setup the configuration of WQE addressing to QPC
>>   RDMA/hns: Add method to detach WQE buffer
>>   RDMA/hns: Add method to query WQE buffer's address
>>
>>  drivers/infiniband/hw/hns/Makefile          |    2 +-
>>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 1264 +++++++++++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_dca.h    |   68 ++
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   31 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  119 ++-
>>  include/uapi/rdma/hns-abi.h                 |   64 ++
> 
> Where are the rdma-core changes to go with this?
> 
> Jason
> 

I sent the userspace part just now:
https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/

Thanks
Weihang
