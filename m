Return-Path: <linux-rdma+bounces-7818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA99A3AC91
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 00:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93BB7A5E83
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7A1D90B9;
	Tue, 18 Feb 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQyYaiAt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66619CC17;
	Tue, 18 Feb 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921472; cv=none; b=mJdcP8VfThW2wA7cmt3u8w5TVuxYsTxFDc99dzpkSlKyzMErtyp6Wn75GKpGjHto4dllpKTgKmiBCDXwX5sYUYp8jRAVlwBSreP27tXoMrELvFuxfCjHbnLRC1Q00hA9kNpDDH1q9mPQcFLFZjSZ4wNYitrxyN4pUtubeounkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921472; c=relaxed/simple;
	bh=Ktp3q+vyFgGJNlGF9go2OGf8msLlPBzcKI8SNITpBMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N03xoIl2KPw3MblA6K7+zG5kBxN8Du7U/z/opaVMAhGSFa9Ot9qaTJL1gnBJP2/FbA+W7bT3q8ZKZDqi7WjZwvEioCH1SodtqTvFUPu857usIpwTXrf3ilXGs6Gs0ujJH3+cqbPG4CED28FHnaQr/WJHARfk8yx1M+vzfZNYKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQyYaiAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5112DC4CEE7;
	Tue, 18 Feb 2025 23:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739921471;
	bh=Ktp3q+vyFgGJNlGF9go2OGf8msLlPBzcKI8SNITpBMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQyYaiAtvcRCjhCsuwS1ceipPD6ej6yrZ9oSoO81c2kDEj9AzAb7MK63EL3/CwEt7
	 YCp7Q+UCHffH5jp2iNrIvkAZ+Z9bE7gQaTos2eCSUQfwtZ4PVG42AuSDgSPxwcBdK2
	 /C8vYFfDrwtINHYxHAIatJSEXS5LmP3j2uSFIvJ6LwvkL/iwxut8iXqi72ZOoc1pyQ
	 /lOGaQc3iwR94PsGt7Ryusaga5VdBtTnxM0TZfISVdvmhSP9efrbxtfJ/G7vBd4QP8
	 +xUPa1ZBQNSXFX++UOsPFN0Ii4RHmztFiXyRkPglrXyrxIV6C4EbFSkL/Wd8TyIahu
	 JNbe+C1RYZUTA==
Date: Tue, 18 Feb 2025 15:31:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig
 <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid
 Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Nelson, Shannon" <shannon.nelson@amd.com>, Michael
 Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250218153110.0c10e72c@kernel.org>
In-Reply-To: <532d2530-5c12-43b7-973f-ce43dbc36e67@kernel.org>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<20250206164449.52b2dfef@kernel.org>
	<CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
	<20250207073648.1f0bad47@kernel.org>
	<Z6ZsOMLq7tt3ijX_@x130>
	<20250207135111.6e4e10b9@kernel.org>
	<20250208011647.GH3660748@nvidia.com>
	<20250210170423.62a2f746@kernel.org>
	<a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
	<20250218200520.GI4183890@nvidia.com>
	<532d2530-5c12-43b7-973f-ce43dbc36e67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:42:48 -0700 David Ahern wrote:
> On 2/18/25 1:05 PM, Jason Gunthorpe wrote:
> > On Tue, Feb 11, 2025 at 09:24:35AM -0700, David Ahern wrote:
> >   
> >> "Any resources in use by the netdev stack can only be created and
> >> modified by established netdev tools."  
> > 
> > That is already a restriction described in the doc, not just netdev,
> > but any kernel driver running with any kernel owned resource. You
> > can't reach in and change kernel owned objects.
> 
> ok, then Jakub's concerns should be met.

I appreciate the doc, but no, it's not enough. The fwctl interface must
not be exposed if RDMA is disabled or driver not loaded.

