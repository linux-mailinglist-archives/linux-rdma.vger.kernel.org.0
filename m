Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C9C4535D1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhKPPeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 10:34:01 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27215 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbhKPPeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Nov 2021 10:34:00 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HtqjV4S7xz8vQd;
        Tue, 16 Nov 2021 23:29:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:31:01 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 16 Nov
 2021 23:31:01 +0800
Subject: Re: [PATCH v2 rdma-core 1/2] Update kernel headers
To:     <leon@kernel.org>, <jgg@nvidia.com>
References: <20211116150316.21925-1-liangwenpeng@huawei.com>
 <20211116150316.21925-2-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <0fc3c207-afaa-7f64-3f93-d633b7ba5636@huawei.com>
Date:   Tue, 16 Nov 2021 23:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211116150316.21925-2-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2021/11/16 23:03, Wenpeng Liang wrote:
> To commit ?? ("RDMA/hns: Support direct wqe of userspace").
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  kernel-headers/rdma/hns-abi.h       |  2 ++
>  kernel-headers/rdma/rdma_netlink.h  |  5 +++++
>  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)

Hi Leon,

I have encountered a problem and I hope to master a correct
submission method.

This user space patch modifies the hns-abi.h file, so I use the
python command to generate the patch to keep the kernel-headers
consistent with the kernel mode:

python3.5 kernel-headers/update --not-final <kernel space dir> <commitID>

In addition to the modification of hns-abi.h, the generated patch
also involves the modification of other files. And resulted in the
following compilation error:

/rdma-core/providers/rxe/rxe.c: In function ‘rxe_post_one_recv’:
/rdma-core/providers/rxe/rxe.c:712:17: error: ‘struct rxe_dma_info’ has no member named ‘sge’
   712 | memcpy(wqe->dma.sge, recv_wr->sg_list,
       | ^
/rdma-core/providers/rxe/rxe.c:713:38: error: ‘struct rxe_dma_info’ has no member named ‘sge’
   713 | wqe->num_sge*sizeof(*wqe->dma.sge));

In this case, what is the correct way to submit the patch? Should
I wait for the rxe patch submission to complete before submitting
this patchset, or submit only the hns part of the patch generated
by python?

Thanks,
Wenpeng
