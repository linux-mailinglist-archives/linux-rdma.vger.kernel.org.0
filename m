Return-Path: <linux-rdma+bounces-15663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CAD39242
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 03:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310083015170
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355591A5B8A;
	Sun, 18 Jan 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2nJxDCK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FFFBF0;
	Sun, 18 Jan 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704554; cv=none; b=IoylvN67Ad1CkvbYasU9XCR6JjLy9Ont1TxATjH2aiH9+l84b7NvsNGfe1BdFbCRPVle5cE8h966o6OJWDz9T8LKmEXj1cyYt9yrnz2hq/EJXUFQQUD231rBXyamEF7v4xchD5nkgd5a82axHzswrzJP9pdglEGVObWUf8Y98Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704554; c=relaxed/simple;
	bh=f8lMJjuptCPHYA5hUktASOtoFhrTgmJMaKCtGm+gKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIiFq/sQdL1GH4Fp7WLM+lToo33phOKjTvfZd+zA2snAQhKqF9jiHXuGF1/Jj/BVF9sgOgrFwb+HazCgBQ66ezqY9npVlpZeA2VwioSg88Y6LLGQ6/xAE9vwYa0GZ2/mwTZSMAZWpT7D6qsbyLlBjd+VVRDEGeUGcVJn7wkplv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2nJxDCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2830C4CEF7;
	Sun, 18 Jan 2026 02:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768704553;
	bh=f8lMJjuptCPHYA5hUktASOtoFhrTgmJMaKCtGm+gKh8=;
	h=From:To:Cc:Subject:Date:From;
	b=U2nJxDCKWP0aii4ClL3wtF/1bPyn4LEFvTzIXggzL2e0F+IRsG+H+TDX+PlxwQybQ
	 QOw6laHA/lPmpAvHaNEz/QNJG+HphUceZLyvKnhQZCnMc3eCuR1wFNRKmZimfLPkE6
	 1eUdh+o7DDTWa/VBnCxEWLP/MMCivpViECOAZq+JJ6nf5AmI3ayAt94Kb6FcFbxPcU
	 GuGNyUE4d+0YH10G9aI9as6MMUumkKLmAwPUwY5cQ34wj+f5rSRpJ/G6Gz7xIZfts2
	 Ii8jhQQ7SBVfntyDl0knvtP5B59sVfFyRECjuTD4V+6loqYQK70iHPTVTAlGCKP23u
	 4GqqYo8MBpfvg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 0/3] net/rds: RDS-TCP bug fix collection, subset 2: lock contention, state machine bugs, message drops
Date: Sat, 17 Jan 2026 19:49:08 -0700
Message-ID: <20260118024911.1203224-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is subset 2 of the RDS-TCP bug fix collection series I posted last
Oct.  The greater series aims to correct multiple rds-tcp bugs that
can cause dropped or out of sequence messages.  I've broken it down into
smaller sets to make reviews more manageable.

In this set, we correct a few RDS/TCP connection handling issues, lock
contention issues, and message some loss bugs.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!
Thanks!
Allison

Gerd Rausch (2):
  net/rds: No shortcut out of RDS_CONN_ERROR
  net/rds: rds_tcp_accept_one ought to not discard messages

Håkon Bugge (1):
  net/rds: Change return code from rds_send_xmit() when lock is taken

 net/rds/connection.c |   5 ++
 net/rds/rds.h        |  65 +++++++++++++---------
 net/rds/recv.c       |   4 ++
 net/rds/send.c       |   4 +-
 net/rds/tcp.c        |  27 ++++-----
 net/rds/tcp.h        |  22 +++++++-
 net/rds/tcp_listen.c | 128 +++++++++++++++++++++++++++++++------------
 7 files changed, 172 insertions(+), 83 deletions(-)

-- 
2.43.0


