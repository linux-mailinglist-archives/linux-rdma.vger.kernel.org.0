Return-Path: <linux-rdma+bounces-11751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBECAED98E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570363ADDDC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F002571A1;
	Mon, 30 Jun 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7ei5a/F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA12459F3;
	Mon, 30 Jun 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278616; cv=none; b=lsWV2FYLVo8alLmhhHjqBi+xqzb2l5dYo+qlXOCO4pNcnyjkj6qZQDSloCX7XUwjv3B2TJY0tBU2P6KxfM3XD6QWK9iGZ1hd/3cdKcMHluRFFVyEJMgugIAuN8o8lL6tEEawCyaPPBEyJzqZYX7LExkdxvYLBf5+pT8xrC+pdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278616; c=relaxed/simple;
	bh=FBUnxXNfef0l/y0E9J7++Bgq6onPTRelPZX05aNzVBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+kLyel8IWppQAKfjjwYzRWlHg1F7h1OT9PWPNz1C+XKn1QS4e7+EO/2S9QyVirYOlFA5TjzepBzXouar2026ybkamlUwUBS0VPQpnSEaluW12aO07wCgjBjiEKRVF1JclN4+hJmmfYHz3lqBL7MOvzHLC34lRtVpaBCH6Th/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7ei5a/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6863FC4CEEB;
	Mon, 30 Jun 2025 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751278616;
	bh=FBUnxXNfef0l/y0E9J7++Bgq6onPTRelPZX05aNzVBA=;
	h=From:To:Cc:Subject:Date:From;
	b=K7ei5a/FBZLDJdZJVRyCxoduoAVBUCsU5LF7qk/2BODAIMW4pf1T04v84LISdNW0P
	 3WQVRe0nWRT5bIDwCKgYjbcwIG82aHWnZFLJbaJyW4NAdqGyMleRXgUAnAEPYafNE2
	 aFN8sPT267/ae0MuvV/5V7M4FkYepeBX3Q7sNBUWrUxB4Esx2MbHNTqRj/9yUlZJu4
	 X/PPvUsfrav7wt5C9bIBneh7ZF22sv+9jA1Yxd7t2HGX1E0XQpT1fMYh+QbtiGLCqM
	 F+H0cGxaawqOabas+68mvqOXiNbvbPdEUGXgRAVWdhNpj6LfTChmBW5k0B4IAOHI8i
	 stPlYkjqeX6sg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next v2 0/3] IB/mad: Add Flow Control for Solicited MADs
Date: Mon, 30 Jun 2025 13:16:41 +0300
Message-ID: <cover.1751278420.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v2:
 * Add separate send-only agent for REPs to prevent starvation
   of REPs when runnning both service and client on the same node.
 * Instead of immediately resending a timed-out MAD, it will now   be
 * placed in backlog queue if the queue is not empty.
v1: https://lore.kernel.org/all/cover.1736258116.git.leonro@nvidia.com
 * Add a cancel state to the state machine which allows removing the
 * status field in MAD's struct.
 * Add change_mad_state function which handles all the state transition.
 * Add WARN_ONs to check MAD states
 * Reorganize patches to have only two patches in this series instead of
 * three.
v0: https://lore.kernel.org/all/cover.1733233636.git.leonro@nvidia.com

--------------------------------------------------------------------------
From Or and Vlad

This patch series introduces flow control for solicited MADs in
the MAD layer, addressing the need to avoid loss caused by insufficient
resources at the receiver side.

Both the client and the server act as receivers - the latter receives
requests, while the former receives responses.
To facilitate this flow control, the series also refactors the MAD code,
improving readability and enabling more straightforward implementation.

Patch #1: Add state machine to MAD layer
Patch #2: Add flow control for solicited MADs
Patch #3: Use separate send-only agent for REPs

The primary goal of this series is to add a flow control mechanism
to the MAD layer, reducing the number of timeouts.
The accompanying refactoring simplifies state management, making
the code more maintainable and supporting the new flow control
logic effectively.

Thanks

Or Har-Toov (2):
  IB/mad: Add state machine to MAD layer
  IB/mad: Add flow control for solicited MADs

Vlad Dumitrescu (1):
  IB/cm: Use separate agent w/o flow control for REP

 drivers/infiniband/core/cm.c       |  47 ++-
 drivers/infiniband/core/mad.c      | 468 ++++++++++++++++++++++-------
 drivers/infiniband/core/mad_priv.h |  76 ++++-
 drivers/infiniband/core/mad_rmpp.c |  41 +--
 4 files changed, 500 insertions(+), 132 deletions(-)

-- 
2.50.0


