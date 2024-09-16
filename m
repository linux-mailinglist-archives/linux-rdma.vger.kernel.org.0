Return-Path: <linux-rdma+bounces-4963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF340979D3B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 10:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08061C22D6F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4B145A17;
	Mon, 16 Sep 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukpp9USO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2B13D612;
	Mon, 16 Sep 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476678; cv=none; b=a9UuFoO1ZrEkSdzji9Y7FDoskb99ZQ3NuwZUGl7XuxBQPCq5UJyXesQZfMmumgRVZM4OUpXHhCEKgmVyn793o3WrDQ9gMCa7ueIfyn1m+pf5MIKT6EsmFWTluVZlHMm0B8mdyxM55Xqkl8faRePwSRMnNlGRf65I3NUNCf1ltpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476678; c=relaxed/simple;
	bh=8tWjdaMhQGz4Nhxt5ahKw22r3ZtGi1XC+p6fOx1psQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk82NxYCeIL5OMmG/m0ojQgrIv4MLdwteGGqYlKya7UlKT/ERSkmysakCWPkDQf0xsxv+ZHvJkKp89D3WSjhK5HuJHPXMqo9vKKKi/XrE2p0YKDN9bhnrMFMnc2lJ4BEMN0Q9DdJB5ZS9fetHUGW9VVY/s2MOysmXuq2zR51iE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukpp9USO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD3FC4CEC4;
	Mon, 16 Sep 2024 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726476677;
	bh=8tWjdaMhQGz4Nhxt5ahKw22r3ZtGi1XC+p6fOx1psQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ukpp9USOkAyw+uA2SUGu3MpoJ41eh4D7un0L0z4s56fVu60v5BgoUPIjtqyaEDZHe
	 /A3NtshaaCD1xQcCdl6lpY13OnJvmi/7xNXy1IL8tFTlRAVzDsF4MPaSILvLrQHySx
	 LfQETy9uhbXNgD7a8Ude0myMLjQ2S8JoCTFPi0VPhcMsXDIKKOVlPNJjGF4hyjsb4S
	 znqUM0k8WdxHR+Ge2rhUWlGD5obyTLOIyHfjk81KklbPR1HjdwZRuAI3A5+D+zdxtI
	 K81vYRCnCJ9GPoBF2h7I0tsVqvCDdtQnl+4W2wEXs9qj+zc6CiS0YccYxYbl7fmPD6
	 vpOUu7x15T3ZQ==
Date: Mon, 16 Sep 2024 11:51:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Roland Dreier <rolandd@cisco.com>,
	Steve Wise <larrystevenwise@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] RDMA/cxgb4: Added NULL check for lookup_atid
Message-ID: <20240916085112.GL4026@unreal>
References: <20240912145844.77516-1-m.lobanov@rosalinux.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912145844.77516-1-m.lobanov@rosalinux.ru>

On Thu, Sep 12, 2024 at 10:58:39AM -0400, Mikhail Lobanov wrote:
> The lookup_atid() function can return NULL if the ATID is
> invalid or does not exist in the identifier table, which
> could lead to dereferencing a null pointer without a
> check in the `act_establish()` and `act_open_rpl()` functions.
> Add a NULL check to prevent null pointer dereferencing.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I would say that this is not possible flow, but the check is harmless.

Thanks

