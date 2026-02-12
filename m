Return-Path: <linux-rdma+bounces-16771-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IGlK/hljWlI2AAAu9opvQ
	(envelope-from <linux-rdma+bounces-16771-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:32:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32112A715
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD5F230EAAE3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 05:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E3285418;
	Thu, 12 Feb 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKC1oEwr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724291DED5C;
	Thu, 12 Feb 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874352; cv=none; b=iiiOaIko/4qtxCj4y6zfD57Lx2oxKy63CoZ9LI4lx2Ri4Y17THKeElUr3UgYj4+RxLLAkCkUT58ezCJSOIujdXUU6kByZgJNBTdx54w4DwfIzw+/woYrXT0FenMERgXsCtmBuCCs1G1uL76OL8vheTeO+3aCFqH5Wdcv/EALclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874352; c=relaxed/simple;
	bh=7OW1iVB22WsozCPADEcH4TziocsYEuUiqVvH0xvXz9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeiVJML8KCpSTCfMDgafxg5ekyFopSy2PT8L79AW7hEg1a1x/WzFfs5TNcm1TE7HTg1+VUb5m5mIqr6As0vKL/dXrHaK+muRbWLWqPN6rZwQ7JP7lx+EIrmKXQ13lkb5cbXnAcKpzXjmLPJiH8XBdTR85efSd+OncXt0P7rFAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKC1oEwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BFAC4CEF7;
	Thu, 12 Feb 2026 05:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770874352;
	bh=7OW1iVB22WsozCPADEcH4TziocsYEuUiqVvH0xvXz9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=oKC1oEwrwURXuDZnVdPceZiIDTOrU6Hz1u8uiFTulBf1WeyqN+w9qUCvjS8FTB68F
	 LxwVDwMhU9nJqYSp11gk18SLMrLOUWQAXQRAWDqLZATeqXZXY1vC1OQLll08SV6JDP
	 v58Xt7RVYpiblRY+S3m7kx98spjDjOFMedLA9aiK9joNKBpqXk1XeYLpcVS4oBmak6
	 gzH6xfeKw9e7rjmqxt1j23AhsGHF1cRc4Rw1PB8uaEOqlBEWOCYmfp92X0cY2v0rCu
	 pIzCu0IWWvB48Xl2S8DMg6obIVamg8VNeB1l2bES2uYXaDQX9Z1nRgLy/WlV/Xh9cv
	 oCqHT9EEgoMFA==
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
Subject: [PATCH net-next v4 0/4] net/rds: RDS-TCP reconnect and fanout improvements
Date: Wed, 11 Feb 2026 22:32:26 -0700
Message-ID: <20260212053230.1921241-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16771-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A32112A715
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


