Return-Path: <linux-rdma+bounces-14264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C162C362EC
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 15:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11844F583C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FE32C95F;
	Wed,  5 Nov 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNUenzsE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66D3191B4;
	Wed,  5 Nov 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354272; cv=none; b=QVuqEiAjnB3dd64y41kA9tury9VltbKdiScsUxihCwBntU6cRIlHlvujvgx9LFGgWUZ10J3+MA9z7UcC2iUSeHdBgR7/VgSR0Nc9/Ugt63iWt1It9S8lWVI9710yurSvBeojCLUUk/2A/wBIvdQPs0UvAfK4fU9RbZOAga0IE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354272; c=relaxed/simple;
	bh=tdq+4btkngSavv+5JwmO8S2wxZS26gc4wDaWkcIkJ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMy/uyUKcXQ/dVOW4lO2YGj61ptjzf0SGHRKdCYT8HiVmIgHBTd88Cgyenrb3Gxi1uAuwwL/fhsjp2JcVRcA/ftzElZ1XBMW1nqCS0pph75hyCDmMIFPYfNbb9gpWMP6uRydE3kpICjV033yE1rIxA5M27Ua/cG7/JcdrW2ws+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNUenzsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366CBC4CEF8;
	Wed,  5 Nov 2025 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354271;
	bh=tdq+4btkngSavv+5JwmO8S2wxZS26gc4wDaWkcIkJ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNUenzsEhK+PuJc2st3qaLUdjj07gX2BbrNJOw7m4oB+oaiSoTBJo5WWfXpi7314P
	 CtkGW4cCqTU3e8HafSbKSHpOYxLTqpaoEoba8v7hZrfoTvs/ggrFqUq0BKIw6ecbbo
	 6sOzyQ0BYbZUtMfqgbNgbiGhdGZmpSuTJnvnOKXc/oGy/F8ofw5hdHDzXjbM6xz9+Y
	 WbDreNc5ckHBGe4lKpI10KfJH53SiOuJeyK6IC8uaBm8OddqENxB8wfAJpHT98giFE
	 TY2PcVx9Pp76NvfAEjkhb9PaI0iNPIxgkWsJn5h9y2MfFCBgRaua6o25H2A9eSuZ2L
	 l22NYgWGiRLHg==
Date: Wed, 5 Nov 2025 16:51:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ma Ke <make24@iscas.ac.cn>, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Message-ID: <20251105145106.GG16832@unreal>
References: <20251104021900.11896-1-make24@iscas.ac.cn>
 <20251105125713.GC16832@unreal>
 <20251105134659.GM1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105134659.GM1204670@ziepe.ca>

On Wed, Nov 05, 2025 at 09:46:59AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 02:57:13PM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 04, 2025 at 10:19:00AM +0800, Ma Ke wrote:
> > > get_or_create_srv() fails to call put_device() after
> > > device_initialize() when memory allocation fails. This could cause
> > > reference count leaks during error handling, preventing proper device
> > > cleanup and resulting in memory leaks.
> > 
> > Nothing from above is true. put_device is preferable way to release
> > memory after call to device_initialize(), but direct call to kfree is
> > also fine.
> 
> Once device_initialize() happens you must call put_device(), it is one
> of Greg's rules.

According to the documentation it is not must, but is very good to have.

This sentence from above commit message is wrong:
"This could cause reference count leaks during error handling, preventing proper device
cleanup and resulting in memory leaks."

It won't cause to reference count leaks and doesn't have memory leaks in
this flow.

Thanks

> 
> Jason

