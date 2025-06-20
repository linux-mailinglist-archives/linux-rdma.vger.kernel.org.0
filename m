Return-Path: <linux-rdma+bounces-11498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F55AE19A4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CE33BB875
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC90289E23;
	Fri, 20 Jun 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2wrkJE1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449E289353;
	Fri, 20 Jun 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417817; cv=none; b=b/kNymzKnbwy7rIhGbfU+j1mLjzxqW+4v7F7z54FFx6SHTf+eQFJycGTcZ1ZFQ2xlsb+fRfdy3FY9ODOJKJni63453/LkHjTVppp/6g8mp1+Zs6CX5iCERZyJ8jmbE7c7hBHbcTye6lml6Vel6/wWcu0KmsnPY8rJla9FiC6fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417817; c=relaxed/simple;
	bh=uvtVP1aYMUTlFmGxU79MyL6lu/a9tI++Kn5yo964ngw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VZZIbJCt/BIBPiRXnxxGU3LrBTqMhW9UhoDmIa1/2960dzFOI7Jg3fBnu2QmQMIDruoMtBUzyjQXWzSZhiHJ06yWi3Xs+DJYToTkiQp15RLb9HiUU1Nem2/pW4anBEjYK5qa2sDw3VXJGY4ujKrUU6z80CytR1cRzONJdkVUjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2wrkJE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C3AC4CEEE;
	Fri, 20 Jun 2025 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750417816;
	bh=uvtVP1aYMUTlFmGxU79MyL6lu/a9tI++Kn5yo964ngw=;
	h=From:To:Cc:Subject:Date:From;
	b=r2wrkJE1oBEwAImWqC6gxhqDrazO1wRs7uEh2lluKtKamtV693IR8cEbvcTjZ7Poe
	 2Vn8xWR1r2oZKa+Q+WAn2+VZ+n+rg0fdHrn42gcJxEKuftfK0LVRRDJQGgzW7JFgFQ
	 KoBqQPjS3nOOYaC3h85xyvP6hiRtfHqOvpQ7JN0oGdtv7SIGhoQdhJrB/mIDLi2m82
	 ukfHIR4KB+v+OYP9EK1y1TQKsyOn2rqvl8jJaxeVIpBGhMuFqmObKnvc+xx3Utlbp5
	 Tcym8jdkbEu6qYJHM65kl5QFEQWW7+sLYEw8K9tE9Jw7579bcqyEBEkt0EoEeS1ahB
	 BZXzF/c/BH+qg==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eli Cohen <elic@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Erez Shitrit <erezsh@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] net/mlx5: don't build with CONFIG_CPUMASK_OFFSTACK
Date: Fri, 20 Jun 2025 13:10:04 +0200
Message-Id: <20250620111010.3364606-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Local cpumask_t variables must be wrapped with alloc_cpumask_var() or
similar helpers, to allow building with ridiculous values of CONFIG_NR_CPUS:

drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function ‘comp_irq_request_sf’:
drivers/net/ethernet/mellanox/mlx5/core/eq.c:897:1: error: the frame size of 8560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:494:1: error: the frame size of 8544 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_irq_request_vector’:
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:561:1: error: the frame size of 8560 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:74:1: error: the frame size of 8544 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

The mlx5 driver used to do this correctly in the past, but was changed
to use local 'irq_affinity_desc' structures in at least four places,
which ends up having the mask on the stack again.

It is not easily possible to use alloc_cpumask_var() again without
reverting that patch, so work around this by disallowing this drivers
on kernels that rely on CONFIG_CPUMASK_OFFSTACK.

Fixes: bbac70c74183 ("net/mlx5: Use newer affinity descriptor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is probably not a great idea since most enterprise distros do
enable both CPUMASK_OFFSTACK and MLX5, and any ideas for how to sort
this out better would be helpful.

I mainly tried setting CONFIG_NR_CPUS to an unrealistic value for my
own compile testing, to see which files run into this problem. I have
managed to come up with better fixes for the other three I found, but
not this one.
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 6ec7d6e0181d..7c2da240ffdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -8,6 +8,7 @@ config MLX5_CORE
 	depends on PCI
 	select AUXILIARY_BUS
 	select NET_DEVLINK
+	depends on !CPUMASK_OFFSTACK
 	depends on VXLAN || !VXLAN
 	depends on MLXFW || !MLXFW
 	depends on PTP_1588_CLOCK_OPTIONAL
-- 
2.39.5


