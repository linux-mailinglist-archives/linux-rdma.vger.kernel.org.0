Return-Path: <linux-rdma+bounces-4059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7CD93F01C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 10:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259F92837AD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1013B597;
	Mon, 29 Jul 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a881dwgn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1F13AD32
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242834; cv=none; b=ZKMryvitzVahM6UikwZkv10XZ0qzgsD7RiprGDaRA6xJWmKU9o42N3zT0dsMgVK6QSInU6ppy7tiwBIOXQ/m0uUJ3i0lPVEpakp5DjD5aM4FkWE/OlGm1brL9gxnLOKEWdP8V83JGWiSKCHbgMAOip1Bg1VKv2uTAcYVegbShs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242834; c=relaxed/simple;
	bh=7AcCGuwWkGL7hS0mYhvajlDk0s65XYGnzt1WXb+67mM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OXUVXu4nSMtqSI5OyZejyOm/H3qLpVIRCCnGZsUylKSFYPDfPYM4X/iy2aOUcQoxJcfzk09GdS8WDhssE8HFmhgZpuugga4B8UlL+TrdHjHOGiwXSOVM0EUpcAlvMdDLFSgDZ0z+7qHnwqxyeBDeqW0+/rZn28RcLLSOzG6Bor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a881dwgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0399CC32786;
	Mon, 29 Jul 2024 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722242834;
	bh=7AcCGuwWkGL7hS0mYhvajlDk0s65XYGnzt1WXb+67mM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a881dwgni4nDhyY1EYoemGxY0iftN3ElD4y/e3GbzP3eAB2gcZvamANZNQGwjHFeO
	 cdOh0LIlGYCicZZdz76H/MSDHgmUiHgP562Fo3MqqZyRvnlb5CXIWaf8gP1DnVG+nM
	 PaX0cgt4or1Ifynf2XaE9zAQS0OMGsL2kXETRPCd7hdMFbGPBB06POq5T4uZs7PotK
	 Fo4KAv/fvvYFp63+751LkzEVlcMQL6PYLp7HjzWicXBCpWjf207MeCc9Pa1ca3cCUf
	 CMyT+yA+DSExMWnwoh7gyhUJsFmUpOXiTDc51NsGS0wA8XHpf83aTc1qeWIjBoMnrz
	 wW/t/PTWzOFZQ==
From: Leon Romanovsky <leon@kernel.org>
To: bmt@zurich.ibm.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Showrya M N <showrya@chelsio.com>
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>
In-Reply-To: <20240724085428.3813-1-showrya@chelsio.com>
References: <20240724085428.3813-1-showrya@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Remove NETDEV_GOING_DOWN event
 handler
Message-Id: <172224283033.205305.16625659434975021740.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 11:47:10 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 24 Jul 2024 14:24:28 +0530, Showrya M N wrote:
> Toggling link while running NVME-oF over siw hits a kernel panic
> due to race condition within siw_handler and ib_destroy_qp().
> The IB_EVENT_PORT_ERR event can alone handle destroying qps.
> therefore remove unwanted processing in siw.
> 
> 

Applied, thanks!

[1/1] RDMA/siw: Remove NETDEV_GOING_DOWN event handler
      https://git.kernel.org/rdma/rdma/c/60dc7fcafea817

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


