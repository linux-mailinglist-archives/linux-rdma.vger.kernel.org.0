Return-Path: <linux-rdma+bounces-13519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917CB8AA6D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637945661FA
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE131FEFC;
	Fri, 19 Sep 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOgl9Jy4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E54241665;
	Fri, 19 Sep 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300920; cv=none; b=Mx+j1ieYiEkw+108nVsVhCPlStpR71f0xdKhKFAZPgTZIhaQvGZd+vc0iiCB7gUlAqHiKN5fij/CDKqCORS3eVtDBuskfsAewiRYXRnkG3R6SsqwrN3hitIfzlHMALfhMfOkFIXQDsRA6fn9UpRzpEoGzoPryjKNnCmEOoDWwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300920; c=relaxed/simple;
	bh=p9xSgb/by5KzTQC9wcVAcHSIVEKzi/zwG++yqatSoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chmEC3SSgeYcvxVCW1kW19OYWqjs8kYp6AuO4RuYXTn+MUgqEn0VDOBDXyAVaR83rcRfSh4aXWknS444JHzo4wyrDYwl/fl7KviH0GLRX3Io0wJ57A5UKixMy5QRhBvk+ZSHZrmxglq7i03nSJMwwWoVGQcvcxuT0KcPFaV6TUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOgl9Jy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F2C4CEF0;
	Fri, 19 Sep 2025 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300920;
	bh=p9xSgb/by5KzTQC9wcVAcHSIVEKzi/zwG++yqatSoWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOgl9Jy4pTb4PjbMByu9d/tPnn4JbXLgVAILkVvlYmFhkaNxaly9sNhC4ZeZadEa+
	 Mk5PAIxnwkDNsZUvFCxPLUcEEAYM1kAYxO19v6DfSNpZY00P5inHvayscprs/rpVCm
	 TNThH8bZVatCNHBQM+/J4t4icON9dDZb0VoZmKEJrTYeRMQ3YGu/HdkPohe0dIYDQ5
	 DDi3MU/Vu70BxhbrRuGeoFD3KyI7hcvu8x2WZHFVnUw/MGwMCLwgJnWdtjnbtOPifK
	 QBnQ9t33UZLxwbkOFk926TvSb2tBzVM567WRnWb8rp5ukKMvhJnZpdpgb5q0AcW5NT
	 AfCLc1jiZz1aA==
Date: Fri, 19 Sep 2025 17:55:14 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, cocci@inria.fr,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5: Use %pe format specifier for
 error pointers
Message-ID: <20250919165514.GC589507@horms.kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758192227-701925-3-git-send-email-tariqt@nvidia.com>

On Thu, Sep 18, 2025 at 01:43:47PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> Using the coccinelle test introduced in previous commit
> (scripts/coccinelle/misc/ptr_err_to_pe.cocci), convert error logging
> throughout the mlx5 driver to use the %pe format specifier instead of
> PTR_ERR() with integer format specifiers.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Alexei Lazar <alazar@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Simple, mechanical change that improves readability.
Looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


