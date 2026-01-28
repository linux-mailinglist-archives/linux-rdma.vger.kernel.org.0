Return-Path: <linux-rdma+bounces-16102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P7EEdZieWlhwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:13:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F629BD41
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64FAE3015455
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF5221F06;
	Wed, 28 Jan 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swIf+02C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E382AF1B;
	Wed, 28 Jan 2026 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769562833; cv=none; b=HvikrirGXwKpf8b0z7ZtoiNoP9lfvFDJA5QcCIK+hCNAa2mFH75Cntdi8IKnLGspXgtqOt81UqnDZd3elqm7WtuDtiNtjSJPvXL12oIVXt5VH8v7UwLuS3t8J/yn5Xcc2yV+WHSi30LkHuXjKbM/Yst9D8zN7vSa439/mAgKsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769562833; c=relaxed/simple;
	bh=ejj5hCANxMhcNLd5HZbTgLKAnsjd7cBG1IptTztPG8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ctG9o29SIWypBqieJe+PUiHDGA4z4Z8cDZBwF4mBB59/IPios9aBHkZb02MN7mjfoj5zYHvaEx8xW/sxAJ75AaahMs9xslVOhwmUsQyrj8ta5+u03MDSH0NPw805agGg+X+k/Bj1QCOqDELHpLcycYR0tHiu2ZRlZ2iqjtidhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swIf+02C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28905C116C6;
	Wed, 28 Jan 2026 01:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769562832;
	bh=ejj5hCANxMhcNLd5HZbTgLKAnsjd7cBG1IptTztPG8M=;
	h=From:To:Cc:Subject:Date:From;
	b=swIf+02CCqFrZfHbe/amV+c+DH28Sju+9rOEoePmB/uAJJnSOfgnkwrGROjrvgqzW
	 VP+nJSanDKgsVBFU5mQRaqinnB7uUh69TiHcPF430Cua45/25dYbCWvanj9Q2I68gT
	 9Iby9DrOPmRz2LrhV+N2cFOfU0pkD3kOSVZvuekA80a65lWY6WCGQCYmyKgDLOjEtr
	 Wx2XA2cYiHs3AJ8JslI93wcbnD58AZ5jlpRhaJAmwoLAmdPXL5869bI6rQfea7Ioq1
	 fJlPJ86YAVVk2KT8NgV2rKNpbUsEyGKATUTzm9XGQlfIoWmSi7SkkfoTPlKd7L0aEf
	 1U+J7KJs3LuXQ==
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
Subject: [PATCH net-next v2 0/7] net/rds: RDS-TCP protocol and extension improvements
Date: Tue, 27 Jan 2026 18:13:44 -0700
Message-ID: <20260128011351.78511-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16102-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F629BD41
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

Change Log:
v2:
   [PATCH net-next v2 1/7] net/rds: new extension header: rdma bytes
     - Fixed AI complaints for uninitalized structs

   [PATCH net-next v2 2/7] net/rds: Encode cp_index in TCP source port
     - Fixed line length checkpatch complaints

   [PATCH net-next v2 3/7] net/rds: rds_tcp_conn_path_shutdown must not
   discard messages
     - Added sk convenience variable to reduce dereferencing and line
       wrapping
     - Fixed line length checkpatch complaints

   [PATCH net-next v2 6/7] net/rds: Use the first lane until
     - Added rds_mprds_cp0_catchup helper to de-nest rds_send_xmit
     - Fixed line length checkpatch complaints

   [PATCH net-next v2 7/7] net/rds: Trigger rds_send_ping() more than
   once
     - Fixed ai complaints for comment clarification

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
 net/rds/ib_send.c     |  22 ++++++-
 net/rds/message.c     |  66 ++++++++++++++++-----
 net/rds/rds.h         |  32 +++++++++--
 net/rds/recv.c        |  37 ++++++++++--
 net/rds/send.c        | 130 +++++++++++++++++++++++++++++-------------
 net/rds/stats.c       |   1 +
 net/rds/tcp.c         |   1 +
 net/rds/tcp.h         |   7 ++-
 net/rds/tcp_connect.c |  79 +++++++++++++++++++++++--
 net/rds/tcp_listen.c  |  92 +++++++++++++++++++++++++++---
 net/rds/tcp_recv.c    |   4 ++
 net/rds/tcp_send.c    |   2 +-
 13 files changed, 400 insertions(+), 80 deletions(-)

-- 
2.43.0


