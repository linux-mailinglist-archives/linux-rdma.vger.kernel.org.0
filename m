Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3763A9BC33
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfHXGXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Aug 2019 02:23:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfHXGXt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 24 Aug 2019 02:23:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 804BFC2DEB470B56E543;
        Sat, 24 Aug 2019 14:23:38 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 24 Aug 2019
 14:23:27 +0800
Subject: Re: [PATCH for-next 0/9] Bugfixes for 5.3-rc2
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <ac9cd14a089a03bf1d19ca5a938c8d6bfa1e5f70.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <f29f004a-6cd4-a843-14b2-fe866af0947f@huawei.com>
Date:   Sat, 24 Aug 2019 14:23:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <ac9cd14a089a03bf1d19ca5a938c8d6bfa1e5f70.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/8/14 0:34, Doug Ledford 写道:
> On Fri, 2019-08-09 at 17:40 +0800, Lijun Ou wrote:
>> Here fixes some bugs for hip08
>>
>> Lang Cheng (1):
>>   RDMA/hns: Remove unuseful member
>>
>> Lijun Ou (2):
>>   RDMA/hns: Bugfix for creating qp attached to srq
>>   RDMA/hns: Copy some information of AV to user
>>
>> Weihang Li (1):
>>   RDMA/hns: Logic optimization of wc_flags
>>
>> Xi Wang (2):
>>   RDMA/hns: Bugfix for slab-out-of-bounds when unloading hip08 driver
>>   RDMA/hns: bugfix for slab-out-of-bounds when loading hip08 driver
>>
>> Yangyang Li (3):
>>   RDMA/hns: Completely release qp resources when hw err
>>   RDMA/hns: Modify pi vlaue when cq overflows
>>   RDMA/hns: Kernel notify usr space to stop ring db
>>
>>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 22 ++++++--
>>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |  1 -
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++-
>>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 19 ++++---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 78
>> +++++++++++++++++++++++------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++
>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 29 +++++++----
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 25 ++++++---
>>  include/uapi/rdma/hns-abi.h                 |  7 +++
>>  9 files changed, 148 insertions(+), 45 deletions(-)
>>
> Patches 1, 2, 4, 5, 6, and 7 applied to for-next.
>
> I have concerns about patches 3, 8, and 9.  I'm skipping them until you
> can address the comments I made on and off list.
>
Thanks. We will talk about further analysis discussion for the comments before send the next patch.


