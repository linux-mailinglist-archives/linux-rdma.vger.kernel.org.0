Return-Path: <linux-rdma+bounces-7617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B37A2E7D3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC1418874AE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696241C3C18;
	Mon, 10 Feb 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR8subNd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B531BC077
	for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179991; cv=none; b=U9C8G1fRwPfy7+Ap7KPejZKu8hlPLeiOdyZQQh4WUhIquAwkp5dKBmEji5CKIzcC9Hw/b8bi1WVeUFmni9g3/N3pGOFjNaS5+dhuD5FfPfXg55tPL5rJC38q1pV0l4JXY4K299DOvA7rc2iK2PX/GTRH5SnaG++Jt7joG6tmsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179991; c=relaxed/simple;
	bh=LarOAsy9iUh2peX3Jeh0udGeXbzc19tmUdTz+IB0Kug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXbcNdSE1n95Lk02LRRr1MuCd9ZxKZ65V3rpmgRSILsIEMeD00BGalE9YTwPfEPNqrG2Uhi1CQOZpwblWveSTgnPaJ9WIlTp2JBBNoKicy89za6bBEe8hdPlSAE72hv0KF+KLidJZ6FjIARd35I0WTBkqxgEttPPQD1Z7S3oCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR8subNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0308C4CED1;
	Mon, 10 Feb 2025 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739179989;
	bh=LarOAsy9iUh2peX3Jeh0udGeXbzc19tmUdTz+IB0Kug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VR8subNd484bfFp4rtsCKbzNTZI7nnqgH78wtKR2NulYlxMAKS9O6loa9iRrx6wyT
	 EXdu64QqxP2pq0B3dyy3dK5+x0rDdObP7bTNOj3YL8vlzUHbsp6wlP8ji3PX+kFOnd
	 aZpmVCakmhX3qDIcjCSfeTtOH0tF6yewX0Jc08YTA3DVyLg/KMsT5LieYDkGJxe/s6
	 cOl8lEpJXY/l1KOjh4AFw00U7jKDI2Q9rKNiC4hBQ05yymiuPCA4Vtokf5Xf9Chnzj
	 r5u4ZSlsiAkW8V0IFSpXHISIZxcIfHOpNGlw7CwS2ASCec0j5nc7pyUjHQDutNuUox
	 /KPIxndPi57IQ==
Date: Mon, 10 Feb 2025 11:33:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Question about ib_drain_sq()
Message-ID: <20250210093303.GD17863@unreal>
References: <b80b04df-ff75-9308-6d27-a8df9f6abca8@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80b04df-ff75-9308-6d27-a8df9f6abca8@hisilicon.com>

On Mon, Feb 10, 2025 at 11:27:56AM +0800, Junxian Huang wrote:
> Hi all! A simple question about ib_drain_sq():
> 
> Why are we posting a WRITE wr but not a SEND in ib_drain_sq()?
> This doesn't work with UD QPs.

Yes, UD QP support wasn't needed for ib_drain_XXX users.

Thanks

> 
> Thanks,
> Junxian

