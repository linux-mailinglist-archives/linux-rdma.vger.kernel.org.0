Return-Path: <linux-rdma+bounces-11793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31260AEF544
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172FA3AE7E7
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD326D4E9;
	Tue,  1 Jul 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeOqMyNG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F91DED52;
	Tue,  1 Jul 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366329; cv=none; b=e7uE4jpNnG3A91/3bF8ZB9ui8ZcAQ++3CEu6w0Ueu4R7qre9CT+GLq2Kozzj6jCVKRPnoSIrL0p0s1U/Kvh06dy199J6obulyPiNuUDMDZHrVqYCC3QWTCHkNezxOhrqBWlVvHlZ/WDS1d3nVVzqmbKvm3QZCBXxnDR3zfoofAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366329; c=relaxed/simple;
	bh=yPNa7uEfUMjgDyJRDFdMre2nt/VrGx/fqW5DHixzKC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts5Dl/ZGW0SVODhAyMsjQFEt+aIiXBkCFla+L3auxRr5zdkMVSNbei2TNt4rGNPbwuaABvJ/c+nZiRKpa6HUGmp9Z0dcdApiJpwi9tcVptLLz30AGNyjU47mUGRI5d/g9ZEaaXeaFtVcKxTDS+dZb/ZmoTH91Qu7tMeY/W1uGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeOqMyNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E25C4CEEB;
	Tue,  1 Jul 2025 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366328;
	bh=yPNa7uEfUMjgDyJRDFdMre2nt/VrGx/fqW5DHixzKC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeOqMyNGI8+KkXU73chcalCuVbwdpK5eeKEPc+y+kpK77IzclAvE0yQEs/xgwW2SC
	 iw/sC2kNd5uE4690zw8PXGfLakcfRhwWSdojnl/tCXQOYRLRmXmss89B0irt2TueEX
	 NWNqpD/tJRQhvo6sB+4+vBwzGrs4dBR3sArwMdkFcXvO8vUpH9oze0/Bb9cNRHgcvD
	 THC4V2Unf+P6KrvwJ67/amGe3neg9rK1l3PEKFUANAeB2nka5k2Ifstg8JJFzWs5Ow
	 klClJfAfAQpVnhNioayHgTMlreRepAwbJGdZBrQ6t5cfslf9d0U0rZjQ8/MWVF4HAP
	 CrzQQ6Jk0eiiA==
Date: Tue, 1 Jul 2025 13:38:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250701103844.GB118736@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121315.739049-11-abhijit.gangurde@amd.com>

On Tue, Jun 24, 2025 at 05:43:11PM +0530, Abhijit Gangurde wrote:
> Implement device supported verb APIs for control path.
> 
> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v2->v3
>   - Registered main ib ops at once
>   - Removed uverbs_cmd_mask
>   - Removed uverbs_cmd_mask
>   - Used rdma_user_mmap_* APIs for mappings
>   - Removed rw locks around xarrays
>   - Fixed sparse checks
> 
>  drivers/infiniband/hw/ionic/ionic_admin.c     |  101 +
>  .../infiniband/hw/ionic/ionic_controlpath.c   | 2530 +++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_fw.h        |  717 +++++
>  drivers/infiniband/hw/ionic/ionic_ibdev.c     |   44 +
>  drivers/infiniband/hw/ionic/ionic_ibdev.h     |  249 +-
>  drivers/infiniband/hw/ionic/ionic_pgtbl.c     |   19 +
>  include/uapi/rdma/ionic-abi.h                 |  115 +
>  7 files changed, 3767 insertions(+), 8 deletions(-)
>  create mode 100644 include/uapi/rdma/ionic-abi.h

<...>

> +static void ionic_flush_qs(struct ionic_ibdev *dev)
> +{
> +	struct ionic_qp *qp, *qp_tmp;
> +	struct ionic_cq *cq, *cq_tmp;
> +	LIST_HEAD(flush_list);
> +	unsigned long index;
> +
> +	/* Flush qp send and recv */
> +	rcu_read_lock();
> +	xa_for_each(&dev->qp_tbl, index, qp) {
> +		kref_get(&qp->qp_kref);
> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> +	}
> +	rcu_read_unlock();

Same question as for CQ. What does RCU lock protect here?

> +
> +	list_for_each_entry_safe(qp, qp_tmp, &flush_list, ibkill_flush_ent) {
> +		ionic_flush_qp(dev, qp);
> +		kref_put(&qp->qp_kref, ionic_qp_complete);
> +		list_del(&qp->ibkill_flush_ent);
> +	}

<...>

> +err_buf:
> +err_hdr:

Please don't use empty goto labels.

> +	return rc;
> +}

<...>

> +#define IONIC_ABI_VERSION	4

For us it is 1.

Thanks

