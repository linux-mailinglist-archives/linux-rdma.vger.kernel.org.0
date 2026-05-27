Return-Path: <linux-rdma+bounces-21335-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAoPOTlYFmo9lgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21335-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 04:34:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCF5DE959
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 04:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA70730137A3
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BE363C73;
	Wed, 27 May 2026 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzSzZxVd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34162DFA25;
	Wed, 27 May 2026 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849265; cv=none; b=APS/pTUfZpamzFis0gq3GexiNL9ltZ1KeAjldmAeEqHe94Ot+/cxsLcnIfzC+NCaiXK25ltC59AOsKuq6HwdvnS5KStcXlV4V8UeEwhRSzmgeXmDX2WMPIcvRR5ba/P1tngkK2G2I9raNYe4Zd5GDr/zdQuk4aFtwLB+rIkA9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849265; c=relaxed/simple;
	bh=mTXzHo9IhRsoIGL7Rhzno3JrOsQRwe8W9h77DZeG2hU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LhPGaY4kCUu4FBPXHs8Glkj+AiGBTj+XJGhtxnc5Ev1fgPs+EU6Cjb9HFTQxqs0kbBpNRJKptoMSC5H9EWV2PPgbr8xY7D/qi1N+8dHxQ9JRsrIsGBE9I20NTm5igGylrhpPmcoTdaqxEX356+RXBaIecEdKO63BJ3dZxrNXZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzSzZxVd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDC1F000E9;
	Wed, 27 May 2026 02:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849264;
	bh=P24sS9sSMp4+ojJAWQ+i+YOvllL4qXcWUbK74vyaWAw=;
	h=From:To:Subject:Date;
	b=OzSzZxVd0OvHMa9KHmrhplz9U2xaKL1O5Jiyr/6CsIHXsKhFK37khf/TXUfET/mbM
	 SLqhlO+2cilZGbQ7To1npfHKHZ/cCC/2Y1B3a3v0gNUqueK5RnGMDTYeMMjZiJxh/O
	 ptiIEDmNoqd7TYpN3LG7H7XWi4SgcBW3jHKO22MHgIgos8Rj5hzG3Trm3HdNO9HqMW
	 AzFeTKmsCLXgV9SpxZebz2T5lRax4ZgpZAO8sHOhQQ9GAIdIznrfVk/F0l4BYzxZrO
	 f7v7xWZPvtCrKOzTE6YQa92XT3D1xDgVJQqPS0t5AA/xuef2oTbjNf03P8+zD6z+3Y
	 2tP46bWtD2BLQ==
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
Subject: [PATCH net-next v2 0/4] selftests: rds: ROCE support follow ups
Date: Tue, 26 May 2026 19:34:19 -0700
Message-Id: <20260527023423.387792-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21335-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48CCF5DE959
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
any component set as such.

The fourth patch converts the rdma-prerequisite checks to return XFAIL
rather than SKIP, since the RDMA datapath is not run in netdev CI.

Questions, comments and feedback appreciated!

Thanks everyone!
Allison

Change log:
v2:
   [PATCH net-next v1 1/3] selftests: rds: add per-transport run wrappers
   - Renamed to "selftests: rds: Rename run.sh to rds_run.sh"
   - Removed rds_*_run.sh wrappers

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
 tools/testing/selftests/net/rds/README.txt    |  8 +--
 tools/testing/selftests/net/rds/config        |  1 -
 .../selftests/net/rds/{run.sh => rds_run.sh}  | 72 ++++++++++++-------
 tools/testing/selftests/net/rds/test.py       | 18 +++++
 5 files changed, 69 insertions(+), 32 deletions(-)
 rename tools/testing/selftests/net/rds/{run.sh => rds_run.sh} (78%)

-- 
2.25.1


