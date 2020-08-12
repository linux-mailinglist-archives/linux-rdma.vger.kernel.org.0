Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5324251F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Aug 2020 07:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLFw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Aug 2020 01:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgHLFw7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Aug 2020 01:52:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E97920768;
        Wed, 12 Aug 2020 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597211579;
        bh=0ybcVrNMKq+NEb0GlZ1DY8froaaLuRExbiJbZ3/87Ag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iACneFBb/uPnGIzGZp7dIM/4zjPhyz4KiXlvgq+VQ34WNMrrHnAT3VGVkHrc2yd7I
         S2Lx9N0b/uzh1ipwgQesBJ5ypu4h5BFHNcfF8xIacubrGeMUky2qblqgd/VZTKvQ3U
         fZ0JhlKK9fO5vOdO/R3SS5TKXfp+eDPiqpnIKAPA=
Date:   Wed, 12 Aug 2020 08:52:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 1/1] Address an issue with hardened user copy
Message-ID: <20200812055255.GI634816@unreal>
References: <20200811191457.6309-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811191457.6309-1-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 02:14:57PM -0500, Bob Pearson wrote:
> by copying to user space from the stack instead of slab cache.
> This affects the rdma_rxe driver causing a warning once per boot.
> The alternative is to ifigure out how to whitelist the xxx_qp struct

ifigure -> figure

> but this seems simple and clean.


We have multiple cases like this in the code, what is the error exactly?
And what is "hardened user copy"?

>
> ---

Signed-off-by is missing.

>  drivers/infiniband/core/uverbs_std_types_qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
> index 3bf8dcdfe7eb..2f8b14003b95 100644
> --- a/drivers/infiniband/core/uverbs_std_types_qp.c
> +++ b/drivers/infiniband/core/uverbs_std_types_qp.c
> @@ -98,6 +98,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>  	struct ib_device *device;
>  	u64 user_handle;
>  	int ret;
> +	int qp_num;
>
>  	ret = uverbs_copy_from_or_zero(&cap, attrs,
>  			       UVERBS_ATTR_CREATE_QP_CAP);
> @@ -293,9 +294,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>  	if (ret)
>  		return ret;
>
> +	/* copy from stack to avoid whitelisting issues */
> +	qp_num = qp->qp_num;
>  	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
> -			     &qp->qp_num,
> -			     sizeof(qp->qp_num));
> +			     &qp_num, sizeof(qp_num));
>
>  	return ret;
>  err_put:
> --
> 2.25.1
>
