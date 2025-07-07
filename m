Return-Path: <linux-rdma+bounces-11923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03F0AFB1F9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED7E1889C24
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195F2957C6;
	Mon,  7 Jul 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6yB84aH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A16293C59;
	Mon,  7 Jul 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886536; cv=none; b=u289mbJFbnBsgm1+nvdByM+n28frXIl56TgZ1SKSNBbWzCTplAKmWKp2uZyY+cyYubauJNAyOn/ctOrMDfsUtmAJcJm/l/iGqpxUboRlhIkH8MN5SAsdB0wkCDNW5Yti6lQK2YXgQuKTE9sGbuB9ZkSYU0i/hAQGrMTd3MXSv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886536; c=relaxed/simple;
	bh=8lOBoqW9F4r2VYCO6hlejMjBBeb3V/F/1c09P5GydGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efJCRqh6VLRTgl24bCU+YNzmSSLJdP8j8tR8RYJRIMfxjGozL0MOQsO4YAXWK83L4HraFkR8RNsPIYLBf/yhxHahlw0JJw6SZbzUoo0EdipGK/vPuj/8qiBRy/retNSdFbGzpJxk2WXj+Hptv9w0lBPyw4BIXFNswnQh95Wdnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6yB84aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C131C4CEE3;
	Mon,  7 Jul 2025 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886536;
	bh=8lOBoqW9F4r2VYCO6hlejMjBBeb3V/F/1c09P5GydGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6yB84aH+lsSQECy1qfZt0G1ChpHjgxtqR9ngHVBPSANNpfxILuorGVkcohQkTQIb
	 Z9D/8nE+SibMgLWWU/7C9yedRuJYSLpGRiA7WXPLenRXX1Og8PXiJEyYX84jt544j7
	 YM8Tfl7n3EAC01gHV+U93HuxDPlBLXScX2d0aEw30esxqjAFUN9swa7Ahcmg00k9p4
	 0fZzv6pxImfOi8fk5Q1Zt+3P9uRS5AXwRSsyRLAFKzkyjMa145sSUWpo5VRdaHVNeZ
	 jtScEUe7ZUUSSW5JITJBK+YuQ9KqNq97luMUEiERteDgUaDbupNSdZYbKNBWDlqH/A
	 3vcC01bEQ3VHQ==
Date: Mon, 7 Jul 2025 12:08:50 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v3 04/10] net/mlx5: HWS, Refactor rule skip logic
Message-ID: <20250707110850.GH89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-5-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:25PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Reduce nesting by adding a couple of early return statements.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


