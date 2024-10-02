Return-Path: <linux-rdma+bounces-5183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20F98D750
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84CF282B10
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925E1D0436;
	Wed,  2 Oct 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpJ4TOSW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317A29CE7;
	Wed,  2 Oct 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876896; cv=none; b=t2scCJnv2g2PB0TZDjFPn74MnM3sR97aLn0YDR0Cp0NNIQPJ5D8APWFCVa2rt6P0yFXNb+mCYENYohFsucyqVJoxXFPOgeSgDBEIh2Is5Ymli4S59i7crjC/StXhLUCBJtQdho8yAYiAzg4XWwVLyusyH+nPFh0dOF+Dh65MD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876896; c=relaxed/simple;
	bh=IsCM6sG+IjFqFUeQDnuBKsarTp7+M7zRzPX2gX5/i18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOrTFAmwHptOqyldU5HXBf5CqELGKkenOfTD/jsYGbgKdcDhVOVxpIwjnZ/YgK+AUIR0WprfqAuKU+cOn4jL3JxY2cXdORjmXag9xzxXSXji0/3Tb175PFAzYlpXUclnUoK9mMw0uWgi4MMAugmtG67XUc6ZwnF0wkeLRYm0X5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpJ4TOSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B429FC4CEC2;
	Wed,  2 Oct 2024 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876896;
	bh=IsCM6sG+IjFqFUeQDnuBKsarTp7+M7zRzPX2gX5/i18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpJ4TOSW6jMhPSxUpINtMng3p5Zo8p+RqoSNdw/oWvO/eQgrYI63DwRYTKWR9UIBb
	 KrSQSfzlGd++nNTgVzJF6mA/new3mtGXV3J/zhiwUBGjFvl4wyHYx9E0IjQYWgaLr3
	 A5XeJebJIvPlhZci9/t81svNxJ8913+p8t28qlDStEd65VI22IhbeNrVNt9w4I00SZ
	 hkVrtmvou4uCiQXodv9bFqpEjLErOvktIuqYVAQsNEuvs6OTCIADr+wSC+a9zs4sY0
	 hfGzrYfwuvRZgPeqkiAdzTK3tItB6a5jhngIgFgVxC0NalKpaC4DW/bfbAgMbRuLMj
	 lGHcKnxlT0I0w==
Date: Wed, 2 Oct 2024 14:48:11 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] net/mlx5: Fix typos
Message-ID: <20241002134811.GI1310185@kernel.org>
References: <20240915114225.99680-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915114225.99680-1-algonell@gmail.com>

On Sun, Sep 15, 2024 at 02:42:25PM +0300, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Hi Andrew,

These changes look good to me.

However, the patch was posted while net-next was closed for the v6.12 merge
window. And, I assume because of that, it has been marked as deferred in
Patchwork.

In the meantime, net-next has reopened, so could you consider reposting
your patch. If you do so please mark it as v2 or repost of something like
that. And please include the target tree, net-next, in the subject.

  Subject [PATCH net-next repost] ...

For reference, Netdev processes are documented here:
https://docs.kernel.org/process/maintainer-netdev.html

...

