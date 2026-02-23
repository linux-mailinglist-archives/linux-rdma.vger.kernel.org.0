Return-Path: <linux-rdma+bounces-17081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHb5OW/SnGlLKwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 23:19:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ED17E2D0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 23:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3284A306CDCE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1637A485;
	Mon, 23 Feb 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDPMIFM5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A637882A;
	Mon, 23 Feb 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885160; cv=none; b=pxR+2aioGIY6WY4z49q247y65XVssQIDGxm0s5NvCI8R+e5PSrBql+cp/Hzb7F6g+fRzidAkwMYXxv1u00H952tgarm0bGEd3RPkCKe9SaEa05NcdOy9BEU3hGvSElNu8xkCVaxt9+zp9kCBEEKD9ABwMo+sx9FmdS/X71GhjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885160; c=relaxed/simple;
	bh=xt9ORoAyftTCHdxhLPTUzb9JYk/R6VOwutyTZYLKbzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTXzTeodA36Gik8qE3PLZUrj2o6azs0PIZv4rATtrhxs6DwUXxpA34WVKfXytzMcOszr2HmmQSlXNt00jiJdHo/PBRaOAAEg+P4DP4foTj0+0eS3bA9TwgCaFMn9ZSfDG0uRgvO4vkCozJh6vE3oZdmPa3v9Qise25Cb51RpAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDPMIFM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E670C116C6;
	Mon, 23 Feb 2026 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885159;
	bh=xt9ORoAyftTCHdxhLPTUzb9JYk/R6VOwutyTZYLKbzk=;
	h=From:To:Cc:Subject:Date:From;
	b=XDPMIFM55jDwvTta3yUpeZYyUuQuGUDqFbKpYjAHySk3wghDCyMu6s+urYua54PqV
	 3D5al7e/gvSRAt8zBgRlkYAERqaaBGRr71QhzNO2aLNPyf0e/9E8uG7dt0VMa2CxmR
	 oHpwfgslf5zB8JyYweUItp/jeWAuva0CHr1Xl/VFg8IIcUhJG5wtkg/CkmkAEbYzjd
	 neolIoIawqz2O0TkJLz1up4D7BGTmZJ7sdGHhk0Hk5NhEE6+wYrtFjfnrN2XmxV8xB
	 d5RQoNo41ADyqdhYEfU5BRefKCcADTPDTGk8Ribm8y3HrqhJmC7Lz5lgVL5t5bFTeU
	 uI+qr+P153+cQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v5 0/2] net/rds: RDS-TCP reconnect and fanout improvements
Date: Mon, 23 Feb 2026 15:19:16 -0700
Message-ID: <20260223221918.2750209-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17081-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: AC3ED17E2D0
X-Rspamd-Action: no action

Hi all,

This is subset 4 of the larger RDS-TCP patch series I posted last
Oct.  The greater series aims to correct multiple rds-tcp issues that
can cause dropped or out of sequence messages.  I've broken it down into
smaller sets to make reviews more manageable.

In this set, we address some reconnect issues occurring during connection
teardowns, and also move connection fanout operations to a background
worker.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!

Thanks,
Allison

Change Log
v2:
   [PATCH net-next v2 1/4] net/rds: Refactor __rds_conn_create for
   blocking transport cleanup
      - NEW

   [PATCH net-next v2 2/4] net/rds: Delegate fan-out to a background
    worker
      - Added syzbot report link
v3:
  [PATCH net-next v3 1/4] net/rds: Fix NULL pointer dereference in
  rds_tcp_accept_one
    - NEW
    - Fixes syzbot bug
      https://syzkaller.appspot.com/bug?extid=96046021045ffe6d7709

  [PATCH net-next v3 2/4] net/rds: Refactor __rds_conn_create for
  blocking transport cleanup
    - Moved syzbot report link from "Delegate fan-out to a background
      worker" to this patch
    - this patch fixes syzbot bug flaged in next patch
      https://ci.syzbot.org/series/1a5ef180-c02c-401d-9df7-670b18570a55

   [PATCH net-next v3 3/4] net/rds: Delegate fan-out to a background
    worker
     - Moved syzbot report link to previous patch

   [PATCH net-next v3 4/4] net/rds: Use proper peer port number even
   when not connected
     - Fixed ai comment complaint

   [PATCH net-next v2 4/4] net/rds: rds_sendmsg should not discard
   payload_len
     - Removed
     - Deferred to net instead of net-next

v4:
  [PATCH net-next v4 2/4] net/rds: Refactor __rds_conn_create for
  blocking transport cleanup
    - Removed Reported-by: tag

  [PATCH net-next v4 3/4] net/rds: Delegate fan-out to a background
  worker
    - Expanded commit header to clarify ordered queue mechanics and
      cancel_work_sync() usage

v5:
  [PATCH net-next v4 1/4] net/rds: Fix NULL pointer dereference in
  rds_tcp_accept_one
   - Removed
   - Deferred to net instead of net-next

  [PATCH net v5 1/2] net/rds: Refactor __rds_conn_create for blocking
  transport cleanup
   - Clarified commit header and commets per ai review

  [PATCH net-next v4 4/4] net/rds: Use proper peer port number even
  when not connected
   - Removed
   - Superceeded by
        "net/rds: fix recursive lock in rds_tcp_conn_slots_available"

Allison Henderson (1):
  net/rds: Refactor __rds_conn_create for blocking transport cleanup

Gerd Rausch (1):
  net/rds: Delegate fan-out to a background worker

 net/rds/connection.c  | 32 ++++++++++++++-----------
 net/rds/tcp.c         |  3 +++
 net/rds/tcp.h         |  7 ++----
 net/rds/tcp_connect.c |  2 ++
 net/rds/tcp_listen.c  | 54 +++++++++++++++++++++++++++++++------------
 5 files changed, 64 insertions(+), 34 deletions(-)

-- 
2.43.0


