Return-Path: <linux-rdma+bounces-13096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A594B445B0
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 20:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA3D5470CC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B032F772;
	Thu,  4 Sep 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Gozm/c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711202AF00;
	Thu,  4 Sep 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011553; cv=none; b=Gpfk3WKwBL+dTOZGIlItMdwfuQ5lyOPPprfxIoUFwkJKc816OLGxF1dPW+dEYwkIAYYJwsx4MvYT9bSa/ta/qLbT7wE0tRnEUhKM2WoaFRjihNUb6XQX6Ez01l+bgY84jatstN9CHQUZ083rKGUG+K0LzBaP2mxy3S6pqCo6L74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011553; c=relaxed/simple;
	bh=9zjitpEiNjIRsHyVbtqAQ1md45Vb+8/EWgUeD2j/glM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMGMGbstv1wg03YeUrOPiHJe2nBLEaDIlsOAkS/kxaKCXduU2wiGPj0LDleZocSZhQ+JG5u54vcOYMZNbRmLXb4yYvKnXFRyTUa2I0SLo/ZpbTorLAFRYml43J1/C3k9ywTVNsuvuTF5SJxBy7hrbQFzZVPiz1y6RSOB95sFA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Gozm/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F8C4CEF0;
	Thu,  4 Sep 2025 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011553;
	bh=9zjitpEiNjIRsHyVbtqAQ1md45Vb+8/EWgUeD2j/glM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1Gozm/cyo+vcmGSfEfSLSWai1/BBkn37yUH15FqdDioWRqH36/LiPlvAmUCa3buS
	 hE4TCD3mDGBr/rDI/7d06uS3oTwHbDHZYY19nK1Ys4cc+9xTfX3+DUBmper6DVPIf8
	 WhQI0HnNWsHxiSBguSDcbiUz1yd663pjlfeZcrcbLZD54sZqPmHsZ48hn567EnV9XM
	 oxUiUwEQ4+fJNhyasAkM1J76PLttkeoy6/qyxXmaDvt1i06Qa8Y8yiHkKyouyTdrRD
	 yrp0lEGCPxthcu7gMhnmRHiHnaLBrtaaKlJ2/rxUNHefey/ZxGNGqT8amj2QTDCwrm
	 8wSAp+bExX7eA==
Date: Thu, 4 Sep 2025 19:45:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] rds: ib: Remove unused extern definition
Message-ID: <20250904184548.GK372207@horms.kernel.org>
References: <20250904115345.3940851-1-haakon.bugge@oracle.com>
 <20250904065502.13d94569@kernel.org>
 <44A12092-5DA9-4A3C-ACBC-FF1AACB03BD3@oracle.com>
 <20250904073343.1138ce24@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904073343.1138ce24@kernel.org>

On Thu, Sep 04, 2025 at 07:33:43AM -0700, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 14:22:02 +0000 Haakon Bugge wrote:
> > Sorry if I have mis-interpreted the collateral. From [1], I quote:
> > 
> > "A Fixes: tag indicates that the patch fixes an issue in a previous
> > commit." As such, it is an "issue" and I reference the offending
> > commit.
> 
> You're not the first one to misinterpret it, I guess we should fix the
> doc :$

+1

FTR, a fix implies a bug. And a good rule of thumb that a bug
is something broken that is user-visible. E.g. a system panic.

> 
> > As to "Cc: stable", you're quite right. My bad. You want a v3 or are
> > you (and stable) able to handle it?
> 
> Please repost this one without the extra tags, and if you want it to go
> via netdev the subject tag should be net-next in this case (it will end
> up in 6.18)

