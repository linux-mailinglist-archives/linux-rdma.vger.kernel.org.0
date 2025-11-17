Return-Path: <linux-rdma+bounces-14551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88627C66197
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BDC36297EB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86833FE23;
	Mon, 17 Nov 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEM/MhfP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E033C53A;
	Mon, 17 Nov 2025 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411023; cv=none; b=B41fFlzZ44Ik4+NYAEvbJYR8jB/oHjqaINo7Xw8flmpzHJ2bdbAMVxWWD1BDp780fDpLNJJwhI0taTzzHGxiOCUG7tCcY83NWs6KVqwHkzQoVsaNmaPVun81PvfB6U+eZPCGzP0t3/ncsu/axNkYUUJ+UMWWw3jqY8b/ognnjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411023; c=relaxed/simple;
	bh=c7lA379kZrf3rirR1LfTH1L62mSsl8NaKmrCfzf+ebg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1h6nt9yOOYoCDN4Gd1fb+GnD7yjqC5uMhwg/WV3CZ6UX5HboTWzvz23fwyujiXovCnNkmVUTFXSv+Se6oo99u+2HTg6rFHdAkkFU3Ezk9spin5mvio1uEP/YMHX4dmNxOc94wAnMp+tGpzsP96cu/d1nJQIL2crr/tw6U+Bx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEM/MhfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355AFC2BCB1;
	Mon, 17 Nov 2025 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763411021;
	bh=c7lA379kZrf3rirR1LfTH1L62mSsl8NaKmrCfzf+ebg=;
	h=From:To:Cc:Subject:Date:From;
	b=mEM/MhfPos9Ybgz7VVf/E+lzAJ2UOTRzAkWHhwVBVb8HiHTBfH80wdrvy9g+edz47
	 0wtm99bfpPUFE3zz2eZsRvxGsS/L9y5iCXHe6Fmzh3j4aayxAJi873Ahw3ByiOUS3J
	 cnsFyk7txD1dlQxyLyl2iKvtXFu68ZroOeOzW+8CYRulbD7LnA82F83xWwCQXDYgK8
	 +SqTzcwsudNujr3MHoyj0aOmd3bwEAxqjVJ+yNkKJDSE0+HB0+vVqYbeFN5QJObMgg
	 vY//tRxMQORMFs6xs5DOfyj0Rc9COz43J3IMssH/SFmIi8+lgDNsLkeE46gku7oWa9
	 KaM8t+ay/zFRw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net/rds: RDS-TCP bug fix collection, subset 1: Work queue scalability
Date: Mon, 17 Nov 2025 13:23:36 -0700
Message-ID: <20251117202338.324838-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is subset 1 of the RDS-TCP bug fix collection series I posted last
week.  The greater series aims to correct multiple rds-tcp bugs that
can cause dropped or out of sequence messages.  The set was starting to
get a bit large, so I've broken it down into smaller sets to make
reviews more manageable.

In this subset, we focus on work queue scalability.  Messages queues
are refactored to operate in parallel across multiple connections,
which improves response times and avoids timeouts.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!
Thanks!
Allison

Change Log:
rfc->v1
 - Fixed lkp warnings and white space cleanup
 - Split out the workqueue changes as a subset

v1->v2
 [PATCH 1/2] net/rds: Add per cp work queue
   - Checkpatch nits
 [PATCH 2/2] net/rds: Give each connection its own workqueue
   - Checkpatch nits
   - Updated commit message with workqueue overhead accounting

Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: Give each connection its own workqueue

 net/rds/connection.c | 16 ++++++++++++++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  9 +++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 32 insertions(+), 18 deletions(-)

-- 
2.43.0


