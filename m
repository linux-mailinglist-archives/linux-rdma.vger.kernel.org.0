Return-Path: <linux-rdma+bounces-8048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D75A430BE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A4C3BA548
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D020C479;
	Mon, 24 Feb 2025 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="urS3i3WK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5720B80F
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439357; cv=none; b=dFDXinscNgwlICOgeeFYCL/5r3sdMDrlb7BHY/9R0sEsVwm6S1c82e/pVuWKfQEopRZKJjIJklYoSnFw+6JeqaAN1WSsf4DzwiXgE2Tvkl3hJ56kO9ju/+l53soJwwqOlCDqjb9m9IjUcg3+UdT7SnpVaDSeI8JifriOttdGv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439357; c=relaxed/simple;
	bh=w1mD5fuomTKcDheeNNyRyURDVNWObyrD9liVs+/yILk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzz6IQdwXd0wVS0bib+jiRKr1jlqK1yRvn7/ybXU2Kdt28A3v1TizUvFfCXy/MIxspVz4DYqpC+DYuYZDdrgRseoKb+n+8VNlr4+6b2c3+XEzlCnuz639PeFZp3gUbeTgR5sDm4aU7r5TksrvyPrjCnkKfhASWB2DqIzS+LGf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=urS3i3WK; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 23:22:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740439353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEhGeS60oeT9+pGPnwQZjCKLTHtzVArP5aHGBLvNaLk=;
	b=urS3i3WK277mF7qPrCNxUoICjR7w6QlYlyR5bqHwShS6n8iUb1HRVY+MeZzLBjLMuq5634
	997AmaslCG1m/RGAu7Tki/gUr1KshfPccVAyL0KDbh4W/cKRaIs1wBE5kwE6yCX0rIdb5L
	WPD8I8+gCGLZGAJeaYlfU6bm5FPmjaU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Parav Pandit <parav@mellanox.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <Z7z_NcGWIr3_Dxtt@google.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, February 24, 2025 8:41 PM
> > 
> > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> > > renaming ib_setup_port_attrs() to be generic.  To utilize the group
> > > initialization ib_setup_port_attrs() needs to move up before
> > > device_add().
> > 
> > It needs more than that, somehow you have to maintain two groups list or
> > somehow remove the coredev->dev.groups assignment..
> > 
> I was thinking that if both device and port attr setup is done in same function, there is knowledge of is_full_dev that can be used for device level hw_stats setup. (similar to how its done at port level).

Given that there is a bit of discussion on how to move forward with this,
can we please merge the trivial fix in the mean time? (Just sent out v2 with
the fixed commit log).

Thanks!

