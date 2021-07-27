Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC223D74A2
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhG0L5O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 07:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhG0L5L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 07:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2BAD61414;
        Tue, 27 Jul 2021 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627387031;
        bh=j76F0Anp3FRmQECgPvcov+bjoLPDAERVJ9LmILXON0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SecaiQeo5ykM9LQu2AMv9iNXNyPx4WdXrLr7sOdw3MzLB0bOzAkMtLPlAK+Z5ipAi
         bNZoc91DnpnZ8ZZla6Qt2IaIrnLEKxup8sKAiLwUYWiSnHWHiQN7ijHwLJYfuOxucd
         B6UFWpkGuuXqEIjzHB8cymkzt3Wq4ssyxwjnqQxYB2bqRmgt/BS+g4slPO9xZAPxuY
         cNVgG9KuvlMmCblyyEQntLuDjh73zQFqm+kJeHuaTV/6OsaeKN9ny6jzMPyEkqsp2w
         elsyMKraOmPPEx4KnpYzMgZIE2+j5nMmdS3+hQgf6avG4T5K96Nr5wnHne/jeEn/Po
         iVL6CivAzrdOQ==
Date:   Tue, 27 Jul 2021 14:57:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v3 for-next 12/12] RDMA/hns: Dump detailed
 driver-specific UCTX
Message-ID: <YP/0ksOdlErAT9lh@unreal>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
 <1627356452-30564-13-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627356452-30564-13-git-send-email-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 11:27:32AM +0800, Wenpeng Liang wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Dump DCA mem pool status in UCTX restrack.
> 
> Sample output:
> $ rdma res show ctx dev hns_0 -dd
>  dev hns_0 ctxn 7 pid 1410 comm python3 drv_dca-loading 37.50 drv_dca-total 65536 drv_dca-free 40960
>  dev hns_0 ctxn 8 pid 1410 comm python3 drv_dca-loading 0.00 drv_dca-total 0 drv_dca-free 0
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
>  drivers/infiniband/hw/hns/hns_roce_restrack.c | 85 +++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)

<...>

> +static int hns_roce_fill_dca_uctx(struct hns_roce_dca_ctx *ctx,
> +				  struct sk_buff *msg)
> +{
> +	char tmp_str[LOADING_PERCENT_CHARS];
> +	unsigned long flags;
> +	u64 total, free;
> +	u64 percent;
> +	u32 rem = 0;
> +
> +	spin_lock_irqsave(&ctx->pool_lock, flags);
> +	total = ctx->total_size;
> +	free = ctx->free_size;
> +	spin_unlock_irqrestore(&ctx->pool_lock, flags);
> +
> +	percent = calc_dca_loading_percent(total, free, &rem);
> +	scnprintf(tmp_str, sizeof(tmp_str), "%llu.%0*u\n", percent,
> +		  LOADING_PERCENT_SHIFT, rem);
> +
> +	if (rdma_nl_put_driver_string(msg, "dca-loading", tmp_str))
> +		goto err;

Please no, users can calculate percentage by themselves. We don't need
to complicate kernel for it.

Thanks

> +
> +	if (rdma_nl_put_driver_u64(msg, "dca-total", total))
> +		goto err;
> +
> +	if (rdma_nl_put_driver_u64(msg, "dca-free", free))
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	return -EMSGSIZE;
> +}
> +
> +int hns_roce_fill_res_ctx_entry(struct sk_buff *msg, struct ib_ucontext *ctx)
> +{
> +	struct hns_roce_dev *hr_dev = to_hr_dev(ctx->device);
> +	struct hns_roce_ucontext *uctx = to_hr_ucontext(ctx);
> +	struct nlattr *table_attr;
> +
> +	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> +	if (!table_attr)
> +		goto err;
> +
> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE) {
> +		if (hns_roce_fill_dca_uctx(&uctx->dca_ctx, msg))
> +			goto err_cancel_table;
> +	}
> +
> +	nla_nest_end(msg, table_attr);
> +
> +	return 0;
> +
> +err_cancel_table:
> +	nla_nest_cancel(msg, table_attr);
> +err:
> +	return -EMSGSIZE;
> +
> +	return 0;
> +}
> -- 
> 2.8.1
> 
