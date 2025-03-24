Return-Path: <linux-rdma+bounces-8919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1DBA6E071
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E80188BEE7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16503263F28;
	Mon, 24 Mar 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8U/56rW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9A25F983;
	Mon, 24 Mar 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835672; cv=none; b=KlrtNljXM7wP5aI5/Rc5nWq2rrQp2gyV1gLAHx16JcEBEBjYfBitII3dSNuOSGVj/+XjqZWWPGhP/D01gH1mYqCLpftlS87DesUBAAGr2T9VJG0cCPZPY+4FdK01z66AwHDJCmJXYu1hD2HVLChVgx33Ol0JUjWz5XfsNGsxN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835672; c=relaxed/simple;
	bh=rl4bGchbGnhGJm3HPX/K4Jg2ZZTwUiWgytXyO1M/v1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwyQrsc4oaATMLtW5nzrYsDQSlnxikzJpyZYyZTAwUya24KWOEWsxc5F/2ET7+6s/oUqcvfK+FX3Or2KywTqOInJtWuORBwzEyNzr1T/V2DYxZLVgv50GieAbl95B4WGESDyjv+3tssaOqUN0JMfLHliyjx/hgtlTdDc6savXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8U/56rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE01C4CEDD;
	Mon, 24 Mar 2025 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835672;
	bh=rl4bGchbGnhGJm3HPX/K4Jg2ZZTwUiWgytXyO1M/v1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E8U/56rWRPlEqYJ+vyaqxXzfJzeYAh2FaoQJvApSyZ7F8zx6H+kneVjL1c+PcBZb2
	 rs63VWjd82RBiwRfnYSZ/GH++kB6pGqljBWMUFZGvMWIBfhHziKpEFMPH6aLAMyW/U
	 Ha41y2+nm4NSqEY+hyssRChl4p8bMGpSdPYdwFrDbnPwfAvhwADJ+DngFlKvCrxSwc
	 COqnfyf2fN9XnQkL322NdrI3c3dqbN6kNeyA+0mfB1az/wtE9ZP+xkn94N1bYPkm3p
	 Qp62DZJ4+CvVXI2bCGBGG+f0BO2WTdn0sVpcsISEwsg89NKCRRXfFjL+iFUBe+IDB7
	 IrvbbIvlMnRUg==
Date: Mon, 24 Mar 2025 10:01:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Leon Romanovsky <leon@kernel.org>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Zhang <markzhang@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH net] rtnetlink: Allocate vfinfo size for VF GUIDs when
 supported
Message-ID: <20250324100103.73324cc0@kernel.org>
In-Reply-To: <20250320151150.GC889584@horms.kernel.org>
References: <20250317102419.573846-1-mbloch@nvidia.com>
	<20250320151150.GC889584@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 15:11:50 +0000 Simon Horman wrote:
> Perhaps I'm over thinking things here,
> perhaps the following is easier on the eyes?
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index d1e559fce918..60fac848e092 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1151,6 +1151,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
>  			 nla_total_size(sizeof(struct ifla_vf_link_state)) +
>  			 nla_total_size(sizeof(struct ifla_vf_rss_query_en)) +
>  			 nla_total_size(sizeof(struct ifla_vf_trust)));
> +		if (dev->netdev_ops->ndo_get_vf_guid)
> +			size += num_vfs * 2 *
> +				nla_total_size(sizeof(struct ifla_vf_guid));
>  		if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
>  			size += num_vfs *
>  				(nla_total_size(0) + /* nest IFLA_VF_STATS */

Yes, please
-- 
pw-bot: cr

