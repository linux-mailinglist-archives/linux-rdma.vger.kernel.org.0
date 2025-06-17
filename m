Return-Path: <linux-rdma+bounces-11395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD073ADC534
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F218170E64
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54C28F92F;
	Tue, 17 Jun 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy7qQLAP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006E8528E
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149856; cv=none; b=cRMRHMNkODlg+Re5IPx3FueenkdcZocqmkb2vi8/Oa7i9bRFmKnvj8dCDB98LlDHfgsJ51B8uD1hO3WOjGzaH2pc4P3N0rOgVOxmdBb8WnZnZvy2gj48uQAlDv3tppOHWPkicVW2VG4zO0cq0Rq8htiB8wgJ5IQEEUC+GEUG/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149856; c=relaxed/simple;
	bh=fpSC22WS5/6zEKWcAPR6G3iaq/dt7cBthdZEX558AQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARbMeUMz5tVp751OizPWKfZCwUiUOUoVIf5XBIvdGXO/uKCiDHSXv7ckYy36jxE/rRwfyF2cQf9FFuPkRJUtjLUl4Uwj2TKCsfHV/Vv7VWtIvN+jbcN+uQlXWIUwSV3S6PInxWGLPrrHWU5hDI7Wi61s5RhlL8wBcspYW7+vQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy7qQLAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836BC4CEE3;
	Tue, 17 Jun 2025 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149855;
	bh=fpSC22WS5/6zEKWcAPR6G3iaq/dt7cBthdZEX558AQU=;
	h=From:To:Cc:Subject:Date:From;
	b=Zy7qQLAP1CKdQq6H8QEFNOlR4f9QaheH9LPUzYTN1ifRLWMseG9q5+4RhqlPoesEC
	 3orTSIANHxTjPclehkonKpe0sHa9zK5DFs11JxOpkjDh1a0tJvFGGljW/91Pxk8uw6
	 xFlNm3/14CnMJVdYsDJr33qNxqt5u/GyXd443FfiKuxYeWmXODzfgZW1osNCX6JvOv
	 2JhFPzXl8NPsurOIPdyOq6PggEvPXkMz9JbMHqayZ8aBTRig9vsag/180AtIhXX1cU
	 rF89WoMazFkGOAWgQJp+A1qr4Ryhd/Og5Y3sErUYIhH/iTymaFi0GRGfvbYgvO2wS3
	 q9ClPSjmVJWGA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 0/3] Add net namespace awareness to device registration
Date: Tue, 17 Jun 2025 11:44:00 +0300
Message-ID: <cover.1750149405.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Mark:
Introduces net namespace awareness to RDMA device registration and update
relevant users accordingly.

Currently, RDMA devices are always registered in the initial network namespace,
for example even when their associated devlink devices have been moved to
a different namespace via devlink reload.

This results in inconsistent behavior and namespace mismatches.

So in this series, we update the RDMA core to optionally accept
a net namespace during device allocation, allowing drivers to associate
the RDMA device with the correct namespace. In addition, we ensures that
IPoIB inherit the namespace from the underlying RDMA device, maintaining
consistency across the RDMA stack.

Thanks

Mark Bloch (3):
  RDMA/core: Extend RDMA device registration to be net namespace aware
  RDMA/mlx5: Allocate IB device with net namespace supplied from core
    dev
  RDMA/ipoib: Use parent rdma device net namespace

 drivers/infiniband/core/device.c                  | 14 ++++++++++++--
 drivers/infiniband/hw/mlx5/ib_rep.c               |  3 ++-
 drivers/infiniband/hw/mlx5/main.c                 |  6 ++++--
 drivers/infiniband/sw/rdmavt/vt.c                 |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |  2 ++
 .../net/ethernet/mellanox/mlx5/core/lib/mlx5.h    |  5 -----
 include/linux/mlx5/driver.h                       |  5 +++++
 include/rdma/ib_verbs.h                           | 15 +++++++++++++--
 8 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.49.0


