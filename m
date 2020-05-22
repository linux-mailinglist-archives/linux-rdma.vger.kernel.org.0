Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDB1DE28B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgEVJB6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 22 May 2020 05:01:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2147 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728424AbgEVJB6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 05:01:58 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 32792694D0967CA2AA8F
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 17:01:56 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.243]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0487.000; Fri, 22 May 2020 17:01:46 +0800
From:   liweihang <liweihang@huawei.com>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Various fixes and cleanups
Thread-Topic: [PATCH for-next 0/9] RDMA/hns: Various fixes and cleanups
Thread-Index: AQHWJR2R13RQ/ucvpES4423Q+u32DQ==
Date:   Fri, 22 May 2020 09:01:46 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0236A86A@DGGEML522-MBX.china.huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
 <B82435381E3B2943AA4D2826ADEF0B3A0236A7A2@DGGEML522-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/5/22 15:39, liweihang wrote:
> On 2020/5/8 17:46, Weihang Li wrote:
>> This series contains the following:
>> - #1 ~ #2 are fixes to solve issues found from previous versions.
>> - #3 ~ #5 are fixes for recent refactoring codes to 5.8.
>> - #6 ~ #9 are various cleanups.
>>
>> Lang Cheng (2):
>>   RDMA/hns: Fix cmdq parameter of querying pf timer resource
>>   RDMA/hns: Store mr len information into mr obj
>>
>> Lijun Ou (2):
>>   RDMA/hns: Bugfix for querying qkey
>>   RDMA/hns: Reserve one sge in order to avoid local length error
>>
>> Weihang Li (3):
>>   RDMA/hns: Fix wrong assignment of SRQ's max_wr
>>   RDMA/hns: Fix error with to_hr_hem_entries_count()
>>   RDMA/hns: Remove redundant memcpy()
>>
>> Wenpeng Liang (1):
>>   RDMA/hns: Fix assignment to ba_pg_sz of eqe
>>
>> Xi Wang (1):
>>   RDMA/hns: Rename macro for defining hns hardware page size
>>
>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |  6 ++--
>>  drivers/infiniband/hw/hns/hns_roce_cq.c     |  4 +--
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 15 +++++---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 53 ++++++++++++-----------------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++-
>>  drivers/infiniband/hw/hns/hns_roce_mr.c     |  8 +++--
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  9 ++---
>>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 10 +++---
>>  8 files changed, 56 insertions(+), 53 deletions(-)
>>
> 
> Hi Jason,
> 
> I notice that this series has been marked as "Accepted" on patchwork,
> but I can't find them on your for-next branch. Maybe there is something
> wrong :)
> 

Sorry, I just saw them on your branch.

Thanks
Weihang
