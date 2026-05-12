Return-Path: <linux-rdma+bounces-20518-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFlTFb+AA2pB6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20518-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24A528AB4
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278E73041A31
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C3357D06;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIZPbpWa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C635979;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614455; cv=none; b=KnzVsO93fQS3Koz3Z+3UuD8LBrmOXa+FsczlbbjM9jKUjkVlTDGrtcPMgY8qqYwZ4/1oz322kMRTOHN3gnYVgf4yyaEku9wCfIgE8JsuTjehCmWUuDwzfRCcnKDHv/WJRP9Z621OR3PoI3d6yAeuTtu3424aPPjGqo5NiuyF9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614455; c=relaxed/simple;
	bh=2jqFxb+r9G9qQBI8MV2AR2FsQdB41PWdBe6RvNU3lsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqQjc+4Jwhco3Ie4R4HNb1dVI8dI+Z8Oom6sfFEnxqz4JE7mlTHWl3lzPOq+U02d/SpX4fdDZKcompDD2oFfy84RxBPtzLfNCOzg4obG+4U6uuhsFcAZIcMlTyTYLxYCgosthhHrDnxoLx0UVr2L2TTGVpUjzWE6lc7L3nz1mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIZPbpWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5ADC2BCB0;
	Tue, 12 May 2026 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614454;
	bh=2jqFxb+r9G9qQBI8MV2AR2FsQdB41PWdBe6RvNU3lsA=;
	h=From:To:Cc:Subject:Date:From;
	b=fIZPbpWa5H11qjXWleK/NU1fS00u0jMkKlVvvizhyt8oSYqxm+fwmL6y3/XUqgbss
	 VkqHuEUocCdbbMaihGyyDKV9KQLot8Ax+R7N5gL8YxIlQORJWj2UnRqhtmPxma2aYe
	 jkdpUgPhaOyrAZF8iWPTq6eqsOuqGM75ll4EVkiXoR6sCZGdD+4cevNQz461s2Z9gN
	 mqDLFBOMWY1QemB8Zq90sEXVRCVcfK9QjEoi3ShTR9EeBnd+WvFjToECebjmrLI/2A
	 tM8icgsajU1Xt7BBN902X0Oyknc92kyo8t78ZlrZraHeOwXCG9ifezhvgj1CEEy4b5
	 Gz2anS5q1ZQCw==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next v2 0/4] Allow rdma dev netns to take a pid
Date: Tue, 12 May 2026 13:34:03 -0600
Message-ID: <20260512193412.32019-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC24A528AB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20518-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Avoid the extra hurdle of creating an entry in /var/run/netns
and allow the netns argument to be a name or a pid.

v2
- update netns_get_fd to handle the pid fallback
- update devlink code

David Ahern (4):
  namespace: Add fallback to netns by pid
  iplink: Drop pid fallback code for netns
  rdma: Allow netns to be specified by pid
  devlink: Drop now duplicate pid fallback for netns

 devlink/devlink.c   | 25 +++++++------------------
 ip/iplink.c         | 10 +---------
 lib/namespace.c     | 28 +++++++++++++++++++++-------
 man/man8/rdma-dev.8 |  3 ++-
 rdma/dev.c          | 11 ++++-------
 5 files changed, 35 insertions(+), 42 deletions(-)

-- 
2.43.0


