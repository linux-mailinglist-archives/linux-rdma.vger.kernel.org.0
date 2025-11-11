Return-Path: <linux-rdma+bounces-14385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B3C4C603
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 09:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1479018C3800
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BA2F3C02;
	Tue, 11 Nov 2025 08:19:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC032DF71D
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849163; cv=none; b=EExkxEgGSh8GnPi6Bj/uv4q4QidZCulvnPtUlRUyDoi2v9liHT2LrFi4mX8niE7REUId64aHbioxOkZ1JMg+7FGpsgYlLYzozhz26C0fxyUDylR2LgsYcvf4UArRW5AIImLEUeIUi806VSPQ1pGt14y8Ok9mTU0g+MPzF8ZxJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849163; c=relaxed/simple;
	bh=bkG60du0bV6zGvQaPSlAd8a5/fQEy0WlQqKcylbPLps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LdLqVKWb1d9sE6hXuIG4NK9KlzV7gp+C/w2m4BbwOpJ30yrfIxls6169y/uBvLoHzRHXMlwpQQZf4t9L6b2/XcZ+DjY36RHEfL+e4LgzLeRFQtg2eKLkza3U+Kp1oRwln4PwCO8zwYxEmOTVPjlhg3ABbZcdB99EhxIkuKR45xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d5KCJ2ZbpzmVZk;
	Tue, 11 Nov 2025 16:17:32 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A63F14022E;
	Tue, 11 Nov 2025 16:19:11 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 16:19:10 +0800
Message-ID: <dab01bc8-d07a-0ba5-405c-1acf14dbe401@hisilicon.com>
Date: Tue, 11 Nov 2025 16:19:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/core: Prevent soft lockup during large user memory
 region cleanup
To: lirongqing <lirongqing@baidu.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20251111070107.2627-1-lirongqing@baidu.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20251111070107.2627-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/11/11 15:01, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When a process exits with numerous large, pinned memory regions consisting
> of 4KB pages, the cleanup of the memory region through __ib_umem_release()
> may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
> is called in a tight loop for unpin and releasing page without yielding the
> CPU.
> 
> Fix the soft lockup by adding cond_resched() calls in __ib_umem_release
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/core/umem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index c5b6863..70c1520 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -59,6 +59,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
>  
> +	cond_resched();

If the soft lockup is caused by unpin_user_page_range_dirty_lock(),
cond_resched() should probably be inside the for_each_sgtable_sg
loop.

Junxian

>  	sg_free_append_table(&umem->sgt_append);
>  }
>  

