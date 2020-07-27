Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A422EA67
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgG0Kvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 06:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0Kvk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 06:51:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8BC2070B;
        Mon, 27 Jul 2020 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595847099;
        bh=YctOa3sggLgVLAGPd5DwpeBpy/wU+Ru8/wsFY2/uXRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRxjWO432K42EogCi2Zeb/5855bwHULy0OEXuentNpgP7RtgwEqml3jeDWW+f1wn7
         XS77idA1gtvpcTcvkvilCljfqgtMSPUDkgaLF2JtMXJyKNQFnTDczk8HiZlMKZGcYe
         6P8odH8S3JtZyrkViON+IJz1OaXhlUnnht7L5FZI=
Date:   Mon, 27 Jul 2020 13:51:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/7] RDMA/hns: Refactor hns_roce_v2_set_hem()
Message-ID: <20200727105135.GC75549@unreal>
References: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
 <1595837449-29193-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595837449-29193-3-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 27, 2020 at 04:10:44PM +0800, Weihang Li wrote:
> The parts about preparing and sending mailbox to hardware is not strongly
> related to other codes in hns_roce_v2_set_hem(), and can be encapsulated
> into a separate function.
>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 45 +++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 35d46b7..0eab92a 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -3373,11 +3373,33 @@ static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
>  	return op + step_idx;
>  }
>
> +static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj, u64 bt_ba,
> +			 u32 hem_type, int step_idx)
> +{
> +	struct hns_roce_cmd_mailbox *mailbox;
> +	int ret;
> +	int op;
> +
> +	op = get_op_for_set_hem(hr_dev, hem_type, step_idx);
> +	if (op == -EINVAL)
> +		return 0;

It is not how we write error checks "if (op < 0) return 0;"

Thanks
