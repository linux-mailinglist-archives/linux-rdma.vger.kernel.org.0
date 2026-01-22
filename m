Return-Path: <linux-rdma+bounces-15876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M4mNhu7cWkNLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 06:52:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F562117
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 06:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9305D442A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61734DB66;
	Thu, 22 Jan 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrinEVp6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CB31E106;
	Thu, 22 Jan 2026 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061135; cv=none; b=RMXrrOF1IzxKTnxCYmIhMPaBwd/l9UfbaNgANz32mnWhXHK0qh3t5bNw8oM6MRNwfUq4Vj2YuplUI469voxlsbkm3EgDDLntZIhf8B84O+jORx0OpJ1xkQ5iiICPpgWoPg1xHHzVpgADwOkY4lkBIYZ6HAvwXDgs0gnEspnHfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061135; c=relaxed/simple;
	bh=dUd40H27/QRNpRisociEKfE85EtG7argiVmsNDA0cx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQN+ksG15bsaIvt68n8VH/QrvsOT9XWs+dVjd/apbLuJCsMlwTah0KvzQ4q85OWBGStr2xPTAsjY0T1hCYUKaiPpjLY02+W0eKLUtFJVGpkwKOeR96JWYKO4+jyRRBXQWQOOh6yf+/k86uklhp9D1PyJdZt6D+IVo5yv9qOSBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrinEVp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995F5C116C6;
	Thu, 22 Jan 2026 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061135;
	bh=dUd40H27/QRNpRisociEKfE85EtG7argiVmsNDA0cx8=;
	h=From:To:Cc:Subject:Date:From;
	b=nrinEVp6R63Y3rK1m7zjPgkCOU4hgtzSUNuRMX+fqxD2MxfM78otFrDAuxPsWqoz7
	 Csnk1XA6e+EotacUiUKKlIrukbQflQTWq5wdZU9Wn14QMUVFskwtK7kF/29juPAbcD
	 m+hElcHeaxvgKJqzq0dhQz8c8gev0t9+h+f8lmGQ3IxkIQnZ6zjffvlxGQ46JucjZt
	 UcY2vsjKY3NYn2QYWuhpdtc0QHZAmaJga3KeX2YhJ5hVUM7AHs9aevjR4y6i0R2iin
	 0YEZpWmLQjgck1XOOBmfmA2MtK+gR5QdH1Liqbn4QgZJ3miNR9cY128LEgcVjIIuCh
	 zV/R7erWb+72Q==
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
Subject: [PATCH net-next v2 0/2] net/rds: RDS-TCP state machine and message loss improvements
Date: Wed, 21 Jan 2026 22:52:11 -0700
Message-ID: <20260122055213.83608-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15876-lists,linux-rdma=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: A61F562117
X-Rspamd-Action: no action

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This is subset 2 of the larger RDS-TCP patch series I posted last
Oct.  The greater series aims to correct multiple rds-tcp issues that
can cause dropped or out of sequence messages.  I've broken it down into
smaller sets to make reviews more manageable.

In this set, we correct a few RDS/TCP connection handling issues, and
message loss issues.

The entire set can be viewed in the rfc here:
https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/

Questions, comments, flames appreciated!
Thanks!
Allison

Change Log:
v2
  [PATCH v1 1/3] net/rds: Change return code from rds_send_xmit() when lock is taken
  - Dropped for further investigation of possible races

  [PATCH v2 1/2] net/rds: No shortcut out of RDS_CONN_ERROR
  - Removed Fixes tag

  [PATCH v2 2/2] net/rds: rds_tcp_accept_one ought to not discard messages 
  - Fixed netdev/checkpatch warnings

Gerd Rausch (2):
  net/rds: No shortcut out of RDS_CONN_ERROR
  net/rds: rds_tcp_accept_one ought to not discard messages

 net/rds/connection.c |   5 ++
 net/rds/rds.h        |  66 +++++++++++++---------
 net/rds/recv.c       |   4 ++
 net/rds/tcp.c        |  27 ++++-----
 net/rds/tcp.h        |  22 +++++++-
 net/rds/tcp_listen.c | 128 +++++++++++++++++++++++++++++++------------
 6 files changed, 171 insertions(+), 81 deletions(-)

-- 
2.43.0


