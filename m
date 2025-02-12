Return-Path: <linux-rdma+bounces-7680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02BA32744
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322397A2E02
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E020E6F0;
	Wed, 12 Feb 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/kbYa8/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D088134A8;
	Wed, 12 Feb 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367666; cv=none; b=HNFUIIE2BVHgNCvkHHWY2gyq/UkzcYl8rkM1pB3KEXTZJDb1qGHu90NBh5Hsucyd/Wt0RPrMHOwVlFxCXFQh+dToxu5HDVGRFwZHle44zEwQoYii46XnGC2j6NQzYkc9C+1owIzkmvoEVhI3EekJrg3vS5/nPlAa04x5ysiGmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367666; c=relaxed/simple;
	bh=QwxYYZ2lu8cCaX1eM4Wkqn0p/HWnap94XnF6/L28Uss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfWjx514b5qXgphOBShO9qY3h0t+ANfGvQB1BJ5qbQF2B8AjYb+TQuGVMFdA2rDyIhtCGaPC5aWrCwnrD439LhGd2kfeNO2VY6NiMGAAIpWxnKeL938nQ1Tc49se01qWI/MZzgRBAJcqf1AoMagpBByBch+whNQPVFNbARKESVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S/kbYa8/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DsqRzMD38fNHmtDc7dw8PqZW1w5iP/GdHY1JZLfl4uk=; b=S/kbYa8/k8XhdqgTy1maWhp1jQ
	aqsfAkRc8+eU4IfbyqNelLF06qwB+yX94KesW4ItYbhNDitTBVjopzzgAlvpsXbcw9eEgxku+uvIv
	WfmwzFDbh8a0mczyY5guhlkZC7HPDfSb+04Lp/0NHrEtbqpvQOpvbL3vBeplFpr5SByE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCyr-00DPED-1N; Wed, 12 Feb 2025 14:40:45 +0100
Date: Wed, 12 Feb 2025 14:40:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 0/5] pds_fwctl: fwctl for AMD/Pensando core
 devices
Message-ID: <7a9d5e34-4a1c-4e91-9a25-805052ffd73e@lunn.ch>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211234854.52277-1-shannon.nelson@amd.com>

> existing function-specific tools.  For example, these are things that make
> the Eth PCI device appear on the PCI bus

That sounds like a common operation which many vendors will need? So
why use fwctl for this? The whole point of fwctl is things which are
highly vendor specific and not networking.

Isn't this even generic for any sort of SR-IOV? Wouldn't you need the
same sort of operation for a GPU, or anything with a pool of resources
which can be mapped to VFs?

If you really want to use this as you key selling point, you need to
clearly explain why is this highly vendor specific and cannot be
generalised.

	Andrew

