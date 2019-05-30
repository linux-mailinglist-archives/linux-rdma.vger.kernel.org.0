Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C405302DB
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfE3Te6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 15:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3Te6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 15:34:58 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4AA260EE;
        Thu, 30 May 2019 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559244897;
        bh=tRidG2IIyKqQpinWpBGW3dxCyZKFrhDk2UZMcNO+jXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9l3wQ9mzre3wQKIc9W30v/O3I+/0joqaQrfuqTFcTtyBVUnEo1Wb12qzXIDwhsJD
         erz00FBTF5q2JHqkyJc1eHOKtlOeGzaAe+56m8JTjb3Tr7ikRHiU9V8bJOgJsW5cGb
         Z+/ORR8RYmSYuzjlJkGhbc17KdprNjMOKU3t+HtM=
Date:   Thu, 30 May 2019 22:34:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V3 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190530193451.GE5768@mtr-leonro.mtl.com>
References: <1559231276-67517-1-git-send-email-oulijun@huawei.com>
 <1559231276-67517-2-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559231276-67517-2-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 11:47:54PM +0800, Lijun Ou wrote:
> Currently, the MTT(memory translate table) design required a buffer
> space must has the same hopnum, but the hip08 hw can support mixed
> hopnum config in a buffer space.
>
> This patch adds the MTR(memory translate region) design for supporting
> mixed multihop.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  36 +++
>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 467 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 +++++++
>  4 files changed, 638 insertions(+)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index d6e8b44..720be44 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -341,6 +341,29 @@ struct hns_roce_mtt {
>  	enum hns_roce_mtt_type	mtt_type;
>  };
>
> +struct hns_roce_buf_region {
> +	int offset; /* page offset */
> +	u32 count; /* page count*/
> +	int hopnum; /* addressing hop num */
> +};
> +
> +#define HNS_ROCE_MAX_BT_REGION	3
> +#define HNS_ROCE_MAX_BT_LEVEL	3
> +struct hns_roce_hem_list {
> +	struct list_head root_bt;
> +	/* link all bt dma mem by hop config */
> +	struct list_head mid_bt[HNS_ROCE_MAX_BT_REGION][HNS_ROCE_MAX_BT_LEVEL];
> +	struct list_head btm_bt; /* link all bottom bt in @mid_bt */
> +	dma_addr_t root_ba; /* pointer to the root ba table */
> +	int bt_pg_shift;
> +};
> +
> +/* memory translate region */
> +struct hns_roce_mtr {
> +	struct hns_roce_hem_list hem_list;
> +	int buf_pg_shift;
> +};
> +
>  struct hns_roce_mw {
>  	struct ib_mw		ibmw;
>  	u32			pdn;
> @@ -1111,6 +1134,19 @@ void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev,
>  int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
>  			   struct hns_roce_mtt *mtt, struct hns_roce_buf *buf);
>
> +void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
> +		       int buf_pg_shift);
> +int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
> +			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
> +			int region_cnt);
> +void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
> +			  struct hns_roce_mtr *mtr);
> +
> +/* hns roce hw need current block and next block addr from mtt */
> +#define MTT_MIN_COUNT	 2
> +int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
> +		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
> +
>  int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
>  int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
>  int hns_roce_init_eq_table(struct hns_roce_dev *hr_dev);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> index 157c84a..d758e95 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -1157,3 +1157,470 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
>  					   &hr_dev->mr_table.mtt_cqe_table);
>  	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtt_table);
>  }
> +
> +struct roce_hem_item {
> +	struct list_head list; /* link all hems in the same bt level */
> +	struct list_head sibling; /* link all hems in last hop for mtt */
> +	void *addr;
> +	dma_addr_t dma_addr;
> +	size_t count; /* max ba numbers */
> +	int start; /* start buf offset in this hem */
> +	int end; /* end buf offset in this hem */
> +};
> +
> +#define hem_list_for_each(pos, n, head) \
> +		list_for_each_entry_safe(pos, n, head, list)
> +
> +#define hem_list_del_item(hem)		list_del(&hem->list)
> +#define hem_list_add_item(hem, head)	list_add(&hem->list, head)
> +#define hem_list_link_item(hem, head)	list_add(&hem->sibling, head)
> +

Please don't obfuscate kernel primitives, it hurts both readability and
possible refactoring.

Thanks
