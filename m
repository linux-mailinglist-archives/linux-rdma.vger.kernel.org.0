Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D93989FF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhFBMtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 08:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhFBMtt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 08:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1808E6121D;
        Wed,  2 Jun 2021 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622638086;
        bh=b1ugfBfncbpuw/DFAtLpa+sb5ONaeXnvcLucaD4kbuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9S0m1Ose/8KyEgStJ7jVt9RmjqYwHgMVH7D6gHbML1adbDNvdI5VL7hCRiIij1bI
         o5bRWJXbU5+BUCYuaPaTgAViL3hr+7J67BhDkHakaymwW0ro4//SbtZyCa5KKR19dC
         B1nz70axrFEjBr5rqHpq49ThWq7RifcfbJj8dsYw0ij8E9YLAAGV5lLENQsmZdzCgZ
         gBQ20ER4zPgJPz4bhC0WcOlR6+YTcOnGiWLGwF1vDlRVTvXLPVwoSc2tl/4s9GKALZ
         fsmqzPFrEGrrc3OnCyiOj3oh0hckDCwZJ95XHKAojS/YvVk6dG6bhHtT8iIOcyNaDt
         Q9mJMaa3sWa7Q==
Date:   Wed, 2 Jun 2021 15:48:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V4 for-next 1/3] RDMA/bnxt_re: Enable global atomic ops
 if platform supports
Message-ID: <YLd+AzGd2NhnVas6@unreal>
References: <20210602042839.968833-1-devesh.sharma@broadcom.com>
 <20210602042839.968833-2-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602042839.968833-2-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 09:58:37AM +0530, Devesh Sharma wrote:
> Enabling Atomic operations for Gen P5 devices if the underlying
> platform supports global atomic ops.
> 
> Fixes:7ff662b76167 ("Disable atomic capability on bnxt_re adapters")
       ^^^ space here

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
> index 3ca47004b752..d722ca5cd464 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -959,3 +959,20 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
>  	bnxt_qplib_free_res(res);
>  	return rc;
>  }
> +
> +bool bnxt_qplib_determine_atomics(struct pci_dev *dev)
> +{
> +	int comp;
> +	u16 ctl2;
> +
> +	comp = pci_enable_atomic_ops_to_root(dev,
> +					     PCI_EXP_DEVCAP2_ATOMIC_COMP32);
> +	if (comp)
> +		return -ENOTSUPP;
> +	comp = pci_enable_atomic_ops_to_root(dev,
> +					     PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	if (comp)
> +		return -ENOTSUPP;
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctl2);
> +	return !(ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
> +}
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 7a1ab38b95da..fb7fde4fed56 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -373,6 +373,7 @@ void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
>  int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
>  			 struct bnxt_qplib_ctx *ctx,
>  			 bool virt_fn, bool is_p5);
> +bool bnxt_qplib_determine_atomics(struct pci_dev *dev);
>  
>  static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
>  {
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 049b3576302b..57407be16f27 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -54,6 +54,17 @@ const struct bnxt_qplib_gid bnxt_qplib_gid_zero = {{ 0, 0, 0, 0, 0, 0, 0, 0,
>  
>  /* Device */
>  
> +static u8 bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
> +{
> +	u16 pcie_ctl2 = 0;
> +
> +	if (!bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
> +		return false;
> +
> +	pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
> +	return (pcie_ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ);
> +}
> +
>  static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
>  				     char *fw_ver)
>  {
> @@ -162,7 +173,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
>  		attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
>  	}
>  
> -	attr->is_atomic = false;
> +	attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
>  bail:
>  	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
>  	return rc;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> index bc228340684f..260104783691 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> @@ -42,8 +42,6 @@
>  
>  #define BNXT_QPLIB_RESERVED_QP_WRS	128
>  
> -#define PCI_EXP_DEVCTL2_ATOMIC_REQ      0x0040
> -
>  struct bnxt_qplib_dev_attr {
>  #define FW_VER_ARR_LEN			4
>  	u8				fw_ver[FW_VER_ARR_LEN];
> -- 
> 2.25.1
> 


