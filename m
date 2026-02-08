Return-Path: <linux-rdma+bounces-16670-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KyFAhUhiGmrjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16670-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:37:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD4107ED0
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 06:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108BF3013684
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 05:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0622339B49;
	Sun,  8 Feb 2026 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvcSHdwM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14C328626;
	Sun,  8 Feb 2026 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770529038; cv=none; b=CECaS63Uf1by8XVDTIsyS3knWY5mCcpVHr09cJOn/OfoW29u9raRcY8kXV8fDpimfY09eIcuxihymBFBblbKewVy+UpD5jduvU5dEFRcyyiFoc4PPFf2Z0+p/YgTDWIzTLmqbVlVm8K75ahaV0D6hdQG/hHBk3PxEq3wmli19Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770529038; c=relaxed/simple;
	bh=7cVfGu9LCOLtQvXyCDaccpgU3yU80yJpX40S4wXNBMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLAfMiyxFNemvGPTFXLlqeeza0KrWRGZXU3qu7fnrallfw+wEw0TGk+PZI8lobr5NNtnow++HH7Yr7srbDx/X4Ul1IgC/tpSfI8X+c/ViDhg0ql3JWydK3Ifl5biKqGwv2hkrRJtFr5ogHB+ppx0Iyy+aI4RcnaIWy67XcLSh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvcSHdwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B48C4CEF7;
	Sun,  8 Feb 2026 05:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770529038;
	bh=7cVfGu9LCOLtQvXyCDaccpgU3yU80yJpX40S4wXNBMw=;
	h=From:To:Cc:Subject:Date:From;
	b=XvcSHdwMxxVA5Hf+qJUexpGVjugzrdZWC+HYhvN7YI06wrA0SOncQPfaB+D20F/O3
	 CVwwYOLgx4pRVBLO2RcU79UvQ3VlMwJhoptw5l0fShva2+we2vUUri8m/AnvROH0w+
	 dJj+IXKZxW3o1D1J7v3KRrjXy6twlX+BxxuxIka0MYK8gE4KdEiZXmm6hXzpXBqKOn
	 aItGYtY9J2zDcDEIADOdbgNzinkUfe3ndHX4ZO9rADiUXOhjn+oKXBDvGen+felAqJ
	 DJjxLyrl+blcu3uMbOrtwr2k8CIi+9HEg7A9wfrIwUrIkb+BsGlUffHE4yFfxNdPD1
	 S7Ygjj/j7sVeA==
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
Subject: [PATCH net-next v2 0/4] net/rds: RDS-TCP reconnect and fanout improvements
Date: Sat,  7 Feb 2026 22:37:12 -0700
Message-ID: <20260208053716.1617809-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16670-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7BD4107ED0
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

Allison Henderson (2):
  net/rds: Refactor __rds_conn_create for blocking transport cleanup
  net/rds: rds_sendmsg should not discard payload_len

Gerd Rausch (1):
  net/rds: Delegate fan-out to a background worker

Greg Jumper (1):
  net/rds: Use proper peer port number even when not connected

 net/rds/connection.c  | 32 ++++++++++++----------
 net/rds/send.c        |  6 +++--
 net/rds/tcp.c         |  3 +++
 net/rds/tcp.h         |  7 ++---
 net/rds/tcp_connect.c |  2 ++
 net/rds/tcp_listen.c  | 63 ++++++++++++++++++++++++++++++++-----------
 6 files changed, 76 insertions(+), 37 deletions(-)

-- 
2.43.0


