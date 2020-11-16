Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D542B44ED
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKPNqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 08:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgKPNqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 08:46:51 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF7C2074B;
        Mon, 16 Nov 2020 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605534410;
        bh=4sq0RQYh/Mq/ggBMFam/ejSGQb0G4HTIm/4EqrEOCy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoAzCrPaBHj17PFd0cOkmk+Xtyw7B3qxa4bOerPJN4ziOq26XRuKgI0Q/BtAc6isS
         gb2yTRA4B1FGMhv2E3icgUhVphxM3Py1X5HfoOJQxJjVUdJEieyIoMTjqWsVmvWLIY
         9oQ96WgZin2SynYcVdnb5knZw/HJ/913H2gmHxwY=
Date:   Mon, 16 Nov 2020 15:46:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Message-ID: <20201116134645.GL47002@unreal>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605527919-48769-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> Stash is a mechanism that uses the core information carried by the ARM AXI
> bus to access the L3 cache. It can be used to improve the performance by
> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
>  4 files changed, 39 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> index f5669ff..8d96c4e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> @@ -53,6 +53,18 @@
>  #define roce_set_bit(origin, shift, val) \
>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>
> +#define FIELD_LOC(field_h, field_l) field_h, field_l
> +
> +#define _hr_reg_set(arr, field_h, field_l)                                     \
> +	do {                                                                   \
> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
> +		(arr)[(field_h) / 32] |=                                       \
> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
> +	} while (0)
> +
> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)

I afraid that it is too much.
1. FIELD_LOC() macro to hide two fields.
2. hr_reg_set and  _hr_reg_set are the same.
3. In both patches field_h and field_l are the same.
4. "do {} while (0)" without need.

Thanks
