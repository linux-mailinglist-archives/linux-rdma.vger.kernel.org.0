Return-Path: <linux-rdma+bounces-10129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6CAAF138
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 04:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE551B68ADD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5F1DE4F3;
	Thu,  8 May 2025 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwZCzMS9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5571D5AD4;
	Thu,  8 May 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672191; cv=none; b=dQv/WtoCE+xAQJDnEldrFifSUkSz1BvTp5ev6khLwEV9ansA2BDkLsji2FJylQwZfhzuJQ2nM90ssA2spf/P5fcMDrTYwcWk9WQyTD3UzKe0IgJ6/Spk59XizOLXUBrXMn+sriym1ngEvVMXzriRsMdXcdH/aJTTvJHkXJKHUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672191; c=relaxed/simple;
	bh=QHIqGXwRiR2ss8hlVa4na7pnGZlFNP0+0NJi8rMzu14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce8YidbABls1D2GJHQAL+ZcAMS5Gz2eHWU5FTWCc9Akn6VSE8VPZ0H99QkjOSQqfWBif3ixrAXEqzTmEM1R+rCxVWm1jMgeYZXhYRSxZrCvQUV4jZK6earRhOaq/hRRqdwWPaoBVF+UXiMxjWiyVI37Hp85Ek0L6UR3Lr2Nme3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwZCzMS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E0CC4CEE8;
	Thu,  8 May 2025 02:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746672189;
	bh=QHIqGXwRiR2ss8hlVa4na7pnGZlFNP0+0NJi8rMzu14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwZCzMS9n/ql48KSuu3eThBtXFZzpAkVe4q2Sp3Dzx6ky5R0h2ze7tPDxjDaDV+wL
	 J6DuFO/WjUhFy4lwANVQQ2uHQ1DY5pyGSkLxTGXjNHlcYel7VIJZJexhEE5ZjeYvpq
	 DtP5C3P5Zt8/GCFPfxIeIxhnxqM5QKIq+yD1MgePb7XxZDNT5e8aM0MubamyNs0Zu8
	 cCnKnIHT9P5ghgSeB3+7RTgAXLom6ztGGvZLqO/c3bkwFAyyypNtqeZJtTdWLz02pT
	 qsj/kjPDWeUzwpd4D9X6VeliBvxXgx0/kFKRleT9VhEBhHO16QiCgrSlm2vD/ioD0K
	 l2yx0BGtUDRZg==
Date: Wed, 7 May 2025 19:43:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Dave Ertman
 <david.m.ertman@intel.com>, tatyana.e.nikolova@intel.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next,rdma-next 5/5] iidc/ice/irdma: Update IDC to
 support multiple consumers
Message-ID: <20250507194308.26d31e9a@kernel.org>
In-Reply-To: <20250505212037.2092288-6-anthony.l.nguyen@intel.com>
References: <20250505212037.2092288-1-anthony.l.nguyen@intel.com>
	<20250505212037.2092288-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 14:20:34 -0700 Tony Nguyen wrote:
> -	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
> +	cdev->iidc_priv = privd;
> +	privd->netdev = pf->vsi[0]->netdev;
> +
> +	privd->hw_addr = (u8 __iomem *)pf->hw.hw_addr;
> +	cdev->pdev = pf->pdev;
> +	privd->vport_id = pf->vsi[0]->vsi_num;
> +
> +	pf->cdev_info->rdma_protocol |= IIDC_RDMA_PROTOCOL_ROCEV2;
> +	ice_setup_dcb_qos_info(pf, &privd->qos_info);
>  	ret = ice_plug_aux_dev(pf);
>  	if (ret)
>  		goto err_plug_aux_dev;
>  	return 0;
>  
>  err_plug_aux_dev:
> -	pf->adev = NULL;
> +	pf->cdev_info->adev = NULL;
>  	xa_erase(&ice_aux_id, pf->aux_idx);
> +err_alloc_xa:
> +	kfree(privd);
> +err_privd_alloc:
> +	kfree(cdev);
> +	pf->cdev_info = NULL;

Where do privd and cdev get freed on normal device removal?

