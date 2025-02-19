Return-Path: <linux-rdma+bounces-7859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A3A3C44F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9308B3AA2D2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99ED1FC7F7;
	Wed, 19 Feb 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bywyUzoF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28111D5175
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980612; cv=none; b=qhWFcjnwm/1wFWrSlNDdB/L94rlsMTdrzHCnMLfZn3WJwxPkMl8kd5oXwk2P0TMk3re6MLOcFGmsLO+QxCXwstUhc2zMDW8/2JaUlBmZFLJFhr613YvrLkviwbE3fDikbedz62DquZAUZ/pKtjcGfTNUkpoER9WXaVFvyO+jy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980612; c=relaxed/simple;
	bh=u0EjFnpokQLu7NbvygtCu4viMIcD6UPQxvMfvJ5kjKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC8unPdVgVG1tDqdJOAy1il0IPHeD9nYERB3B+Mpri2ocAOcNk/fVa8O5SBEx4pV2LNRRM0EiVsMQp7h/PF8U3MdJUYtqCckr3rMovEhV4ceV7AO8aCG2ZvcGLywNzgK4U5IrUTlqy+GyJJ2hQwOeHJfe+96wUZpWd/fGGnBUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bywyUzoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0A3C4CED1;
	Wed, 19 Feb 2025 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980612;
	bh=u0EjFnpokQLu7NbvygtCu4viMIcD6UPQxvMfvJ5kjKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bywyUzoF5Qi+PDOWaoE/icWtTKZvtRDY0IgtUjKO1BhxCXSqNNZ83ip2nlLw6Mwrf
	 N8zsFxIWC3QCdTGaXfkBYPxtDilhYEcG2ZyqVDgz6AC+UOwW3LSCPI+/Ba2Xwly9L3
	 OiX6gM1n5bnL4eA/8tz5IRS+MgSu0roRhYZ4IajehZo36H93D1ybQi7tFdmxnpsVOB
	 j4cBZQJ87NRodwNFS8+WyziLaEes0KNtUwKox3uV3G5HIm078AwrySE1mcBm+vD47A
	 D0raOkP++/cNnGYpywoxg0cvXve0WYxymfHWF0p/kkq8FOlPwaibuy2XEeAuPTy2g4
	 mNPzfaE3JO6rw==
Date: Wed, 19 Feb 2025 17:56:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250219155647.GI53094@unreal>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219144616.GO4183890@nvidia.com>

On Wed, Feb 19, 2025 at 10:46:16AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 03:52:05PM +0200, Leon Romanovsky wrote:
> > From: Maher Sanalla <msanalla@nvidia.com>
> > 
> > Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> > uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> > In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> > error code from rdma_lookup_get_uobject(). The IB uverbs API then
> > translates this NULL to -EINVAL, masking the actual error and
> > complicating debugging.
> 
> This may have been deliberate as this old stuff is not supposed to be
> returning weird error codes.

I assumed that this was the reason for such overwrite in the past, but
is this continue to be true in 2025?

> 
> What error code are you missing here?

Error returned from modify QP was masked by setting real error to be -EINVAL.

Thanks

> 
> Jason

