Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE11389C31
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 05:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETD5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 19 May 2021 23:57:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4552 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETD5m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 23:57:42 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Flwnn3RbCzkYC9;
        Thu, 20 May 2021 11:53:33 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (7.185.36.148) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:56:19 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:56:19 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 20 May 2021 11:56:19 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH v2 for-next 0/7] RDMA/hns: Add support for Dynamic
 Context Attachment
Thread-Index: AQHXRlf62+7thPJ5jkK+TA/Qw2h+Ew==
Date:   Thu, 20 May 2021 03:56:19 +0000
Message-ID: <d3edf24af30740a98d5da2df03570e4a@huawei.com>
References: <1620732161-27180-1-git-send-email-liweihang@huawei.com>
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

On 2021/5/11 19:22, liweihang wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.
> 
> Changes since v1:
> * Modify return type of hns_roce_enable_dca() to void.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620650889-61650-1-git-send-email-liweihang@huawei.com/
> 
> Two RFC versions of this series has been sent before, and it's associated
> with the userspace one "libhns: Add support for Dynamic Context
> Attachment".
> 
> Changes since RFC v2:
> * Just fix a typo in commit message of #6.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1611394994-50363-1-git-send-email-liweihang@huawei.com/
> 
> Changes since RFC v1:
> * Replace all GFP_ATOMIC with GFP_NOWAIT, because the former may use
>   emergency pool if no regular memory can be found.
> * Change size of cap_flags of alloc_ucontext_resp from 32 to 64 to avoid
>   a potential problem when pass it back to the userspace.
> * Move definition of HNS_ROCE_CAP_FLAG_DCA_MODE to hns-abi.h.
> * Rename free_mem_states() to free_dca_states() in #1.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1610706138-4219-1-git-send-email-liweihang@huawei.com/
> 
> Xi Wang (7):
>   RDMA/hns: Introduce DCA for RC QP
>   RDMA/hns: Add method for shrinking DCA memory pool
>   RDMA/hns: Configure DCA mode for the userspace QP
>   RDMA/hns: Add method for attaching WQE buffer
>   RDMA/hns: Setup the configuration of WQE addressing to QPC
>   RDMA/hns: Add method to detach WQE buffer
>   RDMA/hns: Add method to query WQE buffer's address
> 
>  drivers/infiniband/hw/hns/Makefile          |    2 +-
>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 1262 +++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |   69 ++
>  drivers/infiniband/hw/hns/hns_roce_device.h |   33 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  223 ++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |    3 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   27 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  105 ++-
>  include/uapi/rdma/hns-abi.h                 |   64 ++
>  9 files changed, 1746 insertions(+), 42 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h
> 

We have received new comments on v1, so please ignore this version.

Thanks
Weihang
