Return-Path: <linux-rdma+bounces-8580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31DA5C322
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 14:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5D616F87C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60F256C84;
	Tue, 11 Mar 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odxrt06O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63425524D;
	Tue, 11 Mar 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701567; cv=none; b=OsG6lTR7G3XYbG42YmTOgfeGCPj1fkdB8cAq36TXUbMATIyS9xqxJ3aLLLjCTMxQyiqwRTDs8nlp9tAgH3hQaa8sCWLvF4qJct5e85X/gQ4nXa6z86qVr2tNKp492mOqi95rXnfOShUWVt8eP/tY0o8QluMt6lHpEprx3vwn95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701567; c=relaxed/simple;
	bh=5MhmNTWMGNzvKLDkWq38qbEpyg7A+zhP0shutNQJMpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCWfkBT+WN2sMh9vHLUiU0UxjWRXs65rHnkH9ZqOe+d2BuoVhSpf8a3BkvADupiAGp1jSNQyJU7UFEtoxi7qmtn720RLfhS7vpP75Ap8MX+GR0VflU3IYZSaT+6k9RrFXdd2kd1kyMMoxj1nVMU1eqdBSp/JvIYejz1+7j/F9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odxrt06O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C7C4CEE9;
	Tue, 11 Mar 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741701566;
	bh=5MhmNTWMGNzvKLDkWq38qbEpyg7A+zhP0shutNQJMpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Odxrt06OG/LR3t2QdbTKiPibxyn1ezxxomjuLdwrTqHuSIusglpwrTR4VzCiAB40O
	 KupSFCyID5UpxIZlQEaG+A1yYJOkc4D8bP0Oa+XOu08g5zMM98NPJBGOnxGO9aO8Hq
	 jnSvB3ADFy2PJoI52mWgM6gRedMD06KJxLrhOegPa91a6HNDmzKnVlgGknJl4KXTbf
	 UqsTFSCpwf9aRcQWvAnabp2zgvJR0bmpbXu3fyy+fkjG8sdpIpC7AtZZgZlIN4rw0X
	 tafJStLqtDR94UgUBo+6TrjHz4pawsFgdS+GLtetJge/Z/cP3UcQkx5J6rrL1bxoPx
	 lDWZQleRTaiYA==
Date: Tue, 11 Mar 2025 15:59:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250311135921.GF7027@unreal>
References: <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>

On Tue, Mar 11, 2025 at 12:23:19PM +0100, David Ahern wrote:
> On 3/6/25 12:21 AM, Jason Gunthorpe wrote:
> > On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:
> >=20
> >> How do you imagine this driver/core structure should look like? Who
> >> will be the top dir maintainer?
> >=20
> > I would set something like this up more like DRM. Every driver
> > maintainer gets commit rights, some rules about no uAPIs, or at least
> > other acks before merging uAPI. Use the tree for staging shared
> > branches.
>=20
> why no uapi? Core driver can have knowledge of h/w resources across all
> use cases. For example, our core driver supports a generid netlink based
> dump (no set operations; get and dump only so maybe that should be the
> restriction?) of all objects regardless of how created -- netdev, ib,
> etc. -- and with much more detail.

Because, we want to make sure that UAPI will be aligned with relevant
subsystems without any way to bypass them.

Thanks

