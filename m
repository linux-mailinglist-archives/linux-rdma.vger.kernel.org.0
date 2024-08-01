Return-Path: <linux-rdma+bounces-4173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A694516F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EAF1F21A00
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0CC1B4C4D;
	Thu,  1 Aug 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4oEPrg9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFF13D617;
	Thu,  1 Aug 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533197; cv=none; b=ndXyhzComPK64wK7jPAPUwzUrRr0Ux5DlC1DNAuamhBfBhlciuGmS9NsrXRth93vHKDlvvYR9YNm5iov09skF+mVqzFzTKjhsxtXB9QqZ/gfrYF/mvFeQqi71KaUm0NIdT30+j5ym5TMzxvj/G2XLE/ITQEDftSBjMil2W2OTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533197; c=relaxed/simple;
	bh=o7DCCp3FQn1iCJygO3a/7pgwytsbRS5VxIzYzl6e+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA8nOY/qaq0z2MJpV42I133aDWHi6Fwk2efnIUkN9TddLKIJZW4ahAWSm+ZUGDrWvJXdJH6pWIFvTNg6Dgxc/guvUcq4oQ1LIA3xkK5HLOalU+m1dVsES5Unn3ukVnXEPsM+90CKx5S1sikvv77TKYq2IkOCgr4hv5Mf+stB23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4oEPrg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D8C32786;
	Thu,  1 Aug 2024 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722533197;
	bh=o7DCCp3FQn1iCJygO3a/7pgwytsbRS5VxIzYzl6e+YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4oEPrg9+DVF6yeVY6KBfcL06gLroS6GHruR5IcZJmRbunZnOwEr/LbC/KL03gH7w
	 6f9lrd4jIvAgEcdGjGzQPPSRPtFQUkhktyRTrRMgKO2+Qtd0nDCQHc51utYmO0zu+Z
	 Qae7fhZvWWg62LkxMsq+3zTjV1eShdMM8nziIn51y+GMrZGEj2FUT1aohkgiQ9x5Ub
	 FdIuMBRSx6ll0aCJ1dObQNIy9uhRfnv/i6IM6GL1hyZAqVWefz3FNrP3TCbHoy6btp
	 o/Es+Po/e5gG/qeQz+Q8EDdQBH3yq2xfMnaJCJRO0+zPmIzKmlqgDZpjBP80kClv0S
	 Lg29flwmYdHwQ==
Date: Thu, 1 Aug 2024 20:26:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240801172631.GI4209@unreal>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240730080038.GA4209@unreal>
 <20240801125829.GA2809814@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801125829.GA2809814@nvidia.com>

On Thu, Aug 01, 2024 at 09:58:29AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2024 at 11:00:38AM +0300, Leon Romanovsky wrote:
> > > +
> > > +	void *inbuf __free(kvfree) =
> > > +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
> > 
> > 
> > <...>
> > 
> > > +	out_len = cmd->out_len;
> > > +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> > > +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
> > 
> > I was under impression that declaration of variables in C should be at the beginning
> > of block. Was it changed for the kernel?
> 
> Yes, the compiler check blocking variables in the body was disabled to
> allow cleanup.h
> 
> Jonathan said this is the agreed coding style to use for this

I'm said to hear that.

Thanks

> 
> Jason

