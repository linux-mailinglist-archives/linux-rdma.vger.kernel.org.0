Return-Path: <linux-rdma+bounces-8348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301AA4F2E2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A302188F1B5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755D2D7BF;
	Wed,  5 Mar 2025 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+7/a0hq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BF2E336C;
	Wed,  5 Mar 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135327; cv=none; b=JSgRJsKgHHIWYDPFNIZx0TVTB+rbVW1fQ45oeTrh3gEqu6JoCahCmsOF4Du4Gm2Y1w2uwYSNWAzvnn7TbmZfaOSz1s/Ey7gnNatFhNCP0jYloT1/nJsqKvSh9MuXAwGNs9Ix4H6jZgj7uJxXuZUYEJjjGnX3Lf86utXXyUxEHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135327; c=relaxed/simple;
	bh=szov/TVctoQefLK38irRq6/qIMWI1TSwdt7wMHC9hQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F59CopvtvxGrekMBdJufzV3pe6BUy+fFLt23IptsRikyvXNY2mvFqsHhQugXd9R6jLAMppwVYBRRibXSIqHWePVzAREh7we7zNZGVcgoRZnCOrduinNT85BoaaDEzuS37pQp9dd+yeaj4l/EeCKpHUgTFMFxNGzfNuEyd0vzT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+7/a0hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D91C4CEE5;
	Wed,  5 Mar 2025 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741135325;
	bh=szov/TVctoQefLK38irRq6/qIMWI1TSwdt7wMHC9hQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+7/a0hqQjbKQRBs3pXLSCXT/1B/IffJMwyZsTVSWDtCCQ6um+AY75bC6YZT1PPdC
	 soVwhr3QvnUdwdISa0E9XWvfbREu6hGbJN+3fs4zFFvJhZ1nKcWnQf4NHsNDQgXdtt
	 yQqe4Oey8j3pb49WKw3t/W6Q4rGC6C2PEkmZiMwIyg3zuSpvIv8QNj/tSjXDgpLgnc
	 5h7yFoe0BZ97S4aTjr50MWEwqsguEwjW3OdTdGsIWmEoPxF7p7VFQEpm8LgSvDEXvD
	 4I77E/BhNoYvwQSFLPnmGnIdIu2yzxxyjRn5LwTmpadhMLpSN8IFKy/L6EK8mPoW7F
	 IDZye+vcOra6g==
Date: Tue, 4 Mar 2025 16:42:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250304164203.38418211@kernel.org>
In-Reply-To: <20250304140036.GK133783@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
	<20250303175358.4e9e0f78@kernel.org>
	<20250304140036.GK133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
> I never agreed to that formulation. I suggested that perhaps runtime
> configurations where netdev is the only driver using the HW could be
> disabled (ie a netdev exclusion, not a rdma inclusion).

I thought you were arguing that me opposing the addition was
"maintainer overreach". As in me telling other parts of the kernel
what is and isn't allowed. Do I not get a say what gets merged under
drivers/net/ now?

> However, I would agree fwctl should not accept any fwctl drivers for
> simple networking devices. However, "smart nics" and RDMA capable
> devices are in-scope.

Please stop with the fake technical arguments.
I worked on SmartNICs for a decade.

