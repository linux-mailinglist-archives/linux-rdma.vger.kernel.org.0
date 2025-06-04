Return-Path: <linux-rdma+bounces-10952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE3ACD5CF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE065176421
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B663139CE3;
	Wed,  4 Jun 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL8Wu+HT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107D28EA;
	Wed,  4 Jun 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005424; cv=none; b=KBjEGrpQumKB3FZ2NcZ9DKNwd+JNoZXxhD2Z40Ql1CNM5AVbD+u52OnRHfdueRFo3VG0IjYjKKS5cHvSlU7jW6ErUEy50q8lh9l9pR0LjYNEtBQ/w33OtzCitcLrU6ickqM2Q+4lBsju73u0bmIvJwIGRYGuaTiyrFUsX7C4uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005424; c=relaxed/simple;
	bh=PQsWGdIeUe+/p25m2WRW2U5NqQNh6YYdL0YPGhe4ubk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiHw8a5rP4bVDCQllQZx1/kkUvO+PnRIXv0HbZI0j52d6IhcgcBGtZaxgtnjOoaXrOLwqG6ivIrcpZ1cGJlGY60JIY0UCkCb/UIneT79FTZ/cAEaWsdjovE77OYPYk8oAU/uAR9pnp2qk8/YO3tPfTKny0yloV+BeeqzVpiXG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL8Wu+HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1297C4CEED;
	Wed,  4 Jun 2025 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749005423;
	bh=PQsWGdIeUe+/p25m2WRW2U5NqQNh6YYdL0YPGhe4ubk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HL8Wu+HT1KfcmIsuRy4jhUAZjJvvYrLhWCWKszRD/N9O9elm4bkP9le7yRXkKRa1q
	 oi8Jw6wA+TWwaZtZYumLO2XFbDnQgDUuHLwBg5a/B1MG3xL7zHrfbDLlO6uVLUtnWf
	 wmpE/l5CxbiC5qpIIydq61epq9iXC4O9gi2rKaQPz4H1x4RelFTeEKafTdeefKjNQz
	 nlebuHi83CCPgCI4Iln0CA6gEFwLzyxRe1ZYlVnVSysjFajXGlbY1ebPK8ZGfiLtid
	 3uO529sSI1BZhy+sHUY3QER2zxsKDi3sw4n1ohfWzgMeNsh7+lw2OIni2Et+Xj9bOQ
	 xRCXCg1SN01rg==
Date: Tue, 3 Jun 2025 19:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yael Chemla <ychemla@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Log error messages when extack
 is not present
Message-ID: <20250603195022.3719b2a6@kernel.org>
In-Reply-To: <2c0f4a69-dd90-4822-9981-faa90f7a58a6@nvidia.com>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
	<1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
	<20250527174955.594f3617@kernel.org>
	<2c0f4a69-dd90-4822-9981-faa90f7a58a6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Jun 2025 00:01:05 +0300 Yael Chemla wrote:
> Ethtool APIs: While Netlink support was introduced around versions
> 5.6=E2=80=935.8, many LTS distributions (e.g., Ubuntu 20.04, CentOS 7) st=
ill
> ship with older userspace ethtool utilities that rely on ioctl for
> certain operations. In these ioctl-based paths, the extack pointer
> passed down to the driver may legitimately be NULL.

Ubuntu 20.04 is EOL, and so is CentOS 7.

> TC APIs: Even though TC is predominantly Netlink-based, extack can still
> be NULL in certain internal driver code, legacy handling, or specific
> test/debug scenarios.
>=20
> If a narrower scope is preferred, I can revise the patch to include only
> the ethtool-related changes, which were the primary motivation behind
> this work.

Do you expect the users to update their kernels but not be able=20
to update the CLI? Finding and migrating the stragglers to netlink
is probably a better time investment. The "print to logs if extack=20
is NULL" idea keeps coming back since the early days of extack.
We filled the few remaining gaps since then (mostly the ability
to use formatted strings). We should only break the general policy
of "users should switch to netlink if they want meaningful errors"
for really narrow, and well defined cases.

