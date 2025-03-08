Return-Path: <linux-rdma+bounces-8501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A31EA57DC3
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 20:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D053A16D74D
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F921E834E;
	Sat,  8 Mar 2025 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKfQr1az"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827C7482;
	Sat,  8 Mar 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462297; cv=none; b=TJh7fwBx1IBWPQkvL9fmNW9+6CYYsZDdFID9q/ZwUcr3Zzuiv5+3X3nkj74y9W6U4JkLcn23YquPmosEBaA57x61tuylOIJqiTbmHp49YfEsWRiDdv38bv/XqalC9E5z0chVC0sqoeP5QaEkMSY7hzNvgjQNe0UB92/oIjhJI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462297; c=relaxed/simple;
	bh=1jyjnTRZLxuiVvw0hxz+UHM7456URTNFpheHyEXKrSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tg8KMgQFark1/D3ZfbmgjbLqOvLCEn0iG26+3ltUdPNJRecYVR6K4vp/bPTCTw+ENCMUZoBMhKH8St+t+O2CnZbgCfKJVnbkm7aH7OJZluqHf6dN208SqCDD/PiY5j6PM10vW/JWQdSU8i2fXPuKQ20inUeb57ULo/IunMrhAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKfQr1az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEE9C4CEE0;
	Sat,  8 Mar 2025 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741462297;
	bh=1jyjnTRZLxuiVvw0hxz+UHM7456URTNFpheHyEXKrSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iKfQr1az/pZygt3GhjBUTyn+WF0autac7wD8uGHr0VM2on538GHoiLbHY/IesiKxQ
	 3/hnzO8UUfnDNzUS1EBtdFlPL5hjqpuFtBfO8WgwbnF5ECVcw9+MXcRMq7gC2lvgVE
	 ty6rY4yX3k69NQWATmVVzncULkYuLiH0KOYjqAIqyl4X989epYxaaSoIgmdKV+ycbe
	 5EhdlLHf4q0541pMK7+5egHxY3gfL1uEBqfoNadm/+AKufHyUNAlyVV9R/9MoUAvDq
	 6j4jQsvYzHJk0CA8lGyr2PXjjv8uFfUnT8HHNLDNXNQDMdubBVW32gC269IcSxo4mY
	 4+ClqmYRcQOOg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1741097408.git.leonro@nvidia.com>
References: <cover.1741097408.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Add optional-counters binding support
Message-Id: <174146229393.310407.731855525292951254.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 14:31:33 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 04 Mar 2025 16:15:24 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> From Patrisious,
> 
> Add optional-counters binding support together with new packets/bytes
> counters. Previously optional-counters were on a per link basis, this
> series allows users to bind optional-counters to a specific counter,
> which allows tracking optional-counter over a specific QP group.
> 
> [...]

Applied, thanks!

[1/5] RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
      https://git.kernel.org/rdma/rdma/c/30c77a88e3ffe9
[2/5] RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_obj()
      https://git.kernel.org/rdma/rdma/c/3644e21c005fcf
[3/5] RDMA/core: Add support to optional-counters binding configuration
      https://git.kernel.org/rdma/rdma/c/df5f4ff6319a6f
[4/5] RDMA/core: Pass port to counter bind/unbind operations
      https://git.kernel.org/rdma/rdma/c/d73531da19eb56
[5/5] RDMA/mlx5: Support optional-counters binding for QPs
      https://git.kernel.org/rdma/rdma/c/7bcd537adb21b5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


