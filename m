Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CA1E7695
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2H0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 03:26:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgE2H0j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 May 2020 03:26:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 920E05587BB7B903D501;
        Fri, 29 May 2020 15:26:37 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.119) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 15:26:30 +0800
Subject: Re: [PATCH][next] RDMA/hns: remove duplicate assignment to pointer
 raq
To:     Colin King <colin.king@canonical.com>,
        Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200528150427.420624-1-colin.king@canonical.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <7a803901-5405-4837-3fa8-d81e8bdfc067@huawei.com>
Date:   Fri, 29 May 2020 15:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20200528150427.420624-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.119]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



在 2020/5/28 23:04, Colin King 写道:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer raq is being assigned twice. Fix this by removing
> one of the redundant assignments.
> 
> Fixes: 14ba87304bf9 ("RDMA/hns: Remove redundant type cast for general pointers")
> Addressses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index 8ff6b922b4d7..d02207cd30df 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -1146,7 +1146,7 @@ static void hns_roce_db_free(struct hns_roce_dev *hr_dev)
>   static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
>   {
>   	struct hns_roce_v1_priv *priv = hr_dev->priv;
> -	struct hns_roce_raq_table *raq = raq = &priv->raq_table;
> +	struct hns_roce_raq_table *raq = &priv->raq_table;
>   	struct device *dev = &hr_dev->pdev->dev;
>   	int raq_shift = 0;
>   	dma_addr_t addr;
> 
thanks

