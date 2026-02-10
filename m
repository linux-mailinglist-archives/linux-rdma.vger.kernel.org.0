Return-Path: <linux-rdma+bounces-16698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFV9D4z2imn2OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:12:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AA118AC1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0A24301CD85
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BC33F389;
	Tue, 10 Feb 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p01is1n8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B21CEAC2;
	Tue, 10 Feb 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714757; cv=none; b=NxvZva9T3Z7T1rPqPxrm0N2e82kTV3EvBWdiGLN0n6TZz/F0y0OJvQ1G9CVFntFn1FPoy2MLFimQnbZpfVxJ7J0eJKc8SfacpHl0hE1kwyimej9Gt0DMVxDwNdWmdYpjqhKgmxxatHwS+g5CysefHLtJiPwek6cava1kyQgR4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714757; c=relaxed/simple;
	bh=a4kGJg4WbAjnEgn9ulvPgmWFvR8pCZo3tPkDFyWVr3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHUyD1hE+F2U3GX+zk/Qu0kHWRQsmZ0m0eCOxitFM3JEei3obcwJPHumfynuztPtKEUfCX+l78KR3NhFYeCRYKPAS0K9wP9+Pjxocd/tOHVFJDDQVOu3fQt/AvLWhH6UlS6m9Splr3eNiDQv7XsCMuFWgRRJ/xK5H1fGDO8mBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p01is1n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FC9C116C6;
	Tue, 10 Feb 2026 09:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770714757;
	bh=a4kGJg4WbAjnEgn9ulvPgmWFvR8pCZo3tPkDFyWVr3A=;
	h=From:To:Cc:Subject:Date:From;
	b=p01is1n8ih5qrat3ot9M8va2R2rz1Qk7QBzR+hjIrkgseUQpWzClSM8d+RjUhhr+/
	 DJSBzd32r5oc7r0Win2arHKOZGh3ODX6sDzWJT9ioGe8JEt/sls2mouPk7Zzc8hH7s
	 pUjH5ZTCdOhJWiP2ytHwtCmnYb6sotNu7Iw4s3/Mj4f/GGteTa+1qgjlLqWfotJ4GL
	 WaGsxNiup96toXZRuwfPUOBC0xGeJePDPfsGb+fRVpv6aZHNttgvNpeBrwutiU2Q+P
	 eEURDjM9CMPCdDXfKpuDCcSAsfPBLH2k0dE60D700XABuAKMtE2L3hP7VOF31we2Z5
	 iu38iRWjxZF8Q==
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
Subject: [PATCH net-next v3 0/4] net/rds: RDS-TCP reconnect and fanout improvements
Date: Tue, 10 Feb 2026 02:12:31 -0700
Message-ID: <20260210091235.1817860-1-achender@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16698-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,syzbot.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF3AA118AC1
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
     - Deffered to net instead of net-next

Allison Henderson (2):
  net/rds: Fix NULL pointer dereference in rds_tcp_accept_one
  net/rds: Refactor __rds_conn_create for blocking transport cleanup

Gerd Rausch (1):
  net/rds: Delegate fan-out to a background worker

Greg Jumper (1):
  net/rds: Use proper peer port number even when not connected

 net/rds/connection.c  | 32 +++++++++--------
 net/rds/tcp.c         |  3 ++
 net/rds/tcp.h         |  7 ++--
 net/rds/tcp_connect.c |  2 ++
 net/rds/tcp_listen.c  | 80 +++++++++++++++++++++++++++++++++----------
 5 files changed, 86 insertions(+), 38 deletions(-)

-- 
2.43.0


