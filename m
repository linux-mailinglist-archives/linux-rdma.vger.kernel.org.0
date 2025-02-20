Return-Path: <linux-rdma+bounces-7878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF2A3D198
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3BF171871
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D81E3DD3;
	Thu, 20 Feb 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCOY6ECb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA11DEFF7
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034783; cv=none; b=iDQxCBou3m7wT4aab0jl6QGvbcjkxmo/H2tqP5dOeyxNZU2l8j0TwAvlYcrxUda6IpnQu1e8rCnwAkHiUsChxMo/HYdvUjX0K6eL8IdRqGhm5M0HMrJGIL+Lv1gth5vzDSd1fOgUUeBReJqWXiMOHdc/D4EdhxiU+/XiwuJj2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034783; c=relaxed/simple;
	bh=uG7LaI+TRR7IELw2RW5kzC+aR6xsdvj6roGkBnpZPEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJajkVkwtlFshjLzFN7tmMzdsDUPfmUCL4LxyzLA6BT5bvfO/ky9nXRM5ndFgUJMfYYZjLy7Cnxwtn9vyFajFW4FgR+A+drIDSSn9akIrfACH3pu1tDthQH93UHC49FIrKfYi4/l99dII71ulyGePVc8ZWr0HouEwg7gXWWiXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCOY6ECb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E2C4CED1;
	Thu, 20 Feb 2025 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740034782;
	bh=uG7LaI+TRR7IELw2RW5kzC+aR6xsdvj6roGkBnpZPEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCOY6ECbH//nMHZDSyStIaD4lscvC+cDz/DxuvIUdLjYKPVRnlnYeRJt5dv2v82t8
	 5QUdJS6h/f2w4/emunCCpwhrkR+V8cm7grI8hAeGBDbhbcl9mco7s5xHd4SwJP3QEF
	 wb63LiNfM11DnjUulMjupwByu0sirOXSXkTty4GgQK3czNYYoXrWnUo+dwiMU1QCX6
	 vlOM1vO8iqp3eX58Qy3U4RJh5+BhZzZx+x2kAnvDbRQ1WSwSNAg8qxUJkVY7uiD2R+
	 HWr6hIQmk3qp0dnRt7ZsZxc3/14H6u6uwEBO9pE6e2YjLSGqFDyCdD5+MGD59xp9Kk
	 ROoTP22euJbPQ==
Date: Thu, 20 Feb 2025 08:59:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250220065938.GJ53094@unreal>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
 <20250219155647.GI53094@unreal>
 <20250219175335.GA28076@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175335.GA28076@nvidia.com>

On Wed, Feb 19, 2025 at 01:53:35PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 05:56:47PM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 19, 2025 at 10:46:16AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Feb 19, 2025 at 03:52:05PM +0200, Leon Romanovsky wrote:
> > > > From: Maher Sanalla <msanalla@nvidia.com>
> > > > 
> > > > Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> > > > uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> > > > In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> > > > error code from rdma_lookup_get_uobject(). The IB uverbs API then
> > > > translates this NULL to -EINVAL, masking the actual error and
> > > > complicating debugging.
> > > 
> > > This may have been deliberate as this old stuff is not supposed to be
> > > returning weird error codes.
> > 
> > I assumed that this was the reason for such overwrite in the past, but
> > is this continue to be true in 2025?
> 
> Maybe, it is ABI that leaks out libiverbs
> 
> But also, maybe nobody cares. There is a small chance places are
> relying on detecting certain errnos.
> 
> > > What error code are you missing here?
> > 
> > Error returned from modify QP was masked by setting real error to be -EINVAL.
> 
> What errno was it though? What other errors are there that are now no
> longer supressed?

Mainly -EBUSY from FW command interface, so users can safely call again
to modify QP.

> 
> I think the commit message needs a deeper analysis to be convincing
> the ABI break is low risk

No problem, we will update commit message.

Thanks

> 
> Jason

