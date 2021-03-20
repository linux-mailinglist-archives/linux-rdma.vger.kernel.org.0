Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89640342BAF
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCTLM3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Mar 2021 07:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCTLMK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80821619A7;
        Sat, 20 Mar 2021 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616232783;
        bh=/t1RIX+R7Yy5xSs7oiJc4GBhIwgItMLmy+RTD4RbXP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2yZ0U83HIKgeLClx3c87/+WGCgT4DcEYRzlV5vlJjWyTbvqJTuj39p/lr0iz01pB
         X2a4KCHFaxa5wWLAHZOjzA82mz/L2EoRJc7eFPNQS4fGk9CIM0mzmsiSDG8eQgy+71
         3bbq4C7zNQYmKurgXiwm+pv/3oB1s4+Rw3Da1FCPxzoicFFuFHZaFArotiPQoNi5ps
         4/1W2KezPf4X0dToRB0aMTQNvDJQIfiWoM8pNXdGRTmhb6y1/CdLvdBILxe1UTiTN8
         W3gaCVstChfg9EG7QAtfzyUI5xjSdAx5KLJMCshvpbvT23B88c0GJg8pwJv1LVs+zj
         y3Jvkqzhj0i4w==
Date:   Sat, 20 Mar 2021 11:32:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Fix memory corruption when allocating
 XRCDN
Message-ID: <YFXBSyUI/J8uMoxH@unreal>
References: <1616143536-24874-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616143536-24874-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 04:45:36PM +0800, Weihang Li wrote:
> It's incorrect to cast the type of pointer to xrcdn from (u32 *) to
> (unsigned long *), then pass it into hns_roce_bitmap_alloc(), this will
> lead to a memory corruption.
> 
> Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_pd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
> index 3ca51ce..16d6b69 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_pd.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
> @@ -140,8 +140,14 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
>  
>  static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
>  {
> -	return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
> -				     (unsigned long *)xrcdn);
> +	unsigned long obj;
> +	int ret;
> +
> +	ret = hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, &obj);
> +
> +	*xrcdn = (u32)obj;

NIT, it will be safer if you don't set set xrcdn after hns_roce_bitmap_alloc() failed.

Thanks

> +
> +	return ret;
>  }
>  
>  static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
> -- 
> 2.8.1
> 
