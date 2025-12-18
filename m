Return-Path: <linux-rdma+bounces-15089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9765DCCCD7E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7146F30A923A
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E84368273;
	Thu, 18 Dec 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cepAEvCB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CA366DDF;
	Thu, 18 Dec 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074190; cv=none; b=ogZMz50jW64wEtNGUWFFY0rdCc2U+ln+W180w4GFFgTo4SPAyS1NK+Cm7U/6zbm76h2ZAaNzDHlITJGl7cC+7A6nV/rwS+7DMaqDtK1YyBdUigNi9zTb2240qO051/VytqCr+BSolvHK5CbElrGSaqhroSxG8xgDwSZW5sGBh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074190; c=relaxed/simple;
	bh=h5iO/egUUv5aO60s7ezCX0gBR0o81QoXAe6OhhRWj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W31Ac8NxMqYOR57bGyVbD7zQrOdE8t/Hc46GROz4ecUOHamB9H/HAut/yAx76u+OHAdtj93D+2fF0pXpV13n7E3anr8XamJI/QqOt+f/f9EfjIANH1CcANCTio66T/Uss8/66RlFdCgKR1VHHHoipo1Wlzdq9vngoCMBct9/H2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cepAEvCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12734C116D0;
	Thu, 18 Dec 2025 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766074190;
	bh=h5iO/egUUv5aO60s7ezCX0gBR0o81QoXAe6OhhRWj6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cepAEvCBzWawoYjJ3UoFyuXsiXqrkdSNd02w9DrJ+S62nDYh8syt0UPZ+YaPSr+Cs
	 56GfRZHbsPIbgSyFGH/5jnDpTAjY5pOLvrpW3wH+DcGDI78W4j2IOspy+Hew8xo8aG
	 K3E8fWAFDqteis/0lzm7XHz8Wp4nYE6GWR7t5Qy4Gs9BTvJZuiYMFVV77ORG4zAwWE
	 yjS8/In97eLlhlpsVDWvq13Jzg8NoIPlPdaZN5fgrtv9wsX7Wc5xchsFzhmOlARbo6
	 ouEFaOpp2u4fBJQrj3O9mFYH/vgvIcBDeh/knVXRcXrbsmbOc1UeafXyvo5dc8lwnL
	 F9zJpqhcvCkjg==
Date: Thu, 18 Dec 2025 18:09:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ionic: Replace cpu_to_be64 + le64_to_cpu with swab64
Message-ID: <20251218160947.GF400630@unreal>
References: <20251210131428.569187-2-thorsten.blum@linux.dev>
 <aTu7FFofH/ot1A74@ziepe.ca>
 <66a98775-76f2-683f-77b1-7f5dc991ca14@amd.com>
 <20251216005112.GA31492@ziepe.ca>
 <3BC136A4-B5FF-40B1-968C-67BB30C73239@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC136A4-B5FF-40B1-968C-67BB30C73239@linux.dev>

On Tue, Dec 16, 2025 at 01:35:02PM +0100, Thorsten Blum wrote:
> On 16. Dec 2025, at 01:51, Jason Gunthorpe wrote:
> > Okay, so Throsten, please don't send patches for changing to swab.
> 
> Yeah sorry, I didn't know about the sparse warnings before.
> 
> > If you want to improve it then the primitive should be
> > 
> > le64_to_be64(x)
> 
> le64_to_be64() or a similar helper doesn't seem to exist.

You can add it.

Thanks

> 
> Thanks,
> Thorsten
> 

