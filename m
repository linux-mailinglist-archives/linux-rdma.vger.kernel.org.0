Return-Path: <linux-rdma+bounces-2944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01B8FE7ED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D1928517E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDE196C8E;
	Thu,  6 Jun 2024 13:34:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055719642D;
	Thu,  6 Jun 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680871; cv=none; b=Kjh1Za6WjM0XLHSXuV6JtowAz8Xg/wKId++yive1lmWIv23C12mbT/9ESrpywWW4VaZHoLi6PMuaawXET9eK7dIHpS2Gh5v3cpu6hhH49J1h/EDe71VE8lxLr4mz5Quq4yA8OGx7VDfi2jdJmWuOKDnl+QubEAAe8fw+U+lvqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680871; c=relaxed/simple;
	bh=wVX5LN5wezgSA3E348Yymtojtevb4mWjLp7y2qc+kQw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYVBPoV+tcg0p7IEcEIh39hlx62Du1CSjJZwUDW0fuTBjsf/9HkaJWCXMM07FIblJOxTcREGKdyPYFEs8lRm7EEC2nqugdh2DgvrXT/YdfQ0q1tKrfVgefWKUH21dtwGb0LrdG7dzTP8UoyJlsQdNs7X/hWZlAIpXg52hnF3ODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw4tz4dFjz6K6Lf;
	Thu,  6 Jun 2024 21:29:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EECED1400D4;
	Thu,  6 Jun 2024 21:34:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:34:26 +0100
Date: Thu, 6 Jun 2024 14:34:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
	<dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
	Peter Zijlstra <peterz@infradead.org>, "Julia Lawall" <julia.lawall@inria.fr>
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240606143424.00001fbd@Huawei.com>
In-Reply-To: <20240605182726.GX19897@nvidia.com>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
	<20240604122221.GR3884@unreal>
	<20240604175023.000004e2@Huawei.com>
	<20240604165844.GM19897@nvidia.com>
	<20240605120737.00007472@Huawei.com>
	<20240605182726.GX19897@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 5 Jun 2024 15:27:26 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 05, 2024 at 12:07:37PM +0100, Jonathan Cameron wrote:
> 
> > > I don't recall that dramatic conclusion in the discussion, but it does
> > > make alot of sense to me.  
> > 
> > I'll be less lazy (and today found the search foo to track it down).
> > 
> > https://lore.kernel.org/all/CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com/  
> 
> Oh that is a bit different discussion than I was thinking of.. I fixed
> all the cases to follow this advise and checked that all the free
> functions are proper pairs of whatever is being allocated.

Yes. I think we are approaching the point where maybe we need
a 'best practice guide' somewhere. It is sort of coding style, but
it is perhaps rather complex perhaps to put in that doc.

I'm happy to help review such changes, but it would be too far down
my todo list if I took on writing one.

Maybe there is one I've missed?

Jonathan
> 
> Thanks,
> Jason


