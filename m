Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF06F7A9E4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfG3Nln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 09:41:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfG3Nln (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 09:41:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4DE009D7C0222294667C;
        Tue, 30 Jul 2019 21:41:41 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 21:41:35 +0800
Subject: Re: [PATCH for-next 00/13] Updates for 5.3-rc2
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <648dafeb-1922-b1d0-a2da-dc2844a1b426@intel.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <e0fc14e1-30ef-3124-feaf-ea0ddf0c568d@huawei.com>
Date:   Tue, 30 Jul 2019 21:41:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <648dafeb-1922-b1d0-a2da-dc2844a1b426@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/7/30 20:33, Dennis Dalessandro 写道:
> On 7/30/2019 4:56 AM, Lijun Ou wrote:
>> Here are some updates for hns driver based 5.3-rc2, mainly
>> include some codes optimization and comments style modification.
>>
>> Lang Cheng (6):
>>    RDMA/hns: Clean up unnecessary initial assignment
>>    RDMA/hns: Update some comments style
>>    RDMA/hns: Handling the error return value of hem function
>>    RDMA/hns: Split bool statement and assign statement
>>    RDMA/hns: Refactor irq request code
>>    RDMA/hns: Remove unnecessary kzalloc
>>
>> Lijun Ou (2):
>>    RDMA/hns: Encapsulate some lines for setting sq size in user mode
>>    RDMA/hns: Optimize hns_roce_modify_qp function
>>
>> Weihang Li (2):
>>    RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
>>    RDMA/hns: Disable alw_lcl_lpbk of SSU
>>
>> Yangyang Li (1):
>>    RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
>>
>> Yixian Liu (2):
>>    RDMA/hns: Update the prompt message for creating and destroy qp
>>    RDMA/hns: Remove unnessary init for cmq reg
>>
>>   drivers/infiniband/hw/hns/hns_roce_device.h |  65 +++++----
>>   drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 +-
>>   drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 +-
>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 210 ++++++++++++++--------------
>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 -
>>   drivers/infiniband/hw/hns/hns_roce_mr.c     |   1 -
>>   drivers/infiniband/hw/hns/hns_roce_qp.c     | 150 +++++++++++++-------
>>   7 files changed, 244 insertions(+), 205 deletions(-)
>>
>
> A lot of this doesn't seem appropriate for an -rc does it?
>
It mainly optimize some codes and style. if it is some bugs, we should consider -rc?
> -Denny
>
> .
>


