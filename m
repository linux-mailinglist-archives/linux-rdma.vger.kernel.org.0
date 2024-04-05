Return-Path: <linux-rdma+bounces-1795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D466C899321
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 04:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6423BB22D43
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Apr 2024 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797C12B82;
	Fri,  5 Apr 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz77j7vz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED679C4;
	Fri,  5 Apr 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712283733; cv=none; b=nPeaHhanHWomqmAU1kEX6GlPY7sx5sQB/JmUXKSoz4I5IseKPI1htaa4f3QUwr5ol48vlU1wjXxGYYj5KbRJypplit3j4Y3B7NkG8y7zyrAbRD11aShRklAT6eAaEWzqh31qm1Zklj5peqE8nNkTIQZgEdAByz31fbtp3hQJrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712283733; c=relaxed/simple;
	bh=0M2Shx9rg9ohy473A71dryd2RvjsIJkTbmSZvEyeAyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e06FAZrQQmKfZ+CH1acuLtpUKYG5ohHIPek7Fl4QvDZLVp8eXimGMJZ0C/5oZDjp1nBQLqoqNvscrSD/62IAVpJvCG8hxnGYP88D05DagEK+YdjVhDt5r4YG7cNPSGWVDsQExBB3sR6IcPmhBVuu33y+nfrJ3Y32WgT2Onrpj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz77j7vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD01C433C7;
	Fri,  5 Apr 2024 02:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712283732;
	bh=0M2Shx9rg9ohy473A71dryd2RvjsIJkTbmSZvEyeAyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bz77j7vz7YgdiqOMP64jE8vNFEljFbfgnSUwT+k7sZyzsWeYVdSzgHNPP1+lqfpOM
	 2h9s9aeGcjCDTwHe/qPdqSMt+SaIrOpFEuNgZVvTd5UraUPd+v1WNaLl99lnDrPBaJ
	 OHYhfygBNJBWViOl+Gpm7E16uuinabi7MWWpwoEOh4y5RQS1xqCb7XKL1/6hsBacDm
	 xFywZzjVC1CYyJJeWoW+/4V8gL/wpVF5esZ4F3XQRF9GdiHMm3NMTh6e8JIbNYmw1H
	 aQbwEu6LH4ptpFZ/pTyS/EWN56fIzPM63mRUBbAKOYx2UtOoIR9HsfZfjGIbrDIsQr
	 6kTBZonkITQoQ==
Date: Thu, 4 Apr 2024 19:22:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: David Wei <dw@davidwei.uk>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "kalesh-anakkur.purayil@broadcom.com"
 <kalesh-anakkur.purayil@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
 Shay Drori <shayd@nvidia.com>, Dan Jurgens <danielj@nvidia.com>, Dima
 Chumak <dchumak@nvidia.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next v3 1/2] devlink: Support setting max_io_eqs
Message-ID: <20240404192210.28e077bd@kernel.org>
In-Reply-To: <PH0PR12MB54811346FB97E174AD134F88DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240403174133.37587-1-parav@nvidia.com>
	<20240403174133.37587-2-parav@nvidia.com>
	<b6f1dc7a-4548-42df-99ae-596dff525226@davidwei.uk>
	<PH0PR12MB548196662E45D680214A6069DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<e909bd86-a6bc-4234-b895-280cbd9d66e0@davidwei.uk>
	<PH0PR12MB54815B522DAFE87942E15825DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
	<5983d9e0-955b-43c9-98a1-7c770ffac7f7@davidwei.uk>
	<PH0PR12MB54811346FB97E174AD134F88DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 18:55:09 +0000 Parav Pandit wrote:
> > Yeah of course, thanks. I'm making some changes in netdevsim and can do a
> > drive-by cleanup there too.
> >  
> Ok. yes, that will be helpful. Thanks.

I think that part is fine, TBH.
Drivers may not support particular control on particular HW/FW
for any number of reasons, we should let them return EOPNOTSUPP.
Not sure if there's much benefit for splitting the ops..

