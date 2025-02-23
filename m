Return-Path: <linux-rdma+bounces-8018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E162CA40DC2
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACAE3B284C
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5052036F0;
	Sun, 23 Feb 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd/NuYoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C21C84BA;
	Sun, 23 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303826; cv=none; b=g6wvZEqlblIAldbzzQ0vJZiKclENfnPISqsYXFBhJphf4UK2IixUpm7nuVXSRf/UsIbO6LRJZ6Dt2VIr8zxHIIzPh74oCGEx5tAlf6izo0sLjfSfG/WlbdyHErVoJRQqUa5C3d9zHHJ4j4oEfw3ZsnD4PRujp3GdrwMh5bYqWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303826; c=relaxed/simple;
	bh=ivkyYIRjD3iDkUC0J1Fw+YA3hXSkIW5vFdgvdSMRqk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kVCrM05tVnXx6rfXwd3UKQqnFzjgFf5GY8YrqwHP/X4r05Rxr54dsv53czql0HCH34MWxOtikQMtN5A1C87u8UzB9Sun+qh3nFAeiHus4dmSASdxyz84sDQn9g/XJw43VjPmXvRC4sgigK/pYggz8WJzp+X8FQFDUmMXASrpwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd/NuYoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6CC4CEDD;
	Sun, 23 Feb 2025 09:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740303826;
	bh=ivkyYIRjD3iDkUC0J1Fw+YA3hXSkIW5vFdgvdSMRqk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Bd/NuYoH12fJ5181S4Yt+eoA+il9FpikOq2cULXtuJJNNshxHeb+DSiFD63DWci17
	 7C6FNkS9yHwT1auHE1s+1woSjRJSObTH6pUGtW1ebfv1xL676F8M/7Pe8e5AqklZFW
	 5NzoGO3B16gJK3qiNNZ+XjSUQqZEnsp/G3NaJ6ThACdeEUVN3qwQPLe/Yf4QHsOmai
	 atCpWfZiZXXBYm7RbHvHncKfbLODbqT8tUPxINmMOVtPVfgfbKoVceUefiKrpT6Jw0
	 yo8YjG1hTXch1tciP5m26w78pmsZelS5/wA056038irYjhVzyIIITlLuJMLrZXZDd4
	 +q/zF4F54kkzQ==
From: Leon Romanovsky <leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219085808.349923-1-tariqt@nvidia.com>
References: <20250219085808.349923-1-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2025-02-19
Message-Id: <174030382258.497750.8800825927872509906.b4-ty@kernel.org>
Date: Sun, 23 Feb 2025 04:43:42 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 19 Feb 2025 10:58:06 +0200, Tariq Toukan wrote:
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> Regards,
> Tariq
> 
> Patrisious Haddad (1):
>   net/mlx5: Change POOL_NEXT_SIZE define value and make it global
> 
> [...]

Applied, thanks!

[1/2] net/mlx5: Add new health syndrome error and crr bit offset
      https://git.kernel.org/rdma/rdma/c/531ca2b9a215d0
[2/2] net/mlx5: Change POOL_NEXT_SIZE define value and make it global
      https://git.kernel.org/rdma/rdma/c/80df31f384b414

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


