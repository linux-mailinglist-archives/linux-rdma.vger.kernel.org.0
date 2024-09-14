Return-Path: <linux-rdma+bounces-4946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956D978F17
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86A21F23C68
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476314430E;
	Sat, 14 Sep 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcKeYbAm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403F13C90F;
	Sat, 14 Sep 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302121; cv=none; b=D1OTzO5EqVLfuE20O9xvhGjoDdQzc+ZkHPhwLMnRTzlI6/hayW2goByCWkHbpdviuCA6UMe91YjY3SCCn/x6vKMTL6PnRoilsUWA3oGN15QjQ1Jpwwx/1UK5aTA1ywBDz3VqIVDvKzK3DrwIVoZhPqUiyzJghPZNPgCbUd5xWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302121; c=relaxed/simple;
	bh=V0xQRb6hvB3TAUXYpJ0T0CAil15Rp5i3PZlkpBbF9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKCy6+0VpRimR/ZNZBZ4VmCu9wXEQQqC+2AFTc3PBjR4HsyoQ+rJ/vT0MwkGVYK9gEuJbobNbkfif1hg4v6SKgzL66bVvXwDPaiXe7/H1DocaGWmd5oYWGBwwjB00BZd9ZVi+BHKG6apJfIydCju+ubVVdL8S4oXW6nUnLnx0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcKeYbAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E460C4CEC0;
	Sat, 14 Sep 2024 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726302121;
	bh=V0xQRb6hvB3TAUXYpJ0T0CAil15Rp5i3PZlkpBbF9pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcKeYbAm/wezKNnNlWX2CJrfNitsNEjmvgg5XoHiwG9lf8rz75zBA7ini3wzsxdgd
	 nObFywaawiP1Z1159JdS4RFXKRV2RvrbJ41YV/V/rT52+wgJ7OynhCReKlvWljAaJg
	 xdTojCbQzWlMXHgOQLqIh65Rj2/DWw6nI8u3qByEIUPnLjhIr4QXzwWbixZb10ci/+
	 6QzpIxOEM04beOvMj6lIm5Sxosu5VM5BnMdMRpz58UkvF2TeP8vqp9sOclzh9hUFzB
	 bPptudjHCLF0DtMtXsH2ecO1umjRwozywY/peJUKinbtM8KUlzIAo40r+oOQbM+J6C
	 ylZ5XdrSLZXJA==
Date: Sat, 14 Sep 2024 09:21:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
	Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
Message-ID: <20240914082156.GB8319@kernel.org>
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <20240913135510.1c760f97@kernel.org>
 <6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
 <20240913194808.43932def@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913194808.43932def@kernel.org>

On Fri, Sep 13, 2024 at 07:48:08PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Sep 2024 19:12:01 -0700 Krzysztof Olędzki wrote:
> > On 13.09.2024 at 13:55, Jakub Kicinski wrote:
> > > On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Olędzki wrote:  
> > >> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
> > >>
> > >> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
> > >> as close as possible to each other.
> > >>
> > >> Simplify the logic for selecting SFF_8436 vs SFF_8636.  
> > > 
> > > Minor process suggestion, I think you may be sending the patches one by
> > > one. It's best to format them into a new directory and send all at once
> > > with git send-email. Add a cover letter, too.
> > >   
> > 
> > Thanks, yes, will do for v2. I assume this needs to wait for about
> > two weeks for net-next to re-open?
> 
> The cleanups - yes, but if patch 3 works you should make it independent
> and send as a fix (and trees never close for fixes).

Hi Krzysztof,

Just to expand on what Jakub wrote a little. In general fixes should have a
Fixes tag and be targeted at the net tree.

	Subject: [PATCH net] ...

Link: https://docs.kernel.org/process/maintainer-netdev.html

