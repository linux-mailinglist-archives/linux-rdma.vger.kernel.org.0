Return-Path: <linux-rdma+bounces-5809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA19BE6E9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 13:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE03228532B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0931DF257;
	Wed,  6 Nov 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms2bLTJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793431D2784;
	Wed,  6 Nov 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894904; cv=none; b=P/GctpZ2R2vjSiFZ+DEDRHWRXHz1FOOnPNhU+dtirX3egoYTT+h0g/qb3d0nBuQP+utN9mOGXJasnjEZuSBB6mybh2dZDKpTooqeNIeLiSiWg399Zgu7lb3PcVhcnJthft35DmW31puKwB74UMBVIY+mCqq23OTzPBbHD+XM9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894904; c=relaxed/simple;
	bh=NDhsrpAKOtA879Zj0VhgxfyAFSxu+wXLDn314nMeTRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h904mfvJcEN4BKAZh33iE22Z7UELOMLsNW6YwsRjNCCwivkyHh/Ay/4zLmnzhrzH49leJheLPG7vkMSMwtOQ9DAH98ET4f3AYRWGIj6LA+fLyp/KW7KyyV714Q/hBxXF2jxI8Gg1q/eGIzJdmn+MwzuFGzeQaQLgf8NPpEvUStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms2bLTJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F7C4CED2;
	Wed,  6 Nov 2024 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730894904;
	bh=NDhsrpAKOtA879Zj0VhgxfyAFSxu+wXLDn314nMeTRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ms2bLTJLSa+2kY2baAhKHijkOhYWaK8DlDsvjAxWX4RysoT/0mS+9VCpf0TRP5P+H
	 mS1z5r1FhEuTZCQo+Pg4kYmjt0STsCnzgLUMRad5odaWQO/8X0NpdsViSaOx4gvgos
	 UX2mDR4JXYNBODvIfOX7OAD2rwBswbaWxVuuRcSvYPNSaeOYJS3iP63fL1rJ5Vm4FQ
	 z/fnlywJS72179bWYVd28M5C6Zp3idPr7LRPTY5qOOLc73SS5Bs0lokflJUFEiBoUD
	 LuuPnd1D4gAdsG74DFmVaCkdGK2z1T0a23aVRh/xG4ri5CYZf/MFRzNLEHQ2/hLycA
	 fqKCoRi6tL9Qw==
Date: Wed, 6 Nov 2024 14:08:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/2] Small optimization for ib_map_mr_sg() and
 ib_map_mr_sg_pi()
Message-ID: <20241106120819.GA5006@unreal>
References: <20241105120841.860068-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105120841.860068-1-huangjunxian6@hisilicon.com>

On Tue, Nov 05, 2024 at 08:08:39PM +0800, Junxian Huang wrote:
> ib_map_mr_sg() and ib_map_mr_sg_pi() allow ULPs to specify NULL as
> the sg_offset/data_sg_offset/meta_sg_offset arguments. Drivers who
> need to derefernce these arguments have to add NULL pointer checks
> to avoid crashing the kernel.
> 
> This can be optimized by adding dummy sg_offset pointer to these
> two APIs. When the sg_offset arguments are NULL, pass the pointer
> of dummy to drivers. Drivers can always get a valid pointer, so no
> need to add NULL pointer checks.
> 
> Junxian Huang (2):
>   RDMA/core: Add dummy sg_offset pointer for ib_map_mr_sg() and
>     ib_map_mr_sg_pi()
>   RDMA: Delete NULL pointer checks for sg_offset in .map_mr_sg ops
> 
>  drivers/infiniband/core/verbs.c         | 12 +++++++++---
>  drivers/infiniband/hw/mlx5/mr.c         | 18 ++++++------------
>  drivers/infiniband/sw/rdmavt/trace_mr.h |  2 +-
>  3 files changed, 16 insertions(+), 16 deletions(-)

So what does this change give us?
We have same functionality, same number of lines, same everything ...

Thanks

> 
> --
> 2.33.0
> 
> 

