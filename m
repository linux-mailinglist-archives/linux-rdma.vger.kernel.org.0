Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B143216580
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 06:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGGEpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 00:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgGGEpX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 00:45:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416F520722;
        Tue,  7 Jul 2020 04:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594097122;
        bh=Smu4vU6x/gfF1uuZL8wjEYy4f7mtHyg2YFq9A4xr24E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS2CZMURMPhozlQiTpsMcl5HpdeO8/SnR4svxguhX+o0zSQfYSxZw4SXKSzJfB86Q
         zjn+XBaov7UsnFhl/sVTCppxcW0gpXXpJogFOCLa9VPQRIPk955rf7gbOr9i7F9DGX
         3BFTh+q55Puuog2waENLGT8gSmAUDvRj5AZTbPaM=
Date:   Tue, 7 Jul 2020 07:45:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, aelior@marvell.com,
        ybason@marvell.com, mkalderon@marvell.com,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v2 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Message-ID: <20200707044519.GJ207186@unreal>
References: <20200706193214.19942-1-michal.kalderon@marvell.com>
 <20200706193214.19942-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706193214.19942-3-michal.kalderon@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 10:32:14PM +0300, Michal Kalderon wrote:
> User space should receive the maximum edpm size from kernel
> driver, similar to other edpm/ldpm related limits.
> Add an additional parameter to the alloc_ucontext_resp
> structure for the edpm maximum size.
>
> In addition, pass an indication from user-space to kernel
> (and not just kernel to user) that the DPM sizes are supported.
>
> This is for supporting backward-forward compatibility between driver and
> lib for everything related to DPM transaction and limit sizes.
>
> This should have been part of commit mentioned in Fixes tag.
> Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for dpm
> enabled mode")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
>  include/uapi/rdma/qedr-abi.h       | 6 +++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index fbb0c66c7f2c..f03178866b50 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
>  				  QEDR_DPM_TYPE_ROCE_LEGACY |
>  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
>
> -	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
> -	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
> -	uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
> +	if (!!(ureq.context_flags & QEDR_SUPPORT_DPM_SIZES)) {

"!!" is not needed here.

Thanks

> +		uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
> +		uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
> +		uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
> +		uresp.edpm_limit_size = QEDR_EDPM_MAX_SIZE;
> +	}
>
>  	uresp.wids_enabled = 1;
>  	uresp.wid_count = oparams.wid_count;
> diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
> index b261c9fca07b..bf7333b2b5d7 100644
> --- a/include/uapi/rdma/qedr-abi.h
> +++ b/include/uapi/rdma/qedr-abi.h
> @@ -40,7 +40,8 @@
>  /* user kernel communication data structures. */
>  enum qedr_alloc_ucontext_flags {
>  	QEDR_ALLOC_UCTX_EDPM_MODE	= 1 << 0,
> -	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1
> +	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1,
> +	QEDR_SUPPORT_DPM_SIZES		= 1 << 2,
>  };
>
>  struct qedr_alloc_ucontext_req {
> @@ -50,6 +51,7 @@ struct qedr_alloc_ucontext_req {
>
>  #define QEDR_LDPM_MAX_SIZE	(8192)
>  #define QEDR_EDPM_TRANS_SIZE	(64)
> +#define QEDR_EDPM_MAX_SIZE	(ROCE_REQ_MAX_INLINE_DATA_SIZE)
>
>  enum qedr_rdma_dpm_type {
>  	QEDR_DPM_TYPE_NONE		= 0,
> @@ -77,6 +79,8 @@ struct qedr_alloc_ucontext_resp {
>  	__u16 ldpm_limit_size;
>  	__u8 edpm_trans_size;
>  	__u8 reserved;
> +	__u16 edpm_limit_size;
> +	__u8 padding[6];
>  };
>
>  struct qedr_alloc_pd_ureq {
> --
> 2.14.5
>
