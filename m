Return-Path: <linux-rdma+bounces-15956-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEuhEBTBdWmBIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15956-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:07:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 994857FEAA
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 325923009997
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D049239E6C;
	Sun, 25 Jan 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Vo3KPT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA91F03D2;
	Sun, 25 Jan 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769324813; cv=none; b=tjQElbMrVYkoxu1dWGUlwNmkxMWkn6yC+o0qp3h41JvktNc15PJDU/4g5qrGexFCO3ZsOJatVm5+UIM+0HKv7GweAtH0zIpQ3XWzhayz9Uq8iPAB1pKfbQTFDd4NmnuLge1XfJ427vAqsNxOVtc7rSSOansMV7CDWPWJTPos1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769324813; c=relaxed/simple;
	bh=ho8hvtx8lZ8bUZdStjI6VdhrpPlYoy3oQcc2Sg9YoZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+6V+6HFRvbXdrrthn2oedR1n85ErKdOWAu3TUwhk+Im+ItFG/RhDC/M61tqx7Z1stk+F0/528vvFeOV86aORxUSdE17WHbUHxxWqjm0qPMpNEuPRZsrxMIOgaAM7rx2zQ0DJE/570bYTdRxb1E+8LaD5N1yRayuYrKX62kMpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Vo3KPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267AEC4CEF1;
	Sun, 25 Jan 2026 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769324812;
	bh=ho8hvtx8lZ8bUZdStjI6VdhrpPlYoy3oQcc2Sg9YoZg=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7Vo3KPTtnJhbc4CHwf/hLxXGd/z+jMXMTtERYBv3/5X3uU/4T7SacOyLXgXgHivX
	 NI4irYgySwWGZxB4B10ojcLy/UpgybPIEIgvy8fOYUw4N55WH35gkX/8pSbgRLCDTz
	 NyvR4xcBK2GhZLWNxBwRpvbZM3UC10j/cGCj8WI7RF6ZBMW8C8rOqEivlEUcG7brmj
	 Aqd44qzcxulhzatkvfYebJLwguDnKT09SzHTM4PysR16tSOob++6WTexEJfhsn+082
	 GejXKfA06LMfb0nQB/SdwTHvY8N/3C5VO92ROThaHTO/v0lEiQNwyafI1m83IzxsET
	 xGKDFxyP6oY7A==
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
Subject: [PATCH net-next v1 0/7] net/rds: RDS-TCP protocol and extension improvements
Date: Sun, 25 Jan 2026 00:06:44 -0700
Message-ID: <20260125070651.207042-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15956-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994857FEAA
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is subset 3 of the larger RDS-TCP patch series I posted last
Oct.  The greater series aims to correct multiple rds-tcp issues that
can cause dropped or out of sequence messages.  I've broken it down into
smaller sets to make reviews more manageable.

In this set, we introduce extension headers for byte accounting
and fix several RDS/TCP protocol issues including message preservation
during connection transitions and multipath lane handling.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!
Thanks!
Allison


Gerd Rausch (5):
  net/rds: Encode cp_index in TCP source port
  net/rds: rds_tcp_conn_path_shutdown must not discard messages
  net/rds: Kick-start TCP receiver after accept
  net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
  net/rds: Trigger rds_send_ping() more than once

Håkon Bugge (1):
  net/rds: Clear reconnect pending bit

Shamir Rabinovitch (1):
  net/rds: new extension header: rdma bytes

 net/rds/connection.c  |   7 ++-
 net/rds/ib_send.c     |  19 ++++++-
 net/rds/message.c     |  66 ++++++++++++++++++-----
 net/rds/rds.h         |  32 +++++++++---
 net/rds/recv.c        |  37 +++++++++++--
 net/rds/send.c        | 118 ++++++++++++++++++++++++++++--------------
 net/rds/stats.c       |   1 +
 net/rds/tcp.c         |   1 +
 net/rds/tcp.h         |   7 ++-
 net/rds/tcp_connect.c |  68 +++++++++++++++++++++++-
 net/rds/tcp_listen.c  |  92 +++++++++++++++++++++++++++++---
 net/rds/tcp_recv.c    |   4 ++
 net/rds/tcp_send.c    |   2 +-
 13 files changed, 378 insertions(+), 76 deletions(-)

-- 
2.43.0


