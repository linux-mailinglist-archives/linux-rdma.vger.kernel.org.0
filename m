Return-Path: <linux-rdma+bounces-6300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337019E57CC
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBF61881B20
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E47218ABF;
	Thu,  5 Dec 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMCgNNpF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46181DED77;
	Thu,  5 Dec 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406637; cv=none; b=kas1y0ti0OACqz47zulLv8wTQxkcRCO2dexgtiNevSmJIm57xAgPynX6nEZhb6mXV9sZO+ArtiE0zL4iQnfGPiL2q7+un2zb/KTh9zrdbOTlsIv2rnZdzj7mpd2ppBvqjWO8h4PmelHmAKOII/KGOKD2V5BUBhyyUZa0GwuEg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406637; c=relaxed/simple;
	bh=aZtiKxlbwI3iz4Q7oXu1l34TtwwPSR1EgAsfbUW9HaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3t+5d36GIW0UvHkhN2Cc6wbpnxOnszs/3d0y5fKh80ueup/hLj7K0CeEp18rdpaist1mTyYiBi69OU+wbpDNTdeAYVBM5OvldpzFC7GDZ4nWlBNPZ6L8tO3Cvn3oiSdUMAkPrKObYGrvsDMVrey3FOqgq+o/bAHEXzNgLKoHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMCgNNpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8133C4CEDC;
	Thu,  5 Dec 2024 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406637;
	bh=aZtiKxlbwI3iz4Q7oXu1l34TtwwPSR1EgAsfbUW9HaI=;
	h=From:To:Cc:Subject:Date:From;
	b=cMCgNNpF/1S+t6cbLbV4+Tr3jZ5dVX6rOUd2bovtIA/FEst2gAuhoD/fs7U+I5/c/
	 3bShZmrtYZsi09DFhghrgPk2A3jRv9BmapkKyxLDMwHnuC1xqk4xi7JSv9Fw/Ndv43
	 E6FHgZAeIsnDydG6c82WkJYR7OPoHLgwN6849GhIXxJZz/foSAhS67WPWx1aO87D8j
	 2gFEU7j6JIkoJwuGx6F1HEIXUwiRr2kx3IxK4gIErjKE8xT9bmEhGaGFmzPbXD0KSK
	 0m/k3q8uCdgbBVo8gk2tCBDbmPNwatIkQOk0hmchDR+1vSty90Px31AQ3J2revoDRE
	 ysgs0GuxT5ILg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 0/9] Rework retry algorithm used when sending MADs
Date: Thu,  5 Dec 2024 15:49:30 +0200
Message-ID: <cover.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Vlad,

This series aims to improve behaviour of a MAD sender under congestion
and/or receiver overload.  We've seen significant drops in goodput when
MAD receivers are overloaded.  This typically happens with SA requests,
which are served by a single node (SM), but can also happen with CM.

Patch 7 introduces the main change: exponential backoff.  This new retry
algorithm is applied to all MADs, except RMPP and OPA.  To avoid
reductions in recovery speed under transient failures, the exponential
backoff algorithm only engages after a certain number of linear timeouts
is experienced.  The backoff algorithm resets to beginning after a CM
MRA, assuming the remote is not longer overloaded.

Because a trade-off between speed of recovery under transient failure
and reducing load from unnecessary retries under persistent failure must
be made, and this trade-off depends on the network scale, patch 8 makes
mad-linear-timeouts configurable.

Patch 1 makes CM MRA apply only once, to prevent entering an excessive
delay condition, even when the receiver is likely no longer overloaded.

The exponential backoff algorithm (a) increases the time until a send
MAD reaches the final timeout, and (b) makes it hard to predict by
callers.  Since certain callers appear to care about this, Patch 2
introduces a new option, deadline, which can be used to enforce when
the final timeout is reached.  SA, UMAD and CM are updated to use this
new parameter (patches 3, 5, 6).

Patch 3 also solves a related issue in SA, which configures the MAD
layer with extremely aggressive retry intervals, in certain cases.
Because the current aggressive retry was introduced to solve another
issue, patch 4 makes sa-min-timeout configurable.

Patch 9 resolves another related issue in CM, which uses a retry
interval that is way too high for (low latency) RDMA networks.

In summary:
  1) IB/mad: Apply timeout modification (CM MRA) only once
  2) IB/mad: Add deadline for send MADs
  3) RDMA/sa_query: Enforce min retry interval and deadline
  4) RDMA/nldev: Add sa-min-timeout management attribute
  5) IB/umad: Set deadline when sending non-RMPP MADs
  6) IB/cm: Set deadline when sending MADs
  7) IB/mad: Exponential backoff when retrying sends
  8) RDMA/nldev: Add mad-linear-timeouts management attribute
  9) IB/cma: Lower response timeout to roughly 1s

Two tunables will be added to RDMA tool (iproute2), under the
'management' namespace as follow-up:

  mad-linear-timeouts
  sa-min-timeout

Thanks

Vlad Dumitrescu (9):
  IB/mad: Apply timeout modification (CM MRA) only once
  IB/mad: Add deadline for send MADs
  RDMA/sa_query: Enforce min retry interval and deadline
  RDMA/nldev: Add sa-min-timeout management attribute
  IB/umad: Set deadline when sending non-RMPP MADs
  IB/cm: Set deadline when sending MADs
  IB/mad: Exponential backoff when retrying sends
  RDMA/nldev: Add mad-linear-timeouts management attribute
  IB/cma: Lower response timeout to roughly 1s

 drivers/infiniband/core/cm.c        |  13 +++
 drivers/infiniband/core/cma.c       |   2 +-
 drivers/infiniband/core/core_priv.h |   4 +
 drivers/infiniband/core/mad.c       | 141 ++++++++++++++++++++++++++--
 drivers/infiniband/core/mad_priv.h  |   8 ++
 drivers/infiniband/core/nldev.c     | 133 ++++++++++++++++++++++++++
 drivers/infiniband/core/sa_query.c  |  81 +++++++++++++---
 drivers/infiniband/core/user_mad.c  |   8 ++
 include/rdma/ib_mad.h               |  29 ++++++
 include/uapi/rdma/ib_user_mad.h     |  12 ++-
 include/uapi/rdma/rdma_netlink.h    |   7 ++
 11 files changed, 416 insertions(+), 22 deletions(-)

-- 
2.47.0


