Return-Path: <linux-rdma+bounces-8406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF93A54546
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DA1895539
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB014207E03;
	Thu,  6 Mar 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Clg2cLtd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C920551C;
	Thu,  6 Mar 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250879; cv=none; b=sRwOQ0TDK073bLG6hn6QFrkhmj1exhYDcD7Y5Y88s88bVsd5NnNC+8YU2ngGdKCeTCZL+xHrogIjrbH5LeaD/7zUepPKHu3POu6RjRvwoI5Lnhvid/MvJeHWnUOhg3wZEWNtjEekLhRhvwLgHf1037M3Kr18/RhEjBrMdohDbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250879; c=relaxed/simple;
	bh=J+PDjpUqfvf57ViyFi5yPq7UxVpHRWHfqW+jl+tEfWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paKy6GxEd4238YywA6s1W0C+fCJP8eoL2x2FW58fE/ch3e9SFDRfB7OzO8JBqu/cU0dl5AeaplsO/nN8svXPqQSs/vhh2MxczGcfI7ltmbJKQKOitSj93TCDa80epjPKPC6ykTRSzwBhhPbOj1no3UU+MtpH+ztmANu9tZNQdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Clg2cLtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E539C4CEE0;
	Thu,  6 Mar 2025 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250879;
	bh=J+PDjpUqfvf57ViyFi5yPq7UxVpHRWHfqW+jl+tEfWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Clg2cLtdb6GNixf2GL7cU41I+Dixm63vAKvHkIx2m2D6kz5olpYI2+XvyNJPMpQts
	 Ncl41mdckfamKfXDNI4ua9AB+VLwXgeMOuNck6dRLhY/6H837vexzW1SCNWdVVyEQX
	 lE8LPPAhe6vZFKA59CjrjkdvyI2ErQ/wXY7JDQp2GnK+Ukfw2DGJLg8xmZSGE9HpO0
	 mTwBL0FGQ+/c5EAw0nEjsl9V7HvzvLk9WEwk7tXi2v+YSpQ5o4GwxN3UQNF+JFKMe7
	 8oUiZoGW3TvyYADzE9LiZeWkevy7yrr2q9BS4Rfrx1lAg4BX2E+txzEK1bbiS04O8A
	 b/FcndbLFSksw==
Date: Thu, 6 Mar 2025 10:47:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Message-ID: <20250306084754.GR1955273@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
 <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>

On Wed, Mar 05, 2025 at 03:20:41PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Mar 2025 15:07:51 +0100
> 
> The implementation of the function “erdma_accept_newconn” contained
> still the statement “new_cep->sock = NULL” after
> the function call “erdma_cep_put(new_cep)”.
> Thus delete an inappropriate reset action.
> 
> Reported-by: Cheng Xu <chengyou@linux.alibaba.com>

Cheng, please resubmit this patch, I'm experiencing the same issues as
Christophe has here https://lore.kernel.org/all/20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de
and it looks like Markus continues do not listen to the feedback.

Thanks

