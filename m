Return-Path: <linux-rdma+bounces-3414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D5913BE7
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B241F223FB
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jun 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972918132D;
	Sun, 23 Jun 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d62+5SzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9720E6;
	Sun, 23 Jun 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719154970; cv=none; b=pM8tYFEmvMXfCiCX78WkYylrBK3SJEZqUc0xL9PRlTmWRsQWZo6SA/+oUOpqQLrh30UZ+Sw6iSkAKl1nN5/HDvC0JpmFncy2qT1CbcVH5jO0GapTmeQOna8qc7zX9UKM6XCfnmhwQLzuUfpgHqAHyyytESsbPDyVM7oQoZx1VQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719154970; c=relaxed/simple;
	bh=pmraKMKuGHQsOuwkJdHHe7ZPHs24rglHuo8gj8xVWbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnIpcTWwBbeqC6BFU/YOJsEKqo/o3/sCI2fKean3uhNCwEIFB0dQ2k5npWQXF7NuDmRahbl580WpM5PQZTh7yUny9WgntH0qA0db3yhqp5Kj2meMdNC0jIgpX9UvPx7SiOr182f5tGfzbZfLBO3gz1sm6ysRjYzhiGlF14YInbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d62+5SzZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lAeNiNN7T2hP3j1rcbWFTsr6hZ4Ct1xVTB5elrFogu0=; b=d62+5SzZZhGQ0EO4TWRU14lMaj
	bsfy0dl0rM/dFmE0iwO9Opswh8k5s9z7Jqd2x5l2OYfHO/UHdR2TViD+PyC955fd4ssnXwLx2GPVx
	J0BNIWFxZZVRYc+/sgXK5zI6jhz3wk6WzkfxyIxfxrlm/LnYaiSnZ/1DLuEJN5oC2nxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLOjs-000mnd-Ez; Sun, 23 Jun 2024 17:02:44 +0200
Date: Sun, 23 Jun 2024 17:02:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 06/15] net: hbl_cn: debugfs support
Message-ID: <b40391d5-66d2-44be-bc83-4ac3b7bcfe08@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-7-oshpigelman@habana.ai>
 <BY3PR18MB473757A4F450A2F5C115D5A9C6CF2@BY3PR18MB4737.namprd18.prod.outlook.com>
 <ac16e551-b8d6-4ca7-9e3c-f2e8de613947@habana.ai>
 <060ac3a6-bbac-400c-bfd9-cb1a32c653b4@lunn.ch>
 <a1a3bafb-c64e-4960-a826-f49d4679d7a0@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a3bafb-c64e-4960-a826-f49d4679d7a0@habana.ai>

> > If there is no netdev, what is the point of putting it into loopback?
> > How do you send packets which are to be looped back? How do you
> > receive them to see if they were actually looped back?
> > 
> > 	Andrew
> 
> To run RDMA test in loopback.

What is special about your RDMA? Why do you need something which other
vendors don't? Please solve this problem for all RDMA devices, not
yours.

This all part of the same thing with respect to module
parameters. Vendors would add module parameters for something. Other
vendors would have the same concept, but give it a different name,
different values. It was all poorly documented. You had to read the
kernel sources to figure out what kernel module parameters do. Same
goes for debugfs, driver values in /proc, /sysfs or /debugfs. So for
years we have been pushing back on things like this.

If you have something which is unique to your hardware, no other
vendor is ever going to have the same, then you can make an argument
for something driver specific in /debugfs. But RDMA loopback tests is
clearly not specific to your driver. Extend the KAPI and tools to
cover this, document the KAPI, write the man page, and let other
vendors implement the little bit they need in their driver, so users
have a uniform way of doing things over a rather of devices.

You will get a lot of pushback on everything in /debugfs, so please
review them all with this in mind.

       Andrew

