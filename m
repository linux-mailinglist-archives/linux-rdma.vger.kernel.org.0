Return-Path: <linux-rdma+bounces-18986-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGj3DRbi0Wm8PwcAu9opvQ
	(envelope-from <linux-rdma+bounces-18986-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624139D486
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 06:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8302D300C90C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB11D798E;
	Sun,  5 Apr 2026 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIR26xj1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667454726;
	Sun,  5 Apr 2026 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775362574; cv=none; b=LRgsLr8rblsF+3ggZDPNEWhf1dusgqE7GesVnZ9kr77wYca7ZSHfU0wU/QJBk8qCnlMRic0KvhUso6X9nm+RoTldLFeM3oepHFlPXKmfNdJt7BmIsQdflN/deoDT3KIOQg2HGC1lpQhpGewJsZCzA0ZvO4zDx9F4r/jlEOBWNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775362574; c=relaxed/simple;
	bh=3x27M9yg/TErPyCGNhXZlvzZcXchlXEBtlxieSz9rdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/pumfJmrwgz4gK5OYobhIa9E1c/vfnh7BvY8MreqsdSvwyZbK7HP+AIxzGtqek78mCmWSztBc/JWv72UN3Z1q6VNcB4N3PfMvF5Pyj95yKKGeght8oRG3Re6lb8zmGAHjnk2tUu0koxBC9bzoDDxLRNObsacXea8Azg3/ZzHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIR26xj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4759C116C6;
	Sun,  5 Apr 2026 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775362574;
	bh=3x27M9yg/TErPyCGNhXZlvzZcXchlXEBtlxieSz9rdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KIR26xj14CXYWOtWGlq5lzrkHqINCp2dMDnLQyKuQcE4Glhj6QmOAwQJ/TKVywSRo
	 388fZQkfeoHbLymmbVVpIhiKGNs49VFvOmNSF3WhnVpoGdPVnS4KAmdjOAkch6Fz32
	 DgqolB7xo4mbTFKXuRwTTpwOdBavWiIl6hYkeHJk/6ksq+10pfGI1D9ZKTtRH4EAHE
	 3P/GXmBa4LO84arB55qJ4gd3oru0bRsc1BySmZnmShUvvBJj7vlNmEzqlAvnUY70Vn
	 Tp/BoTeW+3BkaQVIho0d0O269kN/ZRIKJ3d0Mt9N2dp9CYcADnT91iXgCx5ZJLxwS5
	 H9/YFL30+CIZw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v1 0/2] net/rds: Fix use-after-free in RDS/IB for non-init namespaces
Date: Sat,  4 Apr 2026 21:16:11 -0700
Message-ID: <20260405041613.309958-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18986-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 8624139D486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes syzbot bug da8e060735ae02c8f3d1
https://syzkaller.appspot.com/bug?extid=da8e060735ae02c8f3d1

The report finds a use-after-free bug where ib connections access an
invalid network namespace after it has been freed.  The stack is:

    rds_rdma_cm_event_handler_cmn
      rds_conn_path_drop
        rds_destroy_pending
          check_net()  <-- use-after-free

This is initially introduced in:
d5a8ac28a7ff ("RDS-TCP: Make RDS-TCP work correctly when it is set up
in a netns other than init_net").

Here, we made RDS aware of the namespace by storing a net pointer in
each connection.  But it is not explicitly restricted to init_net in
the case of ib. The RDS/TCP transport has its own pernet exit handler
(rds_tcp_exit_net) that destroys connections when a namespace is torn
down. But RDS/IB does not support more than the initial namespace and
has no such handler. The initial namespace is statically allocated,
and never torn down, so it always has at least one reference.

Allowing non init namespaces that do not have a persistent reference
means that when their refcounts drop to zero, they are released through
cleanup_net(). Which would call any registered pernet clean up handlers
if it had any, but since they don't in this case, the extra
rds_connections remain with stale c_net pointers.  Which are then
accessed later causing the use-after-free bug.

So, the simple fix is to disallow more than the initial namespace
to be created in the case of ib connections.

Fixes are ported from UEK patches found here:

  https://github.com/oracle/linux-uek/commit/8ed9a82376b7
  Patch 1 is a prerequisite optimization to rds_ib_laddr_check() that
  avoids excessive rdma_bind_addr() calls during transport probing by
  first checking rds_ib_get_device().  This is needed because patch 2
  adds a namespace check at the top of the same function.

    UEK: 8ed9a82376b7 ("rds: ib: Optimize rds_ib_laddr_check")

  https://github.com/oracle/linux-uek/commit/bd9489a08004
  Patch 2 restricts RDS/IB to the initial network namespace.  It adds
  checks in both rds_ib_laddr_check() and rds_set_transport() to reject
  IB use from non-init namespaces with -EPROTOTYPE.  This prevents the
  use-after-free by ensuring IB connections cannot exist in namespaces
  that may be torn down.

    UEK: bd9489a08004 ("net/rds: Restrict use of RDS/IB to the initial
    network namespace")

Questions, comments and feedback appreciated!

Thank you!
Allison

Greg Jumper (1):
  net/rds: Restrict use of RDS/IB to the initial network namespace

Håkon Bugge (1):
  net/rds: Optimize rds_ib_laddr_check

 net/rds/af_rds.c  | 10 ++++++++--
 net/rds/ib.c      | 23 +++++++++++++++++++++--
 net/rds/ib.h      |  1 +
 net/rds/ib_rdma.c |  2 +-
 4 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.43.0


