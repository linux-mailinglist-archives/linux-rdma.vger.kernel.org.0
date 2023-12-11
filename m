Return-Path: <linux-rdma+bounces-345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B8280C2BF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 09:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A891F20F7C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F220B27;
	Mon, 11 Dec 2023 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpPKx/ts"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EE20B19
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 08:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5FCC433C7;
	Mon, 11 Dec 2023 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702282236;
	bh=U009T3co86A+jFzx1dykHYacYEb0/TBK54kBhbBL8ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpPKx/tsGtNwHgKD48dn0vN7l8x7yl4ksyVUCMWqFKkrtscpqozkgmMEQC29mEyu4
	 37NVlx/QGdDg6mo88gfOh2UEpwUIkk2ynvbOPF72PwS7b03flYnsZyHUIm9i7pNUsu
	 217HtX8N06BR2uvHVu45FCy4/PKKKD8RlYhzejLi+DA+Pzm20W/sdjN6OPt4tFmQ+V
	 2wsFM+8dux7OQ95MKLfhyTDz4Qjer+mJ8N0CYbM/VRhapmPDUfCC9PK1v7v8ieuXi+
	 QA0uLR7S7Nkg4fL5IgjE2jpaKMoa+XLvQMpZR75e2Z4AZJOuGIfWZs2XT+sCCDGyJb
	 2u4jVURhBPaZw==
Date: Mon, 11 Dec 2023 10:10:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Add EFA query MR support
Message-ID: <20231211081032.GB4870@unreal>
References: <20231207142748.10345-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207142748.10345-1-mrgolin@amazon.com>

On Thu, Dec 07, 2023 at 02:27:48PM +0000, Michael Margolin wrote:
> Add EFA driver uapi definitions and register a new query MR method that
> currently returns the physical PCI buses' IDs the device is using to
> reach the MR. Update admin definitions and efa-abi accordingly.
> 
> Reviewed-by: Anas Mousa <anasmous@amazon.com>
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h               |  5 +-
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 ++++++++
>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  6 ++
>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  4 +
>  drivers/infiniband/hw/efa/efa_main.c          |  5 ++
>  drivers/infiniband/hw/efa/efa_verbs.c         | 77 +++++++++++++++++++
>  include/uapi/rdma/efa-abi.h                   | 19 +++++
>  7 files changed, 146 insertions(+), 1 deletion(-)

<...>

> +	/*
> +	 * Mask indicating which fields have valid values
> +	 * 0 : recv_pci_bus_id
> +	 * 1 : rdma_read_pci_bus_id
> +	 * 2 : rdma_recv_pci_bus_id
> +	 */
> +	u8 validity;

<...>

>  #define EFA_GID_SIZE 16
> +#define EFA_INVALID_PCI_BUS_ID 0xffff

Is 0xffff value guaranteed by PCI subsystem to be invalid? Why don't you
provide "validity" field to userspace instead?

Thanks

