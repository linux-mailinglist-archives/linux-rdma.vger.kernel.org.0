Return-Path: <linux-rdma+bounces-21610-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOOwOv1kHmrCiwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21610-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:07:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F26816285CB
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B83FA300D7B6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7C2DC789;
	Tue,  2 Jun 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+i3PPEz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9F2BEFEE;
	Tue,  2 Jun 2026 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376820; cv=none; b=hTO34U30HE7pPik+DjYDhFaX2biMrt6oNlYywTnBELc+JgWqLOquE7zjwBqVRrOrV5IWOHsalql/MI+v+faixsaa0IdU2aYudXOsNV2CuOKWzitbAY84ibEE7qdTsKald7GMpLudRCqhJSeZ/HAoSzNPu+j8arntK/SVhpQP/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376820; c=relaxed/simple;
	bh=6phfBdD7Y8i8kIGiUIPre4j3tXYbCRIV02SUxxtO+AA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hcpTl8+vObqOnkcW4g9CzkGCxnRSCMBxZdFpGBoV3H2ozZJS0uAoZLfeutM8QiZYf0YVt9/qnotGmWvB/1AuSBStLUZRgdiZ7Qim2FKzkw/YtfXn4/C5x5Ih1knFv8BeTXVNhZEqcIjY5V4e7+9XigCFF5k3jln/uDM3hqh5S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+i3PPEz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6339F1F00893;
	Tue,  2 Jun 2026 05:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780376819;
	bh=NTcvrD6vnoDOP9BObrF7HGtoiQIc3t/YgVf27KmlOZA=;
	h=From:To:Subject:Date;
	b=c+i3PPEzvpA/np+hyPRIFgyDXzOcMEKYbUfyMBCpePVqa77QOjbNt80NPx5KAUhxh
	 aHKUMeWObfEt+HundEzPmtaqGBvG6CKpGO6z6Qb4wxu/uYr7Yc2jaIJgKCCxyqcGeT
	 f7fJQmdR4YRBpvo1r9fn8arirTkzIHPJfHuYGJb5T6saeS47FUQagMSYETlwgsM7FQ
	 cTaOrxinCvGgW7ARzaK5Ubh3W4IeuiKzyHq6xZYARa1mEDD+IBdBiM4HWCO7bsehgt
	 fDkuaycQEzFVouD8/1kR83ih/fvFPL+cF1KPZiS1Yiwu32VSBbvOXFsh6Hd8wW77OT
	 SVUEiNCHQ0b6w==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v3 0/4] selftests: rds: ROCE support follow ups
Date: Mon,  1 Jun 2026 22:06:53 -0700
Message-Id: <20260602050657.26389-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21610-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,config.sh:url,run.sh:url]
X-Rspamd-Queue-Id: F26816285CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This is a follow up series to the "Add ROCE support to rds selftests"
series.  The first patch renames run.sh to rds_run.sh, which provides
a self-describing name that appears on the netdev CI dashboard.

The second patch addresses a sashiko complaint that I thought was
worth circling back for.  In the patch "pin RDS sockets to their
intended transport," sockets are pinned to the specific transport they
are meant to test.  By default, socket transports are implicitly
selected based on the network topology, but it is possible that they
can fail back to other transports if the underlying connection could
not be established.  So the patch pins them to the intended transport
to avoid false positives.

The third patch "support RDS built as loadable modules," lifts the
CONFIG_MODULES=n requirement, and updates the check_*conf_enabled()
to allow modules set to "=m" and further load the backing modules for
any component set as such.  config.sh is updated to match.

The fourth patch converts the rdma-prerequisite checks to return XFAIL
rather than SKIP, since the RDMA datapath is not run in netdev CI.

Questions, comments and feedback appreciated!

Thanks everyone!
Allison

Change log:
v3:
   [PATCH net-next v2 1/4] selftests: rds: Rename run.sh to rds_run.sh
   - Wrapped USAGE line to fix checkpatch 84-column warning

   [PATCH net-next v2 3/4] selftests: rds: support RDS built as loadable modules
   - Drop --disable CONFIG_MODULES from config.sh

   [PATCH net-next v2 4/4] selftests: rds: report missing RDMA prereqs as XFAIL
   - Corrected XFAIL rc from 5 to 2

v2:
   [PATCH net-next v1 1/3] selftests: rds: add per-transport run wrappers
   - Renamed to "selftests: rds: Rename run.sh to rds_run.sh"
   - Removed rds_*_run.sh wrappers
   - Dropped dangling wrapper paragraph from README

   [PATCH net-next v1 3/3] selftests: rds: support RDS built as loadable modules
   - Fixed long line length warning

   [PATCH net-next v2 4/4] selftests: rds: report missing RDMA prereqs as XFAIL
   - NEW

Allison Henderson (4):
  selftests: rds: Rename run.sh to rds_run.sh
  selftests: rds: pin RDS sockets to their intended transport
  selftests: rds: support RDS built as loadable modules
  selftests: rds: report missing RDMA prereqs as XFAIL

 tools/testing/selftests/net/rds/Makefile      |  2 +-
 tools/testing/selftests/net/rds/README.txt    |  8 +-
 tools/testing/selftests/net/rds/config        |  1 -
 tools/testing/selftests/net/rds/config.sh     |  3 -
 .../selftests/net/rds/{run.sh => rds_run.sh}  | 75 ++++++++++++-------
 tools/testing/selftests/net/rds/test.py       | 18 +++++
 6 files changed, 71 insertions(+), 36 deletions(-)
 rename tools/testing/selftests/net/rds/{run.sh => rds_run.sh} (78%)


base-commit: 1a1f055318d82e64485a6ff8420e5f70b4267998
-- 
2.25.1


