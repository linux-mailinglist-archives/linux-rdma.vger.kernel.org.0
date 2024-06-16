Return-Path: <linux-rdma+bounces-3166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE2909E2F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487471C20C72
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E914A8B;
	Sun, 16 Jun 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1hYyAqb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5C11CAB;
	Sun, 16 Jun 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552306; cv=none; b=HhLreYLZJt6oRng/jZitAWoCD0RB3qKRZ7Q4MYEEu295ufWJFszuuIgqj1sefP5soNmg+oM4HK3k4Me9G7aCoKMDQOR2FB3f5NkGOtmJPgqvraQ2futorwjGj2irKdBM9LbQOr/3aMFDXY3sIJ+N/6delAyw7xpAmpENE60jeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552306; c=relaxed/simple;
	bh=gaiDuH/UwxUBAbTw97a7QxxnL1TjSr3yzzQI0+k68W0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QIsdD7gM2LffiqcYu/U59biLCp29It7K13pqRrh8T1KlaXpyYFp6XDoTTSMAHqL77n/rZ7qPMin2raQuX1yaEOvKZmwW+/5J5+YGIGUhZYMtpGOy0X+Avsd7TbCAyfs01NAfvNh6YGaHt6+ALKhyzdKqHvG+5dKY4TKhc+ANWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1hYyAqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93F4C2BBFC;
	Sun, 16 Jun 2024 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718552306;
	bh=gaiDuH/UwxUBAbTw97a7QxxnL1TjSr3yzzQI0+k68W0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b1hYyAqb/mYWA1DX6VA/jwYFqDgqTnJ5W17J2FzGzsxeowRnLsyJZPFtnBxNmPtWV
	 8L/3tnqRqXk92/2rztAvnLVJqpiXS7WiMyWwcQq6Ws3ogPLdHbJ1kWq3GV125XlnCU
	 sF6go6+uaAP8sY4j0QUvXXPiSEzY9yFFlE7KitOhnGTJI38SWBuQX7FWV/qyROLOJQ
	 RPSbRtZ2YP7DL+rgA+aKhm5G9OnRD/0TIeQTPCAOffXcqlEWkvwh+6L3IMmw1CvtQ7
	 cqEj+16b4DgofCYEJgn5NC2F6P9PAFzeuWtJzQWef3pJOr8fzgQ8DE4ITiQ/kKaZuG
	 N4AnmeOcI/k9g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Jianbo Liu <jianbol@nvidia.com>, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1717409369.git.leon@kernel.org>
References: <cover.1717409369.git.leon@kernel.org>
Subject: Re: (subset) [PATCH rdma-next 0/3] Delay mlx5_ib internal
 resources allocations
Message-Id: <171855230192.136500.7249427705216716337.b4-ty@kernel.org>
Date: Sun, 16 Jun 2024 18:38:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 03 Jun 2024 13:26:36 +0300, Leon Romanovsky wrote:
> Internal mlx5_ib resources are created during mlx5_ib module load. This
> behavior is not optimal because it consumes resources that are not
> needed when SFs are created. This patch series delays the creation of
> mlx5_ib internal resources to the stage when they actually used.
> 
> Thanks
> 
> [...]

Applied, thanks!

[2/3] IB/mlx5: Create UMR QP just before first reg_mr occurs
      https://git.kernel.org/rdma/rdma/c/638420115cc4ad
[3/3] IB/mlx5: Allocate resources just before first QP/SRQ is created
      https://git.kernel.org/rdma/rdma/c/5895e70f2e6e8d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


