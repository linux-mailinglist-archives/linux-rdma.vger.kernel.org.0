Return-Path: <linux-rdma+bounces-7886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F979A3D42A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CE9189A3F6
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512E1DF962;
	Thu, 20 Feb 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8AaBXdY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BE1C5D67
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042418; cv=none; b=LrfhO1dMmyhyzzPHurNPM4DZnbW6Ex3fvIMftFttkE8ORb4NfoFW3+vcz2gL821b/h48RXczX8L5qoKR1/L4rF9uR2Bohc7cHVwBy8BE856qdZ2uQ0NLMZJzesgvLtYfCK7xX4rzyA7sb8SLkGg6r7moGXlRnWc+qmllMg0lKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042418; c=relaxed/simple;
	bh=CiZZcJY4eLhRLvMkDcUx2cxtgPsyD9NS56NLE6DVKlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJUNt2KguzbP0mJs+j/ZEXhyuTvwWxshPMEqtxclZ/DgqRw7nbbsgT3T/pz2yUNNwknEwYOMelDvLPWM4zmh6pzIc1DwewHZ/MB42gzeODbgLaHk1Rc4cOYjUUeyXiieqcAtQn97AyFaabrTaSGunS4bsrgwZOeg+Mtupvtqf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8AaBXdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4933AC4CED1;
	Thu, 20 Feb 2025 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740042418;
	bh=CiZZcJY4eLhRLvMkDcUx2cxtgPsyD9NS56NLE6DVKlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8AaBXdYzkxvFj2w55wCxXnJTwo+WLnS9hxERWSTMMimkGCW6m8io6UUjB/+j0ybo
	 h/tkyJb5FGSCCKIarPnKplCy9m2TAyR716DnMzK79g0HlQuMM+VGxrr2+nIKWaCE5w
	 jMl4IdZMVALRZEWZ9GvLv5CX6qG6VzQxcApVrd9JnEIT4tqesUpP/YJFowjuKsGQCh
	 5wNyTBcXn6XZvlfxlCKG30pTJB/DB8n52BfIBgm3dLzhA7ZrE2cbATR+4ZYgKhJlsE
	 nLG5ErJcsy3rCWOpqB3nzHDJcuuhKceHVhWmJircPEE0UN9Zpix+dHksh2TMFNhyVb
	 K4xo9uVtO9yDg==
Date: Thu, 20 Feb 2025 11:06:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250220090652.GN53094@unreal>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
 <20250219155647.GI53094@unreal>
 <20250219175335.GA28076@nvidia.com>
 <20250220065938.GJ53094@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220065938.GJ53094@unreal>

On Thu, Feb 20, 2025 at 08:59:38AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 19, 2025 at 01:53:35PM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2025 at 05:56:47PM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 19, 2025 at 10:46:16AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Feb 19, 2025 at 03:52:05PM +0200, Leon Romanovsky wrote:
> > > > > From: Maher Sanalla <msanalla@nvidia.com>
> > > > > 
> > > > > Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> > > > > uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> > > > > In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> > > > > error code from rdma_lookup_get_uobject(). The IB uverbs API then
> > > > > translates this NULL to -EINVAL, masking the actual error and
> > > > > complicating debugging.
> > > > 
> > > > This may have been deliberate as this old stuff is not supposed to be
> > > > returning weird error codes.
> > > 
> > > I assumed that this was the reason for such overwrite in the past, but
> > > is this continue to be true in 2025?
> > 
> > Maybe, it is ABI that leaks out libiverbs
> > 
> > But also, maybe nobody cares. There is a small chance places are
> > relying on detecting certain errnos.
> > 
> > > > What error code are you missing here?
> > > 
> > > Error returned from modify QP was masked by setting real error to be -EINVAL.
> > 
> > What errno was it though? What other errors are there that are now no
> > longer supressed?
> 
> Mainly -EBUSY from FW command interface, so users can safely call again
> to modify QP.

Forget about this comment, I was distracted, and it is -EBUSY from
uverbs_try_lock_object() and not from FW command interface.

Thanks


> 
> > 
> > I think the commit message needs a deeper analysis to be convincing
> > the ABI break is low risk
> 
> No problem, we will update commit message.
> 
> Thanks
> 
> > 
> > Jason
> 

