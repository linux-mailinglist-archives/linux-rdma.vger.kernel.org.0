Return-Path: <linux-rdma+bounces-11481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71FAE0F8E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 00:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B85016E7C6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D8228C86;
	Thu, 19 Jun 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwbEl1Rg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2B30E833;
	Thu, 19 Jun 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371773; cv=none; b=K4FW8wT9ZYPLC2w+0W1pG5HEH9Co2v359MEDatrjsj7YHvB5jszD+hMBLKeYW8JzjR2XK8Hxkp6K7Tc676XoGhIgszK88hAB9dIH2/6TAWzd1YrcU2bW40hS9adiyMmIHF01ykuoqSClNvdDJPH+34lW9ym33w5pxdd1fHWnJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371773; c=relaxed/simple;
	bh=uuNeXpgmEWXpmKFqM5fGOcTUU83w5G+xQhwv58hyrIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT+xtNBvofMxMTerRvkbB++SBfxTJ1ib80ZbplSAwZnfAae7wi6htYuBox6BQAqnNksx4zqpSHJLPCPzlWpjpQSu4OpflNof+reMRw4ps+rCxQ5JBy79DjCGDlFrRom4bVfuPF9fIVZtB5oX3pGD+MJniH2qhKs5Ns4gbMiw/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwbEl1Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1510EC4CEEA;
	Thu, 19 Jun 2025 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750371772;
	bh=uuNeXpgmEWXpmKFqM5fGOcTUU83w5G+xQhwv58hyrIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SwbEl1Rg+yOe+lOwKpPUYYcTnGZpOdKAeO5wLLkfbfzgx/LdXdH41OMCKRQwqhFhT
	 bUxv7wDb28iStyvWAgR1FOUM5irshO3X68EAhZ7VVxwLY76+uyNzqg6gsyTYzuJy4O
	 L+BZPLqAGzPgJgg2WZ+n4E1qOLRqZyWSsKJujNzg38JabZHtbVU1ZZ2Xs2EqxP0g/T
	 5jdORCr71TLpJs9KGg16PcdnDO32VRJ9mF9iFO+JYKiy1f6iHJ3O0zVeQPw5Usulh/
	 mKU8qH49+v8zV6eQeQpeAT50Pv3tF4TAM0a/q0mqgwAzLaSW9U1cO6l3Hr2j/oYoIs
	 hvq4qJw7kasfA==
Date: Thu, 19 Jun 2025 15:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net/mlx5e: Add support for PCIe congestion
 events
Message-ID: <20250619152251.5005d727@kernel.org>
In-Reply-To: <aFRiuIPidlx7Qsy9@x130>
References: <20250619113721.60201-1-mbloch@nvidia.com>
	<20250619075543.1d31f937@kernel.org>
	<d9bcc48d-17a2-4d12-bacd-6bef296b45c6@nvidia.com>
	<aFRiuIPidlx7Qsy9@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 12:19:20 -0700 Saeed Mahameed wrote:
> I think what Mark did here is fine, Yes I understand this is not
> applicable to net-next yet,

Yes, once again netdev is the problem.

> but the point is review and we can do the following, when review is done:
> 
> I can Apply the mlx5-next portion to mlx5-next and Mark on V2 can send the
> net-next stuff + A PR request to the mlx5-next branch, this is how we used
> to do it all the time, but this time review happens all at once for both
> trees.
> 
> Jakub is this acceptable ? 

Don't complicate it, please. Send a PR with the interface patches and
we can review the rest.

