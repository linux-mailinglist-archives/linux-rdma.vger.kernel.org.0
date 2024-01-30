Return-Path: <linux-rdma+bounces-812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB25842663
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DD2286689
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE16D1A6;
	Tue, 30 Jan 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po4G78u+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EF67E7E
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jan 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622473; cv=none; b=VeluUCF2ftOfQ7+O9wxJdWyiY+eDiOOFCkx/sXGPhxbZyyygcOnBqnbxo6W/bt/61453tgTO3pEGDAxcwiuqrtcXqvXqe95rNUkJgaY0Qalsmyx3PF4k6/9aHHdqpWkYyxPRXtZD76FeKYjnTE0QIFgighSMIyobtWv5/TySUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622473; c=relaxed/simple;
	bh=jOCPsPiWXbZ1rNzsO4u2kcpyFU86rxI+FZCol7IXEH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Odwpru+tRofu5snnPd0YQEV9oW8CQ1fPj0lfdg9FlKcspIUgAH0A1TPYsJCIGMzFkzMrd4EdLjCwkSqk4WisMDL2gdUziVMP5h17DUg01o7djgDgFP51JC01frSlwDA4qogrFtjkU6kfxMX8gnKKlXG7Tbz8xvFXAy6Lq6dsf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po4G78u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71ACC433C7;
	Tue, 30 Jan 2024 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706622473;
	bh=jOCPsPiWXbZ1rNzsO4u2kcpyFU86rxI+FZCol7IXEH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po4G78u+wzxu0SMyoyF9SApwKjzAz9KKo3k9m3HEpbNIwtlEtEu4XzthvxOFXUHFA
	 fgeD6A5+NWw3NPthO/gLOm2ksf0uGlnlaGa+L0dVF0NAelxcPiITAh1xqahkEXbX/f
	 xjmE+1dSIQpSa2VXYMNfxfFhE2R7vca+TZilCy3m1hBnFT3ubP+BR7Wt7M6BEHJnka
	 gbdduSDlNZVmLTXTZBMxU4if0mLE/hEoaLy6ukJ3KjWdEoUrZkQv4NXn5S8ggG+Rlx
	 EhYEw5srecsVtJxNgeoEiwz7/Zxd28IcbHGXu95Cs3lmn5APc/Ep0i37cT8vX96H83
	 5tc3FtjsAlqQQ==
Date: Tue, 30 Jan 2024 15:47:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Message-ID: <20240130134748.GA71813@unreal>
References: <cover.1706433934.git.leon@kernel.org>
 <20dc8ea1c606351b0491240d857977f724084345.1706433934.git.leon@kernel.org>
 <20240129175239.GY1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129175239.GY1455070@nvidia.com>

On Mon, Jan 29, 2024 at 01:52:39PM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
> > From: Or Har-Toov <ohartoov@nvidia.com>

<...>

> >  	if (mr->umem && mr->umem->is_peer) {
> >  		rc = mlx5r_umr_revoke_mr(mr);
> >  		if (rc)
> 
> ?? this isn't based on an upstream tree

Yes, it is my mistake. I will fix it.

Thanks

