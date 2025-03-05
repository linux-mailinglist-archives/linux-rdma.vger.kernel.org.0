Return-Path: <linux-rdma+bounces-8356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB2A4FDE2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B833B7A6F50
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6681233733;
	Wed,  5 Mar 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz7ipSLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AA1F416D
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174872; cv=none; b=bT+w/KnJtGM5yhHBsyS4OphB74vxJTEUHqlAf7ws1LtImjgxyLd9zUPIE/wNtmaA/rR5lQegfEBsFJ2Oa52KDjEG/gDURfI8Eepv3KODanHFwvd0bbSd/4lR1jEHFSUOowL7mq9uVPeD40xjTgc79x/ogYDJa6OBNcX8jbvzhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174872; c=relaxed/simple;
	bh=Wx0HHw56wlhCOt+i6pGfAaykI+OE/Zsqtu3dQLR9vu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEGBbi1CxsPSeTuOFaBeh1UisYV/PnCm1CcP/+dMv9G3PxT0VJcXa+oikhoq4f6lJ+J+5Ilh2pPf6x33EDAiWVAuu1EOAozOa/PAGivGuf77Siv3V5wDHLqDksaq3msocR1YIR93dQKTJZzJCP3N6w8M4xud2gMrhz37/E2qERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz7ipSLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F9C4CEE2;
	Wed,  5 Mar 2025 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174871;
	bh=Wx0HHw56wlhCOt+i6pGfAaykI+OE/Zsqtu3dQLR9vu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz7ipSLamFJ0Nk2x8h2EV//CWLXKMpu96CkB3TYvTz4z1J9stSuSDHL0FHSI2X3id
	 IsDPXSRPQZcP7mJOG0odc/4MzIPpPRfM0CK2r9J+E/qMS2ZgT/nXs5H+Oo6l/HTyua
	 rVOZvZOndeMha99/+W7d8hIfcutqrMV6mhFwU/8RxcvDlSodGH1VJumEkEhHtrZKwU
	 gaEMlCZGWmx5J+HCwqd1v7DhGOv2EbNBf6J5WllMxH7Z0atxppqfeXngiyTC0TgrLe
	 Vghi2wApixAG1WwgAQnTvycBCMnCdlC7pvAK9KBRL2SJVdWZqEg4GVXqKQC3sXg9RU
	 ct+G+4pKohapA==
Date: Wed, 5 Mar 2025 13:41:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250305114107.GJ1955273@unreal>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>

On Wed, Feb 26, 2025 at 04:17:27PM +0200, Leon Romanovsky wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Implement a new User CAPabilities (UCAP) API to provide fine-grained
> control over specific firmware features.
> 
> This approach offers more granular capabilities than the existing Linux
> capabilities, which may be too generic for certain FW features.
> 
> This mechanism represents each capability as a character device with
> root read-write access. Root processes can grant users special
> privileges by allowing access to these character devices (e.g., using
> chown).
> 
> UCAP character devices are located in /dev/infiniband and the class path
> is /sys/class/infiniband_ucaps.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/core/Makefile      |   3 +-
>  drivers/infiniband/core/ucaps.c       | 255 ++++++++++++++++++++++++++
>  drivers/infiniband/core/uverbs_main.c |   2 +
>  include/rdma/ib_ucaps.h               |  25 +++
>  4 files changed, 284 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/core/ucaps.c
>  create mode 100644 include/rdma/ib_ucaps.h

<...>

> +/**
> + * ib_remove_ucap - Remove a ucap character device
> + * @type: User cap type
> + *
> + * Removes the ucap character device according to type. The device is completely
> + * removed from the filesystem when its reference count reaches 0.
> + */
> +void ib_remove_ucap(enum rdma_user_cap type)
> +{
> +	struct ib_ucap *ucap;
> +
> +	mutex_lock(&ucaps_mutex);
> +	ucap = ucaps_list[type];
> +	if (WARN_ON(!ucap))
> +		goto end;
> +
> +	ucap->refcount--;
> +	if (ucap->refcount)
> +		goto end;
> +
> +	ucaps_list[type] = NULL;
> +	cdev_device_del(&ucap->cdev, &ucap->dev);
> +	put_device(&ucap->dev);

This is kref release pattern, please use it.

> +
> +end:
> +	mutex_unlock(&ucaps_mutex);
> +}
> +EXPORT_SYMBOL(ib_remove_ucap);

Thanks

