Return-Path: <linux-rdma+bounces-13062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E3B4153A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A425E71B5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C92D6625;
	Wed,  3 Sep 2025 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE15uslG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86619F12A;
	Wed,  3 Sep 2025 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881085; cv=none; b=hQ5Tbw95gCqROuaRFarDcnoom5KT3Zf+mjE1B4pR9HZ5HXF9dbePtzvB5q0s9v4BUAjf6+ygRb/RoUmJQOWhEIu8s79DlygQS5amGWZff1j4U9WBq2k0rlFeLJojBzLsSEbkLdW6zQV2kXMK/LVYu/6+loHslugTdv+P7j12Cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881085; c=relaxed/simple;
	bh=cIELB+MKUdfwCBYdZmaI1Sg0mQcM3EneIgaB0hQZ4GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gu5a5/+oAIr13Zp8/loUKaAvmAmOWTkEAK0R81r9MOZu1/ruUja428nVMCWuRO9/uwby/m4+4vNbHQbWssenU2QHqyzSqEuLRleFxmWC/gqs50YUHp85l7QaLi4epy4lIzLY77wnN3tvvBoEcvOyif/5qkmuWS8OI7KAQkvpHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE15uslG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036DDC4CEF0;
	Wed,  3 Sep 2025 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881085;
	bh=cIELB+MKUdfwCBYdZmaI1Sg0mQcM3EneIgaB0hQZ4GI=;
	h=From:To:Cc:Subject:Date:From;
	b=pE15uslGjgt6cRA32qLrkZ5BmKnuqz5OD/ScbGYJfIMO6wb3gVqZZUm/xT3OTU43g
	 sYa/QsOyzKVq9qkazDT02S3mRNWOlNGbDAy38o869+buum74U+mTEPuv+XA84PQDrr
	 Al3b0uxOJz2D+cWvatzNtFWheFiFAmcFk1Dc3KBKp22yC7NRv8B28rA+GyenGkvkwx
	 HB/nd7KfW0mohODmik/WwxrjksDWBwE/Gp8dKWsYiZ5b/948+kjFLjTnI9eLK7qlVh
	 Rur1AgNilvBznCgU2dHc9mtQAzegrz2BDf8QkSDbFBmuTLsQXYzx9px0CnHhuinxVA
	 1NaEduWZuThsA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	netdev@vger.kernel.org,
	mbloch@nvidia.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Raed Salem <raeds@nvidia.com>
Subject: [GIT PULL] mlx5 PSP IFC bits
Date: Tue,  2 Sep 2025 23:30:49 -0700
Message-ID: <20250903063050.668442-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Hi Jakub, Jason,

This PR has a single patch to add mlx5_ifc PSP related capabilities structures
and HW definitions needed for PSP support in mlx5.

Link: https://lore.kernel.org/netdev/20250828162953.2707727-1-daniel.zahka@gmail.com/

Please pull and let me know if there's any problem.

The following changes since commit 40653f280b2640e5caa94eeedee43e0f1df97704:

  {rdma,net}/mlx5: export mlx5_vport_get_vhca_id (2025-08-15 12:17:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git tags/mlx5-psp-ifc

for you to fetch changes up to 04a3134f88a4bd03001a3093144819523cfca99e:

  net/mlx5: Add PSP capabilities structures and bits (2025-09-02 23:08:13 -0700)

----------------------------------------------------------------
mlx5 PSP IFC bits

----------------------------------------------------------------

Saeed Mahameed (1):
  net/mlx5: Add PSP capabilities structures and bits

 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  6 ++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  1 +
 .../mellanox/mlx5/core/steering/hws/definer.c |  2 +-
 include/linux/mlx5/device.h                   |  4 +
 include/linux/mlx5/mlx5_ifc.h                 | 95 ++++++++++++++++++-
 5 files changed, 103 insertions(+), 5 deletions(-)

-- 
2.50.1


