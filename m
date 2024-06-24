Return-Path: <linux-rdma+bounces-3464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B1915A4E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 01:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C561F24563
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B31A2C04;
	Mon, 24 Jun 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAjhKY8V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4B1448E6;
	Mon, 24 Jun 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271084; cv=none; b=LQDmdyObOqpmzh1+JS4PhRobGKz7AjFz0xY2xAzOEupyaXRC/cBhxSik9hLVgQ5WIiJ3LAghnGHcZXiY2juxQzGDKRCw6h69QRUXUeztK1zhErS5LGYLraioBeKdd/b2ekNnu+b6AgB1J5X7ztpMydGxyG6tF6YTmAxk3lMS0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271084; c=relaxed/simple;
	bh=b8lg8KLVesphXHNeR3O0DBOHLM2f5EKg4zX/f+OaVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0It2q9KAXc63o4Wt5+svLHTbp2aKgvmNvzVLWO9pwrJRDGe7yssms3zqShfv3HyUdVVDuWZCDxB909SlfLBr4HEgEdt1y1s7Sw2OGJZmqO/2qW1foZFFMusoHHoBj867R3sh+3oeBuLiirtp4VusVp0KwFuiP+pfESL+iNOWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAjhKY8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D2C2BBFC;
	Mon, 24 Jun 2024 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719271083;
	bh=b8lg8KLVesphXHNeR3O0DBOHLM2f5EKg4zX/f+OaVa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAjhKY8Vcc0kKV5sEUErYICsMHkKtyoG+TvMrAbWChCFdFY0PwPzmOSFWBJSsKCa/
	 2PVimbmuqolvaBFTfz1++Danom6U9rrVZ2eVzAvYmgj7nGHWRS1Yw4WP9Bx+ZwGtBV
	 qxpDy/xmMvn6xrFVR5nH7DRtBsoO3znuaG5gEAxF+YMgu9cswXRcZ6tSVuZa7ky7ya
	 4VOu+8UT5jiMPArJv4hds639iBd+HOVBnTvcWS5R9Z1JPXEjIHaxld5lOH+Ik8hwdH
	 2BpxFCLqyjevRtO0kwPMy/YEyy39iijaZAWrHMLJt/Yo98RPdpSSBkABSJ8cD+0Ehk
	 +DR1SlMuFJ23Q==
Date: Mon, 24 Jun 2024 16:18:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
 <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, Christoph
 Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/8] Introduce fwctl subystem
Message-ID: <20240624161802.1b7c962d@kernel.org>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 19:47:24 -0300 Jason Gunthorpe wrote:
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.
> 
> This concept is similar to the long standing practice in the "HW" RAID
> space of having a device specific misc device to manager the RAID
> controller FW. fwctl generalizes this notion of a companion debug and
> management interface that goes along with a dataplane implemented in an
> appropriate subsystem.
> 
> The need for this has reached a critical point as many users are moving to
> run lockdown enabled kernels. Several existing devices have had long
> standing tooling for management that relied on /sys/../resource0 or PCI
> config space access which is not permitted in lockdown. A major point of
> fwctl is to define and document the rules that a device must follow to
> expose a lockdown compatible RPC.
> 
> Based on some discussion fwctl splits the RPCs into four categories
> 
> 	FWCTL_RPC_CONFIGURATION
> 	FWCTL_RPC_DEBUG_READ_ONLY
> 	FWCTL_RPC_DEBUG_WRITE
> 	FWCTL_RPC_DEBUG_WRITE_FULL

Nacked-by: Jakub Kicinski <kuba@kernel.org>

