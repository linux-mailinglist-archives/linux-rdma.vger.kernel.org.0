Return-Path: <linux-rdma+bounces-8399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95988A54088
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 03:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4973AA785
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD918DB18;
	Thu,  6 Mar 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGYLfMCN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B28624B;
	Thu,  6 Mar 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227382; cv=none; b=BiQIGpkno9CKEfKE6B6orXf0M2FvZByhfqMFaUXIBFGXSfpt7OFzbErpE4I1gSFGxTKFr4iPtGfeD9ygMIUDLemKliimbirzDGkPkvsxVD5+R/ftULxKUoMUgs0bPZZtesSnssgFyY5QkAAfXOquLlgi7NvdlO6S8YDq/1QU/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227382; c=relaxed/simple;
	bh=ca2RkUcd3KWRqlaazF65NjhjBXERjxSiESRczshyh2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caoRimV11LSulsro7/jHEH9KDmB7C574tk8ak1OGpPrKTfXdweoqYKbnFUK5eK5ZZosbk4EnmluD9xDH0qXrTePG6rgm4e6BwFLGjl5xnf3xckh2bZrhn9NSmNFMf+/HMdJzovhwu8OR4pJLypGNnSxYMoQJK/AcPE6iMb34lhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGYLfMCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C98C4CEE2;
	Thu,  6 Mar 2025 02:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227381;
	bh=ca2RkUcd3KWRqlaazF65NjhjBXERjxSiESRczshyh2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGYLfMCNNncsLMXfW9xH26kFsBDQYQ82J7ZJKSyGTAaXjXBD1VXh87mDhzdMKllEE
	 AqipWfqERAowisUVAJe5eyl6zWVxcHcPwREn9d2Xx4wZj9S2MDWC0aOelR7zi7NYW7
	 pcDYKI2u890Ns0+V/wug+/8OdTQfB8mh3MavuulEH4Dmnxu5rtjAmBP50vu5IXJQrg
	 plKkCq8Dc4O2iaPMKCrEBI67YQYMf7+R5f1m1+hBVpLpCx4eJRckXOgRw8r6caMaTH
	 yv4OJYhEEa0+JIvK0khwX9dQlSQ5a9efOp95fz5ZKNBiwUpFp6WJ/oo7snMgx0xu9z
	 Z1KMMP0JbAruA==
Date: Wed, 5 Mar 2025 18:16:20 -0800
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
Message-ID: <20250305181620.217ebaba@kernel.org>
In-Reply-To: <20250305133254.GV133783@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
	<20250303175358.4e9e0f78@kernel.org>
	<20250304140036.GK133783@nvidia.com>
	<20250304164203.38418211@kernel.org>
	<20250305133254.GV133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 09:32:54 -0400 Jason Gunthorpe wrote:
> > I thought you were arguing that me opposing the addition was
> > "maintainer overreach". As in me telling other parts of the kernel
> > what is and isn't allowed. Do I not get a say what gets merged under
> > drivers/net/ now?  
> 
> The PCI core drivers are a shared resource jointly maintained by all
> the subsytems that use them. They are maintained by their respective
> maintainers. Saeed/etc in this case.

PCI core driver? You need it for RDMA.

Whether you move the code around or spell it backwards, I don't care,
as long as vast majority of the users of this **NIC**, who only use
TCP/IP do not have fwctl access.

