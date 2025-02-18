Return-Path: <linux-rdma+bounces-7800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C20A38FEA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 01:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7F77A1BE0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F0B660;
	Tue, 18 Feb 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5eFKvk+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F118F40;
	Tue, 18 Feb 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838442; cv=none; b=dnmG6XJV4wt813oLx5KTTgeReH7tXfhgfXCYLyNk+Me4lxGeNYrbc0CoUxUEoPRWGU7KzL9adts9ORf1SPk7yxZCxDYK/6JyDSNTUIDp8iNkyKbUwXrEJb+nKuGT+YD9ILYroehiGeglzQri6zL0p+TGIZunfftGDuI2frdGw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838442; c=relaxed/simple;
	bh=ZEgQ//xY50OgJZV1eRCl9eh/0wLOmAsMyto2nZFDG54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNbSlajQWmOoyMywrUmq8tDvWHQJ2wWFxeSTj9jneFsj6HQgbC/lAgmu9vURK4HJvXIr++CpquEral1MuuPAHcpCtdVH4AMAKb/2iYO2Tbo9INKPfOh0tFyipnVaFGNRoKislE0qxyB0hir9/uXBJ5aPYt5hjiPxEy5+j9izhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5eFKvk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EF9C4CED1;
	Tue, 18 Feb 2025 00:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739838441;
	bh=ZEgQ//xY50OgJZV1eRCl9eh/0wLOmAsMyto2nZFDG54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5eFKvk+tEJ0RtnV3TxJZH1RWD+mRL31B51pjjQG5O/76GYTF1HreYcas+MpFE6gN
	 bKjF5dELIvC0Z00buSSBPMaLGsPTpGb7ADtF/Vp7XrWJGhndxqBfq3NkKSL6bxrda9
	 LUmNdsGYkzSlZ++2UTYwsdsxlva4902XRS3uMpelwrBf1kSUhdXSvuoIbrYbFnfsKS
	 pEtVUesbixbPzraXvoAmI0ELHOsIR2g0yjbhB0iX80z9ck7tiMEzEJEYZd8mkqXthH
	 4Kbc5L1frOvDas9EmcuslJUvCbFiIbJIzmcBZahbmtBTDHU6OlcIlSWKSMDN+r1BqV
	 WfaXQ8bh/61vg==
Date: Mon, 17 Feb 2025 16:27:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shahar Shitrit
 <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature
 event message
Message-ID: <20250217162719.1e20afac@kernel.org>
In-Reply-To: <20250215192935.GU1615191@kernel.org>
References: <20250213094641.226501-1-tariqt@nvidia.com>
	<20250213094641.226501-5-tariqt@nvidia.com>
	<20250215192935.GU1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 19:29:35 +0000 Simon Horman wrote:
> > +	for_each_set_bit(i, bit_set_ptr, num_bits) {
> > +		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
> > +
> > +		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
> > +	}
> > +}  
> 
> nit:
> 
> If you have to respin for some other reason, please consider limiting lines
> to 80 columns wide or less here and elsewhere in this patch where it
> doesn't reduce readability (subjective I know).

+1, please try to catch such situations going forward

