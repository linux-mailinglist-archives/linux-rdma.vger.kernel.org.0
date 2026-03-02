Return-Path: <linux-rdma+bounces-17382-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB3CByKZpWnXEgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17382-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 15:05:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FD1DA598
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26746303C50B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A23FD132;
	Mon,  2 Mar 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br2Gg+fs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6A3FD122;
	Mon,  2 Mar 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459876; cv=none; b=sauoHMcCRXd66d9VgSBMZy6gmygmt2j2nYHU/7CyuT95gKF+bx4qaSPLMRuMZdad8eSyXEDMiigZMusFhuEJeMyE8M+WC7rsdjHzgIfy4PkEfRQ+FLH0mH7HTOX7xDk0z1DjGTI2BTcGION5r/mOIGa6fAVNQliXJ1UVIJWdEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459876; c=relaxed/simple;
	bh=OpF63jZ1+ApPFiq+BXSePG0xAgq3xMaZe+lKNvA48QY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M0K0elX5mjyvFbHZb7WR2H73BqxMlXrPYO8P7+mwYNLVOcazmnA5kxUBeMBm1q5ylnY5rxn/MBA65VqTvcz2YyOP9YIbR64nrcjK/OtX3/kDiueg6wpCYJJA5o6EI3gHZlLLIZd91P4X1zmjyuazE7P8xT/IDy/zIEWrO0+EVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br2Gg+fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AAFC2BCB6;
	Mon,  2 Mar 2026 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772459876;
	bh=OpF63jZ1+ApPFiq+BXSePG0xAgq3xMaZe+lKNvA48QY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Br2Gg+fslmsqdebQ9Vpcffb4OAxrp2ybp/K+QoeuBBQwrwm/Z04kfTZ9EUwWI9yzF
	 czw1FXfJ7nTS0hw/Xt1xGg1GXrjREFYgkn1WHIFOsce86+UEXX+HWsAfSMpD1888Xm
	 CaSw3jYwvlO9HasbcznfnAkA0IM5Mw04emulDz/N1kfrbZfKLaMxa0qFetjHc6gV3r
	 AhFfclllmorn1K53mlosA3r8pWzOoiOMc01QA+0StVjka0sjsxxVTj+EIEsVLo2ZaL
	 ay4mHrFJBbrJIa/eIPXdOY5Q4B5b1/qt17Ak0bkWvljgA5YrkK0uX0md/le8kaOb9v
	 OaWggcUgyS34A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Edward Srouji <edwards@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>, 
 Chiara Meiohas <cmeiohas@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
Subject: Re: [PATCH rdma-next v4 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
Message-Id: <177245987341.974499.2313612318874608305.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 08:57:53 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17382-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C0FD1DA598
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 15:52:05 +0200, Edward Srouji wrote:
> >From Michael:
> 
> This patch series introduces a new FRMR (Fast Registration Memory Region)
> pool infrastructure for the RDMA core subsystem. The goal is to provide
> efficient management and allow reuse of MRs (Memory Regions) for RDMA
> device drivers.
> 
> [...]

Applied, thanks!

[01/11] RDMA/mlx5: Move device async_ctx initialization
        (no commit info)
[02/11] IB/core: Introduce FRMR pools
        (no commit info)
[03/11] RDMA/core: Add aging to FRMR pools
        (no commit info)
[04/11] RDMA/core: Add FRMR pools statistics
        (no commit info)
[05/11] RDMA/core: Add pinned handles to FRMR pools
        (no commit info)
[06/11] RDMA/mlx5: Switch from MR cache to FRMR pools
        (no commit info)
[07/11] net/mlx5: Drop MR cache related code
        (no commit info)
[08/11] RDMA/nldev: Add command to get FRMR pools
        (no commit info)
[09/11] RDMA/core: Add netlink command to modify FRMR aging
        (no commit info)
[10/11] RDMA/nldev: Add command to set pinned FRMR handles
        (no commit info)
[11/11] RDMA/nldev: Expose kernel-internal FRMR pools in netlink
        (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


