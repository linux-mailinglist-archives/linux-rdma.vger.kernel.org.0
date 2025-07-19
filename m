Return-Path: <linux-rdma+bounces-12313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D824B0AD07
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 02:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB69AA1E3D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BE54279;
	Sat, 19 Jul 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFghbRVZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729224C6C;
	Sat, 19 Jul 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886060; cv=none; b=qtnPRyCZkXRqZhgCgeyV8pZTPAdns+Ri4U41EH7D2xQ+VwGDQICIyemziOw2fIdQUntFeHpo8Ix5JXzKtje083mVNT2oN4JrToRB0aPHPXqDnFhmF2/72GIyRkiAa4Q8XlJiHTtEBEuCFOltczIFPT/utRss+lFK1FnebKhm7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886060; c=relaxed/simple;
	bh=XWuJCJJk0aV1qvt1Ws58hkJTkIsuqdkQoYz9oZwo0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNsTNeBUENVa+iXYeZTgPYFycb8hSJTuNibQot8vZgVDWDIHaVanB24OXN+JnZaB4bfutZkRJV9EkiVzQ8qDJBQhD9pjNV23pR3IHBA1y9v4mupv5TLLjscmzKnoNuP4M+o/sDLXEeLOsWT9an/Srevh834bUpc8muo06beydzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFghbRVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2896C4CEEB;
	Sat, 19 Jul 2025 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886059;
	bh=XWuJCJJk0aV1qvt1Ws58hkJTkIsuqdkQoYz9oZwo0A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rFghbRVZUQtS04xAEUavFtutQFmD8yLdkuOrSdpLL7c0Na4XiUXsAtxW6wDwztw3w
	 XhxiZbMRo6PVPayxGEye1e9kHjqqmPfuSBkibINJfSce7CBGXv/MT2QAV5v+9GnLhM
	 muW7QjvrVXFzBX7jB+1tCZKE3bF2HIlgZBGVT1Ob16bluI3YuNWd8JLqfBpiUDAzFc
	 x58WpHF08HMRyq/mc4j5jIMTFtC9DVVGIbAafBzvCyAMOadb+ggVDkBBYt41qDGvHI
	 4vyhzzN0OPjTENEdko/RT71JSsyxVMDx125WBvK++u53IkIExjDt4y0qQBC74xrugD
	 IATv9Up02IfUg==
Date: Fri, 18 Jul 2025 17:47:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
 <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Shahar Shitrit
 <shshitrit@nvidia.com>, "Donald Hunter" <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, "Brett Creeley" <brett.creeley@amd.com>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 0/5] Expose grace period delay for devlink
 health reporter
Message-ID: <20250718174737.1d1177cd@kernel.org>
In-Reply-To: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 19:07:17 +0300 Tariq Toukan wrote:
> Currently, the devlink health reporter initiates the grace period
> immediately after recovering an error, which blocks further recovery
> attempts until the grace period concludes. Since additional errors
> are not generally expected during this short interval, any new error
> reported during the grace period is not only rejected but also causes
> the reporter to enter an error state that requires manual intervention.
> 
> This approach poses a problem in scenarios where a single root cause
> triggers multiple related errors in quick succession - for example,
> a PCI issue affecting multiple hardware queues. Because these errors
> are closely related and occur rapidly, it is more effective to handle
> them together rather than handling only the first one reported and
> blocking any subsequent recovery attempts. Furthermore, setting the
> reporter to an error state in this context can be misleading, as these
> multiple errors are manifestations of a single underlying issue, making
> it unlike the general case where additional errors are not expected
> during the grace period.
> 
> To resolve this, introduce a configurable grace period delay attribute
> to the devlink health reporter. This delay starts when the first error
> is recovered and lasts for a user-defined duration. Once this grace
> period delay expires, the actual grace period begins. After the grace
> period ends, a new reported error will start the same flow again.
> 
> Timeline summary:
> 
> ----|--------|------------------------------/----------------------/--
> error is  error is    grace period delay          grace period
> reported  recovered  (recoveries allowed)     (recoveries blocked)
> 
> With grace period delay, create a time window during which recovery
> attempts are permitted, allowing all reported errors to be handled
> sequentially before the grace period starts. Once the grace period
> begins, it prevents any further error recoveries until it ends.

We are rate limiting recoveries, the "networking solution" to the
problem you're describing would be to introduce a burst size.
Some kind of poor man's token bucket filter.

Could you say more about what designs were considered and why this
one was chosen?

