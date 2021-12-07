Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9046BBC8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 13:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhLGMzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 07:55:13 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29098 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhLGMzN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 07:55:13 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J7g8h39Nrz1DJxV;
        Tue,  7 Dec 2021 20:48:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:51:41 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 20:51:41 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Modify the mapping attribute of
 doorbell to device
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211206133652.27476-1-liangwenpeng@huawei.com>
 <20211206153743.GI4670@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <54ba4c20-58b3-ca00-7b3c-c7ba423e276d@huawei.com>
Date:   Tue, 7 Dec 2021 20:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211206153743.GI4670@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/12/6 23:37, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 09:36:52PM +0800, Wenpeng Liang wrote:
>> From: Yixing Liu <liuyixing1@huawei.com>
>>
>> It is more general for ARM device drivers to use the device attribute to
>> map pci bar spaces.
>>
>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> It seems like the right thing todo, thanks
> 
> I see other drivers are doing it wrong as well:
> 
> drivers/infiniband/hw/bnxt_re/ib_verbs.c:               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/cxgb4/provider.c:         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/cxgb4/provider.c:                                 pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/cxgb4/t4.h:       return pgprot_noncached(prot);
> drivers/infiniband/hw/efa/efa_verbs.c:                                  pgprot_noncached(vma->vm_page_prot),
> drivers/infiniband/hw/hfi1/file_ops.c:          /* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
> drivers/infiniband/hw/hfi1/file_ops.c:          vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/hns/hns_roce_main.c:              prot = pgprot_noncached(prot);
> drivers/infiniband/hw/irdma/verbs.c:                             pgprot_noncached(vma->vm_page_prot), NULL);
> drivers/infiniband/hw/irdma/verbs.c:                                    pgprot_noncached(vma->vm_page_prot),
> drivers/infiniband/hw/mlx4/main.c:                                       pgprot_noncached(vma->vm_page_prot),
> drivers/infiniband/hw/mlx4/main.c:                      PAGE_SIZE, pgprot_noncached(vma->vm_page_prot),
> drivers/infiniband/hw/mlx5/main.c:              prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/mlx5/main.c:              prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/mlx5/main.c:                                       pgprot_noncached(vma->vm_page_prot),
> drivers/infiniband/hw/mthca/mthca_provider.c:   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:            vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/qib/qib_file_ops.c:               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/qib/qib_file_ops.c:       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/usnic/usnic_ib_verbs.c:   vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c:        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> They should all use pgprot_device I think?
> 
> It is the same except on ARM where pgprot_device() is a bit faster
> 
> Jason
> .
> 

I will submit a patch to fix these problems later.

Thanks
Wenpeng
