Return-Path: <linux-rdma+bounces-14840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6399C95C26
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 07:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3823A2817
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681D23B61B;
	Mon,  1 Dec 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK5tFMje"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F622E3F0;
	Mon,  1 Dec 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764569438; cv=none; b=LlLmKYvbeClzemUKqSl9qAVE90hpG5pdNz9ml9v9uNyax2bjvcRqmySs/ZCrrojzqyoxgQ9AFrlwB4smxrDUQX7D+g/fdiuPm1S5+xqtEO56hxyS+pjncOHAa/jLBnKk6xeQZ8KsYAbSU9Z8ZrBTuICEKB1ZO+67R42lc0NEmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764569438; c=relaxed/simple;
	bh=SbN03ySWt9OfcLFHO8YJtWYqg62fldrVVKz/4VsMIrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DfZ1CZso49OAw1k/lBfuejYsnS1mFjuIpPF9uPH/KPPedDekH19qv01mjOaBWBFFD2rKtG3WOrJZJlRdPfNbQm6lJcirEV1T8QC3rpxwA9JeGKohUmPc3EPvPXUYeW8OiFpzexmOtstYF7w735rXOUDKvLWA8VOJF1LqIKBD9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK5tFMje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2381C4CEF1;
	Mon,  1 Dec 2025 06:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764569438;
	bh=SbN03ySWt9OfcLFHO8YJtWYqg62fldrVVKz/4VsMIrg=;
	h=From:To:Subject:Date:From;
	b=gK5tFMjeWw2oahGZp/BQCjjNHuVQfQct1yX92sZNkwGE5RfzYFBzTnpkdBu9uMt1x
	 FnRprEtP8/XOc/u+HgoKqfrO9WyJoMlh5r3dNaYhNwdB3r8WJqIGxkC4K4RmS1FFq6
	 CYZGMqhdCeGLn2qPVHH/q6UImj7jejAIaJU51hrUWLd/ZHGtaiKVRjzX0PNSQQTVJk
	 3vmbjA3Ka2GZiQOfsWtEH6M0dvedn6elR2YA9JTL7q7rwHr5a8t6lIPAiBNDamexLq
	 Wdl9Gtw4a5PO4cQiWNYjDJRW4tGOYNMrAmun5L0AcSRtXrUDuTKwEVNoQKIOKDaq14
	 RXWxz6VjrvPFA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v3 0/2] net/rds: RDS-TCP bug fix collection, subset 1: Work queue scalability
Date: Sun, 30 Nov 2025 23:10:34 -0700
Message-ID: <20251201061036.48865-1-achender@kernel.org>
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

v2->v3
 [PATCH 2/2] net/rds: Give each connection path its own workqueue
   - Updated commit message with worst case connection path accounting
   - Use rds_wq as a fall back if queue alloc fails
   - Checkpatch nits 

Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: Give each connection path its own workqueue

 net/rds/connection.c | 14 ++++++++++++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  9 +++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.43.0


