Return-Path: <linux-rdma+bounces-13656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209FBA0F6B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89229175ED5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E10311580;
	Thu, 25 Sep 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceJ6yMw7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC712E7641;
	Thu, 25 Sep 2025 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823056; cv=none; b=ImfJycbhkgnKqW43mEQgQSS9s+H/YGPNzbjZ2wHhUoREe+oStXQVb36AOlNthCwN8gw5Pzrx8XDcaeqOT67ezfSLdFnV+zSiS2NiXcZsAjuPD8saALXYlgcny9TGb2Ad2kyqu6I+rAyNCGP1pkjtw2/gnhA6cAXbGhdHcZXJnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823056; c=relaxed/simple;
	bh=qoifE3zJBGyy8pHJ5F5xTTvVhsEV8efkkUoMsXjzTe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyQXOnfnoHDE61f5MymyY74FxTEsuwM6PYIyEVWMlKiK0WMa6kj6FKbjOM5oZmBWl49MOogRXTv4Rz12U174K7UawPGDYTvXClF95l4OMz14zATx2uYzA9gUumtszJRTnnFWVsDAWe4PIlhMw1M0Wxw+RfBrAA7w7J6JgBfKFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceJ6yMw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF9C4CEF0;
	Thu, 25 Sep 2025 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758823056;
	bh=qoifE3zJBGyy8pHJ5F5xTTvVhsEV8efkkUoMsXjzTe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ceJ6yMw7lJUX9dmO+ynu8AwRojuaHCYTII2JpwpLSHULnUvPwYrfZ6q//NFxAK5+x
	 3Im+PV8UQ3qdDUVTiaKs6NYL8q5jiW5CqXHks1GTdPkhfvSVFALYdyzQnrmuuQt80I
	 EjfoxlsnkUie13/Yu+NPeWMyRsT0W9XvRTjHcht4hgL0pVX91JeWd4E3DVrKCqGcX8
	 8znv3cmhhTgeB8j0c8MlMgwPh9M+Nk9SiA+qZONF9+D2lXYcGm0/kUxZWk7w5YKQAe
	 UGm/zfGgH9DJW3HzCx1EB3wrfY37nc7qA1AgwhWZn1yPCcq4Z56vfdKBe6uWtSz/sF
	 WNTYAJku+1Rfw==
Date: Thu, 25 Sep 2025 10:57:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Alexandra Winter <wintera@linux.ibm.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>, Aswin
 Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Mahanta
 Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen
 Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Simon
 Horman <horms@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>, Konstantin Shkolnyy
 <kshk@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shannon Nelson <sln@onemain.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Jason Gunthorpe <jgg@ziepe.ca>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Wenjia
 Zhang <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net-next v3 13/14] dibs: Move data path to dibs layer:
 manual merge
Message-ID: <20250925105733.040604ca@kernel.org>
In-Reply-To: <74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
	<20250918110500.1731261-14-wintera@linux.ibm.com>
	<74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 10:07:35 +0100 Matthieu Baerts wrote:
> Regarding this conflict, I hope the resolution is correct. The patch
> from 'net' was modifying 'net/smc/smc_loopback.c' in
> smc_lo_register_dmb() and __smc_lo_unregister_dmb(). I applied the same
> modifications in 'drivers/dibs/dibs_loopback.c', in
> dibs_lo_register_dmb() and __dibs_lo_unregister_dmb(). In net-next,
> kfree(cpu_addr) was used instead of kvfree(cpu_addr), but this was done
> on purpose. Also, I had to include mm.h to be able to build this driver.
> I also attached a simple diff of the modifications I did.

Thanks a lot for sharing the resolutions!

> Note: no rerere cache is available for this kind of conflicts.

BTW have you figured out how to resolve that automatically?
NIPA does trusts rerere but because it didn't work we were running
without net for the last few days (knowingly) :(

