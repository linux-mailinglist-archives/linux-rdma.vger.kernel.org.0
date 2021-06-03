Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4939A1C5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCNGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 09:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhFCNGD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 09:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C9F6601FA;
        Thu,  3 Jun 2021 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622725459;
        bh=9OmY3x3ItIVZ7LqEBGM9yDAJrhOSsswmfLM51oWkQpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCSAJUWiXP9hajE/frFB848NzL67xwg4zPLjwtAKcVti+J4sUfPHBQ17y+hdzuOvO
         W9zVnHQu+3HC+gPnYQXyOGCasclb26CaoZFKGvaGxFot6eahVmtdZr4mnAmyxWk6rJ
         kKqR6okfyu7cTk7DjsudoHy/x/WZcqs+j3viqmpojUUc3j6AesoJjw/R2GoUj1dxVH
         3/VOwXbl85yoNPRHuxifShaIJ6yG3LDf2828SAu632U8yNwKbdDN3UrzMYH7H4rAhD
         PxszkqZkGolbuI4D/wItY8SQOxZaSxyEaTfv6amO0d/z8IGclBSeYv/PzU9V1T0V9B
         GQ0RmbaaB2tcQ==
Date:   Thu, 3 Jun 2021 16:04:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V6 for-next 1/3] RDMA/bnxt_re: Enable global atomic ops
 if platform supports
Message-ID: <YLjTTzw2L1hLj/vf@unreal>
References: <20210603103057.980996-1-devesh.sharma@broadcom.com>
 <20210603103057.980996-2-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603103057.980996-2-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 04:00:55PM +0530, Devesh Sharma wrote:
> Enabling Atomic operations for Gen P5 devices if the underlying
> platform supports global atomic ops.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
>  drivers/infiniband/hw/bnxt_re/main.c      |  3 +++
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 +++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
>  6 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 537471ffaa79..a113d8d9e9ed 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -163,6 +163,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
>  	ib_attr->max_qp_init_rd_atom = dev_attr->max_qp_init_rd_atom;
>  	ib_attr->atomic_cap = IB_ATOMIC_NONE;
>  	ib_attr->masked_atomic_cap = IB_ATOMIC_NONE;
> +	if (dev_attr->is_atomic) {
> +		ib_attr->atomic_cap = IB_ATOMIC_GLOB;
> +		ib_attr->masked_atomic_cap = IB_ATOMIC_GLOB;
> +	}
>  
>  	ib_attr->max_ee_rd_atom = 0;
>  	ib_attr->max_res_rd_atom = 0;
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index b090dfa4f4cb..0de4e22f9750 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -128,6 +128,9 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
>  	rdev->rcfw.res = &rdev->qplib_res;
>  
>  	bnxt_re_set_drv_mode(rdev, wqe_mode);
> +	if (bnxt_qplib_determine_atomics(en_dev->pdev))
> +		ibdev_info(&rdev->ibdev,
> +			   "platform doesn't support global atomics.");
>  	return 0;
>  }
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index 3ca47004b752..108a591e66ff 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -959,3 +959,20 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
>  	bnxt_qplib_free_res(res);
>  	return rc;
>  }
> +
> +int bnxt_qplib_determine_atomics(struct pci_dev *dev)
> +{
> +	int comp;
> +	u16 ctl2;
> +
> +	comp = pci_enable_atomic_ops_to_root(dev,
> +					     PCI_EXP_DEVCAP2_ATOMIC_COMP32);
> +	if (comp)
> +		return -ENOTSUPP;

I would say that it needs to be EOPNOTSUPP, not critical.

> +	comp = pci_enable_atomic_ops_to_root(dev,
> +					     PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	if (comp)
> +		return -ENOTSUPP;

Thanks
