Return-Path: <linux-rdma+bounces-14340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76FC43B9E
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 11:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A4F3AE8FA
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E482D5C6C;
	Sun,  9 Nov 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVCX2C2P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22177214812;
	Sun,  9 Nov 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762683750; cv=none; b=FvcY6aGt2vRRnUPXW6O+/ZOsDT2DwJgoFQ/bsKBrSI+GJXeYEMHHiILJbvpOVXa/KZa2SOMHDmROFp96wWKJcm2UIuF9/8+JFXvLdvFvv7IFEZZpctei29aKiZ9UT9T2Orf8Il0saRaTsahPDCwC3p7aCwAQcN6pPGYC9c1l7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762683750; c=relaxed/simple;
	bh=gzhE7u2W8nxp5TvyA8HScnLaHS/0XfLFY5QDEZm7vCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuYonKZo9aQZ3yR8ABiqzyou0b1K8p+lvJ0E42dqFhKTBab53RVM/nORDoHironBLJZng+5RaRe//vhrKXNvr6cWm5hbbXajNBmFHuCyYUKL8n1XlMNZUdQ0sQTXW0ltHdY0+v95JZNxz0RwqgsvNUfHixGk9fU7WBZN9hfApj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVCX2C2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F4C4CEF8;
	Sun,  9 Nov 2025 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762683749;
	bh=gzhE7u2W8nxp5TvyA8HScnLaHS/0XfLFY5QDEZm7vCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVCX2C2PBCPz02KvRb2dRu0wanZrqIsvae0EFWDprJH+xghTc8yx9lPlQGtayIUOi
	 QEF2/DYvXxsQhbflFsU2+EXljmLZfNEQNhfNbPDqi2btYgSaOkssBGxD1nvpKOUhLi
	 QetshCT/FKq3cqOe3fimIjgwuT5iV/2TBFzegNiODSpSMXY6JcMG03fT7eVxtbCoZd
	 rbE+XzBwOlVTv4pd0YYhpU6Xi2xO5sQeEL22GRqnm75nBgNQ7zZqYIAN2IKRpd1HUV
	 FU5Q8QjhgIJTLo194q4AYMPirNaRiyxwpgc4+2nlg6FJTcBVbsnkIUYL6kp8lA5kw8
	 YzC/nVXYl88ew==
Date: Sun, 9 Nov 2025 12:22:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH rdma-next 0/7] Add other eswitch support
Message-ID: <20251109102224.GI15456@unreal>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>

On Wed, Oct 29, 2025 at 05:42:52PM +0200, Edward Srouji wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> From Patrisious:
> When the device in switchdev mode, the RDMA device manages all the
> vports which belong to its representors, which can lead to a situation
> where the PF that is used to manage the RDMA device isn't the native PF
> of some of the vports it manages.
> 
> Add infrastructure to allow the master PF to manage all the hardware
> resources for the vports under its management.
> Whereas currently the only such resource is RDMA TRANSPORT steering
> domains.
> 
> That is done by adding new FW argument other_eswitch which is passed by
> the driver to the FW to allow the master PF to properly manage vports
> belonging to other native PF.
> 
> ---
> Patrisious Haddad (7):
>       net/mlx5: Add OTHER_ESWITCH HW capabilities
>       net/mlx5: fs, Add other_eswitch support for steering tables
>       net/mlx5: fs, set non default device per namespace
>       RDMA/mlx5: Change default device for LAG slaves in RDMA TRANSPORT namespaces
>       RDMA/mlx5: Add other_eswitch support for devx destruction
>       RDMA/mlx5: Refactor _get_prio() function
>       RDMA/mlx5: Add other eswitch support to userspace tables
> 

Thanks, applied.

