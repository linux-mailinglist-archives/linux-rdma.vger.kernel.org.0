Return-Path: <linux-rdma+bounces-7681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92692A32845
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E612B7A057C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AA20FA93;
	Wed, 12 Feb 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbplJdvZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06320F08F;
	Wed, 12 Feb 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370018; cv=none; b=l2aTw7WdXfMUPjYeGolcpZMp7WrzW5ZgDP3sILZWoAClG8dR7xVNYk/zWejVc+yVvQZavnqjsa+cMslVgfVW4m9V0ABvKxt1lWfZigJVfkH3DS1wqiXQ5kaxpOp9ay2MG1ViIFVOUHOWiH3+ZBTusyO+HfwK2OzKSHjB+DE9MlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370018; c=relaxed/simple;
	bh=W76h+CLfCyTTdsAX/7kJMTRrDvwOck8HYBZvhglAEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKOH27l5pQYW/juWIePHmYpOpK+hMowUOgJvFeC7mMZfCNH1gIC0L7YSZNtGcK4K0R8bKpAoasOLjz4U06LV3WuS0s93vzZnFszFrUbF3GIYCXozZxZgxSHIhxMWEhoayn+lYtiAE6eW5Rv0YnVdLN5iZTwnM4Y8qPgT62TH9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbplJdvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ADBC4CEDF;
	Wed, 12 Feb 2025 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739370018;
	bh=W76h+CLfCyTTdsAX/7kJMTRrDvwOck8HYBZvhglAEO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbplJdvZjHhY8XDZUmGI4C0Xkpaj+HvVxCjfRZL9fIMNcksBce30FIRYX4jbzmsgJ
	 kXRnfadJ7kyCveNMfheNoc42Oj36V52dDZxQ0dBHtDAGGEvmkG+nmMRjxlzy6hY2DD
	 GY1tvgSqit6YQ4ZimW2xCBiMe0yvqA5y+tsd6fbwlRxjduJ8155Q3KiogWqFAxoXrw
	 KhnPPUkRbkz7d/zLKJxCoLJIrF4kVghFad9FC+/DhSRgpfDx/teNmEVyXDBYXqNFC/
	 g3w6rN5PS43enSbGM6frtQQtXQpTI9U4BABwAvKvSZiRcQNce8Icd1P+Uh61bJfDBY
	 55/eINUud5IeQ==
Date: Wed, 12 Feb 2025 16:20:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250212142013.GH17863@unreal>
References: <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <20250211075553.GF17863@unreal>
 <CACDg6nWiSbBV=Ls=Rts=vsx0V7pKHX0ZztbKJL_UM0+u34uiZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACDg6nWiSbBV=Ls=Rts=vsx0V7pKHX0ZztbKJL_UM0+u34uiZg@mail.gmail.com>

On Tue, Feb 11, 2025 at 09:27:08AM -0500, Andy Gospodarek wrote:
> On Tue, Feb 11, 2025 at 2:55 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
> > > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> > > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> > > >
> > > > > But if you agree the netdev doesn't need it seems like a fairly
> > > > > straightforward way to unblock your progress.
> > > >
> > > > I'm trying to understand what you are suggesting here.
> > > >
> > > > We have many scenarios where mlx5_core spawns all kinds of different
> > > > devices, including recovery cases where there is no networking at all
> > > > and only fwctl. So we can't just discard the aux dev or mlx5_core
> > > > triggered setup without breaking scenarios.
> > > >
> > > > However, you seem to be suggesting that netdev-only configurations (ie
> > > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
> > > > case? All else would remain the same. It is very ugly but I could see
> > > > a technical path to do it, and would consider it if that brings peace.
> > >
> > > Yes, when RDMA driver is not loaded there should be no access to fwctl.
> >
> > There are users mentioned in cover letter, which need FWCTL without RDMA.
> > https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
> >
> > I want to suggest something different. What about to move all XXX_core
> > logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
> > place?
> >
> 
> I understand the logic in your statement, but I do not want to
> separate/split PCI driver from the NIC driver for bnxt-based devices.

It is just an idea and there is no need to worry yet. There is no
evidence that netdev community will allow such move. 

> 
> We can look at doing that for future generations of hardware, but
> splitting/switching drivers for existing hardware creates a poor
> user-experience for distro users.

It is already solved with module autoload, dependencies and aliases.

Thanks

