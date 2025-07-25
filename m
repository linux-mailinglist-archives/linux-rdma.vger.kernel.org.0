Return-Path: <linux-rdma+bounces-12471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53115B1157F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 03:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ECEAE23ED
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4216EB42;
	Fri, 25 Jul 2025 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S//hzPtk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5259FC0A;
	Fri, 25 Jul 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405292; cv=none; b=mpUaS6F+LmqU6lHSVbXbJnXCRSRGwR8Zt/E4sTTwnSiey1pUYdFDXXuHxNQureRq6VvbhEfd75IWxYVy3Z6GkoCrPmp/RXbumhgVZO+wHqFNDdBrVYs5AZVnczFUHb8TxgUPt3k+tbKiRq6qcRMFmWmw1tZ19ixsVxAF/IkYIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405292; c=relaxed/simple;
	bh=2xm7u3ygcZYBzCZXGoS/pCUYoBjZBFKnG8HwfR0nmZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtO3rch5zSk7+104GLb2IAb8QAcdXBQPfH9h21ByzZFzKmOg6uDDArzkF7gr6u2cq+x8IcRlxWvg51ovRVdgznxY0adMjMrphpqDG1EPHnOYH+o2pgS7fOAhBgmK/MeiqxP4Xp6s4kJkJoZ2PJPgSxLVx1zAt/dqts/XD0S2vHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S//hzPtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0ECC4CEED;
	Fri, 25 Jul 2025 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753405291;
	bh=2xm7u3ygcZYBzCZXGoS/pCUYoBjZBFKnG8HwfR0nmZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S//hzPtkrEJWtjCpMVveiikuo8YGKwG6HXKQsFWNzKhUo1FqN3Qha5XSwann5Qfh0
	 8qgq16uXtPh7baKfgU3rbq6tF4hAGNaNnQHvApWdE2oqiRU/Rl2yRN7OTZgRC+LXxn
	 95gkYGtHVCApuf2h0QczyVlYs3RTMESoE1yX5KIsoEK67EeJoHbMmVPZbujbf+67Ma
	 6pffUAXSOuY4fZWPPtXjlFUUir8R4XmbVwy2pJtTWzTWPWjBRaPHvAY8PNNw9KFuJC
	 Y7KQ6PuuG/byFbltcIqK/g9BJnpqLoyUYm2flutmNIcZ6+ldBIsg0Y2tKUUqeS9BkW
	 8WWl+mvi9bumg==
Date: Thu, 24 Jul 2025 18:01:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Brett Creeley <brett.creeley@amd.com>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 "Cai Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
 <manishc@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Shahar
 Shitrit" <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V2 0/5] Expose grace period delay for devlink
 health reporter
Message-ID: <20250724180128.338977e3@kernel.org>
In-Reply-To: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
References: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 23:48:49 +0300 Tariq Toukan wrote:
> This series by Shahar implements graceful period delay in devlink health
> reporter, and use it in mlx5e driver.

You waited a week to get back to me with the reply to my comments on v1:
https://lore.kernel.org/all/6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com/
and 10h later, before I had a chance to reply - you submit a v2. 
Not very demure.

