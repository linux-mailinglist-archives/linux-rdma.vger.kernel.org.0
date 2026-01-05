Return-Path: <linux-rdma+bounces-15310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB500CF5D98
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 23:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F63E3053F91
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432E27F010;
	Mon,  5 Jan 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ZgiYFe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC40239E81;
	Mon,  5 Jan 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652534; cv=none; b=UPP0aXsZqC/47YBYFMkBAoPY/5OXMrJcz+Md8K7GPhWuCzpj4KS7ugXMZ1y/fZEdX00yqiKWuVJX/mzkNmwaF1i888F4kQIRJhZPg2z46TkFf5Ee4vsIHrKEcYAblzKLrRA5qkC2IdXEjhvG43Xo88SaUHC5hksURkLJroB98g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652534; c=relaxed/simple;
	bh=7Wk9kNLDRt4a7o0EKuYOjlCslBxZW5yOT8wfCEyCISQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEnSDc+wC+q00otP/s+WyvgNknAlnNCtN2tgEyC695SIEvrjbAI1bOyHDTHg9oB4DrDdhEDClsuKdBAdoVkTSQe5qWVaFLZqzKZd8Wuxoz2cu0A4paasEi4drnICOlKus4fhHUXZaNCAkwNGb+UiAA8YpdoCOAAES9PBcgROemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3ZgiYFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91641C116D0;
	Mon,  5 Jan 2026 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767652534;
	bh=7Wk9kNLDRt4a7o0EKuYOjlCslBxZW5yOT8wfCEyCISQ=;
	h=From:To:Cc:Subject:Date:From;
	b=I3ZgiYFe/uD3fhmNFHm+66OvdJwBETMkljcMJfNb339b2l6xFiEFkBCv9h2VnFD7+
	 l5Qmm2ARj3/dYYBo8kePWI7ugPHKA/qa9RUmLAAUNdrx0wh8QiXyAi7KahPgazaNzv
	 yIPWyatPD4dLbsoOaQeYiCfL6bkd28AM/NsuvgcwkxfpxCRLdDXDmeDC7quZFlPXkV
	 O5AEZXxdgPyOdlJxy4K8nGf3vIF18ZNKd97Wp3v2pbhiRjseRw5wqZcG9J7PQw5f7L
	 hFeaK7kYHcQWoFqQ8P31kQ9jKCv2o/g65k9Tnv8KKmqsBv8tztiB5YNp+hXox3SmXr
	 g7k9i4GCIqyJg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v4 0/2] net/rds: RDS-TCP bug fix collection, subset 1: Work queue scalability
Date: Mon,  5 Jan 2026 15:35:30 -0700
Message-ID: <20260105223532.167452-1-achender@kernel.org>
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

v3->v4
  [PATCH 2/2] net/rds: Give each connection path its own workqueue
   - Fixed memleak warning in __rds_conn_create error path

Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: Give each connection path its own workqueue

 net/rds/connection.c | 17 +++++++++++++++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  9 +++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.43.0


