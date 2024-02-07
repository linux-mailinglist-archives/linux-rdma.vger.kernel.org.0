Return-Path: <linux-rdma+bounces-945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D725F84C5A8
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 08:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B7128290F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB01F61C;
	Wed,  7 Feb 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ8mszpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0891F60B
	for <linux-rdma@vger.kernel.org>; Wed,  7 Feb 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291079; cv=none; b=Z16hiID+2yuSZZPu1/LG0dn21kdakDWAOSWe0i6gqpzY9b7nmB/N95lF7Qfg0Mb3iROjQrq955y4jp3UE/7/8OvI3xQfIwyMyhcIqfZFgJfZgMwmCsW8egZY1Tj5rZypwTD47Tio6Bawa52r3SAS8ZvWy33XC9GIU7F7IFXpD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291079; c=relaxed/simple;
	bh=Wihnwg2Bo2iw+oA2wPA2QIzqCKw1GB9k/GVZcpZ09xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW4Bm6AB7o7nj920M0P+bhWyXMiVXsaizrDsz2r9bJBNXqVYLpfc3gccsFRU1hX9/y1BVL5i91gemGPhDWYp0G2WYJQMPXuAQ9N+dwpQSAe5pWAseZ6FejOLb+/cXiN9sRUd+3jxjaDwt1OMI67/bQtmoleXidP6WWm47mozZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ8mszpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC8C433C7;
	Wed,  7 Feb 2024 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707291079;
	bh=Wihnwg2Bo2iw+oA2wPA2QIzqCKw1GB9k/GVZcpZ09xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZ8mszpFs7fpF7pofKV+yLqTizcOMTxNhcAfIgbUKF/GTk31BPBbXwErfa0VKPzgv
	 W+sGjB/7NCBuub2rnTZPrHyIrM9JxkQE57aj5SavtcRWu1V4tLBDCJepphjLEsnQlI
	 Vmrb7kwHEIEWwgvHyZlzRNTyCnxgH4urUfNzQklqs9xKDKoTLKzR50YEumaUtTEe/S
	 O/Y99Ahl2mNiEwH3p6NWychYyWtPYiyxXgl23sIQ8dW32HsGkRDnA2VkeSfRY3g6O5
	 f2e+tFc2taWd1RD5SrEkFio7iUpQukarmYo6ZbYlajJCgzgCwDEkPhI+6roFGI5gF1
	 z4eV2WZKs4Zxw==
Date: Wed, 7 Feb 2024 09:31:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error flow
Message-ID: <20240207073114.GA56027@unreal>
References: <20240206175449.1778317-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206175449.1778317-1-kheib@redhat.com>

On Tue, Feb 06, 2024 at 12:54:49PM -0500, Kamal Heib wrote:
> Avoid the following warning by making sure to call qedr_cleanup_user()
> in case qedr_init_user_queue() failed.

<...>

> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 7887a6786ed4..0943abd4de27 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1880,7 +1880,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
>  		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
>  					  ureq.rq_len, true, 0, alloc_and_init);
>  		if (rc)
> -			return rc;
> +			goto err1;

"goto err1" will cause to call to qedr_cleanup_user() which will call to qedr_free_pbl()
with qp->urq.pbl_tbl) which can be NULL.

Thanks

>  	}
>  
>  	memset(&in_params, 0, sizeof(in_params));
> -- 
> 2.43.0
> 
> 

