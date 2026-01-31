Return-Path: <linux-rdma+bounces-16275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMwaMv1ZfWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C5BFF65
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC0C8301BC3E
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E031ED76;
	Sat, 31 Jan 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+kg73UY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187123A9B3;
	Sat, 31 Jan 2026 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822709; cv=none; b=oDbwWIiph2CA40J95kD8D2PrS81pRH267CnM99tsJ/lFB4PrEhrJ9tYaSH++zwUJw+1DLZBnc9PZcPO6HoILWTmFhFRetuIM6CoQssB5qV+2vy53P2sWKh0Z5r2grLJHUBIN9EZ0kZ8NtueXAQTyAE4P/HssHGXjyXaW4anl3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822709; c=relaxed/simple;
	bh=IUD8h7e9A8FW5M58ciHvDH/ThxPY3iaE48Cr8W6Hwzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KN/1TH+Wg8dJk5n3B+r2Gv/+ePExOKYgayh+Disr5B3QRxHIDUBbSK52V85vTAQUnphM/ljYsb9bTtJdu3PeRnN2AufoDmxA1N3r7YCCyOn3sG9eb+3Cx9hDgN08k9a0UYRn9Y9eQCCw1VG1gQUQxhjgupW67VSNlmt4WjCYMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+kg73UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ECEC4CEF7;
	Sat, 31 Jan 2026 01:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822709;
	bh=IUD8h7e9A8FW5M58ciHvDH/ThxPY3iaE48Cr8W6Hwzs=;
	h=From:To:Cc:Subject:Date:From;
	b=D+kg73UYvaT/Vflx8Z+jMrq67xb5AkN6/mhosj1neTrfJj9iqr+yQ2/JeC6BYM5f2
	 Yqd8r4HuMBmvnNW35EBl75FG4Xo3p5+PkbCGWVCl098CkaHYuNRVCX2ydvfudf2k3t
	 yAsg/4raBatPWWsWgGkK10EKzRh8OWHzzwDp1LcS7CwsWt1YXnNLmqLbygshtOpPId
	 he03fQuLZ8w20hNF5fUfBOpKMG4YNsioy4sEaD7xX1wFgNweguH+bnz8fGM9AZE5RV
	 4FRJxTUe0dbkpzzID+x6QHDH0M38m6+4Uq7eSvtRw0cjong4hGiDlsdd1DDPVLT+PA
	 DVVpS0CLtPKRQ==
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
Subject: [PATCH net-next v4 0/8] net/rds: RDS-TCP protocol and extension improvements
Date: Fri, 30 Jan 2026 18:24:59 -0700
Message-ID: <20260131012507.814119-1-achender@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16275-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 731C5BFF65
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

v3:
  [PATCH net-next v3 1/8] net/rds: new extension header: rdma bytes
    - Addressed ai complaints about unpacked/unpadded rds_ext_header_rdma_bytes
    - Added return code checks to rds_message_add_extension

  [PATCH net-next v3 06/8] net/rds: Update struct rds_statistics to
  use u64 instead of uint64_t
     - NEW

  [PATCH net-next v3 6/8] net/rds: Use the first lane until
    - Fixed Prefer kernel type 'u64' over 'uint64_t' warnings

  [PATCH net-next v3 08/8] net/rds: Trigger rds_send_ping() more than once
    - Addressed ai complaints for comment clarification

v4:
  [PATCH net-next v4 1/8] net/rds: new extension header: rdma bytes
  - Fixed line length checkpatch complaints

  [PATCH net-next v4 2/8] net/rds: Encode cp_index in TCP source port
  - Addressed ai complaints for kernel_getpeername return code handling

Allison Henderson (1):
  net/rds: Update struct rds_statistics to use u64 instead of uint64_t

Gerd Rausch (4):
  net/rds: Encode cp_index in TCP source port
  net/rds: rds_tcp_conn_path_shutdown must not discard messages
  net/rds: Kick-start TCP receiver after accept
  net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives

Håkon Bugge (1):
  net/rds: Clear reconnect pending bit

Original Author (1):
  net/rds: Trigger rds_send_ping() more than once

Shamir Rabinovitch (1):
  net/rds: new extension header: rdma bytes

 net/rds/connection.c  |   7 ++-
 net/rds/ib_send.c     |  40 ++++++++++---
 net/rds/message.c     |  66 ++++++++++++++++-----
 net/rds/rds.h         | 105 ++++++++++++++++++++--------------
 net/rds/recv.c        |  37 ++++++++++--
 net/rds/send.c        | 130 +++++++++++++++++++++++++++++-------------
 net/rds/stats.c       |   1 +
 net/rds/tcp.c         |   1 +
 net/rds/tcp.h         |   7 ++-
 net/rds/tcp_connect.c |  79 +++++++++++++++++++++++--
 net/rds/tcp_listen.c  |  92 +++++++++++++++++++++++++++---
 net/rds/tcp_recv.c    |   4 ++
 net/rds/tcp_send.c    |   2 +-
 13 files changed, 450 insertions(+), 121 deletions(-)

-- 
2.43.0


