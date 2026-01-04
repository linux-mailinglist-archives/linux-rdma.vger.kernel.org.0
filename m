Return-Path: <linux-rdma+bounces-15284-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33238CF1090
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B0D73000B0E
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D030DEC8;
	Sun,  4 Jan 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxIzlUCw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FB2874E4;
	Sun,  4 Jan 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534710; cv=none; b=Vz+P/IEBvR1HmkE+i8UTcYwHMjaYuNzKqd8zQNg2KgBlnVV83f9uwDZntUWJmrG71cqRFB+1xEmawokjNNopkJzMBpFuyaTfOSje0/16Hh6nX7MVHNrEZoqgXq5Rs50hOLObCF7hY8+lWVyBXpaDNZTnb2VFkil1qkCw9bFZYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534710; c=relaxed/simple;
	bh=ans4XcFv3SVoM+jYqydUxahgAQakisvIL9ZRJ9lIcSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uiqIB+V0I74m0b6re5RuXNmBKtSv6QtxviLRShkP9Y4F4fyiKtV5ej7FySljVfMCfBrVvP4w85sv67mMWkK6Fg2/5sY89aXZKlFy6hl6rDzCzOnyhq/pdv4wzu5ortmbeOB6PLIEKRZfz1QnITV8QaTmjCbu0prQI6vuewMoYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxIzlUCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB62C4CEF7;
	Sun,  4 Jan 2026 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534708;
	bh=ans4XcFv3SVoM+jYqydUxahgAQakisvIL9ZRJ9lIcSg=;
	h=From:To:Cc:Subject:Date:From;
	b=TxIzlUCwp9P0/qgrf+Kgknx5youU+uoL7PqOZRIO64GmNTxS/BcBOH9X2jxpzw5sS
	 KXqUSakacLU1dCNMvZKW57wbe6YJ80R6wTRx6GxqlhJq+3wtgLZoBEU0fr8KoWJ1xe
	 X+iPeiwPzF9bkgEsWdIZBfeJx5aZMMLehb0bIArx/ZxAPAnm3SeZwBopW4YXhLcU+N
	 kQN5prSr3KY60BS73rk8kAjUOMGK4qrVN8B7WpEsPZ2DrrXLz5/D74yiTIrFU3M1ek
	 Gz9UQ7JkFxx6wLikwgs0JVj6jWlA1l7SQCWljSMmetjlcvJiUgzgfVk3iMFu2RkSIk
	 aps/7h1zQlBIA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 0/6] Batch of unrelated cleanups in IB
Date: Sun,  4 Jan 2026 15:51:32 +0200
Message-ID: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251224-ib-core-misc-0081798ba040
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

A collection of independent, self-contained cleanup patches in IB.

Thanks

---
Leon Romanovsky (4):
      RDMA/umem: Remove redundant DMABUF ops check
      RDMA/mlx5: Avoid direct access to DMA device pointer
      RDMA/qedr: Remove unused defines
      RDMA/ocrdma: Remove unused OCRDMA_UVERBS definition

Maher Sanalla (1):
      RDMA/mlx5: Fix ucaps init error flow

Parav Pandit (1):
      RDMA/core: Avoid exporting module local functions and remove not-used ones

 drivers/infiniband/core/device.c      | 30 ------------------------------
 drivers/infiniband/core/umem_dmabuf.c |  3 ---
 drivers/infiniband/hw/mlx5/main.c     |  6 +++++-
 drivers/infiniband/hw/mlx5/mr.c       | 11 ++++++-----
 drivers/infiniband/hw/ocrdma/ocrdma.h |  2 --
 drivers/infiniband/hw/qedr/qedr.h     | 20 --------------------
 include/rdma/ib_verbs.h               |  2 --
 7 files changed, 11 insertions(+), 63 deletions(-)
---
base-commit: a3572bdc3a028ca47f77d7166ac95b719cf77d50
change-id: 20251224-ib-core-misc-0081798ba040

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


