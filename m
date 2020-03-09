Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC51217E325
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIPKh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 11:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgCIPKh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 11:10:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0DE20873;
        Mon,  9 Mar 2020 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583766636;
        bh=dO4tKcDtwcaUmfaL0PsDGw1tex5sOVZlYHK2eiJBC/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laOfv6Dpb+O4qhVRNTPZLYoX9w3EPpZNnU9vFl3RbPEaPzLKKiM6gzohjjiUNLl79
         BjfwCGTEcwWOxpkHD9z4yCPiHscngH4fM4G6pY97SU47GKCQzusTers9+U4nMZDdtz
         YKYLeQiczhibic1hdTdkIzThrysXxdAZwE8LdiFQ=
Date:   Mon, 9 Mar 2020 17:10:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Message-ID: <20200309151030.GC172334@unreal>
References: <1583462694-43908-1-git-send-email-liweihang@huawei.com>
 <1583462694-43908-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583462694-43908-5-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 06, 2020 at 10:44:53AM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
>
> Currently, before the qp is created, a page size needs to be calculated for
> the base address table to store all base addresses in the mtr. As a result,
> the parameter configuration of the mtr is complex. So integrate the process
> of calculating the base table page size into the hem related interface to
> simplify the process of using mtr.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  4 ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 16 +++++++----
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 42 +++++++----------------------
>  3 files changed, 21 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index b6ae12d..f6b3cf6 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -669,10 +669,6 @@ struct hns_roce_qp {
>  	struct ib_umem		*umem;
>  	struct hns_roce_mtt	mtt;
>  	struct hns_roce_mtr	mtr;
> -
> -	/* this define must less than HNS_ROCE_MAX_BT_REGION */
> -#define HNS_ROCE_WQE_REGION_MAX	 3
> -	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX];
>  	int                     wqe_bt_pg_shift;
>
>  	u32			buff_size;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> index e822157..8380d71 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -1383,6 +1383,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
>  	void *cpu_base;
>  	u64 phy_base;
>  	int ret = 0;
> +	int ba_num;
>  	int offset;
>  	int total;
>  	int step;
> @@ -1393,12 +1394,16 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
>  	if (root_hem)
>  		return 0;
>
> +	ba_num = hns_roce_hem_list_calc_root_ba(regions, region_cnt, unit);
> +	if (ba_num < 1)
> +		return -ENOMEM;
> +
>  	INIT_LIST_HEAD(&temp_root);
> -	total = r->offset;
> +	offset = r->offset;
>  	/* indicate to last region */
>  	r = &regions[region_cnt - 1];
> -	root_hem = hem_list_alloc_item(hr_dev, total, r->offset + r->count - 1,
> -				       unit, true, 0);
> +	root_hem = hem_list_alloc_item(hr_dev, offset, r->offset + r->count - 1,
> +				       ba_num, true, 0);
>  	if (!root_hem)
>  		return -ENOMEM;
>  	list_add(&root_hem->list, &temp_root);
> @@ -1410,7 +1415,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
>  		INIT_LIST_HEAD(&temp_list[i]);
>
>  	total = 0;
> -	for (i = 0; i < region_cnt && total < unit; i++) {
> +	for (i = 0; i < region_cnt && total < ba_num; i++) {
>  		r = &regions[i];
>  		if (!r->count)
>  			continue;
> @@ -1443,7 +1448,8 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
>  			/* if exist mid bt, link L1 to L0 */
>  			list_for_each_entry_safe(hem, temp_hem,
>  					  &hem_list->mid_bt[i][1], list) {
> -				offset = hem->start / step * BA_BYTE_LEN;
> +				offset = (hem->start - r->offset) / step *
> +					  BA_BYTE_LEN;
>  				hem_list_link_bt(hr_dev, cpu_base + offset,
>  						 hem->dma_addr);
>  				total++;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index c2ea489..1c5de2b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -579,30 +579,6 @@ static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
>  	return region_cnt;
>  }
>
> -static int calc_wqe_bt_page_shift(struct hns_roce_dev *hr_dev,
> -				  struct hns_roce_buf_region *regions,
> -				  int region_cnt)
> -{
> -	int bt_pg_shift;
> -	int ba_num;
> -	int ret;
> -
> -	bt_pg_shift = PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz;
> -
> -	/* all root ba entries must in one bt page */
> -	do {
> -		ba_num = (1 << bt_pg_shift) / BA_BYTE_LEN;
> -		ret = hns_roce_hem_list_calc_root_ba(regions, region_cnt,
> -						     ba_num);
> -		if (ret <= ba_num)
> -			break;
> -
> -		bt_pg_shift++;
> -	} while (ret > ba_num);
> -
> -	return bt_pg_shift - PAGE_SHIFT;
> -}
> -
>  static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
>  				struct hns_roce_qp *hr_qp)
>  {
> @@ -768,7 +744,10 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
>  static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  		       u32 page_shift, bool is_user)
>  {
> -	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
> +/* WQE buffer include 3 parts: SQ, extend SGE and RQ. */
> +#define HNS_ROCE_WQE_REGION_MAX	 3
> +	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX] = {};
> +	dma_addr_t *buf_list[HNS_ROCE_WQE_REGION_MAX] = { NULL };

Nitpick, NULL is not needed.

Thanks
