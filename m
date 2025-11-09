Return-Path: <linux-rdma+bounces-14329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BEAC43A73
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22BC3AC542
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F2B2C15A5;
	Sun,  9 Nov 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcGEujvA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72A1A23AC
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679528; cv=none; b=UU68npy2NiOnvqbQLqCBBWdyOhD0QgSMtmFRvFd8kZEciPrO5FcDhNQQw5F+cS9mHkO0c59pYkMMOTOKhbw40jci995MYjgjOA8QgoFGxZIhHxpxotspSqFj983y7TxmELWCD7TC2JC6hXlHaV9bNRtyHN3tmwRqEWnuBqNApDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679528; c=relaxed/simple;
	bh=kBLtIPf8/P4akx0GFBtj1dFtp5pgWibOeKZ3jPEt5rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPLencYfwdxZOjRh6t7JktPzYamZFyac/dzCfx38xylHl68N7dwtr8gSwjCrVTnC0YdK8Z0/vd62L8kKw7dEwz9MSOHIbKmqJH8BuKRuak7tm3Y4vA4HZ9Frsk2cnZ/aurCF7U+lsBLq0f56FSGYwAS3MU54w6eehkSdyzkeWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcGEujvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A7CC2BCAF;
	Sun,  9 Nov 2025 09:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762679527;
	bh=kBLtIPf8/P4akx0GFBtj1dFtp5pgWibOeKZ3jPEt5rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcGEujvAYMS821QShIrYEY9rQFXmvi2p0qWMu0FGKWD1pbwuJO6t7CjOTa7pM0ugY
	 dkayzkQAr895dMj61+cpLvbQdpr/13d6XY6krosagJSXHBA3TUIg/yc0Oo4Jix/KoX
	 eIHM3OSPS0aVi/m2VOLYRVyqAG6RDn45avfzu2FSmJtGn59aUmOlXrOl+KQVumwT6s
	 57OMG49ihn1bRRHHGpys6L9DxCPyqoA6LUOndAPPBIbQ2etnM7d4gatOnrm6wJ6jp4
	 9VbDoJHVjvGD2xXsXgMhp0TgS8UuLmAnOcKdq2xqYqmsmgwDz3+T4CwRlQpb3bCY/D
	 z5DVh1MpT5pLw==
Date: Sun, 9 Nov 2025 11:12:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 1/4] RDMA/bnxt_re: Move the UAPI methods to
 a dedicated file
Message-ID: <20251109091202.GF15456@unreal>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-2-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104072320.210596-2-sriharsha.basavapatna@broadcom.com>

On Tue, Nov 04, 2025 at 12:53:17PM +0530, Sriharsha Basavapatna wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> This is in preparation for upcoming patches in the series.
> Driver has to support additional UAPIs for Direct verbs.
> Moving current UAPI implementation to a new file, dv.c.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/Makefile   |   2 +-
>  drivers/infiniband/hw/bnxt_re/dv.c       | 356 +++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 305 +------------------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
>  4 files changed, 361 insertions(+), 305 deletions(-)
>  create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

<...>

> +++ b/drivers/infiniband/hw/bnxt_re/dv.c
> @@ -0,0 +1,356 @@
> +/*
> + * Broadcom NetXtreme-E RoCE driver.
> + *
> + * Copyright (c) 2025, Broadcom. All rights reserved.  The term
> + * Broadcom refers to Broadcom Inc. and/or its subsidiaries.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * BSD license below:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in
> + *    the documentation and/or other materials provided with the
> + *    distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> + * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
> + * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> + * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
> + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
> + * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * Description: Direct Verbs interpreter
> + */

Please remove all this boilerplate and use SPDX tag instead,

> +
> +#include <rdma/ib_addr.h>
> +#include <rdma/uverbs_types.h>
> +#include <rdma/uverbs_std_types.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
> +#define UVERBS_MODULE_NAME bnxt_re
> +#include <rdma/uverbs_named_ioctl.h>
> +#include <rdma/bnxt_re-abi.h>

<...>

> +	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
> +	if (IS_ERR(uctx))

This is can't be right, you should check ib_uverbs_get_ucontext() for
error first, before doing container_of().

> +		return PTR_ERR(uctx);

Thanks

