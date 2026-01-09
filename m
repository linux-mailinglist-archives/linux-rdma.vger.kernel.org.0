Return-Path: <linux-rdma+bounces-15417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E59B6D0C7C4
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 23:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12B92300E8E2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 22:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BA337B95;
	Fri,  9 Jan 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFJHcS7t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768286353;
	Fri,  9 Jan 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998925; cv=none; b=c2smkdXQk7iBkC1jq5Us58lsHLsAB03Bi4u0a4BVf7MNS1G84N5suRrvZI0H1sOHbpTlZtvDpK+6jeXXSTpp296ZMLYECGwQzitZVHPlXJaZl/0HakBVXSS8NDEjaRYc7rV+T/3cnB43x88MWRTDKgVb4ZSrmb2s/NysZ7hmwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998925; c=relaxed/simple;
	bh=hSclj7Vw5YVSOr94y9Puq7z7FipvJMoNGHQt+6rwjhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4xfLqH4+OtUdkSFTc0snQsSfBAVXxgfRtutc5lJgUxsj3i+DeO4V++B8NDnZlWfmp0kgYF3OboLQRYbQbsk7Oxv5QuKNvNK66z7D8naKVLmFPoUAg6Y0ukehez2kobIPbdJMI0CXnzxaU9KPR3KRAQYeu4ZF8OVW1w8TEw/Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFJHcS7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7344EC4CEF1;
	Fri,  9 Jan 2026 22:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998925;
	bh=hSclj7Vw5YVSOr94y9Puq7z7FipvJMoNGHQt+6rwjhU=;
	h=From:To:Cc:Subject:Date:From;
	b=WFJHcS7tc23m6TFwEO6KsadazxwwdjS8EEBzRjDiFHJmjg+fNly21w3EKQPAJ2dKr
	 S7wjFqka33j3vHqxqWrTSQ+opSzyLBG+SXUOZtFDGEihg517QDs6xJQ6cf2vmEB2iU
	 r3RSE428El1/M66NvU5MKYAPf940fz4Tpn5w1whnpu7vOzz2izoNtmj/Fy/9nJsSxy
	 Pu8rA28Ym0eGunwDRjNx6D9sJ1XX1ar6AJoI+uUmOCpMrVYBYAw0K2LiWTlxV+q2Eq
	 j5YUkHN5DxsVI80s0VNDO3ctt4LexN6Xzz3YHkikVYt4dSwzVaiNwQfL213liDzrd8
	 Lh2IyP0BQKuhw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v5 0/2] net/rds: RDS-TCP bug fix collection, subset 1: Work queue scalability
Date: Fri,  9 Jan 2026 15:48:41 -0700
Message-ID: <20260109224843.128076-1-achender@kernel.org>
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
Oct.  The greater series aims to correct multiple rds-tcp bugs that
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

v2
 [PATCH 1/2] net/rds: Add per cp work queue
   - Checkpatch nits
 [PATCH 2/2] net/rds: Give each connection its own workqueue
   - Checkpatch nits
   - Updated commit message with workqueue overhead accounting

v3
 [PATCH 2/2] net/rds: Give each connection path its own workqueue
   - Updated commit message with worst case connection path accounting
   - Use rds_wq as a fall back if queue alloc fails
   - Checkpatch nits 

v4
  [PATCH 2/2] net/rds: Give each connection path its own workqueue
   - Fixed memleak warning in __rds_conn_create error path

v5
  Fixed AI complaints

  [PATCH 1/2] net/rds: Add per cp work queue
  - updated rds_wq in rds_cong_queue_updates and
    rds_ib_send_cqe_handler

  [PATCH 2/2] net/rds: Give each connection path its own workqueue
  - free paths on race detection error and move freeing of conn->c_path
    outside of spinlocks
 
Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: Give each connection path its own workqueue

 net/rds/cong.c       |  2 +-
 net/rds/connection.c | 28 +++++++++++++++++++++++-----
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  4 ++--
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  9 +++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 9 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.43.0


