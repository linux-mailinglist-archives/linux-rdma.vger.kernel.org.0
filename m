Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B047DD97
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 03:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhLWCIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Dec 2021 21:08:13 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30095 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWCIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Dec 2021 21:08:12 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JKD6P4Vfsz1DK9c;
        Thu, 23 Dec 2021 10:05:01 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 10:08:11 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 23 Dec
 2021 10:08:10 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Remove support for HIP06
To:     <jgg@nvidia.com>, <leon@kernel.org>
References: <20211220122334.31204-1-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <9aef2ed8-e775-87e7-70ee-c8455e535f6a@huawei.com>
Date:   Thu, 23 Dec 2021 10:08:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211220122334.31204-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please ignore this patch, the latest patch is v2.

[PATCH v2 for-next] RDMA/hns: Remove support for HIP06

It should be resend, but I incorrectly marked it as v2.

Thanks,
Wenpeng

On 2021/12/20 20:23, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> HIP06 is no longer supported. In order to reduce unnecessary maintenance,
> the code of HIP06 is removed.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Kconfig           |   17 +-
>  drivers/infiniband/hw/hns/Makefile          |    5 -
>  drivers/infiniband/hw/hns/hns_roce_ah.c     |    5 +-
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |    3 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_common.h |  202 -
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |   13 -
>  drivers/infiniband/hw/hns/hns_roce_db.c     |    1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |   60 -
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 4675 -------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h  | 1147 -----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |    6 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   58 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   19 +-
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |   20 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |   37 +-
>  17 files changed, 25 insertions(+), 6245 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.c
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.h
