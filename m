Return-Path: <linux-rdma+bounces-6884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C3A041AB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7CB166826
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73B1F8680;
	Tue,  7 Jan 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePTJCUXK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853331F4284;
	Tue,  7 Jan 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258546; cv=none; b=du4Ofp5L/8ciTNklEQ86iJujIplB09cUDwISU/BrsUZa+rugUU74xB8iNN6QfIK5I5M4muwVOgn4wuNYoIMrHItSchYkvOrxwf47U/BhCkVrZ7Gm0v6Ys8KZTOyedJFB7e+slCcVV+/syGELw1xr1uoCkDTePs+1ipU4qBFXyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258546; c=relaxed/simple;
	bh=nKbG9BngEYf4f9Ix9pWDIqYTwEqqy6K1LdF2DiA9oTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kd6M6g1Bpl+gw7nHDCj29IM6OmZOjtuIrUO/kVB74w9IDqPb3mzzPO9T74a46xiIIcGpJahPACEPM88XkoZJvPISNhdMtwQdjUJNyWpd8oJ1do88b3G2ClJiWlZ54onpypTl+IciJiaMj/Tf2mvubs79CUrd9Ifu0H8crqJcmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePTJCUXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B372C4CEDD;
	Tue,  7 Jan 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736258546;
	bh=nKbG9BngEYf4f9Ix9pWDIqYTwEqqy6K1LdF2DiA9oTU=;
	h=From:To:Cc:Subject:Date:From;
	b=ePTJCUXKDYUBN5Gwp0y8KEFtS+0BxffFjPzUQRihpABZ0AgpR60KnS7kab1EaRjT0
	 BUyMMPNbYXfo8HjDeh9jQpH9eSvt7J7/HAe8z7yyRJ8T4psuzdWhDO/SXiVMitz+4y
	 +BEpOz5IgE+UHccu3RiGpIO40ZHN6KWmJYCTi+k3jRVe2tf1Pml02eu4dJKUvEdYJP
	 NpGV8uHGRKdDZqvaItU9d7FPjqh37NqUKQKlWmTdjEGOH4b3VfdbwAHwYO7edqVe7K
	 2btPgD0irGUvjznfcNltDJBw4/BxZ2BS5UgbZFo5bVfSC/nMXprh8ZLYsfGStrOfjR
	 SZ/pEL40+r2fw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next v1 0/2] IB/mad: Add Flow Control for Solicited MADs
Date: Tue,  7 Jan 2025 16:02:11 +0200
Message-ID: <cover.1736258116.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Add a cancel state to the state machine which allows removing the
   status field in MAD's struct.
 * Add change_mad_state function which handles all the state transition.
 * Add WARN_ONs to check MAD states
 * Reorganize patches to have only two patches in this series instead of three.
v0: https://lore.kernel.org/all/cover.1733233636.git.leonro@nvidia.com

--------------------------------------------------------------------------
From Or,

This patch series introduces flow control for solicited MADs in
the MAD layer, addressing the need to avoid loss caused by insufficient
resources at the receiver side.

Both the client and the server act as receivers - the latter receives
requests, while the former receives responses.
To facilitate this flow control, the series also refactors the MAD code,
improving readability and enabling more straightforward implementation.

Patch #1: Add state machine to MAD layer
Patch #2: Add flow control for solicited MADs

The primary goal of this series is to add a flow control mechanism
to the MAD layer, reducing the number of timeouts.
The accompanying refactoring simplifies state management, making
the code more maintainable and supporting the new flow control
logic effectively.

Thanks

Or Har-Toov (2):
  IB/mad: Add state machine to MAD layer
  IB/mad: Add flow control for solicited MADs

 drivers/infiniband/core/mad.c      | 415 ++++++++++++++++++++++-------
 drivers/infiniband/core/mad_priv.h |  64 ++++-
 drivers/infiniband/core/mad_rmpp.c |  41 +--
 3 files changed, 410 insertions(+), 110 deletions(-)

-- 
2.47.1


