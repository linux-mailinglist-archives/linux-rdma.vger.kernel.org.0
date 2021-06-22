Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FB3AFE21
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVHo6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 22 Jun 2021 03:44:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5064 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFVHo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 03:44:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8JBz22H3zXjnt;
        Tue, 22 Jun 2021 15:37:31 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (7.185.36.93) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 15:42:40 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 15:42:40 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Tue, 22 Jun 2021 15:42:39 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        zhangjiaran <zhangjiaran@huawei.com>,
        chenglang <chenglang@huawei.com>
Subject: Re: [PATCH RESEND for-next] RDMA/hns: Solve the problem that dma_pool
 is used during the reset
Thread-Topic: [PATCH RESEND for-next] RDMA/hns: Solve the problem that
 dma_pool is used during the reset
Thread-Index: AQHXXqU6SHyhWNAGeECZzIdBLVcbbw==
Date:   Tue, 22 Jun 2021 07:42:39 +0000
Message-ID: <1e67a9181f0d4b17911cae3c03185c76@huawei.com>
References: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
 <YMRbnjyO0VxhYojL@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/12 15:01, Leon Romanovsky wrote:
> On Fri, Jun 11, 2021 at 05:35:56PM +0800, Weihang Li wrote:
>> From: Jiaran Zhang <zhangjiaran@huawei.com>
>>
>> During the reset, the driver calls dma_pool_destroy() to release the
>> dma_pool resources. If the dma_pool_free interface is called during the
>> modify_qp operation, an exception will occur. The completion
>> synchronization mechanism is used to ensure that dma_pool_destroy() is
>> executed after the dma_pool_free operation is complete.
>>
>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_cmd.c    | 24 +++++++++++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
>> index 8f68cc3..e7293ca 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
>> @@ -198,11 +198,20 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
>>  	if (!hr_dev->cmd.pool)
>>  		return -ENOMEM;
>>  
>> +	init_completion(&hr_dev->cmd.can_free);
>> +
>> +	refcount_set(&hr_dev->cmd.refcnt, 1);
>> +
>>  	return 0;
>>  }
>>  
>>  void hns_roce_cmd_cleanup(struct hns_roce_dev *hr_dev)
>>  {
>> +	if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
>> +		complete(&hr_dev->cmd.can_free);
>> +
>> +	wait_for_completion(&hr_dev->cmd.can_free);
>> +
>>  	dma_pool_destroy(hr_dev->cmd.pool);
>>  }
> Did you observe any failures, kernel panics e.t.c?
> At this stage, you are not supposed to issue any mailbox commands and if
> you do, you have a bug in some other place, for example didn't flush
> workqueue ...
> 
> Thanks
> 

We get following errors with high probability when IMP reset and modify QP
happens at the same time:

[15834.440744] Unable to handle kernel paging request at virtual address
ffffa2cfc7725678
..
[15834.660596] Call trace:
[15834.663033]  queued_spin_lock_slowpath+0x224/0x308
[15834.667802]  _raw_spin_lock_irqsave+0x78/0x88
[15834.672140]  dma_pool_free+0x34/0x118
[15834.675799]  hns_roce_free_cmd_mailbox+0x54/0x88 [hns_roce_hw_v2]
[15834.681872]  hns_roce_v2_qp_modify.isra.57+0xcc/0x120 [hns_roce_hw_v2]
[15834.688376]  hns_roce_v2_modify_qp+0x4d4/0x1ef8 [hns_roce_hw_v2]
[15834.694362]  hns_roce_modify_qp+0x214/0x5a8 [hns_roce_hw_v2]
[15834.699996]  _ib_modify_qp+0xf0/0x308
[15834.703642]  ib_modify_qp+0x38/0x48
[15834.707118]  rt_ktest_modify_qp+0x14c/0x998 [rdma_test]

..

[15837.269216] Unable to handle kernel paging request at virtual address
000197c995a1d1b4
..
[15837.480898] Call trace:
[15837.483335]  __free_pages+0x28/0x78
[15837.486807]  dma_direct_free_pages+0xa0/0xe8
[15837.491058]  dma_direct_free+0x48/0x60
[15837.494790]  dma_free_attrs+0xa4/0xe8
[15837.498449]  hns_roce_buf_free+0xb0/0x150 [hns_roce_hw_v2]
[15837.503918]  mtr_free_bufs.isra.1+0x88/0xc0 [hns_roce_hw_v2]
[15837.509558]  hns_roce_mtr_destroy+0x60/0x80 [hns_roce_hw_v2]
[15837.515198]  hns_roce_v2_cleanup_eq_table+0x1d0/0x2a0 [hns_roce_hw_v2]
[15837.521701]  hns_roce_exit+0x108/0x1e0 [hns_roce_hw_v2]
[15837.526908]  __hns_roce_hw_v2_uninit_instance.isra.75+0x70/0xb8 [hns_roce_hw_v2]
[15837.534276]  hns_roce_hw_v2_uninit_instance+0x64/0x80 [hns_roce_hw_v2]
[15837.540786]  hclge_uninit_client_instance+0xe8/0x1e8 [hclge]
[15837.546419]  hnae3_uninit_client_instance+0xc4/0x118 [hnae3]
[15837.552052]  hnae3_unregister_client+0x16c/0x1f0 [hnae3]
[15837.557346]  hns_roce_hw_v2_exit+0x34/0x50 [hns_roce_hw_v2]
[15837.562895]  __arm64_sys_delete_module+0x208/0x268
[15837.567665]  el0_svc_common.constprop.4+0x110/0x200
[15837.572520]  do_el0_svc+0x34/0x98
[15837.575821]  el0_svc+0x14/0x40
[15837.578862]  el0_sync_handler+0xb0/0x2d0
[15837.582766]  el0_sync+0x140/0x180

It is caused by two concurrent processes:
	uninit_instance->dma_pool_destroy(cmdq) 
	modify_qp->dma_poll_free(cmdq)

So we want the dma_poll_destroy() to be called after all dma_poll_free() is
complete.

Thanks
Weihang

