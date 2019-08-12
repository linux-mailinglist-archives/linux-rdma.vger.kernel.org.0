Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFEF896FE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 07:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfHLFw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 01:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfHLFw1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 01:52:27 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B522070C;
        Mon, 12 Aug 2019 05:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565589146;
        bh=lwjrFNiRVlxYY8eL4EjsKkgRTO2TS6xYQUAV1/FHCj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo5vFeJeE2r8MGuCyC5+m1GudhxMMLkucD8pJ0lnGAr3pDDPtXwCWZYMyxhCkUcy+
         tjvdXTpZ3Q6+fI+2PjExQLe82+hVBi2OSKvTohqTp4hmAH3z8IdEmRWveOwU5uunJK
         2c+9JVB0VBz+ARW9MtlqbWeglOXspaEbRuEValSA=
Date:   Mon, 12 Aug 2019 08:52:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 8/9] RDMA/hns: Kernel notify usr space to stop
 ring db
Message-ID: <20190812055220.GA8440@mtr-leonro.mtl.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-9-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565343666-73193-9-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 09, 2019 at 05:41:05PM +0800, Lijun Ou wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
>
> In the reset scenario, if the kernel receives the reset signal,
> it needs to notify the user space to stop ring doorbell.

I doubt about it, it is racy like hell and relies on assumption that
userspace will honor such request to stop.

>
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 52 ++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 +++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 22 ++++++------
>  4 files changed, 70 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 32465f5..be65fce 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -268,6 +268,8 @@ enum {
>
>  #define PAGE_ADDR_SHIFT				12
>
> +#define HNS_ROCE_IS_RESETTING			1
> +
>  struct hns_roce_uar {
>  	u64		pfn;
>  	unsigned long	index;
> @@ -1043,6 +1045,8 @@ struct hns_roce_dev {
>  	u32			odb_offset;
>  	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
>  	u32			tptr_size;	/* only for hw v1 */
> +	struct page		*reset_page; /* store reset state */
> +	void			*reset_kaddr; /* addr of reset page */
>  	const struct hns_roce_hw *hw;
>  	void			*priv;
>  	struct workqueue_struct *irq_workq;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index d33341e..138e5a8 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1867,17 +1867,49 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
>  			  link_tbl->table.map);
>  }
>
> +static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
> +{
> +	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!hr_dev->reset_page)
> +		return -ENOMEM;
> +
> +	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
> +	if (!hr_dev->reset_kaddr)
> +		goto err_with_vmap;
> +
> +	return 0;
> +
> +err_with_vmap:
> +	put_page(hr_dev->reset_page);

Are you sure that pages allocated with alloc_page() are released with put_page()?

I would say with high confidence that whole this patch is wrong.

Thanks
