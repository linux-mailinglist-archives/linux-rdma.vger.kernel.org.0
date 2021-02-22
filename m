Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A739321A51
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhBVOZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 09:25:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12639 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBVOWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 09:22:48 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DkkqF2WBTz16BWQ;
        Mon, 22 Feb 2021 22:20:25 +0800 (CST)
Received: from [10.174.179.96] (10.174.179.96) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 22:21:58 +0800
Subject: Re: [PATCH v2 -next] IB/mlx5: Add missing error code
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210222082503.22388-1-yuehaibing@huawei.com>
 <20210222122343.19720-1-yuehaibing@huawei.com> <YDOwQyZJ+Iovj/Yj@unreal>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <4f4ed6f2-8b2d-30f5-20dd-f27049621399@huawei.com>
Date:   Mon, 22 Feb 2021 22:21:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YDOwQyZJ+Iovj/Yj@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/2/22 21:23, Leon Romanovsky wrote:
> On Mon, Feb 22, 2021 at 08:23:43PM +0800, YueHaibing wrote:
>> Set err to -ENOMEM if kzalloc fails instead of 0.
>>
>> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
> 
> Thanks,
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> 
> And please don't send new version of patches as a reply-to, it is
> annoying like hell.

Ok, Got it.

> Thanks
> .
> 
