Return-Path: <linux-rdma+bounces-19127-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDrjIiAM1mlnAwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19127-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 10:04:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4593B8B53
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 10:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F647300D9D1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6C39B95F;
	Wed,  8 Apr 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="narVIeIX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A939C012;
	Wed,  8 Apr 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635462; cv=none; b=VdUbURN141phyVpG/s6ydsOxsK0sd3WaOv4BDHaWGDQuxSFFW7FPF8HXVRTi9Ffwuzr1j9WwCH394owzN6UngkI0Gv6EZ8Cx8fzI7G+vIfGpc0hN2/7k11yzK1ycOlDi1Bz/YiG4y9RMG6C3K+iHAn0LBc2TC0dAyma7vwalx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635462; c=relaxed/simple;
	bh=DqQn1QbgGalUlwfTeJD4OKWAxtEs1W9p9GDTr8KZMVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1nngDb1sAhuC8IcD1i3JYyzMHZHeXwsLJQBbr3zGdHGa9yGk2ml6Mp7GVXyMkBNR50l/LDQWx96doav+rMW6YhmoHhtW8A3+Fxawhif9IpxxhGUZ63MdRYzLidWz5tO5i86vJwpAx3sROFL7j3Jec/N4k3x9Kq/lLilVVVKiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=narVIeIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D8C19425;
	Wed,  8 Apr 2026 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635462;
	bh=DqQn1QbgGalUlwfTeJD4OKWAxtEs1W9p9GDTr8KZMVM=;
	h=From:To:Cc:Subject:Date:From;
	b=narVIeIXKDPpGhVFsMJL2UNaDtJtuS2xIqCsnCPcuY+mppY4gZr90qH7Ysz3xOG6d
	 xnce22VtIkHmQJeMcrkEa4vA/OZ3My42InPcoHhXXZXZYr/njEYMkgFbNi83XKf+Jk
	 gMgDvf/QVH4wCQIKjhguD3spcuDRalIJP8tLY+sXP3k6YC3TfrJHQSG/I/selDugP8
	 VI3eV5njIpVKGWRs9oI9lpIORwIZZYrsBWou70OzaevykKzm+iNndkc/GGizpjLwLt
	 J3OTd3N8IJVu24kkRCUtq10BKwjS5ya4x4cNxscBgA+doWCtiPTmT7M1dLrl4WVpM7
	 I0Qbx++IOW57w==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org
Subject: [PATCH net v2 0/2] net/rds: Fix use-after-free in RDS/IB for non-init namespaces
Date: Wed,  8 Apr 2026 01:04:18 -0700
Message-ID: <20260408080420.540032-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19127-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[syzkaller.appspot.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[syzkaller.appspot.com:query timed out];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E4593B8B53
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

Change Log:
v2:
   [PATCH net v2 1/2] net/rds: Optimize rds_ib_laddr_check
        - Added missing author sob
        - Added ipv6_addr_v4mapped check

   [PATCH net v2 2/2] net/rds: Restrict use of RDS/IB to the initial
        - Addressed comment consistency nits
        - Addressed commit message nits

Greg Jumper (1):
  net/rds: Restrict use of RDS/IB to the initial network namespace

Håkon Bugge (1):
  net/rds: Optimize rds_ib_laddr_check

 net/rds/af_rds.c  | 10 ++++++++--
 net/rds/ib.c      | 24 ++++++++++++++++++++++--
 net/rds/ib.h      |  1 +
 net/rds/ib_rdma.c |  2 +-
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.43.0


