Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42413D87B1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhG1GKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 02:10:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16010 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhG1GKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jul 2021 02:10:42 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZNV63TXXzZthh;
        Wed, 28 Jul 2021 14:07:10 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:10:38 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 14:10:38 +0800
Subject: Re: [PATCH v3 for-next 01/12] RDMA/hns: Introduce DCA for RC QP
To:     Leon Romanovsky <leon@kernel.org>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
 <1627356452-30564-2-git-send-email-liangwenpeng@huawei.com>
 <YP/3HPtB9DkFbWOL@unreal>
CC:     <dledford@redhat.com>, <jgg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        Xi Wang <wangxi11@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <570898e5-bf25-e1d0-dde3-b4e651b79418@huawei.com>
Date:   Wed, 28 Jul 2021 14:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YP/3HPtB9DkFbWOL@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/7/27 20:07, Leon Romanovsky wrote:
> On Tue, Jul 27, 2021 at 11:27:21AM +0800, Wenpeng Liang wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> The hip09 introduces the DCA(Dynamic context attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool, this will
>> reduce the memory consumption when there are too many QPs are inactive.
>>
>> If a QP enables DCA feature, the WQE's buffer will not be allocated when
>> creating. But when the users start to post WRs, the hns driver will
>> allocate a buffer from the memory pool and then fill WQEs which tagged with
>> this QP's number.
>>
>> The hns ROCEE will stop accessing the WQE buffer when the user polled all
>> of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
>> to the memory pool.
>>
>> This patch adds a group of methods to support the user space register
>> buffers to a memory pool which belongs to the user context. The hns kernel
>> driver will update the pages state in this pool when the user calling the
>> post/poll methods and the user driver can get the QP's WQE buffer address
>> by the key and offset which queried from kernel.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 343 ++++++++++++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  27 ++-
>>  include/uapi/rdma/hns-abi.h                 |  27 +++
>>  6 files changed, 427 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h
> 
> <...>
> 
>> +static struct hns_dca_page_state *alloc_dca_states(void *pages, int count)
>> +{
>> +	struct hns_dca_page_state *states;
>> +
>> +	states = kcalloc(count, sizeof(*states), GFP_NOWAIT);
> 
> GFP_NOWAIT ????
> Why do you use this flag while in the function before you used classic GFP_KERNEL?
> 
> Thanks
> .
> 

The next version will change this flag to GFP_KERNEL.

Thanks


