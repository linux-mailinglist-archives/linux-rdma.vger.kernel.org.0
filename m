Return-Path: <linux-rdma+bounces-14433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79862C518B7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C773A5029
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF982FE075;
	Wed, 12 Nov 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3rGwrp3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13F29AB1D;
	Wed, 12 Nov 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940619; cv=none; b=gx2/oNAPwL7GDSJAhTgOGKA3F5SiYBkuQoJ1aELFTr2RNArj2eiiJfY0ttibeY/RQR45BU8FWJ7+Szw+52zUgp0l2VH+p2p2yMDFVdFR7cX4i/tqoGfJIS/PDrOrgwI00vtufcguXcscAwJxSVP5FXFt4cPFSPGHsNK1Q3qmAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940619; c=relaxed/simple;
	bh=YxRXcxcGSbhL8vl9fWIcTKoE+aw4v1nrR3WfAaIRGQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/FuGKXKqg17s8LDHu5+Z7/CdLhnDyyAFGKQ7BrD7iZeD8CjjuIP2csob+XxGujDQVElV9XXuNa2ydnI2iJi8kqaSuJgQUWghJIQ98bvJCIyGnn6AKsuLdGhFYG+/mdz5XvsI0XtQ4CgX7HNmhP+23WHQ5Tu9QL2GF8/18gf9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3rGwrp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99029C4CEF8;
	Wed, 12 Nov 2025 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940619;
	bh=YxRXcxcGSbhL8vl9fWIcTKoE+aw4v1nrR3WfAaIRGQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3rGwrp3oBILwz3AFk+DleZqyIjNQO+8i3vTs+AE1EMFfvQVfurHU3d+EjO9/gVJ7
	 VMTCqITGQgwImURZyrE+Vp1IhqFgngwUjhY4D24MzjfS1kE/3NO/MhJos1QLv0xqJ5
	 9alRYXkdGZFzM99xalmQad1yUxGXPraZYtmL2o6QLAebptywwnDcEyo37p5JXXglgC
	 SHlwTbnzcXHJowAY63u+rIOfGDxxPk699Xbm8X9nMOHEOHG0Bg4vvkVXdSY+pKfMOc
	 3z7TRmRBzcLJxqshXOIACsf2xLiyztE/AGRAlEcWAZJhKkhpG550coD0lBwdMPRTm1
	 MFHqeDLuP5knA==
Date: Wed, 12 Nov 2025 11:43:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cm: correct typedef and bad line warnings
Message-ID: <20251112094334.GB17382@unreal>
References: <20251112062908.2711007-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112062908.2711007-1-rdunlap@infradead.org>

On Tue, Nov 11, 2025 at 10:29:08PM -0800, Randy Dunlap wrote:
> In include/rdma/ib_cm.h:
> 
> Correct a typedef's kernel-doc notation by adding the 'typedef' keyword
> to it to avoid a warning.
> Add a leading " *" to a kernel-doc line to avoid a warning.
> 
> Warning: ib_cm.h:289 function parameter 'ib_cm_handler' not described
>  in 'int'
> Warning: ib_cm.h:289 expecting prototype for ib_cm_handler().  Prototype
>  was for int() instead
> Warning: ib_cm.h:484 bad line: connection message in case duplicates
>  are received.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  include/rdma/ib_cm.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, applied.

