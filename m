Return-Path: <linux-rdma+bounces-5923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA409C4CB3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23B1B22377
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC6204F6C;
	Tue, 12 Nov 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw2K/BCn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761C4206E;
	Tue, 12 Nov 2024 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379097; cv=none; b=Bu2SubE/+CIEKctUgNVBnTb3DKzj0Fpatv+F4lL2aMNsoWRS2pU3GcYjVrT5abG3kqy0JwuvH/HCN/K2n/g36lRpTpL3XRpLRIAJHyC5ji+2DT3I7NJq1iqiW1nkcpr2UtHznvjlAyOo0NYr0IXPVRnYJwqYPgiyuUlMP3T7RvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379097; c=relaxed/simple;
	bh=Z2tElrgtXWs2mL9ir69TYsaaIcF9mG5lgXAywvxFvco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9lE+mEauxtNHwkDI/riVE6+8okZtKyNfw/i01OccDweo7dyl0ZjW0XuOItnAgX4husBWkhrq4ey5B/jcPvFgJu6wyhmtvr4/EtSFfdQM9CtzLy/DgBl0IYy8vS11ZxAvqGNZeyTRY4fHy34JpH4hzRrxuKxfKSYe9n0uVwN6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw2K/BCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43A3C4CECF;
	Tue, 12 Nov 2024 02:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731379096;
	bh=Z2tElrgtXWs2mL9ir69TYsaaIcF9mG5lgXAywvxFvco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cw2K/BCnWBy08LE6bIgofxDciz2gJLYKem/FI9U+ac0dfDhyyAfCbIiS7nHzr7OSk
	 F14m7XsDwwUcq4a9FBPFAIPheQ+ELDjIBi0wT57mDmi9GJIillri+QRvKXrVTLAq7O
	 NErWVNgEm2x4uuT+hNZurLiWayxuGq2ThtlnoOOLWzHYPdujbWueKMi9+GDab5C38J
	 tOKWrleE9Zrp/Ql6z9dmeNnTVQJlbkO5bWF9VJnlYfPno0eixM618peTL7dJzmRnL3
	 0xRSH7FMJcSTrs/NZ4tnkJ0gCOeeUlsTSryHOmUOc/DWqVXkEcMywo0vvQndt83ptb
	 vvDFe96OH2ynQ==
Date: Mon, 11 Nov 2024 18:38:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Parav Pandit
 <parav@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in
 eq_update_ci()
Message-ID: <20241111183814.264205a9@kernel.org>
In-Reply-To: <20241107183054.2443218-1-csander@purestorage.com>
References: <ZyxMsx8o7NtTAWPp@x130>
	<20241107183054.2443218-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 11:30:51 -0700 Caleb Sander Mateos wrote:
> The memory barrier in eq_update_ci() after the doorbell write is a
> significant hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see
> 3% of CPU time spent on the mfence instruction.

Applied, thanks. 

In the future please avoid sending patches in reply to older version.

