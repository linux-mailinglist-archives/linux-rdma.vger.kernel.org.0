Return-Path: <linux-rdma+bounces-12307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA5B0A5BE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD7C5A7919
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F22DCBE0;
	Fri, 18 Jul 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2h6XiNe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BA2DC337;
	Fri, 18 Jul 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847154; cv=none; b=RESIab3ykyeuZ4ul9XlHEQRe4QWctZJ6wdKwb7cLTz5SEOP3lZtTwA6zwOJGH7ZLo88l5nHr+bk6M/858psEypaMMS8DFolXi/R+1PC8cYEL4Rovq2ZN6w6cr1fAxkxEY+Z8TIS6ngh+fEK4rnuSiG1QGgvRkPyYCdw4sQ+60pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847154; c=relaxed/simple;
	bh=UJ3UCdbYr6DZ8AR+X7jU/IAtrwmerjFEQ6XfAsgcsNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7h2SFCZssjbSYVW9ubqelJfv2NKt9yWv+86XCKKXpIrmI8HAtRM5R8gT1aeNaBKGLV799GSvOkdnwZ4MDkuLhuggXKGp7eLC36RUdZNGFFzKrRdbWFiwUEfz7DwyB/Nc6eh4v+G03QeqZ7aVTbCy8oXXGYVVc/rxwujzwZlyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2h6XiNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51798C4CEEB;
	Fri, 18 Jul 2025 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752847154;
	bh=UJ3UCdbYr6DZ8AR+X7jU/IAtrwmerjFEQ6XfAsgcsNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2h6XiNeDdZXYNJXAZLmn3d9A80w9sgI5bvlQoXTQKHl12zivloo1v4cduTmXt4Tb
	 4Uj/OJSKSnwCDNTRdJRhT1HmPe5qlGWFid4CZRuWOdnTfQYyFk6d8qcjgeEn9ViYyo
	 vek9Si3g4NiTv1NoNcH6B7rXY1/RqCyMCEqVEnfQNgkVkroB2mp4mQgz9oSp+ZsMt/
	 6yZQljUFUIEDS4BJIkkNMowuoa53jYdeyufLuLGM/AGFHwLcTQXryRRM/oDog9SbZn
	 hpnLxZH/RnDKu4WjXaqnfnWuh0/qJgbAc8PrScw15YKWBNF3DdAdjp02RyGHpX4QwW
	 Jg68iuC5XCIIQ==
Date: Fri, 18 Jul 2025 14:59:09 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net 2/2] net/mlx5: E-Switch, Fix peer miss rules to use
 peer eswitch
Message-ID: <20250718135909.GB2459@horms.kernel.org>
References: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
 <1752753970-261832-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752753970-261832-3-git-send-email-tariqt@nvidia.com>

On Thu, Jul 17, 2025 at 03:06:10PM +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> In the original design, it is assumed local and peer eswitches have the
> same number of vfs. However, in new firmware, local and peer eswitches
> can have different number of vfs configured by mlxconfig.  In such
> configuration, it is incorrect to derive the number of vfs from the
> local device's eswitch.
> 
> Fix this by updating the peer miss rules add and delete functions to use
> the peer device's eswitch and vf count instead of the local device's
> information, ensuring correct behavior regardless of vf configuration
> differences.
> 
> Fixes: ac004b832128 ("net/mlx5e: E-Switch, Add peer miss rules")
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


