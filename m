Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5023F474491
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhLNOOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 09:14:55 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32919 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhLNOOz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 09:14:55 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JD0kN2npczcbvs;
        Tue, 14 Dec 2021 22:14:36 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 22:14:53 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 22:14:53 +0800
Subject: Re: [PATCH] RDMA/hns: Replace kfree with kvfree
To:     Jiacheng Shi <billsjc@sjtu.edu.cn>,
        Weihang Li <liweihang@huawei.com>
References: <20211210094234.5829-1-billsjc@sjtu.edu.cn>
CC:     <linux-rdma@vger.kernel.org>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <a449120c-23d9-e884-46f0-481bdade3047@huawei.com>
Date:   Tue, 14 Dec 2021 22:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211210094234.5829-1-billsjc@sjtu.edu.cn>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/12/10 17:42, Jiacheng Shi wrote:
> Variables allocated by kvmalloc_array should not be freed by kfree.
> Because they may be allocated by vmalloc.
> So we replace kfree with kvfree here.
> 
> Fixes: 6fd610c5733d ("RDMA/hns: Support 0 hop addressing for SRQ buffer")
> Signed-off-by: Jiacheng Shi <billsjc@sjtu.edu.cn>
> ---
>  drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
> index 6eee9deadd12..e64ef6903fb4 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_srq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
> @@ -259,7 +259,7 @@ static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
>  
>  static void free_srq_wrid(struct hns_roce_srq *srq)
>  {
> -	kfree(srq->wrid);
> +	kvfree(srq->wrid);
>  	srq->wrid = NULL;
>  }
>  
> 

Thanks for the patch.

Acked-by: Wenpeng Liang <liangwenpeng@huawei.com>

Thanks
Wenpeng
